# AKS Monitoring

Monitoring Azure Kubernetes Service with Container Insights and Prometheus.

```mermaid
graph TB
    subgraph "AKS Cluster"
        A[Nodes]
        B[Pods]
        C[Containers]
    end
    
    subgraph "Monitoring"
        D[Container Insights]
        E[Prometheus]
        F[Managed Grafana]
    end
    
    A & B & C --> D
    D --> E --> F
```

## In This Section

| Page | Description |
|------|-------------|
| [Observability](observability.md) | Container Insights, Prometheus metrics, Managed Grafana, node/pod/container metrics |

## See Also

- [Platform: Data Collection Rules](../../platform/data-collection-rules.md)
- [Operations: Workspace Management](../../operations/workspace-management.md)

## Sources

- [Monitor Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/aks/monitor-aks)
- [Container insights overview](https://learn.microsoft.com/azure/azure-monitor/containers/container-insights-overview)
