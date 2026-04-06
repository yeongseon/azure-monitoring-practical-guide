# AGENTS.md

Guidance for AI agents working in this repository.

## Project Overview

**Azure Monitoring Practical Guide** — a unified documentation hub for implementing, operating, and troubleshooting Azure Monitor, Log Analytics, Application Insights, and related observability services.

- **Live site**: <https://yeongseon.github.io/azure-monitoring-practical-guide/>
- **Repository**: <https://github.com/yeongseon/azure-monitoring-practical-guide>

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

All architectural diagrams use Mermaid. Every documentation page should include at least one diagram. Test with `mkdocs build --strict`.

Common diagram types for Azure Monitor:

- Data flow diagrams (sources → workspace → consumers)
- Alert processing pipelines
- DCR routing topology
- Workspace federation patterns

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
- 400-600 lines
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
- 250-350 lines
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
- 250-350 lines
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
- 380-480 lines
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

## Quality Gates

### Line Count Requirements

| Section | Minimum Lines | Target Lines |
|---|---|---|
| Platform | 300 | 400-600 |
| Best Practices | 200 | 250-350 |
| Operations | 200 | 250-350 |
| Playbooks | 350 | 380-480 |
| Reference | 100 | 150-300 |

### Required Elements Checklist

Every page must have:

- [ ] At least one Mermaid diagram (except Reference pages)
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
| Log Analytics | Log storage and query engine | All custom tables |
| Application Insights | APM for applications | requests, dependencies, traces, exceptions |
| Metrics | Time-series performance data | AzureMetrics |
| Alerts | Proactive notification system | Alert rules, Action groups |
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

// Alert correlation
AlertEvidence
| where TimeGenerated > ago(7d)
| join kind=inner (AlertInfo) on AlertId
| summarize count() by Severity, bin(TimeGenerated, 1d)
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

## Related Projects

| Repository | Description |
|---|---|
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service practical guide |
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines practical guide |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking practical guide |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps practical guide |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage practical guide |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions practical guide |
