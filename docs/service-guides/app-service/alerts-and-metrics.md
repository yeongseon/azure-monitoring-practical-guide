# Alerts and Metrics

Azure App Service provides a rich set of platform metrics that help you monitor the health and performance of your application. You can use these metrics to create alert rules that notify you of issues in real-time.

## Data Flow Diagram

```mermaid
graph TD
    Resource[Azure App Service] -->|Push| MetricsStore[Azure Monitor Metrics Store]
    MetricsStore -->|Aggregation| Dashboards[Azure Portal Dashboards]
    MetricsStore -->|Rule Evaluation| AlertEngine[Azure Monitor Alert Engine]
    AlertEngine -->|Trigger| ActionGroup[Action Groups (Email, SMS, Webhook)]
```

## Key Metrics for App Service

The following platform metrics are critical for monitoring App Service performance:

- **Http5xx**: Number of HTTP requests resulting in a 5xx server error.
- **AverageResponseTime**: Time taken for the app to serve requests.
- **CpuPercentage**: CPU utilization of the App Service plan instances.
- **MemoryPercentage**: Memory utilization of the App Service plan instances.
- **Requests**: Total number of HTTP requests processed.

## Configuration Examples

### Creating an Alert Rule via CLI

The following command creates a metric alert rule that triggers when the HTTP 5xx error count exceeds 10 in a 5-minute period.

```bash
az monitor metrics alert create \
    --name "High-HTTP-5xx-Errors" \
    --resource-group "my-resource-group" \
    --scopes "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{appName}" \
    --condition "count Http5xx > 10" \
    --window-size "5m" \
    --evaluation-frequency "1m" \
    --description "Alert when HTTP 5xx errors are high" \
    --action "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/actionGroups/{actionGroupName}"
```

## KQL Query Examples

While metrics are used for alerting, you can also query them using KQL in the `AzureMetrics` table if you have enabled metric export in diagnostic settings.

### Query High CPU Utilization

Identify instances within an App Service Plan experiencing high CPU usage.

```kusto
AzureMetrics
| where MetricName == "CpuPercentage"
| summarize AverageCpu = avg(Average) by ResourceInstance, bin(TimeGenerated, 5m)
| where AverageCpu > 80
| render timechart
```

### Analyze Response Time Spikes

Compare average response times across different time intervals.

```kusto
AzureMetrics
| where MetricName == "AverageResponseTime"
| summarize avg(Average) by bin(TimeGenerated, 15m)
| render timechart
```

## See Also

- [Platform Logs](platform-logs.md)
- [Application Insights Integration](application-insights-integration.md)

## Sources

- [Monitor Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/monitor-app-service)
- [Create metrics alerts](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-metric)
- [App Service Plan metrics](https://learn.microsoft.com/en-us/azure/app-service/web-sites-monitor#metrics-granularity-and-retention-policy)
