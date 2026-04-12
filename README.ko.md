# Azure Monitoring 실무 가이드

[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

Azure Monitor 기초부터 Log Analytics 및 Application Insights를 활용한 운영 환경까지, Azure 워크로드 모니터링을 위한 포괄적인 가이드입니다.

## 주요 내용

| 섹션 | 설명 |
|---------|-------------|
| [시작하기 (Start Here)](https://yeongseon.github.io/azure-monitoring-practical-guide/) | 개요, 학습 경로 및 저장소 맵 |
| [플랫폼 (Platform)](https://yeongseon.github.io/azure-monitoring-practical-guide/platform/) | Azure Monitor 아키텍처, 데이터 플랫폼, Log Analytics, Application Insights |
| [베스트 프랙티스 (Best Practices)](https://yeongseon.github.io/azure-monitoring-practical-guide/best-practices/) | 작업 영역 설계, 알림 전략, 비용 최적화, 데이터 보존 |
| [서비스 가이드 (Service Guides)](https://yeongseon.github.io/azure-monitoring-practical-guide/service-guides/) | App Service, Container Apps, Functions, AKS, VM별 모니터링 |
| [운영 (Operations)](https://yeongseon.github.io/azure-monitoring-practical-guide/operations/) | 작업 영역 관리, 진단 설정, 경고 규칙, 워크북 |
| [트러블슈팅 (Troubleshooting)](https://yeongseon.github.io/azure-monitoring-practical-guide/troubleshooting/) | 9개의 플레이북, KQL 쿼리 팩, 의사 결정 트리, 증거 맵 |
| [참조 (Reference)](https://yeongseon.github.io/azure-monitoring-practical-guide/reference/) | CLI 치트시트, KQL 빠른 참조, 플랫폼 제한 사항 |

## 서비스 가이드

- **App Service** — 플랫폼 로그, Application Insights 통합, 알림 및 메트릭
- **Container Apps** — 콘솔 로그, 시스템 로그, 스케일링 메트릭
- **Functions** — 실행 로그, 호스트 메트릭, 호출 추적
- **AKS** — Container Insights, Prometheus 메트릭, 노드/파드 메트릭
- **Virtual Machines** — Azure Monitor Agent, VM Insights, 성능 카운터

각 가이드는 진단 설정, KQL 쿼리, 알림, 대시보드를 다룹니다.

## 빠른 시작

```bash
# 저장소 복제
git clone https://github.com/yeongseon/azure-monitoring-practical-guide.git

# MkDocs 의존성 설치
pip install mkdocs-material mkdocs-minify-plugin

# 로컬 문서 서버 시작
mkdocs serve
```

로컬에서 `http://127.0.0.1:8000`에 접속하여 문서를 확인하세요.

## KQL 쿼리 팩

카테고리별로 정리된 바로 사용 가능한 KQL 쿼리:

- **Application Insights** — 요청 성능, 종속성 실패, 예외 추세
- **Log Analytics** — 수집 볼륨, 리소스 상태, 교차 작업 영역 쿼리
- **알림** — 알림 발생 이력, 작업 그룹 실패
- **서비스별** — App Service 진단, AKS 컨테이너 로그

## 기여하기

기여는 언제나 환영합니다. 다음 사항을 준수해 주세요:
- 모든 CLI 예제에는 긴 플래그를 사용하세요 (`-g` 대신 `--resource-group`)
- 모든 문서에는 Mermaid 다이어그램을 포함하세요
- 모든 콘텐츠는 출처 URL과 함께 Microsoft Learn을 참조해야 합니다
- CLI 출력 예제에 개인 식별 정보(PII)를 포함하지 마세요

## 관련 프로젝트

| 저장소 | 설명 |
|---|---|
| [azure-virtual-machine-practical-guide](https://github.com/yeongseon/azure-virtual-machine-practical-guide) | Azure Virtual Machines 실무 가이드 |
| [azure-networking-practical-guide](https://github.com/yeongseon/azure-networking-practical-guide) | Azure Networking 실무 가이드 |
| [azure-storage-practical-guide](https://github.com/yeongseon/azure-storage-practical-guide) | Azure Storage 실무 가이드 |
| [azure-app-service-practical-guide](https://github.com/yeongseon/azure-app-service-practical-guide) | Azure App Service 실무 가이드 |
| [azure-functions-practical-guide](https://github.com/yeongseon/azure-functions-practical-guide) | Azure Functions 실무 가이드 |
| [azure-container-apps-practical-guide](https://github.com/yeongseon/azure-container-apps-practical-guide) | Azure Container Apps 실무 가이드 |
| [azure-aks-practical-guide](https://github.com/yeongseon/azure-aks-practical-guide) | Azure Kubernetes Service 실무 가이드 |

## 면책 조항

이 프로젝트는 독립적인 커뮤니티 프로젝트입니다. Microsoft와 제휴하거나 보증을 받지 않았습니다. Azure 및 Azure Monitor는 Microsoft Corporation의 상표입니다.

## 라이선스

[MIT](LICENSE)
