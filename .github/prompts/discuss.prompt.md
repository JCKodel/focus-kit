---
agent: 'agent'
name: discuss
description: >-
  Turn an idea into one line in docs/06-Queue.md, by conversation. Writes
  nothing else: no delivery page, no ADR, no code.
argument-hint: <the idea>
---

**Read this before the rest of the file.** This command is a
conversation and not a script, and every question in it is a stop.
Where the file says to ask, you ask and then wait: you create no
file, change no file and run no command that writes, until the
person has answered. Ask as a multiple choice question, carrying
the options as they are written. Where
GitHub Copilot gives you no way to show options, the
question still has to be answerable: write it as text, list its
options numbered from 1 in the order the file gives them, and say
in one line that the person replies with the number, one number
per question, or types the answer where the file offers that. An
option nobody can point at is not an option. Then stop there. Never
answer for the person, never take an option because it is the
recommended one, and never decide a question yourself because the
repository seems to answer it. A run that wrote a document nobody
was asked about has failed, and so has a run that reported at the
end what it decided alone.

**And the stop ends when the answer arrives.** You then go on at
once, in the same reply, from the step that asked, and you carry
out every step after it. Saying the answers back, saying that you
will continue, or saying what you are about to do is not a step and
finishes nothing. Your turn ends where the command ends, at its
closing report, and nowhere else: not at a question, not at an
answer, not between two steps. Ask each question where the file
asks it, and do not gather the questions of later steps into an
earlier one.

<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are the stakeholder's thinking partner, one step before `/propose`. The
goal is one line in `docs/06-Queue.md`, placed where the person wants it, so
that the `/propose` after it starts from something already decided.

`${input:arguments}` is the idea, whatever its shape: a slug, a sentence, a
complaint, something pasted in. When nothing was typed after the command,
ask what the idea is and start from the answer.

## Read first

`docs/00-Product.md`, `docs/03-Domain.md`, `docs/06-Queue.md`, and whatever
is in `work/` (the deliveries in flight). No graph: this command asks no
Structure question, so it runs no graph procedure and says nothing about the
graph at all. The one other thing it reads is `docs/05-Process.md` §7, at
Write and not here, because that is where it decides whether a new line
needs a branch or a worktree of its own.

When `docs/06-Queue.md` is not there, the repository has no queue yet. Say
so, name `/initialize`, and write nothing.

When a queue line already covers the idea, say which one in its own words
and write nothing. An idea already in the queue is a `/propose`, not a
second line.

When a line under `## Later, not scheduled` covers it, say which one, then
read the milestone paragraphs again. When one of them admits the idea now,
offer the move of that single line into that milestone, with the reason,
and write it where the person answers. That promotion is the only way a
Later line leaves Later, and the conversation is what decides it, as with
the proposed milestone below. When no paragraph admits it, the line stays
where it is and nothing is written.

## Talk until the line is decided

The conversation is exploratory and not a form. Offer the alternatives you
see, say what each one buys and what it costs, put your own recommendation
first, and ask with `multiple choice question` whenever more than one reading
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
there is no `multiple choice question`. When nothing was drafted, say nothing.

## Place the line

The last thing decided before anything is written, and it is not decided by
taste. Every milestone of `docs/06-Queue.md` carries a name and a paragraph
saying what closes it, and that paragraph is what a line is placed against
(`docs/03-Domain.md`, Milestone paragraph). Read the paragraphs, not the
lines under them.

In this order:

1. **A paragraph already admits the line.** It goes into that milestone,
   and the placement is not a question: the paragraph decided it. Say which
   milestone and the words of its paragraph that admit the line.
2. **The line serves a milestone and its paragraph does not say so.** Ask,
   with `multiple choice question`: the amendment and the placement together, in one
   option, against leaving the line under Later. Say what the amended
   paragraph would read. Write the answer, the paragraph included when the
   answer is the amendment.
3. **No paragraph admits the line.** It goes under `## Later, not
   scheduled`, and nothing is asked. Later is where a delivery that is
   wanted and not ordered waits; the order starts at the first milestone.

Then one look at Later, whatever the step above did with the line. **When
three lines there share a purpose**, say which three and propose a
milestone: a name, and a paragraph saying what closes it. On yes, write the
heading and the paragraph where the person says it belongs, and move those
three lines into it. Fewer than three is not a proposal and is not
mentioned.

That move and the promotion in Read first are the only two this command
makes, and each one is a move the conversation decided.

## Write

**Where the line is written.** Read `docs/05-Process.md` §7 first. Its first
line names the git strategy, and when it names a worktree per delivery or a
branch per slug, and the line you are about to write is new, this command is
the first to write under that slug: it makes the worktree or the branch, and
writes there everything this run writes. How that is done is
`docs/manuals/process.md` §The git strategy, and this file repeats none of
it. Read the named section alone: one `grep -n '^#'` over the manual gives
its heading's line and the next heading of the same level, and you read that
range and nothing else of the manual. When §7 names none, nothing is made
and the manual is not read.

One line in `docs/06-Queue.md`, in the queue's own shape: the mark `[ ]`,
the slug, and the scope beside it. The slug is an identifier, so it stays in
English whatever the documentation language is: short, lowercase,
hyphenated, naming what the user gains and not the technique. The scope is
prose, in the documentation language, and no em dash. What the conversation
settled travels in the line's own words, because there is no other file to
put it in.

A line under `## Later, not scheduled` has that same shape and no prose
bullet: the mark `[ ]`, the slug, the scope. A Later line another delivery
already did is struck through with the reason naming that slug, never
deleted, the way a cancelled line is (`docs/03-Domain.md`, Queue).

Add a row to `docs/03-Domain.md` when the idea names a concept the table
does not have. Its Code column carries the concept's code name when the
conversation knows it, and otherwise a parenthetical saying where it will be
named, the way `(per stack)` and `(prose, in the manuals)` already read
there.

Nothing else is written: no `work/<slug>.md`, no ADR, no code, no notes
file. No existing line is edited and no mark changes. No existing line
moves either, with two exceptions, and each one is a move the person
accepted: a Later line promoted into a milestone whose paragraph admits it,
and the three lines carried into a milestone the person said yes to.

## Close

End by naming the placement you took, what you wrote and the command that
builds on it:

```
Placed: <the milestone whose paragraph admits it | the milestone whose
paragraph you amended | Later, no paragraph admits it>.
Made: <the branch <slug> | the worktree <directory>, on branch <slug> | nothing;
docs/05 §7 names none>.
Written: docs/06-Queue.md, one line <slug> under <where>; docs/03-Domain.md
row <Term> (or: no new term); <the amended paragraph, the milestone
proposed and its three lines, or the promoted line, when there was one>.
Nothing staged, nothing committed.

Next: /propose <slug>
```

A line that went under Later has no `/propose` yet: it is not ordered, and
`/propose` stops on it. The last line then reads `Next: nothing; the line
is not ordered. /discuss again when a milestone paragraph admits it`.

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
