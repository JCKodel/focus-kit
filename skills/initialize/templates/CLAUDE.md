# <Project name>

<!-- init: one sentence: what the product is and for whom. -->

<!-- init: the documentation language settled in Step 0, in the form
     "Prose in <language>; identifiers in English." Every session reads this
     line, and /propose and /apply obey it. Detail in docs/04-Conventions.md §1. -->
Prose in English; identifiers in English.

## Read before acting
- the product: docs/00-Product.md · the vocabulary: docs/03-Domain.md
- how it is built: docs/01-Architecture.md · the server: docs/02-Backend.md
- style and tests: docs/04-Conventions.md · process: docs/05-Process.md
- queue: docs/06-Queue.md · decisions: docs/adr/ · manuals: docs/manuals/
- the codebase graph: graphify-out/ (ask it before grepping; docs/manuals/graphify.md)

## Non-negotiables
- One delivery = one page in work/<slug>.md. /propose to define, /apply to build.
- FOCUS (docs/manuals/focus.md): rules live in pure use cases; the
  orchestrator converts one event into one state; the repository is the
  only place an exception becomes a Result; features are vertical slices.
- Errors are values. `throw` is not flow.
- No em dash in any text a user reads.
- The agent stages (`git add`) and suggests the commit message. It never commits.
<!-- init: add the two or three rules this product cannot exist without
     (a privacy boundary, a regulatory constraint, a client rule). Each one
     a line. If there are none yet, leave only the five above. -->

## How to work
- Verify: `<verify command>` before declaring anything done.
<!-- init: the environments and what a delivery must leave up to date in
     each, in one or two lines, pointing at docs/05-Process.md §Environments. -->
- Ambiguity → AskUserQuestion. Abstraction on the second concrete
  occurrence, and the delivery says which was the first.
- Docs are living: a delivery that changes behaviour updates the doc that
  owns it, in the same delivery.
