# Contributing to vibeslop

## Adding a phase skill

1. Create `.agents/skills/vibeslop-<phase>/SKILL.md`.
2. Open with frontmatter (open standard from [agentskills.io](https://agentskills.io)):

   ```markdown
   ---
   name: vibeslop-<phase>
   description: "<phase>-phase command for the vibeslop product methodology. <one sentence on what it forces>."
   ---
   ```

3. Match the existing voice — sharp peer thinking partner, not polite
   assistant. Specific pushback, named pitfalls, refuse-to-produce
   when the inputs are hand-wavy.
4. Write to `.vibeslop/{owner}/{feature}/{phase}.md` with the same
   idempotency rules other phases use (create / update-in-place /
   timestamped side-by-side when the file is already committed).
5. Add a row to the table in [README.md](README.md).
6. Add the skill name to the `SKILLS` list in [install.sh](install.sh) so
   the installer picks it up.
7. Open a PR.

## Editing existing skills

Edits to wording, pushback heuristics, and artifact skeletons are
welcome. For changes to the voice or the artifact contract, open an
issue first or include rationale in the PR.

## Style

- Markdown only.
- Frontmatter: `name` and `description` are required (the open Agent
  Skills standard). Harnesses use `description` as the trigger summary —
  keep it under ~250 characters and lead with the phase label.
- Don't soften the voice. If a heuristic feels rude, that's likely
  correct — these skills exist to surface what a polite assistant
  would skip past.
- Don't add skills outside the lifecycle without discussion. The
  set is meant to stay small and load-bearing.
- Stay harness-agnostic. Don't assume a specific CLI (Claude Code,
  Gemini CLI, etc.) — refer to the agent generically and let the
  invoking harness fill in the slash-command syntax.

## Testing

Run the skill end-to-end inside your agent harness on a real feature
before submitting:

- Verify the description triggers when intended.
- Walk through the prompts; confirm the pushback fires on
  intentionally weak inputs.
- Confirm the artifact lands at the documented path with the
  documented idempotency behavior.

## License

By contributing, you agree your contributions are licensed under the
Apache License 2.0 (see [LICENSE](LICENSE)).
