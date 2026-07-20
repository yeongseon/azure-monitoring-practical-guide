---
description: Diagram source metadata policy for the Azure Monitoring practical guide, and the CI tooling that keeps that metadata honest today.
---

# Content Source Validation Status

This page describes how diagram and content sources are declared in this repository, and what tooling is available today to validate those declarations.

!!! note "Current state"
    Diagram-level source metadata (`content_sources.diagrams`) is used across the repository, and the tooling below runs in CI to keep that metadata honest. **Document-level `content_validation` metadata is being rolled out section-by-section.** Adoption began with the `docs/platform/` factual pages (see [Document-Level `content_validation` Coverage](#document-level-content_validation-coverage) below); `docs/best-practices/` and `docs/operations/` follow in subsequent pull requests. Until a section is listed as covered, do not read the absence of a `content_validation` block on its pages as a validation failure; read it as "not yet rolled out to that section."

## Source Type Policy

The `content_sources.diagrams[].source` field must be one of the three values below. These are the exact set accepted by `scripts/validate_content_sources.py` today; any other value causes CI to fail.

| Type | Description | Additional requirement |
|---|---|---|
| `mslearn` | Content directly from Microsoft Learn | `mslearn_url` OR a non-empty `based_on` list |
| `mslearn-adapted` | Content adapted or synthesized from Microsoft Learn | `mslearn_url` OR a non-empty `based_on` list |
| `self-generated` | Original content created for this guide | `justification` field |

!!! note "Broader source vocabulary in AGENTS.md"
    [AGENTS.md](https://github.com/yeongseon/azure-monitoring-practical-guide/blob/main/AGENTS.md) also references `community` and `unknown` source categories as part of the broader content-validation policy. Those values are **not** currently accepted by the validator on any Mermaid page in this repository.

## Document-Level `content_validation` Coverage

Document-level `content_validation` blocks record the verification status of a page's core factual claims, each traced to an already-cited Microsoft Learn URL. This metadata is not machine-validated by a dashboard generator today (there is no generator script in this repository); it is maintained manually and reviewed as part of each pull request.

| Section | Status | Notes |
|---|---|---|
| `docs/platform/` | Rolled out | All eight factual platform pages carry a `content_validation` block. The section landing page (`index.md`) is navigation-only and is intentionally excluded. |
| `docs/best-practices/` | Planned | Follows in a subsequent pull request. |
| `docs/operations/` | Planned | Follows in a subsequent pull request. |

Sections not listed are out of scope for document-level `content_validation` (for example, reference look-ups, tutorials, and KQL packs make no standalone factual platform claims).

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

| Script | Purpose | Where it runs |
|---|---|---|
| `scripts/validate_content_sources.py` | Enforces that every Mermaid block has a `diagram-id` HTML comment and a matching `content_sources.diagrams[]` entry with a valid `source` value. | **Blocking** PR check (`Validate Content Sources`) |
| `scripts/validate_mermaid_format.py` | Enforces Mermaid orientation rules and formatting conventions. | **Blocking** PR check (same workflow) |
| `scripts/validate_mermaid_syntax.py` | Parses each Mermaid block to catch syntax errors before build. | **Blocking** PR check (same workflow) |
| `scripts/validate_mslearn_urls.py` | Checks that Microsoft Learn URLs cited in `content_sources` are reachable. | **Reporting only:** runs on push to `main` with `continue-on-error`, not a blocking PR gate |

## Validation Rules Enforced Today

!!! danger "Enforced in CI"
    1. Every Mermaid block must have a `diagram-id` HTML comment.
    2. Every declared `diagram-id` must have a matching `content_sources.diagrams[]` entry.
    3. `mslearn-adapted` and `mslearn` diagrams must have either an `mslearn_url` field or a **non-empty** `based_on` list. The validator does **not** currently verify that every `based_on` URL points to `learn.microsoft.com`; that is a repository convention, not an enforced rule.
    4. `self-generated` diagrams must include a `justification` field.
    5. Mermaid syntax must parse successfully.

## See Also

- [Reference Index](index.md)

## Sources

- https://learn.microsoft.com/en-us/azure/azure-monitor/
- https://learn.microsoft.com/en-us/azure/
