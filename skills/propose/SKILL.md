---
name: propose
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>
---
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are the stakeholder's thinking partner. The goal is a one-page file,
`work/$ARGUMENTS.md`, in the format `docs/05-Process.md` §3 defines, that
`/apply` can implement in one clean session without asking anything.

## Read first

`docs/00-Product.md`, `docs/03-Domain.md`, `docs/06-Queue.md`, and whatever
is in `work/` (the deliveries in flight). Read `docs/01-Architecture.md`
for where the slice would live. Ensure the graph first, per
`docs/manuals/graphify.md` §Ensuring the graph, then ask it before
grepping: `graphify query "<what this delivery touches>"` tells you which
slices, entities and rules are involved.

## Talk until it fits

Ask with `AskUserQuestion` whenever there is more than one reading. Give
your assessment in prose before a batch of questions, and put your own
recommendation first. If the scope does not fit on one page, it is two
deliveries: say so, propose the split, and write only the first.

Things that usually need a question:

* which side or user the delivery serves, when the product has more than
  one;
* what is out of scope, and why (half a line each);
* what "done" means in each environment named in `docs/05-Process.md`;
* whether a decision the delivery implies deserves an ADR;
* the visual reference, if there is a screen.

## Write

`work/$ARGUMENTS.md`, one page. The **Contract** section (data, API,
migrations, message shapes) is the only one that must be exact: a wrong
screen is fixed in a session, a wrong column is a migration. Name the
slice the delivery lives in and the four pieces it touches (view,
orchestrator, use case, repository) using the vocabulary of
`docs/manuals/focus.md`.

Use only terms from `docs/03-Domain.md`. A new concept goes into
`docs/03-Domain.md` first, with its code identifier, then into the
delivery.

Then mark the line in `docs/06-Queue.md`: `[ ]` becomes `[>]`. If the
delivery is not in the queue, add it where it belongs and say why.

## Never

Do not write, edit or generate code, migration, test or configuration.
Separating deciding from doing is what keeps scope from growing during
implementation.

Every file you write is in the project's documentation language, the one
`docs/05-Process.md` §0 declares (`CLAUDE.md` repeats it on its language
line, `docs/04-Conventions.md` §1 has the detail). English when nothing
says otherwise. Identifiers stay in
English regardless. Talk to the person in the language they write in. No em
dash anywhere in the delivery file.
