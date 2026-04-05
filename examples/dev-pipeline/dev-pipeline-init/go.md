Follow the CLAUDE.md workflow exactly:

0. Check that a root `CLAUDE.md` exists in the project root (one level above this subsystem). If missing — warn me: "Root CLAUDE.md not found at <path>. Run vault migration or create it from `_pipeline/root-claude-md-template.md`." Then continue — this is not a blocker.
1. Run the `ensure_repo` check for this repo and the vault (Step 1 in CLAUDE.md)
2. Scan `vault/specs/` for specs with `status: approved` in frontmatter that match this subsystem

3. Pick the spec to work on based on `$ARGUMENTS`:
   - If empty → if one approved spec — use it; if multiple — show the list and ask; if none — say there are no approved specs.
   - If a number (digit or word, e.g. "6", "six") → find the approved spec whose filename starts with that number. If not found or not approved → say "No approved spec #N found."
   - If "next" → pick the approved spec with the lowest number.
   - If "last" or "latest" → pick the approved spec with the highest number.
   - Otherwise treat `$ARGUMENTS` as a keyword search — find the approved spec whose filename or title best matches. If ambiguous, show matches and ask.

4. Read the required context (subsystem + global files from vault) and start working.

Do not ask me to remind you what we were working on. The vault has all the context.
