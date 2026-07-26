# Lab Substrate: AMA Heartbeat Loss

Create a minimal VM + Azure Monitor Agent (AMA) substrate where heartbeat flows normally, then reproduce signal loss by deleting the data collection rule (DCR) association named `ama-heartbeat-loss`.

## Scenario

This substrate is intentionally small:

- A Linux virtual machine with the Azure Monitor Linux Agent extension.
- A Log Analytics workspace that receives guest signals.
- A Linux data collection rule associated to the VM as `ama-heartbeat-loss`.

The failure trigger is **deleting the DCR association**, not uninstalling the agent or deleting the VM. That lets the lab isolate the “agent installed but guest signal path severed” state.

## Files

```text
labs/ama-heartbeat-loss/
├── main.bicep
├── main.parameters.json
├── README.md
├── evidence/
│   └── README.md
└── scripts/
    ├── break.sh
    ├── cleanup.sh
    ├── deploy.sh
    ├── fix.sh
    └── verify.sh
```

## Run Sequence

```bash
export RG="rg-ama-heartbeat-loss"
export LOCATION="eastus"

bash labs/ama-heartbeat-loss/scripts/deploy.sh

# Wait for AMA onboarding and initial Heartbeat ingestion.
bash labs/ama-heartbeat-loss/scripts/verify.sh

# Break the signal path by deleting the DCR association.
bash labs/ama-heartbeat-loss/scripts/break.sh

# Wait past the documented freshness window before querying again.
sleep 360
bash labs/ama-heartbeat-loss/scripts/verify.sh

# Restore the DCR association and confirm Heartbeat freshness recovers.
bash labs/ama-heartbeat-loss/scripts/fix.sh
sleep 180
bash labs/ama-heartbeat-loss/scripts/verify.sh

# Remove the lab resource group when finished.
bash labs/ama-heartbeat-loss/scripts/cleanup.sh
```

## Heartbeat Query

```kusto
Heartbeat | where Computer == '<vm-name>' | summarize LastHeartbeat=max(TimeGenerated), MinutesSinceLastHeartbeat=datetime_diff('minute', now(), max(TimeGenerated))
```

## Expected Interpretation

- **Healthy / before break**: `MinutesSinceLastHeartbeat <= 5`
- **Broken / after deleting `ama-heartbeat-loss` and waiting past the freshness window**: `MinutesSinceLastHeartbeat > 5`
- **Fixed / after recreating the association**: `MinutesSinceLastHeartbeat <= 5`

## Notes

- `deploy.sh` creates the resource group, deploys `main.bicep`, and prints the environment variables that the other scripts expect.
- `break.sh` deletes the DCR association named `ama-heartbeat-loss` from the VM resource.
- `fix.sh` recreates the same association against the deployed DCR.
- `verify.sh` runs the Heartbeat KQL query against the workspace and prints JSON output.
- Real evidence capture is deferred to a live Azure run; see `evidence/README.md`.

## See Also

- [Troubleshooting Lab Guides](../../docs/troubleshooting/lab-guides/index.md)
- [Virtual machine observability guide](../../docs/service-guides/vm/observability.md)

## Sources

- [Azure Monitor agent overview](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview)
- [Data collection rules in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-overview)
