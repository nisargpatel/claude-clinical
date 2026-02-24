---
description: Create a new patient workspace for case-based clinical reasoning. Initializes structured files for clinical summary, differential diagnosis, evidence, notes, and decision-making.
argument-hint: <brief case descriptor, e.g., "68F-MRONJ-consult" or "45M-chest-pain-ED">
allowed-tools: Bash(mkdir:*), Bash(date:*), Write, Read
---

## Create a New Patient Workspace

### Step 1: Create the directory

Generate today's date in YYYY-MM-DD format. Create the workspace at:
`workspaces/[YYYY-MM-DD]_$ARGUMENTS/`

Also create subdirectories: `evidence/`, `notes/`, `letters/`

### Step 2: Initialize clinical_summary.md

```markdown
# Clinical Summary

**Created:** [today's date]
**Case:** $ARGUMENTS
**Last Updated:** [today's date]

---

## Patient Demographics
- **Age/Sex:**
- **Relevant PMH:**
- **Relevant PSH:**

## Presenting Concern


## History of Present Illness


## Current Medications


## Allergies


## Key Examination Findings


## Investigations
| Test | Date | Result | Interpretation |
|------|------|--------|----------------|

## Active Problems


## Working Assessment

```

### Step 3: Initialize differential.md

```markdown
# Differential Diagnosis

**Case:** $ARGUMENTS
**Last Updated:** [today's date]

---

| Rank | Diagnosis | Probability | Supporting Evidence | Against | Next Best Test |
|------|-----------|-------------|--------------------|---------|--------------------|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |
| 4 | | | | | |
| 5 | | | | | |

## 🚨 Cannot-Miss Diagnoses
- [ ]

## Reasoning Notes


## Updates Log
| Date | New Data | Change to Differential |
|------|----------|----------------------|
```

### Step 4: Initialize decision_matrix.md

```markdown
# Treatment Decision Matrix

**Case:** $ARGUMENTS
**Last Updated:** [today's date]

---

| Option | Efficacy Evidence | Key Risks | Cost/Access | Patient Factors | Recommendation |
|--------|-------------------|-----------|-------------|-----------------|----------------|

## Key Trade-offs


## Patient Preferences / Values


## Shared Decision-Making Notes

```

### Step 5: Confirm to the physician

Tell them:
"Workspace created at `workspaces/[path]/`. It has templates for clinical summary, differential diagnosis, and decision matrix. Paste or dictate the clinical data and I'll structure the case. You can also run `/consult` with the full scenario to trigger the complete workflow."

List the files created.
