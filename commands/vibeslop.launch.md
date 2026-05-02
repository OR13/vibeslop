---
description: "Launch-phase skill for the vibeslop product methodology. Helps get the work into customers' hands."
---

# Vibeslop Launch: Get the work into customers' hands

## User Input

The text the user typed after `/vibeslop.launch` is the feature description.
If empty and a `.vibeslop/` directory exists, look for the most recent feature context.
If still empty, ask the user what feature they want to launch.

## Roles Required

- **Lead**: Product Manager (coordinator — always present)
- **Contributors**: Engineering, Marketing
- **Optional**: Sales, Customer Success, Security

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` → `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine feature name**:
   - If user provided an argument: use it as the feature name (kebab-case)
   - Else check current git branch: if it matches `NNN-feature-name` pattern, extract `feature-name`
   - Else scan `.vibeslop/{owner}/` for most recent directory
   - Else ask the user: "What feature are you working on?"

3. **Discover existing artifacts**: Scan `.vibeslop/{owner}/{feature-name}/` for any existing phase artifacts. Read them as optional context — they inform your thinking but are never required. Pay special attention to `build.md` and `test.md` artifacts for what was built and what's verified.

4. **Research the project**: Read relevant source code, README, recent git commits, and any project documentation to understand the current state.
   - **Ritual Search**: Look for evidence of **Release Planning**, **Go-to-Market** strategy, **Launch Checklists**, or **Sales Enablement** sessions.
   - **Tool Context**: Check for data in **Sentry** (production alerts), **GitHub** (release tags/changelogs), or **Vercel** (rollout/health).
   Prioritize project-specific insights over generic advice.

### Step 2: Stage Loop

Execute exactly 3 stages. For each stage, research and synthesize an insight, present it to the user, and wait for approval before proceeding.

**Roles to consider**: Product Manager, Engineering, Marketing, Sales, Customer Success, Security — weave their perspectives into each stage naturally.

---

**Stage 1: "How do we talk about this?"**

Research and synthesize:
- Lead messaging with the struggling moment, not the feature list ("Tired of squinting?" not "We added dark mode"). The pain is the headline.
- Present the product as progress on the user's job: verb + object + context. This is the one-line pitch.
- Use social proof from users who completed the job successfully — real stories beat feature specs.
- Feature lists go in the changelog, not the announcement. Keep the narrative about progress, not capabilities.
- Pull in Sales' positioning needs (what language closes deals?) and Marketing's channel strategy (where does this message land?).

Present a concise draft that includes: the struggling-moment headline, the job-framed pitch, social proof angles, and channel strategy. Keep it readable in under 30 seconds.

Ask: **"Does this messaging land? Approve, or tell me what to change."**

---

**Stage 2: "What's the first experience?"**

Research and synthesize (building on approved Stage 1):
- Design first-use to complete the full engagement cycle on day one: trigger → action → reward → invest. If users don't complete one full cycle in their first session, habit formation stalls.
- Match external triggers to internal emotions — not "new feature available" but "struggling with X? Try this." The trigger should acknowledge the pain before offering the solution.
- Plan trigger frequency: enough to build the mental association, not enough to annoy. Tapers matter — heavy early, lighter as habits form.
- Track which trigger channels produce highest first-cycle completion. Not all channels are equal.
- Pull in Customer Success's onboarding knowledge (where do new users get stuck?) and Sales' demo-ready requirements (what must work flawlessly in a live demo?).

Present a concise draft of the first experience: day-one cycle design, trigger strategy, frequency plan, and channel priorities. Keep it readable in under 30 seconds.

Ask: **"Is this the right first experience? Approve, or tell me what to change."**

---

**Stage 3: "How do we roll out safely?"**

Research and synthesize (building on approved Stages 1 and 2):
- Stage rollout: internal dogfood → beta cohort → general availability with feature flags. Each stage has explicit go/no-go criteria.
- Use canary releases to validate in production: route a small percentage of real traffic to the new version, monitor error rates and latency against the baseline, and only widen exposure when metrics hold. Canary catches production-only issues that staging environments miss.
- Define rollback criteria before launch: error rate thresholds, satisfaction drops, performance degradation. Know the tripwires before you flip the switch.
- Train sales to position around the job ("this helps customers [job]") not features. Demo scripts should mirror the user's struggling moment, not the feature tour.
- Monitor support ticket volume and first-session completion post-launch. These are the two leading indicators that matter most.
- What agents manage (deploy pipeline, auto-rollback, health checks) vs. what humans decide (go/no-go, narrative, customer escalations).
- Pull in Engineering's assessment of deploy pipeline health and readiness.

Present a concise draft of the rollout plan: staging strategy, rollback tripwires, sales enablement, monitoring plan, and agent/human split. Keep it readable in under 60 seconds.

Ask: **"Is this rollout plan safe enough? Approve, or tell me what to change."**

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
   - Run: `git status --porcelain -- .vibeslop/{owner}/{feature-name}/launch.md`
   - If the file exists AND git status returns empty (committed): create a new timestamped version at `.vibeslop/{owner}/{feature-name}/launch-{YYYYMMDD-HHMMSS}.md`
   - If the file exists AND git status returns non-empty (uncommitted): update it in place
   - If the file doesn't exist: create it

3. **Ensure directory exists**: Create `.vibeslop/{owner}/{feature-name}/` if it doesn't exist.

4. **Write the artifact** to the determined path.

5. **Confirm to user**: Tell the user where the artifact was written and strongly suggest:

   > Run `/vibeslop.analyze` to close the loop. Analyze produces the evidence-ranked bet list that feeds your next Plan cycle. Without it, the next cycle starts cold — you lose the compounding effect of evidence-informed planning.

### Adaptive Depth

- For small features (single file, minor change): keep each stage to 3-5 lines. Don't force depth where there isn't any.
- For large features (new product area, multi-component): go deeper, surface more perspectives, identify more risks.
- The methodology coverage should be complete either way — just proportionally scoped.

### Artifact Format

```
# Launch: {Feature Name}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Feature**: {feature-name}

## How do we talk about this?

{Approved content from Stage 1}

## What's the first experience?

{Approved content from Stage 2}

## How do we roll out safely?

{Approved content from Stage 3}

## Decisions

- **messaging**: "{struggling-moment headline} — {job-framed pitch}"
- **first-experience**: "{day-one cycle design summary}"
- **rollout-stage**: "{current stage: dogfood/beta/GA}"
- **rollback-tripwires**: ["{error rate threshold}", "{satisfaction drop threshold}"]
- **next-phase**: analyze
- **agents-needed-next**: [Designer]
- **open-questions**: ["{any unresolved items}"]
```

No methodology labels. Section headers are the product questions.
