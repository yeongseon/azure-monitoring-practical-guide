# Contributing

Thank you for your interest in contributing to Azure Monitoring Practical Guide!

## Quick Start

1. Fork the repository
2. Clone: `git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git`
3. Install dependencies: `pip install mkdocs-material mkdocs-minify-plugin`
4. Start local preview: `mkdocs serve`
5. Open `http://127.0.0.1:8000` in your browser
6. Create a feature branch: `git checkout -b feature/your-change`
7. Make changes and validate: `mkdocs build --strict`
8. Submit a Pull Request

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

| Section | Purpose | Page Count |
|---|---|---|
| **Start Here** | Entry points, learning paths, repository map | 3 |
| **Platform** | Architecture, design decisions — WHAT and HOW Azure Monitor works | 9 |
| **Best Practices** | Production patterns — HOW to use Azure Monitor well | 8 |
| **Service Guides** | Per-service monitoring setup and configuration | 13 |
| **Operations** | Day-2 execution — HOW to run monitoring in production | 8 |
| **Troubleshooting** | Diagnosis and resolution — hypothesis-driven playbooks and KQL query packs | 29 |
| **Reference** | Quick lookup — CLI, KQL, platform limits | 5 |

## Document Templates

Every document must follow the template for its section.

### Platform docs

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

### Best Practices docs

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

### Operations docs

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

### Playbooks

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

### Reference docs

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

## Writing Standards

### CLI Commands
```bash
# ALWAYS use long flags for readability
az monitor log-analytics workspace create \
    --resource-group $RG \
    --workspace-name $WORKSPACE_NAME \
    --location $LOCATION

# NEVER use short flags in documentation
az monitor log-analytics workspace create -g $RG -n $WORKSPACE_NAME  # ❌ Don't do this
```

### Variables
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

### Mermaid Diagrams
All architectural diagrams use Mermaid. Every page should include at least one diagram.

### Nested Lists
4-space indent required.

### Admonitions
4-space indent for body content.

### Tail Sections
1. `## See Also` — internal cross-links
2. `## Sources` — Microsoft Learn URLs

## Content Source Policy
All documentation content must be traceable to official Microsoft Learn documentation.

| Type | Description | Allowed? |
|---|---|---|
| `mslearn` | Directly from Microsoft Learn | Required for platform content |
| `mslearn-adapted` | MSLearn content adapted for this guide | Allowed with source URL |
| `self-generated` | Original content for this guide | Requires justification |
| `community` | From community sources | Not for core content |
| `unknown` | Source not documented | Must be validated |

## PII Rules
**CRITICAL**: All CLI output examples MUST have PII removed.

**Must mask (real Azure identifiers):**

- Subscription IDs: `<subscription-id>`
- Tenant IDs: `<tenant-id>`
- Object IDs: `<object-id>`
- Resource IDs containing real subscription/tenant
- Emails: Remove or mask as `user@example.com`
- Secrets/Tokens: NEVER include
- Connection strings: Replace with `<connection-string>`

## Build and Validate
```bash
pip install mkdocs-material mkdocs-minify-plugin
mkdocs build --strict
mkdocs serve
```

## Git Commit Style
`type: short description` — types: feat, fix, docs, chore, refactor

## Review Process
1. CI checks (MkDocs build)
2. Maintainer review
3. Merge triggers deployment

## Code of Conduct
See [CODE_OF_CONDUCT.md](https://github.com/yeongseon/azure-monitoring-practical-guide/blob/main/CODE_OF_CONDUCT.md).

## See Also
- [Repository Map](../start-here/repository-map.md)
