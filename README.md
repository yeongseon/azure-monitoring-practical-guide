# Azure Monitoring Practical Guide

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

Comprehensive guide for monitoring Azure workloads — from Azure Monitor fundamentals to production operations with Log Analytics and Application Insights.

## What's Inside

| Section | Description |
|---------|-------------|
| [Start Here](https://yeongseon.github.io/azure-monitoring-practical-guide/start-here/) | Overview, learning paths, and repository map for Azure observability |
| [Platform](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Deep dive into Azure Monitor architecture: data platform, Log Analytics, and Application Insights |
| [Best Practices](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | Production-ready design for alerting strategy, cost optimization, and data retention |
| [Service Guides](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | Per-service monitoring setup for App Service, Container Apps, Functions, AKS, and VMs |
| [Operations](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | Day-2 guide for managing diagnostic settings, alert rules, and interactive workbooks |
| [Troubleshooting](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | Diagnosis playbooks with KQL query packs, decision trees, and evidence maps |
| [Reference](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | Quick-lookup CLI cheatsheet, KQL quick reference, and platform limits |

## Service Guides

Tailored monitoring configurations for key Azure services:
- **App Service**: Platform logs and Application Insights integration
- **Container Apps**: Console/system logs and scaling metrics
- **Functions**: Execution logs and invocation tracing
- **AKS**: Container Insights and managed Prometheus metrics
- **Virtual Machines**: Azure Monitor Agent (AMA) and VM Insights

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

## Contributing

Contributions welcome! Please see our [Contributing Guide](https://yeongseon.github.io/azure-monitoring-practical-guide/contributing/) for:

- Repository structure and content organization
- Document templates and writing standards
- Local development setup and build validation
- Pull request process

## Related Projects

| Repository | Description |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines practical guide |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking practical guide |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage practical guide |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service practical guide |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions practical guide |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps practical guide |
| [azure-communication-services-practical-guide](https://github.com/yeongseon/azure-communication-services-practical-guide) | Azure Communication Services practical guide |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service (AKS) practical guide |
| [azure-architecture-practical-guide](https://github.com/yeongseon/azure-architecture-practical-guide) | Azure Architecture practical guide |

## Disclaimer

This is an independent community project. Not affiliated with or endorsed by Microsoft. Azure and Azure Monitor are trademarks of Microsoft Corporation.

## License

[MIT](LICENSE)

