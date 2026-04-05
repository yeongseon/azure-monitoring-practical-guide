# Azure Monitor CLI Cheatsheet

Quick reference for common `az monitor` commands. All examples use long flags for clarity and script compatibility.

## Log Analytics Workspaces

### Create a Workspace
```bash
az monitor log-analytics workspace create \
    --resource-group <resource-group-name> \
    --workspace-name <workspace-name> \
    --location <location> \
    --sku PerGB2018 \
    --retention-time 30
```

### List Workspaces
```bash
az monitor log-analytics workspace list \
    --resource-group <resource-group-name>
```

### Show Workspace Details
```bash
az monitor log-analytics workspace show \
    --resource-group <resource-group-name> \
    --workspace-name <workspace-name>
```

## Diagnostic Settings

### Create Diagnostic Setting
```bash
az monitor diagnostic-settings create \
    --name <setting-name> \
    --resource <resource-id> \
    --workspace <workspace-id> \
    --logs '[{"category": "AppServiceHTTPLogs", "enabled": true}]' \
    --metrics '[{"category": "AllMetrics", "enabled": true}]'
```

### List Diagnostic Settings
```bash
az monitor diagnostic-settings list \
    --resource <resource-id>
```

## Alert Rules

### Create Metric Alert Rule
```bash
az monitor metrics alert create \
    --name <alert-name> \
    --resource-group <resource-group-name> \
    --scopes <resource-id> \
    --condition "avg Percentage CPU > 90" \
    --window-size 5m \
    --evaluation-frequency 1m \
    --description "High CPU alert"
```

### Create Log Search Alert (v2)
```bash
az monitor scheduled-query create \
    --name <alert-name> \
    --resource-group <resource-group-name> \
    --scopes <workspace-id> \
    --condition-query "AppServiceHTTPLogs | where ScStatus >= 500 | summarize AggregatedValue = count() by bin(TimeGenerated, 5m)" \
    --condition-threshold 10 \
    --condition-operator GreaterThan \
    --evaluation-frequency 5m \
    --window-size 5m
```

## Metrics and Logs

### List Metric Definitions
```bash
az monitor metrics list-definitions \
    --resource <resource-id>
```

### Query Metrics
```bash
az monitor metrics list \
    --resource <resource-id> \
    --metric "Percentage CPU" \
    --interval 1m
```

### Query Logs (Ad-hoc)
```bash
az monitor log-analytics query \
    --workspace <workspace-id> \
    --analytics-query "AzureActivity | take 10"
```

## Action Groups

### Create Action Group
```bash
az monitor action-group create \
    --name <group-name> \
    --resource-group <resource-group-name> \
    --short-name "OpsAlert" \
    --action email admin admin@example.com
```

### List Action Groups
```bash
az monitor action-group list \
    --resource-group <resource-group-name>
```
