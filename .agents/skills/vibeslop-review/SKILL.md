---
name: vibeslop-review
description: "Review-phase skill for the vibeslop product methodology. Helps face whether the work moved the needle."
---

# Vibeslop Review: Face whether the work moved the needle

## User Input

The feature description is whatever the agent's harness passed as input to this skill.
If empty and a `.vibeslop/` directory exists, look for the most recent feature context.
If still empty, ask the user what feature they want to review.

## Roles Required

- **Lead**: Product Manager (coordinator — always present)
- **Contributors**: Engineering Lead, Sales, Customer Success
- **Optional**: Marketing

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` → `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine feature name**:
   - If user provided an argument: use it as the feature name (kebab-case)
   - Else check current git branch: if it matches `NNN-feature-name` pattern, extract `feature-name`
   - Else scan `.vibeslop/{owner}/` for most recent directory
   - Else ask the user: "What feature are you working on?"

3. **Discover existing artifacts**: Scan `.vibeslop/{owner}/{feature-name}/` for any existing phase artifacts. Read them as optional context — they inform your thinking but are never required. Pay special attention to `build.md` and `launch.md` artifacts for shipped scope and rollout details.

4. **Research the project**: Read relevant source code, README, recent git commits, and any project documentation to understand the current state.
   - **Ritual Search**: Look for evidence of **Sprint Reviews**, **Demo Days**, **Stakeholder Feedback** notes, or **Security Audit** results.
   - **Tool Context**: Check for data in **GitHub** (deploy frequency), **speckit** (quality validation), **Notion** (decision logs), or **Clarity** (session replays).
   Prioritize project-specific insights over generic advice.

### Step 2: Stage Loop

Execute exactly 3 stages. For each stage, research and synthesize an insight, present it to the user, and wait for approval before proceeding.

**Roles to consider**: Product Manager, Engineering Lead, Sales, Customer Success, Marketing — weave their perspectives into each stage naturally.

---

**Stage 1: "Did we help the customer make progress?"**

Research and synthesize:
- Review against the original job statement, not just the spec — the job is the truth. If the plan artifact has a job statement, measure against it directly.
- Measure concrete progress: job completion rate, time-to-value, satisfaction gap closure (did the importance x satisfaction score improve?).
- Check switching behavior: did customers stop using their old workaround? If they're still using the workaround alongside the new solution, the job isn't done.
- If spec and job statement diverged during build, note the divergence and assess whether it served the customer or just served the schedule.
- Pull in Sales' perspective on deal velocity changes and Customer Success's view on support ticket trends since launch.

Present a concise draft that includes: progress against the job statement, satisfaction gap movement, switching evidence, and any spec/job divergence. Keep it readable in under 30 seconds.

Ask: **"Does this capture the real progress? Approve, or tell me what to change."**

---

**Stage 2: "Is the experience becoming a habit?"**

Research and synthesize (building on approved Stage 1):
- Track cycle completion rate: what percentage of users complete the full engagement cycle (trigger → action → reward → investment) per session?
- Measure inter-session interval — decreasing = habit forming, increasing = losing them. Compare the first-week interval to the current interval.
- Identify the biggest drop-off point in the engagement cycle — where do users stop? The drop-off point tells you what to fix next.
- Assess whether the investment step is generating enough stored value to pull users back. If users aren't investing (saving preferences, creating content, building history), the next trigger has nothing to load.
- Pull in Marketing's perspective on content and messaging effectiveness — are external triggers converting to first-cycle completions?

Present a concise draft of habit formation status: cycle completion rate, interval trends, biggest drop-off, and investment quality. Keep it readable in under 30 seconds.

Ask: **"Does this habit assessment ring true? Approve, or tell me what to change."**

---

**Stage 3: "What shipped and what did we learn?"**

Research and synthesize (building on approved Stages 1 and 2):
- Demo the user journey end-to-end, not features in isolation. Walk through the actual shipped experience from the user's first trigger to their first investment.
- Produce a clear shipped/cut/carried-forward list with outcome data for each bet. Every item from the original scope should be accounted for.
- Identify which bets paid off (with evidence) and which missed (with evidence + next action). Honest accounting matters more than a good story.
- Security audit results from the build — any vulnerabilities introduced, any outstanding items.
- What agents handled vs. what humans owned — was the split right? Where did agents over- or under-perform expectations?
- Pull in Engineering Lead's assessment of system health and technical debt accumulated during the build.

Present a concise draft of the shipped inventory: journey walkthrough, bet outcomes, security status, and agent/human retrospective. Keep it readable in under 60 seconds.

Ask: **"Is this an honest accounting? Approve, or tell me what to change."**

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
   - Run: `git status --porcelain -- .vibeslop/{owner}/{feature-name}/review.md`
   - If the file exists AND git status returns empty (committed): create a new timestamped version at `.vibeslop/{owner}/{feature-name}/review-{YYYYMMDD-HHMMSS}.md`
   - If the file exists AND git status returns non-empty (uncommitted): update it in place
   - If the file doesn't exist: create it

3. **Ensure directory exists**: Create `.vibeslop/{owner}/{feature-name}/` if it doesn't exist.

4. **Write the artifact** to the determined path.

5. **Confirm to user**: Tell the user where the artifact was written and suggest: "Run `vibeslop-launch` to continue to the Launch phase."

### Adaptive Depth

- For small features (single file, minor change): keep each stage to 3-5 lines. Don't force depth where there isn't any.
- For large features (new product area, multi-component): go deeper, surface more perspectives, identify more risks.
- The methodology coverage should be complete either way — just proportionally scoped.

### Artifact Format

```
# Review: {Feature Name}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Feature**: {feature-name}

## Did we help the customer make progress?

{Approved content from Stage 1}

## Is the experience becoming a habit?

{Approved content from Stage 2}

## What shipped and what did we learn?

{Approved content from Stage 3}

## Decisions

- **progress-verdict**: "{did/didn't} help the customer make progress — {evidence}"
- **habit-status**: "{forming/stalling/declining} — cycle completion rate: {X%}"
- **shipped**: ["{items shipped with outcome data}"]
- **cut**: ["{items cut with reason}"]
- **carried-forward**: ["{items deferred to next cycle}"]
- **next-phase**: launch
- **agents-needed-next**: [Engineer]
- **open-questions**: ["{any unresolved items}"]
```

No methodology labels. Section headers are the product questions.
