---
description: >
  Check drug interactions, dosing, and safety for a medication list.
  Provides interaction severity, renal/hepatic adjustments, black box
  warnings, and monitoring requirements.
argument-hint: <medication list, or "from workspace">
---

## Drug Interaction & Safety Check

Delegate to the **pharmacology-agent** subagent.

"Review the following medications for interactions and safety:

$ARGUMENTS

Provide:
1. All pairwise drug interactions with severity ratings
2. Black box warnings for any listed medications
3. QTc prolongation risk assessment if applicable
4. Monitoring requirements (labs, levels, ECG)
5. Any dosing concerns based on clinical context

If patient-specific factors are available (renal function, hepatic function,
weight, age), incorporate dose adjustment recommendations.

Format as a structured medication safety report."
