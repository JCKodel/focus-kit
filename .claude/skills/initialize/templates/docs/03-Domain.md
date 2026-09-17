# Domain and ubiquitous language

**Project:** <name>
**Status:** <draft | active>
**Last updated:** <YYYY-MM-DD>

---

## Purpose

This document defines the entities of <name>, their invariants and the
**ubiquitous language** of the project.

It is the pivot document: every delivery in `work/`, every identifier in
code and every test uses the terms defined here. Each concept has exactly
one meaning, and the same concept never receives two names.

## Term in code

Concepts are defined in prose; every identifier in code, schema and API is
written in English, whatever language this document is in. So that the
translation from concept to identifier is made once and not renegotiated
file by file, each term declares its canonical code name. The table is normative: no delivery may name in code a
concept that is not here.

The listed form uses `camelCase`. The concrete casing follows the artifact:
`PascalCase` for types, `snake_case` for database objects where the stack
uses it, plural for collections.

**A new concept enters here first**, with its code term, and only then
appears in a delivery. The kit's own vocabulary is the exception: view,
orchestrator, use case, repository, Result, `Failure`, slice and every other
term `docs/manuals/focus.md` defines mean there what they mean here, and
need no row. A name that builds on one of them is an identifier of this
project and does.

| Term | Code | Short meaning |
|---|---|---|
<!-- init: one row per concept. Start with the nouns from the product
     conversation or the graph's god nodes. Aim for completeness over
     brevity: twenty rows is normal, sixty is fine. Brownfield: the "Code"
     column is what the code already calls it; if two names exist for one
     concept, pick one, list the other as deprecated, and add a queue line
     to rename. -->

---

## Entities and invariants

<!-- init: one subsection per aggregate or cluster of concepts. Each one:
     what it is, what is always true about it (the invariants, as
     checkable sentences), what transitions it has, and what it is not.
     Invariants are what use cases enforce and tests prove; write them so a
     test can be named after each. -->

### <Aggregate>

<!-- init: meaning, invariants, transitions, what it is not. -->

---

## What is a fact and what is a preference

<!-- init: optional, keep if the product distinguishes what a user IS or
     DID from what a user WANTS, and treats them differently (visibility,
     matching, privacy). Delete otherwise. -->

## Language of the interface

<!-- init: which languages the product speaks to users in, and the rule
     for text on screen (lives in the component, in a resource file, in a
     translation system). -->

---

## Related documents

* `docs/00-Product.md`: what the product is.
* `docs/01-Architecture.md`: how it is built.
* `docs/02-Backend.md`: the server.
