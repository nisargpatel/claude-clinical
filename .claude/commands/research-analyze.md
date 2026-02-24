---
description: >
  Analyze a clinical or research dataset using R or Python. Generates
  descriptive statistics, visualizations, and drafts methods sections.
  Can work with CSV, Excel, or other tabular data.
argument-hint: <describe the dataset and analysis goals, or path to data file>
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

## Research Data Analysis Workflow

### Step 1: Understand the Data
- Read the dataset file (CSV, TSV, Excel, or other format)
- Display: variable names, types, dimensions, missingness summary
- Identify the key outcome variable(s) and predictor variable(s)
- Flag any data quality issues (duplicates, implausible values, encoding problems)

### Step 2: Check Physician Preferences
Read `my-clinical-context.md` for:
- Preferred analysis tool (R/tidyverse or Python/pandas)
- Target journal (for formatting conventions)
- Active research project context

### Step 3: Plan the Analysis
Based on $ARGUMENTS and the data structure:
- Identify the appropriate study design category
- Select statistical tests based on variable types and distribution
- Plan the visualization strategy
- Document assumptions to check
- Write an analysis plan as a comment block in the script

### Step 4: Execute

**Always:**
- Set a random seed (`set.seed(42)` / `np.random.seed(42)`)
- Document every data transformation step
- Handle missing data explicitly (document the strategy)

**Produce:**
1. **Table 1**: Descriptive statistics / baseline characteristics
   - Continuous variables: mean ± SD or median [IQR] based on distribution
   - Categorical variables: n (%)
   - Include p-values for group comparisons if applicable
2. **Primary analysis**: Appropriate statistical test with full reporting
   - Effect size with 95% CI
   - P-value (but don't rely on p-value alone)
3. **Figures**: Publication-quality visualizations
   - Proper axis labels, titles, legends
   - Appropriate figure type for the data
   - High resolution (300+ DPI for journal submission)
4. **Sensitivity analyses**: If applicable

### Step 5: Document for Publication
- Draft a **Methods section** for the target journal
- Create **formatted results tables** per journal style
- Save analysis code with extensive comments
- Checkpoint after each major analysis step

### Reporting Guidelines
Follow the appropriate checklist:
- Observational studies → STROBE
- Randomized trials → CONSORT
- Systematic reviews → PRISMA
- Diagnostic studies → STARD
- Quality improvement → SQUIRE

### Output
Save all files to the workspace or to `workspaces/research_[descriptor]/`:
- `analysis_script.R` or `analysis_script.py`
- `table1.md` — formatted baseline characteristics
- `results_summary.md` — key findings
- `methods_draft.md` — methods section draft
- `figures/` — generated visualizations
