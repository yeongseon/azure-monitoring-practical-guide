# AGENTS.md

Guidance for AI agents working in this repository.

## Project Overview

**Azure Monitoring Practical Guide** — a unified documentation hub for implementing, operating, and troubleshooting Azure Monitor, Log Analytics, Application Insights, and related observability services.

- **Live site**: <https://yeongseon.github.io/azure-monitoring-practical-guide/>
- **Repository**: <https://github.com/yeongseon/azure-monitoring-practical-guide>

## Series-Wide Documentation Contract

This repository is part of the Azure Practical Guide series. All repositories in the series must preserve a consistent reader experience while allowing repository-specific extensions.

### Core Sections

Every service-focused repository SHOULD use these core sections unless the repository-specific addendum explains an exception.

| Section | Required | Purpose |
|---|---:|---|
| `Start Here` | Yes | Entry points, overview, learning paths, repository map |
| `Platform` | Yes | Service concepts, architecture, core behavior |
| `Best Practices` | Yes | Production patterns, anti-patterns, design guidance |
| `Operations` | Yes | Day-2 operational procedures and verification |
| `Troubleshooting` | Yes | Symptom-based diagnosis, playbooks, evidence collection |
| `Reference` | Yes | CLI, KQL, limits, glossary, decision tables |

### Approved Extension Sections

| Section | Use When |
|---|---|
| `Tutorials` | The repository provides hands-on learning or lab sequences |
| `Lab Guides` | Reproducible experiments or validation exercises are first-class content |
| `Language Guides` | The service has language/runtime-specific implementation tutorials |
| `SDK Guides` | The service is primarily consumed through SDKs |
| `Service Guides` | The repository configures or monitors multiple Azure services |
| `Workload Guides` | The repository is architecture/workload oriented |
| `Architecture Reviews` | The repository includes architecture review methodology and playbooks |
| `Design Labs` | The repository includes architecture design exercises |
| `Visualization` | Visual maps are a deliberate learning surface, not generated leftovers |
| `Meta` | Repository taxonomy, content model, or generated metadata |

Do not create a new top-level section if the content can fit under one of the core or approved extension sections.

## Monitoring-Specific Addendum

This repository covers Azure Monitor and observability configuration across multiple Azure services. It uses `Service Guides` as a first-class extension section.

Approved Monitoring extension sections:

| Section | Purpose |
|---|---|
| `Service Guides` | Per-service monitoring setup and observability configuration |
| `Tutorials` | Hands-on monitoring setup tutorials |
| `Lab Guides` | Reproducible monitoring exercises |
| `KQL Query Packs` | Query examples and diagnostic interpretation |

### Completeness over Line Count

Avoid hard line-count targets. A page is complete when:

- It explains the concept or task clearly.
- It includes required sources and validation metadata.
- It provides CLI/KQL examples only where useful.
- It separates facts, measurements, and inferences.
- It avoids repeating full explanations that belong in another canonical page.

## Repository Structure

```text
.
├── .github/
│   └── workflows/              # GitHub Pages deployment
├── docs/
│   ├── assets/
│   │   └── images/             # Static site assets
│   ├── best-practices/         # Production patterns and anti-patterns (8 pages)
│   ├── javascripts/            # Mermaid zoom JS
│   ├── main.html               # MkDocs Material template override
│   ├── operations/             # Day-2 operational execution (8 pages)
│   ├── platform/               # Architecture and design decisions (9 pages)
│   ├── reference/              # CLI cheatsheet, KQL, limits, tables (5 pages)
│   ├── service-guides/         # Per-service monitoring configurations (13 pages)
│   │   ├── app-service/        # App Service landing page + 3 deep dives
│   │   ├── aks/                # AKS landing page + observability guide
│   │   ├── container-apps/     # Container Apps landing page + observability guide
│   │   ├── functions/          # Functions landing page + observability guide
│   │   └── vm/                 # VM landing page + observability guide
│   ├── start-here/             # Overview, learning paths, repository map (3 pages)
│   ├── stylesheets/            # Custom CSS
│   └── troubleshooting/        # Decision tree, evidence map, playbooks, query packs (29 pages)
│       ├── playbooks/          # 9 playbooks with real Azure evidence
│       └── kql/                # KQL query packs and category indexes (14 pages)
└── mkdocs.yml                  # MkDocs Material configuration (7-tab nav)
```

## Start Here Rules

`Start Here` is orientation content. It must not become a language tutorial, SDK tutorial, operations runbook, troubleshooting playbook, or lab guide.

Required pages:

| Page | Purpose |
|---|---|
| `overview.md` | Who this guide is for, what is in scope, and what is out of scope |
| `learning-paths.md` | Role-based and experience-based reading paths |
| `repository-map.md` | Map of major sections and when to use them |

Optional pages:

| Page Pattern | Purpose |
|---|---|
| `when-to-use-*.md` | Service selection guidance |
| `prerequisites.md` | Required tools, permissions, and accounts |
| `common-scenarios.md` | Common use cases |
| `*-vs-other-compute.md` | Positioning against neighboring Azure services |
| `how-to-use-this-guide.md` | Reader navigation guidance |

`learning-paths.md` MUST:

- Start with role-based or goal-based paths.
- Link to tutorials instead of embedding a full tutorial sequence.
- Avoid service-specific code walkthroughs except short examples.
- Avoid `content_validation` unless this repository explicitly includes Start Here pages in content validation scope.

Preferred title:

```markdown
# Learning Paths
```

Avoid:

```markdown
# Tutorial: {Service} for {Language}
```

## Navigation Budget

The left navigation should help orientation, not expose every file.

Recommended:

- Top-level sections SHOULD stay between 6 and 9 items.
- Direct children under a top-level section SHOULD stay between 5 and 8 items.
- Large collections such as tutorials, recipes, KQL packs, lab guides, and playbooks SHOULD be listed on index pages rather than fully expanded in `mkdocs.yml`.
- Use hub pages, tables, tags, and search for deep inventory.
- Keep `mkdocs.yml` readable enough that a contributor can understand the site structure without scrolling through hundreds of deep links.

Preferred troubleshooting structure:

```text
Troubleshooting
├─ Overview
├─ Quick Diagnosis
├─ Decision Tree
├─ First 10 Minutes
├─ Playbooks
├─ KQL Query Packs
└─ Labs
```

Avoid exposing every individual playbook, KQL query, and lab guide in `mkdocs.yml` unless the repository is intentionally small.

## Content Validation Scope

`content_validation` is required for factual-claim pages, not for every Markdown file.

Required by default:

- `docs/platform/**`
- `docs/best-practices/**`
- `docs/operations/**`
- factual troubleshooting methodology/playbook pages

Usually out of scope:

- `docs/start-here/**`
- `docs/reference/**`
- `docs/language-guides/**`
- `docs/sdk-guides/**`
- `docs/tutorials/**`
- `docs/troubleshooting/kql/**`
- `docs/troubleshooting/lab-guides/**`
- generated dashboards
- navigation-only index pages

Content-type-specific rules:

- Tutorials use `validation`.
- Labs use evidence and falsification integrity.
- KQL packs document query purpose, expected interpretation, required tables, and assumptions.
- KQL packs do not need `content_validation` unless they make factual platform claims outside the query explanation.
- Never fabricate validation dates or test results.

## Mermaid Diagrams

Use Mermaid diagrams when they clarify architecture, flow, dependency, decision logic, or troubleshooting paths.

Required for:

- Platform architecture pages
- Complex operations pages
- Decision trees
- Troubleshooting playbooks with multi-step diagnosis
- Lab guides with failure progression or evidence timelines
- Architecture review or design decision flows

Optional for:

- Reference tables
- CLI cheatsheets
- Glossary pages
- Generated validation dashboards
- Short landing pages
- Simple tutorial steps where prose is clearer

Do not add a diagram just to satisfy a checkbox. A diagram must explain something better than prose or a table.

### Diagram Orientation Rule

- **Sequential flows with 5+ nodes**: Use `flowchart TD` (top-down) to prevent horizontal overflow.
- **Short diagrams with fewer than 5 nodes**: `flowchart LR` (left-right) is acceptable.
- **Layered architecture diagrams** (e.g., network layers, stack diagrams): Always use `flowchart TD`.

```mermaid
%% CORRECT — 5+ node sequential flow uses TD
flowchart TD
    A[Commit] --> B[Build and test]
    B --> C[Package artifact]
    C --> D[Deploy to staging]
    D --> E[Validation]
    E --> F[Swap to production]

%% WRONG — long horizontal overflow
flowchart LR
    A[Commit] --> B[Build and test] --> C[Package] --> D[Deploy] --> E[Validate] --> F[Swap]
```

### Monitoring-Specific Diagram Types

Common diagram types for Azure Monitor:

- Data flow diagrams (sources → workspace → consumers)
- Alert processing pipelines
- DCR routing topology
- Workspace federation patterns

## Image and Screenshot Rules

Images must support the reader's task. Do not add screenshots only for decoration.

Every referenced image MUST have:

- Descriptive alt text.
- A nearby explanation of what the reader should verify.
- No real subscription IDs, tenant IDs, object IDs, emails, phone numbers, secrets, keys, connection strings, or customer data.
- Visual verification before merge when the image is referenced from Markdown.

Recommended explanation pattern:

```markdown
![Container App overview showing a healthy revision](../assets/example.png)

Purpose: Confirm why this image exists.
Look for: Tell the reader what values or states to confirm.
Expected result: State the healthy or expected condition.
Next step: Link the image to the next action.
```

Portal screenshots:

- Prefer text replacement over black-box redaction.
- Use black-box masking only for unavoidable avatar/profile pixels and only with the repository-approved mask color.
- If a screenshot cannot be visually verified, remove the Markdown reference or disclose the debt explicitly in the PR.

## Microsoft Learn URL Locale

All `learn.microsoft.com` URLs SHOULD use the `en-us` locale prefix.

Canonical form:

```text
https://learn.microsoft.com/en-us/azure/{service}/...
```

Avoid locale-less URLs:

```text
https://learn.microsoft.com/azure/{service}/...
```

Reason:

- Stable reader experience.
- Stable reviewer experience.
- Easier link checking.
- Less URL drift across repositories.

## Related Projects

| Repository | Description |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines practical guide |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking practical guide |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage practical guide |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service practical guide |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions practical guide |
| [azure-communication-services-practical-guide](https://github.com/yeongseon/azure-communication-services-practical-guide) | Azure Communication Services practical guide |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps practical guide |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service (AKS) practical guide |
| [azure-architecture-practical-guide](https://github.com/yeongseon/azure-architecture-practical-guide) | Azure Architecture practical guide |
| [azure-monitoring-practical-guide](https://github.com/yeongseon/azure-monitoring-practical-guide) | Azure Monitoring practical guide |

## Content Categories

The documentation is organized by intent and lifecycle stage:

| Section | Purpose | Page Count |
|---|---|---|
| **Start Here** | Entry points, learning paths, repository map | 3 |
| **Platform** | Architecture, design decisions — WHAT and HOW Azure Monitor works | 9 |
| **Best Practices** | Production patterns — HOW to use Azure Monitor well | 8 |
| **Service Guides** | Per-service monitoring setup and configuration | 13 |
| **Operations** | Day-2 execution — HOW to run monitoring in production | 8 |
| **Troubleshooting** | Diagnosis and resolution — hypothesis-driven playbooks and KQL query packs | 29 |
| **Reference** | Quick lookup — CLI, KQL, platform limits | 5 |

!!! info "Platform vs Best Practices vs Operations"
    - **Platform** = Understand Azure Monitor architecture, data platform, and core concepts.
    - **Best Practices** = Apply practical patterns for alerting, cost control, and workspace design.
    - **Operations** = Execute day-2 tasks like rule management, data export, and workspace maintenance.

## Documentation Conventions

### File Naming

- All files: `topic-name.md` (kebab-case)
- Index files: `index.md` in each directory

### CLI Command Style

```bash
# ALWAYS use long flags for readability
az monitor log-analytics workspace create \
    --resource-group $RG \
    --workspace-name $WORKSPACE_NAME \
    --location $LOCATION

# NEVER use short flags in documentation
az monitor log-analytics workspace create -g $RG -n $WORKSPACE_NAME  # ❌ Don't do this
```

### Variable Naming Convention

| Variable | Description | Example |
|----------|-------------|---------|
| `$RG` | Resource group name | `rg-monitoring-demo` |
| `$WORKSPACE_NAME` | Log Analytics workspace name | `law-demo-001` |
| `$WORKSPACE_ID` | Log Analytics workspace resource ID | `/subscriptions/.../workspaces/law-demo-001` |
| `$APP_INSIGHTS_NAME` | Application Insights resource name | `appi-demo-001` |
| `$LOCATION` | Azure region | `koreacentral` |
| `$SUBSCRIPTION_ID` | Subscription identifier placeholder | `<subscription-id>` |
| `$ACTION_GROUP_NAME` | Action group name | `ag-oncall-team` |
| `$ALERT_RULE_NAME` | Alert rule name | `alert-high-cpu` |
| `$DCR_NAME` | Data collection rule name | `dcr-vm-perf` |

### PII Removal (Quality Gate)

**CRITICAL**: All CLI output examples MUST have PII removed.

**Must mask (real Azure identifiers):**

- Subscription IDs: `<subscription-id>`
- Tenant IDs: `<tenant-id>`
- Object IDs: `<object-id>`
- Resource IDs containing real subscription/tenant
- Emails: Remove or mask as `user@example.com`
- Secrets/Tokens: NEVER include
- Connection strings: Replace with `<connection-string>`

**OK to keep (synthetic example values):**

- Demo correlation IDs: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`
- Example request IDs in logs
- Placeholder domains: `example.com`, `contoso.com`
- Sample resource names used consistently in docs

The goal is to prevent leaking **real Azure account information**, not to mask obviously-fake example values that aid readability.

### Admonition Indentation Rule

For MkDocs admonitions (`!!!` / `???`), every line in the body must be indented by **4 spaces**.

```markdown
!!! warning "Important"
    This line is correctly indented.

    - List item also inside
```

### Mermaid Diagrams

See `## Mermaid Diagrams` above (part of the Series-Wide Documentation Contract). Repository-specific orientation and diagram-type guidance is preserved in that section.

### Nested List Indentation

All nested list items MUST use **4-space indent** (Python-Markdown standard).

```markdown
# CORRECT (4-space)
1. **Item**
    - Sub item
    - Another sub item
        - Third level

# WRONG (2 or 3 spaces)
1. **Item**
  - Sub item          ← 2 spaces ❌
   - Sub item         ← 3 spaces ❌
```

### Tail Section Naming

Every document ends with these tail sections (in this order):

| Section | Purpose | Content |
|---|---|---|
| `## See Also` | Internal cross-links within this repository | Links to other pages in this guide |
| `## Sources` | External authoritative references | Links to Microsoft Learn (primary) |

- `## See Also` is required on every page.
- `## Sources` is required on every page and must cite Microsoft Learn references.
- Order is always `## See Also` → `## Sources` (never reversed).
- All content must be based on Microsoft Learn with cited sources.

### Canonical Document Templates

Every document follows one of 5 templates based on its section. Do not invent new structures.

#### Platform docs

```text
# Title
Brief introduction (1-2 sentences)

## Architecture Overview
[Mermaid diagram showing component relationships]
[Detailed explanation of architecture]

## Core Concepts
### Concept 1
[Explanation with CLI examples]

### Concept 2
[Explanation with CLI examples]

## Data Flow
[How data moves through the system]

## Integration Points
[How this component connects to others]

## Configuration Options
[Key settings with CLI examples]

## Pricing Considerations
[Cost factors and optimization tips]

## Limitations and Quotas
[Platform limits to be aware of]

## Advanced Topics (optional)
## See Also
## Sources
```

**Platform page requirements:**
- Minimum 1 Mermaid diagram
- Minimum 3 CLI examples with output
- Must explain WHAT, HOW, and WHY

#### Best Practices docs

```text
# Title
Brief introduction (1-2 sentences)

## Why This Matters
[Business impact and risk context]

## Prerequisites
[Required resources and permissions]

## Recommended Practices
### Practice 1: [Name]
**Why**: [Rationale]
**How**: [CLI commands with output]
**Validation**: [How to verify]

### Practice 2: [Name]
[Same structure]

## Common Mistakes / Anti-Patterns
### Anti-Pattern 1: [Name]
**What happens**: [Symptom]
**Why it's wrong**: [Impact]
**Correct approach**: [Fix with CLI]

## Validation Checklist
- [ ] Item 1
- [ ] Item 2

## Cost Impact
[How these practices affect billing]

## See Also
## Sources
```

**Best Practices page requirements:**
- Each practice must include CLI examples
- Must include anti-patterns section
- Must include validation checklist

#### Operations docs

```text
# Title
Brief introduction (1-2 sentences)

## Prerequisites
[Required resources, permissions, tools]

## When to Use
[Scenarios that trigger this operation]

## Procedure
### Step 1: [Action]
```bash
# CLI command with --long-flags
```
[Expected output]
[Explanation]

### Step 2: [Action]
[Same structure]

## Verification
[How to confirm the operation succeeded]

## Rollback / Troubleshooting
[What to do if something goes wrong]

## Automation
[Scripting and scheduling options]

## See Also
## Sources
```

**Operations page requirements:**
- Step-by-step procedures with CLI
- Must include verification steps
- Must include rollback guidance

#### Playbooks

```text
# Title

## 1. Summary
[1-2 paragraph description of the symptom]
[When this playbook applies]

## 2. Common Misreadings
| Observation | Often Misread As | Actually Means |
|---|---|---|
| [Symptom] | [Wrong interpretation] | [Correct interpretation] |

## 3. Competing Hypotheses
| Hypothesis | Likelihood | Key Discriminator |
|---|---|---|
| [Cause 1] | High/Medium/Low | [How to prove/disprove] |

## 4. What to Check First
1. [Quick check with CLI command]
2. [Another quick check]

## 5. Evidence to Collect
### 5.1 KQL Queries
```kusto
// Query title
[KQL query]
```

| Column1 | Column2 | Interpretation |
|---|---|---|
| [Sample] | [Data] | [What it means] |

!!! tip "How to Read This"
    [Interpretation guide]

### 5.2 CLI Investigation
```bash
# Investigation command
```
[Sample output]
[Interpretation]

## 6. Validation and Disproof by Hypothesis
### Hypothesis 1: [Name]
**Proves if**: [Condition]
**Disproves if**: [Condition]
[CLI/KQL to test]

## 7. Likely Root Cause Patterns
| Pattern | Evidence | Resolution |
|---|---|---|
| [Cause] | [What you'll see] | [How to fix] |

## 8. Immediate Mitigations
1. [Quick fix 1]
2. [Quick fix 2]

## 9. Prevention (optional)
[Long-term fixes]

## See Also
## Sources
```

**Playbook requirements:**
- ALL 9 numbered sections required
- Minimum 2 KQL queries with sample output
- Minimum 2 CLI investigation commands
- Tables for hypotheses and evidence interpretation

#### Reference docs

```text
# Title
Brief introduction (1-2 sentences)

## Prerequisites (optional)
[Required context]

## Command Reference / Data Tables
### Category 1
[Commands or data with examples]

### Category 2
[Commands or data with examples]

## Usage Notes
[Important considerations]

## See Also
## Sources
```

**Reference page requirements:**
- Comprehensive coverage
- Consistent table formatting
- Copy-paste ready examples

## Content Source Requirements

### 1. MSLearn-First Policy

All content MUST be traceable to official Microsoft Learn documentation:

- Platform content: MUST have direct MSLearn source URLs
- Architecture diagrams: MUST reference official Microsoft documentation
- Troubleshooting playbooks: MAY synthesize MSLearn content with clear attribution
- Self-generated content: MUST have justification explaining the source basis

### 2. Source Types

| Type | Description | Allowed? |
|---|---|---|
| `mslearn` | Directly from Microsoft Learn | Required for platform content |
| `mslearn-adapted` | MSLearn content adapted for this guide | Allowed with source URL |
| `self-generated` | Original content for this guide | Requires justification |
| `community` | From community sources | Not for core content |
| `unknown` | Source not documented | Must be validated |

### 3. Diagram Source Documentation

Every Mermaid diagram MUST have source metadata in frontmatter:

```yaml
content_sources:
  diagrams:
    - id: architecture-overview
      type: flowchart
      source: mslearn
      mslearn_url: https://learn.microsoft.com/en-us/azure/azure-monitor/
    - id: troubleshooting-flow
      type: flowchart
      source: self-generated
      justification: "Synthesized from Microsoft Learn articles"
      based_on:
        - https://learn.microsoft.com/en-us/azure/azure-monitor/
```

### 4. Content Validation Tracking

- See [Content Validation Status](docs/reference/content-validation-status.md) for current status
- See [Tutorial Validation Status](docs/reference/validation-status.md) for tutorial testing

### Text Content Validation

Every non-tutorial document should include a `content_validation` block in frontmatter to track the verification status of its core claims.

```yaml
---
content_sources:
  - type: mslearn-adapted
    url: https://learn.microsoft.com/azure/{service}/...
content_validation:
  status: verified  # verified | pending_review | unverified
  last_reviewed: 2026-04-12
  reviewer: agent  # agent | human
  core_claims:
    - claim: "{example claim}"
      source: https://learn.microsoft.com/azure/{service}/...
      verified: true
---
```

#### Validation Status Values

| Status | Description |
|--------|-------------|
| `verified` | All core claims have been traced to Microsoft Learn sources |
| `pending_review` | Document exists but claims need source verification |
| `unverified` | New document, no validation performed |

#### Agent Rules for Content Validation

1. When creating or modifying Platform, Best Practices, or Operations documents, add `content_validation` frontmatter.
2. List 2-5 core claims that are factual assertions (not opinions or procedures).
3. Each claim must have a Microsoft Learn source URL.
4. Set `status: verified` only when ALL core claims have verified sources.
5. Run `python3 scripts/generate_content_validation_status.py` after updates.

## Quality Gates

### Required Elements Checklist

Every page must have:

- [ ] Mermaid diagram if the page benefits from one (see `## Mermaid Diagrams` above)
- [ ] CLI examples with `--long-flags` only
- [ ] `## See Also` section with internal links
- [ ] `## Sources` section with Microsoft Learn URLs
- [ ] 4-space indentation for nested lists
- [ ] No short flags (`-g`, `-n`, etc.)
- [ ] No PII in example output

### Microsoft Learn Source Requirement

**All content must be based on Microsoft Learn documentation.**

- Primary source: `https://learn.microsoft.com/en-us/azure/azure-monitor/`
- Secondary sources: `https://learn.microsoft.com/en-us/azure/` (related services)
- Every page must cite at least one Microsoft Learn URL in `## Sources`

## Tutorial Validation Tracking

Every tutorial document supports **validation frontmatter** that records when and how it was last tested against a real Azure deployment.

### Frontmatter Schema

Add a `validation` block inside the YAML frontmatter (`---` fences) of any tutorial file:

```yaml
---
hide:
  - toc
validation:
  az_cli:
    last_tested: 2026-04-09
    cli_version: "2.83.0"
    result: pass
  bicep:
    last_tested: null
    result: not_tested
---
```

### Agent Rules for Validation

1. **After deploying a tutorial end-to-end**, add or update the `validation` frontmatter with the current date, CLI version, and `result: pass`.
2. **If a tutorial step fails during validation**, set `result: fail` and note the issue.
3. **Never fabricate validation dates.** Only stamp a tutorial after actually executing all steps against a real Azure environment.
4. **After updating frontmatter**, regenerate the dashboard:
    ```bash
    python3 scripts/generate_validation_status.py
    ```
5. **Include the regenerated dashboard** (`docs/reference/validation-status.md`) in the same commit as the frontmatter change.
6. **Do not manually edit** `docs/reference/validation-status.md` — it is auto-generated.

## Build & Preview

```bash
# Install MkDocs dependencies
pip install mkdocs-material mkdocs-minify-plugin

# Build documentation (strict mode catches broken links)
mkdocs build --strict

# Local preview
mkdocs serve
```

## Git Commit Style

```text
type: short description
```

Allowed types: `feat`, `fix`, `docs`, `chore`, `refactor`

## Azure Monitor Domain Knowledge

### Key Services Covered

| Service | Purpose | Key Tables |
|---|---|---|
| Azure Monitor | Unified monitoring platform | AzureMetrics, AzureDiagnostics |
| Log Analytics | Log storage and query engine | Built-in and custom tables |
| Application Insights | APM for applications | requests, dependencies, traces, exceptions |
| Metrics | Time-series performance data | AzureMetrics |
| Alerts | Proactive notification system | (Alert rules, Action groups — components, not tables) |
| Workbooks | Interactive visualization | N/A |

### Common KQL Patterns

```kusto
// Basic log query
AzureDiagnostics
| where TimeGenerated > ago(1h)
| where Category == "ApplicationGatewayAccessLog"
| summarize count() by bin(TimeGenerated, 5m)

// Application Insights request analysis
requests
| where timestamp > ago(24h)
| summarize count(), avg(duration) by bin(timestamp, 1h)
| render timechart

// Alert history analysis
AzureDiagnostics
| where Category == "Alert"
| where TimeGenerated > ago(7d)
| summarize count() by AlertSeverity, bin(TimeGenerated, 1d)
```

### CLI Command Groups

| Command Group | Purpose |
|---|---|
| `az monitor log-analytics workspace` | Workspace management |
| `az monitor app-insights` | Application Insights |
| `az monitor metrics` | Metrics queries |
| `az monitor scheduled-query` | Scheduled query alerts |
| `az monitor action-group` | Alert action groups |
| `az monitor data-collection rule` | DCR management |
| `az monitor diagnostic-settings` | Resource diagnostics |


