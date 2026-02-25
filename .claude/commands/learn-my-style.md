---
description: >
  Analyze 1-5 of your actual clinical notes to learn your documentation style,
  then update my-clinical-context.md with extracted patterns. Feed me your real
  notes (de-identified) and I'll learn: structure, voice, abbreviation patterns,
  level of detail, how you write A/P sections, and your idiosyncrasies.
argument-hint: <paste a sample note, or "analyze" followed by pasted notes>
---

## Learn My Documentation Style

### Step 1: Receive Sample Notes
Accept one or more clinical notes from $ARGUMENTS. If the physician pastes
multiple notes, separate them by "---" or "NEXT NOTE".

Tell the physician: "I'll analyze your notes to learn your style. The more
examples you give me (ideally 3-5 different note types), the better I'll
capture your patterns. De-identify any patient data before pasting."

### Step 2: Analyze Each Note For:

**Structure & Organization**
- What sections do they include/exclude?
- What order are sections in?
- Do they use headers, or is it flowing narrative?
- How do they structure the A/P? (problem-oriented with numbered items? single narrative? SOAP?)
- Do they separate assessment from plan, or combine?

**Voice & Tone**
- Terse-telegraphic ("68F p/w non-healing socket") vs. prose ("This is a 68-year-old female who presents with...")
- Passive vs. active voice
- First person ("I examined") vs. impersonal ("Patient examined")
- How do they handle uncertainty? ("likely" vs. "most consistent with" vs. "cannot rule out")

**Abbreviation Patterns**
- Which abbreviations do they use freely? (h/o, s/p, c/w, ROS, etc.)
- Which do they spell out?
- Any idiosyncratic abbreviations specific to their practice?

**Level of Detail**
- Do they document normal findings or omit them?
- How much ROS detail?
- How detailed is the physical exam documentation?
- Do they include differentials in routine notes or only complex ones?

**Clinical Reasoning Markers**
- Do they cite evidence in notes?
- Do they document decision-making rationale?
- How do they handle shared decision-making documentation?
- Do they document time spent (relevant for E/M)?

**Formatting Preferences**
- Bullet points vs. narrative in plan
- Table format for meds/labs vs. inline
- Signature style

**Specialty-Specific Patterns**
- What exam elements are always included?
- What specialty-specific sections do they have?
- How do they document procedures within a note?

### Step 3: Generate a Style Profile

Produce a summary like:

```markdown
## Documentation Style Analysis

### Based on [N] sample notes analyzed

**Overall voice:** [terse-telegraphic / concise-prose / detailed-narrative]

**Note structure pattern:**
- [Describe their typical section order and what they include/omit]

**A/P style:**
- [How they write assessments and plans]

**Key patterns observed:**
- [Pattern 1]
- [Pattern 2]
- [Pattern 3]

**Abbreviations used freely:**
- [list]

**Phrases characteristic of their writing:**
- [e.g., "The patient was counseled regarding..." or "Plan discussed with patient who agrees"]

**What they NEVER include:**
- [e.g., never documents full ROS if negative, never uses "pleasant"]

**Specialty-specific elements:**
- [e.g., always includes dental charting notation, always documents MRONJ staging]
```

### Step 4: Update my-clinical-context.md

Ask the physician: "Here's what I learned from your notes. Should I update
your clinical context file with these patterns?"

If yes, **append** the style analysis to the relevant sections of
`my-clinical-context.md`. Don't overwrite existing preferences — merge
with them, noting any conflicts.

### Step 5: Confirm

"Your documentation style is now captured. The note-writer agent will use these
patterns when drafting notes for you. If the output drifts from your style over
time, paste another sample note and run `/learn-my-style` again to recalibrate."
