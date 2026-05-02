# Contributing to vibeslop

## Adding a phase skill

The set is intentionally small (4 skills: pitch, sketch, ship, score)
and bounded by spec-kit's scope below it. Adding a fifth skill is a
substantive change — open an issue to discuss the boundary before
opening a PR.

If a new skill is justified:

1. Create `.agents/skills/vibeslop.<name>/SKILL.md`.
2. Open with frontmatter (open standard from [agentskills.io](https://agentskills.io)):

   ```markdown
   ---
   name: vibeslop.<name>
   description: "<one sentence on what the skill helps you think through, and where it slots relative to spec-kit>."
   ---
   ```

3. Match the structure used by the existing skills:
   - **Step 1 — Front-load research.** Read prior artifacts, git state,
     project conventions, available MCPs / CLIs, *and* spec-kit
     artifacts (`.specify/`, `specs/<feature>/`) when present, *before*
     prompting the user. The user lands on a grounded proposal, not an
     empty prompt.
   - **Voice.** Peer thinking partner. Sharp about *its own draft's*
     weak spots — not adversarial to the user. Names frameworks; never
     forces them.
   - **Step 2 — Three proposal rounds.** Each round drafts from
     research, names what's weak in the draft inline, offers a deepen
     pass with a concrete cost, and accepts approve / refine / pass.
   - **Step 3 — Reflect, then write.** Credit any frameworks the user
     engaged with by name. Write the artifact with an `Open soft spots`
     section that preserves anything the user passed on.
4. Write to `.vibeslop/{feature}/{name}.md` with the standard
   idempotency rule (create if missing, otherwise update in place). Git
   tracks evolution across runs — no sidecar files. When spec-kit is
   present, prefer `specs/<feature>/{name}.md` so artifacts cohabit
   with spec-kit's spec.md / plan.md / tasks.md.
5. Add a row to the table in [README.md](README.md).
6. Add the skill name to the `SKILLS` list in [install.sh](install.sh)
   so the installer picks it up.
7. Open a PR.

## Editing existing skills

Edits to wording, the proposal-round content, and artifact skeletons
are welcome. For changes to the voice, the framework principle, or
the artifact contract, open an issue first or include rationale in
the PR.

## Adding a framework

The toolbox grows over time. To add a framework (e.g., a new
prioritization model, a new design heuristic, a new test pattern):

1. Add it where it would actually sharpen a draft — usually inside one
   of the existing skills' proposal rounds or "Pull in when relevant"
   notes.
2. Cite the source. Frameworks need a real reference (paper, book,
   essay, or canonical post) so future readers can dig deeper.
3. Name it consistently the way its source names it (e.g., *Cagan's
   four risks*, *Fogg's six simplicity factors*, *B=MAT*) — don't
   paraphrase into your own label.
4. Mention it in the `## 📚 The toolbox` section of the README so
   discovery is easy.

## Style

- Markdown only.
- Frontmatter: `name` and `description` are required (the open Agent
  Skills standard). Harnesses use `description` as the trigger summary —
  keep it under ~250 characters and lead with the phase label.
- **Gradient, not gate.** The skill always produces an artifact. Soft
  spots ship in the artifact under `Open soft spots`, visible to the
  next phase, rather than blocking on a quality threshold. Engagement
  is rewarded inline; passing is recorded honestly.
- **Frameworks named, not paraphrased.** When a framework would
  sharpen the draft, the skill calls it out by name. Engaging is
  rewarded; passing is recorded as a soft spot. Never forced.
- **Sharp about the draft, not the user.** The skill points at *its
  own draft's* weak spots ("My latency target is a guess"), not at the
  user's. No "you didn't think hard enough." No assistant-mode hedging
  either — plain, concrete, specific.
- **Don't invent data.** When an integration isn't reachable, record
  the gap honestly. Never fabricate metrics, retention curves, or
  satisfaction scores.
- Don't add skills outside the lifecycle without discussion. The set
  is meant to stay small and load-bearing — spec-kit covers the
  engineering substrate, vibeslop covers the product-thinking layers
  around it. Anything that belongs in spec-kit's scope should be a
  spec-kit PR, not a vibeslop one.
- Stay harness-agnostic. Don't assume a specific CLI (Claude Code,
  Gemini CLI, etc.) — refer to the agent generically and let the
  invoking harness fill in the slash-command syntax.

## Testing

Run the skill end-to-end inside your agent harness on a real feature
before submitting:

- Verify the description triggers when intended.
- Walk through the proposal rounds; confirm the skill names *its own*
  weak spots inline rather than interrogating the user.
- Confirm engagement is rewarded — pushing on a framework should make
  the artifact visibly stronger and the reflection step should credit
  the framework by name.
- Confirm passing is honest — items the user passed on should land in
  `Open soft spots`, not get silently dropped.
- Confirm the artifact lands at the documented path with the
  documented idempotency behavior.

## License

By contributing, you agree your contributions are licensed under the
Apache License 2.0 (see [LICENSE](LICENSE)).
