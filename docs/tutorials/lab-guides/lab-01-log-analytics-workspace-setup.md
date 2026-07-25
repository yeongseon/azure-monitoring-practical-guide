---
content_sources:
  diagrams:
    - id: architecture-diagram
      type: flowchart
      source: mslearn-adapted
      based_on:
        - https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview
        - https://learn.microsoft.com/en-us/azure/azure-monitor/logs/manage-access
        - https://learn.microsoft.com/en-us/azure/azure-monitor/platform/create-diagnostic-settings
        - https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview
        - https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-overview
validation:
  az_cli:
    last_tested: null
    cli_version: null
    result: not_tested
  bicep:
    last_tested: null
    result: not_tested
---

# Lab 01: Log Analytics Workspace Setup

This lab builds the shared data platform for the rest of the tutorial sequence. You will create a Log Analytics workspace, configure retention and daily cap settings, and connect Azure resources so telemetry lands in one searchable location.

## Lab Metadata

| Attribute | Value |
|---|---|
| Difficulty | Beginner |
| Estimated Duration | 35-45 minutes |
| Azure Monitor Tier | Foundational |
| Primary Services | Log Analytics workspace, diagnostic settings, Azure Monitor Agent |
| Skills Practiced | Workspace creation, retention design, resource connection, validation |

## Prerequisites

- Azure CLI installed and authenticated with `az login`.
- Contributor access to a sandbox subscription.
- Permission to create resource groups, workspaces, virtual machines, storage accounts, and diagnostic settings.
- Familiarity with Azure resource IDs and the Azure portal.
- Bash-compatible shell for environment variables.

Define reusable variables:

```bash
export LOCATION="koreacentral"
export RG="rg-monitoring-lab01"
export WORKSPACE_NAME="lawmonlab01"
export STORAGE_NAME="stmonlab01001"
export VM_NAME="vmmonlab01"
export DCR_NAME="dcr-monlab01"
```

## Architecture Diagram

<!-- diagram-id: architecture-diagram -->
```mermaid
flowchart TD
    VM[Azure VM] --> AMA[Azure Monitor Agent]
    AMA --> DCR[Data Collection Rule]
    App[Storage account diagnostics] --> DS1[Diagnostic setting]
    SA[Storage account] --> DS1
    DCR --> LAW[Log Analytics workspace]
    DS1 --> LAW
    LAW --> Query[KQL queries]
    LAW --> Alert[Alert rules]
    LAW --> Workbook[Workbooks]
```

## Lab Objectives

By the end of the lab, you will have:

1. A dedicated resource group for monitoring experiments.
2. A Log Analytics workspace with retention and daily cap configured.
3. A storage account streaming logs and metrics into the workspace.
4. A VM connected through Azure Monitor Agent and a data collection rule.
5. A validation query proving that data is arriving.

## Step-by-Step Instructions

### Step 1: Create the resource group

```bash
az group create \
    --name "$RG" \
    --location "$LOCATION" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az group create` | Create a resource group. |
| `--name` | Name of the resource. |
| `--location` | Azure region for the resource. |
| `--output` | Output format for the result. |

Expected result:

```json
{
  "location": "koreacentral",
  "name": "rg-monitoring-lab01",
  "properties": {
    "provisioningState": "Succeeded"
  }
}
```

### Step 2: Create the Log Analytics workspace

```bash
az monitor log-analytics workspace create \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --location "$LOCATION" \
    --sku "PerGB2018" \
    --retention-time 30 \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics workspace create` | Create a Log Analytics workspace. |
| `--resource-group` | Resource group that contains the resource. |
| `--workspace-name` | Name of the Log Analytics workspace. |
| `--location` | Azure region for the resource. |
| `--sku` | SKU tier of the resource. |
| `--retention-time` | Data retention period in days. |
| `--output` | Output format for the result. |

Review the workspace properties:

```bash
az monitor log-analytics workspace show \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --query "{name:name,location:location,retentionInDays:retentionInDays,workspaceId:customerId}" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics workspace show` | Show a Log Analytics workspace. |
| `--resource-group` | Resource group that contains the resource. |
| `--workspace-name` | Name of the Log Analytics workspace. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |

### Step 3: Set a daily cap for predictable spend

```bash
az monitor log-analytics workspace update \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --set workspaceCapping.dailyQuotaGb=2 \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics workspace update` | Update a Log Analytics workspace. |
| `--resource-group` | Resource group that contains the resource. |
| `--workspace-name` | Name of the Log Analytics workspace. |
| `--set` | Property assignment applied during update. |
| `--output` | Output format for the result. |

Why this matters:

- Retention protects investigation depth.
- Daily cap protects your sandbox budget.
- Both settings should be explicit rather than relying on defaults.

### Step 4: Create a storage account that can emit platform logs

```bash
az storage account create \
    --name "$STORAGE_NAME" \
    --resource-group "$RG" \
    --location "$LOCATION" \
    --sku "Standard_LRS" \
    --kind "StorageV2" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az storage account create` | Create a storage account. |
| `--name` | Name of the resource. |
| `--resource-group` | Resource group that contains the resource. |
| `--location` | Azure region for the resource. |
| `--sku` | SKU tier of the resource. |
| `--kind` | Resource kind. |
| `--output` | Output format for the result. |

Capture IDs for later steps:

```bash
export WORKSPACE_ID=$(az monitor log-analytics workspace show \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --query "id" \
    --output tsv)

export STORAGE_ID=$(az storage account show \
    --name "$STORAGE_NAME" \
    --resource-group "$RG" \
    --query "id" \
    --output tsv)
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics workspace show` | Show a Log Analytics workspace. |
| `--resource-group` | Resource group that contains the resource. |
| `--workspace-name` | Name of the Log Analytics workspace. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |
| `az storage account show` | Show properties of a storage account. |
| `--name` | Name of the resource. |
| `--resource-group` | Resource group that contains the resource. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |

### Step 5: Connect storage logs and metrics to the workspace

```bash
az monitor diagnostic-settings create \
    --name "send-to-law" \
    --resource "$STORAGE_ID" \
    --workspace "$WORKSPACE_ID" \
    --logs '[{"categoryGroup":"audit","enabled":true}]' \
    --metrics '[{"category":"Transaction","enabled":true}]' \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor diagnostic-settings create` | Create a diagnostic setting. |
| `--name` | Name of the resource. |
| `--resource` | Target resource ID or name for the operation. |
| `--workspace` | Log Analytics workspace name or resource ID that receives the logs. |
| `--logs` | Log categories or settings to collect. |
| `--metrics` | Metric categories to collect. |
| `--output` | Output format for the result. |

List the diagnostic settings to confirm the attachment:

```bash
az monitor diagnostic-settings list \
    --resource "$STORAGE_ID" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor diagnostic-settings list` | List diagnostic settings for a resource. |
| `--resource` | Target resource ID or name for the operation. |
| `--output` | Output format for the result. |

### Step 6: Create a VM to generate heartbeat telemetry

```bash
az vm create \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --image "Ubuntu2204" \
    --admin-username "azureuser" \
    --generate-ssh-keys \
    --size "Standard_B2s" \
    --public-ip-sku "Standard" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az vm create` | Create a virtual machine. |
| `--resource-group` | Resource group that contains the resource. |
| `--name` | Name of the resource. |
| `--image` | VM image used to create the virtual machine. |
| `--admin-username` | Administrator username for the virtual machine. |
| `--generate-ssh-keys` | Generates SSH keys for the virtual machine if missing. |
| `--size` | Virtual machine size (SKU). |
| `--public-ip-sku` | SKU for the public IP address. |
| `--output` | Output format for the result. |

Capture the VM resource ID:

```bash
export VM_ID=$(az vm show \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --query "id" \
    --output tsv)
```

| Command | Purpose |
| --- | --- |
| `az vm show` | Show properties of a virtual machine. |
| `--resource-group` | Resource group that contains the resource. |
| `--name` | Name of the resource. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |

### Step 7: Create a data collection rule for performance counters

```bash
az monitor data-collection rule create \
    --name "$DCR_NAME" \
    --resource-group "$RG" \
    --location "$LOCATION" \
    --data-flows streams="[\"Microsoft-Perf\"]" destinations="[\"la-workspace\"]" \
    --destinations log-analytics name="la-workspace" workspace-resource-id="$WORKSPACE_ID" \
    --data-sources performance-counters name="perfCounters" streams="[\"Microsoft-Perf\"]" sampling-frequency="PT1M" counter-specifiers="[\"\\Processor(_Total)\\% Processor Time\",\"\\Memory\\Available MBytes\"]" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor data-collection rule create` | Create a data collection rule. |
| `--name` | Name of the resource. |
| `--resource-group` | Resource group that contains the resource. |
| `--location` | Azure region for the resource. |
| `--data-flows` | Data flow mappings from sources to destinations. |
| `--destinations` | Destinations that receive collected data. |
| `--data-sources` | Data sources collected by the rule. |
| `--output` | Output format for the result. |

### Step 8: Install Azure Monitor Agent on the VM

```bash
az vm extension set \
    --resource-group "$RG" \
    --vm-name "$VM_NAME" \
    --name "AzureMonitorLinuxAgent" \
    --publisher "Microsoft.Azure.Monitor" \
    --enable-auto-upgrade true \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az vm extension set` | Install or update a virtual machine extension. |
| `--resource-group` | Resource group that contains the resource. |
| `--vm-name` | Name of the virtual machine. |
| `--name` | Name of the resource. |
| `--publisher` | Publisher of the VM extension. |
| `--enable-auto-upgrade` | Enables automatic extension upgrades. |
| `--output` | Output format for the result. |

Associate the VM with the data collection rule:

```bash
export DCR_ID=$(az monitor data-collection rule show \
    --name "$DCR_NAME" \
    --resource-group "$RG" \
    --query "id" \
    --output tsv)

az monitor data-collection rule association create \
    --name "vm-law-association" \
    --resource "$VM_ID" \
    --rule-id "$DCR_ID" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor data-collection rule show` | Show a data collection rule. |
| `--name` | Name of the resource. |
| `--resource-group` | Resource group that contains the resource. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |
| `az monitor data-collection rule association create` | Associate a data collection rule with a resource. |
| `--name` | Name of the resource. |
| `--resource` | Target resource ID or name for the operation. |
| `--rule-id` | Resource ID of the data collection rule to associate. |
| `--output` | Output format for the result. |

### Step 9: Wait for telemetry ingestion and run validation queries

It may take several minutes before the first records appear.

```bash
az monitor log-analytics query \
    --workspace "$WORKSPACE_ID" \
    --analytics-query "Heartbeat | where TimeGenerated > ago(30m) | summarize Computers=dcount(Computer)" \
    --output table
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics query` | Run a KQL query against a Log Analytics workspace. |
| `--workspace` | Log Analytics workspace ID for the query. |
| `--analytics-query` | Kusto (KQL) query to execute. |
| `--output` | Output format for the result. |

Run a second query for metrics and logs from the storage account:

```bash
az monitor log-analytics query \
    --workspace "$WORKSPACE_ID" \
    --analytics-query "AzureMetrics | where TimeGenerated > ago(30m) | summarize Records=count() by ResourceProvider" \
    --output table
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics query` | Run a KQL query against a Log Analytics workspace. |
| `--workspace` | Log Analytics workspace ID for the query. |
| `--analytics-query` | Kusto (KQL) query to execute. |
| `--output` | Output format for the result. |

## Validation Steps

Use these checks to verify success:

1. Confirm workspace configuration.

```bash
az monitor log-analytics workspace show \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --query "{retentionInDays:retentionInDays,dailyQuotaGb:workspaceCapping.dailyQuotaGb,publicNetworkAccessForIngestion:publicNetworkAccessForIngestion}" \
    --output json
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics workspace show` | Show a Log Analytics workspace. |
| `--resource-group` | Resource group that contains the resource. |
| `--workspace-name` | Name of the Log Analytics workspace. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |

2. Confirm the VM association exists.

```bash
az monitor data-collection rule association list \
    --resource "$VM_ID" \
    --output table
```

| Command | Purpose |
| --- | --- |
| `az monitor data-collection rule association list` | List data collection rule associations. |
| `--resource` | Target resource ID or name for the operation. |
| `--output` | Output format for the result. |

3. Confirm diagnostic settings are attached to the storage account.

```bash
az monitor diagnostic-settings list \
    --resource "$STORAGE_ID" \
    --query "[].{name:name,workspaceId:workspaceId}" \
    --output table
```

| Command | Purpose |
| --- | --- |
| `az monitor diagnostic-settings list` | List diagnostic settings for a resource. |
| `--resource` | Target resource ID or name for the operation. |
| `--query` | JMESPath projection of the fields to return. |
| `--output` | Output format for the result. |

4. Confirm the workspace receives telemetry.

```bash
az monitor log-analytics query \
    --workspace "$WORKSPACE_ID" \
    --analytics-query "union isfuzzy=true Heartbeat, Perf, AzureMetrics | where TimeGenerated > ago(30m) | summarize Records=count() by Type" \
    --output table
```

| Command | Purpose |
| --- | --- |
| `az monitor log-analytics query` | Run a KQL query against a Log Analytics workspace. |
| `--workspace` | Log Analytics workspace ID for the query. |
| `--analytics-query` | Kusto (KQL) query to execute. |
| `--output` | Output format for the result. |

Validation is successful when the workspace exists, retention and quota settings are visible, the DCR association is present, and at least one telemetry table returns recent rows.

## Cleanup Instructions

If you are continuing with later labs, keep the workspace and resource group. Otherwise delete the sandbox:

```bash
az group delete \
    --name "$RG" \
    --yes \
    --no-wait
```

| Command | Purpose |
| --- | --- |
| `az group delete` | Delete a resource group. |
| `--name` | Name of the resource. |
| `--yes` | Skips the confirmation prompt. |
| `--no-wait` | Returns without waiting for the operation to finish. |

Optional partial cleanup if you want to keep the workspace but remove the VM:

```bash
az vm delete \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --yes
```

| Command | Purpose |
| --- | --- |
| `az vm delete` | Delete a virtual machine. |
| `--resource-group` | Resource group that contains the resource. |
| `--name` | Name of the resource. |
| `--yes` | Skips the confirmation prompt. |

## See Also

- [Platform: Log Analytics Workspace](../../platform/log-analytics-workspace.md)
- [Operations: Workspace Management](../../operations/workspace-management.md)
- [Lab 02: Custom KQL Queries](lab-02-custom-kql-queries.md)

## Sources

- [Log Analytics workspace in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)
- [Manage access to Log Analytics workspaces](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/manage-access)
- [Create diagnostic settings in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/platform/create-diagnostic-settings)
- [Azure Monitor Agent overview](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview)
- [Data collection rules in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-overview)
