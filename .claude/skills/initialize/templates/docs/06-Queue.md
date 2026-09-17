# Queue

One line per delivery, in order. The mark says where it stands:
`[ ]` not yet defined · `[>]` defined, `work/<slug>.md` exists, not yet
built · `[x]` done, in `work/done/`. The process is `docs/05-Process.md`.

---

## Milestone 1: <name>

<!-- init: one paragraph: what a person can do end to end when this
     milestone closes. Then the lines. A slug is short, lowercase, hyphenated,
     and names what the user gains, not the technique. After the slug, one
     line of scope; a second line if it needs one. Brownfield: the first
     lines are often "describe what exists" deliveries (a missing test file
     the promise depends on, and a migration per slice toward the target
     layout only when the structure answer of docs/01-Architecture.md §3 is
     vertical slices and the code is organized by layer). Every other
     practice of §3 answered against what the code does today gets at least
     one line here as well: two patterns in the tree with no queued
     migration is the state the person was warned about when they chose.
     A line speaks in the terms of docs/03-Domain.md: an identifier it names
     is in that table, or the line says it in words and the term enters
     docs/03 when /propose defines the delivery. -->

```
[ ] <slug>               <one line of scope>
[ ] <slug>               <one line of scope>
```

Close of milestone 1: whole-branch review (`docs/05-Process.md` §9).

## Milestone 2: <name>

```
[ ] <slug>               <one line of scope>
```

## Later, not scheduled

<!-- init: what is known to be wanted and deliberately not ordered yet,
     one line each. -->

## Open decisions

<!-- init: decisions the queue depends on and nobody has taken. Each one a
     line with who decides. Mirror of docs/00-Product.md §Open decisions
     when they affect ordering. -->
