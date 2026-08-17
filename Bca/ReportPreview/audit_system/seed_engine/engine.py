"""
Dynamic Report Seed Engine
===========================
Generates .fr3 seeds (master templates) for stored procedures in the
database, ranked by complexity.

Pipeline:
    1. Pull stored procedure definitions from SQL Server
    2. Score each one for complexity (params, joins, agg, subqueries)
    3. For top-N most complex procedures, generate a fully-formed
       FastReport .fr3 seed (XML) — minimal but valid, ready to
       import into FastReport Designer.

This module plugs into the existing LearningEngine so each generated
seed is registered as a learned skill (rule_id = PROC_NAME + lang).
"""
from __future__ import annotations

import os
import re
import json
import time
import hashlib
import random
from dataclasses import dataclass, field, asdict
from pathlib import Path
from typing import Dict, List, Optional, Any, Tuple
from xml.sax.saxutils import escape

import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from learning_engine.engine import LearningEngine, LearnedSkill


# ---------------------------------------------------------------------------
# Models
# ---------------------------------------------------------------------------
@dataclass
class SPComplexity:
    procedure: str
    params: int
    joins: int
    aggregations: int
    subqueries: int
    tables_referenced: int
    lines: int
    score: float
    rank: int = 0


@dataclass
class FR3Seed:
    procedure: str
    complexity: SPComplexity
    file_path: str
    datasets: List[str]
    fields: List[str]
    parameters: List[Dict[str, str]]
    bands: List[str]
    sha256: str
    generated_at: float


# ---------------------------------------------------------------------------
# Complexity analyzer
# ---------------------------------------------------------------------------
class StoredProcedureAnalyzer:
    """Static-analysis complexity scoring for T-SQL stored procedures."""

    # Common aggregation keywords
    AGG = ("SUM(", "AVG(", "COUNT(", "MAX(", "MIN(", "GROUP BY", "HAVING")
    JOIN = ("INNER JOIN", "LEFT JOIN", "RIGHT JOIN", "FULL JOIN", "CROSS JOIN")
    SUB = ("SELECT ",)  # subqueries = inner SELECTs
    PARAM_RE = re.compile(r"@\w+", re.I)

    @classmethod
    def analyze(cls, name: str, definition: str) -> SPComplexity:
        if not definition:
            return SPComplexity(name, 0, 0, 0, 0, 0, 0, 0.0)

        body = definition.upper()
        joins = sum(body.count(j) for j in cls.JOIN)
        aggs = sum(body.count(a) for a in cls.AGG)
        # subquery heuristic: count "SELECT " and subtract 1 (the outer)
        subq = max(0, body.count("SELECT ") - 1)
        # tables referenced — crude: tokens after FROM/JOIN
        tables = len(set(re.findall(r"\b(?:FROM|JOIN)\s+(\[?dbo\]?\.?\[?\w+\]?)", body)))
        # parameters
        params = len(set(cls.PARAM_RE.findall(definition)))
        lines = max(1, definition.count("\n"))

        # score = weighted sum
        score = (
            params * 1.0
            + joins * 3.0
            + aggs * 2.0
            + subq * 4.0
            + tables * 1.5
            + (lines / 50.0) * 0.5
        )

        return SPComplexity(
            procedure=name,
            params=params,
            joins=joins,
            aggregations=aggs,
            subqueries=subq,
            tables_referenced=tables,
            lines=lines,
            score=round(score, 2),
        )


# ---------------------------------------------------------------------------
# Field extractor — pull likely data fields from procedure definition
# ---------------------------------------------------------------------------
class FieldExtractor:
    """Heuristic field discovery from T-SQL definition.
    
    Strategy: extract columns from the main SELECT statement, handling:
    - Column aliases (AS)
    - Functions with parameters (SUM(x), CAST(x AS ...))
    - Table prefixes
    - Computed columns
    """

    @staticmethod
    def extract(definition: str) -> List[str]:
        if not definition:
            return []
        
        # Strategy 1: Look for "SELECT" followed by column list before first FROM
        # We need to find the MAIN query (not subqueries), so look for the first
        # FROM that's not inside parentheses
        main_query = FieldExtractor._extract_main_select(definition)
        if not main_query:
            return []
        
        fields = FieldExtractor._parse_select_columns(main_query)
        
        # If no fields found, fall back to parameter names (common in report SPs)
        if not fields:
            fields = FieldExtractor._extract_param_fields(definition)
        
        return fields[:20]
    
    @staticmethod
    def _extract_main_select(definition: str) -> Optional[str]:
        """Extract the main SELECT statement (not subqueries)."""
        # Find the first SELECT
        select_match = re.search(r'\bSELECT\b', definition, re.IGNORECASE)
        if not select_match:
            return None
        
        start = select_match.start()
        # Find the matching FROM by tracking parenthesis depth
        depth = 0
        pos = start
        while pos < len(definition):
            ch = definition[pos]
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
            elif ch == '\n' or ch == ';':
                # End of statement
                break
            pos += 1
        
        return definition[start:pos].strip()
    
    @staticmethod
    def _parse_select_columns(select: str) -> List[str]:
        """Parse column list from SELECT statement."""
        # Remove SELECT keyword
        select = re.sub(r'^\bSELECT\b\s*', '', select, flags=re.IGNORECASE)
        # Remove TOP clause
        select = re.sub(r'\bTOP\s+\d+\s*', '', select, flags=re.IGNORECASE)
        # Remove DISTINCT
        select = re.sub(r'\bDISTINCT\b\s*', '', select, flags=re.IGNORECASE)
        
        # Split columns by comma, respecting parentheses
        parts: List[str] = []
        depth = 0
        current = ""
        for ch in select:
            if ch == '(':
                depth += 1
                current += ch
            elif ch == ')':
                depth -= 1
                current += ch
            elif ch == ',' and depth == 0:
                if current.strip():
                    parts.append(current.strip())
                current = ""
            else:
                current += ch
        if current.strip():
            parts.append(current.strip())
        
        fields = []
        for part in parts:
            # Check for alias
            alias_match = re.search(r'\bAS\s+(\w+)\b', part, re.IGNORECASE)
            if alias_match:
                fields.append(alias_match.group(1))
            else:
                # Try to extract column name (remove prefixes, functions)
                # Remove table prefixes like "t1."
                col = re.sub(r'^\w+\.', '', part)
                # Remove function wrappers like "SUM(" ... ")" or "CAST(" ... ")"
                # Extract base column name
                base_match = re.search(r'\[?(\w+)\]?', col)
                if base_match:
                    fields.append(base_match.group(1))
        
        return fields[:20]
    
    @staticmethod
    def _extract_param_fields(definition: str) -> List[str]:
        """Fallback: extract parameter names as field hints."""
        params = re.findall(r'@(\w+)', definition)
        # Common report parameters
        common = {'TglAwal', 'TglAkhir', 'tgl1', 'tgl2', 'NoBukti', 'Customer', 
                  'Supplier', 'Gudang', 'Sales', 'Kode', 'Kategori', 'Grup'}
        # Filter to common report field names
        fields = [p for p in params if p.lower() in common or len(p) > 3]
        return fields[:10]


# ---------------------------------------------------------------------------
# FR3 seed generator
# ---------------------------------------------------------------------------
class FR3SeedGenerator:
    """Produces minimal valid .fr3 XML for a stored procedure."""

    HEADER = (
        '<?xml version="1.0" encoding="utf-8"?>\n'
        '<TfrxReport Version="4.5" DotMatrixReport="False" '
        'IniFile="\\Software\\Fast Reports" PreviewOptions.Buttons="4095" '
        'PreviewOptions.Zoom="1" PrintOptions.Printer="Default" '
        'PrintOptions.PrintOnSheet="0" ReportOptions.CreateDate="{created}" '
        'ReportOptions.LastChange="{changed}" ScriptLanguage="PascalScript" '
        'ScriptText.Text="begin&#13;&#10;end." '
        'PropData="044C65667403200203546F70025008446174617365747301010C2E00000020'
        '446174615365743D2266727844424D61696E2200446174615365744E616D653D2266727844424D61696E220000095661726961626C65730100055374796C650100">\n'
    )

    def __init__(self, complexity: SPComplexity, fields: List[str], parameters: List[Dict[str, str]]):
        self.complexity = complexity
        self.fields = fields or ["NoBukti", "Tanggal", "Keterangan", "Qty", "Harga", "Total"]
        self.parameters = parameters or [
            {"name": "@TglAwal", "type": "datetime", "len": "8"},
            {"name": "@TglAkhir", "type": "datetime", "len": "8"},
        ]

    def _dataset_xml(self) -> str:
        field_list = "".join(
            f'<Field Name="{escape(f)}" DataType="String"/>\n        '
            for f in self.fields
        )
        return (
            f'  <TfrxDataPage Name="Data" Height="1000" Left="0" Top="0" Width="1000"/>\n'
            f'  <TfrxReportPage Name="Page1" PaperWidth="210" PaperHeight="297" '
            f'PaperSize="9" LeftMargin="10" RightMargin="10" TopMargin="10" '
            f'BottomMargin="10" ColumnWidth="0" ColumnPositions.Text="">\n'
            f'    <TfrxMasterData Name="MasterData1" Height="18.9" Left="0" Top="240" '
            f'Width="740" ColumnWidth="0" ColumnGap="0" DataSet="frxDBMain" '
            f'DataSetName="frxDBMain" RowCount="0" Stretched="True">\n'
        )

    def _memos_xml(self) -> str:
        memos: List[str] = []
        x = 0
        for i, f in enumerate(self.fields[:6]):
            memos.append(
                f'      <TfrxMemoView Name="Memo{i+1}" Left="{x}" Top="0" '
                f'Width="120" Height="18.9" DataSet="frxDBMain" DataSetName="frxDBMain" '
                f'DisplayFormat.DecimalSeparator="," Font.Charset="1" Font.Color="0" '
                f'Font.Height="-13" Font.Name="Arial" Font.Style="0" ParentFont="False" '
                f'Text="[frxDBMain.&quot;{escape(f)}&quot;]"/>\n'
            )
            x += 122
        return "".join(memos)

    def _header_xml(self) -> str:
        title = self.complexity.procedure.replace("sp_", "").replace("SP_", "")
        title = re.sub(r"([a-z])([A-Z])", r"\1 \2", title).title()
        return (
            f'    <TfrxPageHeader Name="PageHeader1" Height="120" Left="0" '
            f'Top="0" Width="740">\n'
            f'      <TfrxMemoView Name="Title" Left="0" Top="10" Width="740" '
            f'Height="30" DisplayFormat.DecimalSeparator="," Font.Charset="1" '
            f'Font.Color="0" Font.Height="-19" Font.Name="Arial" Font.Style="1" '
            f'HAlign="haCenter" ParentFont="False" Text="{escape(title)}"/>\n'
            f'      <TfrxMemoView Name="Subtitle" Left="0" Top="50" Width="740" '
            f'Height="20" DisplayFormat.DecimalSeparator="," Font.Charset="1" '
            f'Font.Color="0" Font.Height="-13" Font.Name="Arial" Font.Style="2" '
            f'HAlign="haCenter" ParentFont="False" Text="Auto-generated from {escape(self.complexity.procedure)} | Complexity score: {self.complexity.score}"/>\n'
        )

    def _footer_xml(self) -> str:
        return (
            f'    </TfrxPageHeader>\n'
            f'    <TfrxPageFooter Name="PageFooter1" Height="40" Left="0" Top="320" Width="740">\n'
            f'      <TfrxMemoView Name="Footer" Left="0" Top="10" Width="740" Height="20" '
            f'DisplayFormat.DecimalSeparator="," Font.Charset="1" Font.Color="0" '
            f'Font.Height="-11" Font.Name="Arial" Font.Style="0" HAlign="haCenter" '
            f'ParentFont="False" Text="Page [Page#] of [TotalPages] | Generated by '
            f'dynamic-report-seed-engine"/>\n'
            f'    </TfrxPageFooter>\n'
            f'  </TfrxReportPage>\n'
            f'</TfrxReport>\n'
        )

    def render(self) -> str:
        created = time.strftime("%y%m%d,%H%M%S", time.localtime())
        return (
            self.HEADER.format(created=created, changed=created)
            + self._dataset_xml()
            + self._memos_xml()
            + "    </TfrxMasterData>\n"
            + self._header_xml()
            + self._footer_xml()
        )


# ---------------------------------------------------------------------------
# Dynamic Report Seed Engine
# ---------------------------------------------------------------------------
class DynamicReportSeedEngine:
    """Orchestrator: DB → analyze → score → generate → register skill."""

    def __init__(self, output_dir: str = "d:/TestLaB/piagent/Bca/ReportPreview/seeds",
                 learning_engine: Optional[LearningEngine] = None):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.engine = learning_engine or LearningEngine()
        self.seeds: List[FR3Seed] = []
        self.ranking: List[SPComplexity] = []

    def _connect(self):
        import pyodbc
        return pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=192.168.56.1;'
            'DATABASE=dbbcagroup;'
            'UID=sa;'
            'PWD=anekajc1a9;'
        )

    def _fetch_procedures(self) -> List[Tuple[str, str, List[Dict[str, str]]]]:
        conn = self._connect()
        cur = conn.cursor()
        cur.execute("""
            SELECT p.name, OBJECT_DEFINITION(p.object_id)
            FROM sys.procedures p
        """)
        procs = []
        for row in cur.fetchall():
            name = row[0]
            defn = row[1] or ""
            # fetch params
            cur.execute("""
                SELECT pm.name, TYPE_NAME(pm.user_type_id), pm.max_length, pm.is_output
                FROM sys.parameters pm
                WHERE pm.object_id = OBJECT_ID(?)
                ORDER BY pm.parameter_id
            """, (name,))
            params = [
                {"name": p[0], "type": p[1], "len": str(p[2]), "output": bool(p[3])}
                for p in cur.fetchall() if p[0]
            ]
            procs.append((name, defn, params))
        conn.close()
        return procs

    def analyze_all(self) -> List[SPComplexity]:
        """Pull from DB, score, return ranked list."""
        procs = self._fetch_procedures()
        scored: List[SPComplexity] = []
        for name, defn, _params in procs:
            scored.append(StoredProcedureAnalyzer.analyze(name, defn))
        scored.sort(key=lambda x: -x.score)
        for i, s in enumerate(scored, 1):
            s.rank = i
        self.ranking = scored
        return scored

    def generate_top(self, n: int = 11) -> List[FR3Seed]:
        """Generate seed .fr3 for top-N most complex procedures."""
        if not self.ranking:
            self.analyze_all()
        top = self.ranking[:n]
        seeds: List[FR3Seed] = []

        # need definitions & params — refetch
        all_procs = {p[0]: (p[1], p[2]) for p in self._fetch_procedures()}

        for comp in top:
            defn, params = all_procs.get(comp.procedure, ("", []))
            fields = FieldExtractor.extract(defn)
            gen = FR3SeedGenerator(comp, fields, params)
            xml = gen.render()
            out = self.output_dir / f"{comp.procedure}.seed.fr3"
            out.write_text(xml, encoding="utf-8")
            sha = hashlib.sha256(xml.encode("utf-8")).hexdigest()
            seed = FR3Seed(
                procedure=comp.procedure,
                complexity=comp,
                file_path=str(out),
                datasets=["frxDBMain"],
                fields=fields,
                parameters=params,
                bands=["PageHeader1", "MasterData1", "PageFooter1"],
                sha256=sha,
                generated_at=time.time(),
            )
            seeds.append(seed)

            # register skill
            self.engine.learn(
                rule_id=f"SEED_{comp.procedure}",
                pattern=f"complexity_score={comp.score};fields={','.join(fields)}",
                fix_action=f"generated .fr3 seed at {out}",
                confidence=min(1.0, comp.score / 50.0),
                applied=True,
                success=True,
                example_path=str(out),
                language="fr3-seed",
            )
        self.seeds = seeds
        return seeds

    def report_markdown(self) -> str:
        if not self.ranking:
            self.analyze_all()
        lines = [
            "# Dynamic Report Seed Engine — Top 11 Very-High-Complexity Reports",
            "",
            f"**Source DB**: dbbcagroup @ 192.168.56.1  ",
            f"**Engine**: dynamic-report-seed-engine  ",
            f"**Output**: {self.output_dir}  ",
            f"**Generated**: {time.strftime('%Y-%m-%d %H:%M:%S')}",
            "",
            "## Complexity Ranking (all 408 procedures)",
            "",
            "| Rank | Procedure | Params | Joins | Aggs | SubQ | Tables | Score |",
            "|------|-----------|--------|-------|------|------|--------|-------|",
        ]
        for s in self.ranking[:11]:
            lines.append(
                f"| {s.rank} | `{s.procedure}` | {s.params} | {s.joins} | {s.aggregations} | "
                f"{s.subqueries} | {s.tables_referenced} | **{s.score}** |"
            )
        lines.extend([
            "",
            "## Seed Files Generated",
            "",
            "| # | Procedure | File | Size | SHA256 |",
            "|---|-----------|------|------|--------|",
        ])
        for i, seed in enumerate(self.seeds, 1):
            size = Path(seed.file_path).stat().st_size
            lines.append(
                f"| {i} | `{seed.procedure}` | `{Path(seed.file_path).name}` | "
                f"{size:,}B | `{seed.sha256[:12]}...` |"
            )
        lines.extend([
            "",
            "## Engine Stats",
            "",
            f"- Procedures analyzed: **{len(self.ranking)}**",
            f"- Seeds generated: **{len(self.seeds)}**",
            f"- Avg complexity (top 11): **{sum(s.score for s in self.ranking[:11])/11:.1f}**",
            f"- Output dir: `{self.output_dir}`",
            "",
            "## How to Use",
            "",
            "1. Open FastReport Designer",
            "2. File ��� Open → pick any `*.seed.fr3` from the output dir",
            "3. Connect to `192.168.56.1\\dbbcagroup`",
            "4. Map `frxDBMain` to exec the stored procedure",
            "5. Edit layout, save as real `.fr3`",
            "",
        ])
        return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def run(top_n: int = 11):
    eng = DynamicReportSeedEngine()
    eng.analyze_all()
    seeds = eng.generate_top(top_n)
    md = eng.report_markdown()
    report_path = Path(eng.output_dir).parent / "seed_report.md"
    report_path.write_text(md, encoding="utf-8")
    print(md)
    print(f"\nReport saved: {report_path}")
    return eng, seeds


if __name__ == "__main__":
    import sys
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 11
    run(n)