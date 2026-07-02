---
description: Diagram source metadata policy for the Azure Monitoring practical guide, and the CI tooling that keeps that metadata honest today.
---

# Content Source Validation Status

This page describes how diagram and content sources are declared in this repository, and what tooling is available today to validate those declarations.

!!! note "Current state"
    Diagram-level source metadata (`content_sources.diagrams`) is used across the repository, and the tooling below runs in CI to keep that metadata honest. **Document-level `content_validation` metadata is not yet adopted in this repository** — the schema is documented in [AGENTS.md](https://github.com/yeongseon/azure-monitoring-practical-guide/blob/main/AGENTS.md) as an aspirational policy and is tracked as future work. Do not read the absence of `content_validation` blocks as a validation failure; read it as "not yet implemented."

## Source Type Policy

The `content_sources.diagrams[].source` field must be one of the following values:

| Type | Description | Allowed? |
|---|---|---|
| `mslearn` | Content directly from Microsoft Learn | Yes |
| `mslearn-adapted` | Content adapted or synthesized from Microsoft Learn | Yes, with `based_on` URLs |
| `self-generated` | Original content created for this guide | Requires `justification` |
| `community` | Community source content | Not for core content |
| `unknown` | Source not documented | Must be validated before publication |

## How Diagram Sources Are Declared

### Step 1: Add `content_sources` to the document frontmatter

```yaml
---
content_sources:
  diagrams:
    - id: architecture
      type: flowchart
      source: mslearn-adapted
      based_on:
        - https://learn.microsoft.com/en-us/azure/azure-monitor/overview
---
```

### Step 2: Mark each Mermaid block with its `diagram-id`

```markdown
<!-- diagram-id: architecture -->
​```mermaid
flowchart TD
    A --> B
​```
```

### Step 3: Run the diagram source validator

```bash
python3 scripts/validate_content_sources.py
```

This is the same validator that runs in the `Validate Content Sources` CI workflow.

## Tooling Available in This Repository

The following scripts run against the repository today. There is no dashboard-generator script in this repository, so this page is maintained manually rather than being regenerated.

| Script | Purpose |
|---|---|
| `scripts/validate_content_sources.py` | Enforces that every Mermaid block has a `diagram-id` HTML comment and a matching `content_sources.diagrams[]` entry with a valid `source` value. |
| `scripts/validate_mermaid_format.py` | Enforces Mermaid orientation rules and formatting conventions. |
| `scripts/validate_mermaid_syntax.py` | Parses each Mermaid block to catch syntax errors before build. |
| `scripts/validate_mslearn_urls.py` | Checks that Microsoft Learn URLs cited in `content_sources` are reachable. |

## Validation Rules Enforced Today

!!! danger "Enforced in CI"
    1. Every Mermaid block must have a `diagram-id` HTML comment.
    2. Every declared `diagram-id` must have a matching `content_sources.diagrams[]` entry.
    3. `mslearn-adapted` diagrams must have either an `mslearn_url` field or a populated `based_on` list of Microsoft Learn URLs.
    4. `self-generated` diagrams must include a `justification` field.
    5. Mermaid syntax must parse successfully.

## See Also

- [Reference Index](index.md)

## Sources

- https://learn.microsoft.com/en-us/azure/azure-monitor/
- https://learn.microsoft.com/en-us/azure/
