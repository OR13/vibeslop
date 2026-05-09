# Persona-driven design

> *"If you do not specifically design for someone, you will not satisfy
> anyone."* — Alan Cooper, *The Inmates Are Running the Asylum* (1999)

A reference for the persona-driven design pattern as vibeslop uses it.
Linked from each SKILL.md; built to be navigated by both humans and the
agent at runtime.

---

## What a persona is (and isn't)

A **persona** is a *concrete*, research-grounded model of one user — name,
goals, behaviors, context — used as a single point of empathy that a team
can argue from when making design decisions.

It is **not**:

- A marketing demographic ("women 25–34, urban, household income $80k+").
  Marketing personas describe *who buys*; design personas describe *who
  uses*. Different jobs.
- An average user. Averages mask the behaviors you need to design for.
- A made-up character. A persona without research is fiction.
- A document on a wall. Personas you don't argue from are theater.

The pattern was formalized by **Alan Cooper** (*About Face*, 1995; *The
Inmates Are Running the Asylum*, 1999) and refined by **Kim Goodwin**
(*Designing for the Digital Age*, 2009). **Microsoft's Inclusive Design**
toolkit (2016) extended the model with the **persona spectrum** — replacing
"the user" with a range of permanent, temporary, and situational contexts.

---

## Why personas earn their keep

Three things personas do that nothing else does:

1. **They make trade-offs decidable.** *"Sarah is mid-experiment with
   gloves on; she can't tap a 32×32 button"* settles a fidelity argument
   that an abstract "user" never could.
2. **They expose hidden assumptions.** Naming the primary persona forces
   the team to also name *who they're not designing for* — the anti-persona
   — which surfaces scope drift before code gets written.
3. **They survive handoff.** A pitch.md persona section is what the
   sketch, ship, and score phases all argue from. Without it, each phase
   re-invents who the customer is.

Personas don't replace JTBD or B=MAT. They *ground* them: JTBD says *what
job is being hired for*; the persona says *who's doing the hiring, in what
context*. B=MAT says *behavior happens when motivation × ability × trigger
converge*; the persona names *whose* motivation, ability, and trigger.

---

## How to make a good persona

A persona earns its keep in seven moves. Skip moves at your peril.

### 1. Ground in research

Real conversations with 5–8 users in the segment expose the behavioral
patterns a persona compresses. (Nielsen's "five users find 85% of usability
issues" applies here too — patterns emerge fast.) Sources, in descending
preference:

- **Live conversations** — interviews, contextual inquiry, support calls.
- **Behavioral data** — analytics segments, session replays, support
  tickets clustered by theme.
- **Sales / CS notes** — what customers say in their own words about why
  they bought and where they got stuck.
- **Internal proxies** — only when the above isn't reachable, and clearly
  flagged: "this persona is provisional; first round of user conversations
  will revise."

If none of these are reachable, name the persona **provisional** and ship
it with that label. Fictional personas are theater; *provisional* personas
are a flag for the next round of research.

### 2. Lead with goals (not demographics)

Cooper's model has three goal levels. A persona names all three:

- **Life goals** — who the user wants to become. ("Be respected as the
  go-to lab manager who never loses an experiment.")
- **End goals** — what they accomplish using the product. ("Reproduce
  yesterday's protocol on a new sample without re-deriving the
  parameters.")
- **Experience goals** — how they want to feel during the work.
  ("Confident the data is right. Not dreading the QA review.")

Demographics are last and minimal. Age, role, and seniority go in *only
when they're load-bearing for design decisions*. "Sarah is 42" tells the
designer nothing. "Sarah does 60% of her work mid-experiment with gloves
on" tells the designer everything.

### 3. Concrete: name, photo (or avatar), one sentence

A persona is a *handle*. Give it:

- **A name** — first name only is fine. The name is what the team will
  use in design arguments ("Sarah wouldn't open this modal").
- **A face or avatar** — concreteness anchors. Stock photos work; AI
  avatars work; a stylized illustration works.
- **A one-sentence elevator** — *"Sarah, lab manager at a 50-person
  biotech, runs ~12 reproductions a week and is mid-experiment 60% of
  her workday."*

### 4. Behaviors and context, not traits

Traits ("detail-oriented", "tech-savvy") are unfalsifiable and useless.
Behaviors and context are designable:

- **What they do today** — current job-completion path, tools they
  string together, workarounds they've built.
- **Where they get stuck** — verbatim friction. Real quotes from
  research carry weight.
- **The work environment** — physical (bench? open office? in
  transit?), social (alone? in front of clients?), temporal (deep
  work? interrupted?).
- **Their relationship to the alternatives** — what they'd hire
  instead, and why they don't.

### 5. Pick a primary, name secondaries, name an anti-persona

This is the most important move. From your set of 3–7 personas:

- **One primary.** Designs are argued from the primary's goals. If a
  feature doesn't help the primary, it has to clear a high bar to
  exist.
- **Secondaries (1–2).** Served, but never at the primary's expense.
  Secondary personas are *checks*: "Does this design also work for
  Maya?"
- **Anti-persona (1).** Who you'd be wrong to design for, and why.
  Naming the anti-persona is how scope drift gets caught.

The discipline is *singular focus on one primary*. Designing equally for
everyone is designing for no one.

### 6. Define the persona spectrum (Microsoft Inclusive Design)

A persona shouldn't be a frozen point — it's a *range*. For the primary
persona, name the spectrum on the dimension that matters most:

- **Permanent** — Sarah works one-handed because of a long-term
  injury.
- **Temporary** — Sarah works one-handed because of a sprain.
- **Situational** — Sarah works one-handed because she's holding a
  pipette.

Designs that serve the permanent edge of the spectrum tend to make the
temporary and situational cases easier too. The spectrum is what turns
"design for Sarah" from one user into a class of users.

### 7. Make the persona refreshable

A persona is a snapshot. Behavior changes; the market changes; the user
base changes. A persona without a refresh date decays into theater. Date
the artifact. Re-validate when:

- New behavioral data contradicts the persona.
- Customer interviews reveal a goal that wasn't there before.
- The product expands into a segment the persona doesn't cover.

`vibeslop.score` is the natural refresh point: did the persona's
struggling moment actually move? If not, the persona may be wrong, the
design may be wrong, or both.

---

## The persona artifact (what to write)

Lives at `.vibeslop/{feature}/personas.md` (or as a section inside
`pitch.md`). Template:

```markdown
# Personas: {feature}

**Owner**: {owner} | **Date**: {YYYY-MM-DD} | **Sources**: {N interviews / analytics / CS notes / etc.}

## Primary persona — {Name}

> *"{verbatim quote from research}"*

**One-line:** {role + most-load-bearing context, in one sentence}

**Goals**
- *Life:* ...
- *End:* ...
- *Experience:* ...

**Today's job-completion path:** {tools, sequence, workarounds}
**Where they get stuck:** {friction, with quotes if possible}
**Context:** {physical / social / temporal}
**Spectrum (permanent / temporary / situational):** {dimension that matters most}
**Alternatives they'd hire:** {what they'd switch to}

## Secondary personas

### {Name} — {one-line}
- *End goal:* ...
- *Why secondary, not primary:* ...

## Anti-persona — {Name}

**Who they are:** {one-line}
**Why we'd be wrong to design for them:** ...

## Provenance

- **Sources used:** {interviews / analytics / etc.}
- **What's still thin:** {what would strengthen the persona}
- **Refresh trigger:** {what would make us re-do this}
```

---

## How to interact with the persona while designing

The artifact is only worth the time it took if the team *argues from it*.
Five interaction patterns:

### 1. Name the persona by name in design arguments

*"Sarah wouldn't open this modal — she's gloved up."* Beats *"users
might find this confusing."* The name is what carries the constraint.

### 2. Walk the design as the persona

For each new screen, state, or flow:

- *Why* would Sarah be here?
- *What* is she trying to do?
- *What's her next step?*
- *What would make her stop trusting the product right now?*

If the answers are vague, the design is vague. Fix the design, not the
walk-through.

### 3. Test design decisions against the persona's goals

Every cut, scope decision, and feature add gets evaluated against:

- Does this serve the primary persona's *end goal*?
- Does this protect the primary persona's *experience goal*?
- Does this push toward the primary persona's *life goal* — or away?

A feature that helps the secondary but not the primary is suspicious. A
feature that helps the anti-persona is a red flag.

### 4. Surface persona-mismatches as findings

When a design implicitly assumes context the persona doesn't have, that's
a finding worth naming. *"This admin panel assumes the user has 10
minutes of focused time; Sarah's average focused window is 90 seconds."*
The mismatch is the design problem.

### 5. Flag persona-stretch when scope grows

If a feature requires expanding the primary persona's goals or adding a
new secondary, that's scope creep made visible. The team can decide
*explicitly* to widen the persona — or to cut.

---

## Common failure modes

Watch for these. They're the way persona work fails most often.

| Failure | What it looks like | Fix |
| --- | --- | --- |
| **Stock-photo personas** | A persona poster with a smiling stock photo and zero research citations | Re-ground: 5 user conversations, real quotes |
| **Too many personas** | 8+ personas, no primary | Pick one primary; demote the rest to secondary or merge |
| **Persona theater** | Personas exist but no one references them in design arguments | The skill names them by name; the artifact is read at the start of every phase |
| **Frozen personas** | Same persona doc 18 months later despite shipped features and changed users | Date the artifact; refresh on `vibeslop.score` |
| **Demographics as goals** | "Persona's goal: be 35 years old, urban, with $80k income" | Re-write as life / end / experience goals; demographics last |
| **Trait-soup personas** | "Sarah is detail-oriented, tech-savvy, and motivated" | Replace traits with behaviors and context |
| **Personas instead of research** | Team uses personas to *avoid* talking to users | Personas are research compression, not research replacement |
| **Anti-persona missing** | Personas without a stated "who we're wrong to design for" | Name one; argue from it |

---

## How vibeslop uses personas across the cycle

Personas are *created* in pitch and *consumed* by the rest of the cycle.

| Phase | Persona move |
| --- | --- |
| **pitch** | Synthesize personas (primary + 1–2 secondary + anti). Name the spectrum. Write `personas.md` (or a Persona section inside `pitch.md`). |
| **sketch** | B=MAT *for the primary persona*. Walk the topology as the primary persona. Test the prototype with someone who matches. |
| **ship** | Struggling-moment headline = the primary persona's struggling moment. Channel strategy = where the primary persona lives. Sales enablement = the primary persona's job. |
| **score** | Re-score importance × satisfaction *per persona*. HEART by persona segment when data permits. Bet list ranks bets by which persona each helps. Persona refresh decision lives here. |

The persona is the through-line. JTBD says *what job*. B=MAT says *what
behavior*. The persona says *whose* — and that *whose* is what makes the
methodology stop being abstract.

---

## References

- Alan Cooper, *About Face: The Essentials of Interaction Design* (4th
  ed., 2014). [About the book](https://www.cooper.com/about-face/).
- Alan Cooper, *The Inmates Are Running the Asylum* (1999).
- Kim Goodwin, *Designing for the Digital Age* (2009).
- Microsoft, *Inclusive Design Toolkit* (2016) — the persona spectrum.
  [Inclusive Design at Microsoft](https://inclusive.microsoft.design/).
- Indi Young, *Mental Models* (2008) — adjacent technique using
  behavioral audiences instead of personas. Useful counter-frame.
- Dave Gray, *Empathy Map Canvas* (XPLANE) — Says / Thinks / Does /
  Feels. A cheaper first pass when full personas are too heavy.
- Nielsen Norman Group, [Personas: Study Guide](https://www.nngroup.com/articles/persona/).
