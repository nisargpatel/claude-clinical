---
description: >
  Analyze clinical documentation and identify appropriate ICD-10-CM and
  CPT/CDT codes. Checks medical necessity, E/M level, and flags coding issues.
argument-hint: <paste note text> OR "from workspace"
---

## Encounter Coding Assistant

Delegate to the **coding-agent** subagent.

### Determine Input
If $ARGUMENTS contains "from workspace" or "workspace":
→ Read the most recent note from the active workspace's `notes/` directory

Otherwise:
→ Use the clinical documentation text from $ARGUMENTS

### Delegation Prompt
"Review the following clinical documentation and provide a complete
coding summary. Include:
1. ICD-10-CM diagnosis codes (principal and secondary, highest specificity)
2. CPT or CDT procedure codes with appropriate modifiers
3. E/M level determination based on MDM complexity (if applicable)
4. Medical necessity verification (dx supports px)
5. Common coding error check (unbundling, laterality, specificity)
6. Documentation improvement suggestions if codes are limited by documentation

Consult the reference files in reference/icd10_common.json and reference/cpt_common.json.
Use the code_lookup.py script in .claude/skills/icd-cpt-coding/ if needed.

Documentation:
[note content]"
