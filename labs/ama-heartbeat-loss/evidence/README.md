# Evidence Placeholder

This directory is intentionally checked in with **no fabricated evidence files**.

During a live Azure run, capture the real query outputs here:

- `heartbeat-before-fix.json` — broken state after deleting the `ama-heartbeat-loss` DCR association and waiting past the freshness window.
- `heartbeat-after-fix.json` — recovered state after recreating the association and confirming fresh Heartbeat data.

Live deployment, break, fix, verification, and cleanup are explicitly out of scope for this authoring-only change.
