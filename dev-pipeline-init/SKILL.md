---
name: dev-pipeline-init
description: >
  Initialize or migrate a project to the Claude.ai + Claude Code development pipeline using an Obsidian vault as shared memory. Use this skill whenever the user says "initialize vault", "create vault", "set up pipeline", "migrate project to pipeline", "create CLAUDE.md", "set up dev pipeline", "init pipeline", or asks to create the vault structure for a new or existing project. Also trigger when the user mentions setting up communication between Claude.ai and Claude Code via a shared vault.
---

# Dev Pipeline Init

**This skill is for Claude.ai (PM role) only.** Claude Code should NOT use this skill — Claude Code follows `CLAUDE.md` in each repository, not this skill. If Claude Code is reading this, stop and follow your repository's `CLAUDE.md` instead.

This skill handles two scenarios:
1. **New project** — create a vault from scratch
2. **Existing project** — migrate scattered knowledge (CLAUDE.md files, chat history) into the vault

Both scenarios produce the same result: a fully structured project vault that enables the two-agent pipeline.

## Important: Claude.ai limitations

You (Claude.ai) can only create and edit files via Filesystem MCP tools. You CANNOT run bash commands like `git init`, `git commit`, or `git push`. Git operations are handled by **Claude Code** — the CLAUDE.md template includes a pre-flight check that initializes git repos on first session automatically. Your job is to create files; Claude Code handles the terminal.

## Anti-hallucination rules

These rules apply to ALL vault file creation, especially during migration:

- **Write ONLY what you can verify.** Every fact in a vault file must come from: a file you read, a chat you found via conversation_search, or something the user told you in this conversation. NOTHING else.
- **If you're not sure — leave it blank or write "TBD".** A blank file is better than a file with guesses. Write `<!-- TBD: needs input from user or RECON -->` for anything you can't verify.
- **Never fill in architectural details from general knowledge.** If you know Django typically uses X pattern, but you haven't seen it in the actual project files — don't write it.
- **Cite your source internally.** When writing vault files during migration, add brief HTML comments noting where the info came from: `<!-- from: CLAUDE.md in server/ -->` or `<!-- from: chat search "auth" -->` or `<!-- from: user input -->`. These can be removed later but help during verification.
- **Ask rather than assume.** If the old CLAUDE.md mentions "auth module" but doesn't explain how it works — don't fill in architecture.md with assumptions. Ask the user or mark it as needing a RECON.

## Before starting

Read the templates in this skill's `templates/` directory:
- `templates/pipeline-readme-template.md`
- `templates/ai-instructions-template.md`
- `templates/spec-template.md`
- `templates/recon-spec-template.md`
- `templates/session-template.md`
- `templates/adhoc-session-template.md`
- `templates/claude-md-template.md`
- `templates/root-claude-md-template.md`
- `templates/project-brief-template.md`
- `templates/feature-tracker-template.md`
- `templates/roadmap-template.md`
- `templates/structure-template.md`
- `templates/working-preferences-template.md`
- `templates/active-template.md`
- `templates/backlog-template.md`
- `templates/decisions-template.md`
- `templates/constraints-template.md`
- `templates/gotchas-template.md`
- `templates/integrations-template.md`
- `templates/setup-template.md`
- `templates/gitignore-template` (copy as `.gitignore` to vault root)

These are the canonical templates. Copy them into the vault's `_pipeline/` folder during initialization (pipeline-readme-template.md → `_pipeline/README.md`, ai-instructions-template.md → `_pipeline/ai-instructions.md`).

Additionally, copy the **current project instructions** (the full text from your Claude.ai Project Instructions — the document you're reading right now) into `_pipeline/project-instructions.md`. This is a reference backup — if the user loses access to their Claude.ai account, the full pipeline operating manual is preserved in the vault.

---

## Scenario 1: New Project Initialization

### Step 1: Gather information

Ask the user:
1. **Project root path** — where on disk is the project?
2. **Project name** — what is this project called?
3. **Code sub-projects** — what repositories/folders exist? What does each one do?
4. **Non-code areas** — are there non-code aspects of the project? (marketing, game design, operations, community, content, etc.) These become non-code subsystems.
5. **Tech stack** — languages, frameworks, databases, infra
6. **Current state** — greenfield or in progress? What's already built?
7. **Known constraints** — any "do NOT" rules? (critical to capture early)
8. **Goals and roadmap** — what are we building toward? Any milestones or phases?
9. **Autonomous subsystems** — are any sub-projects large enough to have their own roadmap/backlog? (own release cadence, own milestones, weakly coupled to the rest)
10. **Working preferences** — how does the user prefer to communicate? Technical level? Decision-making style? Fill `_project/working-preferences.md` from their answers and from what you know from memory.

### Step 2: Create vault structure

Using Filesystem tools, create:

```
<project-root>/vault/
├── .gitignore                       # From templates/gitignore-template
├── _pipeline/
│   ├── README.md                    # From templates/pipeline-readme-template.md
│   ├── ai-instructions.md          # From templates/ai-instructions-template.md
│   ├── project-instructions.md     # Full copy of Claude.ai Project Instructions (backup)
│   ├── spec-template.md             # From templates/
│   ├── recon-spec-template.md       # From templates/
│   ├── session-template.md          # From templates/
│   ├── adhoc-session-template.md    # From templates/
│   ├── claude-md-template.md        # From templates/
│   ├── root-claude-md-template.md  # From templates/
│   ├── feature-tracker-template.md  # From templates/
│   ├── roadmap-template.md          # From templates/
│   └── structure-template.md        # From templates/
├── _project/
│   ├── brief.md               # From templates/project-brief-template.md — fill from user's answers
│   ├── architecture.md        # High-level (can be sparse initially)
│   ├── conventions.md         # Code style (can be sparse initially)
│   ├── constraints.md         # From templates/constraints-template.md — CRITICAL
│   ├── gotchas.md             # From templates/gotchas-template.md — start empty
│   ├── integrations.md        # From templates/integrations-template.md
│   └── working-preferences.md # From templates/working-preferences-template.md
├── _state/
│   ├── active.md              # From templates/active-template.md
│   ├── backlog.md             # From templates/backlog-template.md — fill from user's priorities
│   ├── roadmap.md             # From templates/roadmap-template.md — fill from user's goals
│   ├── decisions.md           # From templates/decisions-template.md
│   └── reviewed.md            # Tracks which sessions Claude.ai has read (starts empty)
├── discussions/               # PM ↔ user discussion summaries (YYYY-MM-DD-topic.md)
├── features/                  # Feature trackers (one file per multi-spec feature)
├── subsystems/
│   ├── <code-subsystem>/      # Has a separate code repo on disk + CLAUDE.md
│   │   ├── architecture.md    # HOW it works: layers, data flows, concepts
│   │   ├── structure.md       # WHERE things are: directory tree, key files, modules
│   │   ├── gotchas.md
│   │   ├── conventions.md
│   │   ├── setup.md           # From templates/setup-template.md
│   │   ├── constraints.md     # OPTIONAL — subsystem-specific "do NOT" rules
│   │   ├── integrations.md    # OPTIONAL — APIs/services this subsystem uses
│   │   ├── roadmap.md         # OPTIONAL — only if subsystem has own lifecycle
│   │   └── backlog.md         # OPTIONAL — only if subsystem has own task queue
│   ├── <non-code-subsystem>/  # No separate code repo, but versioned in vault
│   │   ├── architecture.md    # Strategy, processes, workflows
│   │   ├── gotchas.md         # Pitfalls, platform limitations
│   │   ├── conventions.md     # Style guides, tone of voice, rules
│   │   └── tools.md           # Accounts, platforms, tools used
│   └── <lightweight-subsystem>/  # Minimal — e.g., asset files without code
│       ├── architecture.md    # What it is, how it's structured
│       └── gotchas.md         # What to watch out for
├── specs/
└── sessions/
```

### Step 3: Git initialization (handled by Claude Code)

You cannot run git commands. The CLAUDE.md template includes a pre-flight check: when Claude Code first opens any repo, it verifies that both the subsystem repo and the vault have `.git` initialized. If not — it runs `git init` + first commit automatically. It also checks for remotes and offers to create private GitHub repos via `gh` CLI.

**Your only action here**: tell the user that git for all repos (vault and code sub-projects) will be initialized automatically when they first open Claude Code. If the user prefers to set up repos manually beforehand, they can — but it's not required.

### Step 4: Create CLAUDE.md files

**Root CLAUDE.md** (in the project root directory): create using `templates/root-claude-md-template.md`. Fill in project name, vault path, and the sub-project table (code directories only — do NOT include vault/ or non-code subsystems in this table). Use the template exactly — do not add extra sections or information.

**Subsystem CLAUDE.md files** (in each code sub-project directory): create using `templates/claude-md-template.md`, filling in:
- Vault path (absolute path to vault/)
- Subsystem name
- Repo path

**Non-code subsystems do NOT get a CLAUDE.md** — they have no separate code repository. Their knowledge lives in the vault (which is itself versioned via git).

**Slash command** (one-time, user-level): check if `~/.claude/commands/go.md` exists. If not, create it with the content from the `go.md` file included in this skill's root. This gives the user a `/go` command in Claude Code that triggers the CLAUDE.md workflow automatically.

### Step 5: Save vault path to memory

Save the vault path to Claude's memory using the memory tool, so future conversations don't need to ask. Example memory entry: "Vault path for [project name]: [VAULT_PATH]"

### Step 6: Verify with user — file by file

**Do not just show the structure — show the content of each created file.** For every file in `_project/`, show the full content to the user and ask: "Is this accurate? Anything to add or change?" Pay special attention to:
- `_project/constraints.md` — is this complete? Missing constraints cause real damage.
- `_project/brief.md` — is this accurate?
- `_project/working-preferences.md` — does this match how the user likes to work?
- `_state/roadmap.md` — does this reflect the right priorities and phases?
- Sub-project list — did we miss any areas (code or non-code)?

### Step 7: Structural audit

Before proceeding, verify that every subsystem has the required files for its type:

- **Code subsystems** (have a repo + CLAUDE.md): must have `architecture.md`, `gotchas.md`, `conventions.md`, `setup.md`
- **Non-code subsystems** (no repo): must have `architecture.md`, `gotchas.md`, `conventions.md`, `tools.md`
- **Lightweight subsystems**: must have `architecture.md`, `gotchas.md`

Also verify:
- `_pipeline/` contains all 12 template files (README.md, ai-instructions.md, project-instructions.md, and 9 templates)
- `_project/` contains all 7 files (brief, architecture, conventions, constraints, gotchas, integrations, working-preferences)
- `_state/` contains all 5 files (active, backlog, roadmap, decisions, reviewed)
- Root CLAUDE.md exists in project root
- Each code subsystem's repo has a CLAUDE.md

Fix any missing files before moving on. Empty files with TBD comments are fine — missing files are not.

### Step 8: Suggest first RECON

Recommend writing a RECON spec for Claude Code to verify the vault accurately reflects the codebase **and populate `structure.md`** for each code subsystem. This catches assumptions and builds the file map.

---

## Scenario 2: Migrating an Existing Project

### Step 1: Discovery — filesystem scan

1. **Ask the user** for the project root path and project name
2. **List the root directory** using Filesystem:list_directory
3. **Check the root for CLAUDE-like files**: look for ANY file containing "claude" or "CLAUDE" in its name (e.g., `CLAUDE.md`, `l2-CLAUDE.md`, `project-CLAUDE.md`). These often contain project-wide knowledge (infra, deploy, overview). Read all of them.
4. **List all subdirectories** in the root
5. **Ask the user which directories belong to this project.** Do NOT assume all directories are part of the same project — the root may contain unrelated projects side by side. Show the list and ask: "Which of these are part of [project name]?"
6. **For each confirmed sub-directory**, list its contents and look for:
   - Any file with "claude" or "CLAUDE" in the name (not just `CLAUDE.md` — projects often use names like `l2-CLAUDE.md`, `server-CLAUDE.md`, etc.)
   - `.git/` directory (indicates a code repository)
   - `package.json`, `build.xml`, `Cargo.toml`, `setup.py` etc. (indicates code project type)
   - `README.md` (may contain useful project info)
7. **Read all found CLAUDE-like files** — both root-level and sub-repo-level

### Step 2: Discovery — classify what you found

After scanning, present findings to the user.

Ask the user:
- "Is this correct? Did I miss any directories?"
- "Are there non-code areas of this project that should be tracked? (marketing, game design, operations, community?)"
- "For directories without CLAUDE.md — what are these? Should they be subsystems?"

### Step 3: Discovery — chat history

Search past conversations using conversation_search tool:
- Search for: project name, key features, architectural decisions
- Search for: known issues, gotchas, constraints, "do NOT" rules
- Search for: any specs or task descriptions previously discussed
- Search for: non-code topics (marketing, design, content, operations)
- Search for: roadmap, milestones, next steps, priorities

### Step 4: Determine subsystems

Based on all discovery data, propose subsystem list to the user. Wait for user confirmation before proceeding.

### Step 5: Create vault structure

Same as Scenario 1, Step 2. Additionally, fill `_project/working-preferences.md` from what you know about the user from memory and conversations.

### Step 6: Populate knowledge from existing sources

**Remember the anti-hallucination rules.** Only write what you can verify. Mark anything uncertain as TBD. Cite sources in HTML comments.

Distribute knowledge from old CLAUDE.md files, chat history, and user input into the appropriate vault files.

### Step 7: Git initialization (handled by Claude Code)

Same as Scenario 1, Step 3.

### Step 8: Replace CLAUDE.md files

1. **Rename** all existing CLAUDE-like files to `*.bak`
2. **Create root CLAUDE.md** using `templates/root-claude-md-template.md`
3. **Create subsystem CLAUDE.md** in each code repo using `templates/claude-md-template.md`
4. **Install slash command** — same as Scenario 1, Step 4

Use templates exactly as provided — do not add extra sections or information.

### Step 9: Save vault path to memory

Same as Scenario 1, Step 5.

### Step 10: Clean up memory

**Memory is per-project in Claude.ai.** You can only clean up memory if this conversation is running inside the target project. If the migration was done from a different project (e.g., a pipeline design project), memory cleanup is impossible from here.

**If you ARE in the target project:**
Use the memory edit tool to add: "All [PROJECT_NAME] project knowledge now lives in vault at [VAULT_PATH]. Exclude project-specific details from memory (architecture, infra, design, tools, roadmap, constraints, gotchas). Vault is the source of truth."

Then remove any existing memory entries that duplicate vault content. Keep only:
- Vault path
- Project name
- That the project uses the dev pipeline

**If you are NOT in the target project:**
Tell the user: "Memory cleanup needs to happen inside the [PROJECT_NAME] project in Claude.ai. Open a new chat there and say: 'Clean up memory — project knowledge is now in the vault. Follow Step 10 from the pipeline skill.'"

Do NOT skip this step silently. If you can't do it — explicitly tell the user it's pending.

### Step 11: Verify — file by file

Show the user every file created. For each: show content, state source, ask for corrections. Highlight TBD markers. Re-read all old CLAUDE*.bak files and confirm all information is captured.

### Step 12: Structural audit

Same as Scenario 1, Step 7. Fix missing files before suggesting RECON.

### Step 13: RECON spec

Write a RECON spec for Claude Code to audit the vault against the actual codebase and populate `structure.md` for each code subsystem.

---

## Migration Pitfalls

- **Don't create session reports for past work.** The vault tracks work going forward. Past knowledge goes into `_project/` and `_state/`.
- **Don't over-structure initially.** If a subsystem has few gotchas, use global `_project/gotchas.md`. Split later.
- **Constraints are #1 priority.** A missing convention is annoying. A missing constraint causes damage.
- **Old *.bak files can be deleted** once user confirms vault is complete.
- **Don't fill gaps with assumptions.** If you can't verify something — mark it TBD and let the user or a RECON fill it in.
- **Don't assume all directories in the root are part of this project.** Always ask the user.
- **CLAUDE.md files may have non-standard names.** Scan for any file with "claude" in the name, not just `CLAUDE.md`.
- **Root-level CLAUDE.md is project-wide knowledge**, not a subsystem. Distribute its content across `_project/` files.
- **Clean up memory after migration — this is easy to miss.** Memory is per-project, so cleanup only works from within the target project. If migration ran from a different project (e.g., pipeline design), tell the user to open a chat in the target project and clean up there. Stale memory duplicates vault content and will drift over time, causing contradictions.
- **Use CLAUDE.md templates exactly.** Root CLAUDE.md uses `root-claude-md-template.md`, subsystem CLAUDE.md uses `claude-md-template.md`. Do not add extra sections, tables, or content beyond what the template specifies — CLAUDE.md files are thin routers, not knowledge stores.
- **You cannot run terminal commands.** Git initialization and other bash operations are handled by Claude Code (via CLAUDE.md pre-flight checks) or by the user. Do not silently skip steps that require the terminal — inform the user what Claude Code will handle automatically.
