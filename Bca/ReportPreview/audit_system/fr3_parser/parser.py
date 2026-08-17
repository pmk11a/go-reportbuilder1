"""
FR3 Parser Module
=================
Deep parser for FastReport (.fr3) XML files.

Supports FastReport versions: 3.18, 4.x, 5.x, 6.x
Extracts: structure, datasets, memos, script, layout, metadata
"""
from __future__ import annotations
import os
import re
import hashlib
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field, asdict
from xml.etree import ElementTree as ET


# ---------------------------------------------------------------------------
# Data Models
# ---------------------------------------------------------------------------
@dataclass
class FR3Dataset:
    name: str
    fields: List[str] = field(default_factory=list)
    reference: str = ""
    raw_props: str = ""

@dataclass
class FR3Memo:
    name: str
    text: str
    dataset: str = ""
    datafield: str = ""
    expression: str = ""
    align: str = "left"
    fmt: str = ""
    font: str = ""
    font_size: float = 0.0
    left: float = 0.0
    top: float = 0.0
    width: float = 0.0
    height: float = 0.0
    parent: str = ""
    visible: bool = True

@dataclass
class FR3Page:
    name: str
    paper_width: float = 210.0
    paper_height: float = 297.0
    orientation: str = "portrait"
    margins: Dict[str, float] = field(default_factory=dict)
    bands: List[str] = field(default_factory=list)

@dataclass
class FR3Script:
    language: str = "PascalScript"
    text: str = ""
    variables: List[str] = field(default_factory=list)
    procedures: List[str] = field(default_factory=list)

@dataclass
class FR3Report:
    """Parsed representation of one .fr3 file."""
    file_path: str
    file_size: int
    sha256: str
    version: str
    report_name: str
    pages: List[FR3Page] = field(default_factory=list)
    datasets: List[FR3Dataset] = field(default_factory=list)
    memos: List[FR3Memo] = field(default_factory=list)
    script: Optional[FR3Script] = None
    create_date: str = ""
    last_change: str = ""
    description: str = ""
    is_valid_xml: bool = False
    xml_errors: List[str] = field(default_factory=list)
    raw_size: int = 0
    raw_bytes: int = 0
    has_zero_byte_tail: bool = False
    extra_bytes_after_root: int = 0
    parse_warnings: List[str] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _safe_float(s: Optional[str], default: float = 0.0) -> float:
    if s is None:
        return default
    try:
        return float(s.replace(",", "."))
    except Exception:
        return default

def _attr(elem: ET.Element, name: str, default: str = "") -> str:
    return elem.get(name) or elem.get(name.lower()) or default

def _extract_field_references(text: str) -> List[str]:
    """Extract field references inside [..] braces in memo text."""
    if not text:
        return []
    # FastReport uses [frxDBDataset."field"] and similar
    pattern = re.compile(r'\[([^\]]+)\]')
    return pattern.findall(text)

def _parse_propdata(propdata: str) -> Dict[str, str]:
    """Parse PropData hex-encoded blob for declared datasets/variables."""
    out: Dict[str, str] = {}
    try:
        blob = bytes.fromhex(propdata)
        text = blob.decode("latin-1", errors="ignore")
        # Datasets are stored like 'DataSet="frxDBDataset1" DataSetName="..."'
        for m in re.finditer(r'(\w+)="([^"]*)"', text):
            out[m.group(1)] = m.group(2)
    except Exception:
        pass
    return out


# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------
class FR3Parser:
    """Parses a .fr3 file into a FR3Report object."""

    SUPPORTED_VERSIONS = ["3.18", "4.", "5.", "6.", "7."]

    def __init__(self, file_path: str):
        self.file_path = file_path
        self.report = FR3Report(
            file_path=file_path,
            file_size=0,
            sha256="",
            version="",
            report_name=""
        )

    # -- file IO -----------------------------------------------------------
    def _read_file(self) -> bytes:
        with open(self.file_path, "rb") as fh:
            data = fh.read()
        return data

    def _detect_zero_byte_tail(self, data: bytes) -> Tuple[bool, int]:
        """Detect zero-padded or trailing junk after </TfrxReport>."""
        # Strip BOM if any
        if data.startswith(b"\xef\xbb\xbf"):
            data = data[3:]
        text = data.decode("utf-8", errors="ignore")
        end_tag = "</TfrxReport>"
        idx = text.rfind(end_tag)
        if idx == -1:
            return False, 0
        tail = data[idx + len(end_tag):]
        # Trim leading whitespace
        stripped = tail.lstrip(b" \r\n\t")
        if not stripped:
            return False, 0
        # Count zero bytes or non-xml trailing junk
        zero_count = stripped.count(b"\x00")
        if zero_count > 0 or len(stripped) > 0:
            return True, len(stripped)
        return False, 0

    # -- main entry ---------------------------------------------------------
    def parse(self) -> FR3Report:
        data = self._read_file()
        self.report.raw_bytes = len(data)
        self.report.sha256 = hashlib.sha256(data).hexdigest()

        # zero byte tail detection
        has_tail, extra = self._detect_zero_byte_tail(data)
        self.report.has_zero_byte_tail = has_tail
        self.report.extra_bytes_after_root = extra

        # xml parse
        try:
            root = ET.fromstring(data)
            self.report.is_valid_xml = True
        except ET.ParseError as e:
            self.report.is_valid_xml = False
            self.report.xml_errors.append(str(e))
            return self.report

        # root element must be TfrxReport
        if root.tag != "TfrxReport":
            self.report.parse_warnings.append(
                f"Root element is '{root.tag}', expected 'TfrxReport'"
            )

        # version + name
        self.report.version = _attr(root, "Version", "unknown")
        self.report.report_name = _attr(root, "Name", "")
        self.report.create_date = _attr(root, "ReportOptions.CreateDate", "")
        self.report.last_change = _attr(root, "ReportOptions.LastChange", "")
        self.report.description = _attr(root, "ReportOptions.Description.Text", "")

        # script
        script_text = _attr(root, "ScriptText.Text", "")
        if script_text:
            # Decode XML entities
            script_text = (script_text
                           .replace("&#13;&#10;", "\n")
                           .replace("&#10;", "\n")
                           .replace("&#9;", "\t")
                           .replace("&lt;", "<")
                           .replace("&gt;", ">")
                           .replace("&amp;", "&")
                           .replace("&quot;", "\""))
            self.report.script = FR3Script(
                language=_attr(root, "ScriptLanguage", "PascalScript"),
                text=script_text,
                variables=re.findall(r'\bvar\s+([\w,\s:;]+)', script_text),
                procedures=re.findall(r'procedure\s+(\w+)', script_text),
            )

        # PropData for declared datasets (encoded)
        propdata = _attr(root, "PropData", "")
        declared_props = _parse_propdata(propdata) if propdata else {}

        # walk children
        datasets_seen: Dict[str, FR3Dataset] = {}
        pages_seen: List[FR3Page] = []

        for child in root.iter():
            tag = child.tag

            # Pages
            if tag == "TfrxReportPage":
                page = FR3Page(
                    name=_attr(child, "Name", "Page"),
                    paper_width=_safe_float(_attr(child, "PaperWidth"), 210.0),
                    paper_height=_safe_float(_attr(child, "PaperHeight"), 297.0),
                    margins={
                        "left": _safe_float(_attr(child, "LeftMargin"), 10.0),
                        "right": _safe_float(_attr(child, "RightMargin"), 10.0),
                        "top": _safe_float(_attr(child, "TopMargin"), 10.0),
                        "bottom": _safe_float(_attr(child, "BottomMargin"), 10.0),
                    }
                )
                # gather band names
                for grandchild in child:
                    if grandchild.tag.startswith("Tfrx") and grandchild.tag.endswith(("Header", "Footer", "MasterData", "DetailData", "GroupHeader", "GroupFooter")):
                        page.bands.append(_attr(grandchild, "Name", grandchild.tag))
                pages_seen.append(page)

            # Datasets
            elif tag == "TfrxDataPage" or tag.endswith("DBDataset"):
                # detect fields via DataSet/DataSetName on children
                ds_name = _attr(child, "Name", "")
                if ds_name and ds_name not in datasets_seen:
                    datasets_seen[ds_name] = FR3Dataset(
                        name=ds_name,
                        reference=_attr(child, "DataSet", "") + "|" + _attr(child, "DataSetName", "")
                    )

            # Memos
            elif tag == "TfrxMemoView" or tag == "TfrxSysMemoView":
                memo = FR3Memo(
                    name=_attr(child, "Name", ""),
                    text=_attr(child, "Text", ""),
                    dataset=_attr(child, "DataSet", "") or _attr(child, "DataSetName", ""),
                    datafield=_attr(child, "DataField", ""),
                    align=_attr(child, "HAlign", "left"),
                    fmt=_attr(child, "DisplayFormat.FormatStr", ""),
                    font=_attr(child, "Font.Name", ""),
                    font_size=_safe_float(_attr(child, "Font.Height"), 0.0),
                    left=_safe_float(_attr(child, "Left"), 0.0),
                    top=_safe_float(_attr(child, "Top"), 0.0),
                    width=_safe_float(_attr(child, "Width"), 0.0),
                    height=_safe_float(_attr(child, "Height"), 0.0),
                    parent=_attr(child, "Parent", "") or "Page1",
                    visible=(_attr(child, "Visible", "1") != "0"),
                )
                self.report.memos.append(memo)
                if memo.dataset:
                    ds_ref = memo.dataset.split(".")[0]
                    if ds_ref and ds_ref not in datasets_seen:
                        datasets_seen[ds_ref] = FR3Dataset(name=ds_ref, reference=memo.dataset)

        # gather fields referenced in memo expressions
        for memo in self.report.memos:
            for ref in _extract_field_references(memo.text):
                # ref like 'frxDBDataset2."debet"' or 'SUM(...)'
                m = re.match(r'(\w+)\."(\w+)"', ref)
                if m:
                    ds, fld = m.group(1), m.group(2)
                    if ds in datasets_seen:
                        if fld not in datasets_seen[ds].fields:
                            datasets_seen[ds].fields.append(fld)

        self.report.datasets = list(datasets_seen.values())
        self.report.pages = pages_seen
        self.report.file_size = self.report.raw_bytes
        return self.report

    def to_dict(self) -> Dict[str, Any]:
        """Serialize to plain dict (recursively)."""
        return asdict(self.report)


# ---------------------------------------------------------------------------
# Batch scan helper
# ---------------------------------------------------------------------------
def scan_directory(root: str, pattern: str = "*.fr3",
                  recursive: bool = True, limit: Optional[int] = None
                  ) -> List[FR3Report]:
    """Parse every .fr3 under root and return list of FR3Report objects."""
    root_path = Path(root)
    if recursive:
        files = list(root_path.rglob(pattern))
    else:
        files = list(root_path.glob(pattern))

    out: List[FR3Report] = []
    for i, f in enumerate(files):
        if limit and i >= limit:
            break
        try:
            parser = FR3Parser(str(f))
            report = parser.parse()
            out.append(report)
        except Exception as exc:  # pragma: no cover
            print(f"[scan] error on {f}: {exc}")
    return out


if __name__ == "__main__":
    import sys, json
    target = sys.argv[1] if len(sys.argv) > 1 else "d:/TestLaB/piagent/Bca/ReportFiles"
    recursive = "--no-rec" not in sys.argv
    limit = int(sys.argv[sys.argv.index("--limit") + 1]) if "--limit" in sys.argv else None
    reports = scan_directory(target, recursive=recursive, limit=limit)
    print(json.dumps({
        "scanned": len(reports),
        "valid_xml": sum(1 for r in reports if r.is_valid_xml),
        "zero_byte_tail": sum(1 for r in reports if r.has_zero_byte_tail),
        "total_datasets": sum(len(r.datasets) for r in reports),
        "total_memos": sum(len(r.memos) for r in reports),
    }, indent=2))