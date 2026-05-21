#!/usr/bin/env python3
"""Generate tutorial validation status dashboard."""

from __future__ import annotations

import argparse
import re
from collections import Counter
from pathlib import Path
from typing import Any

import yaml

TUTORIAL_GLOB = "tutorials/**/*.md"


def frontmatter(path: Path) -> dict[str, Any]:
    text = path.read_text(encoding="utf-8")
    match = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not match:
        return {}
    data = yaml.safe_load(match.group(1))
    return data if isinstance(data, dict) else {}


def method_status(data: dict[str, Any], method: str) -> str:
    method_data = data.get("validation", {}).get(method)
    if not isinstance(method_data, dict):
        return "missing"
    result = method_data.get("result")
    return result if result in {"pass", "fail", "not_tested"} else "missing"


def collect(docs_dir: Path) -> list[dict[str, str]]:
    rows = []
    for path in sorted(docs_dir.glob(TUTORIAL_GLOB)):
        metadata = frontmatter(path)
        rel = path.relative_to(docs_dir).as_posix()
        rows.append(
            {
                "path": rel,
                "az_cli": method_status(metadata, "az_cli"),
                "bicep": method_status(metadata, "bicep"),
            }
        )
    return rows


def overall(row: dict[str, str]) -> str:
    values = {row["az_cli"], row["bicep"]}
    if "fail" in values:
        return "fail"
    if "pass" in values:
        return "pass"
    if values == {"missing"}:
        return "missing"
    return "not_tested"


def render(rows: list[dict[str, str]]) -> str:
    counts = Counter(overall(row) for row in rows)
    lines = [
        "---",
        "content_sources:",
        "  diagrams:",
        "    - id: reference-validation-status",
        "      type: pie",
        "      source: self-generated",
        "      justification: Tutorial validation status chart generated from repository validation frontmatter.",
        "      based_on:",
        "        - docs/tutorials/",
        "content_validation:",
        "  status: pending_review",
        "  last_reviewed: null",
        "  reviewer: agent",
        "  core_claims: []",
        "---",
        "",
        "# Tutorial Validation Status",
        "",
        "This page tracks tutorial validation metadata. `not_tested` means the tutorial is registered in the validation program but has not been executed end-to-end.",
        "",
        "## Summary",
        "",
        "*Generated from repository frontmatter metadata.*",
        "",
        "| Status | Count |",
        "|---|---:|",
        f"| Total tutorials | {len(rows)} |",
        f"| Pass | {counts['pass']} |",
        f"| Fail | {counts['fail']} |",
        f"| Not tested | {counts['not_tested']} |",
        f"| Missing metadata | {counts['missing']} |",
        "",
        "<!-- diagram-id: reference-validation-status -->",
        "```mermaid",
        "pie title Tutorial Validation Status",
    ]
    for label, key in [
        ("Pass", "pass"),
        ("Fail", "fail"),
        ("Not Tested", "not_tested"),
        ("Missing Metadata", "missing"),
    ]:
        if counts[key]:
            lines.append(f'    "{label}" : {counts[key]}')
    lines.extend(
        [
            "```",
            "",
            "## Validation Matrix",
            "",
            "| Tutorial | az_cli | bicep | Overall |",
            "|---|---|---|---|",
        ]
    )
    for row in rows:
        lines.append(
            f"| [{row['path']}](../{row['path']}) | `{row['az_cli']}` | `{row['bicep']}` | `{overall(row)}` |"
        )
    lines.extend(
        [
            "",
            "## How to Update",
            "",
            "Only set `result: pass` after executing the tutorial against a real Azure environment. Use `not_tested` when the tutorial is registered but not yet executed.",
            "",
            "```bash",
            "python3 scripts/generate_validation_status.py",
            "```",
            "",
            "## See Also",
            "",
            "- [Content Source Validation Status](content-validation-status.md)",
            "- [Tutorials](../tutorials/index.md)",
            "- [CLI Cheatsheet](cli-cheatsheet.md)",
            "",
            "## Sources",
            "",
            "- [Azure Monitor documentation](https://learn.microsoft.com/azure/azure-monitor/)",
        ]
    )
    return "\n".join(lines).rstrip() + "\n"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--docs-dir", type=Path, default=Path("docs"))
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("docs/reference/validation-status.md"),
    )
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    content = render(collect(args.docs_dir))
    if args.check:
        if args.output.read_text(encoding="utf-8") != content:
            raise SystemExit(f"{args.output} is stale. Run scripts/generate_validation_status.py.")
        return
    args.output.write_text(content, encoding="utf-8")
    print(f"Generated {args.output}")


if __name__ == "__main__":
    main()
