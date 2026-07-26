#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-ama-heartbeat-loss}"

az group delete \
  --name "$RG" \
  --yes \
  --no-wait
