<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

# The delivery process

This manual explains the three commands the focus-kit installs in a
repository (`/initialize`, `/propose`, `/apply`), the files they read and
write, and the rules behind them. It is kit-owned: `focus-kit update`
overwrites it. Project-specific slots (the verify command, the
environments, the git policy) live in `docs/05-Process.md`, which is yours.

---

## 1. The idea in one paragraph

Work moves through a **queue** of one-line deliveries. Each delivery is
**defined** in a one-page file by conversation, then **built** in a clean
session that reads only that page and the project docs. Deciding and doing
are separated on purpose: it is what keeps scope from growing while code is
being written. The docs (`docs/00` to `06`) exist so the page can be short:
they hold what the page would otherwise have to restate. A person reviews
and commits; the agent never does.

## 2. The files

```
CLAUDE.md                the entry point every session reads first
docs/
  00-Product.md          what the product is, for whom, what it is not
  01-Architecture.md     how it is built: stack, the four practices, the pieces
  02-Backend.md          the server: topology, operation, migrations, boundary
  03-Domain.md           the vocabulary, with each term's name in code (the pivot)
  04-Conventions.md      names, style, errors, where things are tested, commits
  05-Process.md          this process, with the project's slots filled
  06-Queue.md            the ordered queue, marked [ ] [>] [x]
  adr/                   decisions that are expensive to reverse
  manuals/               how-to documents; these three are kit-owned
work/
  <slug>.md              a delivery being defined or built
  done/<slug>.md         a delivery that shipped, with what happened
graphify-out/            the knowledge graph of the codebase (docs/manuals/graphify.md)
.claude/skills/          /initialize, /propose, /apply (kit-owned)
```

## 3. `/initialize`

Run once, in a repository where `focus-kit install` has been run. It
writes `docs/00` to `06`, `docs/adr/`, `CLAUDE.md`, and the `work/` folder.

* **Greenfield** (no code yet): it asks, in rounds of a few questions each,
  about the product, the domain, the stack, the four practices, the
  environments, the conventions and the first milestone. It does not ask
  what it can default: the house stack (C# on .NET, the Mediator pattern as
  the orchestrator, in any implementation), the house rules, the process
  itself.
* **Brownfield** (code exists): it reads the repository first (manifests,
  CI, infrastructure, migrations, folder layout, git history), builds the
  graphify graph, and asks only what the code cannot answer. It describes
  what exists and what the target is, and keeps them apart when the two
  differ. The queue gets a migration delivery per slice only when the
  structure practice was answered vertical slices and the code is organized
  by layer.
* If `docs/` already exists, it is a **review** run: it proposes edits
  section by section instead of rewriting.
* It merges into an existing `CLAUDE.md`, never overwrites it.
* It installs the graphify post-commit hook, so the graph follows the code.

Run it again with `/initialize brown` after a large change to the
codebase, or `/initialize` at any time to review the docs against the code.

## 4. `/propose <slug>`

A conversation that ends in `work/<slug>.md`, one page, in the format
`docs/05-Process.md` §3 defines:

* **Goal**, one sentence, in user terms.
* **Behaviour**, verifiable scenarios; each becomes a test or a check.
* **Contract**, the data, API and migration shapes. The only section that
  must be exact, because it is the only one that is expensive to reverse;
  exact about what must hold, not about what only a run settles: of a tool
  it names the tool and the constraint, and leaves the version to `/apply`.
  It holds no fact the run rechecks either, because what a tool, a registry
  or a service declares today changes with no commit in the repository, so
  the page writes the constraint, or the condition the run evaluates, and
  never the finding.
* **Slice**, the feature folder and the pieces it touches.
* **States**, **Visual reference**, **Out of scope**, **Done when**.

It reads the product, the domain, the queue and the deliveries in flight;
it asks the graph what depends on what the delivery names; it asks you
whenever there is more than one reading and no file it read closes it; a
matter a file decides goes onto the page with the file cited; it puts its
recommendation first.
It writes no code.
When it is done, it turns the queue line from `[ ]` to `[>]`, and its last
words name the new session to type `/apply` in.

If a scope does not fit on one page, it is two deliveries. The page is the
test that the scope was understood.

## 5. `/apply <slug>`

Implements the page, in a clean session, one where `/apply` is the
first thing typed; when it is not, it says so in one line and stops. End to
end:

1. reads the delivery, `CLAUDE.md`, `docs/01`, `docs/04`, `docs/05` and, of
   the FOCUS manual, the sections the practices answered its way name and
   no others; asks the graph the structure of the slice;
2. builds every piece in the place `docs/01` §3 gives it, with errors
   travelling the way that table answers; settling what the page left to
   the run and recording the choice;
3. runs the verify command until green; proves the screen the way
   `docs/05` §6 says;
4. leaves each environment in the state `docs/05` §5 requires, and
   **never ends silent about environments**: the last thing it says is
   which environment is at which version and the command that updates the
   others;
5. writes into the delivery file what happened (what diverged, what was
   dropped, what the proof found, decisions taken), updates the docs the
   delivery changed, ticks "Done when", moves the file to `work/done/`,
   turns `[>]` into `[x]`;
6. stages with `git add -A` and suggests the commit message. **It does not
   commit.** The post-commit hook rebuilds the graph when you do.

## 6. The house rules

These are fixed in every project the kit installs. They are not up for a
per-project vote, which is why `/initialize` does not ask about them.

* **One delivery is one page.**
* **No em dash in any text a user reads.** It is the signature of generated
  text and it costs the product's credibility.
* **The agent never commits.** It stages and suggests; a person reviews.
* **Abstraction on the second concrete occurrence**, and the delivery
  says which was the first. This is about a layer, a helper or an
  interface inside a slice. Promotion to `shared/` follows the book's rule
  of three (`docs/manuals/focus.md` §6): reuse proven in two working slices
  before the code moves up. YAGNI is a decision rule, not a mood.
* **Docs are living.** A delivery that changes behaviour updates the doc
  that owns it, in the same delivery. A new term enters `docs/03` before
  it enters code.
* **Prose in the project's language, identifiers in English.** The
  documentation language is chosen once, by `/initialize`, and declared on
  the language line of `CLAUDE.md` and in `docs/04-Conventions.md` §1;
  documents, deliveries and commit messages follow it, and English is the
  default. Identifiers never follow it: `docs/03-Domain.md` translates each
  concept into its English code name once, so it is not renegotiated file by
  file. The conversation follows the language of whoever is writing, which
  is a third thing again.

What is not a house rule is the architecture. The four practices, how the
code is structured, where the rules live, how errors travel and what is
tested, are asked by `/initialize`, one question each with the FOCUS answer
offered first and never assumed, and they live in `docs/01-Architecture.md`
§3 of the project that answered them. FOCUS (`docs/manuals/focus.md`) is the
name for saying yes to all four.

## 7. The queue

`docs/06-Queue.md` is one line per delivery, in order, grouped by
milestone. A line never leaves; it changes mark. A milestone is the unit
of "something a person can use end to end". At the close of a milestone the
stakeholder runs a whole-branch review; each confirmed finding becomes a
queue line named after what it fixes.

## 8. What the process deliberately lacks

No formal spec, no spec delta, no archiving step, no numbered tasks, no
pre-implementation gate, no specialized subagents, no architecture linter.
Each of these was tried in the project the kit came from and removed. If
one reappears, the question is which concrete error it would have caught,
and the answer has to name one that happened.

## 9. Commit message

Subject up to 72 characters, imperative, with the slug as scope. Body up
to five one-line bullets: the highlights, not the reasoning. Last line
points at `work/done/<slug>.md`, where the reasoning lives.

```
feat(place-order): order placed with idempotency key

* PlaceOrder use case: rejects an empty cart and a repeated key
* PlaceOrderHandler persists through OrdersRepository, one state out
* endpoint returns 201 with the order id, 409 on repeated key
* staging updated; production waits for the milestone

Details in work/done/place-order.md
```

## 10. Updating the kit

`focus-kit update <repo>` overwrites the three skills and the three
manuals and merges configuration. It never touches `docs/00` to `06`,
`CLAUDE.md`, `docs/adr/` or `work/`. `focus-kit doctor <repo>` says what is
installed and what is missing, and it names the kit-owned files that are
missing, were edited locally, or were added inside a skill folder, before
the next update restores, overwrites or removes them. Run it first when a kit-owned file matters to
you: it is the only warning you get.
