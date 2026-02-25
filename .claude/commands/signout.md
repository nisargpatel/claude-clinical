---
description: >
  Generate a structured inpatient sign-out / handoff document for one or more
  patients. Follows I-PASS format (Illness severity, Patient summary, Action list,
  Situation awareness, Synthesis by receiver). Use at end of shift for safe
  handoff to covering physician. Can work from existing workspaces or fresh input.
argument-hint: <patient summaries> OR "from workspaces" to pull from active cases
---

## Inpatient Sign-Out / Handoff Generator

### Determine Input Source

**If $ARGUMENTS contains "from workspaces" or "from workspace":**
- Scan `workspaces/` for all active case directories
- Read each workspace's `clinical_summary.md` and latest note
- Generate sign-out entries for each

**Otherwise:**
- Parse patient summaries from $ARGUMENTS
- Accept multiple patients separated by "---" or "next patient"

### For Each Patient, Generate I-PASS Format:

```markdown
## [Patient identifier — room/bed or initials] | [Age/Sex] | [Primary team]
**Admission date:** [date] | **Day #:** [N]

### 🔴🟡🟢 Illness Severity: [Stable / Watcher / Unstable]

### One-Liner
[Single sentence: who they are, why they're here, where they are in their course]

### Active Problems
1. **[Problem]** — [current status, today's plan, trending direction]
2. **[Problem]** — [status]

### Action List (Overnight To-Dos)
- [ ] [Specific task with parameters: "Check 10pm BMP — call if K >5.5"]
- [ ] [Task]
- [ ] [Task]

### If/Then Contingencies
- **If** [specific scenario] → **Then** [specific action]
- **If** [scenario] → **Then** [action]
- **If** patient clinically decompensates → [escalation plan, who to call]

### Key Meds / Drips
[Only the critical ones: anticoagulation, insulin, pressors, antibiotics with end date]

### Code Status: [Full / DNR / DNI / DNR-DNI / COMFORT]
### Allergies: [Critical allergies only]
### Primary contact: [Family member / POA, phone if available]

---
```

### Formatting Rules
- **Be terse.** Night cross-cover needs to scan this in 30 seconds per patient.
- **Be specific.** "Call if HR >120" not "call if tachycardic."
- **Prioritize actionability.** What does the covering physician actually need to DO?
- **Flag the watchers.** Patients who might decompensate overnight get 🔴 or 🟡.
- **Include pending results** with expected times and what to do with them.
- **Anticipatory guidance** is the most valuable part — the if/then contingencies.

### Illness Severity Guide
- 🟢 **Stable**: Unlikely to need overnight intervention. Routine tasks only.
- 🟡 **Watcher**: Could change overnight. Specific parameters to watch. Low threshold to assess.
- 🔴 **Unstable**: Active issues requiring close monitoring. May need escalation.

### Output
If generating for multiple patients, compile into a single sign-out document.
Output in conversation for quick sign-outs.
For a full service list, offer to save as `workspaces/signout_[date].md`.

**End with:** "Sign-out for [N] patients generated. Review the if/then contingencies — these are the most important part for overnight safety."
