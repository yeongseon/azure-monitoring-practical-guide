# Azure Monitoring 실무 가이드

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

📘 문서 사이트: <https://yeongseon.github.io/azure-monitoring-practical-guide/>

[![Docs](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/docs.yml)
[![CI](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml/badge.svg)](https://github.com/yeongseon/azure-monitoring-practical-guide/actions/workflows/validate-content-sources.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Azure Monitor 기초부터 Log Analytics 및 Application Insights를 활용한 운영 환경까지, Azure 워크로드 모니터링을 위한 포괄적인 가이드입니다.

## 주요 내용

| 섹션 | 설명 | 상태 |
|---------|-------------|--------|
| [시작하기 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/start-here/) | Azure 관찰 가능성을 위한 개요, 학습 경로 및 저장소 맵 | 포괄적 |
| [플랫폼 (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor 아키텍처 심층 분석: 데이터 플랫폼, Log Analytics 및 Application Insights | 포괄적 |
| [베스트 프랙티스 (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | 알림 전략, 비용 최적화 및 데이터 보존을 위한 운영 환경용 설계 | 포괄적 |
| [서비스 가이드 (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service, Container Apps, Functions, AKS 및 VM별 모니터링 설정 | 포괄적 |
| [운영 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | 진단 설정, 경고 규칙 및 대화형 워크북 관리를 위한 운영 가이드 | 포괄적 |
| [트러블슈팅 (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | KQL 쿼리 팩, 의사 결정 트리 및 증거 맵을 포함한 진단 플레이북 | 포괄적 |
| [참조 (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI 치트시트, KQL 빠른 참조 및 플랫폼 제한 사항 빠른 확인 | 포괄적 |

**상태 범례**: **실습 검증됨 (Lab-validated)** = 포괄적 + 재현 가능한 실습으로 가이드 검증됨 · **포괄적 (Comprehensive)** = 전체 섹션 구성 완료, MSLearn 검증됨, 운영 환경 적용 가능 · **게시됨 (Published)** = 핵심 콘텐츠 포함, 지속적으로 확장 중 · **진행 중 (In progress)** = 일부 콘텐츠 포함, 활발히 개발 중 · **계획됨 (Planned)** = 플레이스홀더 상태, 콘텐츠 시작 전

## 서비스 가이드

주요 Azure 서비스에 맞게 구성된 모니터링 설정:
- **App Service**: 플랫폼 로그 및 Application Insights 통합
- **Container Apps**: 콘솔/시스템 로그 및 스케일링 메트릭
- **Functions**: 실행 로그 및 호출 추적
- **AKS**: Container Insights 및 관리형 Prometheus 메트릭
- **Virtual Machines**: Azure Monitor Agent (AMA) 및 VM Insights

## 빠른 시작

```bash
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git
cd azure-monitoring-practical-guide

python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements-docs.txt

mkdocs serve
```

로컬에서 `http://127.0.0.1:8000`에 접속하여 문서를 확인하세요.

## 기여하기

기여는 언제나 환영합니다! 다음 사항에 대해서는 [기여 가이드](https://yeongseon.github.io/azure-monitoring-practical-guide/contributing/)를 참조하세요:

- 저장소 구조 및 콘텐츠 구성
- 문서 템플릿 및 작성 표준
- 로컬 개발 환경 설정 및 빌드 검증
- 풀 리퀘스트 프로세스

## 관련 프로젝트

| 저장소 | 설명 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 실무 가이드 |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 실무 가이드 |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 실무 가이드 |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 실무 가이드 |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 실무 가이드 |
| [azure-communication-services-practical-guide](https://github.com/yeongseon/azure-communication-services-practical-guide) | Azure Communication Services 실무 가이드 |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 실무 가이드 |
| [azure-kubernetes-service-practical-guide](https://github.com/yeongseon/azure-kubernetes-service-practical-guide) | Azure Kubernetes Service (AKS) 실무 가이드 |
| [azure-architecture-practical-guide](https://github.com/yeongseon/azure-architecture-practical-guide) | Azure Architecture 실무 가이드 |
| [azure-monitoring-practical-guide](https://github.com/yeongseon/azure-monitoring-practical-guide) | Azure Monitoring 실무 가이드 |

## 면책 조항

이 프로젝트는 독립적인 커뮤니티 프로젝트입니다. Microsoft와 제휴하거나 보증을 받지 않았습니다. Azure 및 Azure Monitor는 Microsoft Corporation의 상표입니다.

## 라이선스

[MIT](LICENSE)
