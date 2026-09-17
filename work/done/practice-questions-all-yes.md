# practice-questions-all-yes

**Goal.** A person reading `work/done/focus-is-asked-not-imposed.md` finds
its two unproven clauses proven or found red by a run, not argued: the
FOCUS line of `templates/CLAUDE.md`, written when all four Practice answers
are the manual's, and the two-patterns disclaimer, said on a brownfield
repository before the person answers. Three runs on 2026-09-17 said no to at
least one practice, so the first branch was never taken, and none of them
captured the disclaimer (`docs/06-Queue.md`, this line).

**Behaviour.**

* One scratch repository, brownfield, holding a fictional codebase written
  before the run as a fixture: organized by layer, rules inside handlers, a
  failure travelling as a thrown exception, no tests. Reading 6 of
  `/initialize` Step 1 finds one thing to cite per practice, on the side
  that is not FOCUS's. Code only, no prose document, so the graph builds
  without a model and the Graph confirmation is not asked. No screen, so the
  Proof tool question is not asked and the run says its one line instead.
* `/initialize` runs there in a clean session, the stakeholder answering.
  The four Practice questions get FOCUS's answer, the first option, four
  times. The Documentation language and the kind of project are the
  stakeholder's to answer as they like; the record says what they answered.
* The disclaimer is said as one line before the `AskUserQuestion` that
  carries the four questions, and the record quotes it as the run said it.
  A run whose transcript holds the question grid and no line before it is
  red on this clause, which is exactly what the previous delivery could not
  claim either way.
* The scratch's `CLAUDE.md` holds the FOCUS line as the template writes it
  and no per-practice line; its `docs/01` §3 holds the Practice table with
  four FOCUS answers; its queue holds a migration delivery per slice and one
  line at least for each of the other three practices, the promise the
  disclaimer is said on (`skills/initialize/SKILL.md`, Step 2).
* What the run produced wins. A red on either clause is recorded on the
  page and becomes a queue line naming the defect (`docs/05-Process.md`
  §6; `docs/03-Domain.md`, The queue). Nothing in `skills/` is edited by
  this delivery.

**Contract.** Nothing a target receives changes, so `VERSION` stays where
it is (`docs/05-Process.md` §5) and no `focus-kit install .` is owed.

* Read and not edited, kit-owned: `skills/initialize/SKILL.md`, the
  Practice questions, the disclaimer paragraph and Step 2's migration
  promise; `skills/initialize/templates/CLAUDE.md`, the init comment that
  writes the FOCUS line when all four answers are the manual's.
* This repository, project-owned: `docs/06` line `[x]`; the Record of this
  page quoting the disclaimer, the FOCUS line and the migration lines as the
  run wrote them, plus one honest line on what the stakeholder answered
  beyond the four. Where the quotes come from, the transcript of the session
  that ran or the stakeholder's paste, is the run's to settle and to say.
* The fixture's stack and size are the run's to settle, inside the
  constraint above: small enough that Step 1 reads it in one pass, and with
  at least two features, so the per-slice migration line is plural.

**Slice.** This repository's own `docs/06` and `work/`, project-owned.
`graph: explain "skills/initialize/templates/CLAUDE.md" named 1 file
(focus.md), affected named 0; explain "skills/initialize/SKILL.md" named 1
file (8 sections), affected named 0`. Nothing in `bin/focus-kit`, the
skills, the manuals, the templates or `config/`; no function row of
`docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` in the scratch says
the disclaimer line, asks the four questions once, says `no screen found;
§6 says how the endpoint or the CLI is proven`, and writes the nine
documents and `CLAUDE.md`.

**Visual reference.** No UI. The line the scratch's `CLAUDE.md` must hold,
as `templates/CLAUDE.md` writes it today:

```
- FOCUS (docs/manuals/focus.md): rules live in pure use cases; the
  orchestrator converts one event into one state; the repository is the
  only place an exception becomes a Result; features are vertical slices;
  errors are values and `throw` is not flow.
```

**Out of scope.**

* A fixture already shaped like FOCUS: the disclaimer exists for the code
  that does otherwise, and four yes against it exercise the migration
  promise too (asked, 2026-09-17).
* A clone of a public repository as the scratch: its shape is whatever it
  is, and its domain is not ours to document (asked, 2026-09-17).
* The first target: it moves only at a new version, and a review run there
  asks nothing while its `docs/01` §3 holds the table
  (`docs/05-Process.md` §5; `work/done/focus-is-asked-not-imposed.md`).
* A screen in the fixture: the Proof tool question is proven
  (`docs/06`, `initialize-asks-for-the-proof-tool`).
* Fixing a red in this delivery: a finding is a queue line
  (`docs/03-Domain.md`, The queue).
* An ADR: nothing here is a decision.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` unchanged.
* [x] Proof (`docs/05` §6): the run above, in a scratch repository, in a
  clean session, the stakeholder answering yes four times. Green: the
  disclaimer quoted from before the question grid; `CLAUDE.md` with the
  FOCUS line and no per-practice line; `docs/01` §3 with four FOCUS
  answers; the scratch's queue with the migration lines Step 2 promises.
  Red on either clause: recorded, and a queue line names it. The scratch is
  removed at the end (`docs/03`, Scratch repository).
* [x] The Record quotes the three things and says what else was answered.
* [x] The queue line `[x]`; the page in `work/done/`.
* [x] The last thing said is which environment is at which version.

---

## Record

**What the graph answered.** `graph: explain "skills/initialize/SKILL.md"
named 1 file (8 sections), affected named 0; explain
"skills/initialize/templates/CLAUDE.md" named 1 file (focus.md), affected
named 0`. The two lines the page already carried, re-asked before building.
Nothing in `skills/` was edited, so nothing the graph names moved.

**The fixture, and what it was for.** `ledgerline`, order intake and credit
control for a wholesale distributor, written for this delivery and thrown
away with the scratch: 16 Python files, 18 code files as graphify counted
them, 439 lines by the run's own reading, standard library only, no `.md`
of prose anywhere. Organized by layer (`handlers/`, `models/`,
`storage/`); rules inside the handlers, `place_order` carrying five of
them; a failure travelling as a thrown `LedgerError`, caught once in
`app.py`; no test at all. Three write features and a report, so the
per-slice migration line is plural. Five commits under one author, for the
seventh reading. The stack was the run's to settle (Contract): Python,
because the reading has to fit in one pass and a standard library CLI has
no build, no CI and no infrastructure to describe, which keeps the reading
on the four things the Practice questions quote.

Two things were checked before the handoff and both held. The corpus is
code only, so the first attempt of §Ensuring the graph succeeded for free,
`found 18 code, 0 docs, 0 papers, 0 images`, and the Graph confirmation was
never reached. The graph that probe wrote was deleted again, because the
run's Step 1 has to be the one that ensures it, and it was: the session
built it free (52 nodes, 143 edges, 9 communities, 0 tokens, stamp
`83dbee2d`) and installed the hook.

**The fixture was committed inside the scratch.** The agent never commits
(`docs/05-Process.md` §7), and that rule is about this repository's
delivery. A brownfield fixture with no history answers reading 7 with
nothing and has no `HEAD` for the graph to stamp, so the five commits are
part of the fixture, and they were removed with it.

**Where the quotes come from.** Settled as the session transcript, which
the Contract left to the run: `~/.claude/projects/`
`-private-tmp-focus-kit-scratch-nz4iMO/`
`6298fec7-5183-41e5-976b-e5210efe026f.jsonl`, 421 entries. Every quote
below was read out of that file, not retyped from the screen.

**The two-patterns disclaimer: green.** Entry 167 is an assistant text
block. Entry 168 is the `AskUserQuestion` whose four headers are
`Structure | Rules | Errors | Tests`. So the line was said before the grid,
which is the clause, and this is what it said:

> Agora as quatro Práticas. Uma linha antes de você responder: **escolher a
> resposta do FOCUS onde o código faz outra coisa deixa dois padrões na
> árvore ao mesmo tempo, o velho e o novo, até a migração terminar.** Isso
> é normal num projeto que está migrando e ruim num que não está, então
> cada resposta contra o código de hoje vem acompanhada de entregas de
> migração em `docs/06-Queue.md`, ou não vem.

It is in Portuguese because the conversation was
(`skills/initialize/SKILL.md`, Language); the documents came out in
English. Both halves of the paragraph are there: two patterns in the tree
at once, and the promise of the migration deliveries that pays for them.
`work/done/focus-is-asked-not-imposed.md` could not claim this clause
either way. It is claimed now.

**The four answers: FOCUS's, four times.** Entry 174 carries them, and each
question states what the sixth reading found, with the file:

| Question | The reading it states | The answer |
|---|---|---|
| Structure | by layer, an order spread over `handlers/orders.py`, `models/order.py` and `storage/order_store.py` | Vertical slices |
| Rules | inside the handlers, mixed with fetching and persisting: `place_order`, and `handlers/reports.py` running its own SQL | Use cases puros |
| Errors | as an exception: `errors.py`, raised in handlers and stores, caught in `app.py` `main` | Valores (Result) |
| Tests | none at all, no test file and no framework in `pyproject.toml` | Um teste por peça |

Four firsts, four answers against the code. The branch three runs on
2026-09-17 never took is taken.

**The `CLAUDE.md` FOCUS line: green.** The four lines of the Visual
reference are in the scratch's `CLAUDE.md` byte for byte, compared against
`skills/initialize/templates/CLAUDE.md` and not by eye, under
`## Non-negotiables`, and no per-practice line exists anywhere in the file.
One sentence follows them inside the same bullet, `The four answers are in
docs/01-Architecture.md §3, and that is where /propose and /apply read
them.`, which is the init comment's closing instruction written out. No
`<!-- init: ... -->` comment survived, in that file or in any of the nine
documents, and none of them holds a U+2014.

**One bullet the template does not have, and it belongs to this clause.**
The run added a third non-negotiable: `**The code does not obey them yet.**
All four were answered against what the tree does today, so two patterns
live here at once until the migration in docs/06-Queue.md lands`. It is not
a per-practice line, so the clause is still green. It is the disclaimer
written into the file every session reads, which nothing in the kit asks
for and which is the honest state of a repository that answered four times
against its own code.

**`docs/01` §3: four FOCUS answers.** Header row `Practice | Answer | Here
it is`, four rows, `Vertical slices`, `Pure use cases behind an
orchestrator`, `Values`, `A test per piece`, each with the place it will
live. A second table follows, `What the code does today`, with the file for
each of the four, which is Step 2's rule about keeping the two states
apart. The pieces table names four paths that do not exist yet and says so.

**The scratch's queue: the migration is plural, and every practice has a
line.** Fifteen deliveries in three milestones. Structure gets one line per
slice, four of them: `order-slice`, `customer-slice`, `shipment-slice`,
`statement-slice`. Rules gets `order-use-cases`, "the order rules become
pure functions returning a Result". Errors gets `orders-repository`, "the
only place sqlite3 is imported and the only place an exception is caught".
Tests gets `test-harness` first in the queue, plus a `characterize-*` line
before each move. That is Step 2's promise kept, and it is what the
disclaimer was said on.

**What the stakeholder answered beyond the four.** Kind of project:
`Brownfield`. Documentation language: `English`, asked in the question's
full English wording. Then two the run said no file answers, in one grid:
the verify command, answered `python -m unittest`, and the unit behind the
money integers, answered as whole units. Nothing else was asked, and the
Proof tool question was not, because there is no screen.

**The run corrected its own verify command, and that is the proof rule
working.** It first wrote `python -m unittest discover -s tests`, then ran
it, found `ImportError` and exit 1 with no `tests/` folder, and replaced it
with `python3 -m unittest discover` from the root, recording in `docs/05`
§4 that today it exits 5 with `NO TESTS RAN` and that this is a red. Not
asked for by this delivery, and recorded because what the run produced
wins.

**One divergence from States, and it is the queue line this delivery
leaves.** The page expected the line `no screen found; §6 says how the
endpoint or the CLI is proven`. What entry 177 says is `não achei tela
nenhuma; §6 dirá como a CLI é provada`, the same sentence in the language
of the conversation, and `docs/05` §6 of the scratch came out right:
`**Tool.** None, and none is needed: **no screen found**`. So the clause
the line belongs to is fine and the wording is not what the page predicted.
Inside that one session the Language question was asked in its full English
wording and the four Practice questions, the disclaimer and this line were
translated. `skills/initialize/SKILL.md` says "written here once and asked
as written" of three things, the Language question, the Practice questions
and the Proof tool question (lines 84, 184 and 264), and gives the
disclaimer and the no screen line as fixed text without the phrase. Of none
of the five does it say whether the wording survives a conversation in
another language, so two runs of the same command differ and neither is
wrong against the file. That is the defect, it is the kit's and not the
run's, and it is now
`asked-as-written-says-which-language` in `docs/06-Queue.md`. Fixing it is
out of scope here (`docs/03-Domain.md`, The queue). It sits next to
`review-run-finds-a-translated-practice-table`, which is the same rule
colliding with the same Language section on the writing side rather than
the asking side.

**Neither clause is red**, so neither becomes a queue line, which is the
outcome the page asked for and could not assume.

**What this commit carries that is not this delivery, and what it leaves
out.** A `/propose doctor-sees-an-unbumped-change` ran in another session
while this one was building. `docs/06-Queue.md` is one file and this
delivery had to write to it, so the commit carries that line's `[ ]`
turning into `[>]`. Its two other products are separable and are left
unstaged: `work/doctor-sees-an-unbumped-change.md`, its page, and the
`Unbumped change` row it added to `docs/03-Domain.md`. `git add -A` would
have taken both, and one delivery is one commit (`docs/05-Process.md` §7),
so the staging is by path here and the rule is the one the staging serves.
Same shape as `work/done/focus-is-asked-not-imposed.md`, second occurrence.

**Nothing was dropped.** No file under `skills/`, `manuals/`, `config/`,
`bin/` or `skills/initialize/templates/` was touched, as the Slice said,
and `VERSION` stays at 0.21.1 because a target receives nothing new
(`docs/05-Process.md` §5). The scratch was removed after the quotes were
taken, so nothing outside this repository survives the delivery.
