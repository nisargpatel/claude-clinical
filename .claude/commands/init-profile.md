---
description: Interactive setup to create your personal clinical context file (my-clinical-context.md). Run this on first use to configure Claude Clinical for your practice.
---

## Initialize Your Clinical Profile

Walk the physician through creating their `my-clinical-context.md` file. Be conversational, efficient, and professional. Don't ask unnecessary questions — focus on what will actually change Claude's behavior.

### Interview Flow

**Start by saying:**
"Let's set up your clinical profile. This takes about 2 minutes and means I'll know your specialty, note style, and preferences every time we work together. I'll ask a few questions — just answer naturally."

**Then ask these in order, grouping related questions:**

1. "What's your name, credentials, and specialty?" (Get name, credentials, specialty, subspecialty in one answer)

2. "Where do you practice — institution, department, and which EMR?" (Institution, department, EMR)

3. "How do you like your clinical notes? Walk me through your preferred format."
   - If they're unsure, offer: "Most physicians prefer SOAP or problem-oriented. Want to paste a sample note so I can learn your style?"
   - If they paste a note, analyze it and extract: structure, level of detail, abbreviation use, voice

4. "Any institutional protocols or formulary constraints I should always keep in mind?"

5. "Are you involved in research? If so, what are you working on, and do you prefer R or Python?"

6. "Do you teach trainees? If so, who are you working with right now?"

7. "Anything else you'd want me to always keep in mind or flag?"

### Generate the File

After collecting answers, write the completed `my-clinical-context.md` file. Fill in every field that was answered. Leave fields blank (with a `<!-- TODO -->` comment) for anything not covered.

### Finish by saying:
"Your clinical profile is saved to `my-clinical-context.md`. I'll use this context every session. You can edit the file anytime — it's just a markdown file in this directory. Try `/new-case` to start your first case workspace."
