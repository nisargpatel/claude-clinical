#!/bin/bash
# ╔══════════════════════════════════════════════════════╗
# ║        Claude Clinical — First-Time Setup            ║
# ║  Clinical Intelligence Environment for Physicians    ║
# ╚══════════════════════════════════════════════════════╝

set -e

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║        Claude Clinical — First-Time Setup            ║"
echo "║  Clinical Intelligence Environment for Physicians    ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# ── Check prerequisites ───────────────────────────────────
echo "Checking prerequisites..."

if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code not found."
    echo ""
    echo "   Install Claude Code first:"
    echo "   npm install -g @anthropic-ai/claude-code"
    echo "   OR: brew install claude-code"
    echo ""
    echo "   You'll need a Claude Pro, Max, or Teams subscription,"
    echo "   or an Anthropic API key."
    echo ""
    exit 1
fi
echo "✅ Claude Code found"

if command -v python3 &> /dev/null; then
    echo "✅ Python 3 found ($(python3 --version 2>&1))"
elif command -v python &> /dev/null; then
    echo "✅ Python found ($(python --version 2>&1))"
else
    echo "⚠️  Python not found — coding skill scripts won't work."
    echo "   Install Python 3.10+ for full functionality."
fi

echo ""

# ── Configure MCP Servers ─────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  MCP Server Configuration (all optional)"
echo "  These connect Claude to medical knowledge databases."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# --- PubMed ---
echo "📚 PubMed / NCBI E-utilities"
echo "   Enables real-time literature search from within Claude."
echo "   Free API key: https://www.ncbi.nlm.nih.gov/account/"
echo ""
read -p "   Your email (required by NCBI policy, or press Enter to skip): " NCBI_EMAIL

if [ -n "$NCBI_EMAIL" ]; then
    read -p "   NCBI API Key (optional, higher rate limits): " NCBI_API_KEY
    
    if [ -n "$NCBI_API_KEY" ]; then
        claude mcp add-json pubmed --scope user \
            "{\"command\":\"uvx\",\"args\":[\"pubmed-search-mcp\"],\"env\":{\"NCBI_EMAIL\":\"$NCBI_EMAIL\",\"NCBI_API_KEY\":\"$NCBI_API_KEY\"}}" 2>/dev/null && \
        echo "   ✅ PubMed MCP configured (with API key)" || \
        echo "   ⚠️  PubMed MCP configuration failed — you can add it manually later"
    else
        claude mcp add-json pubmed --scope user \
            "{\"command\":\"uvx\",\"args\":[\"pubmed-search-mcp\"],\"env\":{\"NCBI_EMAIL\":\"$NCBI_EMAIL\"}}" 2>/dev/null && \
        echo "   ✅ PubMed MCP configured" || \
        echo "   ⚠️  PubMed MCP configuration failed — you can add it manually later"
    fi
else
    echo "   ⏭️  Skipped (you can add it later with: claude mcp add pubmed)"
fi
echo ""

# --- FDA ---
echo "💊 FDA / OpenFDA"
echo "   Enables drug label lookups, safety alerts, and interaction data."
echo "   Free API key: https://open.fda.gov/apis/authentication/"
echo ""
read -p "   OpenFDA API Key (or press Enter to skip): " FDA_API_KEY

if [ -n "$FDA_API_KEY" ]; then
    echo "   ✅ FDA API key noted"
    echo "   (OpenFDA MCP server will be configured when a stable package is available."
    echo "    For now, Claude will use web search for FDA data.)"
else
    echo "   ⏭️  Skipped (Claude will use web search for drug information)"
fi
echo ""

# ── Verify setup ──────────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Verifying project structure..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_file() {
    if [ -f "$1" ]; then
        echo "  ✅ $1"
    else
        echo "  ❌ $1 (missing)"
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "  ✅ $1/"
    else
        echo "  ❌ $1/ (missing)"
    fi
}

check_file "CLAUDE.md"
check_file "my-clinical-context.md"
check_dir ".claude/agents"
check_dir ".claude/commands"
check_dir ".claude/skills"
check_dir "templates/notes"
check_dir "templates/letters"
check_dir "reference"
check_dir "workspaces"
echo ""

# ── Final instructions ────────────────────────────────────
echo "╔══════════════════════════════════════════════════════╗"
echo "║              Setup Complete! 🏥                      ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║                                                      ║"
echo "║  Next steps:                                         ║"
echo "║                                                      ║"
echo "║  1. Edit my-clinical-context.md with your info       ║"
echo "║     (or run /init-profile inside Claude Code)        ║"
echo "║                                                      ║"
echo "║  2. Start Claude Code:                               ║"
echo "║     cd $(pwd)                                        ║"
echo "║     claude                                           ║"
echo "║                                                      ║"
echo "║  3. Try these commands:                              ║"
echo "║     /init-profile    — guided profile setup          ║"
echo "║     /new-case        — create a case workspace       ║"
echo "║     /differential    — generate a DDx                ║"
echo "║     /consult         — full consultation workflow     ║"
echo "║     /evidence-search — PICO literature search        ║"
echo "║     /write-note      — draft a clinical note         ║"
echo "║     /drug-check      — medication safety check       ║"
echo "║     /code-encounter  — ICD/CPT coding                ║"
echo "║     /appeal          — insurance appeal letter       ║"
echo "║                                                      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
