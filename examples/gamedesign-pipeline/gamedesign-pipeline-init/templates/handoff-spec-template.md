---
id: "NNN"
status: draft
domain: DOMAIN
feature: FEATURE
type: handoff
depends_on: []
created: YYYY-MM-DD
---

<!-- Spec lifecycle: draft → approved → in_progress → done / partial / blocked / failed / cancelled -->
<!-- A handoff spec tells the Executor to compile a final document ready for the dev team. -->

# NNN: HANDOFF — [Feature name] for development

## Task
Compile a production-ready design document for [feature] that the development team can implement from.

## Source material
<!-- Design specs and research that feed into this handoff -->
- [[specs/NNN-design-spec]]
- [[specs/NNN-research]]
- [[domains/DOMAIN/overview]]
- Decision log entries: [dates/topics from _state/decisions.md]

## Deliverable
- Create: `handoffs/NNN-feature-name.md`
- Audience: developers, QA, producers — people who will build this
- **Must be self-contained** — reader should not need to browse the vault

## Required sections
The handoff document must include:
1. **Overview** — what this feature is, why it exists, how the player experiences it
2. **Detailed specification** — every parameter, rule, edge case
3. **UI/UX flow** — screens, transitions, states (text descriptions; wireframes attached separately if available)
4. **Data model** — what entities, fields, relationships are needed
5. **Content requirements** — what art/audio/text assets are needed
6. **Balance parameters** — all tunable numbers with initial values and rationale
7. **Edge cases & error states** — what happens when things go wrong
8. **Analytics events** — what to track, expected funnels
9. **Acceptance criteria** — how QA verifies this works correctly
10. **Out of scope** — what is explicitly NOT part of this feature

## Acceptance Criteria
- [ ] Self-contained: a developer unfamiliar with the vault can understand the feature
- [ ] No TBDs or open questions remain
- [ ] All numbers have specific values (not "TBD" or "to be balanced")
- [ ] Edge cases covered
- [ ] Consistent with current live game state described in domain docs

## Validation
- Cross-check all numbers against domain balance models
- Verify UI flow covers all entry/exit points
- Confirm no contradictions with constraints.md
- Read as if you're a developer seeing this for the first time — is anything ambiguous?

## Constraints
- Do NOT include internal pipeline context (spec IDs, session references, vault paths)
- Do NOT leave design decisions for the dev team — all decisions must be made
- Write for the dev team's context, not for AI agents

## Post-task
1. Create session report: `sessions/NNN-domain-title.md`
2. Update spec frontmatter: `status: done`
3. Update feature tracker: mark as "ready for handoff"
4. Update `_state/active.md` note: handoff delivered
