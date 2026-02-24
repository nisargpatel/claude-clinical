---
description: >
  Draft a research manuscript section or full paper. Formats for the target
  journal specified in clinical context. Supports abstract, introduction,
  methods, results, discussion, and complete drafts.
argument-hint: <section name> <topic/context> OR "full draft from workspace"
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
---

## Manuscript Drafting Workflow

### Step 1: Determine Scope
Parse $ARGUMENTS to identify:
- **Section**: abstract / introduction / methods / results / discussion / full
- **Context**: research topic, data source, key findings

### Step 2: Gather Context
- Read `my-clinical-context.md` for target journal and research projects
- If a research workspace exists, read all analysis files for data context
- If evidence search results exist, incorporate literature

### Step 3: Draft

**For each section, follow academic writing conventions:**

**Abstract**: Structured (Background, Methods, Results, Conclusions) unless
the target journal uses unstructured format. Word limit per journal guidelines.

**Introduction**: Funnel structure — broad context → knowledge gap →
study purpose. 3-4 paragraphs. End with explicit aim/hypothesis.

**Methods**: Study design, setting, participants, data sources, variables,
statistical analysis. Sufficient detail for reproduction. Reference the
reporting guideline used (STROBE, CONSORT, etc.).

**Results**: Follow the Methods structure. Tables and figures first,
then narrate the key findings. Don't interpret in Results.

**Discussion**: Key findings → comparison to literature → strengths and
limitations → implications → future directions. Don't introduce new results.

### Step 4: Format
- Apply target journal citation style
- Use appropriate heading levels
- Include placeholders for [Table X] and [Figure X] references
- Note word count

### Save
To workspace `research/manuscript_[section]_[date].md`
