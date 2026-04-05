# App Service Diagnostics (HTTP Log Analysis)

Analyze HTTP logs for Azure App Service to identify errors, slow requests, or unusual traffic patterns. This table provides raw details about each incoming request at the infrastructure level.

## Scenario
You need to identify the top 5 client IP addresses that are causing 4xx or 5xx errors on your App Service in the last 24 hours.

## KQL Query
```kusto
AppServiceHTTPLogs
| where TimeGenerated > ago(24h)
| where Result >= 400
| summarize 
    ErrorCount = count(), 
    AvgTimeTaken = avg(TimeTaken) 
    by CIp, Result, CsMethod, CsUriStem
| order by ErrorCount desc
| take 5
```

## Data Flow
```mermaid
graph TD
    A[AppServiceHTTPLogs table] --> B[Filter by 24h]
    B --> C[Filter Result >= 400]
    C --> D[Summarize errors by Client IP]
    D --> E[Order by count]
    E --> F[Take top 5 results]
```

## Sample Output
| CIp | Result | CsMethod | CsUriStem | ErrorCount | AvgTimeTaken |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 192.168.1.5 | 404 | GET | /admin/login | 850 | 12 |
| 10.0.0.12 | 500 | POST | /api/Order | 120 | 4500 |
| 172.16.0.4 | 403 | GET | /config/internal | 85 | 5 |
| 192.168.1.20 | 503 | GET | /status | 45 | 15000 |
| 10.0.0.15 | 401 | POST | /api/Auth | 32 | 10 |

## How to Read This
A high volume of `404` errors for a specific `CsUriStem` from a single `CIp` often indicates a bot or automated scanner. `500` or `503` errors with high `AvgTimeTaken` usually point to application performance issues or downstream dependency timeouts.

## Limitations
*   HTTP logs must be explicitly enabled in the App Service diagnostic settings.
*   The `CIp` field may be obfuscated or represent a load balancer if not configured correctly.
*   Only incoming requests to the App Service are captured; outbound calls are in the `AppDependencies` or `dependencies` tables.

## See Also
*   [Performance Percentiles](../app-insights/request-performance.md)
*   [App Service Monitoring Guide](../../../service-guides/app-service/index.md)

## Sources
*   [MS Learn: AppServiceHTTPLogs table reference](https://learn.microsoft.com/azure/azure-monitor/reference/tables/appservicehttplogs)
*   [MS Learn: Monitor Azure App Service](https://learn.microsoft.com/azure/app-service/troubleshoot-diagnostic-logs)
