#!/usr/bin/env bash
# Validate, rebuild the feed, and push only when the item content actually moved.
# Safe to call from a scheduled task: a genuinely quiet day is a no-op.
set -euo pipefail
R="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$R"

bash scripts/validate.sh
bash scripts/build.sh

# Stage first. A brand-new item file is untracked, and git diff cannot see
# untracked files, so checking before staging silently misses new entries.
git add -A

other=$(git diff --cached --name-only | grep -v "^data/changes.json$" || true)

if [ -z "$other" ]; then
  # Only the generated feed moved. build.sh stamps the current date on every
  # run, so decide on item content and ignore the timestamp line.
  body=$(git diff --cached -U0 -- data/changes.json \
         | grep -E "^[+-]" \
         | grep -vE "^(\+\+\+|---)" \
         | grep -v "\"updated\"" || true)
  if [ -z "$body" ]; then
    git reset -q
    git checkout -- data/changes.json
    echo "publish: nothing changed"
    exit 0
  fi
fi

n=$(ls -1 data/items/*.json | wc -l | tr -d " ")
git commit -q -m "feed: rebuild ($n items, $(date +%Y-%m-%d))"
git push -q origin main
echo "publish: pushed"
