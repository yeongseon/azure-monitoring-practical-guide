# Log Analytics Queries

KQL queries for Log Analytics workspace analysis.

```mermaid
graph LR
    A[Usage] --> B[Ingestion Volume]
    C[Heartbeat] --> D[Resource Health]
    E[workspace] --> F[Cross-Workspace]
```

## Queries

| Query | Description |
|-------|-------------|
| [Ingestion Volume](ingestion-volume.md) | Data volume by table, source, resource; cost attribution |
| [Resource Health](resource-health.md) | Heartbeat checks, agent status, data freshness |
| [Cross-Workspace](cross-workspace.md) | workspace() function patterns, union across workspaces |

## See Also

- [Platform: Log Analytics Workspace](../../../platform/log-analytics-workspace.md)
- [Application Insights Queries](../app-insights/index.md)

## Sources

- [Analyze usage in Log Analytics workspace](https://learn.microsoft.com/azure/azure-monitor/logs/analyze-usage)
- [Cross-resource query Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/logs/cross-workspace-query)
