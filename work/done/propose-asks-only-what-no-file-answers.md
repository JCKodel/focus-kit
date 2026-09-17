# propose-asks-only-what-no-file-answers

**Goal.** A person running `/propose` answers only the questions no file in
the repository answers, so the attention a real decision needs is not spent
on a decided one. Measured on the first target
(`work/done/first-target-delivery.md`, finding 1): `/propose test-harness`
asked which test libraries enter when the queue line named one package and
`docs/04` §5 said when each of the others arrives; it had read both files,
quoted the rule from one of them inside the option text, and still put a
Decided matter in front of a person.

**Behaviour.**

* Before every `AskUserQuestion`, `/propose` passes each question it drafted
  through the files it has read: the queue line it is expanding, `docs/00`
  to `06`, what is in `work/`. The queue line naming what enters closes the
  question, because the order is the decision; a document stating the rule
  closes it; a file stating only today's fact leaves it open. What survives
  is asked, recommendation first, as today.
* A Decided matter goes onto the page in the section it belongs to, usually
  **Contract** or **Out of scope**, with the file cited in parentheses.
* Before the batch, the command says one line, `questions: <n> asked; <n>
  decided by files`, then one line per Decided matter naming it and the
  file. When every drafted question was decided, there is no
  `AskUserQuestion` and the first line reads `0 asked`. When nothing was
  drafted, nothing is said.
* On the first target as it was, question 2 of the four is not asked and
  questions 1, 3 and 4 are: which invariant to lock first, whether CI runs
  the tests and whether verify becomes a script are decisions no file
  there makes.
* "Not now" at the graph changes nothing: the pass reads files.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** One skill and one manual kit-owned; a target receives them on
`update`. Applies after `every-term-enters-03-first`, which takes the
version before this one and leaves the first target re-initialized, which is
where the proof runs.

* `skills/propose/SKILL.md`, Talk until it fits: the first sentence gains
  "and no file you read closes it"; then one paragraph after the first,
  headed by the words Decided matter: the three files that decide (the
  queue line, `docs/00` to `06`, `work/`), what closes (a name in the queue
  line, a rule in a document) and what does not (today's fact), where a
  Decided matter goes on the page, the line said before the batch and the
  one line per matter. It names `/initialize` Step 1 as where the same rule
  already lives, in one clause.
* `manuals/process.md` §4: the sentence "it asks you whenever there is more
  than one reading" gains "and no file it read closes it; a matter a file
  decides goes onto the page with the file cited".
* `VERSION`: one minor above what `every-term-enters-03-first` leaves,
  `0.16.0` when that page takes `0.15.0`. That page reads `VERSION` as
  `0.14.0` and expects the delivery before it to take that number; it
  already did, so the numbers there are one ahead and its own apply reads
  the file.
* This repository: `docs/00-Product.md`, Defining a delivery, the same
  clause as the manual; `docs/03-Domain.md` carries the Decided matter row,
  written by this page; `docs/06-Queue.md` line `[x]`.

**Slice.** `skills/propose/SKILL.md` and `manuals/process.md`, kit-owned;
this repository's `docs/`, project-owned. `graph: explain
"skills/propose/SKILL.md" named the file's four sections, affected named 0`,
so nothing outside the two files changes with them. Nothing in
`bin/focus-kit`, `skills/initialize/`, `skills/apply/` or `config/`, so no
function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. In the session, before each batch:

```
questions: 3 asked; 1 decided by files
  which test libraries enter: docs/06 names vitest, and docs/04 §5 says
  when jsdom, Testing Library and fake-indexeddb arrive
```

`questions: 4 asked; 0 decided by files` when nothing was decided, the first
line alone. `questions: 0 asked; 2 decided by files` and the two lines, with
no `AskUserQuestion`, when everything was.

**Visual reference.** The lines above, as the session would have shown them
on the first target as it was, followed by the `AskUserQuestion` carrying
questions 1, 3 and 4 of `first-target-delivery` unchanged.

**Out of scope.**

* The closing section and the new session: `propose-ends-by-naming-the-next-session`.
* Tooling detail the page cannot verify: `propose-does-not-fix-what-it-cannot-run`.
* The same pass in `/apply`: it asks nothing by contract, and a question
  there is a finding on the page that made it ask.
* `/initialize`: brownfield Step 1 already carries the rule and is the first
  occurrence; greenfield has no file to read.
* A House rule in `manuals/process.md` §6: two commands carry it, each in
  its own words; a third occurrence earns the house rule.
* A script or check: nothing here checks a rule automatically (`docs/00`,
  Not a linter); the check is a transcript read the way the records read it.
* Defining "rule" beyond the discriminator: fact against rule is the whole
  test, and the first target gave one clean case of each.
* An ADR: reversing this is deleting a paragraph.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what `every-term-enters-03-first` left; `focus-kit install .` run here
  last, after that delivery is `[x]`.
* [x] `grep -n "Decided matter" skills/propose/SKILL.md` prints the paragraph;
  `grep -n "closes it" manuals/process.md docs/00-Product.md` prints the §4
  sentence and the Defining a delivery sentence.
* [x] Proof: in `~/Downloads/vaulted` as `every-term-enters-03-first` leaves it,
  `focus-kit update ~/Downloads/vaulted`, then `/propose <slug>` there in a
  clean session, on the first `[ ]` line of the queue that run wrote, the
  stakeholder answering as the owner would. The done page carries the
  `questions:` lines and every question asked, each with the files read
  before it and the words "no file answers it"; a question a file answers
  is red, and the fix is a queue line, never an edit of this page. `git
  reset` there, nothing committed; the page it wrote stays. What the run
  produced wins over this page.
* [x] The `docs/03` row present; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

`graph: explain "skills/propose/SKILL.md" named 4 nodes, its own four
sections, affected "skills/propose/SKILL.md" named 0.` The skill is a
document node whose only edges are the headings it contains, and nothing in
this repository imports or calls it, which is what a skill is: a file a
session reads. So the slice was read from the page, from
`docs/05-Process.md` and from the four files the Contract names.

### What was built

`skills/propose/SKILL.md`, Talk until it fits, in the two places the
Contract names:

* The first sentence: "Ask with `AskUserQuestion` whenever there is more
  than one reading **and no file you read closes it**."
* One paragraph after that first one, headed by the words **Decided
  matter**, carrying the three files that decide (the queue line being
  expanded, `docs/00` to `06`, what is in `work/`), what closes (a name in
  the queue line, because the order is the decision; a rule in a document)
  and what does not (a file stating only today's fact), that the graph
  changes nothing here with "Not now" included, where a decided matter goes
  on the page (Contract or Out of scope, file in parentheses), and the
  clause naming `/initialize` Step 1 on a brownfield repository as where the
  same rule already lives. Then the two output lines, as a fenced block, and
  the two edge cases: `0 asked` and no `AskUserQuestion` when everything was
  decided, nothing said when nothing was drafted.

`manuals/process.md` §4: "it asks you whenever there is more than one
reading **and no file it read closes it; a matter a file decides goes onto
the page with the file cited**; it puts its recommendation first."

`docs/00-Product.md`, Defining a delivery: the same clause, plus one
sentence that a matter a file decides goes onto the page with the file cited
and is never put in front of the person.

`VERSION` `0.15.0` to `0.16.0`.

### What diverged from the plan

**The output block in the skill is written with placeholders, not with the
first target's example.** The Contract asks for "the line said before the
batch and the one line per matter", and the States section of this page
shows the measured case, `which test libraries enter: docs/06 names vitest,
and docs/04 §5 says when jsdom, Testing Library and fake-indexeddb arrive`.
The three skills are stack-agnostic (`CLAUDE.md`), and a target repository
should not receive another project's package names as the illustration of a
rule. The block in the skill reads `questions: <n> asked; <n> decided by
files` and `<the matter>: <the file, and what it says that settles it>`. The
measured example stays where it belongs: this page and the record below.
Same reasoning as `every-term-enters-03-first`, whose template lost
`VaultRepository` for the same reason.

**The `docs/03-Domain.md` row was already there.** The Contract says the row
is "written by this page", and `/propose` had already written it: it is in
commit `8745596`, carried in with the delivery before this one, because that
session ran in parallel. It was read back against the paragraph the skill
now carries and the two agree on every point: the three files, what closes
and what does not, where the matter goes, the two output lines, and
`/initialize` Step 1 named as the first occurrence. Nothing was added and
nothing was changed there.

**`docs/00-Product.md` took one sentence more than the clause.** The
Contract says "the same clause as the manual". The manual's sentence is a
list of what `/propose` does and the clause fits inside it; the product
document's is a paragraph about defining a delivery, where the clause alone
says when a question is asked and not what happens to the one that is not.
So it carries the clause plus one sentence: a matter a file decides goes
onto the page with the file cited, and is never put in front of the person.
That is what the skill says and what the `docs/03` row says, in the document
whose job is to state the rule in full.

**`docs/05-Process.md` §2 carries the same sentence and was left alone.**
The Contract names the manual and `docs/00`, not `docs/05`. That line is a
one-line summary of the flow inside the slot document, and the slot document
is what `/apply` reads; the rule it summarizes is stated in full two files
away. Recorded, not edited, because the Contract is the scope.

### What was dropped

Nothing. Every line of the Contract is in.

### Decisions taken

No ADR, as the page said: reversing this is deleting a paragraph.

### The verify command

```
focus-kit 0.16.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

Run after `focus-kit install .`, which is the order check 6 requires. The
two greps of "Done when" print what they were asked to print: `Decided
matter` at line 39 of the skill, `closes it` at line 83 of
`manuals/process.md` and line 162 of `docs/00-Product.md`.

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.16.0` in. `work/` there was
empty and the first `[ ]` line of the queue the previous delivery's
`/initialize` wrote was `em-dash-sweep`, so that is the slug the run
expanded. A clean session ran `/propose em-dash-sweep`, the stakeholder
answering as the owner would, **Not now** at the Graph confirmation
(`no graph this session; reading files directly`).

The pass ran and said, before its only batch, word for word as the session
printed it:

```
questions: 1 asked; 9 decided by files
  the marketing and launch documents (docs/launch-copy.md,
docs/show-hn-draft.md, MARKETING_PLAN.md, DEPLOY.md): docs/06-Queue.md, the
em-dash-sweep line names what enters, "the 11 files under app/ and
components/"
  code comments (lib/storage.ts:54): docs/04-Conventions.md §1, the rule "does
not cover code comments and documentation, which are technical prose"
  what replaces a dash: docs/04-Conventions.md §1 plus the queue line, a full
stop first, a colon or parentheses when it is not, never a hyphen
  prose language of the page: docs/05-Process.md §0, English
  whether it deserves an ADR: docs/04-Conventions.md §1 already carries the
rule; the sweep decides nothing new
  the verify command: docs/05-Process.md §4, npm run lint && npm run build,
and there is no runner (docs/00-Product.md Open decision 4)
  the "open source" and "no tracking" claims sitting on edited lines:
docs/06-Queue.md gives them to license-or-claim and analytics-truth
  updating the docs that carry the count: CLAUDE.md §How to work, the doc that
owns the behaviour changes in the same delivery
  the visual reference: docs/05-Process.md §6, the live app and
marketing-assets/home.jpg, phone width checked first
```

**The one question asked, and no file answers it.** `Depois da varredura, o
que impede o travessão de número 66 de entrar?` The files read before it
were `docs/04-Conventions.md` §1, which states the rule and enforces
nothing; `docs/05-Process.md` §4, whose verify command is `npm run lint &&
npm run build`, with no lint rule over string literals; and
`docs/06-Queue.md`, which has no guard line. Three documents that between
them say what the rule is and leave open what holds it after the sweep,
which is a decision and not a fact. The answer was "a queue line of its
own", and the run wrote `em-dash-guard` into the queue after
`testing-setup`, with the reason on the line. The question earned its place.

**Nothing red.** Every one of the nine was closed by a file that states a
rule or by the queue line that names what enters, and each one landed on the
page with its file cited: five in **Out of scope** (code comments, the four
marketing documents, the claims on edited lines, the guard, the sitemap
work), the rest in **Behaviour**, **Contract**, **Visual reference** and
**Done when**. Every one of the nine cites the file that closed it, on a
107 line page. No question a file answers reached the person, so there is no
queue line to write.

**"Not now" at the graph changed nothing**, as the page said. The session
said `no graph this session; reading files directly` and ran the pass
anyway, on grep and the seven documents. That is the Behaviour bullet
proven, and it is the branch that matters: a pass that quietly needed the
graph would have printed nothing here.

### What the proof found, and the run wins

* **The ratio is the opposite of the page's illustration, by a lot.** The
  States section shows `3 asked; 1 decided by files`. The run printed
  `1 asked; 9 decided by files`. The measured example came from
  `/propose test-harness`, one question of four; this run drafted ten and a
  file closed nine. Nothing changes in the skill: the pass counts what it
  finds, and what it found is that most of what a well documented repository
  makes an agent want to ask is already written down. The illustration in
  this page stays as the record of the case that made the delivery exist.
* **The predicted case was not the case that ran.** The Behaviour section
  says "on the first target as it was, question 2 of the four is not asked".
  That was `/propose test-harness`, and the first target no longer has the
  documents that run read: `every-term-enters-03-first` cleaned the tree and
  re-initialized it, and `work/` came back empty. So the queue's own first
  `[ ]` line was the honest thing to expand, and the prediction about the
  four questions of `test-harness` was never testable here. It stays as the
  measurement that motivated the change, not as a result.
* **The output block reads as one logical line per matter, wrapped.** Nine
  matters, each one starting at the two space indent and running over two or
  three physical lines because the text is long. The Contract asks for "one
  line per Decided matter" and that is what it is. Nothing to change; worth
  saying, because at nine matters the block is most of a screen and the
  summary line above it is what carries the count.
* **The placeholder form of the block was the right call, and the run
  filled it the way it is written.** `<the matter>: <the file, and what it
  says that settles it>` came back as `code comments (lib/storage.ts:54):
  docs/04-Conventions.md §1, the rule "does not cover code comments and
  documentation, which are technical prose"`, with the rule quoted. The
  divergence recorded above is closed by the run: the skill did not need the
  first target's package names to produce a line that cites and quotes.

### What the proof found beyond its own scope

The run put a wrong reason on the page and then corrected it inside the same
session: it first justified keeping the guard out by saying a guard changes
the verify command, which an eslint rule does not, and rewrote it as "the
queue line names removal and only removal". The Decided matter pass is about
which questions reach the person; it says nothing about whether the reason
written beside a decided matter is true. Recorded, not ordered, because it
is the stakeholder's to order (`docs/03-Domain.md`, First target).

`git reset` was run in `~/Downloads/vaulted`: nothing was staged, nothing
was committed, `HEAD` is still `f6e685c`, and the working tree is left as
the run left it, `work/em-dash-sweep.md` and the queue's two changed lines
included.

### A parallel session

A `/propose` session wrote `work/propose-ends-by-naming-the-next-session.md`,
added the `Clean session` row to `docs/03-Domain.md` and turned that queue
line to `[>]` while this delivery ran. None of the three is staged here: one
delivery, one commit (`docs/05` §7). The queue line was staged at `[ ]` and
left at `[>]` in the working tree, so that session finds it as it left it,
and its `docs/03` row waits for its own apply. This is the fourth time it
happens, after `graph-answers-structure`,
`initialize-asks-for-the-proof-tool` and `every-term-enters-03-first`, and
the handling is the same.

### Environments

| Environment | Version |
|---|---|
| Kit source (`skills/`, `manuals/`, `config/`, `bin/`) | `0.16.0`, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | `0.16.0`, in sync (`selftest` green, check 6 empty) |
| Machine (`~/.local/bin/focus-kit`) | the CLI untouched, a symlink to the kit source; the global `/graphify` skill at graphify `0.9.63` |
| First target (`~/Downloads/vaulted`) | `0.16.0`, one `/propose` run through it, nothing committed |
| Target repositories (anyone else's) | untouched; they move on `focus-kit update <path>`, run by their owner |
