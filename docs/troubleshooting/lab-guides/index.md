---
description: Reproducible Azure Monitor troubleshooting labs — hypothesis-driven experiments that reproduce real failure modes and prove the fix with evidence.
---

# Troubleshooting Lab Guides

Reproducible, hypothesis-driven experiments that recreate real Azure Monitor failure modes end-to-end, then prove the fix with collected evidence. Where the [Playbooks](../playbooks/index.md) tell you how to diagnose a live incident, lab guides let you **reproduce** the failure in a controlled environment so you can build intuition before you face it in production.

## How Lab Guides Differ from Playbooks

| Aspect | Playbooks | Lab Guides |
|--------|-----------|------------|
| Goal | Diagnose and resolve a live incident | Reproduce a failure to learn its signature |
| Starting point | An active symptom | A clean environment you deliberately break |
| Outcome | Restored service | A confirmed hypothesis backed by evidence |
| Reusability | Reference during an incident | Run as a self-contained exercise |

## Lab Methodology

Every lab guide follows the scientific-method skeleton so the result is reproducible and falsifiable, not anecdotal:

1. **Background** — the question the lab investigates and the environment it needs.
2. **Hypothesis** — the expected cause and an "IF … THEN …" prediction.
3. **Runbook** — the steps to deploy the environment, trigger the failure, and apply the fix.
4. **Experiment Log** — the observed evidence, tagged for strength (`[Observed]`, `[Measured]`, `[Inferred]`), including a **Falsification** step that proves the fix works and the original theory was correct.
5. **Verification** — the KQL queries and portal evidence that confirm the outcome.

## Available Labs

No labs have been published yet. This section is the scaffold that new labs land in; each new lab is added both as a file under `docs/troubleshooting/lab-guides/` and as a nav entry in `mkdocs.yml`.

| Lab | Failure Mode | Status |
|-----|--------------|--------|
| _First lab_ | _To be added_ | Planned |

## See Also

- [Playbooks](../playbooks/index.md)
- [Troubleshooting Architecture Overview](../architecture-overview.md)
- [Troubleshooting Mental Model](../mental-model.md)
- [Decision Tree](../decision-tree.md)
- [Evidence Map](../evidence-map.md)
- [KQL Query Packs](../kql/index.md)

## Sources

- [Troubleshoot Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/troubleshoot)
