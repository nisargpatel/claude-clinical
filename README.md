# Claude Clinical 🏥

**A clinical intelligence environment for physicians, built on Claude Code.**

Claude Clinical transforms Claude Code from a general-purpose coding assistant into an agentic clinical reasoning, documentation, and research platform. 

## What You Get

| Feature | Description |
|---------|-------------|
| 🧠 **Persistent clinical context** | Claude knows your specialty, note style, and institution every session |
| ⚡ **Speed tiers** | Fast (seconds), Standard (single-agent), Deep (multi-agent) — matches your clinical pace |
| 📁 **Per-case workspaces** | Organized case files with structured reasoning that persists across sessions |
| 🤖 **5 clinical subagents** | Evidence reviewer, guideline checker, pharmacologist, coder, and note writer — working in parallel |
| 📝 **18 slash commands** | From `/quick` (instant answers) to `/consult` (full case workup) to `/signout` (inpatient handoff) |
| 🏥 **Inpatient + outpatient** | Sign-out, pre-clinic prep, patient messages, management plans — not just research |
| 🔬 **Live evidence search** | PubMed integration via MCP for real-time literature retrieval |
| 🏷️ **Forward + reverse coding** | Note→codes AND code→documentation gap analysis |
| 📊 **Research analysis** | R/Python execution for data analysis and manuscript drafting |
| 🎨 **Learns your style** | Analyze your actual notes to capture your documentation voice |

## How It Works

Claude Clinical is a **configuration layer** on top of Claude Code. There's no app to deploy — it's a collection of carefully crafted markdown files that teach Claude Code to operate as a clinical intelligence system:

- `CLAUDE.md` — Master instructions for clinical behavior
- `.claude/agents/` — 5 specialist subagents with clinical expertise
- `.claude/commands/` — Slash commands for clinical workflows
- `.claude/skills/` — Skills with bundled scripts (e.g., code lookup)
- `templates/` — Clinical document templates
- `reference/` — ICD-10, CPT codes, clinical decision rules

You clone the repo, run setup, and launch Claude Code. That's it.

## Requirements

- **[Claude Code](https://code.claude.com)** installed (requires Claude Pro, Max, Teams, or API key)
- **Python 3.10+** (for the coding skill script)
- **Node.js 18+** (for MCP servers, if you want PubMed integration)

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/claude-clinical.git
cd claude-clinical

# 2. Run first-time setup
chmod +x setup.sh
./setup.sh

# 3. Edit your clinical context (or use /init-profile inside Claude)
nano my-clinical-context.md   # or: code my-clinical-context.md

# 4. Launch Claude Clinical
claude
```

On first launch inside the repo, Claude reads `CLAUDE.md` and becomes Claude Clinical — aware of your specialty, your templates, your subagents, and your tools.

## Commands

### 🟢 Fast Mode — Quick Clinical Answers
| Command | What It Does |
|---------|-------------|
| `/quick <question>` | **Instant clinical answer.** Dosing, interactions, criteria, facts. No files, no subagents. |

### 🟡 Standard Mode — Single-Agent Workflows
| Command | What It Does |
|---------|-------------|
| `/manage <diagnosis + context>` | **Treatment plan for a known diagnosis.** Options matrix, monitoring, A/P draft. |
| `/patient-message <message>` | **Draft patient portal response.** Appropriate reading level, safety-screened. |
| `/signout <patients>` | **Inpatient handoff.** I-PASS format with if/then contingencies. |
| `/prep-clinic <patient list>` | **Pre-clinic triage.** Complexity-flag patients, identify prep tasks. |
| `/write-note <type>` | Draft clinical note in your preferred style |
| `/drug-check <meds>` | Drug interaction and safety check |
| `/code-encounter` | ICD-10/CPT coding from documentation (forward: note→codes) |
| `/review-coding <target code>` | **Reverse coding.** Does my note support this E/M level? What's missing? |
| `/appeal <denial>` | Insurance appeal letter with evidence citations |
| `/learn-my-style <notes>` | **Analyze your sample notes** and learn your documentation patterns |
| `/evidence-search <question>` | PICO-structured literature search |

### 🔴 Deep Mode — Multi-Agent Workflows
| Command | What It Does |
|---------|-------------|
| `/consult <scenario>` | **Full consultation workflow**: DDx + evidence + note + coding |
| `/differential <data>` | Generate ranked Bayesian differential diagnosis |
| `/new-case <desc>` | Create a patient workspace with structured templates |

### Setup & Research
| Command | What It Does |
|---------|-------------|
| `/init-profile` | Guided setup of your clinical context (run once) |
| `/research-analyze <goals>` | Dataset analysis with R or Python |
| `/manuscript-draft <section>` | Draft manuscript sections for target journal |

## Subagents

Claude Clinical includes 5 specialist subagents that work in parallel:

| Agent | Role | Used By |
|-------|------|---------|
| `evidence-reviewer` | PubMed search, critical appraisal, evidence synthesis | `/evidence-search`, `/consult` |
| `guideline-checker` | Verify plans against published guidelines | `/consult` |
| `pharmacology-agent` | Drug interactions, dosing, safety screening | `/drug-check`, `/consult` |
| `coding-agent` | ICD-10/CPT coding, E/M level, medical necessity | `/code-encounter`, `/consult` |
| `note-writer` | Clinical documentation in physician's voice | `/write-note`, `/consult` |

## Example Workflows

### Quick Clinical Question (Fast Mode)
```
> /quick renal dose augmentin CrCl 30
> /quick Wells score criteria PE
> /quick can I give ketorolac post-op with CrCl 38
```
No files created. Direct answers in seconds.

### Management of Known Diagnosis (Standard Mode)
```
> /manage Stage 2 MRONJ in 68F on IV zoledronic acid x3yr for metastatic
  breast cancer. Failed conservative management x 8 weeks. Current meds:
  zoledronic acid, letrozole, metformin, lisinopril.
```
Generates treatment options matrix, monitoring plan, and A/P section.

### Patient Portal Response
```
> /patient-message Patient asks: "I had my tooth pulled 3 days ago and
  there's still some bleeding when I bite on the gauze. Is this normal?
  Should I come back in?"
```
Drafts response at 6th-8th grade reading level with appropriate safety screening.

### Inpatient Sign-Out
```
> /signout
  1. 68F MRONJ post-debridement POD2, on IV clinda, pain controlled
  2. 45M Ludwig's angina s/p I&D, airway stable, on amp-sulbactam day 3
  3. 72M mandible fracture s/p ORIF POD1, IMF in place, on liquid diet
```
Generates I-PASS format handoff with if/then contingencies for each patient.

### Pre-Clinic Prep
```
> /prep-clinic Tomorrow's clinic:
  1. New pt: 55F referred for jaw lesion on panorex
  2. Follow-up: 68F MRONJ 6wk post-debridement
  3. Follow-up: 30M wisdom teeth consult
  4. New pt: 78M on denosumab needs extractions, referred by oncology
  5. Follow-up: 45F post-op biopsy, path results pending
```
Triages by complexity, flags the patients needing pre-visit prep, identifies pending results.

### Reverse Coding Review
```
> /review-coding 99245 [paste consult note]
```
Checks whether documentation supports new patient E/M level 5, identifies MDM gaps.

### Learn Your Note Style
```
> /learn-my-style [paste 3-5 of your actual de-identified notes]
```
Analyzes your documentation patterns and updates your clinical context file.

### Full Consultation (Deep Mode)
```
> /consult 68F referred by oncology for non-healing extraction socket #19,
  6 weeks post-extraction. History of IV zoledronic acid x 3 years for
  metastatic breast cancer. Exposed bone visible in socket. No purulence.
  Pain 4/10. Panorex shows sequestrum formation.
```
Claude Clinical creates a workspace, generates a staged MRONJ differential, searches current AAOMS guidelines, drafts a consult note, and codes the encounter.

### Insurance Appeal
```
> /appeal Denial for CBCT imaging (D0367). Insurance states "not medically
  necessary." Patient has suspected MRONJ with clinical bone exposure and
  needs 3D imaging for surgical planning and staging.
```

## Privacy & Safety

⚠️ **Important considerations:**

- **No patient data is committed to git.** The `workspaces/` directory and `my-clinical-context.md` are gitignored.
- **You control what data enters the system.** Claude Clinical operates on data you paste or dictate — it does not connect to your EHR unless you configure FHIR MCP servers.
- **This is a decision SUPPORT tool.** All clinical outputs require physician review and judgment.
- **Check your institution's AI policy** before using with any clinical data.
- **Data files (CSV, Excel) are gitignored** by default to prevent accidental PHI commits.

### Understand the Data Flow
Everything you type into Claude Code is sent to Anthropic's servers for processing.
This includes clinical scenarios, medication lists, and any text you paste from
your EHR. **Treat Claude Clinical like any cloud-based tool — do not enter
protected health information (PHI) unless you have appropriate data agreements.**

### For Real PHI / HIPAA Compliance

True HIPAA compliance requires:
- A **Business Associate Agreement (BAA)** between your institution and Anthropic
- Or a **Zero Data Retention (ZDR)** commercial agreement
- These are institutional-level agreements, not individual subscriptions
- Check with your institution's IT/compliance team about existing agreements
- Until a BAA/ZDR is in place: **de-identify all patient data before entering**

### De-identification Tip
Before pasting clinical data, strip: patient name, DOB, MRN, SSN, dates of
service (shift by random offset), provider names, institution name, and any
other HIPAA identifiers. Claude Clinical works just as well with "68F" as with
a named patient.

### What IS Sent to Anthropic
- Everything in the conversation (your prompts + Claude's responses)
- File contents when Claude reads them (CLAUDE.md, workspace files, templates)
- MCP tool calls and responses (PubMed queries, etc.)

## Extending Claude Clinical

### Add specialty-specific codes
Edit `reference/icd10_common.json` and `reference/cpt_common.json` to add codes for your specialty.

### Add note templates
Create new `.md` files in `templates/notes/` or `templates/letters/`.

### Add specialty subagents
Create new `.md` files in `.claude/agents/` with YAML frontmatter. See existing agents for the format.

### Improve PubMed search quality
Claude Clinical's evidence search and subagents work best when `WebFetch` and `WebSearch` are allowed. To enable them, create `.claude/settings.json` in the project root (this file is gitignored):
```json
{
  "permissions": {
    "allow": [
      "WebFetch",
      "WebSearch"
    ]
  }
}
```
Without these permissions, literature searches fall back to the PubMed MCP server alone. Adding `WebFetch` and `WebSearch` allows subagents (like `evidence-reviewer`) to supplement MCP results with direct web retrieval, improving recall and enabling full-text access.

### Add MCP servers
Connect additional data sources:
```bash
# Example: Add a FHIR server
claude mcp add-json fhir-server --scope user \
  '{"command":"uvx","args":["fhir-mcp-server"],"env":{"FHIR_SERVER_BASE_URL":"..."}}'
```

## Contributing

PRs welcome, especially for:
- Specialty-specific template libraries (cardiology, neurology, pediatrics, etc.)
- Expanded ICD-10/CPT reference databases
- Additional MCP server integrations
- Improved clinical reasoning prompts
- Non-English language templates

## License

MIT

## Disclaimer

Claude Clinical is a research and productivity tool. It is not FDA-cleared, CE-marked, or validated for clinical decision-making. All outputs must be reviewed by a qualified healthcare professional. Do not use for emergency clinical decisions. The developers assume no liability for clinical decisions influenced by this tool.
