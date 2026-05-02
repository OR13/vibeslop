---
description: "Test-phase skill for the vibeslop product methodology. Catches the gap between what we built and what the customer needs."
---

# Vibeslop Test: Catch the gap between what we built and what the customer needs

## User Input

The text the user typed after `/vibeslop.test` is the feature description.
If empty and a `.vibeslop/` directory exists, look for the most recent feature context.
If still empty, ask the user what feature they want to think about.

## Roles Required

- **Lead**: Product Manager (coordinator — always present)
- **Contributors**: QA Engineer, Engineers
- **Optional**: Security Engineer, Customer Success

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` → `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine feature name**:
   - If user provided an argument: use it as the feature name (kebab-case)
   - Else check current git branch: if it matches `NNN-feature-name` pattern, extract `feature-name`
   - Else scan `.vibeslop/{owner}/` for most recent directory
   - Else ask the user: "What feature are you working on?"

3. **Discover existing artifacts**: Scan `.vibeslop/{owner}/{feature-name}/` for any existing phase artifacts. Read them as optional context — they inform your thinking but are never required. If `plan.md`, `design.md`, and `build.md` artifacts exist, carry forward the approved problem framing, design boundaries, and build decisions.

4. **Research the project**: Read relevant source code, README, recent git commits, and any project documentation to understand the current state.
   - **Ritual Search**: Look for evidence of **QA Reviews**, **Penetration Testing** reports, **User Acceptance Testing (UAT)** feedback, or **Regression Testing** results.
   - **Tool Context**: Check for data in **GitHub** (regression suites), **Claude Code / Copilot** (test authoring), **Snyk** (vulnerabilities), or **Playwright** (E2E/accessibility).
   Prioritize project-specific insights over generic advice.

### Step 2: Stage Loop

Execute exactly 3 stages. For each stage, research and synthesize an insight, present it to the user, and wait for approval before proceeding.

**Roles to consider**: QA Engineer, Engineers, Product Manager, Security Engineer, Customer Success — weave their perspectives into each stage naturally.

---

**Stage 1: "Does this actually help the customer?"**

Research and synthesize:
- Frame acceptance tests as job-completion scenarios: Given [struggling moment] → When [action] → Then [desired outcome]. Every test should trace back to a real user need, not just a spec line.
- Test the full journey from struggling moment to desired outcome — not just individual screens or API endpoints, but the entire path a user walks.
- **Measure Success**: Track **Time-to-Value** (how long from first trigger to first reward) and **Job Completion Rate**. A 100% test pass rate means nothing if users still can't get the job done quickly.
- A feature that works as coded but doesn't help the user complete the job is a failure. Code correctness and user success are different things.
- Consider Product Manager's acceptance criteria and Customer Success's edge case knowledge — what do support tickets tell us about where users actually get stuck?

Present a concise draft that includes: job-completion test scenarios, the end-to-end journey test plan, **target Time-to-Value**, and CS-informed edge cases. Keep it readable in under 30 seconds.

Ask: **"Does this test what actually matters to the customer? Approve, or tell me what to change."**

---

**Stage 2: "Does the full experience hold up?"**

Research and synthesize (building on approved Stage 1):
- Test the entire engagement cycle: does the trigger fire at the right moment? Is the action achievable in minimum steps? Does the reward feel variable (not scripted)? Do users complete the investment step?
- Track cycle completion rate — what percentage of users go from trigger → action → reward → investment? Drop-off at each step tells you where the experience breaks.
- Validate trigger timing — does it reach users when the internal emotion (boredom, uncertainty, anxiety, FOMO) is actually active? A perfectly designed trigger at the wrong moment is noise.
- A/B test reward variations: measure surprise, not just satisfaction. Users should feel "I didn't expect that" more than "that was nice."
- Track session frequency and time-between-sessions. If the interval between sessions is decreasing, habits are forming. If it's increasing, the cycle is losing the competition for attention. Frequency is the leading indicator of habit formation.
- Consider Sales' demo path validation needs — can a prospect experience the full cycle in a single demo without hitting dead ends?

Present a concise draft of: cycle completion test plan (with expected drop-off points), trigger timing validation, reward variability measurement approach, and demo path validation.

Ask: **"Does this cover the full experience? Approve, or tell me what to change."**

---

**Stage 3: "What could break?"**

Research and synthesize (building on approved Stages 1 and 2):
- Regression: all existing job-completion paths must still work. New features cannot break old outcomes — if they do, the new feature isn't ready.
- QA catches intent gaps: the feature works as coded but doesn't serve the job. This is the hardest kind of bug to find because automated tests will pass.
- Pen testing validates threat model mitigations from the Plan phase. Security testing isn't optional — it's part of the definition of done.
- UAT: can a real user complete the job statement in the target time? Not a developer, not a QA engineer — someone who matches the target user profile.
- Accessibility testing: screen readers, keyboard navigation, color contrast, motion sensitivity. If some users can't complete the job, the job isn't done.
- What agents automate (regression suites, E2E happy paths, coverage reports) vs. what humans judge (UAT acceptance, intent-gap detection, "does this feel right?").
- Consider Customer Success's knowledge of edge cases that generate support tickets — test those paths explicitly, not just the happy path.

Present a concise draft of: regression test coverage, intent-gap scenarios, security test plan, UAT plan (who, scenario, target time), accessibility checklist, agent/human testing split, and CS-informed edge cases.

Ask: **"Are we testing what could actually break? Approve, or tell me what to change."**

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
   - Run: `git status --porcelain -- .vibeslop/{owner}/{feature-name}/test.md`
   - If the file exists AND git status returns empty (committed): create a new timestamped version at `.vibeslop/{owner}/{feature-name}/test-{YYYYMMDD-HHMMSS}.md`
   - If the file exists AND git status returns non-empty (uncommitted): update it in place
   - If the file doesn't exist: create it

3. **Ensure directory exists**: Create `.vibeslop/{owner}/{feature-name}/` if it doesn't exist.

4. **Write the artifact** to the determined path.

5. **Confirm to user**: Tell the user where the artifact was written and suggest: "Run `/vibeslop.review` to continue to the Review phase."

### Adaptive Depth

- For small features (single file, minor change): keep each stage to 3-5 lines. Don't force depth where there isn't any.
- For large features (new product area, multi-component): go deeper, surface more perspectives, identify more risks.
- The methodology coverage should be complete either way — just proportionally scoped.

### Artifact Format

```
# Test: {Feature Name}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Feature**: {feature-name}

## Does this actually help the customer?

{Approved content from Stage 1}

## Does the full experience hold up?

{Approved content from Stage 2}

## What could break?

{Approved content from Stage 3}

## Decisions

- **test-coverage**: "{job-completion scenarios covered}"
- **experience-validation**: "{cycle completion test status}"
- **critical-risks**: ["{risks identified with mitigation status}"]
- **uat-verdict**: "{pass/fail/pending with evidence}"
- **next-phase**: review
- **agents-needed-next**: [Designer, Engineer]
- **open-questions**: ["{any unresolved items}"]
```

No methodology labels. Section headers are the product questions.
