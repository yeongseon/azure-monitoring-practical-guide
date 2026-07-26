# Lab Substrate: Application Insights Telemetry Gap

This companion substrate placeholder mirrors the `ama-heartbeat-loss` lab shape without pretending that a live Azure substrate was deployed in this PR.

## Scenario

The intended live lab uses an Azure App Service application that already emits request telemetry to a workspace-based Application Insights resource. The failure trigger is replacing `APPLICATIONINSIGHTS_CONNECTION_STRING` with `invalid`, then restoring the original value to prove that `AppRequests` recovers.

## Files

```text
labs/app-insights-telemetry-gap/
├── README.md
└── evidence/
    └── README.md
```

## Notes

- This directory is documentation support only for the Zero-Lab Readiness authoring pass.
- No deployment scripts, Bicep templates, or captured outputs are committed here yet.
- Real evidence is deferred to a live run; see `evidence/README.md`.

## See Also

- [Application Insights Telemetry Gap](../../docs/troubleshooting/lab-guides/app-insights-telemetry-gap.md)
- [Missing Application Telemetry](../../docs/troubleshooting/playbooks/missing-application-telemetry.md)

## Sources

- [Monitor Azure App Service with Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps)
- [Troubleshoot missing application telemetry in Application Insights](https://learn.microsoft.com/en-us/troubleshoot/azure/azure-monitor/app-insights/telemetry/investigate-missing-telemetry)
