# Troubleshooting

Diagnosis and resolution for common Azure Monitor issues.

```mermaid
graph TB
    A[Symptom] --> B{Decision Tree}
    B -->|No Data| C[No Data Playbook]
    B -->|Alert Issues| D[Alert Playbooks]
    B -->|Cost Issues| E[Cost Playbook]
    B -->|Performance| F[Query Playbook]
    
    C & D & E & F --> G[KQL Queries]
    G --> H[Resolution]
```

## Quick Navigation

| Symptom | Go To |
|---------|-------|
| Data not appearing in workspace | [No Data in Workspace](playbooks/no-data-in-workspace.md) |
| Application Insights not showing telemetry | [Missing Application Telemetry](playbooks/missing-application-telemetry.md) |
| Alert rule not firing | [Alert Not Firing](playbooks/alert-not-firing.md) |
| Too many alerts | [Alert Storm](playbooks/alert-storm.md) |
| Unexpected cost spike | [High Ingestion Cost](playbooks/high-ingestion-cost.md) |
| KQL queries timing out | [Query Performance](playbooks/query-performance.md) |
| Agent not sending data | [Agent Not Reporting](playbooks/agent-not-reporting.md) |

## In This Section

| Page | Description |
|------|-------------|
| [Decision Tree](decision-tree.md) | Symptom-based routing to playbooks |
| [Evidence Map](evidence-map.md) | What data sources to check for each symptom |
| [Playbooks](playbooks/index.md) | Step-by-step troubleshooting guides (7 playbooks) |
| [KQL Query Packs](kql/index.md) | Ready-to-use diagnostic queries (14 pages) |

## See Also

- [Operations](../operations/index.md)
- [Reference](../reference/index.md)

## Sources

- [Troubleshoot Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/troubleshoot)
- [Troubleshoot Log Analytics](https://learn.microsoft.com/azure/azure-monitor/logs/troubleshoot)
