#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-ama-heartbeat-loss}"
VM_NAME="${VM_NAME:-vm-ama-heartbeat-loss}"
DCR_NAME="${DCR_NAME:-dcr-ama-heartbeat-loss}"
DCR_ASSOCIATION_NAME="${DCR_ASSOCIATION_NAME:-ama-heartbeat-loss}"
VM_RESOURCE_ID="${VM_RESOURCE_ID:-}"
DCR_RESOURCE_ID="${DCR_RESOURCE_ID:-}"

if [[ -z "$VM_RESOURCE_ID" ]]; then
  VM_RESOURCE_ID="$(az vm show \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --query id \
    --output tsv)"
fi

if [[ -z "$DCR_RESOURCE_ID" ]]; then
  DCR_RESOURCE_ID="$(az monitor data-collection rule show \
    --resource-group "$RG" \
    --name "$DCR_NAME" \
    --query id \
    --output tsv)"
fi

az monitor data-collection rule association create \
  --name "$DCR_ASSOCIATION_NAME" \
  --resource "$VM_RESOURCE_ID" \
  --rule-id "$DCR_RESOURCE_ID"
