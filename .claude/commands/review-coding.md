---
description: >
  Reverse coding review: given a target E/M level or CPT code, analyze whether
  the documentation supports it and identify what's missing. Use when you know
  what you want to bill and need to verify your note is sufficient, or when
  you want to optimize documentation BEFORE finalizing the note.
argument-hint: <target code(s)> <note text or "from workspace">
---

## Reverse Coding Review

**This works backward from the target code to the documentation, unlike
/code-encounter which works forward from documentation to codes.**

### Step 1: Parse Input
From $ARGUMENTS, identify:
- **Target code(s):** The E/M level or CPT codes the physician intends to bill
  - E.g., "99215", "99223", "99245", "D7240 + D0367"
- **Documentation source:** pasted note text, or "from workspace" to read the latest note

### Step 2: E/M Level Review (if target is an E/M code)

Using the **2021+ MDM-based E/M guidelines**, evaluate the note against the
three MDM elements for the target level:

#### For the target E/M code, the documentation MUST support:

**Number and Complexity of Problems Addressed**
- What the target level requires: [state the criterion]
- What the note documents: [extract from note]
- ✅ Sufficient / ❌ Insufficient — [what's missing]

**Amount and Complexity of Data Reviewed and Analyzed**
- What the target level requires: [state the criterion]
- What the note documents: [extract from note]
- ✅ Sufficient / ❌ Insufficient — [what's missing]
- 💡 Tip: Document independent interpretation of imaging, review of external records, or discussion with external physician to meet higher data thresholds

**Risk of Complications and/or Morbidity or Mortality**
- What the target level requires: [state the criterion]
- What the note documents: [extract from note]
- ✅ Sufficient / ❌ Insufficient — [what's missing]

**Minimum 2 of 3 elements must meet the target level.**

### Step 3: Procedure Code Review (if target includes procedure codes)

For each procedure code:
- **Is the procedure documented?** Indication, technique, findings
- **Is medical necessity established?** Does a diagnosis code support it?
- **Are modifiers needed?** -25, -59, -LT/-RT, etc.
- **Is there a bundling conflict** with other codes being billed?

### Step 4: Gap Analysis

```markdown
## Coding Review: [Target Code(s)]

### Verdict: ✅ Documentation supports / ⚠️ Almost — minor additions needed / ❌ Insufficient

### Supported Elements
- [What's already well-documented]

### Gaps — Add to Note Before Billing
1. ❌ [Specific missing element] — **Add:** "[suggested language to insert]"
2. ❌ [Missing element] — **Add:** "[suggested language]"
3. ⚠️ [Weak area] — **Strengthen by:** "[suggestion]"

### Suggested Addendum Language
If the note is already signed, here's addendum language to close the gaps:

"Addendum [date]: [specific additional documentation to support the code]"

### Alternative Codes
If the note doesn't support the target:
- **Documentation currently supports:** [lower code]
- **To reach [target code], add:** [specific elements]
```

### Step 5: Offer Next Steps
- "Want me to add the missing documentation elements to the note draft?"
- "Want me to generate the addendum language?"

### Output
Output in conversation. If working from a workspace, offer to update the note
file with the additional documentation.
