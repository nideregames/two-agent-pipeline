---
name: gamedesign-pipeline-init
description: >
  Initialize or migrate a game design project to the two-agent pipeline using an Obsidian vault as shared memory. Use this skill whenever the user says "initialize vault", "create vault", "set up pipeline", "set up game design pipeline", "init GD pipeline", or asks to create a vault structure for game design work. Also trigger when the user mentions setting up a shared knowledge base for game design with AI agents.
---

# Game Design Pipeline Init

**This skill is for Claude.ai (Lead Designer / PM role) only.**

This skill handles two scenarios:
1. **New project** — create a vault from scratch for a game that exists but has no design vault
2. **Existing vault** — migrate scattered notes/docs into the structured vault

Both produce the same result: a fully structured game design vault that enables the two-agent pipeline.

## Anti-hallucination rules

These rules apply to ALL vault file creation:

- **Write ONLY what you can verify.** Every fact must come from: a file you read, a chat you found via conversation_search, an uploaded document, or something the user told you. NOTHING else.
- **If you're not sure — leave it blank or write "TBD".** A blank file is better than a file with guesses. Write `<!-- TBD: needs input from user or RESEARCH -->` for anything you can't verify.
- **Never fill in game design details from general knowledge.** If you know match-3 games typically use X economy, but you haven't seen it in the actual game's docs — don't write it.
- **Cite your source internally.** Add brief HTML comments: `<!-- from: uploaded GDD -->` or `<!-- from: user input -->` or `<!-- from: app store page -->`.
- **Ask rather than assume.** If user mentions "the battle pass" but doesn't explain how it works — don't fill in the domain doc with assumptions. Mark it TBD.

## Before starting

Read the templates in this skill's `templates/` directory:
- `templates/pipeline-readme-template.md`
- `templates/ai-instructions-template.md`
- `templates/design-spec-template.md`
- `templates/research-spec-template.md`
- `templates/handoff-spec-template.md`
- `templates/session-template.md`
- `templates/adhoc-session-template.md`
- `templates/game-brief-template.md`
- `templates/design-pillars-template.md`
- `templates/domain-overview-template.md`
- `templates/balance-model-template.md`
- `templates/competitor-analysis-template.md`
- `templates/player-feedback-template.md`
- `templates/feature-tracker-template.md`
- `templates/roadmap-template.md`
- `templates/active-template.md`
- `templates/backlog-template.md`
- `templates/decisions-template.md`
- `templates/constraints-template.md`
- `templates/working-preferences-template.md`

These are the canonical templates. Copy them into the vault's `_pipeline/` folder during initialization.

Additionally, copy the **current project instructions** (the full text from your Claude.ai Project Instructions) into `_pipeline/project-instructions.md` as a reference backup.

---

## Scenario 1: New Project Initialization

### Step 1: Gather information

Ask the user:
1. **Vault path** — where on disk should the vault live?
2. **Game name** — what is this game called?
3. **Game basics** — platform, genre, target audience, monetization model, current state (live/soft launch/pre-prod)
4. **Design domains** — what areas of game design are relevant? Suggest defaults: economy, progression, content, meta, narrative, UX. Ask which to include, which to skip, what to add.
5. **Current documentation** — does the user have existing docs (GDD, balance sheets, analytics exports)? Will they upload them?
6. **Known constraints** — any hard "do NOT" rules? (critical to capture early)
7. **Design pillars** — what are the core design principles? (can be filled later)
8. **Goals and roadmap** — what are we trying to achieve as game designers? Any milestones?
9. **Team context** — who receives handoff documents? What format do they expect?
10. **Reference/competitor games** — what games do we benchmark against?
11. **Working preferences** — how does the user prefer to communicate? Decision-making style?

### Step 2: Create vault structure

Using Filesystem tools, create:

```
<vault-path>/
├── _pipeline/
│   ├── README.md                    # From templates/pipeline-readme-template.md
│   ├── ai-instructions.md          # From templates/ai-instructions-template.md
│   ├── project-instructions.md     # Full copy of Claude.ai Project Instructions (backup)
│   ├── design-spec-template.md      # From templates/
│   ├── research-spec-template.md    # From templates/
│   ├── handoff-spec-template.md     # From templates/
│   ├── session-template.md          # From templates/
│   ├── adhoc-session-template.md    # From templates/
│   ├── feature-tracker-template.md  # From templates/
│   ├── domain-overview-template.md  # From templates/
│   ├── balance-model-template.md    # From templates/
│   ├── competitor-analysis-template.md # From templates/
│   └── player-feedback-template.md  # From templates/
├── _project/
│   ├── brief.md               # From templates/game-brief-template.md — fill from user's answers
│   ├── design-pillars.md      # From templates/design-pillars-template.md
│   ├── constraints.md         # From templates/constraints-template.md — CRITICAL
│   └── working-preferences.md # From templates/working-preferences-template.md
├── _state/
│   ├── active.md              # From templates/active-template.md
│   ├── backlog.md             # From templates/backlog-template.md
│   ├── roadmap.md             # From templates/roadmap-template.md
│   ├── decisions.md           # From templates/decisions-template.md
│   └── reviewed.md            # Tracks which sessions PM has read (starts empty)
├── domains/
│   ├── economy/
│   │   └── overview.md        # From templates/domain-overview-template.md
│   ├── progression/
│   │   └── overview.md
│   ├── content/
│   │   └── overview.md
│   ├── meta/
│   │   └── overview.md
│   ├── narrative/
│   │   └── overview.md
│   └── ux/
│       └── overview.md
├── competitors/               # Competitor analysis files
├── feedback/                  # Player feedback summaries
├── handoffs/                  # Final documents for dev team
├── features/                  # Feature trackers
├── discussions/               # PM ↔ user discussion summaries
├── specs/
└── sessions/
```

Adjust `domains/` based on user's answers in Step 1 — skip domains they don't need, add custom ones they request.

### Step 3: Populate from uploaded documents

If the user uploads existing docs (GDD, spreadsheets, analytics):
1. Read each document
2. Extract facts into the appropriate vault files (brief, domain overviews, constraints)
3. Mark sources with HTML comments: `<!-- from: uploaded GDD, section "Economy" -->`
4. Do NOT rewrite or "improve" the user's design — transcribe faithfully
5. Mark gaps as TBD

### Step 4: Save vault path to memory

Save the vault path to Claude's memory using the memory tool.

### Step 5: Verify with user — file by file

Show the content of each created file and ask for corrections. Pay special attention to:
- `_project/constraints.md` — is this complete?
- `_project/brief.md` — is this accurate?
- `_project/design-pillars.md` — does this reflect the real principles?
- `_state/roadmap.md` — right priorities?
- Domain list — did we miss any areas?

### Step 6: Structural audit

Verify:
- `_pipeline/` contains all 13 template files + README + ai-instructions + project-instructions
- `_project/` contains all 4 files (brief, pillars, constraints, preferences)
- `_state/` contains all 5 files (active, backlog, roadmap, decisions, reviewed)
- Every domain has at least `overview.md`
- Empty folders exist: competitors, feedback, handoffs, features, discussions, specs, sessions

Fix any missing files before finishing.

### Step 7: Suggest first task

Recommend a starting point based on the project state:
- If existing live game with limited docs → RESEARCH spec to document current systems
- If existing GDD but no vault → populate domains from GDD
- If starting fresh → design pillar workshop, then core loop design

---

## Scenario 2: Migrating Existing Notes

### Step 1: Discovery

1. Ask user for vault path and game name
2. Ask what existing materials they have (files on disk, uploaded docs, knowledge in past conversations)
3. Search past conversations for game design context
4. Read any uploaded files

### Step 2: Create vault structure

Same as Scenario 1, Step 2.

### Step 3: Populate from all sources

Merge knowledge from:
- Uploaded documents → domain overviews, brief, constraints
- Past conversations → decisions, backlog items, preferences
- User's verbal input → pillars, roadmap, constraints

Follow anti-hallucination rules strictly. Cite sources.

### Step 4-6: Same as Scenario 1

Save to memory, verify with user, structural audit.

### Step 7: Memory cleanup

If memory contains game design knowledge that's now in the vault, clean it up. Keep only vault path and project name. If not in the target project — tell the user to do it from there.

---

## Initialization Pitfalls

- **Don't over-fill domains initially.** A domain with just `overview.md` containing "TBD — needs RESEARCH spec" is fine. Empty but present is better than filled with assumptions.
- **Constraints are #1 priority.** Capture every "do NOT" rule the user mentions, even informally.
- **Don't create balance models during init.** Those come from RESEARCH or DESIGN specs later.
- **Competitor files start empty.** The `competitors/` folder gets populated through RESEARCH specs.
- **Handoffs folder starts empty.** Handoff docs are the output of the pipeline, not the input.
- **Domain list is flexible.** Some games need `pvp/`, some need `social/`, some don't need `narrative/`. Follow the user's needs.
