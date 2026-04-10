# Pipeline README

This vault is part of a two-agent game design pipeline.

## How it works

**Claude.ai** (Lead Designer / PM) manages project knowledge, writes specs, and reviews results.
**Executor** (any capable LLM) performs design tasks: research, feature design, balance work, document writing.
**The user** carries specs to the Executor and brings reports back to the PM.

## Folder structure

| Folder | Purpose | Written by |
|--------|---------|------------|
| `_pipeline/` | Templates and this README | Created during init |
| `_project/` | Game-level truth (brief, pillars, constraints, preferences) | PM |
| `_state/` | Active work, backlog, decision log | PM |
| `domains/` | Per-domain knowledge (economy, progression, content, narrative, etc.) | Both agents |
| `features/` | Feature trackers for multi-spec design initiatives | PM |
| `competitors/` | Competitor analysis files | Executor |
| `feedback/` | Player feedback summaries | Executor |
| `handoffs/` | Final documents for the dev team | Executor |
| `specs/` | Task specifications | PM |
| `sessions/` | Session reports | Executor |

## Key rules

- `_project/` and `domains/` files are the **source of truth** for game design. If you discover something that contradicts them — update them, don't just note it in a report.
- One spec = one task = one session.
- Always read `constraints.md` before producing design work.
- Handoff documents must be **self-contained** — the dev team doesn't read the vault.
- `_state/active.md` is PM-only — Executor must never modify it.

## Templates

All templates for specs, session reports, domain overviews, and feature trackers are in this folder.
