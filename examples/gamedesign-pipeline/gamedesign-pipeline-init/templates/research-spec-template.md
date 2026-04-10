---
id: "NNN"
status: draft
domain: DOMAIN
feature: FEATURE
type: research
depends_on: []
created: YYYY-MM-DD
---

<!-- Spec lifecycle: draft → approved → in_progress → done / partial / blocked / failed / cancelled -->

# NNN: RESEARCH — Short description of what to investigate

## Task
Investigate [area] and report findings.

## Questions to answer
1. Question 1
2. Question 2
3. ...

## Sources to check
- Competitor games: [list specific games and what to look at]
- App store reviews: [what to search for, which game, which period]
- Existing vault docs: [which domain files to cross-reference]
- Uploaded documents: [if user uploaded analytics, spreadsheets, etc.]
- Public sources: [community forums, patch notes, industry reports]

## Deliverable
- Create: `domains/DOMAIN/research-NNN-title.md` (or update existing file)
- Format: [structured findings with evidence, not opinions]

## Validation
How to confirm the investigation is complete:
- Every question above must have a concrete answer backed by evidence
- If a question can't be answered from available sources, state what's missing
- Claims must reference specific sources, not general impressions

## Constraints
- Do NOT make design recommendations — this is research only, recommendations come in a follow-up design spec
- Do NOT extrapolate beyond what the data shows
- ...

## Post-task
1. Create session report: `sessions/NNN-domain-title.md` with answers to all questions
2. Update `domains/DOMAIN/overview.md` with confirmed findings
3. Update feature tracker in `features/` if one exists
4. Flag any findings that contradict existing vault knowledge
