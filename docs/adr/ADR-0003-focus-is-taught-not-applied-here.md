# ADR-0003: FOCUS is what the kit teaches, not how the kit is built

**Status:** accepted
**Date:** 2026-09-16

---

## Context

focus-kit ships a reference for the FOCUS architecture and installs a
process whose house rules include "rules live in pure use cases, the
orchestrator converts one event into one state, the repository is the only
place an exception becomes a Result".

Its own code is `bin/focus-kit`: 230 lines of bash that copy trees, merge
two JSON files and print what happened. There is no business rule, no state
to publish and no data to persist.

The question came up while writing `docs/01-Architecture.md`, whose §3 is a
table of where each of the four FOCUS pieces lives in the codebase. Leaving
it blank looks like an oversight. Filling it in requires inventing four
layers, and the next session would then be free to "restore consistency" in
either direction. The decision is written down so neither happens by
accident.

## Decision

The four pieces do not exist in `bin/focus-kit`, and they will not be
introduced to make the kit resemble what it documents.

`docs/01-Architecture.md` §3 states this in the table itself, with the
manual's own criterion as the reason: **every layer pays its own way**
(`docs/manuals/focus.md` §What FOCUS is). A layer earns its place only if
it can point
at a verifiable gain that would vanish without it. Splitting `install_repo`
into a view, an orchestrator, a use case and a repository makes nothing
testable that was not, makes nothing swappable that needed swapping, and
adds files. That is Card 4 of the kit's own anti-pattern table, layer by
ceremony.

What `docs/01-Architecture.md` §3 describes instead is what is actually
there: two verbs, `install_repo` and `doctor`, and four helpers, `copy_tree`,
`merge_json`, `python_bin` and the message functions.

The decision has a trigger written into it. If the kit grows something that
**decides** rather than copies, that rule becomes a named function with no
IO in it, tested by calling it with literals, and §3's table is filled in
for real rather than argued with again.

## Consequences

Easier: the architecture document describes the code, so a reader can trust
it. The kit demonstrates the rule it cares about most, which is that a
structure has to justify itself rather than be adopted for consistency.

Harder: it looks like a contradiction from the outside, and it will keep
looking like one. Anyone reading `manuals/focus.md` and then `bin/focus-kit`
in the same sitting will notice. That cost is paid once per reader, in §3,
which is why §3 explains rather than just states.

Forbidden: a refactor of `bin/focus-kit` whose justification is consistency
with FOCUS. The justification has to be a verifiable gain, named.

Revisit when: the kit acquires a rule. The likeliest candidate is a check
inside the verify command that compares something and returns a verdict.

## Alternatives considered

* **Map the pieces anyway** (`main` as View, `install_repo` as orchestrator,
  `merge_json` as use case, the filesystem as repository). Lost: it is
  didactic for about one minute and wrong afterwards, and it teaches the
  reader to apply the pattern where it does not pay.
* **Leave §3 empty.** Lost: an empty section reads as unfinished, and the
  next session fills it in.
* **Rewrite the kit in a language where the four pieces are natural.** Lost:
  it would be a rewrite in service of a diagram, and the language decision
  has its own reasons (`ADR-0001`).
