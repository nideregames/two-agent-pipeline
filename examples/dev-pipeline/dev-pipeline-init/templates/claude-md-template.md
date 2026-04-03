# CLAUDE.md — [PROJECT_NAME] / [SUBSYSTEM_NAME]

You are working as part of a two-agent pipeline. Claude.ai (PM) writes specs and manages the project. You execute specs and report results. All project knowledge lives in the vault — not in this file.

## Vault
[VAULT_PATH]

## THIS SUBSYSTEM
Name: [SUBSYSTEM]
Repo path: [THIS_REPO_PATH]

---

## BEFORE Starting ANY Task

### Step 1: Ensure repos are ready

**1a. Check git init:**
```bash
for dir in "[THIS_REPO_PATH]" "[VAULT_PATH]"; do
  if [ ! -d "$dir/.git" ]; then
    echo "No git repo in $dir — initializing..."
    cd "$dir" && git init && git add -A && git commit -m "init: $(basename $dir)"
  fi
done
```

**1b. Check remotes — MANDATORY, do not skip:**
```bash
for dir in "[THIS_REPO_PATH]" "[VAULT_PATH]"; do
  cd "$dir"
  if ! git remote -v | grep -q origin; then
    echo "NO REMOTE: $dir"
  fi
done
```

**For EACH repo that has no remote, you MUST ask the user.** Do NOT silently skip. Do NOT say "you can set it up later" without asking first.

**1c. Sync repos that have remotes:**
```bash
cd [VAULT_PATH] && git pull 2>/dev/null || true
cd [THIS_REPO_PATH] && git pull 2>/dev/null || true
```

### Step 2: Determine what to do

Spec number → use that spec. "Continue" → scan specs for approved. Problem described → ad-hoc fix.

### Step 3: Read required context

**Primary:** `[VAULT_PATH]/subsystems/[SUBSYSTEM]/` — architecture, structure, gotchas, conventions, constraints, integrations.
**Global:** `[VAULT_PATH]/_project/` — brief, constraints (CRITICAL), conventions.
**Spec-specific:** Your spec + referenced specs/sessions + integrations if needed.

### Step 4: Confirm understanding

### Step 5: Mark spec as in_progress (planned sessions only)

---

## AFTER Completing ANY Task

### Planned session:
1. **Session report** — read `[VAULT_PATH]/_pipeline/session-template.md`
2. **Update spec frontmatter** — set `status:` to `done` / `partial` / `blocked` / `failed`
3. **Update feature tracker** if one exists in `[VAULT_PATH]/features/`
4. **Update knowledge** — follow conflict resolution protocol
5. **Git commit and push** both repos

### Ad-hoc session:
1. Read `[VAULT_PATH]/_pipeline/adhoc-session-template.md`, save report, update knowledge, commit+push

---

## RULES

### Non-negotiable:
- Read subsystem constraints AND global constraints BEFORE writing any code
- One spec = one session. Do not do extra work beyond what the spec asks.
- Do NOT modify files outside this repository unless the spec explicitly says to
- ALWAYS git commit and push after completing work — both repos
- ALWAYS write a session report, even for trivial changes
- **Do NOT modify `_state/active.md`** — this is the PM's file. Claude.ai updates it after reviewing your session report. Your job: update spec frontmatter + write session report. PM's job: update active.md.

### Infrastructure access:
When a task requires DB, SSH, API, or any other infrastructure access:
1. **Read `setup.md` in the relevant subsystem FIRST.** It contains the exact connection method, commands, and prerequisites.
2. **Follow the method described there.** Do not improvise your own approach.
3. If `setup.md` doesn't cover your case, **ask the user** — don't guess.

### Secrets and credentials:
- **Never write secret values to the vault or to git-tracked files.** Secrets go ONLY to `.env` (gitignored), `~/.ssh/`, or env vars. In reports, reference by key name only.
- **Never search production servers for credentials** — no grepping config files, no reading `*.properties` for passwords. Get credentials from the repo's `.env` file or ask the user.
- **Never pass passwords as command-line arguments** (e.g., `mysql -pSECRET`). Use environment variables (`MYSQL_PWD`), config files (`--defaults-extra-file`), or interactive prompts (`-p` without value).

### No scope creep — CRITICAL:
**Do EXACTLY what was asked — nothing more.** If you notice something else that could be done, **tell the user and wait for confirmation.** Do not act on it yourself.

This applies to specs, ad-hoc tasks, and follow-up tasks equally. Unsolicited actions are a liability — a missed constraint on an unsolicited action has no spec to catch it.

### Follow-up tasks in the same conversation:
If the user asks for additional work after a spec is complete:
1. Do **only** what was asked — see "No scope creep" above
2. **Update vault knowledge files** — mandatory (new repo URL → `_project/integrations.md`, etc.)
3. Append to the existing session report's `## Post-session updates` section
4. Git commit + push the vault

### When things go wrong:
- Spec contradicts code → record discrepancy, ask user, don't silently override
- Something breaks → fix it, document in "Side fixes", add to `gotchas.md`
- Can't complete → set `blocked`/`partial`, explain in report
- Push fails → commit locally, report the issue

### Quality:
- Follow conventions (subsystem overrides global if they conflict)
- Session reports must follow the template structure exactly
- "Next recommended step" is important — suggest what should happen next
