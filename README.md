# Azure Monitoring Practical Guide

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

Comprehensive guide for monitoring Azure workloads — from Azure Monitor fundamentals to production operations with Log Analytics and Application Insights.

## What's Inside

| Section | Description |
|---------|-------------|
| [Start Here](https://yeongseon.github.io/azure-monitoring-practical-guide/) | Overview, learning paths, and repository map |
| [Platform](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor architecture, data platform, Log Analytics, Application Insights |
| [Best Practices](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | Workspace design, alerting strategy, cost optimization, data retention |
| [Service Guides](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | Per-service monitoring for App Service, Container Apps, Functions, AKS, VMs |
| [Operations](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | Workspace management, diagnostic settings, alert rules, workbooks |
| [Troubleshooting](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | 9 playbooks, KQL query packs, decision tree, evidence map |
| [Reference](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI cheatsheet, KQL quick reference, platform limits |

## Service Guides

- **App Service** — Platform logs, Application Insights integration, alerts and metrics
- **Container Apps** — Console logs, system logs, scaling metrics
- **Functions** — Execution logs, host metrics, invocation tracing
- **AKS** — Container Insights, Prometheus metrics, node/pod metrics
- **Virtual Machines** — Azure Monitor Agent, VM Insights, performance counters

Each guide covers: diagnostic settings, KQL queries, alerting, and dashboards.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git

# Install MkDocs dependencies
pip install mkdocs-material mkdocs-minify-plugin

# Start local documentation server
mkdocs serve
```

Visit `http://127.0.0.1:8000` to browse the documentation locally.

## KQL Query Packs

Ready-to-use KQL queries organized by category:

- **Application Insights** — Request performance, dependency failures, exception trends
- **Log Analytics** — Ingestion volume, resource health, cross-workspace queries
- **Alerts** — Alert firing history, action group failures
- **Service-Specific** — App Service diagnostics, AKS container logs

## Contributing

Contributions welcome. Please ensure:
- All CLI examples use long flags (`--resource-group`, not `-g`)
- All documents include Mermaid diagrams
- All content references Microsoft Learn with source URLs
- No PII in CLI output examples

## Related Projects

| Repository | Description |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines practical guide |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking practical guide |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage practical guide |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service practical guide |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions practical guide |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps practical guide |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service practical guide |

## Disclaimer

This is an independent community project. Not affiliated with or endorsed by Microsoft. Azure and Azure Monitor are trademarks of Microsoft Corporation.

## License

[MIT](LICENSE)
