---
id: "NNN"
status: draft
subsystem: SUBSYSTEM
feature: FEATURE
type: recon
depends_on: []
created: YYYY-MM-DD
---

<!-- Spec lifecycle: draft → approved → in_progress → done / partial / blocked / failed / cancelled -->

# NNN: RECON — Short description of what to investigate

## Task
Investigate [area] and report findings.

## Questions to answer
1. Question 1
2. Question 2
3. ...

## Where to look
- `src/path/to/relevant/` directory
- Config files mentioning X
- ...

<!-- If this RECON involves DB access, SSH, APIs, or other infrastructure:
     reference setup.md explicitly. Example:
     - For DB queries: follow "Database Access" in `subsystems/server/setup.md`
     - For SSH: use connection details from `subsystems/server/setup.md`
     - For credentials: check `.env` in the repo root, or ask the user. Do NOT search production servers for passwords.
     The PM (Claude.ai) should fill this in — don't leave Claude Code to figure out operational access on its own. -->

## Validation
How to confirm the investigation is complete:
- Every question above must have a concrete answer (not "probably" or "likely")
- If a question can't be answered from code alone, state what's missing and why
- Key claims must reference specific files/lines, not general impressions

## Risks
- What might be harder to investigate than expected (or "None identified")

## Constraints
- Do NOT modify any code files — this is read-only investigation
- ...

## Post-task
1. Create session report: `sessions/NNN-subsystem-title.md` with answers to all questions above
2. Update `subsystems/SUBSYSTEM/architecture.md` with findings
3. Update `subsystems/SUBSYSTEM/structure.md` with discovered file locations and key modules
4. Update `subsystems/SUBSYSTEM/gotchas.md` if anything unexpected found
5. Update feature tracker in `features/` if one exists for this feature
6. If you found contradictions with vault — follow the conflict resolution protocol (see CLAUDE.md Rules section)
7. Git commit + push in vault repo: `cd <vault> && git add -A && git commit -m "session NNN: recon report + updates" && git push`
