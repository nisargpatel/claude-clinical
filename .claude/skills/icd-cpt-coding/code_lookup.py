#!/usr/bin/env python3
"""
ICD-10-CM / CPT / CDT code lookup utility for Claude Clinical.
Searches local reference files for medical codes by description or code number.
"""

import json
import sys
import argparse
from pathlib import Path


def find_reference_dir():
    """Find the reference directory relative to this script or CWD."""
    # Try relative to script location
    script_dir = Path(__file__).parent
    candidates = [
        script_dir / ".." / ".." / ".." / "reference",  # from .claude/skills/icd-cpt-coding/
        Path.cwd() / "reference",                         # from project root
    ]
    for candidate in candidates:
        resolved = candidate.resolve()
        if resolved.exists():
            return resolved
    return Path.cwd() / "reference"


def load_codes(system: str, reference_dir: Path) -> list:
    """Load codes from reference JSON file."""
    filename = f"{system}_common.json"
    filepath = reference_dir / filename
    
    if not filepath.exists():
        print(f"Reference file not found: {filepath}", file=sys.stderr)
        print(f"Available files: {list(reference_dir.glob('*.json'))}", file=sys.stderr)
        return []
    
    with open(filepath) as f:
        return json.load(f)


def search_codes(codes: list, query: str, specialty: str = None) -> list:
    """Search codes by description text."""
    query_lower = query.lower()
    results = []
    
    for entry in codes:
        code = entry.get("code", "")
        desc = entry.get("description", "")
        category = entry.get("category", "")
        specialties = entry.get("specialty", [])
        
        # Check if query matches description, code, or category
        match = (
            query_lower in desc.lower() or
            query_lower in code.lower() or
            query_lower in category.lower()
        )
        
        # Filter by specialty if specified
        if specialty and specialties:
            if specialty.lower() not in [s.lower() for s in specialties]:
                continue
        
        if match:
            results.append(entry)
    
    return results[:25]


def lookup_code(codes: list, code: str) -> dict:
    """Look up a specific code by number."""
    code_clean = code.upper().strip().replace(".", "")
    
    for entry in codes:
        entry_code = entry.get("code", "").upper().replace(".", "")
        if entry_code == code_clean or entry.get("code", "").upper() == code.upper():
            return entry
    
    return None


def format_results(results: list, system: str) -> str:
    """Format results as a readable table."""
    if not results:
        return "No matching codes found."
    
    lines = [f"Found {len(results)} matching {system.upper()} code(s):\n"]
    lines.append(f"{'Code':<12} {'Description':<60} {'Category'}")
    lines.append("-" * 90)
    
    for entry in results:
        code = entry.get("code", "")
        desc = entry.get("description", "")[:58]
        category = entry.get("category", "")
        lines.append(f"{code:<12} {desc:<60} {category}")
    
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(
        description="Medical code lookup for Claude Clinical",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s --system icd10 --query "osteonecrosis jaw"
  %(prog)s --system cpt --query "extraction"
  %(prog)s --system icd10 --code M87.180
  %(prog)s --system icd10 --query "fracture" --specialty oral-surgery
        """
    )
    parser.add_argument("--system", choices=["icd10", "cpt"],
                        required=True, help="Code system to search")
    parser.add_argument("--query", type=str, help="Search by description keyword")
    parser.add_argument("--code", type=str, help="Look up a specific code number")
    parser.add_argument("--specialty", type=str, help="Filter by specialty")
    parser.add_argument("--json", action="store_true", help="Output as JSON")
    
    args = parser.parse_args()
    
    if not args.query and not args.code:
        parser.error("Provide either --query or --code")
    
    reference_dir = find_reference_dir()
    codes = load_codes(args.system, reference_dir)
    
    if not codes:
        sys.exit(1)
    
    if args.code:
        result = lookup_code(codes, args.code)
        if result:
            if args.json:
                print(json.dumps(result, indent=2))
            else:
                print(f"Code:        {result['code']}")
                print(f"Description: {result['description']}")
                if 'category' in result:
                    print(f"Category:    {result['category']}")
                if 'specialty' in result:
                    print(f"Specialty:   {', '.join(result['specialty'])}")
        else:
            print(f"Code '{args.code}' not found in local {args.system.upper()} reference.")
            print("Note: This searches a curated subset. For comprehensive lookup,")
            print("consult CMS.gov (ICD-10) or the AMA CPT codebook.")
    
    elif args.query:
        results = search_codes(codes, args.query, args.specialty)
        if args.json:
            print(json.dumps(results, indent=2))
        else:
            print(format_results(results, args.system))
            if len(results) == 25:
                print("\n(Results limited to 25. Try a more specific query.)")


if __name__ == "__main__":
    main()
