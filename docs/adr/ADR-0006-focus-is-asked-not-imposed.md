# ADR-0006: FOCUS is asked, one question per practice, never imposed

**Status:** accepted
**Date:** 2026-09-17

---

## Context

Until this decision, FOCUS was a house rule. `manuals/process.md` §6 listed
it beside "one delivery is one page" and "the agent never commits", the
`CLAUDE.md` template shipped it as a non-negotiable line, and `/apply` opened
its Build section with "rules go in the use case". `/initialize` never asked
about it, because §6 said it was not up for a per-project vote.

Two runs showed what that costs. The first target's `docs/01-Architecture.md`
came out with a `features/` target layout and a migration delivery per slice
in the queue, written into a repository whose owner was never asked and had
chosen neither. And the project the kit came from removed the four pieces on
purpose, with its own reasons recorded: a kit installed there would have
declared a rule that project had already decided against.

There is a third case closer to home. This repository's own §3 says the four
pieces do not exist and ADR-0003 says they never will. The kit was therefore
shipping as a non-negotiable rule something its own codebase does not follow.

The failure is not that FOCUS is wrong. It is that a house rule and an
architecture are different kinds of thing. "One delivery is one page" is a
rule about how the process works and it holds in any codebase. "Rules live in
pure use cases" is a claim about the code, and the code belongs to whoever
commits it. The person running `/initialize` may never have heard of FOCUS.

## Decision

FOCUS stops being a house rule and becomes **four Practices, each one a
question `/initialize` asks**: structure, vertical slices or layers; rules,
pure use cases behind an orchestrator or where they sit today; errors, values
or exceptions as flow; tests, a test per piece or the project's own policy.

FOCUS's answer is the first option of every question and is never assumed.
The four questions are written once, in `skills/initialize/SKILL.md`, and
asked as written, on a greenfield repository as a round of its own, on a
brownfield one in the paragraph of what the readings do not answer, and on a
review run whose `docs/01-Architecture.md` §3 has no Practice table.

On a brownfield repository **the question itself states what the code does
today**, with the file cited, and the second option is keeping that, in the
reading's own words, while the first names how FOCUS's answer would differ
from it. The question is asked even when today's state already is FOCUS's
answer: the code states a fact and a fact does not decide anything. A project
may be organized by layer and want slices, or hold all four pieces and have
removed them on purpose.

Two things travel with every question, and neither is decoration. Each of the
two options says **what it buys**, in one line, because the person answering
may be a developer who joined last week and has never read the book, and
because the choice is between two purchases rather than between one purchase
and one habit. And on a
brownfield repository, choosing FOCUS where the code does otherwise carries a
spoken disclaimer: two patterns then live in the tree until the migration
lands, which is a normal state for a project that is migrating and a bad one
for a project that is not. The choice therefore comes with migration
deliveries in `docs/06-Queue.md` or it does not come.

Where a queue already exists, which is every review run, **each option names
what choosing it does to that queue**, by slug: what it keeps, what it
cancels, what it adds. Choosing between two architectures is choosing between
two queues, and the queue is the half of the consequence the person can
already read.

The answers are the Practice table of that project's
`docs/01-Architecture.md` §3. `/propose` reads it for the pieces a delivery
may name; `/apply` reads it for where each piece goes, for how a failure
travels, for which tests to write, and for which sections of
`docs/manuals/focus.md` to read at all. A project that answered no to all
four reads none of that manual.

**FOCUS is the name for saying yes to all four.** The `CLAUDE.md` template
keeps the FOCUS line as written today for exactly that case, and otherwise
carries one line per practice chosen.

`manuals/focus.md` does not change. It is the reference behind the answer
each question offers first, and it is the one file in the kit that is allowed
to argue for FOCUS without asking.

## Consequences

Easier: a repository receives the architecture its owner chose, and nothing
else. The migration line per slice appears only when someone asked for
slices. A project that throws exceptions gets documents that say how its
exceptions travel instead of a section telling it it is wrong. And `/apply`
reads less of `focus.md`, down to nothing, when the practices do not call
for it.

Harder: the kit now has four more questions to get right, and four answers
to keep consistent across six documents. A `docs/01-Architecture.md` §3 whose
Practice table is missing or half filled leaves `/propose` and `/apply`
without their source, which is why a review run treats a §3 with no table
exactly as it treats a §6 with no Proof tool.

Also harder: the kit no longer tells a new user what to do about
architecture in one line. It asks them four questions instead, and the first
option of each is the recommendation.

Forbidden: deriving an answer from the code instead of asking, and writing a
piece, a section or a queue line that assumes an answer nobody gave. Those
are the two failures this decision exists to stop.

Revisit when: a fifth practice earns a row. Composition root and CQS are the
candidates named so far, and neither has been asked for by a real run. The
second concrete occurrence adds the row (`docs/06-Queue.md`).

## Alternatives considered

* **Keep FOCUS a house rule and document the exceptions.** Lost: the
  exception list is where the rule goes to die, and this repository would
  have been the first entry on it.
* **Derive the practices from the code and confirm them.** Lost: it reads
  the fact and calls it the decision, which is the exact shape of the first
  target's `features/` layout. A confirmation of something already written
  is not a choice, and on a greenfield repository there is nothing to read.
  What survives of the idea is that the question **states** the fact and
  then asks, which is a different thing: the reading informs the person, it
  does not answer for them.
* **Three options on a brownfield repository**, FOCUS, the named
  alternative, and what the code does today. Lost during the run that
  applied this decision: on a brownfield repository the last two are the
  same option most of the time, and a menu that offers the same answer
  twice teaches the person that the question is a formality.
* **One question, FOCUS or not.** Lost: the four practices are genuinely
  separable. A project that wants errors as values and keeps its layers is
  a normal project, and one question forces it to answer for all four.
* **Four `AskUserQuestion` calls, one per practice.** Lost: one call carries
  four questions, which is the round's ceiling, and the four belong together
  because the later answers are read against the earlier ones.
