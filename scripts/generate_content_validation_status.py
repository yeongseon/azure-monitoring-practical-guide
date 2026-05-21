#!/usr/bin/env python3
"""Generate non-tutorial content validation status dashboard."""

from __future__ import annotations

import argparse
import re
from collections import Counter
from pathlib import Path
from typing import Any

import yaml

VALID_STATUSES = {"verified", "pending_review", "unverified"}


def frontmatter(path: Path) -> dict[str, Any]:
    text = path.read_text(encoding="utf-8")
    match = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not match:
        return {}
    data = yaml.safe_load(match.group(1))
    return data if isinstance(data, dict) else {}


def is_tutorial(path: Path, docs_dir: Path) -> bool:
    parts = path.relative_to(docs_dir).parts
    return bool(parts) and parts[0] == "tutorials"


def status(metadata: dict[str, Any]) -> str:
    content_validation = metadata.get("content_validation")
    if not isinstance(content_validation, dict):
        return "missing"
    value = content_validation.get("status")
    return value if value in VALID_STATUSES else "missing"


def claims(metadata: dict[str, Any]) -> tuple[int, int]:
    content_validation = metadata.get("content_validation")
    if not isinstance(content_validation, dict):
        return 0, 0
    core_claims = content_validation.get("core_claims", [])
    if not isinstance(core_claims, list):
        return 0, 0
    verified = sum(
        1
        for claim in core_claims
        if isinstance(claim, dict) and claim.get("verified") is True
    )
    return len(core_claims), verified


def collect(docs_dir: Path) -> list[dict[str, Any]]:
    rows = []
    for path in sorted(docs_dir.glob("**/*.md")):
        if is_tutorial(path, docs_dir):
            continue
        metadata = frontmatter(path)
        total_claims, verified_claims = claims(metadata)
        rows.append(
            {
                "path": path.relative_to(docs_dir).as_posix(),
                "status": status(metadata),
                "claims": total_claims,
                "verified": verified_claims,
            }
        )
    return rows


def render(rows: list[dict[str, Any]]) -> str:
    status_counts = Counter(row["status"] for row in rows)
    total_claims = sum(row["claims"] for row in rows)
    verified_claims = sum(row["verified"] for row in rows)

    lines = [
        "---",
        "content_sources:",
        "  diagrams:",
        "    - id: reference-content-validation-status",
        "      type: pie",
        "      source: self-generated",
        "      justification: Content validation status chart generated from repository frontmatter metadata.",
        "      based_on:",
        "        - docs/",
        "content_validation:",
        "  status: pending_review",
        "  last_reviewed: null",
        "  reviewer: agent",
        "  core_claims: []",
        "---",
        "",
        "# Content Validation Status",
        "",
        "This page tracks non-tutorial document validation metadata. `pending_review` means the document is registered in the workflow but its individual claims still need source review.",
        "",
        "## Summary",
        "",
        "*Generated from repository frontmatter metadata.*",
        "",
        "| Status | Count |",
        "|---|---:|",
        f"| Total non-tutorial documents | {len(rows)} |",
        f"| Verified | {status_counts['verified']} |",
        f"| Pending review | {status_counts['pending_review']} |",
        f"| Unverified | {status_counts['unverified']} |",
        f"| Missing metadata | {status_counts['missing']} |",
        f"| Core claims listed | {total_claims} |",
        f"| Core claims verified | {verified_claims} |",
        "",
        "<!-- diagram-id: reference-content-validation-status -->",
        "```mermaid",
        "pie title Content Validation Status",
    ]
    for label, key in [
        ("Verified", "verified"),
        ("Pending Review", "pending_review"),
        ("Unverified", "unverified"),
        ("Missing Metadata", "missing"),
    ]:
        if status_counts[key]:
            lines.append(f'    "{label}" : {status_counts[key]}')
    lines.extend(
        [
            "```",
            "",
            "## Document Matrix",
            "",
            "| Document | Status | Core Claims | Verified Claims |",
            "|---|---|---:|---:|",
        ]
    )
    for row in rows:
        lines.append(
            f"| [{row['path']}](../{row['path']}) | `{row['status']}` | {row['claims']} | {row['verified']} |"
        )
    lines.extend(
        [
            "",
            "## How to Update",
            "",
            "Add or update `content_validation` frontmatter when a document is reviewed against Microsoft Learn sources.",
            "",
            "```bash",
            "python3 scripts/generate_content_validation_status.py",
            "```",
            "",
            "## See Also",
            "",
            "- [Tutorial Validation Status](validation-status.md)",
            "- [CLI Cheatsheet](cli-cheatsheet.md)",
            "- [Platform Limits](platform-limits.md)",
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
        default=Path("docs/reference/content-validation-status.md"),
    )
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    content = render(collect(args.docs_dir))
    if args.check:
        if args.output.read_text(encoding="utf-8") != content:
            raise SystemExit(
                f"{args.output} is stale. Run scripts/generate_content_validation_status.py."
            )
        return
    args.output.write_text(content, encoding="utf-8")
    print(f"Generated {args.output}")


if __name__ == "__main__":
    main()
