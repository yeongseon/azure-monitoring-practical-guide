# Azure Monitoring 实操指南

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

📘 文档站点: <https://yeongseon.github.io/azure-monitoring-practical-guide/>

[![Docs](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml)
[![CI](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

从 Azure Monitor 基础到使用 Log Analytics 和 Application Insights 的生产运营，监控 Azure 工作负载的全方位指南。

## 主要内容

| 章节 | 描述 | 状态 |
|---------|-------------|--------|
| [从这里开始 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/start-here/) | Azure 可观测性概述、学习路径和仓库地图 | 全面 |
| [平台 (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | 深入了解 Azure Monitor 架构：数据平台、Log Analytics 和 Application Insights | 全面 |
| [最佳实践 (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | 告警策略、成本优化和数据保留的生产级设计 | 全面 |
| [服务指南 (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service、Container Apps、Functions、AKS 和 VM 的服务级监控设置 | 全面 |
| [运营 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | 诊断设置、告警规则和交互式工作簿管理的运营指南 | 全面 |
| [故障排除 (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | 包含 KQL 查询包、决策树和证据图的诊断实战手册 | 全面 |
| [参考 (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI 速查表、KQL 快速参考和平台限制快速查询 | 全面 |

**状态说明**: **实验室验证 (Lab-validated)** = 内容全面 + 可重复的实验室验证 · **全面 (Comprehensive)** = 章节内容完整，经过 MSLearn 验证，生产环境就绪 · **已发布 (Published)** = 核心内容已到位，仍在持续扩展 · **进行中 (In progress)** = 部分内容已完成，正在积极开发中 · **已计划 (Planned)** = 占位符状态，内容尚未开始

## 服务指南

针对关键 Azure 服务的定制监控配置：
- **App Service**: 平台日志和 Application Insights 集成
- **Container Apps**: 控制台/系统日志和扩展指标
- **Functions**: 执行日志和调用追踪
- **AKS**: Container Insights 和托管 Prometheus 指标
- **Virtual Machines**: Azure Monitor Agent (AMA) 和 VM Insights

## 快速入门

```bash
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git
cd azure-monitoring-practical-guide

python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements-docs.txt

mkdocs serve
```

访问 `http://127.0.0.1:8000` 在本地浏览文档。

## 贡献

欢迎贡献！请参阅我们的 [贡献指南](https://yeongseon.github.io/azure-monitoring-practical-guide/contributing/) 了解以下内容：

- 仓库结构和内容组织
- 文档模板和编写标准
- 本地开发环境设置和构建验证
- 拉取请求流程

## 相关项目

| 仓库 | 描述 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 实操指南 |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 实操指南 |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 实操指南 |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 实操指南 |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 实操指南 |
| [azure-communication-services-practical-guide](https://github.com/yeongseon/azure-communication-services-practical-guide) | Azure Communication Services 实操指南 |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 实操指南 |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service (AKS) 实操指南 |
| [azure-architecture-practical-guide](https://github.com/yeongseon/azure-architecture-practical-guide) | Azure Architecture 实操指南 |
| [azure-monitoring-practical-guide](https://github.com/yeongseon/azure-monitoring-practical-guide) | Azure Monitoring 实操指南 |

## 免责声明

这是一个独立的社区项目。与 Microsoft 无关，也不受其认可。Azure 和 Azure Monitor 是 Microsoft Corporation 的商标。

## 许可证

[MIT](LICENSE)
