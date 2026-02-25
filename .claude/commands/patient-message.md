---
description: >
  Draft a response to a patient portal message (MyChart, patient email, etc.)
  at an appropriate reading level with the right clinical tone. Handles:
  lab result explanations, medication questions, appointment requests, symptom
  inquiries, post-procedure instructions, and general health questions.
argument-hint: <paste the patient's message and any relevant clinical context>
---

## Patient Message Response Drafter

### Step 1: Analyze the Patient's Message
From $ARGUMENTS, identify:
- **Message type**: lab question / medication question / symptom concern / appointment request / post-procedure question / insurance/billing / referral status / other
- **Urgency**: routine / needs-timely-response / potentially-urgent
- **Clinical context**: any relevant diagnoses, recent procedures, or medications mentioned

### Step 2: Check for Red Flags
Before drafting a routine response, screen for:
- 🚨 Symptoms suggesting emergency (chest pain, difficulty breathing, uncontrolled bleeding, signs of infection with fever, neurologic changes)
- 🚨 Medication safety concerns (allergic reaction symptoms, dangerous side effects)
- 🚨 Mental health crisis language

If red flags → draft a response that directs the patient to seek immediate care (ED or call 911), then address the specific question. Do NOT provide reassurance that could delay emergency evaluation.

### Step 3: Draft the Response

**Writing rules:**
- **Reading level**: 6th-8th grade (Flesch-Kincaid). No jargon. If a medical term is necessary, define it in parentheses.
- **Tone**: Warm, direct, and reassuring (but not falsely reassuring). The patient should feel heard and clearly informed.
- **Length**: 3-8 sentences for simple questions. Up to 2-3 short paragraphs for complex explanations. Patients don't read long messages.
- **Structure**: Answer the question first, then explain, then give clear next steps.
- **Action items**: End with a specific, concrete next step ("Please call our office at [number] to schedule..." or "No action needed — we'll see you at your next appointment on [date].")

**For lab results:**
- State whether results are normal, abnormal, or need monitoring
- Explain what the test measures in plain language
- What the result means for THEM specifically
- What happens next (nothing / repeat test / medication change / appointment)
- Do NOT list raw numbers without context

**For medication questions:**
- Answer the specific question clearly
- Include relevant timing, food interactions, or common side effects if asked
- Direct them to pharmacy or ED for urgent medication concerns

**For symptom concerns:**
- Acknowledge the symptom
- Give practical guidance (self-care, when to call, when to go to ED)
- Be specific about what to watch for
- Do NOT diagnose via portal message

**For post-procedure questions:**
- Normalize expected post-procedure experiences
- Clearly distinguish normal vs. concerning signs
- Give specific parameters ("swelling that increases after day 3" not just "worsening swelling")

### Step 4: Format

```
Dear [Patient Name],

Thank you for reaching out.

[Response body]

[Clear next step / action item]

[Closing — warm but professional]

[Signature block from my-clinical-context.md]
```

### Step 5: Review Flags
Mark anything that needs physician verification:
- [VERIFY: specific clinical detail]
- [CUSTOMIZE: insert specific date/number/appointment]

### Output
Output in conversation. Do NOT create workspace files for portal messages unless the physician asks.

**Important:** Remind the physician — "Review before sending. Portal messages become part of the medical record."
