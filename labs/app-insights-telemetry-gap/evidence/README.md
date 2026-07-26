# Evidence Placeholder

This directory is intentionally checked in with **no fabricated evidence files**.

During a live Azure run, capture the real query outputs and screenshots here:

- `apprequests-before-break.json` — healthy baseline before the connection string is changed.
- `apprequests-broken.json` — stale or missing request telemetry after `APPLICATIONINSIGHTS_CONNECTION_STRING` is set to `invalid`.
- `apprequests-after-restore.json` — recovered request telemetry after the original connection string is restored.

Live deployment, traffic generation, break, restore, verification, and Portal capture are explicitly out of scope for this authoring-only change.
