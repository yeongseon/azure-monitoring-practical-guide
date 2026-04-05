# Functions Monitoring

Monitoring Azure Functions execution and performance.

```mermaid
graph TB
    subgraph "Azure Functions"
        A[Function App]
        B[Functions]
    end
    
    subgraph "Telemetry"
        C[Execution Logs]
        D[Application Insights]
        E[Host Metrics]
    end
    
    A --> B
    B --> C & D
    A --> E
```

## In This Section

| Page | Description |
|------|-------------|
| [Observability](observability.md) | Execution logs, Application Insights bindings, host metrics, invocation tracing |

## See Also

- [Platform: Application Insights](../../platform/application-insights.md)
- [Service Guides: App Service](../app-service/index.md)

## Sources

- [Monitor Azure Functions](https://learn.microsoft.com/azure/azure-functions/functions-monitoring)
- [Analyze Azure Functions telemetry in Application Insights](https://learn.microsoft.com/azure/azure-functions/analyze-telemetry-data)
