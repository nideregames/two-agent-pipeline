# Game Design Pipeline

A specialization of the [Two-Agent Pipeline](../../README.md) for **game design** work.

## What's different from the Dev Pipeline

| Aspect | Dev Pipeline | Game Design Pipeline |
|--------|-------------|---------------------|
| **PM role** | Product Manager / System Analyst | Lead Game Designer / PM |
| **Executor** | Claude Code (stateless) | Any capable LLM |
| **Output** | Code changes + commits | Design documents, balance models, handoff specs |
| **Subsystems** | Code areas (server, client, infra) | Design domains (economy, progression, content, narrative) |
| **"Deployment"** | Git push | Handoff document for dev team |
| **Validation** | Run tests, build, lint | Cross-domain consistency checks |
| **Source of truth** | Code (vault documents it) | Vault itself IS the product |

## Structure

```
gamedesign-pipeline/
├── README.md                  # This file
├── project-instructions.md    # Goes into Claude.ai Project Instructions
└── gamedesign-pipeline-init/  # Skill for vault initialization
    ├── SKILL.md
    └── templates/             # All vault templates
```

## Setup

1. **Create a Claude.ai Project** for your game
2. **Copy `project-instructions.md`** into the project's Custom Instructions
3. **Install the skill**: copy `gamedesign-pipeline-init/` to `~/.claude/skills/gamedesign-pipeline-init/` or upload as a ZIP via Claude.ai Skills
4. **Say "initialize vault"** in a new conversation — the skill walks you through setup

## Domains

Default domains (adjust during init):

| Domain | Covers |
|--------|--------|
| `economy` | Currencies, sources, sinks, shops, pricing, IAP |
| `progression` | Levels, unlocks, power curves, XP, milestones |
| `content` | Levels, items, characters, events, seasonal content |
| `meta` | Meta-game loops, guilds, social features, leaderboards |
| `narrative` | Story, lore, characters, dialogue, world-building |
| `ux` | Onboarding, UI flows, information architecture, accessibility |

Add custom domains as needed: `pvp`, `social`, `live-ops`, `audio`, etc.

## Spec Types

| Type | Purpose | Template |
|------|---------|----------|
| `design` | Produce or update a design artifact | `design-spec-template.md` |
| `research` | Investigate before designing (competitors, players, data) | `research-spec-template.md` |
| `handoff` | Compile final doc for dev team | `handoff-spec-template.md` |

## Workflow

```
User discusses feature with PM (Claude.ai)
  → PM writes RESEARCH spec (if needed)
  → User gives spec to Executor (any LLM)
  → Executor produces findings, writes session report
  → PM reads report, writes DESIGN spec
  → Executor produces design doc, writes session report
  → PM reads report, writes HANDOFF spec
  → Executor compiles dev-ready document
  → User delivers handoff to dev team
```

Not every feature needs all three phases. Simple features may go straight to design or handoff.

## Executor Setup

The Executor can be any LLM. Give it:
1. The spec file content
2. All files listed in the spec's **Inputs** section
3. The `_pipeline/ai-instructions.md` file (on first session)
4. The relevant templates for its output

The Executor writes its deliverable + a session report. User pastes the report into the vault's `sessions/` folder and starts a new chat with the PM.
