---
description: Generate or update a ranked differential diagnosis with explicit, auditable uncertainty reasoning. Uses anchored probability estimates, likelihood ratios, and structured pre/post-test reasoning — not vibes. Can work from pasted clinical data or update an existing workspace differential as new information arrives.
argument-hint: "<clinical scenario>" OR "update" to refine existing differential with new data
---

## Differential Diagnosis Generator — Uncertainty-Explicit Edition

### Determine Mode

**If $ARGUMENTS is "update", "refine", or "revise":**
1. Find the most recent workspace (or ask which one)
2. Read `clinical_summary.md` and `differential.md`
3. Ask: "What new information do you have?" (new labs, imaging, exam findings, response to treatment, etc.)
4. Update the differential using the Bayesian Update section below
5. Log the update in the Updates Log table

**Otherwise (new differential):**
1. Parse the clinical data from $ARGUMENTS
2. If a workspace exists for this case, read it for additional context
3. Generate a fresh differential using the full framework below

**Do NOT create a workspace unless the user explicitly asks or runs /new-case.**

### Differential Construction Framework

**Step 1: Frame the Clinical Problem**
State it precisely: "non-healing extraction socket in a patient on IV bisphosphonates" not just "jaw pain."

**Step 2: Generate Candidate Diagnoses**
Think through multiple axes:
- **Anatomic**: What structures are involved? What pathology can occur at each?
- **Pathophysiologic**: Infectious / inflammatory / neoplastic / traumatic / vascular / metabolic / iatrogenic / congenital / autoimmune / degenerative
- **Epidemiologic**: What's common for this age/sex/population/setting?
- **Pattern recognition**: What illness scripts does this presentation match?

Generate at least 5 candidates. Include at least one cannot-miss diagnosis even if unlikely.

**Step 3: Anchor Probabilities — The Critical Step**

⚠️ **Do NOT generate probability numbers from intuition.** Use this structured approach:

For each candidate diagnosis:

1. **Base rate anchor**: State the prevalence or incidence in this specific population. If known, cite the source. If unknown, state "base rate uncertain" and estimate a range.

2. **Key discriminating features**: For each major finding in this case, assess its diagnostic value:
   - Does this finding have a known likelihood ratio (LR)? If so, state it with source.
   - If no formal LR exists, categorize the feature as:
     - **Strongly supports** (LR+ roughly >5): finding is uncommon in other diagnoses on the list
     - **Mildly supports** (LR+ roughly 2-5): finding is more common in this diagnosis than others
     - **Non-discriminating** (LR ~1): finding is equally common across diagnoses
     - **Argues against** (LR+ <0.5): finding would be unusual with this diagnosis

3. **Post-test estimate**: Given the base rate shifted by the key features, assign a probability CATEGORY (not a false-precision percentage):
   - **Leading diagnosis** (>50%): This is the most likely explanation.
   - **Strong contender** (20-50%): Serious alternative that must be evaluated.
   - **Possible** (5-20%): Less likely but cannot be excluded.
   - **Unlikely but cannot-miss** (<5%): Low probability but high consequence if missed.

4. **Confidence in this estimate**: Rate your own confidence:
   - 🟢 **High confidence**: Good prevalence data, well-characterized clinical features, strong LRs available.
   - 🟡 **Moderate confidence**: Some prevalence data, features are suggestive but not pathognomonic, reasoning by analogy.
   - 🔴 **Low confidence**: Poor prevalence data for this population, atypical presentation, limited evidence base. **State what additional data would increase confidence.**

**Step 4: Identify What You Don't Know**

Create an explicit **Information Gaps** section:
- What history is missing that would change probabilities?
- What exam findings were not reported?
- What test results would most efficiently discriminate between the top diagnoses?
- What's the single question or test that would change your leading diagnosis?

**Step 5: Cannot-Miss Diagnoses**
Even if low probability, flag diagnoses that are:
- 🚨 Life-threatening or limb-threatening if missed
- 🚨 Time-sensitive (treatment window that closes)
- 🚨 Rapidly progressive without intervention

For each: what is the minimum workup to exclude it?

**Step 6: Recommend Diagnostic Workup**
Prioritize by information value:
1. Tests that discriminate between the top 2-3 diagnoses
2. Tests that rule out cannot-miss diagnoses
3. Least invasive / most cost-effective first

For each recommended test, state what result would shift the differential and how.

### Output Format

```markdown
# Differential Diagnosis

**Clinical Problem:** [precise framing]
**Generated:** [date] | **Confidence Level:** [🟢🟡🔴 overall]

---

## Ranked Differential

| # | Diagnosis (ICD-10) | Category | Confidence | Key For | Key Against |
|---|-------------------|----------|------------|---------|-------------|
| 1 | [Dx] ([code]) | Leading (>50%) | 🟢 | [features] | [features] |
| 2 | [Dx] ([code]) | Strong contender | 🟡 | [features] | [features] |
| 3 | [Dx] ([code]) | Possible | 🟡 | [features] | [features] |
| 4 | [Dx] ([code]) | Possible | 🔴 | [features] | [features] |
| 5 | [Dx] ([code]) | Cannot-miss | 🟡 | [features] | [features] |

## Reasoning Trace

### Why [Leading Diagnosis] Is on Top
- **Base rate**: [prevalence in this population, with source if available]
- **Findings that shift probability up**: [feature → LR or qualitative shift]
- **Findings that shift probability down**: [feature → LR or qualitative shift]
- **What would make me change my mind**: [specific finding or result]

### Key Discriminators Between Top Diagnoses
- [Dx 1] vs [Dx 2]: The distinguishing feature is [X]. If [test/finding], favors [Dx 1]. If [test/finding], favors [Dx 2].
- [Dx 1] vs [Dx 3]: [same structure]

## 🚨 Cannot-Miss Diagnoses
| Diagnosis | Why Dangerous | Minimum Workup to Exclude | Timeline |
|-----------|--------------|--------------------------|----------|
| [Dx] | [consequence] | [specific test] | [how urgent] |

## Information Gaps — What I Don't Know
- [ ] [Missing history/exam/data that would change the differential]
- [ ] [Missing history/exam/data]
- [ ] [The single most valuable piece of information not yet available]

## Recommended Workup (Priority Order)

| Priority | Test | Discriminates Between | If Positive → | If Negative → |
|----------|------|----------------------|---------------|---------------|
| 1 | [test] | [Dx A] vs [Dx B] | [shift] | [shift] |
| 2 | [test] | Rules out [Dx] | [shift] | [shift] |
| 3 | [test] | Confirms [Dx] | [shift] | [shift] |

## Cognitive Bias Check
- **Anchoring**: [Am I over-weighting the referral diagnosis or first impression?]
- **Availability**: [Am I favoring diagnoses I've seen recently?]
- **Premature closure**: [Have I genuinely considered alternatives?]
- **Base rate neglect**: [Am I ignoring how common/rare these diagnoses actually are?]

## Updates Log
| Date | New Data | What Changed | Direction |
|------|----------|-------------|-----------|
```

### Bayesian Update Protocol (for /differential update)

When new information arrives:

1. **State the prior**: "Before this result, [Dx] was [category] because [reasons]."
2. **State the evidence**: "This new finding ([result]) has a LR of [X] for [Dx]" or "This finding is [strongly supports / mildly supports / argues against] [Dx] because [reasoning]."
3. **State the posterior**: "After incorporating this, [Dx] moves from [old category] to [new category]."
4. **Show what moved**: Clearly state which diagnoses moved up, which moved down, and which were unchanged.
5. **Update the table**: Modify the ranked differential table with new categories and reasoning.

### Important Constraints

- **Never assign false-precision percentages** (e.g., "37.2%") unless derived from a validated clinical decision rule with known sensitivity/specificity.
- **Always distinguish** between "the evidence says this is uncommon" vs. "I don't have evidence on the frequency."
- **If you are uncertain about your uncertainty**, say so. "I'm ranking this as Possible but I have low confidence in that estimate because..." is more useful than a confident-sounding probability.
- **When prevalence data doesn't exist** for this specific population, state the closest available data and note the extrapolation.

### Save Location
- If a workspace exists → save to that workspace's `differential.md`
- If no workspace → output in conversation (do NOT create a workspace unless user asks)

**End by asking:** "What additional data would you like to factor in? Or should I search the evidence on any of these diagnoses?"
