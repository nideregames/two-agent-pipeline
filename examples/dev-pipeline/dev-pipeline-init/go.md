Follow the CLAUDE.md workflow exactly:

1. Run the `ensure_repo` check for this repo and the vault (Step 1 in CLAUDE.md)
2. Scan `vault/specs/` for specs with `status: approved` in frontmatter that match this subsystem
3. If one approved spec found → read the required context (subsystem + global files from vault) and start working
4. If multiple → show the list and ask which one
5. If none → tell me there are no approved specs

Do not ask me to remind you what we were working on. The vault has all the context.
