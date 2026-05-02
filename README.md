# vibeslop

A product methodology shipped as Claude Code slash commands. Sharp
peer thinking partners across the lifecycle of a product bet — from
choosing what's worth doing to facing whether the work moved the
needle.

These commands don't soften, don't synthesize on top of bad inputs,
and don't produce artifacts until the thinking is real. They are
deliberately rude when you're hand-waving.

## The phases

| Phase | Command | Question it forces |
|-------|---------|--------------------|
| Analyze | [`/vibeslop.analyze`](commands/vibeslop.analyze.md) | What's not working? |
| Plan | [`/vibeslop.plan`](commands/vibeslop.plan.md) | What problem are we solving and is it worth it? |
| Design | [`/vibeslop.design`](commands/vibeslop.design.md) | What does success look like, and what's the smallest version that could earn it? |
| Build | [`/vibeslop.build`](commands/vibeslop.build.md) | Let the team solve the problem their way. |
| Test | [`/vibeslop.test`](commands/vibeslop.test.md) | Catch the gap between what we built and what the customer needs. |
| Launch | [`/vibeslop.launch`](commands/vibeslop.launch.md) | Get the work into customers' hands. |
| Review | [`/vibeslop.review`](commands/vibeslop.review.md) | Did this move the needle? |
| Stats | [`/vibeslop.stats`](commands/vibeslop.stats.md) | What's hiding in your product thinking? |

Each phase writes an artifact at
`.vibeslop/{owner}/{feature}/{phase}.md` in the repo where you run it.
Owner is derived from your git config; feature comes from the command
arg or the current branch name (`NNN-feature-name`).

## Install

These are [Claude Code slash commands](https://docs.claude.com/en/docs/claude-code/slash-commands)
(`<name>.md` with a `description` frontmatter field), not Agent
Skills. They run only inside Claude Code.

### Project-scoped

```bash
# from your project root
git clone https://github.com/OR13/vibeslop .vibeslop
mkdir -p .claude
ln -sf ../.vibeslop/commands .claude/commands
```

If you already have a `.claude/commands/` directory you want to keep,
symlink the individual files instead:

```bash
git clone https://github.com/OR13/vibeslop .vibeslop
mkdir -p .claude/commands
for f in .vibeslop/commands/vibeslop.*.md; do
  ln -sf "../../$f" ".claude/commands/$(basename "$f")"
done
```

Pull updates with `git -C .vibeslop pull`.

### User-scoped

```bash
git clone https://github.com/OR13/vibeslop ~/.vibeslop
mkdir -p ~/.claude/commands
for f in ~/.vibeslop/commands/vibeslop.*.md; do
  ln -sf "$f" ~/.claude/commands/
done
```

After install, restart Claude Code and the commands appear under
`/vibeslop.*`.

## Voice

Each command shares a deliberate stance:

> Sharp peer, not polite assistant. The user decides; the command
> makes the thinking real. Push back, name what's being avoided, and
> refuse to produce the artifact until the answers are honest.

If you want a polite assistant, this isn't the right toolkit.

## Contributing

PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md). Each command
should:

- Live at `commands/vibeslop.<phase>.md`
- Open with a `description:` frontmatter line (Claude Code reads this
  as the trigger summary)
- Carry the same voice — rude on hand-waving, specific in pushback,
  no artifact until the thinking lands
- Write its artifact to `.vibeslop/{owner}/{feature}/{phase}.md` and
  honor the same idempotency rules (create / update-in-place /
  timestamped-side-by-side)

## License

MIT — see [LICENSE](LICENSE).
