Follow the CLAUDE.md workflow exactly:

0. Check that a root `CLAUDE.md` exists in the project root (one level above this subsystem). If missing — warn me: "Root CLAUDE.md not found at <path>. Run vault migration or create it from `_pipeline/root-claude-md-template.md`." Then continue — this is not a blocker.
1. Run the `ensure_repo` check for this repo and the vault (Step 1 in CLAUDE.md)
2. Scan `vault/specs/` for specs with `status: approved` in frontmatter that match this subsystem
3. If one approved spec found → read the required context (subsystem + global files from vault) and start working
4. If multiple → show the list and ask which one
5. If none → tell me there are no approved specs

Do not ask me to remind you what we were working on. The vault has all the context.
