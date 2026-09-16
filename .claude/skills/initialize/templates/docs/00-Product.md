# Product

**Project:** <name>
**Status:** <draft | active>
**Last updated:** <YYYY-MM-DD>

---

## Purpose

<!-- init: what this document is: the distilled statement of what the
     product is, its purpose, audience, mechanics, principles and non-goals.
     It is the reference every delivery in work/ is checked against. Nothing
     may contradict it without changing it in the same delivery. Then: the
     purpose itself. Why does the product exist, in two or three paragraphs?
     What does it replace or improve? What is the one principle that decides
     ties? -->

## Positioning

<!-- init: how the product is described to the outside, in one or two
     lines. What it is explicitly not sold as. Name, domain, brand status. -->

## Audience

<!-- init: who uses it. If there is more than one side (buyer and seller,
     candidate and company, admin and end user), name each side, and state
     that every requirement declares which side it serves. Markets, languages,
     regulatory context. -->

## Mechanics

<!-- init: how the product works, as a sequence of what a person does and
     what happens. One subsection per capability. Write rules of product
     here, not rules of implementation: "a draft can be deleted, a published
     item can only be closed" belongs here; which table stores it does not.
     Brownfield: derive from the code and the graph, cite files, and mark
     what the code does that nobody intended. -->

## Non-goals

<!-- init: what the product deliberately is not, one line each, so that
     nobody builds it by accident. -->

## Values

<!-- init: three to six words with one sentence each: the criteria a
     decision is judged by when the docs are silent. -->

## Product questions

Every decision taken during development must answer yes to:

<!-- init: five to nine questions derived from the values above. A "no" to
     any of them means the decision is re-evaluated. -->

## Open decisions

Recorded here so that no agent closes them alone:

<!-- init: numbered list. Closing one is the stakeholder's call, made in
     conversation, never by an agent's assumption. -->

---

## Related documents

* `docs/01-Architecture.md`: how the system is built.
* `docs/02-Backend.md`: the server.
* `docs/03-Domain.md`: entities, invariants and the ubiquitous language.
* `docs/06-Queue.md`: what is left, in order.
* `docs/05-Process.md`: how a delivery is born and declared done.
* `docs/adr/`: the decisions and their reasons.
