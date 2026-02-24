---
description: >
  Draft an insurance prior authorization appeal or denial appeal letter with
  evidence-based medical necessity justification. Includes CPT/ICD codes,
  guideline citations, and CMS coverage criteria.
argument-hint: <paste denial details or describe the situation>
---

## Insurance Appeal Letter Generator

### Step 1: Parse the Denial
From $ARGUMENTS, extract:
- Insurance company and plan type (if provided)
- Denied service/procedure (CPT/CDT code if known)
- Stated reason for denial
- Patient clinical context
- Date(s) of service

### Step 2: Gather Evidence (delegate to evidence-reviewer)
Delegate to **evidence-reviewer** subagent:
"Search for evidence supporting the medical necessity of [procedure/service]
for [clinical indication]. Find:
1. Clinical practice guidelines recommending this intervention
2. Peer-reviewed studies demonstrating efficacy/necessity
3. CMS LCD/NCD coverage criteria if applicable
Focus on the strongest, most authoritative sources."

### Step 3: Identify Codes (delegate to coding-agent)
Delegate to **coding-agent** subagent:
"Identify the correct ICD-10 and CPT/CDT codes for this case:
[clinical scenario]. Verify the medical necessity linkage between
diagnosis and procedure codes."

### Step 4: Draft the Appeal Letter
Using the template from `templates/letters/appeal.md`:

1. **Header**: Patient identifiers, claim/reference numbers, date of service
2. **Opening**: State you are writing to appeal the denial of [service]
3. **Clinical Indication**: Concise presentation of the clinical scenario
   with specific findings that establish medical necessity
4. **Evidence Base**: Cite 3-5 strongest references:
   - Relevant clinical practice guidelines (with specific sections)
   - Peer-reviewed studies
   - CMS coverage criteria if applicable
5. **Address Denial Reason**: Directly rebut the stated reason for denial
6. **Medical Necessity Argument**: Explain why this specific patient requires
   this specific intervention, referencing the clinical data and evidence
7. **Urgency**: If clinically time-sensitive, state why delay causes harm
8. **Closing**: Request reconsideration, provide contact information
9. **Signature block**: From my-clinical-context.md

### Step 5: Save and Present
Save to workspace `letters/appeal_[date].md` if a workspace exists.

Tell the physician: "Appeal letter drafted with [N] evidence citations.
Review for accuracy — especially the clinical details and your signature block.
The letter directly addresses the stated denial reason of [reason]."
