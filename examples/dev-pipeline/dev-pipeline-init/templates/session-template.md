---
spec: "[[specs/NNN-title]]"
status: done|partial|blocked|failed
subsystem: SUBSYSTEM
started: YYYY-MM-DDTHH:MM
finished: YYYY-MM-DDTHH:MM
---

<!-- Status options:
  done    — all acceptance criteria met
  partial — some criteria met, rest documented below
  blocked — cannot proceed, reason documented below
  failed  — broke something, rolled back, reason documented below
-->

# Session NNN: Short title (same as spec)

## Result
One sentence — what was accomplished.

## What was done
- Concrete changes with file paths
- Created: `path/to/file`
- Modified: `path/to/file` (description of change)

## Validation performed
- What commands were run to verify (build, test, lint, curl, manual check)
- Output or result of each check
- What was NOT verified and why (e.g., "no test environment for X", "requires manual UI check")
<!-- This section is mandatory. "It compiles" alone is not sufficient. If the spec included a Validation section, follow it and report results here. -->

## Deviations from spec
- What went differently and why (or "None")

## Discoveries
- New information about the codebase
- Things that weren't documented before
- Potential issues found
- (or "None")

## Side fixes
- Unrelated fixes done during this session
- (or "None")

## Open questions for PM
- Questions that need Claude.ai's input
- (or "None")

## Next recommended step
- What should happen next based on what was learned during this session
- Suggest next spec topic, follow-up investigation, or "Feature complete — ready for post-mortem"

## Files changed
- `path/to/file` — created/modified/deleted (brief reason)
- `vault/subsystems/.../gotchas.md` — updated (added note about X)

## Post-session updates
<!-- If the user asks for follow-up tasks in the same conversation AFTER the spec is complete
     (e.g., "create GitHub repos", "fix that typo", "update the config"), log them here
     instead of writing a separate adhoc report. Always update vault knowledge files too. -->
- (or "None — session ended after spec completion")
