# Launch copy

Ready to post. Do not post all three on the same day — space them out so one dud does not
burn the others. Order: Reddit first (lowest stakes, real feedback), then Hacker News, then X.

The rule for all of them: lead with the concrete thing that costs money. Nobody clicks
"I built a tracker." People click "Replit changed how it charges and you find out after."

---

## 1. Reddit — r/SaaS, r/indiehackers, r/ChatGPTCoding

**Title:** I got tired of finding out about AI tool price changes from my invoice, so I started tracking them

Body:

Replit moved Agent from a flat $0.25 per checkpoint to effort-based pricing in July — the agent
decides what the task costs and you find out after it runs. Cursor shipped a Pro plan limit change
that surprised people enough that they apologised and refunded. Vercel cut CPU billing by up to 90%,
but memory keeps billing for the whole invocation, so the saving is smaller than the headline.

None of that is news. It never makes a newsletter. It just shows up on the bill.

So I started logging it: pricing, credits, quotas and removals across Cursor, Vercel, Replit,
Windsurf, Copilot and the model APIs. Every entry cites the vendor page it came from with the
publish date. If I can only find a secondary source I mark it UNVERIFIED rather than dropping
it or pretending.

It is colour coded by whether it costs you more, less, or has become unpredictable.

Link. Free, open data, corrections welcome as PRs.

**Honest question for you:** what tool has quietly changed its pricing on you, and did you notice
before or after the invoice?

---

## 2. Hacker News — Show HN

**Title:** Show HN: Breaking Change Radar – tracking AI tool pricing and quota changes

Body:

Model deprecation trackers exist. AI newsletters exist at enormous scale. Neither covers the
thing that actually hits your bill: a tool changing its credit allowance, adding margin on top
of the provider rate, or changing what a task costs after you have committed to it.

Some of what is in there now:

- Replit Agent went from flat $0.25 checkpoints to effort-based pricing. The cost is decided
  by the agent and revealed after the run. Users report being billed on runs that errored.
- Cursor Teams/Enterprise adds $0.25 per million tokens on top of the model provider's own price.
- Vercel Active CPU billing pauses on I/O, but provisioned memory does not, so an agent waiting
  40s on a model still pays memory for all 40s.
- OpenAI removes GPT-5 and o3 snapshots from the API on 11 Dec 2026. Pinned IDs do not roll forward.

Data is one JSON file per change in the repo, so corrections are pull requests rather than
emails to me. Built with no backend — it is a static page reading a generated JSON file.

I am deliberately keeping the scope to cost and permission-to-use. No funding rounds, no launches,
no benchmarks. A quiet week produces no entries.

---

## 3. X / Twitter

Thread, 4 posts.

**1/**
Replit changed how Agent charges in July.

It used to be $0.25 a checkpoint. Now the agent decides what your task costs and you find out
after it runs. People report being charged on runs that errored.

This never made a newsletter. It just showed up on invoices.

**2/**
Same month, Vercel cut CPU billing up to 90% on Fluid compute.

Real saving. But memory keeps billing the whole invocation, so an agent waiting 40 seconds on
a model still pays memory for 40 seconds.

The headline number is not the number on your bill.

**3/**
Cursor adds $0.25 per million tokens on top of the model provider's price on Teams and Enterprise.

OpenAI removes GPT-5 and o3 snapshots from the API on Dec 11. Pinned IDs do not roll forward,
the call just stops resolving.

**4/**
So I started tracking it. Pricing, credits, quotas and removals across the AI coding tools.

Every entry cites the vendor page and its date. Unconfirmed things get marked UNVERIFIED
instead of dropped.

Free, open data: [link]

---

## After posting

Reply to every comment for the first three hours. The comments are the research — whatever
people say they got burned by is the next thing to track, and the person who tells you is
your first real user.
