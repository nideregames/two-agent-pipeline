---
id: "NNN"
status: draft
domain: DOMAIN
feature: FEATURE
type: design
depends_on: []
created: YYYY-MM-DD
---

<!-- Spec lifecycle: draft → approved → in_progress → done / partial / blocked / failed / cancelled
  draft       — written by PM, awaiting user review
  approved    — user confirmed, ready for Executor to pick up
  in_progress — Executor is working on it
  done        — all acceptance criteria met
  partial     — some criteria met, rest in session report
  blocked     — cannot proceed, reason in session report
  failed      — approach didn't work, documented in session report
  cancelled   — no longer needed
-->

# NNN: Short descriptive title

## Task
One sentence — what design artifact needs to be produced.

## Context
Why this is needed. What was discussed with the Lead Designer. What prior research or decisions this builds on.

Links: [[_project/design-pillars]], [[domains/economy/overview]]

## Inputs
<!-- What the Executor must read before starting -->
- `domains/DOMAIN/overview.md`
- `_project/constraints.md`
- [specific files, external data, uploaded documents]

## Deliverable
<!-- What the Executor must produce. Be explicit about format and location. -->
- Create/update: `domains/DOMAIN/file.md`
- Format: [narrative doc / table / formulas / flowchart description / comparison matrix]

## Scope
<!-- What IS and what IS NOT part of this task -->
- IN: ...
- OUT: ... (will be handled in a separate spec)

## Acceptance Criteria
- [ ] Testable criterion 1
- [ ] Testable criterion 2
- [ ] No contradictions with existing domain docs
- [ ] Cross-domain impacts identified

## Validation
How to verify the work is correct:
- Consistency check: [what to cross-reference against]
- Completeness check: [what must be covered]
- Sanity check: [what numbers/logic to verify]
<!-- "It reads well" is not sufficient. State specific checks. -->

## Constraints
- Do NOT redesign [X] — that's out of scope
- Do NOT assume [Y] — verify from [source]
- Stay within the parameters set in [[constraints]]

## Post-task
1. Create session report: `sessions/NNN-domain-title.md`
2. Update spec frontmatter: `status: done` (or `partial`/`blocked`/`failed`)
3. Update feature tracker in `features/` if one exists
4. Update `domains/DOMAIN/overview.md` if new systems or parameters were defined
5. Flag any cross-domain impacts discovered
<!-- Do NOT update _state/active.md — that is the PM's responsibility after reviewing the session report. -->
