# Decision Tree

Symptom-based routing to troubleshooting playbooks.

```mermaid
flowchart TD
    A[Start: Monitoring Issue] --> B{What's the symptom?}
    
    B -->|No data appearing| C{Where is data missing?}
    B -->|Alerts not working| D{What's the alert issue?}
    B -->|High costs| E[High Ingestion Cost]
    B -->|Slow queries| F[Query Performance]
    
    C -->|Log Analytics workspace| G{Is agent involved?}
    C -->|Application Insights| H[Missing Application Telemetry]
    
    G -->|Yes - AMA/agent| I[Agent Not Reporting]
    G -->|No - diagnostic settings| J[No Data in Workspace]
    
    D -->|Alert never fires| K[Alert Not Firing]
    D -->|Too many alerts| L[Alert Storm]
    
    E --> E1[Playbook: High Ingestion Cost]
    F --> F1[Playbook: Query Performance]
    H --> H1[Playbook: Missing Application Telemetry]
    I --> I1[Playbook: Agent Not Reporting]
    J --> J1[Playbook: No Data in Workspace]
    K --> K1[Playbook: Alert Not Firing]
    L --> L1[Playbook: Alert Storm]
    
    click E1 "playbooks/high-ingestion-cost.md"
    click F1 "playbooks/query-performance.md"
    click H1 "playbooks/missing-application-telemetry.md"
    click I1 "playbooks/agent-not-reporting.md"
    click J1 "playbooks/no-data-in-workspace.md"
    click K1 "playbooks/alert-not-firing.md"
    click L1 "playbooks/alert-storm.md"
```

## Quick Symptom Lookup

| Symptom | First Check | Playbook |
|---------|-------------|----------|
| No data in Log Analytics | Diagnostic settings enabled? | [No Data in Workspace](playbooks/no-data-in-workspace.md) |
| Application Insights empty | Connection string configured? | [Missing Application Telemetry](playbooks/missing-application-telemetry.md) |
| Alert rule never fires | Signal has data? | [Alert Not Firing](playbooks/alert-not-firing.md) |
| Getting too many alerts | Thresholds appropriate? | [Alert Storm](playbooks/alert-storm.md) |
| Unexpected cost increase | Which table growing? | [High Ingestion Cost](playbooks/high-ingestion-cost.md) |
| Queries timing out | Time range too wide? | [Query Performance](playbooks/query-performance.md) |
| VM metrics missing | AMA installed and healthy? | [Agent Not Reporting](playbooks/agent-not-reporting.md) |

## First 5 Minutes Checklist

Before diving into playbooks, check these common issues:

### Data Issues

1. **Resource exists and is running** — Is the resource deployed and operational?
2. **Diagnostic settings configured** — Are logs/metrics being sent anywhere?
3. **Correct workspace target** — Is data going to the workspace you're querying?
4. **Time range appropriate** — Are you querying the right time window?
5. **Ingestion delay** — Wait 5-10 minutes for recent data to appear

### Alert Issues

1. **Alert rule enabled** — Is the rule active, not disabled?
2. **Scope correct** — Does the rule target the right resources?
3. **Signal has data** — Is the metric/log table populated?
4. **Condition makes sense** — Is threshold achievable with current data?
5. **Action group configured** — Are notifications set up correctly?

### Cost Issues

1. **Check Usage table** — Which tables are growing?
2. **Review recent changes** — New resources or diagnostic settings?
3. **Daily cap status** — Has cap been hit or adjusted?
4. **Commitment tier** — Is usage aligned with tier?

## See Also

- [Evidence Map](evidence-map.md)
- [Playbooks Index](playbooks/index.md)
- [KQL Query Packs](kql/index.md)

## Sources

- [Troubleshoot Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/troubleshoot)
- [Troubleshoot Log Analytics agent](https://learn.microsoft.com/azure/azure-monitor/agents/agent-troubleshoot-overview)
