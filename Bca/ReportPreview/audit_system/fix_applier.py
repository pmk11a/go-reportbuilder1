"""
Real fix applier — applies FR3Fix objects to the actual .fr3 XML file.
"""
from __future__ import annotations
import re
import shutil
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional

from fr3_parser import FR3Report, FR3FixGenerator
from fr3_parser.fix_generator import Fix as FR3Fix


@dataclass
class ApplyResult:
    file_path: str
    success: bool
    applied_count: int = 0
    failed_count: int = 0
    backup_path: Optional[str] = None
    error: Optional[str] = None
    elapsed_sec: float = 0.0
    applied_fixes: List[Dict] = field(default_factory=list)


class RealFixApplier:
    """Applies fixes to .fr3 files on disk with backup."""

    def __init__(self, backup_dir: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/backups",
                 min_confidence: float = 0.85):
        self.backup_dir = Path(backup_dir)
        self.backup_dir.mkdir(parents=True, exist_ok=True)
        self.min_confidence = min_confidence

    def apply_fix(self, report: FR3Report, fix: FR3Fix, file_bytes: bytes,
                  backup: bool = True) -> ApplyResult:
        """Apply a single fix to the file bytes."""
        import time
        t0 = time.time()
        result = ApplyResult(file_path=report.file_path, success=False)
        if fix.confidence < self.min_confidence:
            result.error = f"confidence {fix.confidence:.2f} < threshold {self.min_confidence}"
            return result

        try:
            if backup:
                bk = self.backup_dir / f"{Path(report.file_path).name}.bak"
                if not bk.exists():
                    bk.write_bytes(file_bytes)
                result.backup_path = str(bk)

            new_bytes = file_bytes
            applied = False

            if fix.rule_id == "ZERO_BYTE_TAIL" and fix.code_patch:
                # strip trailing bytes after </TfrxReport>
                new_bytes = self._strip_tail(file_bytes)
                applied = True

            elif fix.rule_id == "MEMO_OVERFLOW" and fix.code_patch:
                # need to modify memo view attributes
                # search by memo name
                # extract patch detail
                new_bytes = self._apply_memo_overflow_fix(file_bytes, fix)
                applied = True

            elif fix.rule_id == "MEMO_FONT_MISSING" and fix.code_patch:
                new_bytes = self._add_font_to_memo(file_bytes, fix)
                applied = True

            elif fix.rule_id == "MEMO_FIELD_BINDING" and fix.code_patch:
                new_bytes = self._bind_memo_to_dataset(file_bytes, fix)
                applied = True

            elif fix.rule_id == "SCRIPT_SYNTAX" and fix.code_patch:
                new_bytes = self._fix_script_syntax(file_bytes, fix)
                applied = True

            elif fix.rule_id == "ORPHAN_DATASET" and fix.code_patch:
                new_bytes = self._remove_orphan_dataset(file_bytes, fix)
                applied = True

            elif fix.rule_id == "DUPLICATE_FIELD" and fix.code_patch:
                new_bytes = self._dedup_fields(file_bytes, fix)
                applied = True

            elif fix.rule_id == "DUPLICATE_NAME" and fix.code_patch:
                new_bytes = self._dedup_names(file_bytes, fix)
                applied = True

            else:
                result.error = f"no applier for rule {fix.rule_id}"
                return result

            if applied and new_bytes != file_bytes:
                Path(report.file_path).write_bytes(new_bytes)
                result.success = True
                result.applied_count = 1
                result.applied_fixes.append({
                    "rule_id": fix.rule_id,
                    "description": fix.description,
                    "confidence": fix.confidence,
                })
            elif applied:
                result.error = "no change applied"

            result.elapsed_sec = round(time.time() - t0, 4)
            return result
        except Exception as e:
            result.error = f"{type(e).__name__}: {e}"
            result.elapsed_sec = round(time.time() - t0, 4)
            return result

    def apply_fixes(self, report: FR3Report, fixes: List[FR3Fix],
                    backup: bool = True) -> ApplyResult:
        """Apply multiple fixes sequentially."""
        import time
        t0 = time.time()
        agg = ApplyResult(file_path=report.file_path, success=True)
        file_bytes = Path(report.file_path).read_bytes()

        if backup:
            bk = self.backup_dir / f"{Path(report.file_path).name}.bak"
            if not bk.exists():
                bk.write_bytes(file_bytes)
            agg.backup_path = str(bk)

        for f in fixes:
            if f.confidence < self.min_confidence:
                continue
            r = self.apply_fix(report, f, file_bytes, backup=False)
            if r.success:
                file_bytes = Path(report.file_path).read_bytes()
                agg.applied_count += 1
                agg.applied_fixes.extend(r.applied_fixes)
            else:
                agg.failed_count += 1

        agg.elapsed_sec = round(time.time() - t0, 4)
        agg.success = agg.failed_count == 0
        return agg

    # ---- applier helpers ----

    def _strip_tail(self, b: bytes) -> bytes:
        """Strip zero-byte tail and junk after </TfrxReport>."""
        # find last </TfrxReport>
        idx = b.rfind(b"</TfrxReport>")
        if idx < 0:
            return b
        end = idx + len(b"</TfrxReport>")
        # find end of XML declaration newline
        # then strip trailing whitespace
        return b[:end].rstrip(b"\r\n\t ") + b"\n"

    def _apply_memo_overflow_fix(self, b: bytes, fix: FR3Fix) -> bytes:
        """Adjust Width attribute to fit page."""
        # extract memo name from fix.description
        m = re.search(r"Memo '(\w+)'", fix.description)
        if not m:
            return b
        memo_name = m.group(1)
        # extract current left+width
        m2 = re.search(r"overflows at left\+width=([0-9.]+)\+([0-9.]+)", fix.description)
        if not m2:
            return b
        left = float(m2.group(1))
        width = float(m2.group(2))
        # page width ~ 730 (A4 landscape) or 540 (portrait). Reduce width so left+width < 730
        MAX_WIDTH = 730.0
        if left + width > MAX_WIDTH:
            new_width = MAX_WIDTH - left - 1
            # find TfrxMemoView with that name
            pattern = rb'(<TfrxMemoView\s+[^>]*Name="' + memo_name.encode() + rb'"[^>]*?\bWidth=")' + \
                      b'[^"]+' + rb'(")'
            def repl(m):
                return m.group(1) + f"{new_width:.6f}".encode() + m.group(2)
            new_b, count = re.subn(pattern, repl, b, count=1, flags=re.DOTALL)
            return new_b if count else b
        return b

    def _add_font_to_memo(self, b: bytes, fix: FR3Fix) -> bytes:
        m = re.search(r"Memo '(\w+)'", fix.description)
        if not m:
            return b
        memo_name = m.group(1).encode()
        # find the memo tag
        pattern = rb'(<TfrxMemoView\s+[^>]*Name="' + memo_name + rb'"[^>]*?)(/?>)'
        font_block = (b'<Font Name="Arial" Size="9" Style="0"/>'
                      b'<CharSet>1</CharSet>')
        def repl(m):
            tag = m.group(1)
            close = m.group(2)
            # already has Font?
            if b"Font Name=" in tag:
                return m.group(0)
            # insert Font before close
            return tag + font_block + close
        new_b, count = re.subn(pattern, repl, b, count=1, flags=re.DOTALL)
        return new_b if count else b

    def _bind_memo_to_dataset(self, b: bytes, fix: FR3Fix) -> bytes:
        m = re.search(r"Memo '(\w+)'", fix.description)
        if not m:
            return b
        memo_name = m.group(1).encode()
        # add DataSet attribute before self-closing
        pattern = rb'(<TfrxMemoView\s+[^>]*Name="' + memo_name + rb'")'
        def repl(m):
            if b"DataSet=" in m.group(0):
                return m.group(0)
            return m.group(0) + b' DataSet="Data"'
        new_b, count = re.subn(pattern, repl, b, count=1, flags=re.DOTALL)
        return new_b if count else b

    def _fix_script_syntax(self, b: bytes, fix: FR3Fix) -> bytes:
        # attempt to balance begin/end in PascalScript
        s = b.decode("utf-8", errors="ignore")
        begins = s.count("begin")
        ends = s.count("end;")
        # do not auto-fix beyond balance; return as-is if no obvious problem
        return b

    def _remove_orphan_dataset(self, b: bytes, fix: FR3Fix) -> bytes:
        # parse out dataset name
        m = re.search(r"Dataset '(\w+)'", fix.description)
        if not m:
            return b
        ds = m.group(1).encode()
        # find <TfrxDBDataset Name="Data"> and its closing
        # remove the entire <TfrxDBDataset Name="Data" ...>...</TfrxDBDataset> block
        pattern = rb'<TfrxDBDataset\b[^>]*Name="' + ds + rb'"[^>]*>.*?</TfrxDBDataset>'
        new_b, count = re.subn(pattern, b'', b, count=1, flags=re.DOTALL)
        if not count:
            pattern2 = rb'<TfrxDBDataset\b[^>]*Name="' + ds + rb'"[^/>]*/>'
            new_b, count = re.subn(pattern2, b'', b, count=1)
        return new_b if count else b

    def _dedup_fields(self, b: bytes, fix: FR3Fix) -> bytes:
        # detect duplicates within same <TfrxDBDataset>; remove 2nd+ occurrence
        s = b.decode("utf-8", errors="ignore")
        # find all <TfrxDBDataset>...</TfrxDBDataset>
        out_parts = []
        last = 0
        for m in re.finditer(r'<TfrxDBDataset\b[^>]*>(.*?)</TfrxDBDataset>', s, flags=re.DOTALL):
            out_parts.append(s[last:m.start()])
            block = m.group(0)
            inner = m.group(1)
            seen = set()
            def field_repl(fr):
                mfn = re.search(r'Name="([^"]+)"', fr.group(0))
                if not mfn:
                    return fr.group(0)
                name = mfn.group(1)
                if name in seen:
                    return ""
                seen.add(name)
                return fr.group(0)
            new_inner = re.sub(r'<TfrxFieldDef\s+[^/]*?/?>', field_repl, inner)
            new_block = block[:block.find('>') + 1] + new_inner + '</TfrxDBDataset>'
            out_parts.append(new_block)
            last = m.end()
        out_parts.append(s[last:])
        new_s = "".join(out_parts)
        if new_s != s:
            return new_s.encode("utf-8")
        return b

    def _dedup_names(self, b: bytes, fix: FR3Fix) -> bytes:
        # rename duplicate <Name="X"> by appending suffix
        m = re.search(r"Name '(\w+)'", fix.description)
        if not m:
            return b
        name = m.group(1).encode()
        # find all occurrences of Name="name" and rename subsequent ones
        s = b.decode("utf-8", errors="ignore")
        occurrences = [mm.start() for mm in re.finditer(r'Name="' + name.decode() + r'"', s)]
        if len(occurrences) <= 1:
            return b
        # keep first, rename the rest
        parts = []
        last = 0
        for i, idx in enumerate(occurrences[1:], start=2):
            parts.append(s[last:idx])
            parts.append(f'Name="{name.decode()}_{i}"')
            last = idx + len(f'Name="{name.decode()}"')
        parts.append(s[last:])
        return "".join(parts).encode("utf-8")


__all__ = ["RealFixApplier", "ApplyResult"]