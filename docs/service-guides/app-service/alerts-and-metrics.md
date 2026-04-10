---
content_sources:
  diagrams:
    - id: data-flow-diagram
      type: flowchart
      source: mslearn-adapted
      based_on:
        - https://learn.microsoft.com/en-us/azure/app-service/monitor-app-service
        - https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-metric
        - https://learn.microsoft.com/en-us/azure/app-service/web-sites-monitor#metrics-granularity-and-retention-policy
---

# Alerts and Metrics

Azure App Service provides a rich set of platform metrics that help you monitor the health and performance of your application. You can use these metrics to create alert rules that notify you of issues in real-time.

## Data Flow Diagram

<!-- diagram-id: data-flow-diagram -->
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

### Compare Error Rate With Total Traffic

If metric export is enabled, compare `Http5xx` to total request volume before deciding whether a short spike warrants paging.

```kusto
let Requests =
    AzureMetrics
    | where TimeGenerated > ago(1h)
    | where MetricName == "Requests"
    | summarize TotalRequests=sum(Total) by bin(TimeGenerated, 5m);
let Errors =
    AzureMetrics
    | where TimeGenerated > ago(1h)
    | where MetricName == "Http5xx"
    | summarize TotalErrors=sum(Total) by bin(TimeGenerated, 5m);
Requests
| join kind=leftouter Errors on TimeGenerated
| extend TotalErrors = coalesce(TotalErrors, 0)
| extend ErrorRate = todouble(TotalErrors) / iff(TotalRequests == 0, 1, todouble(TotalRequests)) * 100
| project TimeGenerated, TotalRequests, TotalErrors, ErrorRate
| order by TimeGenerated asc
```

### Find Apps Near Memory Limits

```kusto
AzureMetrics
| where TimeGenerated > ago(2h)
| where MetricName == "MemoryPercentage"
| summarize AvgMemory=avg(Average), PeakMemory=max(Maximum) by Resource, bin(TimeGenerated, 15m)
| where PeakMemory > 85
| order by PeakMemory desc
```

Sample output:

```text
TimeGenerated              Resource                     AvgMemory  PeakMemory
-------------------------  ---------------------------  ---------  ----------
2026-04-06T00:45:00Z       my-app-service-plan-prod    78.4       91.2
2026-04-06T01:00:00Z       my-app-service-plan-prod    80.7       93.8
```

## Monitoring Baseline

For App Service, start with a small set of metrics that directly map to user impact and capacity:

- **Availability / customer impact**
    - `Http5xx`
    - `Requests`
    - `AverageResponseTime`
- **Capacity / scaling pressure**
    - `CpuPercentage`
    - `MemoryPercentage`
    - `DiskQueueLength` if the workload depends on storage-intensive operations
- **Deployment confidence**
    - Traffic trend after deployment
    - Restart count or instance churn from logs and activity history

The main rule is to alert on sustained conditions, not single-minute spikes. App Service plans can absorb short bursts that do not justify an incident.

## Verify Available Metrics Before Creating Alerts

### List metric definitions

```bash
az monitor metrics list-definitions \
    --resource "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Web/sites/my-app-service" \
    --output table
```

Sample output:

```text
Name                   PrimaryAggregationType    Unit
---------------------  ------------------------  ------------
Requests               Total                     Count
Http5xx                Total                     Count
AverageResponseTime    Average                   Seconds
CpuTime                Total                     Seconds
MemoryWorkingSet       Average                   Bytes
```

### Query recent metric values

```bash
az monitor metrics list \
    --resource "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Web/sites/my-app-service" \
    --metric "Http5xx" "AverageResponseTime" \
    --interval "PT5M" \
    --aggregation "Total" "Average"
```

Sample output:

```json
{
  "cost": 0,
  "timespan": "2026-04-06T00:00:00Z/2026-04-06T01:00:00Z",
  "value": [
    {
      "name": { "value": "Http5xx" },
      "timeseries": [
        {
          "data": [
            { "timeStamp": "2026-04-06T00:55:00Z", "total": 0 },
            { "timeStamp": "2026-04-06T01:00:00Z", "total": 12 }
          ]
        }
      ]
    }
  ]
}
```

## Practical Alert Rules

### Alert on sustained HTTP 5xx failures

Use this as the first production alert because it directly correlates with failed user requests.

```bash
az monitor metrics alert create \
    --name "appsvc-http5xx-sustained" \
    --resource-group "my-resource-group" \
    --scopes "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Web/sites/my-app-service" \
    --condition "total Http5xx > 20" \
    --window-size "5m" \
    --evaluation-frequency "1m" \
    --severity 2 \
    --description "App Service is returning sustained HTTP 5xx responses" \
    --action "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Insights/actionGroups/ag-app-oncall"
```

### Alert on high average response time

```bash
az monitor metrics alert create \
    --name "appsvc-latency-high" \
    --resource-group "my-resource-group" \
    --scopes "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Web/sites/my-app-service" \
    --condition "avg AverageResponseTime > 2" \
    --window-size "10m" \
    --evaluation-frequency "5m" \
    --severity 3 \
    --description "Average response time is above 2 seconds" \
    --action "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Insights/actionGroups/ag-app-oncall"
```

### Alert on App Service plan CPU pressure

Plan-level alerts help when multiple apps share the same compute resources.

```bash
az monitor metrics alert create \
    --name "appsvc-plan-cpu-high" \
    --resource-group "my-resource-group" \
    --scopes "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Web/serverfarms/my-app-service-plan" \
    --condition "avg CpuPercentage > 80" \
    --window-size "15m" \
    --evaluation-frequency "5m" \
    --severity 2 \
    --description "App Service plan CPU usage is above 80 percent" \
    --action "/subscriptions/<subscription-id>/resourceGroups/my-resource-group/providers/Microsoft.Insights/actionGroups/ag-platform-oncall"
```

## Alert Tuning Guidance

- **Use app-level alerts** for request failures and latency.
- **Use plan-level alerts** for CPU and memory saturation across shared apps.
- **Use severity 2** for customer-impacting failures.
- **Use severity 3 or 4** for early warning signals such as latency growth.
- Combine metrics with platform logs or Application Insights during triage instead of creating too many overlapping rules.

## Triage Workflow

When a metric alert fires, review evidence in this order:

1. **Requests and failures**
    - Did traffic increase?
    - Is the error count material or just one instance?
2. **Latency**
    - Are users seeing slow responses before outright failures?
3. **Plan capacity**
    - Is the problem isolated to one app or the whole plan?
4. **Application telemetry**
    - Do dependency failures or exceptions explain the metric spike?
5. **Platform logs**
    - Was there a restart, deployment, or storage issue?

## Workbook Suggestions

For each production app, create a dashboard or workbook with these tiles:

- Requests and `Http5xx` trend for the last 24 hours
- `AverageResponseTime` percentile trend after deployments
- CPU and memory by App Service plan instance
- Deployment markers from Activity Log or release pipeline events
- Drill-through links to Application Insights request and exception queries

## Common Mistakes

- Alerting on `Requests == 0` for apps that do not receive continuous traffic
- Using only plan-level CPU alerts and missing app-specific failures
- Treating single-minute `Http5xx` bursts as incidents without checking traffic volume
- Creating separate alerts for every metric without a triage runbook

## See Also

- [Platform Logs](platform-logs.md)
- [Application Insights Integration](application-insights-integration.md)

## Sources

- [Monitor Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/monitor-app-service)
- [Create metrics alerts](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-metric)
- [App Service Plan metrics](https://learn.microsoft.com/en-us/azure/app-service/web-sites-monitor#metrics-granularity-and-retention-policy)
