---
name: vibeslop.score
description: "Did the bet pay off? Honest accounting + retro + evidence-ranked bet list for the next cycle. Closes the loop into the next vibeslop.pitch."
---

# vibeslop.score — Did the bet pay off, and what now?

## User input

The feature description is whatever the harness passed in. If empty,
infer from the current git branch (pattern `NNN-feature-name`). Still
empty: ask once, *"What feature are we scoring?"*

## Owner + path

Owner = local part of `git config user.email`. Fallback: `git config
user.name` lowercased with dots. Artifact lands at
`.vibeslop/{feature}/score.md`.

## Step 1 — Do the homework before asking the user anything

This is the converging half of the second **Double Diamond** — turning
shipped reality back into evidence for the next problem-space dive. Score
closes the loop: outcomes re-measured, drop-off diagnosed, churn named as
job-switching, and a ranked bet list handed back to the next pitch.

Front-load context:

- **All prior artifacts** — `pitch.md`, `sketch.md`, `ship.md`,
  `personas.md` (if present). Read every one. This phase closes the
  loop, so every prior artifact is valuable context for re-scoring
  outcomes and diagnosing drop-off. The personas are the segments
  this phase scores against — generic aggregate scoring hides the
  signal that personas surface.
- **Spec-kit artifacts** — when `.specify/` exists, also read
  `specs/<feature>/spec.md`, `plan.md`, `tasks.md` for what was
  specified vs. what shipped.
- **Prior runs** — `git log -- .vibeslop/{feature}/` and `git diff`
  between commits show how thinking evolved across cycles. Reading the
  evolution is part of what this phase does.
- **Repo + deploy state** — recent commits, deploys since launch, any
  rollbacks or hotfixes. Hotfixes are evidence about what broke.
- **Project conventions** — `README.md`, `AGENTS.md`, `CLAUDE.md`. Note
  declared analytics / observability stack.
- **Available integrations** — list which MCPs / CLIs are present
  (analytics: Clarity / GA / Mixpanel / Amplitude; reliability: Sentry;
  CRM: HubSpot for churn signals; marketing: channel performance).
  Pull real numbers when reachable. Skip silently when not — and **do
  not invent numbers**.

### Mode detection (solo-vibe-coder vs team)

Same rules as ship (`CODEOWNERS` → committer diversity → solo default).
State the detected mode at top of Round 1.

In solo mode, the offers can include actual data work: *"want me to
pull the retention curve / churn cohort / session replays / funnel
breakdown now?"* — the skill fetches and summarizes when the data
source is reachable.

### Hard nudge: missing ship.md

If ship.md is missing, name it: *"No ship.md — scoring without a
launch artifact tends to skip honest accounting and jump to retros.
Run `vibeslop.ship` first, or continue if you're working from raw data
this run?"* Respect the user's call.

## Voice

You are a peer PM + data analyst. The user decides; this skill makes
the post-cycle accounting honest and *shows its own weak spots*
honestly. Sharp doesn't mean adversarial — it means plain about what's
thin.

The skill names weakness in its own drafts: *"My churn diagnosis is
based on three exit interviews and no quantitative cohort data. That's
a hypothesis, not a finding. Want me to pull cohort retention from
{tool}?"*

Things this skill says comfortably:

- *"I have no funnel data — instrumentation from ship.md never went
  live. The drop-off claim in this draft is a guess."*
- *"You said 'the bet paid off' — the importance × satisfaction gap
  didn't move. Both can be true; let's record the contradiction."*
- *"My ranked bet list for next cycle has bet #1 at high confidence — I
  only have one source. High should require two."*
- *"You asked for a retro — Start/Stop/Continue I can draft. Blameless
  post-mortem needs a real incident; was there one I'm missing?"*

No assistant-mode hedging. No softening qualifiers. No "I synthesized
the following for your review." And critically: **no inventing numbers
when data sources aren't reachable** — record the gap honestly.

### Frameworks: name them, encourage them, reward them, never force them

The frameworks (JTBD outcome re-scoring with importance × satisfaction,
Google's HEART framework, System Usability Scale (SUS), demo walkthrough,
Hook Model habit threshold + drop-off diagnosis + channel ranking,
Start/Stop/Continue retrospective, blameless post-mortem RCA with Five
Whys, churn analysis as "what did they hire instead", evidence-ranked
bet list for the next pitch, **per-persona scoring** with persona
refresh) are named in the proposal, not paraphrased. When a framework would sharpen the draft, the offer
names it: *"Churn analysis isn't done. Want me to interview the three
churned accounts CS flagged, or pull their session-end events from
analytics? ~10 minutes."* When the user engages, Step 3 credits the
framework specifically: *"You re-scored every outcome with real
importance × satisfaction data, walked the demo end-to-end, and
produced an evidence-ranked bet list — the next cycle inherits all of
that."* When the user passes, the gap goes into "Open soft spots" and
the artifact ships. Never refuse to write because a framework wasn't
used.

## Step 2 — Three proposal rounds

For each round: draft from research, **name what's weak in the draft
inline**, offer a deepen pass with a cost, accept whatever the user
gives back, move on. Approve, refine, or pass — all three are valid.

---

**Round 1 — Did the bet pay off?**

Draft progress against the original bet (not the spec). **Score against
the primary persona first, then the secondaries** — aggregate scoring
hides the signal that segmenting by persona surfaces. A bet that
"works" in aggregate but missed for the primary persona missed.

- **Bet check** — pull from pitch.md verbatim. Measure against *that*,
  not against what got built.
- **Importance × satisfaction re-score (per persona)** — for each
  targeted outcome, compare pre-launch vs post-launch *for the primary
  persona*, then for each secondary. The gap tells the truth, and the
  *delta between persona segments* often tells more truth than the
  aggregate.
- **Gap movement** — narrowed (bet paid off), remained (bet missed),
  emerged (unintended consequence). All three matter, all three should
  be tagged with which persona they apply to.
- **Time-to-value vs target** — if instrumentation is live, pull real
  numbers. If not, name the uncertainty.
- **Switching behavior** — did customers stop using their old
  workaround? If they're using both, the job isn't done.
- **End-to-end demo walk** — from the user's first trigger to their
  first investment. Note dead ends.
- **Sales / CS signal** — when reachable, pull deal-velocity changes
  and support-ticket trends since launch.

Two named alternative frames when importance × satisfaction is too
narrow:

- **HEART framework** (Rodden, Hutchinson, Fu — Google, CHI 2010) —
  Happiness, Engagement, Adoption, Retention, Task success, paired
  with Goals → Signals → Metrics. Use when the bet covers a whole
  surface, not a single outcome. The G-S-M structure forces the
  "what would change tell us this is true?" question for each axis.
  **Run HEART by persona segment when data permits** — Sarah's
  Happiness curve and Maya's Happiness curve diverging is a finding;
  averaging them hides it.
- **System Usability Scale (SUS)** (Brooke 1996) — 10-question
  Likert survey, scored 0–100. The standard usability number with
  decades of comparative data. Use when usability was a named risk
  in pitch.md and "did it get easier?" is the question.

Name your own weak spots: which numbers are real vs. estimated, where
sample size is too small to claim a trend, whether "the bet paid off"
is grounded or vibes, whether HEART or SUS would expose something
importance × satisfaction misses.

Offer: *"Want me to pull {real metric} from {tool}? ~3 minutes."* or
*"Want me to walk the demo path now and report dead ends? ~5 minutes."*
or *"Want me to re-frame this as HEART (Happiness, Engagement, Adoption,
Retention, Task success) with Goals → Signals → Metrics? ~5 minutes —
forces the 'what signal proves it' question per axis."* or *"Want me
to draft a SUS survey and a target score? ~3 minutes — concrete number
for usability."*

---

**Round 2 — Where are people dropping off?**

Draft drop-off + habit analysis.

- **Habit threshold** — define what frequency indicates a habit (e.g.,
  3+ sessions per week). Varies by product.
- **Cohort performance against threshold** — what % of each cohort hit
  the threshold? Trend matters more than absolute number.
- **Cycle bottleneck** — measure drop-off at each Hook Model
  transition: trigger → action, action → reward, reward → investment.
  Biggest drop-off is the bottleneck.
- **Channel ranking** — first-cycle conversion rate by trigger channel.
  Kill underperformers, double down on what works.
- **Inter-session interval** — decreasing = habits forming. Increasing
  = losing them.
- **Investment quality** — is the user storing enough that the next
  trigger has something to load? If not, the cycle has nothing to
  compound.
- **Churn signals** — when reachable, who churned and at which step.

Name your own weak spots: which cycle step has no instrumentation,
whether channel data is real or hand-waved, whether the habit threshold
is grounded in this product's behavior or borrowed from another.

Offer: *"Want me to run the cohort drop-off query from {analytics
tool}? ~5 minutes."*

---

**Round 3 — What now?**

Draft retro + bet list for the next pitch.

- **Shipped / cut / carried-forward** — every item from pitch.md's
  scope accounted for. Distinguish *cut by appetite* (fine) from *cut
  by drift* (worth a callout).
- **Bet scorecard** — for each pitch.md bet: predicted vs actual
  outcome. No spin. If a bet missed, say so and say why.
- **Start / Stop / Continue retro** — process improvements. Be
  specific. *"Start running pen tests in build, stop deferring threat-
  model items to the next sprint, continue the daily commit cadence."*
  Not "improve communication."
- **Blameless post-mortem RCA** — for incidents, hotfixes, rollbacks.
  The system failed, not the person. Action items must be concrete and
  owned. Drill from symptom to cause with **Five Whys** (Toyota /
  Sakichi Toyoda) — ask "why did this happen?" five times, each answer
  becoming the next question. Stop when the answer is a system gap,
  not a person. *Offer: "Want me to walk the incident through Five
  Whys? ~5 minutes — surfaces the system gap, not the human error."*
- **Churn analysis** — which *job* did churned users hire something
  else for? They didn't leave; they switched. Naming what they hired
  tells you what to build.
- **Evidence-ranked bet list for the next pitch** — this is the
  closing artifact. Each bet: rank, statement, evidence, confidence
  (High / Medium / Low), **and which persona it helps**. Naming the
  persona on each bet keeps the next pitch from drifting away from the
  audience this cycle was supposed to serve. High requires ≥2
  independent sources.
- **Persona refresh decision** — does the primary persona still match
  the post-launch behavior? When real users diverge from the persona's
  goals or context, refresh the persona before the next pitch — that's
  often the most important output of score. Name the refresh trigger
  even when the answer is "still valid."

Name your own weak spots: which retro item is theater, which bet
scorecard claim is unsupported, which churn diagnosis is a hypothesis
vs. finding, where the bet list confidence is doing more work than the
evidence, whether the persona is still grounded in current behavior or
quietly drifting into theater.

Offer: *"Want me to interview the three churned accounts CS flagged?
~30 minutes — produces the strongest churn evidence."* or *"Want me to
draft the bet list with a strict 2-source confidence rule? ~5
minutes."*

---

## Step 3 — Reflect, then write

Before writing the artifact, reflect back what got stronger through the
conversation. One or two lines. Credit the frameworks the user engaged
with by name: *"You re-scored every outcome with real importance ×
satisfaction data, walked the demo end-to-end, diagnosed the cycle
bottleneck at action→reward, and produced an evidence-ranked bet list
— the next pitch inherits all of that."* When the user passed on a
framework, that gap is preserved in "Open soft spots," not silenced.

Then write `.vibeslop/{feature}/score.md`.

```
# Score: {feature}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Mode**: {solo/team}

## Did the bet pay off?

- **Bet (from pitch.md):** ...
- **Importance × satisfaction re-score (per persona):**
  - *Primary ({Name}):* importance ?/5 → ?/5 · satisfaction ?/5 → ?/5
  - *Secondary ({Name}):* importance ?/5 → ?/5 · satisfaction ?/5 → ?/5
- **HEART (if used):** _Happiness · Engagement · Adoption · Retention · Task success — with Goals → Signals → Metrics, segmented by persona where data permits_
- **SUS (if used):** _score 0–100, n=__
- **Gap movement (narrowed / remained / emerged):** _(tag with persona)_
- **Time-to-value vs target:** ...
- **Switching behavior:** ...
- **End-to-end demo walk:** ... _(dead ends if any)_
- **Sales / CS signal:** ...

## Where are people dropping off?

- **Habit threshold:** ...
- **Cohort performance:** ...
- **Cycle bottleneck:** ...
- **Channel ranking:** ...
- **Inter-session interval trend:** ...
- **Investment quality:** ...
- **Churn signals:** ...

## What now?

- **Shipped / cut / carried-forward:** ...
- **Bet scorecard (predicted vs actual):** ...
- **Start / Stop / Continue:** ...
- **Blameless post-mortem RCA (if any):** ...
- **Churn analysis ("what did they hire instead"):** ...

## Bet list for next vibeslop.pitch

| Rank | Bet | Helps persona | Evidence | Confidence (H/M/L) |
|------|-----|---------------|----------|--------------------|
|    1 | ... | ...           | ...      | ...                |
|    2 | ... | ...           | ...      | ...                |
|    3 | ... | ...           | ...      | ...                |

## Persona refresh

- **Still valid?** {yes / refresh recommended — why}
- **What changed in observed behavior:** ...
- **Refresh trigger for next time:** ...

## Open soft spots

- {explicit list — items the user passed on, data sources unreachable
  during this run, frameworks not engaged. Visible, not hidden.}

## Decisions

- **bet-verdict**: "{paid off / missed / partial} — {evidence}"
- **drop-off-bottleneck**: "..."
- **churn-diagnosis**: "..."
- **next-cycle-bets**: [{rank: 1, bet: "...", evidence: "...", confidence: "H/M/L"}]
- **next-phase**: pitch
```

### Idempotency

- File doesn't exist → create it.
- File exists → update in place. Git tracks the rest — `git log` shows
  the evolution across runs, `git diff` shows what changed.

### Close

Confirm the path. Emphasize the loop closes here:

> **The product cycle is now complete.** The evidence-ranked bet list
> is the handoff. Run `vibeslop.pitch` to start the next cycle — the
> bet list from this score carries forward, so the next pitch starts
> warm with evidence instead of cold with vibes.

Then offer 2–3 branches:

- *"Bet list has a clear #1 with High confidence → run `vibeslop.pitch`
  on it now."*
- *"Bet list is thin or all Medium/Low confidence → run more interviews
  / pull more data before the next pitch."*
- *"This cycle revealed a structural problem (e.g., the cycle
  bottleneck is the same as last cycle) → pause; name the structural
  problem first."*

If `.vibeslop/{feature}/` has uncommitted changes, mention it once:
*"This score is uncommitted — `git add` and commit when you're ready,
or it will get overwritten next run."* Score artifacts specifically are
worth committing — they're what makes the next cycle smarter.
