---
description: Generate or update a ranked differential diagnosis using Bayesian reasoning. Can work from pasted clinical data or update an existing workspace differential as new information arrives.
argument-hint: "<clinical scenario>" OR "update" to refine existing differential with new data
---

## Differential Diagnosis Generator

### Determine Mode

**If $ARGUMENTS is "update", "refine", or "revise":**
1. Find the most recent workspace (or ask which one)
2. Read `clinical_summary.md` and `differential.md`
3. Ask: "What new information do you have?" (new labs, imaging, exam findings, response to treatment, etc.)
4. Update the differential with revised probabilities based on the new data
5. Log the update in the differential's Updates Log table

**Otherwise (new differential):**
1. Parse the clinical data from $ARGUMENTS
2. If a workspace exists for this case, read it for additional context
3. Generate a fresh differential

### Differential Construction Framework

**Step 1: Identify the chief complaint / clinical problem**
Frame it precisely: "non-healing extraction socket in a patient on IV bisphosphonates" not just "jaw pain"

**Step 2: Generate candidate diagnoses using multiple axes**
Think through:
- **Anatomic**: What structures are involved? What can go wrong at each?
- **Pathophysiologic**: Infectious, inflammatory, neoplastic, traumatic, vascular, metabolic, iatrogenic, congenital, autoimmune, degenerative
- **Epidemiologic**: What's common for this age/sex/population?
- **Pattern recognition**: What illness scripts does this match?

**Step 3: Rank by probability**
For each diagnosis, assess:
- Base rate (prevalence in this population and setting)
- Likelihood ratio of the key findings (how much does each finding shift probability?)
- Assign: High (>50%), Moderate (15-50%), Low (5-15%), Very Low (<5%)

**Step 4: Flag cannot-miss diagnoses**
Even if low probability, flag diagnoses that are:
- 🚨 Life-threatening if missed
- 🚨 Time-sensitive (treatment window)
- 🚨 Rapidly progressive

**Step 5: Recommend diagnostic workup**
For each diagnosis, identify the single best next test to confirm or exclude it. Prioritize:
1. Tests that discriminate between the top 2-3 diagnoses
2. Tests that rule out cannot-miss diagnoses
3. Least invasive / most cost-effective first

### Output Format

```markdown
# Differential Diagnosis

**Clinical Problem:** [precise framing]
**Last Updated:** [date]

---

| Rank | Diagnosis (ICD-10) | Probability | Key Supporting | Key Against | Best Next Test |
|------|-------------------|-------------|----------------|-------------|----------------|
| 1 | [Dx] ([code]) | High | [features] | [features] | [test] |
| 2 | ... | ... | ... | ... | ... |

## 🚨 Cannot-Miss Diagnoses
- [ ] [Diagnosis]: [why it's dangerous] → [how to rule out]

## Reasoning Notes
[Explain your Bayesian reasoning — what features shifted your probabilities most, what cognitive biases you're guarding against (anchoring, premature closure, availability)]

## Recommended Workup (Priority Order)
1. [Test] — discriminates between [Dx A] and [Dx B]
2. [Test] — rules out [cannot-miss Dx]
3. [Test] — confirms [top Dx]

## Updates Log
| Date | New Data | Change to Differential |
|------|----------|----------------------|
```

### Save Location
- If a workspace exists → save to that workspace's `differential.md`
- If no workspace → output in conversation and offer to create one

### Cognitive Bias Guards
At the end, explicitly check:
- **Anchoring**: Am I over-weighting the referral diagnosis?
- **Availability**: Am I favoring diagnoses I've seen recently?
- **Premature closure**: Have I considered at least 5 diagnoses?
- **Framing**: Would I think differently if this were presented differently?

If any bias risk is identified, note it in the Reasoning Notes.
