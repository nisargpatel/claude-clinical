---
description: >
  Full consultation workflow: structures clinical data, generates differential,
  searches evidence, checks guidelines, drafts consult note, and identifies
  coding. Orchestrates multiple subagents in parallel.
argument-hint: <paste or describe the full clinical scenario>
---

## Full Consultation Workflow

This is the flagship workflow. It orchestrates all five subagents to produce
a complete case workup from a clinical scenario.

### Step 1: Create the Workspace
If no workspace exists for this case, create one following the `/new-case` convention.
Use a descriptive name derived from the clinical scenario (age, sex, key problem).

### Step 2: Structure the Clinical Data
Parse $ARGUMENTS to extract and organize:
- Demographics, presenting complaint, HPI
- Past medical/surgical history
- Current medications and allergies
- Examination findings
- Available investigations (labs, imaging, pathology)
- Referral context (who referred, what they're asking)

Save structured data to the workspace's `clinical_summary.md`.

### Step 3: Generate Differential Diagnosis
Based on the structured clinical data, follow the full `/differential` framework:
- Generate a ranked differential diagnosis (minimum 5 diagnoses)
- Use probability CATEGORIES (Leading / Strong contender / Possible / Cannot-miss) — not false-precision percentages
- Anchor each estimate to base rates with confidence flags (🟢🟡🔴)
- For each: key features for and against, with likelihood ratios where published
- Identify cannot-miss diagnoses with 🚨
- Explicitly list information gaps — what's missing that would change the differential
- Suggest a prioritized diagnostic workup with expected impact on probabilities
- Save to `differential.md`

### Step 4: Parallel Subagent Delegation

Delegate these tasks simultaneously:

**→ evidence-reviewer subagent:**
"Search for evidence on the top 3 diagnoses for this case: [summary].
Focus on current management guidelines and recent systematic reviews.
Save results to the workspace evidence/ directory."

**→ guideline-checker subagent:**
"Check the proposed assessment and workup against current clinical
practice guidelines for [relevant conditions]. Produce a compliance report."

**→ pharmacology-agent subagent:**
(If medications are listed) "Review this medication list for interactions
and safety concerns in the context of [clinical scenario]: [med list]"

### Step 5: Draft the Consultation Note
Delegate to **note-writer subagent**:
"Draft a consultation note for this case using the physician's preferred format.
Read my-clinical-context.md for style. Read the workspace files for clinical data,
differential, and evidence. Save to workspace notes/initial_consult.md."

### Step 6: Code the Encounter
Delegate to **coding-agent subagent**:
"Review the consultation note at [workspace]/notes/initial_consult.md and
identify appropriate ICD-10-CM and CPT codes. Append coding summary."

### Step 7: Present Summary to Physician

```markdown
## 📋 Consultation Workup Complete

**Case:** [descriptor]
**Workspace:** `workspaces/[path]/`

### Files Generated
- 📄 `clinical_summary.md` — Structured clinical data
- 🧠 `differential.md` — Ranked DDx with [N] diagnoses
- 📚 `evidence/evidence_summary.md` — Literature review
- ✅ Guideline compliance report (in conversation)
- 💊 Medication review (if applicable)
- 📝 `notes/initial_consult.md` — Draft consultation note
- 🏷️ Encounter coding summary

### Top 3 Differential
1. [Dx] — [category] [🟢🟡🔴] — [key supporting feature]
2. [Dx] — [category] [🟢🟡🔴] — [key supporting feature]
3. [Dx] — [category] [🟢🟡🔴] — [key supporting feature]

### ⚠️ Information Gaps
- [Key missing data that would change the differential]

### 🚨 Items Needing Attention
- [Red flags, time-sensitive issues, VERIFY items in the note]

### Suggested Next Steps
1. [Most important next action]
2. [Second priority]
3. [Third priority]
```

Tell the physician: "Full workup is in your workspace. Review the note — there are
[N] items flagged with [VERIFY]. What would you like to refine?"
