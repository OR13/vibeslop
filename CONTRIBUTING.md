# Contributing to vibeslop

## Adding a phase command

1. Create `commands/vibeslop.<phase>.md`.
2. Open with frontmatter:

   ```markdown
   ---
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
6. Open a PR.

## Editing existing commands

Edits to wording, pushback heuristics, and artifact skeletons are
welcome. For changes to the voice or the artifact contract, open an
issue first or include rationale in the PR.

## Style

- Markdown only.
- Frontmatter: `description` is required (Claude Code uses it as the
  trigger summary). Keep it under ~250 characters and lead with the
  phase label.
- Don't soften the voice. If a heuristic feels rude, that's likely
  correct — these commands exist to surface what a polite assistant
  would skip past.
- Don't add commands outside the lifecycle without discussion. The
  set is meant to stay small and load-bearing.

## Testing

Run the command end-to-end inside Claude Code on a real feature
before submitting:

- Verify the description triggers when intended.
- Walk through the prompts; confirm the pushback fires on
  intentionally weak inputs.
- Confirm the artifact lands at the documented path with the
  documented idempotency behavior.

## License

By contributing, you agree your contributions are licensed under the
Apache License 2.0 (see [LICENSE](LICENSE)).
