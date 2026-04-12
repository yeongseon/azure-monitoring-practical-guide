# Azure Monitoring 実務ガイド

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

Azure Monitor の基礎から Log Analytics と Application Insights を活用した本番運用まで、Azure ワークロードのモニタリングに関する包括的なガイドです。

## 主な内容

| セクション | 説明 |
|---------|-------------|
| [ここから開始 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/) | 概要、学習パス、およびリポジトリマップ |
| [プラットフォーム (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor アーキテクチャ、データプラットフォーム、Log Analytics、Application Insights |
| [ベストプラクティス (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | ワークスペース設計、アラート戦略、コスト最適化、データ保持 |
| [サービスガイド (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service、Container Apps、Functions、AKS、VM のサービス別モニタリング |
| [運用 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | ワークスペース管理、診断設定、アラートルール、ワークブック |
| [トラブルシューティング (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | 9 個のプレイブック、KQL クエリパック、決定木、エビデンスマップ |
| [リファレンス (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI チートシート、KQL クイックリファレンス、プラットフォームの制限 |

## サービスガイド

- **App Service** — プラットフォームログ、Application Insights 統合、アラートとメトリクス
- **Container Apps** — コンソールログ、システムログ、スケーリングメトリクス
- **Functions** — 実行ログ、ホストメトリクス、呼び出しトレーシング
- **AKS** — Container Insights、Prometheus メトリクス、ノード/ポッドメトリクス
- **Virtual Machines** — Azure Monitor Agent、VM Insights、パフォーマンスカウンター

各ガイドでは、診断設定、KQL クエリ、アラート、およびダッシュボードについて説明します。

## クイックスタート

```bash
# リポジトリをクローン
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git

# MkDocs の依存関係をインストール
pip install mkdocs-material mkdocs-minify-plugin

# ローカルドキュメントサーバーを起動
mkdocs serve
```

ローカルで `http://127.0.0.1:8000` にアクセスしてドキュメントを閲覧してください。

## KQL クエリパック

カテゴリ別に整理されたすぐに使える KQL クエリ：

- **Application Insights** — リクエストパフォーマンス、依存関係の失敗、例外の傾向
- **Log Analytics** — インジェストボリューム、リソースヘルス、クロスワークスペースクエリ
- **アラート** — アラート発火履歴、アクショングループの失敗
- **サービス別** — App Service 診断、AKS コンテナログ

## 貢献

貢献を歓迎します。以下の点を確認してください：
- すべての CLI の例で長いフラグを使用してください (`-g` ではなく `--resource-group`)
- すべてのドキュメントに Mermaid ダイアグラムを含めてください
- すべてのコンテンツは、ソース URL とともに Microsoft Learn を参照してください
- CLI 出力の例に個人情報 (PII) を含めないでください

## 関連プロジェクト

| リポジトリ | 説明 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 実務ガイド |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 実務ガイド |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 実務ガイド |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 実務ガイド |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 実務ガイド |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 実務ガイド |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service 実務ガイド |

## 免責事項

これは独立したコミュニティプロジェクトです。Microsoft との提携や承認を受けているものではありません。Azure および Azure Monitor は Microsoft Corporation の商標です。

## ライセンス

[MIT](LICENSE)
