#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-ama-heartbeat-loss}"
LOCATION="${LOCATION:-eastus}"
DEPLOYMENT_NAME="${DEPLOYMENT_NAME:-ama-heartbeat-loss}"
TEMPLATE_FILE="${TEMPLATE_FILE:-labs/ama-heartbeat-loss/main.bicep}"
PARAMETERS_FILE="${PARAMETERS_FILE:-labs/ama-heartbeat-loss/main.parameters.json}"

az group create \
  --name "$RG" \
  --location "$LOCATION"

az deployment group create \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --parameters "@$PARAMETERS_FILE"

VM_NAME="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.vmName.value \
  --output tsv)"

VM_RESOURCE_ID="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.vmResourceId.value \
  --output tsv)"

WORKSPACE_NAME="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.workspaceName.value \
  --output tsv)"

DCR_RESOURCE_ID="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.dcrResourceId.value \
  --output tsv)"

DCR_NAME="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.dcrName.value \
  --output tsv)"

DCR_ASSOCIATION_NAME="$(az deployment group show \
  --resource-group "$RG" \
  --name "$DEPLOYMENT_NAME" \
  --query properties.outputs.associationName.value \
  --output tsv)"

WORKSPACE_ID="$(az monitor log-analytics workspace show \
  --resource-group "$RG" \
  --workspace-name "$WORKSPACE_NAME" \
  --query customerId \
  --output tsv)"

cat <<EOF
Deployment completed.

Export these values before running break/fix/verify:
export RG="$RG"
export VM_NAME="$VM_NAME"
export VM_RESOURCE_ID="$VM_RESOURCE_ID"
export WORKSPACE_NAME="$WORKSPACE_NAME"
export WORKSPACE_ID="$WORKSPACE_ID"
export DCR_RESOURCE_ID="$DCR_RESOURCE_ID"
export DCR_NAME="$DCR_NAME"
export DCR_ASSOCIATION_NAME="$DCR_ASSOCIATION_NAME"
EOF
