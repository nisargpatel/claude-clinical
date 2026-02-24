---
description: >
  Draft a clinical note in the physician's preferred style. Supports SOAP,
  H&P, consult, progress, procedure, and discharge notes.
argument-hint: <note type> <clinical data or "from workspace">
---

## Clinical Note Drafting

Delegate to the **note-writer** subagent.

### Determine Note Type
Parse $ARGUMENTS for one of:
- **soap** or **progress** → SOAP / progress note
- **hp** → History and physical
- **consult** → Consultation note
- **procedure** or **op** → Procedure / operative note
- **discharge** → Discharge summary
- **followup** → Follow-up note

### Determine Data Source
If $ARGUMENTS contains "from workspace" or "workspace":
→ Read all files from the most recent workspace for context

Otherwise:
→ Use the clinical data provided in $ARGUMENTS

### Delegation Prompt
"Draft a [note type] note for the following clinical data.
Read my-clinical-context.md for the physician's preferred style and format.
Use the template from templates/notes/[appropriate template].
Mark uncertain items with [VERIFY: reason].
If a workspace exists, save to workspace notes/ directory.

Clinical data:
[data from $ARGUMENTS or workspace]"

### Post-Draft
After the note is written, offer:
"Note drafted. Would you like me to:
1. Code the encounter (/code-encounter)
2. Check guideline compliance (/check-guidelines)
3. Revise specific sections"
