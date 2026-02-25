---
description: >
  Treatment planning and management optimization for a KNOWN diagnosis. Unlike
  /differential (which works up diagnostic uncertainty), /manage assumes the
  diagnosis is established and focuses on: evidence-based treatment options,
  medication selection, monitoring plan, patient counseling, and follow-up.
  Use when: diagnosis is clear, you need to optimize the management plan.
argument-hint: <diagnosis and patient context, e.g., "Stage 2 MRONJ in 68F on IV zoledronic acid">
---

## Management Plan Builder

**This is NOT a diagnostic workup.** The diagnosis is established. Focus entirely
on management optimization.

### Step 1: Parse the Clinical Context
From $ARGUMENTS, extract:
- **Established diagnosis** (with staging/severity if provided)
- **Patient factors**: age, sex, comorbidities, current medications, allergies
- **Prior treatments**: what's been tried, what's failed, what's ongoing
- **Specific constraints**: patient preferences, formulary limits, functional status

### Step 2: Build the Treatment Plan

Structure the plan around:

**First-line Management**
- What do current guidelines recommend as first-line? (cite the guideline)
- Is this patient a candidate for first-line? If not, why not?

**Treatment Options Matrix**
Create a concise comparison:

| Option | Evidence | Expected Outcome | Key Risks | Monitoring | Cost/Access |
|--------|----------|-------------------|-----------|------------|-------------|

Evidence column uses tags: `[GRADE: High/Moderate/Low/Very Low]`, `[Evidence gap]`, `[Extrapolated]`

**For each viable option include:**
- Specific drug/dose/route/duration OR procedure details
- Expected timeline to response
- When to escalate or switch
- What defines treatment failure

**Medication Details** (delegate to pharmacology-agent if complex polypharmacy):
- Exact dosing with adjustments for this patient's renal/hepatic function
- Key interactions with current medication list
- Monitoring schedule (labs, imaging, clinical checkpoints)

**Patient Factors**
- How do this patient's comorbidities affect treatment selection?
- Are there contraindications to any standard options?
- What are the patient's likely preferences/values to discuss?

### Step 3: Build the Monitoring Plan

| Timepoint | Assessment | Action if Abnormal |
|-----------|------------|-------------------|
| [e.g., 2 weeks] | [what to check] | [what to do] |

### Step 4: Patient Counseling Points
- What does the patient need to understand about their condition?
- Expected timeline and realistic outcome expectations
- Warning signs that should prompt immediate contact
- Lifestyle modifications if applicable

### Step 5: Draft the A/P Section
Write a concise Assessment and Plan that could be pasted into a note:
- Assessment: one-line synthesis with diagnosis and severity
- Plan: numbered, specific, actionable items

### Output
- If a workspace exists for this patient → save to `decision_matrix.md` and append A/P to the latest note
- If no workspace → output in conversation (do NOT create a workspace)

**End by asking:** "Want me to draft the full note (/write-note), check drug interactions (/drug-check), or code this encounter (/code-encounter)?"
