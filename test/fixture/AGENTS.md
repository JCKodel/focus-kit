# greet

A shell script that greets whoever runs it. Prose in English; identifiers in English.

## Read before acting
- the product: docs/00 · the vocabulary: docs/03
- how it is built: docs/01
- style and tests: docs/04 · process: docs/05 · queue: docs/06
- running it, and the container's worktrees: docs/manuals/

## Non-negotiables
- One POSIX shell script and one shell test runner; no runtime, no
  dependency (ADR-0001).
- Every behaviour of the page is a `check` line in `test/greet_test.sh`.
- One delivery = one page in work/<slug>.md: /propose to define, /apply
  to build. Code changes only inside /apply: a change asked outside it,
  however small, becomes a `[ ]` line in docs/06, with a draft page for
  what the line cannot hold, and the answer stops there, naming /propose
  (docs/05 §2).
- No em dash in any text a user reads.
- The agent stages and suggests the commit message. It never commits or
  merges on its own; asked, it takes the step the person names.
- Stage only this delivery's changes as docs/05 §6 says; preserve unrelated
  edits and existing index entries.

## Do not rebuild
- A second script or a library: removed on purpose (ADR-0001).

## How to work
- `src/greet.sh` parses options, then one `case` over the verb (docs/01).
- Errors print the usage line to stderr and exit 2 (docs/01).
- `make verify` before declaring anything done.
- Abstraction on the second concrete occurrence, and the delivery says
  which was the first.
- Ambiguity → ask. Documents are living: a delivery that changes behaviour
  updates the document that owns it, in the same delivery.
- Asked where things stand, answer from docs/06 and work/, and from the
  delivery branches after `git fetch`: the lines in flight, their marks,
  and the next command, as this host invokes it.
  Asked what a delivery decided or why, answer from its page and the
  ADRs it names.
