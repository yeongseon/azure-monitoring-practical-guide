# Azure Monitoring 实操指南

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

从 Azure Monitor 基础到使用 Log Analytics 和 Application Insights 的生产运营，监控 Azure 工作负载的全方位指南。

## 主要内容

| 章节 | 描述 |
|---------|-------------|
| [从这里开始 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/) | 概述、学习路径和仓库地图 |
| [平台 (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor 架构、数据平台、Log Analytics、Application Insights |
| [最佳实践 (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | 工作区设计、告警策略、成本优化、数据保留 |
| [服务指南 (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service、Container Apps、Functions、AKS、VM 的服务级监控 |
| [运营 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | 工作区管理、诊断设置、告警规则、工作簿 |
| [故障排除 (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | 9 个实战手册、KQL 查询包、决策树、证据图 |
| [参考 (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI 速查表、KQL 快速参考、平台限制 |

## 服务指南

- **App Service** — 平台日志、Application Insights 集成、告警和指标
- **Container Apps** — 控制台日志、系统日志、扩展指标
- **Functions** — 执行日志、主机指标、调用追踪
- **AKS** — Container Insights、Prometheus 指标、节点/Pod 指标
- **Virtual Machines** — Azure Monitor Agent、VM Insights、性能计数器

每个指南都涵盖：诊断设置、KQL 查询、告警和仪表板。

## 快速入门

```bash
# 克隆仓库
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git

# 安装 MkDocs 依赖
pip install mkdocs-material mkdocs-minify-plugin

# 启动本地文档服务器
mkdocs serve
```

访问 `http://127.0.0.1:8000` 在本地浏览文档。

## KQL 查询包

按类别组织的即用型 KQL 查询：

- **Application Insights** — 请求性能、依赖项故障、异常趋势
- **Log Analytics** — 摄取量、资源运行状况、跨工作区查询
- **告警** — 告警触发历史、操作组故障
- **服务级** — App Service 诊断、AKS 容器日志

## 贡献

欢迎贡献。请确保：
- 所有 CLI 示例使用长标记 (使用 `--resource-group` 而不是 `-g`)
- 所有文档包含 Mermaid 图表
- 所有内容参考 Microsoft Learn 并附带源 URL
- CLI 输出示例中不含个人身份信息 (PII)

## 相关项目

| 仓库 | 描述 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 实操指南 |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 实操指南 |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 实操指南 |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 实操指南 |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 实操指南 |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 实操指南 |
| [azure-aks-practical-guide](https://github.com/yeongseon/azure-aks-practical-guide) | Azure Kubernetes Service 实操指南 |

## 免责声明

这是一个独立的社区项目。与 Microsoft 无关，也不受其认可。Azure 和 Azure Monitor 是 Microsoft Corporation 的商标。

## 许可证

[MIT](LICENSE)
