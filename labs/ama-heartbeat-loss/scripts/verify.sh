#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-ama-heartbeat-loss}"
VM_NAME="${VM_NAME:-vm-ama-heartbeat-loss}"
WORKSPACE_NAME="${WORKSPACE_NAME:-law-ama-heartbeat-loss}"
WORKSPACE_ID="${WORKSPACE_ID:-}"

if [[ -z "$WORKSPACE_ID" ]]; then
  WORKSPACE_ID="$(az monitor log-analytics workspace show \
    --resource-group "$RG" \
    --workspace-name "$WORKSPACE_NAME" \
    --query customerId \
    --output tsv)"
fi

QUERY="Heartbeat | where Computer == '$VM_NAME' | summarize LastHeartbeat=max(TimeGenerated), MinutesSinceLastHeartbeat=datetime_diff('minute', now(), max(TimeGenerated))"

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "$QUERY" \
  --timespan P1D \
  --output json
