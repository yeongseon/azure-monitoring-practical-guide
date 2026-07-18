# Azure Monitoring 実務ガイド

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

📘 ドキュメントサイト: <https://yeongseon.github.io/azure-monitoring-practical-guide/>

[![Docs](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml)
[![CI](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Azure Monitor の基礎から Log Analytics と Application Insights を活用した本番運用まで、Azure ワークロードのモニタリングに関する包括的なガイドです。

## 主な内容

| セクション | 説明 | ステータス |
|---------|-------------|--------|
| [ここから開始 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/start-here/) | Azure オブザーバビリティの概要、学習パス、およびリポジトリマップ | 包括的 |
| [プラットフォーム (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor アーキテクチャの深掘り：データプラットフォーム、Log Analytics、および Application Insights | 包括的 |
| [ベストプラクティス (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | アラート戦略、コスト最適化、およびデータ保持のための本番環境向け設計 | 包括的 |
| [サービスガイド (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service、Container Apps、Functions、AKS、および VM のサービス別モニタリング設定 | 包括的 |
| [運用 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | 診断設定、アラートルール、および対話型ワークブック管理のための運用ガイド | 包括的 |
| [トラブルシューティング (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | KQL クエリパック、決定木、およびエビデンスマップを含む診断プレイブック | 包括的 |
| [リファレンス (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI チートシート、KQL クイックリファレンス、およびプラットフォーム制限のクイックルックアップ | 包括的 |

**ステータス凡例**: **ラボ検証済み (Lab-validated)** = 包括的 + 再現可能なラボによるガイダンスの検証済み · **包括的 (Comprehensive)** = セクション全体が完成、MSLearn 検証済み、本番環境対応 · **公開済み (Published)** = コアコンテンツは完成、拡張中 · **進行中 (In progress)** = コンテンツの一部が完成、活発に開発中 · **計画中 (Planned)** = プレースホルダー、コンテンツ未着手

## サービスガイド

主要な Azure サービスに合わせたモニタリング設定：
- **App Service**: プラットフォームログと Application Insights 統合
- **Container Apps**: コンソール/システムログとスケーリングメトリクス
- **Functions**: 実行ログと呼び出しトレーシング
- **AKS**: Container Insights と管理型 Prometheus メトリクス
- **Virtual Machines**: Azure Monitor Agent (AMA) と VM Insights

## クイックスタート

```bash
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git
cd azure-monitoring-practical-guide

python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements-docs.txt

mkdocs serve
```

ローカルで `http://127.0.0.1:8000` にアクセスしてドキュメントを閲覧してください。

## 貢献

貢献を歓迎します！以下の点については [貢献ガイド](https://yeongseon.github.io/azure-monitoring-practical-guide/contributing/) を参照してください：

- リポジトリ構造とコンテンツ構成
- ドキュメントテンプレートと執筆標準
- ローカル開発環境のセットアップとビルド検証
- プルリクエストプロセス

## 関連プロジェクト

| リポジトリ | 説明 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 実務ガイド |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 実務ガイド |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 実務ガイド |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 実務ガイド |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 実務ガイド |
| [azure-communication-services-practical-guide](https://github.com/yeongseon/azure-communication-services-practical-guide) | Azure Communication Services 実務ガイド |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 実務ガイド |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service (AKS) 実務ガイド |
| [azure-architecture-practical-guide](https://github.com/yeongseon/azure-architecture-practical-guide) | Azure Architecture 実務ガイド |
| [azure-monitoring-practical-guide](https://github.com/yeongseon/azure-monitoring-practical-guide) | Azure Monitoring 実務ガイド |

## 免責事項

これは独立したコミュニティプロジェクトです。Microsoft との提携や承認を受けているものではありません。Azure および Azure Monitor は Microsoft Corporation の商標です。

## ライセンス

[MIT](LICENSE)
