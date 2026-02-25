---
description: >
  Pre-clinic preparation: triage a list of upcoming patients by complexity,
  flag those needing pre-visit chart review, identify overdue labs/imaging,
  and generate a prioritized prep list. Use the day before or morning of clinic.
argument-hint: <paste patient list with brief summaries, or describe your upcoming clinic>
---

## Pre-Clinic Preparation

### Step 1: Ingest the Patient List
From $ARGUMENTS, parse each patient. Accept formats like:
- "1. 68F MRONJ follow-up 2. 45M wisdom teeth consult 3. 72M biopsy results"
- Pasted schedule with brief descriptions
- Any reasonable list format

### Step 2: Triage by Complexity

For each patient, categorize:

🔴 **Complex — Needs Pre-Visit Prep**
- New diagnosis requiring workup or treatment decision
- Results pending that will change management (biopsy, imaging, labs)
- Multi-system or multi-specialty coordination needed
- Difficult conversation expected (bad news, goals of care, treatment failure)
- Prior auth or insurance issue to address

🟡 **Moderate — Brief Review Recommended**
- Follow-up with expected change in management
- New patient with straightforward referral question
- Post-procedure follow-up with potential complications
- Medication adjustment needed based on response

🟢 **Routine — Standard Visit**
- Stable follow-up, no expected changes
- Routine post-op (healing as expected)
- Straightforward new patient consult
- Recall/surveillance visit

### Step 3: For Each 🔴 and 🟡 Patient, Generate:

```markdown
### [Patient identifier] — [🔴/🟡/🟢] [Complexity]

**Visit reason:** [brief]
**Key question for this visit:** [the clinical decision to be made]

**Pre-visit checklist:**
- [ ] [Review specific result/imaging/consult note]
- [ ] [Check if referral completed]
- [ ] [Verify medication refills]
- [ ] [Review outside records if applicable]

**Anticipate:**
- Likely assessment: [what you'll probably conclude]
- Decision point: [the choice you'll need to make]
- Time estimate: [standard / will run long]

**Prep note:** [any specific thing to look up or have ready]
```

### Step 4: Clinic Summary

```markdown
## Clinic Prep: [Date]

**Total patients:** [N]
**Complexity breakdown:** 🔴 [N] | 🟡 [N] | 🟢 [N]

**Time management flags:**
- [Patient X] will likely run long — [reason]
- [Patient Y] may need interpreter / family meeting / extra time

**Results to review before clinic:**
- [Patient]: [specific result to check]

**Pre-visit orders to consider:**
- [Patient]: [labs or imaging that should have been ordered]

**Supplies / materials to have ready:**
- [e.g., consent forms, educational handouts, specific instruments]
```

### Step 5: Offer Deeper Prep

"Want me to prep a specific patient in more detail? I can:
- Build a workspace for complex cases (/new-case)
- Search evidence for a clinical question (/evidence-search)
- Draft a management plan (/manage)
- Review their medication list (/drug-check)"

### Output
Output in conversation for quick clinics (≤10 patients).
For larger clinics, offer to save as `workspaces/clinic_prep_[date].md`.
