# App Service Monitoring

Monitoring Azure App Service with platform logs, Application Insights, and metrics.

```mermaid
graph TB
    subgraph "App Service"
        A[Web App]
    end
    
    subgraph "Data Collection"
        B[Platform Logs]
        C[Application Insights]
        D[Metrics]
    end
    
    subgraph "Log Analytics"
        E[AppServiceHTTPLogs]
        F[AppServiceConsoleLogs]
        G[AppServicePlatformLogs]
    end
    
    A --> B & C & D
    B --> E & F & G
```

## In This Section

| Page | Description |
|------|-------------|
| [Platform Logs](platform-logs.md) | AppServiceHTTPLogs, ConsoleLogs, PlatformLogs tables |
| [Application Insights Integration](application-insights-integration.md) | Auto-instrumentation, SDK setup, correlation |
| [Alerts and Metrics](alerts-and-metrics.md) | Key metrics, recommended alert rules |

## See Also

- [Platform: Application Insights](../../platform/application-insights.md)
- [Operations: Diagnostic Settings](../../operations/diagnostic-settings.md)

## Sources

- [Monitor App Service](https://learn.microsoft.com/azure/app-service/monitor-app-service)
- [Enable diagnostics logging for apps in Azure App Service](https://learn.microsoft.com/azure/app-service/troubleshoot-diagnostic-logs)
