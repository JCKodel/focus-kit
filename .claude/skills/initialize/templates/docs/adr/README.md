# Architecture decision records

One file per decision that is expensive to reverse: a stack choice, a
boundary, a rule the whole codebase obeys. Numbered, never renumbered,
never deleted. A decision that changes gets an **amendment** dated inside
the same file, or a new ADR that supersedes it, with both pointing at each
other.

Format: `ADR-NNNN-short-slug.md`, from `ADR-0000-template.md`.

What is an ADR and what is not:

* **Is:** the database, the framework, the authorization model, the error
  model, "no branches", "migrations are squashed until the first real user".
* **Is not:** a delivery's local choice (that goes in `work/done/<slug>.md`),
  a naming rule (that goes in `docs/04-Conventions.md`), a product rule
  (that goes in `docs/00-Product.md`).

The docs cite ADRs by number (`ADR-0003`). When a doc and an ADR disagree,
the ADR is the reason and the doc is the state: fix the doc, or amend the
ADR, in the same delivery.

## Index

| ADR | Title | Status |
|---|---|---|
| 0001 | <!-- init: the stack decisions found or given --> | accepted |
