---
description: "Analyze-phase skill for the vibeslop product methodology. Helps name what's not working."
---

# Vibeslop Analyze: Name what's not working

## User Input

The text the user typed after `/vibeslop.analyze` is the feature description.
If empty and a `.vibeslop/` directory exists, look for the most recent feature context.
If still empty, ask the user what feature they want to analyze.

## Roles Required

- **Lead**: Product Manager (coordinator — always present)
- **Contributors**: Data Analyst, Marketing
- **Optional**: Sales, Customer Success, Security

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` → `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine feature name**:
   - If user provided an argument: use it as the feature name (kebab-case)
   - Else check current git branch: if it matches `NNN-feature-name` pattern, extract `feature-name`
   - Else scan `.vibeslop/{owner}/` for most recent directory
   - Else ask the user: "What feature are you working on?"

3. **Discover existing artifacts**: Scan `.vibeslop/{owner}/{feature-name}/` for any existing phase artifacts. Read them as optional context — they inform your thinking but are never required. This phase closes the loop, so all prior artifacts (plan, design, build, test, review, launch) are valuable context.

4. **Research the project**: Read relevant source code, README, recent git commits, and any project documentation to understand the current state.
   - **Ritual Search**: Look for evidence of **Retrospectives**, **Metrics Reviews**, **Post-mortems**, or **Churn Analysis** reports.
   - **Tool Context**: Check for data in **Sentry** (reliability), **Clarity** (session replays/heatmaps), **HubSpot** (churn signals/health), or **Google Analytics** (funnels/retention).
   Prioritize project-specific insights over generic advice.

### Step 2: Stage Loop

Execute exactly 3 stages. For each stage, research and synthesize an insight, present it to the user, and wait for approval before proceeding.

**Roles to consider**: Product Manager, Engineering Lead, Data Analyst, Marketing, Sales, Customer Success, Security — weave their perspectives into each stage naturally.

---

**Stage 1: "Which problems are still unsolved?"**

Research and synthesize:
- Re-score each targeted outcome: importance (1-10) x satisfaction (1-10), compare pre-launch vs. post-launch. The gap tells the truth.
- Identify outcomes where the gap narrowed (bet paid off), remained (bet missed), or new gaps emerged (unintended consequence). All three categories matter.
- Task completion rate, time-to-value, and job satisfaction matter more than page views or DAU. Vanity metrics hide real problems.
- These findings feed the next Plan cycle directly — be specific enough to act on.
- Pull in Data Analyst's metrics deep-dive and Sales' perspective on deal velocity impact since launch.

Present a concise draft that includes: outcome re-scoring, gap movement (narrowed/remained/emerged), and progress metrics that matter. Keep it readable in under 30 seconds.

Ask: **"Does this match what you're seeing? Approve, or tell me what to change."**

---

**Stage 2: "Where are people dropping off?"**

Research and synthesize (building on approved Stage 1):
- **Define Habit Threshold**: How many sessions per period indicates a habit? (e.g., 3+ uses per week). This varies by product.
- Track what percentage of each cohort reaches the habit threshold. If it's declining across cohorts, the problem is getting worse, not better.
- **Diagnose Drop-off**: Measure drop-off at each engagement cycle transition: **trigger→action**, **action→reward**, **reward→investment**. The biggest drop-off is the bottleneck.
- Compare trigger channels by first-cycle conversion rate. Kill underperforming channels, double down on what works.
- A decreasing inter-session interval = habits forming; increasing = losing attention. The trend matters more than the absolute number.
- Pull in Customer Success's churn signals and Marketing's channel effectiveness data.

Present a concise draft of the drop-off analysis: **habit threshold**, cohort performance, **cycle bottleneck**, and channel ranking. Keep it readable in under 30 seconds.

Ask: **"Does this drop-off picture feel accurate? Approve, or tell me what to change."**

---

**Stage 3: "What should we change?"**

Research and synthesize (building on approved Stages 1 and 2):
- Run a Start/Stop/Continue retrospective for process improvements. Be specific — "start doing X" not "improve communication."
- Compare actual outcomes vs. predicted bet outcomes — honest accounting. No spin. If a bet missed, say so and say why.
- **Blameless Post-mortem**: RCA for incidents or misses. The system failed, not the person. What process change prevents recurrence?
- **Churn Analysis**: Which job did churned users find a better solution for? They didn't leave — they hired something else. Understanding what they hired tells you what to build.
- Produce an evidence-ranked bet list for the next Plan cycle: rank, bet statement, evidence, confidence (High/Medium/Low). This is the handoff to the next cycle.
- Pull in Engineering Lead's technical debt assessment and Data Analyst's cohort analysis.

Present a concise draft of the change recommendations: retrospective actions, bet scorecard, **churn diagnosis**, and the ranked bet list for next cycle. Keep it readable in under 60 seconds.

Ask: **"Are these the right changes? Approve, or tell me what to change."**

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
   - Run: `git status --porcelain -- .vibeslop/{owner}/{feature-name}/analyze.md`
   - If the file exists AND git status returns empty (committed): create a new timestamped version at `.vibeslop/{owner}/{feature-name}/analyze-{YYYYMMDD-HHMMSS}.md`
   - If the file exists AND git status returns non-empty (uncommitted): update it in place
   - If the file doesn't exist: create it

3. **Ensure directory exists**: Create `.vibeslop/{owner}/{feature-name}/` if it doesn't exist.

4. **Write the artifact** to the determined path.

5. **Confirm to user**: Tell the user where the artifact was written and emphasize:

   > **The product cycle is now complete.** Your evidence-ranked bet list is ready. Run `/vibeslop.plan` to start the next cycle — the bet list from this Analyze will carry forward automatically.
   >
   > Skipping Analyze means your next Plan phase starts cold, without evidence from this cycle. The bet list is what makes each cycle smarter than the last.

### Adaptive Depth

- For small features (single file, minor change): keep each stage to 3-5 lines. Don't force depth where there isn't any.
- For large features (new product area, multi-component): go deeper, surface more perspectives, identify more risks.
- The methodology coverage should be complete either way — just proportionally scoped.

### Artifact Format

```
# Analyze: {Feature Name}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Feature**: {feature-name}

## Which problems are still unsolved?

{Approved content from Stage 1}

## Where are people dropping off?

{Approved content from Stage 2}

## What should we change?

{Approved content from Stage 3}

## Decisions

- **unsolved-problems**: ["{outcomes where gap remained or widened}"]
- **drop-off-bottleneck**: "{biggest cycle drop-off point and cause}"
- **bets-that-paid-off**: ["{bet statement — evidence}"]
- **bets-that-missed**: ["{bet statement — evidence — why}"]
- **next-cycle-bets**: [{rank: 1, bet: "{statement}", evidence: "{data}", confidence: "High/Med/Low"}]
- **next-phase**: plan
- **agents-needed-next**: [Designer]
- **open-questions**: ["{any unresolved items}"]
```

No methodology labels. Section headers are the product questions.
