---
description: "Stats skill for the vibeslop product methodology. Surfaces surprising insights hidden in your product thinking."
---

# Vibeslop Stats: What's hiding in your product thinking?

## User Input

```text
$ARGUMENTS
```

No arguments required. If the user passes a feature name, scope the analysis to that feature's artifacts only.

## Execution

### Step 1: Context Gathering

1. **Derive owner**: Run `git config user.email` and extract the local part before `@` (e.g., `orie@or13.io` -> `orie`). If email is unset, use `git config user.name` lowercased with spaces replaced by dots.

2. **Determine scope**:
   - If user provided a feature name argument: scope to `.vibeslop/{owner}/{feature-name}/`
   - Else: scan ALL artifacts across `.vibeslop/` (all owners, all features)

3. **Discover artifacts**: Recursively scan `.vibeslop/` for all markdown files (`*.md`). These are phase artifacts (plan, design, build, test, review, launch, analyze) written by the vibeslop phase skills. If no `.vibeslop/` directory exists or it contains no markdown files, display:
   > No artifacts found in `.vibeslop/`. Run `/vibeslop.plan` to create your first product artifact.
   Then STOP.

4. **Read all artifacts**: Read every discovered markdown file into memory. Parse each artifact's metadata from its header block: owner, date, feature name, and phase (derived from filename or `# Phase:` header).

### Step 2: Scan and Extract Snippets

For each artifact, extract notable content snippets. A snippet is a sentence, bullet point, or short paragraph that contains a substantive claim, decision, metric, risk, prediction, or design choice. Skip boilerplate headers, metadata lines, and structural formatting.

For each snippet, record:
- `text`: The snippet content (1-3 sentences max)
- `source`: Which artifact it came from (owner/feature/phase)
- `date`: When the artifact was written
- `context`: The section heading or surrounding context

Aim to extract 5-15 snippets per artifact. Prioritize:
- Concrete decisions ("We chose X over Y because...")
- Quantified claims ("Completion rate: 73%", "Time appetite: 2 days")
- Risk statements ("If X fails, Y breaks")
- Predictions ("We expect Z to improve by...")
- Contradictions to common assumptions
- Specific file/component/metric references

### Step 3: Score Each Snippet

Score every extracted snippet along three dimensions. Each dimension is scored 1-5.

**Dimension 1: Rarity** (1 = common across many artifacts, 5 = appears only once)
- 1: Generic insight repeated in 3+ artifacts or phases ("users want fast load times")
- 2: Appears in 2 artifacts with similar framing
- 3: Unique to one artifact but covers a common theme
- 4: Unique insight that no other artifact touches
- 5: Completely novel — contradicts or extends everything else in the corpus

To score rarity: compare each snippet's core claim against all other snippets. Count how many other snippets make a similar point. Fewer matches = higher rarity.

**Dimension 2: Contradiction** (1 = consistent with everything, 5 = directly conflicts)
- 1: Fully aligned with all other artifacts
- 2: Slight tension with one other artifact (different emphasis)
- 3: Meaningful tension — two artifacts make claims that don't easily coexist
- 4: Direct contradiction between two phases ("Plan said X, Build did Y")
- 5: Fundamental conflict that reveals an unresolved strategic tension

To score contradiction: for each snippet, search other artifacts for claims that oppose, undermine, or tension it. Higher contradiction scores flag hidden disagreements in your product thinking.

**Dimension 3: Specificity** (1 = generic advice, 5 = highly specific to this project)
- 1: Could appear in any project ("test edge cases", "consider user experience")
- 2: References the general problem domain but not this project specifically
- 3: References this project's feature set or user base by name
- 4: References specific files, components, metrics, or code patterns
- 5: References exact file paths, function names, measured values, or concrete user data

To score specificity: check for proper nouns, file paths, metric values, component names, API endpoints, or user segments. The more grounded in project reality, the higher the score.

**Composite score**: `(Rarity * 2) + (Contradiction * 3) + (Specificity * 1)` — contradiction is weighted highest because it reveals the most actionable tensions. Maximum possible: 30.

### Step 3b: Phase-Quality Scoring

For each artifact, compute quality dimensions that replace the old binary "lenses completed" metric:

**Specificity Score** (1-5): How grounded is the artifact in project reality?
- 1: Generic advice that could apply to any project
- 2: References the problem domain but not this project specifically
- 3: Names this project's features or user base
- 4: References specific files, components, or measured metrics
- 5: Contains exact file paths, function names, measured values, or concrete user data

**Decision Density**: Count the number of concrete decisions per artifact. A "decision" is a committed choice — "we chose X over Y", "scope includes A, excludes B", "target metric is Z." Aspirations and observations don't count. Higher density = more actionable artifact.

**Word Count Ratio**: Artifact word count relative to feature complexity (estimated from scope breadth in the Plan artifact). Flag outliers:
- Too short (< 200 words for a multi-component feature) = likely shallow
- Too long (> 1500 words for a single-file change) = likely unfocused

**Decisions Block Completeness**: If the artifact has a `## Decisions` block, score how many fields are filled vs. placeholders. A fully populated Decisions block = high handoff quality.

Present per-artifact quality as a compact table in the output:

```
Phase quality:
  {phase} | Specificity {X}/5 | Decisions: {N} | Words: {W} | Handoff: {complete/partial/missing}
```

### Step 4: Present Findings

Rank all snippets by composite score. Present the top 5-8 findings.

**Emoji vocabulary** (use to indicate WHY the snippet scored high):
- 💎 High rarity — this insight is rare across your artifacts
- ⚠️ High contradiction — this conflicts with something elsewhere
- 🧬 High specificity — deeply grounded in your actual project
- ⚡ High composite — scores well across multiple dimensions
- 🔮 Prediction tension — a prediction in one phase is challenged by evidence in another
- 🔥 Urgent contradiction — two recent artifacts directly disagree
- 🎯 Hidden opportunity — a specific insight that nothing else builds on

**Output format**:

```
--- vibeslop stats: what's hiding in your product thinking? ---
{N} artifacts scanned | {M} snippets analyzed | {K} features

Top findings:

{emoji} [{source phase} -> {tension phase, if contradiction}] {snippet text}
   Why notable: {1-sentence explanation of why this scored high}
   Score: Rarity {X}/5 | Contradiction {Y}/5 | Specificity {Z}/5

{emoji} [{source phase}] {snippet text}
   Why notable: {1-sentence explanation}
   Score: Rarity {X}/5 | Contradiction {Y}/5 | Specificity {Z}/5

... (5-8 findings)

---
Contradiction map:
  {phase A} vs {phase B}: {1-line summary of the tension}
  {phase C} vs {phase D}: {1-line summary of the tension}

{closing emoji} {1-sentence takeaway about what these findings suggest}
```

**Presentation rules**:
- Lead with the highest-scoring finding
- Always include at least one contradiction if any exist (even if its composite score isn't the highest)
- Always include at least one high-specificity finding (grounds the analysis in reality)
- The "Why notable" line is the most important part — it tells the user why they should care
- The contradiction map only appears if there are contradiction scores >= 3
- The closing takeaway should provoke curiosity, not prescribe action
- Keep the entire output scannable in under 60 seconds
- Never mention methodology names — describe insights in plain product language

### No Artifact Write

This skill does NOT write any files. It is a read-only analysis tool. After presenting findings, simply end with:

> Run any `/vibeslop.*` phase to act on these insights. Or run `/vibeslop.stats` again after your next phase to see what changed.
