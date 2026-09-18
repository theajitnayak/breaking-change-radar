#!/usr/bin/env bash
# Check every item carries the fields the feed depends on, and at least one source.
set -uo pipefail
R="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ITEMS="$R/data/items"
fail=0

REQUIRED='id vendor kind direction date title detail impact confidence'

for f in "$ITEMS"/*.json; do
  base=$(basename "$f")
  for key in $REQUIRED; do
    grep -q "\"$key\"" "$f" || { echo "MISSING $key -> $base"; fail=1; }
  done

  grep -q '"url"' "$f" || { echo "NO SOURCE URL -> $base"; fail=1; }

  kind=$(grep -m1 '"kind"' "$f" | sed 's/.*: *"//; s/".*//')
  case "$kind" in
    pricing|limit|removal|policy) ;;
    *) echo "BAD kind '$kind' -> $base"; fail=1 ;;
  esac

  dir=$(grep -m1 '"direction"' "$f" | sed 's/.*: *"//; s/".*//')
  case "$dir" in
    up|down|variable|neutral) ;;
    *) echo "BAD direction '$dir' -> $base"; fail=1 ;;
  esac

  conf=$(grep -m1 '"confidence"' "$f" | sed 's/.*: *"//; s/".*//')
  case "$conf" in
    verified|unverified) ;;
    *) echo "BAD confidence '$conf' -> $base"; fail=1 ;;
  esac

  date=$(grep -m1 '"date"' "$f" | sed 's/.*: *"//; s/".*//')
  echo "$date" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' \
    || { echo "BAD date '$date' -> $base"; fail=1; }

  id=$(grep -m1 '"id"' "$f" | sed 's/.*: *"//; s/".*//')
  [ "$id.json" = "$base" ] || { echo "ID/filename mismatch: '$id' vs $base"; fail=1; }
done

n=$(ls -1 "$ITEMS"/*.json 2>/dev/null | wc -l | tr -d ' ')
if [ $fail -eq 0 ]; then echo "validate: $n items OK"; else echo "validate: FAILED"; fi
exit $fail
