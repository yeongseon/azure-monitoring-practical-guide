---
description: Author-facing capture briefs for the Monitoring portal screenshot campaign (wave 1 — platform and operations). Contributor and agent reference only; see AGENTS.md for authoritative PII rules.
---
# Monitoring Portal Capture Briefs

!!! info "Audience: contributors and agents, not readers"
    This page is an **author-facing reference** for the portal screenshot campaign tracked in [azure-container-apps-practical-guide#389](https://github.com/yeongseon/azure-container-apps-practical-guide/issues/389). It documents which Azure Monitor blades to capture for each wave-1 page, the stable `shot()` ids the pages will reference, and what each capture must show. Readers consume the captures from the platform and operations pages directly.

## Why this file exists

The series' verified baseline: portal screenshots exist only in App Service (95 pages) and AKS (8). Monitoring is the agreed next campaign because the product itself is visual — workbooks, metrics explorer, alert rules, and diagnostic settings are portal-first surfaces where a screenshot teaches more than prose.

The captures themselves will live under `docs/assets/captures/` (WebP produced by the `azure-guide-capture-toolkit` pipeline) and are referenced from markdown via the capture macro — `shot("<id>")` wrapped in the custom triple-square-bracket Jinja delimiters configured in `mkdocs.yml` (see `scripts/capture/README.md` for the exact invocation syntax; the delimiters are deliberately not written literally here because the macros plugin would render them). This page exists so a capture session on a fresh environment produces the same ids in the same order, and so the human-in-the-loop step (Conditional Access requires an interactively signed-in, device-compliant browser — see AGENTS.md → Portal Screenshot Capture) is turnkey.

## Prerequisites for a capture session

1. **Human-signed-in debug Chrome over CDP** — the agent cannot pass MFA. Launch with the dedicated debug profile from AGENTS.md, sign in interactively, navigate to the target blade; the agent attaches via `chromium.connectOverCDP('http://localhost:9222')` and applies the PII helper before screenshotting.
2. **A demonstrator environment** with at least: one Log Analytics workspace with real query history, one Application Insights resource with live traffic, at least one alert rule that has fired, and one workbook.
3. **Toolkit CLIs** (`capture-optimize-webp`, `capture-diff-gate`) available locally — see `scripts/capture/README.md`.

## Manifest registration rule

Do **not** pre-register manifest entries for captures that do not exist yet. At capture time, register each PNG/WebP in `scripts/capture/manifest.yaml` with the stable `id` proposed below (equal to the file stem), the `file` path, and accurate `alt` text. The ids below are proposals — if a blade is renamed by the Portal, keep the id stable and update the brief instead.

## Wave 1 capture matrices

Priority order = highest reader value first. Every capture must pass the PII verification checklist in AGENTS.md before the markdown reference lands.

### platform/how-azure-monitor-works.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-overview-hub` | Azure Monitor Overview (Monitor > Overview) | The three pillar tiles (Metrics, Logs, Alerts) | Hub loads with no per-resource scope |
| `mon-insights-menu` | Monitor > Insights / Virtual machines insight blade | Insight center entries (VMs, Storage, Networks) | Full insight gallery visible |

### platform/data-platform.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-platform-settings-sources` | Monitor > Settings > Data sources | Connected VMs / containers / apps counts | At least one connected source type |

### platform/metrics-and-dimensions.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-metrics-explorer` | Metrics explorer with a VM scoped `Percentage CPU` chart | Chart, namespace/metric pickers, dimension split | Live line for the chosen time range |
| `mon-metrics-dimensions-split` | Metrics explorer with `Split by` applied | Split legend rows | One series per dimension value |

### platform/log-analytics-workspace.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-workspace-overview` | Log Analytics workspace Overview | Workspace name, daily ingestion tile, query packs | Ingestion tile shows non-zero GB/day |
| `mon-workspace-tables` | Workspace > Tables (Legacy or new Logs UI) | `AzureMetrics`, `Heartbeat`, `AppRequests` rows | System + platform tables listed with retention columns |

### platform/application-insights.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-appinsights-overview` | Application Insights Overview (Application Map collapsed) | KPI tiles: requests, failures, dependency failures | Live values, not zeros |
| `mon-appinsights-live-metrics` | Live Metrics | Streaming request/dependency counts | "Live" indicator and per-second values |

### platform/alerts-architecture.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-alerts-rules-list` | Monitor > Alerts > Alert rules | Rule name, condition, severity columns | At least one enabled rule |
| `mon-alerts-fired-instance` | Alerts blade with a fired alert (Sev 2+) | Fired instance detail, condition met timestamp | Alert state "Fired", not "New" |

### platform/data-collection-rules.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-dcr-overview` | Data Collection Rule > Overview | Data sources tab, destinations association | Rule associated to ≥1 VM |
| `mon-dcr-association` | DCR > Resources | Associated machine names | Association status "Succeeded" |

### operations/diagnostic-settings.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-diag-settings-list` | Resource > Monitoring > Diagnostic settings | Setting name, destination categories | Setting streaming to the workspace |
| `mon-diag-setting-add` | Add diagnostic setting dialog | Category checkboxes, destination toggles | At least one category selected, Log Analytics destination |

### operations/workbooks-and-dashboards.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-workbook-gallery` | Monitor > Workbooks gallery | Public template gallery entries | Gallery tiles render thumbnails |
| `mon-workbook-editing` | A workbook in edit mode | Edit toolbar, + Add, pin controls | At least one text + one chart item |

### operations/alert-rule-management.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-alert-rule-create-signal` | Create alert rule > Condition tab | Signal picker with metric/log signals | Search box and signal list visible |
| `mon-alert-rule-create-action` | Create alert rule > Actions tab | Action group picker | Selected action group shown |

### operations/workspace-management.md

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-workspace-usage` | Workspace > Usage and estimated costs | Per-table ingestion chart, daily cap toggle | Non-zero per-day ingestion bars |
| `mon-workspace-access-control` | Workspace > Access control (IAM) | Role assignments list | Reader/Contributor rows with masked identities |

### operations/cost-control.md *(stretch — wave 1 close)*

| Shot id | Blade | Look for | Expected |
|---|---|---|---|
| `mon-cost-usage-breakdown` | Usage and estimated costs > Data ingestion breakdown | Per-solution ingestion split | Log Management / Agent rows present |

## Out of wave-1 scope (later waves)

- `platform/networking-and-security.md` (private-link blades — pair with the service-guides wave)
- `operations/export-and-integration.md` and `operations/data-collection-rules-ops.md` (configuration-heavy, lower visual value)
- Service Guides and Troubleshooting surfaces (wave 2+ per the #389 priority)

## See Also

- [AGENTS.md → Portal Screenshot Capture (PII Replacement Rules)](https://github.com/yeongseon/azure-monitoring-practical-guide/blob/main/AGENTS.md) — authoritative capture, PII-replacement, and CDP-session rules
- [scripts/capture/README.md](https://github.com/yeongseon/azure-monitoring-practical-guide/blob/main/scripts/capture/README.md) — manifest schema and toolkit CLI workflow
- [Azure Monitor Overview](../platform/how-azure-monitor-works.md) — first page receiving wave-1 captures
