# Claude Clinical 🏥

**A clinical intelligence environment for physicians, built on Claude Code.**

Claude Clinical transforms Claude Code from a general-purpose coding assistant into an agentic clinical reasoning, documentation, and research platform. 

## What You Get

| Feature | Description |
|---------|-------------|
| 🧠 **Persistent clinical context** | Claude knows your specialty, note style, and institution every session |
| 📁 **Per-case workspaces** | Organized case files with structured reasoning that persists across sessions |
| 🤖 **5 clinical subagents** | Evidence reviewer, guideline checker, pharmacologist, coder, and note writer — working in parallel |
| 📝 **Clinical templates** | SOAP, H&P, consult, procedure, discharge notes + referral and appeal letters |
| 🔬 **Live evidence search** | PubMed integration via MCP for real-time literature retrieval |
| 🏷️ **ICD-10/CPT coding** | Documentation-to-code mapping with medical necessity verification |
| 📊 **Research analysis** | R/Python execution for data analysis and manuscript drafting |
| ⚡ **Multi-step workflows** | `/consult` runs a full case workup autonomously — DDx, evidence, note, coding |

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

| Command | What It Does |
|---------|-------------|
| `/init-profile` | Guided setup of your clinical context (run once) |
| `/new-case <desc>` | Create a patient workspace with structured templates |
| `/consult <scenario>` | **Full consultation workflow**: DDx + evidence + note + coding |
| `/differential <data>` | Generate ranked Bayesian differential diagnosis |
| `/evidence-search <question>` | PICO-structured literature search |
| `/write-note <type>` | Draft clinical note in your preferred style |
| `/drug-check <meds>` | Drug interaction and safety check |
| `/code-encounter` | ICD-10/CPT coding from documentation |
| `/appeal <denial>` | Insurance appeal letter with evidence citations |
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

### New Consultation
```
> /consult 68F referred by oncology for non-healing extraction socket #19,
  6 weeks post-extraction. History of IV zoledronic acid x 3 years for
  metastatic breast cancer. Exposed bone visible in socket. No purulence.
  Pain 4/10. Panorex shows sequestrum formation.
```
Claude Clinical creates a workspace, generates a staged MRONJ differential, searches current AAOMS guidelines, drafts a consult note, and codes the encounter.

### Quick Differential
```
> /differential 55M presenting with acute onset right facial swelling,
  trismus, fever 101.2F, elevated WBC 18k. Recent dental work 2 weeks ago
  on tooth #30. CT shows rim-enhancing fluid collection in right masticator space.
```

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
