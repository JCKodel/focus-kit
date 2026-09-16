# Conventions and tests

How the code looks and where it is tested. The architecture is in
`docs/01-Architecture.md`; the FOCUS review rules in `docs/manuals/focus.md`.

---

## 1. Language

<!-- init: fill the two paragraphs below from the documentation language
     settled in Step 0, and keep the same wording in CLAUDE.md and in
     docs/05-Process.md §0. If the project is not in English, this whole
     document is written in the project's language, this heading included. -->

**Prose in English.** Documents, ADRs, `work/<slug>.md`,
`work/done/<slug>.md` and commit messages. This is the project's
documentation language. The conversation is a separate matter: it follows
the language of whoever is writing.

**Identifiers in English**, whatever the prose language. Types, methods,
columns, migrations, file names, branches. `docs/03-Domain.md` holds the
table that translates each concept into its code name, once.

<!-- init: the language(s) of the user interface, and where UI text lives.
     If the product speaks more than one language, the mechanism, and the
     rule for adding a string. -->

### Text a user reads

**No em dash in any text a user reads.** Non-negotiable. It is the most
recognizable signature of generated text, and a product that shows it
loses trust before it explains what it does. Where one would appear, what
is wanted is almost always a full stop and a new sentence; when it is not,
a colon or parentheses. The rule covers every string a user sees: label,
paragraph, error message, email, `aria-label`, notification. It does not
cover code comments and documentation, which are technical prose.

The rest of the copy answers one question: **what does the person gain
here?** Product vocabulary (`docs/03-Domain.md`) is for the people who
build. On screen, say what the thing does in the words of someone who
never read `docs/03`.

<!-- init: the copy rules the product needs beyond these two, one line each.
     Example from a previous project: "a level number is not copy; say who
     sees it and when"; "a field label is an answered question"; "a field
     without an example is a field without instructions". -->

## 2. Names

| Thing | Form | Example |
|---|---|---|
<!-- init: one row per kind of thing this stack has: type, method, file,
     folder, endpoint, route, table, column, message, event, test. Fill from
     the client's or the framework's convention; be exact, this table is
     what a reviewer points at. -->

The domain vocabulary is `docs/03-Domain.md` and is not translated
independently: if the screen says X, the code says `x`.

## 3. Style

<!-- init: formatter and linter, and the command that runs them. Editor
     config. The two or three style rules the formatter cannot enforce and
     the team cares about. If there is a UI: design tokens, the icon set,
     the theme rule, motion rules. -->

## 4. Errors are values

<!-- init: the Result type in this stack and the four rules:
     functions at the boundary return a Result (or a discriminated union
     when the caller must distinguish failure modes); `throw` is not flow,
     try/catch exists only in repositories to convert an infrastructure
     exception into a Result; the view decides what to show from the
     Result and never inspects a driver message; the framework's own
     error mechanism is the one exception, named. -->

## 5. Where things are tested

| What | With what | When |
|---|---|---|
| Business rule (use case) | <!-- init: unit test framework --> | always: it is the unit of unit testing |
| One action end to end (orchestrator) | <!-- init: integration test, real infra or container --> | every delivery that adds or changes an action |
| Screen or endpoint (view) | <!-- init: e2e or contract test --> | every delivery that has one |
| Repository | <!-- init: against the real database --> | every delivery that touches one |
| <!-- init: the project's inviolable proof, if any (privacy boundary, authorization matrix) --> | | automatic, every run |

```
<verify command>   = <!-- init: expand: build && lint && unit && integration && e2e -->
```

<!-- init: viewports, fixtures, test data policy, what is masked in
     screenshots, anything a test needs that the repo does not say. -->

**What is not a rule:** mandatory red-green, minimum coverage, a test
matrix per layer, a component test by symmetry. Write the test that proves
the behaviour; do not write a test to satisfy a count.

**What is non-negotiable:** <!-- init: the one or two test files the
product's promise depends on, if any. Otherwise: "the verify command green". -->

## 6. Commits

<!-- init: fill from the git policy in docs/05-Process.md §Git. Keep the
     part below that is house rule. -->

The agent stages (`git add`) and **suggests** the message; a person
commits, after reviewing. The commit is the delivery, and the delivery
passes through human review.

Message in the imperative, in the documentation language of §1, with the
slug as scope. The type, the scope and the slug stay as they are, because
they are identifiers:
`feat(place-order): order placed with idempotency key`.

**With a ceiling.** Subject up to 72 characters; body up to five one-line
bullets, the highlights, not the reasoning. The reasoning (what was
weighed, what was dropped, what diverged from the plan, the state of each
environment) lives in `work/done/<slug>.md`, and the body's last line
points at it.

```
feat(place-order): order placed with idempotency key

* PlaceOrder use case: rejects an empty cart and a repeated key
* PlaceOrderHandler persists through OrdersRepository, one state out
* endpoint returns 201 with the order id, 409 on repeated key
* staging updated; production waits for the milestone

Details in work/done/place-order.md
```
