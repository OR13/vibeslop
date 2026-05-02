# Contributing to vibeslop

## Adding a skill

1. Create `skills/<your-skill-name>/SKILL.md`.
2. Open the file with YAML frontmatter:

   ```markdown
   ---
   name: your-skill-name
   description: One sentence that helps an agent decide whether this skill is relevant. The agent reads only the description until the skill is loaded — make it specific.
   ---

   # Your skill name

   ...
   ```

3. Write the body. Keep it task-focused: what to do, in what order, with
   what tools. Prefer concrete examples over abstract guidance.
4. Add a row to the skills table in [README.md](README.md).
5. Open a PR.

## Updating an existing skill

Edits to `SKILL.md` content are welcome. If the change is purely
mechanical (typos, wording), no issue is needed. For behavioral changes,
open an issue first or include rationale in the PR description.

## Style

- Skills must be self-contained — no cross-imports between skills.
- Document any external state paths the skill reads or writes.
- The `description` field in frontmatter is what an agent sees first.
  Lead with the trigger condition ("Use when ..."), keep it under ~250
  characters.
- Plain markdown only. No HTML, no images that aren't strictly
  necessary.

## Testing

Skills are documents, not code, but their *behavior* is whatever an
agent does when it reads them. Before submitting:

- Load the skill into Claude Code or Gemini CLI and run it end-to-end.
- Confirm the description triggers cleanly (no false positives, no
  missed cases).
- If the skill writes state to disk, verify the paths exist or are
  created.

## License

By contributing, you agree your contributions are licensed under the
MIT License (see [LICENSE](LICENSE)).
