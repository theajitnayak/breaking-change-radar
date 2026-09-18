#!/usr/bin/env bash
# Validate, rebuild the feed, and push if anything changed.
# Safe to call from a scheduled task: it is a no-op on a quiet day.
set -euo pipefail
R="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$R"

bash scripts/validate.sh
bash scripts/build.sh

if git diff --quiet && git diff --cached --quiet; then
  echo "publish: nothing changed"
  exit 0
fi

n=$(ls -1 data/items/*.json | wc -l | tr -d ' ')
git add -A
git commit -q -m "feed: rebuild ($n items, $(date +%Y-%m-%d))"
git push -q origin main
echo "publish: pushed"
