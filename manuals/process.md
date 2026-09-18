<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

# The delivery process

This manual explains the four commands the focus-kit installs in a
repository (`/initialize`, `/discuss`, `/propose`, `/apply`), the files they
read and write, and the rules behind them. It is kit-owned: `focus-kit update`
overwrites it. Project-specific slots (the verify command, the
environments, the git policy) live in `docs/05-Process.md`, which is yours.

---

## 1. The idea in one paragraph

Work moves through a **queue** of one-line deliveries. The line itself is
written by conversation, from an idea and whatever the project documents
already decide about it. Each delivery is then
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
.claude/skills/          /initialize, /discuss, /propose, /apply (kit-owned)
```

## 3. `/initialize`

Run once, in a repository where `focus-kit install` has been run. It
writes `docs/00` to `06`, `docs/adr/`, `CLAUDE.md`, and the `work/` folder.

* **Greenfield** (no code yet): it asks, in rounds of a few questions each,
  about the product, the domain, the stack, the four practices, the
  environments, the git strategy (§The git strategy), the conventions and
  the first milestone. It does not ask
  what it can default: the house stack (C# on .NET, the Mediator pattern as
  the orchestrator, in any implementation), the house rules, the process
  itself.
* **Brownfield** (code exists): it reads the repository first (manifests,
  CI, infrastructure, migrations, folder layout, git history), builds the
  graphify graph, and asks only what the code cannot answer. It describes
  what exists and what the target is, and keeps them apart when the two
  differ. The queue gets a migration delivery per slice only when the
  structure practice was answered vertical slices and the code is organized
  by layer. The git strategy is asked here too: the git history says what
  the repository does today, and today is a fact and not the rule.
* If `docs/` already exists, it is a **review** run: it proposes edits
  section by section instead of rewriting.
* It merges into an existing `CLAUDE.md`, never overwrites it.
* It installs the graphify post-commit hook, so the graph follows the code.
* It ends by running `focus-kit doctor` in the repository and printing what
  that command says, so a step the run did not take is named while the
  person is still reading.

Run it again at any time to review the documents against the code.

## 4. `/discuss <the idea>`

A conversation that ends in one line of `docs/06-Queue.md`, and in nothing
else. It is where an idea becomes a delivery someone can pick up, so that
the `/propose` after it starts from something already decided.

It reads the product, the domain, the queue and the deliveries in flight,
and no more: it asks the graph nothing. It offers the alternatives it sees,
says what each one buys and what it costs, puts its own recommendation
first, and asks you whenever more than one reading survives those files. A
matter one of them decides is said out loud with the file cited, and never
put in front of you.

Where the line goes it decides against the milestone paragraphs, and not by
taste: a milestone whose paragraph already admits the line takes it, with
no question asked; a line that serves a milestone whose paragraph does not
say so makes it ask you for the amendment and the placement together; and a
line no paragraph admits goes under "Later, not scheduled", which is the
block for what is wanted and not ordered. When three lines there share a
purpose, it says which three and proposes a milestone, a name and a
paragraph of its own, and writes it where you say.

It writes the line, and a term in `docs/03-Domain.md` when the idea names a
concept that document does not have. It writes no delivery page, no ADR and
no code, it edits no existing line and it changes no mark. It moves a line
in two cases only, each one a move you accepted: the three lines carried
into a milestone you said yes to, and a Later line promoted into a
milestone whose paragraph admits it now. When the idea is already a line it
says which one and writes nothing; when it is already a line under Later,
it says which one and offers that promotion.

The line is the whole record: what the conversation settled travels in its
own words, in the project's documentation language, with the slug in
English. Its last words name `/propose <slug>`, which may run in the same
session.

## 5. `/propose <slug>`

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

It starts from a line the queue already holds and already placed. A slug
the queue does not have, and a slug standing under "Later, not scheduled",
both stop it before it reads anything else: it says the line is not ordered
yet and names `/discuss`, so a run that stops costs neither a page nor a
graph build.

If a scope does not fit on one page, it is two deliveries. The page is the
test that the scope was understood.

## 6. `/apply <slug>`

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

## 7. The house rules

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

## 8. The queue

`docs/06-Queue.md` is one line per delivery, grouped by milestone and in
order from the first milestone on, plus one block outside that order. A
line never leaves; it changes mark. A milestone is the unit of "something a
person can use end to end". At the close of a milestone the stakeholder
runs a whole-branch review; each confirmed finding becomes a queue line
named after what it fixes.

**A milestone carries a name and a paragraph saying what closes it**, and
that paragraph is what a line is placed against: what it says closes the
milestone is what the milestone admits. A line whose scope the paragraph
already covers belongs there, and a line no paragraph covers does not
belong to any milestone yet.

**"Later, not scheduled" is that block outside the order**: the deliveries
that are wanted and not ordered, one `[ ]` line each in the queue's own
shape, a slug and its scope, and no prose bullet. It carries no `[>]` and
no `[x]`, because `/propose` stops on a slug standing there rather than
marking it. A Later line another delivery already did is struck through
with the reason naming that slug, never deleted, the way a cancelled line
is.

So a placement ends in one of three places, and `/discuss` is what takes
it: the milestone whose paragraph admits the line, the milestone whose
paragraph you amended to admit it, or Later. A line leaves Later only the
way it arrived, through `/discuss` and a move you accepted.

## 9. What the process deliberately lacks

No formal spec, no spec delta, no archiving step, no numbered tasks, no
pre-implementation gate, no specialized subagents, no architecture linter.
Each of these was tried in the project the kit came from and removed. If
one reappears, the question is which concrete error it would have caught,
and the answer has to name one that happened.

## 10. The git strategy

`docs/05-Process.md` §7 opens with `**Strategy.**` and one of three
answers, chosen once by `/initialize`. It decides where the work under a
slug is written and nothing else: whatever it says, the agent never commits
and never merges. It stages, and it names the command you run.

**The first command that writes under a slug is what makes the worktree or
the branch**, and every later command for that slug works in it. That is
`/discuss` when the line is new, and `/propose` when the line was already in
the queue. Everything relative to one slug is on one branch, named by the
slug, so `git add -A` of one delivery can never stage another's page.

**A worktree per delivery.** The command runs `git worktree add
../<repository folder>-<slug> -b <slug>` and writes its files in that
directory. `/propose` makes it at Write, after the graph is ensured and the
conversation is over, so a run that stops costs no directory; its Close
names that directory as where the `/apply` session opens, instead of
`/clear` here. `/apply` works in it, and its Close names the merge command
and `git worktree remove ../<repository folder>-<slug>`, and runs neither.
The merge command is `git checkout <trunk> && git merge <slug>`, the trunk
being the branch §7 names, under this strategy and under a branch per slug
alike. It is written here so that no run invents it.
A worktree is made from `HEAD`, so what is uncommitted in the main tree does
not follow it: a queue line written there and not yet committed is not in
the worktree, and neither is the graph, because `graphify-out/` is ignored
and the procedure builds one there once per delivery.

**A branch per slug.** The command runs `git checkout -b <slug>` in the tree
it is standing in. When that tree is not clean it first says what the
checkout will carry with it and asks, because uncommitted work follows a
checkout and the isolation this strategy promises covers committed work
alone.

**None.** Nothing is made. The three commands write where you are, and the
work goes straight to the trunk.

A branch or a worktree that already exists for the slug is not a failure:
the slug is what names it and the delivery is one, so the command says it is
already there and works in it.

`/apply` checks where it is standing before it reads anything of the
delivery. When §7 names worktree or branch and the session is not in the one
for this slug, it says the strategy, where it expected to be, where it is
and the command that gets there, and stops: nothing read, nothing built,
nothing staged. Under a branch that command is `git checkout <slug>`; under
a worktree it is opening a session in that directory, because a session does
not change its own working directory.

## 11. Commit message

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

## 12. Updating the kit

`focus-kit update <repo>` overwrites the four skills and the three
manuals and merges configuration. It never touches `docs/00` to `06`,
`CLAUDE.md`, `docs/adr/` or `work/`. `focus-kit doctor <repo>` says what is
installed and what is missing, and it names the kit-owned files that are
missing, were edited locally, or were added inside a skill folder, before
the next update restores, overwrites or removes them. Run it first when a kit-owned file matters to
you: it is the only warning you get.
