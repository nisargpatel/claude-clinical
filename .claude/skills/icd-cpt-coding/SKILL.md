---
name: icd-cpt-coding
description: >
  Medical coding lookup and assistance. Use when identifying ICD-10-CM
  diagnosis codes, CPT procedure codes, or CDT dental codes from clinical
  documentation. Triggers: coding, ICD, CPT, CDT, billing codes, code
  this encounter, what code, how to code.
allowed-tools: Bash, Read, Grep
---

# ICD-10 / CPT / CDT Coding Skill

## How to Search for Codes

Use the bundled `code_lookup.py` script:

```bash
# Search ICD-10-CM codes by description
python .claude/skills/icd-cpt-coding/code_lookup.py --system icd10 --query "osteonecrosis jaw"

# Search CPT codes by description
python .claude/skills/icd-cpt-coding/code_lookup.py --system cpt --query "surgical extraction"

# Look up a specific code
python .claude/skills/icd-cpt-coding/code_lookup.py --system icd10 --code M87.180

# Filter by specialty
python .claude/skills/icd-cpt-coding/code_lookup.py --system icd10 --query "fracture" --specialty oral-surgery
```

## Reference Files
- `reference/icd10_common.json` — Common ICD-10 codes by specialty
- `reference/cpt_common.json` — Common CPT/CDT codes by specialty
- `reference/clinical_decision_rules.md` — Decision rules for E/M complexity

## Coding Rules to Follow
1. **Highest specificity**: Always use the most specific code supported by documentation
2. **Laterality**: Code right/left/bilateral when applicable
3. **7th character**: Include for injury/fracture codes (A=initial, D=subsequent, S=sequela)
4. **Medical necessity**: Verify diagnosis supports the procedure code
5. **Bundling**: Check if procedure codes are bundled (CCI edits)
6. **Modifiers**: Apply -25, -59, -LT/-RT, etc. as appropriate
7. **Never upcode**: Only code what the documentation explicitly supports
