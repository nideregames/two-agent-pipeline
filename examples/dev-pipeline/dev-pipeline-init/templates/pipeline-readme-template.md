# Pipeline README

This vault is part of a two-agent development pipeline.

## How it works

**Claude.ai** (Product Manager) writes specs and manages project knowledge.
**Claude Code** (Executor) implements specs and writes session reports.
**The user** carries specs from Claude.ai to Claude Code and brings reports back.

## Folder structure

| Folder | Purpose | Written by |
|--------|---------|------------|
| `_pipeline/` | Templates and this README | Created during init |
| `_project/` | Current project truth (architecture, conventions, constraints, gotchas) | Both agents |
| `_state/` | Active work, backlog, decision log | Both agents |
| `features/` | Feature trackers for multi-spec features | Claude.ai |
| `subsystems/` | Per-subproject knowledge | Both agents |
| `specs/` | Task specifications | Claude.ai |
| `sessions/` | Session reports | Claude Code |

## Key rules

- `_project/` files are the **source of truth**. If you discover something that contradicts them — update them, don't just note it in a report.
- One spec = one session. Don't combine unrelated work.
- Always read `constraints.md` before writing code.
- Always git commit + push after completing work.

## Templates

All templates for specs, session reports, CLAUDE.md, and feature trackers are in this folder.
