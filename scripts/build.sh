#!/usr/bin/env bash
# Rebuild data/changes.json from every object in data/items/.
# Pure shell on purpose: this box has no jq, node or python.
set -euo pipefail
R="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$R/data/changes.json"
ITEMS="$R/data/items"

# newest first, by the "date" field
mapfile -t FILES < <(
  for p in "$ITEMS"/*.json; do
    d=$(grep -m1 '"date"' "$p" | sed 's/.*: *"//; s/".*//')
    echo "$d|$p"
  done | sort -r | cut -d'|' -f2-
)

n=${#FILES[@]}
[ "$n" -gt 0 ] || { echo "build: no items in data/items"; exit 1; }

{
  echo '{'
  echo '  "schema": 1,'
  echo '  "scope": "Pricing, credit, quota and removal changes in AI coding tools and the model APIs they bill through.",'
  echo "  \"updated\": \"$(date +%Y-%m-%d)\","
  echo '  "items": ['
  for i in "${!FILES[@]}"; do
    if [ "$i" -lt $((n - 1)) ]; then
      sed 's/^/    /' "${FILES[$i]}" | sed '$ s/}$/},/'
    else
      sed 's/^/    /' "${FILES[$i]}"
    fi
  done
  echo '  ]'
  echo '}'
} > "$OUT.tmp"

mv "$OUT.tmp" "$OUT"
echo "build: wrote $n items to data/changes.json"
