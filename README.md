# vibeslop

A small, opinionated set of [Agent Skills](https://agentskills.io) for
Claude Code, Gemini CLI, and any other agent harness that follows the
open-standard `<name>/SKILL.md` layout.

## Skills

| Skill | What it does |
|-------|--------------|
| [`social-config`](skills/social-config/SKILL.md) | View / modify social-media posting preferences. |
| [`post-content`](skills/post-content/SKILL.md) | Draft and publish hot takes to Bluesky and X.com. |
| [`discover-accounts`](skills/discover-accounts/SKILL.md) | Find candidate accounts to follow via seed crawl + platform search. |
| [`filter-follows`](skills/filter-follows/SKILL.md) | Audit followed accounts and recommend unfollows for off-topic content. |
| [`memory-reflect`](skills/memory-reflect/SKILL.md) | Persist durable items from a conversation into a Letta-style context repository. |
| [`memory-defrag`](skills/memory-defrag/SKILL.md) | Audit a context repository and consolidate toward 15–25 focused files per tier. |

Each skill is a single `SKILL.md` with YAML frontmatter
(`name`, `description`) followed by markdown instructions. That format is
the [Agent Skills](https://agentskills.io) open standard, and is read
natively by Claude Code (`.claude/skills/<name>/SKILL.md`) and Gemini CLI
(`.agents/skills/<name>/SKILL.md`).

## Install

### Project-scoped (recommended)

Clone the repo into your workspace and symlink the `skills/` directory at
the path your agent harness reads from:

```bash
# from your project root
git clone https://github.com/OR13/vibeslop .vibeslop

# Claude Code
mkdir -p .claude && ln -sf ../.vibeslop/skills .claude/skills

# Gemini CLI
mkdir -p .agents && ln -sf ../.vibeslop/skills .agents/skills
```

Pull updates with `git -C .vibeslop pull`.

### User-scoped

For a global install across all projects:

```bash
git clone https://github.com/OR13/vibeslop ~/.vibeslop
ln -sf ~/.vibeslop/skills ~/.claude/skills
```

### Cherry-pick individual skills

Skills are independent; you can symlink them one at a time:

```bash
git clone https://github.com/OR13/vibeslop ~/.vibeslop
ln -sf ~/.vibeslop/skills/post-content ~/.claude/skills/post-content
```

## Requirements

The social-media skills (`social-config`, `post-content`,
`discover-accounts`, `filter-follows`) read and write state in
`$OVERMIND_ROOT/.git-ignored/social-media/`. They were extracted from
[overmind](https://github.com/OR13/overmind) and currently expect that
env var to be set. Outside overmind, point `OVERMIND_ROOT` at any
writable directory you'd like to use for state — generalizing this path
is tracked as future work.

The memory skills (`memory-reflect`, `memory-defrag`) implement the
[Letta context-repository pattern](https://www.letta.com/blog/context-repositories)
and assume a `memory/` directory layout with `memory/*.md` (auto-loaded
top-level) and `memory/<topic>/...` (on-demand nested) tiers, optionally
plus a `memory/private/` mount. Adapt as needed for your harness.

## Contributing

PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md). Each skill should:

- Live at `skills/<name>/SKILL.md`
- Open with valid YAML frontmatter (`name`, `description` required;
  `description` is what triggers the skill, so write it carefully)
- Be self-contained — no cross-skill imports, and any external state
  paths should be documented in the skill body

## License

MIT — see [LICENSE](LICENSE).
