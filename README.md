# ⚡ Vibeslop

> *"Ship products, not features."*

Product delivery skills for any AI coding agent — packaged as vendor-neutral [Agent Skills](https://agentskills.io). Apply **four proven methodologies** across every phase of development. One install. Seven skills. Continuous improvement. 🔄

### 🌐 [See the interactive methodology → or13.io/vibeslop](https://or13.io/vibeslop)

## 🔄 The Cycle

```mermaid
graph LR
    P["🎯 Plan"] --> D["💎 Design"]
    D --> B["⚡ Build"]
    B --> T["🔮 Test"]
    T --> R["🧬 Review"]
    R --> L["🔥 Launch"]
    L --> A["🌊 Analyze"]
    A -->|next cycle| P

    style P fill:#10b981,stroke:#059669,color:#fff
    style D fill:#8b5cf6,stroke:#7c3aed,color:#fff
    style B fill:#f59e0b,stroke:#d97706,color:#fff
    style T fill:#3b82f6,stroke:#2563eb,color:#fff
    style R fill:#ec4899,stroke:#db2777,color:#fff
    style L fill:#ef4444,stroke:#dc2626,color:#fff
    style A fill:#06b6d4,stroke:#0891b2,color:#fff
```

| Skill | Phase | *The Vibe* |
|---------|-------|-----------|
| `vibeslop-plan` | 🎯 Plan | *"Choose what's worth building next"* |
| `vibeslop-design` | 💎 Design | *"Sketch the solution at the right altitude"* |
| `vibeslop-build` | ⚡ Build | *"Let the team solve the problem their way"* |
| `vibeslop-test` | 🔮 Test | *"Catch the gap between built and needed"* |
| `vibeslop-review` | 🧬 Review | *"Face whether the work moved the needle"* |
| `vibeslop-launch` | 🔥 Launch | *"Get the work into customers' hands"* |
| `vibeslop-analyze` | 🌊 Analyze | *"Name what's not working"* |

## 🚀 Install

```bash
curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash
```

> 📦 **One-liner** · 🚫 **No dependencies** · 🔌 **Speckit optional**

Update to the latest:

```bash
curl -fsSL https://raw.githubusercontent.com/or13/vibeslop/main/install.sh | bash -s -- --force
```

## 🤝 Harness compatibility

Vibeslop ships skills in the open [agentskills.io](https://agentskills.io) format — `.agents/skills/<name>/SKILL.md` per skill — alongside the [agents.md](https://agents.md) project convention.

| Harness | How it picks up the skills |
|---|---|
| Gemini CLI | Auto-discovers `.agents/skills/` |
| Claude Code | Reads `.claude/skills/` — installer creates a `.claude/skills` → `.agents/skills` symlink for you |
| Any agents.md-compliant agent | Reads `.agents/skills/` directly |

The installer writes to `.agents/skills/` by default, so any harness following the standard sees the same seven skills. Earlier versions of vibeslop installed Claude-Code-only files into `.claude/commands/`; re-run the installer to migrate.

## ✨ How It Feels

You invoke a skill. The agent researches your codebase, drafts a proposal for the first round, and **names what's weak about its own draft**:

```
🎯 Plan — Round 1: The bet (mode: solo)

📰 Press release: "Squinting at bright screens at night? Switch to dark
   mode in one tap from any screen."

❓ Customer FAQ (3 of 5):
   Q: Will it remember my preference? A: Yes, per-device.
   Q: Does it work on the marketing site? A: No — that's deferred.
   Q: What about images and videos? A: Auto-dimmed; flag if wrong.

💸 Cost of inaction: support tickets show ~12/week mention eye strain.
   Six months → ~300 tickets, plus the SEO hit from competitors shipping
   first.

⚠️ My own soft spots:
   - The 12/week number is a sample, not the full ticket data — pull
     from HubSpot? (~3 min)
   - "Auto-dimmed images" is a guess at scope. Cagan's feasibility risk
     is where I'm thinnest.

Want to push on any of those, approve as-is, or pass?
```

You approve, refine, or pass. Soft spots you pass on land in the artifact under "Open soft spots" — visible to the next phase, not silenced. The artifact is written when all rounds are done. 🌐 **[See the interactive methodology →](https://or13.io/vibeslop)**

## 📐 Principles

The skills share six assumptions. Knowing them upfront tells you what to expect — and what *not* to expect.

1. **Gradient, not gate.** The skill produces an artifact at whatever level of engagement you bring. Engagement makes it sharper; the skill never refuses to write because the thinking is thin. Unresolved items ship in the artifact under "Open soft spots" — visible, not hidden.

2. **Frameworks named, not paraphrased.** When a framework would sharpen the current draft — Cagan's four risks, B=MAT, the Hook Model, Shape Up appetites, Secure Coding from the threat model, and others (the library grows) — the skill calls it out by name. Engaging with a framework is rewarded inline; passing on one is recorded as a soft spot. Never forced.

3. **Skill does its homework first.** Each skill front-loads research — prior artifacts, git state, related code, available MCPs / CLIs — before asking you anything. You land on a grounded proposal, not an empty prompt.

4. **Self-criticism inline.** Proposals name their own weak spots: *"I drafted X, but I'm guessing about Y — want to push on it?"* You react to specific soft spots, not generic open questions.

5. **Solo and team both work.** Each skill detects mode (`CODEOWNERS`, committer diversity in `git log`) and adapts. In solo mode, the agent fills the missing engineering roles — actually writes code, runs commands, builds the critical path. In team mode, the agent produces planning artifacts the team executes.

6. **Iteration compounds, then gets committed.** Re-running a phase updates the artifact in place; git tracks the evolution. Your second run is smarter than your first because the prior commit is one `git log` away. Uncommitted changes get overwritten on the next run — each skill nudges you once, no nagging.

## 📚 The toolbox

The skills aren't a methodology with a fixed framework count. They're a peer thinking partner that draws on a growing library — Working Backwards, Cagan's four risks, JTBD, B=MAT, Fogg's six simplicity factors, the Hook Model, Shape Up appetites, Secure Coding, and more — and reaches for whichever sharpens the current draft. The toolbox grows over time. PRs adding frameworks (with citations) welcome.

## 🚀 Self-Deploying

**Launch** doesn't just write an artifact — it commits and pushes your code (with your approval). **Analyze** verifies the published state matches local. The skills practice what they preach.

## 🔌 Speckit Integration

Works standalone or with [speckit](https://github.com/or13/speckit) for feature directory management:

- **With speckit**: Artifacts go to `plan.md` in the active feature directory
- **Without speckit**: Artifacts go to `plan.md` in the current directory

## 📋 Requirements

- An AI coding agent that supports the [Agent Skills](https://agentskills.io) standard (e.g., Claude Code, Gemini CLI, or any [agents.md](https://agents.md)-compliant tool)
- `curl` (for installation)

## 🤝 Contributing

PRs welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## 📄 License

Apache 2.0 — see [LICENSE](LICENSE).

---

<p align="center">
  🌐 <a href="https://or13.io/vibeslop"><strong>or13.io/vibeslop</strong></a> · Built with vibeslop ⚡
</p>
