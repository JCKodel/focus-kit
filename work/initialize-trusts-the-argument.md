# initialize-trusts-the-argument

**Goal.** A person running `/initialize` is never asked to reconfirm
something they typed, and never reads a recommendation whose reason is the
answer it is recommending: the command takes no argument, counts the source
files in every run, says what it counted, and the question it asks about the
kind of project is confirming a detection that really is one. Measured on
2026-09-17 in the scratch of `review-run-finds-a-translated-practice-table`:
the run was started with `/initialize green`, asked the question anyway, and
the description of the option it recommended cited the argument it was
reconfirming (`docs/06-Queue.md`, this line).

**Behaviour.**

* `/initialize` takes no argument. The frontmatter line that declares one
  goes, and the sentence of Step 0 that trusted `$ARGUMENTS` goes with it;
  what stays is the count of source files and the two definitions it decides
  between (asked, 2026-09-17: neither of the two fixes the queue line
  offered, because removing the argument leaves no second source to
  reconcile).
* A word typed after the command is ignored, and the run says nothing about
  it. Nothing in the skill names an argument any more, so there is no rule to
  read and none to explain (asked, 2026-09-17).
* Before the Step 0 `AskUserQuestion`, one line says what the count found and
  which kind of project it makes the repository, so a record of the run holds
  the evidence behind the option the question puts first (asked,
  2026-09-17).
* The kind question keeps its words. It said "say which you detected and let
  them confirm" while one path through Step 0 reached it with nothing
  detected, and that path is what leaves; the sentence is true in every run
  once the count is the only source.
* The two manuals that name `/initialize brown` stop naming an argument the
  command no longer has.

**Contract.** One skill and two manuals, kit-owned; a target receives all
three on `update`.

* `skills/initialize/SKILL.md`, frontmatter: the `argument-hint` line is
  removed. `name:`, the `description: >-` block and the two `---` lines stay
  as they are; the description block becomes the last key, which check 4 of
  the verify command accepts, because its closing `---` ends the read before
  any indentation test (`bin/focus-kit`, `check_frontmatter`).
* The same file, Step 0, first paragraph: the sentence trusting `$ARGUMENTS`
  is removed. What remains must hold the count, what it counts and the two
  definitions, as it does today. The wording is the run's, inside that.
* The same file, Step 0, one line before the `AskUserQuestion`: it must hold
  what the count found and which kind of project that makes the repository.
  Said in the conversation's language, like everything the command says.
* The same file, Step 0, item 1 of the `AskUserQuestion`, keeps its words,
  and so does the sentence that says the one question carries both. The
  review-run exception that reads the language instead of asking it is
  untouched, so a review run still carries the kind question alone.
* The Language question's text does not change. It is the source the As
  written rule compares a record against, and it belongs to
  `work/asked-as-written-says-which-language.md`.
* `manuals/process.md`, §3, the sentence that ends the `/initialize`
  description: it must no longer name an argument, and what it says must stay
  true of the command, which is that running it again reviews the documents
  against the code. Both halves of today's sentence are review runs, because
  Step 0 makes any run a review once `docs/00-Product.md` exists.
* `manuals/graphify.md`, §Why it is here, the sentence naming what each of
  the three commands asks the graph: the same, and what it says about reading
  the god nodes and the communities once is unchanged.
* `docs/03-Domain.md`: the row Kind of project, added by this page. The
  Initialize row keeps its wording. `docs/06` line `[x]`.
* Nothing in `docs/00-Product.md` changes: its Initializing section describes
  greenfield and brownfield and never named the argument.
* `VERSION`: one patch above what the file holds.
* Nothing in `bin/focus-kit`, the templates or `config/` changes.

**Slice.** `skills/initialize/SKILL.md`, `manuals/process.md` and
`manuals/graphify.md`, kit-owned; this repository's `docs/03` and `docs/06`,
project-owned. `graph: explain "skills/initialize/SKILL.md" named 1 file
(8 sections), affected named 0`. No row of `docs/01` §3 changes, in either
table. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` says one line more than
today, before the Step 0 question, and asks the same two questions it asks
now: the kind of project and, on a first run, the documentation language.

**Visual reference.** No UI. What the record of a run holds: the count line
as said, and the kind question as asked, whose recommended option cites the
count and nothing else.

**Out of scope.**

* The two `docs/06` lines that name `/initialize brown`,
  `graph-answers-structure` and `review-run-finds-a-translated-practice-table`:
  a queue line records what was true when it was written.
* Saying anything, in the skill or in a run, about a word typed after the
  command (asked, 2026-09-17).
* How the count decides: what counts as a source file was never the defect.
* What makes a run a review run: `docs/00-Product.md` existing decides it,
  and the argument never overrode that (`skills/initialize/SKILL.md`,
  Step 0).
* The five As written texts:
  `work/asked-as-written-says-which-language.md` owns them, and the Language
  question keeps its words here.
* Translating the manuals: `docs/00`, open decision 4.
* An ADR: removing one argument from one command is not expensive to reverse
  (`docs/03`, ADR).

**Done when.**

* [ ] `bin/focus-kit selftest` green, check 4 and check 6 included; `VERSION`
  one patch above what the file holds; `focus-kit install .` run here last.
* [ ] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
  fictional domain, brownfield so the count has something to count, in a
  clean session, run at least through the kind question. Green: the skill's
  frontmatter declares no argument; the run says what it counted and which
  kind it gives before it asks; the kind question's recommended option cites
  the count and no argument. Then the same command with a word after it, in a
  second scratch so that both runs are first runs and neither reaches the
  review branch, which must produce the same line and the same question. Both
  scratches are removed. What the run produced wins; red is a queue line.
* [ ] Neither manual names an argument, and the `docs/03` row is present; the
  queue line `[x]`.
* [ ] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [ ] The last thing said is which environment is at which version.
