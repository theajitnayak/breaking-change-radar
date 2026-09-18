# Breaking Change Radar

**What the AI coding tools quietly changed about what you pay and what you are allowed to use.**

Pricing, credits, quotas and removals across Cursor, Vercel, Replit, Windsurf, GitHub Copilot and
the model APIs they bill through. Nothing else. No funding rounds, no launches, no opinion.

→ **[Live feed](https://theajitnayak.github.io/breaking-change-radar/)**

## Why this exists

Model *deprecation* trackers already exist. General AI newsletters exist at enormous scale.
Neither covers the thing that actually costs you money: a tool changing its credit allowance,
adding a margin on top of the provider rate, or altering what a task costs after you have
already committed to it.

Replit moved Agent from a flat $0.25 per checkpoint to effort-based pricing where the agent
decides the cost and you find out after the run. Cursor shipped a Pro plan limit change that
produced unexpected charges and had to refund users. Vercel cut CPU billing by up to 90% while
memory keeps billing through the whole invocation. None of those are news stories. All of them
are line items on somebody's invoice.

## How an entry is built

Every item carries the exact page it came from and that page's publish date. Nothing is asserted
from memory. Anything that could not be confirmed against a primary source is published with
`"confidence": "unverified"` and shown with an UNVERIFIED stamp rather than quietly dropped or
smoothed over — a low-confidence item you can see beats a confident one you cannot check.

A quiet day produces no entries. That is a correct result, not a gap to fill.

## Repository layout

```
data/items/<id>.json   one change per file — this is the source of truth
data/changes.json      generated feed the site reads; do not hand-edit
index.html             the site
scripts/build.sh       regenerate changes.json from data/items/
scripts/validate.sh    check required fields, enums, dates, id/filename match
scripts/publish.sh     validate + build + commit + push, no-op when unchanged
```

One file per change is deliberate: two people adding entries on the same day never touch the
same file, so corrections arrive as clean pull requests instead of merge conflicts.

## Contributing a correction

Vendors change prices quietly and sometimes retroactively. If an entry is wrong or stale:

1. Edit the relevant file in `data/items/`.
2. Run `bash scripts/validate.sh`.
3. Open a pull request. Include the primary source URL and its publish date.

Corrections that add a source are more useful than corrections that only change wording.

## Running it locally

The page fetches `data/changes.json`, so opening `index.html` straight off disk will fail —
browsers block local fetches. Serve the folder over HTTP with any static server, or just read
the live site.

## Schema

See [SCHEMA.md](SCHEMA.md).

## Licence

Code MIT. The change data is free to reuse with attribution.
