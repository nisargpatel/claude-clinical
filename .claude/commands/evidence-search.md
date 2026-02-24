---
description: >
  Structured literature search using PICO framework. Searches PubMed via
  MCP or web, retrieves and appraises evidence, and synthesizes findings.
argument-hint: <clinical question in natural language>
---

## Structured Evidence Search

Delegate this task to the **evidence-reviewer** subagent with the following instructions:

"Conduct a structured evidence search for the following clinical question:

$ARGUMENTS

Follow your full workflow:
1. Parse into PICO components
2. Build a MeSH + free-text search strategy
3. Execute the search (PubMed MCP if available, web search if not)
4. Retrieve and critically appraise the top results
5. Synthesize into a bottom-line answer with evidence quality rating

If there is an active workspace, save results to the evidence/ directory.
Otherwise, report findings in conversation."
