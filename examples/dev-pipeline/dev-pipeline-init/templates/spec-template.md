---
id: "NNN"
status: draft
subsystem: SUBSYSTEM
feature: FEATURE
type: implementation
depends_on: []
created: YYYY-MM-DD
---

<!-- Spec lifecycle: draft → approved → in_progress → done / partial / blocked / failed / cancelled
  draft       — written by Claude.ai, awaiting user review
  approved    — user confirmed, ready for Claude Code to pick up
  in_progress — Claude Code is working on it
  done        — all acceptance criteria met
  partial     — some criteria met, rest in session report
  blocked     — cannot proceed, reason in session report
  failed      — broke something, rolled back
  cancelled   — no longer needed
-->

# NNN: Short descriptive title

## Task
One sentence — what needs to be done.

## Context
Why this is needed. What was done before (link to previous specs/sessions).
What the user discussed with PM. Dependencies and assumptions.

Links: [[_project/architecture]], [[sessions/NNN-previous]]

## Steps
1. Concrete step with file paths
2. Exact commands if needed
3. ...

## Acceptance Criteria
- [ ] Testable criterion 1
- [ ] Testable criterion 2

## Validation
How to verify the work is done correctly. Be specific:
- Commands to run (build, test, lint, curl, etc.)
- Expected output or behavior
- What "working" looks like
<!-- If no automated tests exist, describe manual verification steps. "It compiles" is not sufficient. -->

## Risks
- What could go wrong or be harder than expected (or "None identified")
- Edge cases to watch for

## Constraints
- Do NOT ...
- Do NOT ...

## Post-task
1. Create session report: `sessions/NNN-subsystem-title.md`
2. Update spec frontmatter: `status: done` (or `partial`/`blocked`/`failed`)
3. Update feature tracker in `features/` if one exists for this feature
4. If you discovered something that contradicts `_project/` or `subsystems/` files — follow the conflict resolution protocol (see CLAUDE.md Rules section)
5. If you found a new gotcha — add it to the appropriate `gotchas.md`
6. Git commit + push in code repo: `git add -A && git commit -m "NNN: short description" && git push`
7. Git commit + push in vault repo: `cd <vault> && git add -A && git commit -m "session NNN: report + updates" && git push`
<!-- Do NOT update _state/active.md — that is the PM's responsibility after reviewing your session report. -->
