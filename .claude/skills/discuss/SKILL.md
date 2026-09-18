---
name: discuss
description: >-
  Turn an idea into one line in docs/06-Queue.md, by conversation. Writes
  nothing else: no delivery page, no ADR, no code.
argument-hint: <the idea>
---
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are the stakeholder's thinking partner, one step before `/propose`. The
goal is one line in `docs/06-Queue.md`, placed where the person wants it, so
that the `/propose` after it starts from something already decided.

`$ARGUMENTS` is the idea, whatever its shape: a slug, a sentence, a
complaint, something pasted in. When nothing was typed after the command,
ask what the idea is and start from the answer.

## Read first

`docs/00-Product.md`, `docs/03-Domain.md`, `docs/06-Queue.md`, and whatever
is in `work/` (the deliveries in flight). Nothing else, and no graph: this
command asks no Structure question, so it runs no graph procedure and says
nothing about the graph at all.

When `docs/06-Queue.md` is not there, the repository has no queue yet. Say
so, name `/initialize`, and write nothing.

When a queue line, or a bullet under "Later, not scheduled", already covers
the idea, say which one in its own words and write nothing. An idea already
in the queue is a `/propose`, not a second line.

## Talk until the line is decided

The conversation is exploratory and not a form. Offer the alternatives you
see, say what each one buys and what it costs, put your own recommendation
first, and ask with `AskUserQuestion` whenever more than one reading
survives the files you read. This is where the product decision is taken,
and taking it here is what keeps it out of the delivery page.

Where the idea adds a part to the process itself, ask the question
`docs/00-Product.md` asks of every such part: **which concrete error that
happened would it have caught?** The answer names an error that actually
happened, or the idea is not a line yet.

**Decided matter.** Before every batch, pass each question you drafted
through the files you have already read. A queue line that names what enters
closes the question, because the order is the decision; a document that
states the rule closes it; a file that states only today's fact leaves it
open. A question a file closes never reaches the person: it is said out
loud, with the file cited, and the line carries the answer.

Say one line before the batch, then one line per decided matter, naming the
matter and the file that decides it:

```
questions: <n> asked; <n> decided by files
  <the matter>: <the file, and what it says that settles it>
```

When every drafted question was decided, the first line reads `0 asked` and
there is no `AskUserQuestion`. When nothing was drafted, say nothing.

## Write

One line in `docs/06-Queue.md`, in the queue's own shape: the mark `[ ]`,
the slug, and the scope beside it. The slug is an identifier, so it stays in
English whatever the documentation language is: short, lowercase,
hyphenated, naming what the user gains and not the technique. The scope is
prose, in the documentation language, and no em dash. What the conversation
settled travels in the line's own words, because there is no other file to
put it in.

**Where the line goes is asked, and never assumed.** The order is the
decision, and it is the person's to take in conversation
(`docs/03-Domain.md`, Queue). Offer a placement with the reason for it, put
your recommendation first, and write where they answer.

Add a row to `docs/03-Domain.md` when the idea names a concept the table
does not have. Its Code column carries the concept's code name when the
conversation knows it, and otherwise a parenthetical saying where it will be
named, the way `(per stack)` and `(prose, in the manuals)` already read
there.

Nothing else is written: no `work/<slug>.md`, no ADR, no code, no notes
file. No existing line moves, none is edited, and no mark changes.

## Close

End by naming what you wrote and the command that builds on it:

```
Written: docs/06-Queue.md, one line <slug> under <where>; docs/03-Domain.md
row <Term> (or: no new term). Nothing staged, nothing committed.

Next: /propose <slug>
```

`/propose` may be typed in this same session: only `/apply` needs a clean
one (`docs/03-Domain.md`, Clean session).

## Never

Do not write, edit or generate code, migration, test or configuration, and
do not open a delivery page. Defining the delivery is `/propose`, and a page
opened too early is what this command exists to prevent.

Every file you write is in the project's documentation language, the one
`docs/05-Process.md` §0 declares (`CLAUDE.md` repeats it on its language
line, `docs/04-Conventions.md` §1 has the detail). English when nothing says
otherwise. Identifiers stay in English regardless. Talk to the person in the
language they write in.
