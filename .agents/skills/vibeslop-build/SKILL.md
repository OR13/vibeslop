---
name: vibeslop-build
description: "Build-phase skill for the vibeslop product methodology. Helps the team solve the problem their way."
---

# Vibeslop Build: Let the team solve the problem their way

## User Input

The feature description is whatever the agent's harness passed as input to this skill.
If empty and a `.vibeslop/` directory exists, look for the most recent feature context.
If still empty, ask the user what feature they want to think about.

## Roles Required

- **Lead**: Product Manager (coordinator — always present)
- **Contributors**: Engineers, Engineering Lead
- **Optional**: Security Engineer

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` → `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine feature name**:
   - If user provided an argument: use it as the feature name (kebab-case)
   - Else check current git branch: if it matches `NNN-feature-name` pattern, extract `feature-name`
   - Else scan `.vibeslop/{owner}/` for most recent directory
   - Else ask the user: "What feature are you working on?"

3. **Discover existing artifacts**: Scan `.vibeslop/{owner}/{feature-name}/` for any existing phase artifacts. Read them as optional context — they inform your thinking but are never required. If `plan.md` and `design.md` artifacts exist, carry forward the approved problem framing, engagement cycle, bet scope, and design boundaries.

4. **Research the project**: Read relevant source code, README, recent git commits, and any project documentation to understand the current state.
   - **Ritual Search**: Look for evidence of **Daily Standups**, **Pair Programming**, **Code Review** feedback, or **Secure Coding** checklists.
   - **Tool Context**: Check for data in **Sentry** (errors), **GitHub** (PRs/CI), **Claude Code / Copilot** (generative context), **Snyk** (vulnerabilities), **Vercel** (previews), or **Supabase** (migrations).
   Prioritize project-specific insights over generic advice.

### Step 2: Stage Loop

Execute exactly 3 stages. For each stage, research and synthesize an insight, present it to the user, and wait for approval before proceeding.

**Roles to consider**: Engineers, Engineering Lead, Product Manager, Security Engineer — weave their perspectives into each stage naturally.

---

**Stage 1: "Are we building toward the outcome?"**

Research and synthesize:
- Every PR or change should reference the job statement it serves and the outcome it moves. If a change can't be traced back to an underserved outcome, push back on it.
- Track which job each piece of work serves — no orphan features. Every line of code should connect to something the user is trying to accomplish.
- If spec and job diverge during build, flag it immediately. The spec serves the job, not the other way around.
- Consider Sales' pipeline urgency — are there deals waiting on specific capabilities? And Customer Success's support ticket patterns — are we building toward the pain users actually report?
- Review the project's current state: what exists, what's partially built, what needs to change.

Present a concise draft that includes: job-to-work mapping, orphan feature audit, any spec-job divergence found, and pipeline/support alignment. Keep it readable in under 30 seconds.

Ask: **"Are we building toward the right outcome? Approve, or tell me what to change."**

---

**Stage 2: "What's the critical path?"**

**Mode detection**: Check team context to determine execution mode:
- **Solo vibe-coder mode** (default — single contributor, agent IS the team): This stage **executes code**, not just plans. The agent reads Plan + Design artifacts, identifies the critical path, and actually creates/edits files, runs commands, and builds the feature.
- **Team mode** (multiple contributors detected): This stage produces a critical path planning document for the team to execute.

**Solo vibe-coder mode** — Research, then execute:
- Read the Design artifact's core action and scope boundaries. Identify the smallest set of files/changes that deliver the critical path.
- **Actually write the code**: create files, edit existing code, run build/test commands. Ship the core action first, then layer on supporting pieces.
- **Optimize for Speed**: Target **latency targets** for the core action — the one thing users do most should be fastest.
- Build persistence for user investments (content, preferences, connections, history) — these must survive across sessions.
- After writing code, present a summary of what was built: files created/modified, commands run, and what remains.

**Team mode** — Research and synthesize (building on approved Stage 1):
- **Latency Targets**: Optimize the core action for minimum latency — the one thing users do most should be fastest. Every millisecond of friction on the critical path is a design failure.
- **Variability Systems**: Build systems that generate reward variability, not static content. Users should get something slightly different each time — not necessarily bigger, just surprising.
- Build persistence for user investments: content they create, connections they make, preferences they set, history they accumulate. These must survive across sessions.
- Ensure investments are visible on return — the product should feel "mine" the moment a user comes back. If it feels like starting over, the investment layer failed.
- Reduce friction at every step of the engagement cycle: trigger → action → reward → investment → loaded next trigger.
- Present a concise draft of: the critical path (with latency targets), **variability system design**, investment persistence layer, return experience, and friction audit.

Ask: **"Is this the right critical path? Approve, or tell me what to change."** (In solo mode: **"Here's what I built. Approve, or tell me what to change."**)

---

**Stage 3: "How should the team work?"**

Research and synthesize (building on approved Stages 1 and 2):
- Small batches, continuous integration, trunk-based development. Ship small, ship often, keep the main branch deployable.
- **Ritual Focus**: Standups surface blockers, not status reports. Pair programming on complex unknowns and security-sensitive paths.
- Code review checks outcome alignment alongside code quality — does this PR move the outcome metric, not just pass lint?
- **Secure Coding**: Implement threat model mitigations from the Plan phase — don't defer security to a later sprint. Security debt compounds faster than technical debt.
- Secure coding practices: input validation, output encoding, least privilege, dependency auditing.
- What agents handle (scaffolding, CI, progress tracking) vs. what humans own (design decisions, customer context, go/no-go calls).

Present a concise draft of: team workflow (batch size, branching, CI), standup format, pairing targets, review checklist, security implementation plan, and agent/human split.

Ask: **"Is this how the team should work? Approve, or tell me what to change."**

---

For each stage:
- If user approves (or says nothing significant to change): record the approved content and proceed to the next stage
- If user provides corrections: incorporate the feedback, regenerate the stage content, and re-present
- If user wants to skip: note that the stage was skipped and proceed
- Each subsequent stage builds on approved content from previous stages

### Step 3: Artifact Write

After all 3 stages are approved:

1. **Assemble the artifact**: Combine all approved stage content into a single cohesive document. It should read as a unified product document, not 3 separate chunks.

2. **Check git status**:
   - Run: `git status --porcelain -- .vibeslop/{owner}/{feature-name}/build.md`
   - If the file exists AND git status returns empty (committed): create a new timestamped version at `.vibeslop/{owner}/{feature-name}/build-{YYYYMMDD-HHMMSS}.md`
   - If the file exists AND git status returns non-empty (uncommitted): update it in place
   - If the file doesn't exist: create it

3. **Ensure directory exists**: Create `.vibeslop/{owner}/{feature-name}/` if it doesn't exist.

4. **Write the artifact** to the determined path.

5. **Confirm to user**: Tell the user where the artifact was written and suggest: "Run `vibeslop-test` to continue to the Test phase."

### Adaptive Depth

- For small features (single file, minor change): keep each stage to 3-5 lines. Don't force depth where there isn't any.
- For large features (new product area, multi-component): go deeper, surface more perspectives, identify more risks.
- The methodology coverage should be complete either way — just proportionally scoped.

### Artifact Format

```
# Build: {Feature Name}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Feature**: {feature-name}

## Are we building toward the outcome?

{Approved content from Stage 1}

## What's the critical path?

{Approved content from Stage 2}

## How should the team work?

{Approved content from Stage 3}

## Decisions

- **outcome-alignment**: "{confirmed/diverged} — {evidence}"
- **critical-path**: ["{ordered list of what was built or must be built}"]
- **execution-mode**: "{solo-vibe-coder/team}"
- **files-changed**: ["{files created or modified, if solo mode}"]
- **team-process**: "{batch size, branching strategy, CI status}"
- **next-phase**: test
- **agents-needed-next**: [Engineer, QA]
- **open-questions**: ["{any unresolved items}"]
```

No methodology labels. Section headers are the product questions.
