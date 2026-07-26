#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-ama-heartbeat-loss}"
VM_NAME="${VM_NAME:-vm-ama-heartbeat-loss}"
DCR_ASSOCIATION_NAME="${DCR_ASSOCIATION_NAME:-ama-heartbeat-loss}"
VM_RESOURCE_ID="${VM_RESOURCE_ID:-}"

if [[ -z "$VM_RESOURCE_ID" ]]; then
  VM_RESOURCE_ID="$(az vm show \
    --resource-group "$RG" \
    --name "$VM_NAME" \
    --query id \
    --output tsv)"
fi

az monitor data-collection rule association delete \
  --name "$DCR_ASSOCIATION_NAME" \
  --resource "$VM_RESOURCE_ID" \
  --yes
