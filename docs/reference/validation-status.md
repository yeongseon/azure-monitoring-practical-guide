---
content_sources:
  diagrams:
    - id: reference-validation-status
      type: pie
      source: self-generated
      justification: Tutorial validation status chart generated from repository validation frontmatter.
      based_on:
        - docs/tutorials/
content_validation:
  status: pending_review
  last_reviewed: null
  reviewer: agent
  core_claims: []
---

# Tutorial Validation Status

This page tracks tutorial validation metadata. `not_tested` means the tutorial is registered in the validation program but has not been executed end-to-end.

## Summary

*Generated from repository frontmatter metadata.*

| Status | Count |
|---|---:|
| Total tutorials | 7 |
| Pass | 0 |
| Fail | 0 |
| Not tested | 7 |
| Missing metadata | 0 |

<!-- diagram-id: reference-validation-status -->
```mermaid
pie title Tutorial Validation Status
    "Not Tested" : 7
```

## Validation Matrix

| Tutorial | az_cli | bicep | Overall |
|---|---|---|---|
| [tutorials/index.md](../tutorials/index.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/index.md](../tutorials/lab-guides/index.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/lab-01-log-analytics-workspace-setup.md](../tutorials/lab-guides/lab-01-log-analytics-workspace-setup.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/lab-02-custom-kql-queries.md](../tutorials/lab-guides/lab-02-custom-kql-queries.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/lab-03-azure-monitor-alerts.md](../tutorials/lab-guides/lab-03-azure-monitor-alerts.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/lab-04-application-insights-setup.md](../tutorials/lab-guides/lab-04-application-insights-setup.md) | `not_tested` | `not_tested` | `not_tested` |
| [tutorials/lab-guides/lab-05-workbooks-and-dashboards.md](../tutorials/lab-guides/lab-05-workbooks-and-dashboards.md) | `not_tested` | `not_tested` | `not_tested` |

## How to Update

Only set `result: pass` after executing the tutorial against a real Azure environment. Use `not_tested` when the tutorial is registered but not yet executed.

```bash
python3 scripts/generate_validation_status.py
```

## See Also

- [Content Source Validation Status](content-validation-status.md)
- [Tutorials](../tutorials/index.md)
- [CLI Cheatsheet](cli-cheatsheet.md)

## Sources

- [Azure Monitor documentation](https://learn.microsoft.com/azure/azure-monitor/)
