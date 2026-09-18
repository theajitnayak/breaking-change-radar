# Item schema

One JSON object per file in `data/items/`. The filename must be `<id>.json`.

```json
{
  "id": "replit-effort-based-pricing",
  "vendor": "Replit",
  "kind": "pricing",
  "direction": "variable",
  "date": "2026-07-01",
  "effective": "2026-07-01",
  "title": "One line, plain English, no adjectives",
  "detail": "What actually changed, with the real numbers from the source page.",
  "impact": "What it means for someone already paying for this tool.",
  "confidence": "verified",
  "sources": [
    { "url": "https://blog.replit.com/effort-based-pricing", "published": "2026" }
  ]
}
```

## Fields

| Field | Required | Notes |
|---|---|---|
| `id` | yes | kebab-case, stable, matches the filename |
| `vendor` | yes | the company doing the billing |
| `kind` | yes | `pricing` · `limit` · `removal` · `policy` |
| `direction` | yes | `up` · `down` · `variable` · `neutral` |
| `date` | yes | `YYYY-MM-DD`, when the change was announced or took effect |
| `effective` | no | `YYYY-MM-DD` hard date the site counts down to, or `null` |
| `title` | yes | one line |
| `detail` | yes | the mechanics, with the numbers actually printed on the source page |
| `impact` | yes | the consequence for a paying user. May contain `<b>` for emphasis |
| `confidence` | yes | `verified` (primary source) · `unverified` (secondary only) |
| `sources` | yes | at least one `{ url, published }` |

## The two fields that carry the product

**`direction`** is what no other tracker shows. `up` means this costs you more, `down` means less,
`variable` means the price is no longer predictable before you commit to the work. The site colours
the whole entry from this, so the feed is scannable without reading a word.

**`confidence`** is the credibility mechanism. `verified` means someone opened the vendor's own page
and read the number there. `unverified` means the claim rests on a secondary source. Never promote an
item to `verified` because it sounds right — promote it when a primary source is added to `sources`.

## Rules

- Never state a number, price or version that is not printed on a page in `sources`.
- Never construct a source URL from a pattern. Open it or do not cite it.
- If a source page carries no publish date, set `"published": "undated"`.
- Lead with what was taken away. Removals and price rises outrank everything else.
