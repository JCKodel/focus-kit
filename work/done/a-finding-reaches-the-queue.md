# a-finding-reaches-the-queue

**Goal.** A finding a delivery made and did not build reaches
`docs/06-Queue.md` at the Close of the command that found it, so nobody has
to carry it out of a cleared session by hand.

**Behaviour.**

* `/apply` reaches its Close with three findings its record names and this
  page did not ask for. Before it stages, it asks one question per finding.
  The person takes two of the three. Two entries are written under
  `## Found, not discussed`; the third is not written and is not asked again.
* `/propose` reaches its Close the same way, and its closing report names the
  entries it wrote beside the page and the mark.
* A command that found nothing asks nothing, writes nothing and says nothing
  about the block.
* The block does not exist in that queue yet: the command writes the heading
  itself, directly above `## Later, not scheduled`, and the opening prose
  above it, in one edit.
* The person's widget cannot hold every finding in one card: the command asks
  in as many cards as it takes, back to back at the Close, and writes nothing
  until the last one is answered.
* `/propose <name>` where `<name>` is only an entry: it stops in Read first,
  says the line is not ordered yet, names `/discuss <the idea>`, and writes
  no page, no mark and no graph.
* `/discuss <name of an entry>` starts from that entry instead of from a
  description, holds the conversation it always holds, writes the line where
  the milestone paragraphs place it, and removes the entry in the same edit.
* A target installed before this version has a queue with neither the block
  nor the prose: the first entry written there brings both.

**Contract.**

*The block.* One `## Found, not discussed` in `docs/06-Queue.md`, directly
above `## Later, not scheduled` and below every milestone, with one paragraph
of prose and one fenced block, the shape Later already has. The heading is
written only when the first entry arrives, never as an empty heading. The
queue's own opening prose gains one sentence naming it, and that sentence
lands in two ways: here and in the template it is part of this delivery,
because the queue this repository has is the one a person reads; in a target
installed before this version the command writes the prose and the heading
together with the first entry.

*The entry.* One per finding, inside that fence, carrying no mark, because a
mark is where a queue line stands. Six fields, in this order: the name, short
and lowercase and hyphenated, in the Slug's shape and not a Slug; what was
found; the file and line it stands at, when it has one; the date; the command
that found it; and the delivery it was found in, by slug and never by path,
when there is one, because `/apply` writes the entry after moving its page to
`work/done/` and a path would name a file that is no longer there. The name
sits in the first column, the scope in the second, aligned with the queue's
lines around it; the last continuation line carries the address, the date,
the command and the slug.

*The card.* One question per finding, all in one card, with two options each:
the finding enters the queue, or it does not. Asked at the Close and nowhere
earlier, so a build is never interrupted, and after every other file of the
Close is written. Where the host's widget cannot carry them all, the command
asks in as many cards as it takes, in sequence, and nothing is written until
the last is answered. The question and both options are conversation and not
document, so each carries the phrase the six texts of `/initialize` carry
(`docs/03-Domain.md`, As written). Nothing is written for a finding the
person did not take, and no finding is asked twice.

*Where the text lives.* Once, in `manuals/process.md` §The queue: the block,
the entry's six fields, the card, and the removal. `skills/propose/SKILL.md`,
`skills/apply/SKILL.md` and `skills/discuss/SKILL.md` cite that section by
heading and repeat none of it, the way they already do for the house rules
and the git strategy (`docs/01-Architecture.md` §4, third occurrence; the
first is the house rules).

*The three commands.* `/propose` gains a third stop case in Read first, a
name that is only an entry, answered the way a Later slug is; and a step in
Close, after the mark and before the closing report, whose report names the
entries. `/apply` gains a step in Close between marking the queue and
`git add -A`, so the edit is staged with the delivery. `/discuss` gains one
paragraph: an argument naming an entry is read as the idea's starting point,
and the entry is removed in the edit that writes the line. `/initialize`
gains nothing.

*The documents that give way.* `CLAUDE.md` Non-negotiables and its template's
same line, `docs/00-Product.md` under Putting a line in the queue, Defining a
delivery and Building it, `docs/05-Process.md` §2 and §8,
`manuals/process.md` §5 and §6, each with one sentence pointing at §The
queue, and in `docs/03-Domain.md` the rows Queue, Discuss, Propose, Apply and
As written plus the Queue entity's invariants: each gains the narrow
exception, that `/discuss` stays the owner of the queue's lines and the block
is the antechamber of a line. The `Found, not discussed` row of
`docs/03-Domain.md` is already there and moves in one clause alone, the one
reading "in one card with one item per finding", which becomes as many cards
as the host's widget holds. No new term.

*What does not change.* `bin/focus-kit` is untouched: no check reads a queue
line today and nothing here asks one to. The template
`skills/initialize/templates/docs/06-Queue.md` gains the block in its opening
prose alone, and no heading and no init comment, because the block arrives
with its first entry.

**Slice.** `docs/01-Architecture.md` §3 names no piece in this codebase, so
the page names none either. Kit-owned:
`skills/propose/SKILL.md`, `skills/apply/SKILL.md`,
`skills/discuss/SKILL.md`, `manuals/process.md`,
`skills/initialize/templates/docs/06-Queue.md` and
`skills/initialize/templates/CLAUDE.md`. Project-owned, this repository's own:
`CLAUDE.md`, `docs/00-Product.md`, `docs/03-Domain.md`,
`docs/05-Process.md`, `docs/06-Queue.md` and `docs/01-Architecture.md` §4.
Nothing merged and nothing appended once.

**States.** The defaults. `bin/focus-kit` prints no new line, because it is
not touched.

**Visual reference.** No UI. The block, as it stands in a queue that has two
entries:

````
## Found, not discussed

What a delivery found and did not build. Each entry is one finding, written
by /propose or /apply at its Close after the person said yes to it. It is
not a queue line and carries no mark: /discuss is what turns one into a
line, and it is the only way out of this block.

```
doctor-tells-a-guess       focus-kit doctor cannot tell a guessed document
                           from an answered one: seven documents with the
                           right headings come back green
                           bin/focus-kit:661, 2026-09-18, /apply,
                           in graph-builds-without-a-key
run-writes-past-the-seven  /initialize wrote pytest.ini, a .venv and a
                           work/ page it does not write
                           2026-09-18, /apply,
                           in graph-builds-without-a-key
```
````

The card, one question of it:

```
doctor-tells-a-guess reaches the queue?
  Yes, write it under Found, not discussed
  No, it does not enter
```

The closing report of `/propose` gains one line:

```
Written: work/<slug>.md; docs/06-Queue.md line marked [>]; docs/06-Queue.md
entries <name>, <name> under Found, not discussed (or: no finding).
```

**Out of scope.**

* The four findings still in `work/graph-builds-without-a-key.md`. That line
  is `[>]` in milestone 5 and this one is in milestone 3, so its own `/apply`
  runs after this ships and carries the card.
* `/initialize` writing an entry. No occurrence is recorded in it
  (`docs/00-Product.md`, product question 6).
* A `doctor` or `selftest` check over the block. Nothing in the CLI reads a
  queue line, and adding the first reader is its own delivery.
* An entry in this repository's own queue. The delivery builds the
  mechanism; the first entry here is written by the first command that finds
  something.
* Deduplicating an entry against a line or an entry that already says the
  same thing. One occurrence has not happened.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 included.
* [x] `manuals/process.md` §The queue carries the block, the six fields, the
      card and the removal, and no skill repeats them.
* [x] The three skills cite that section by heading and never by number.
* [x] `/propose` stops on a name that is only an entry, proven by a real run
      in a scratch repository (`docs/05-Process.md` §6).
* [x] `/apply` writes an entry before `git add -A`, proven by a real run in a
      scratch repository, with the card asked and one finding declined.
* [x] `/discuss` removes the entry it turned into a line, proven in the same
      scratch.
* [x] The heading and the prose are written by the first entry, proven in a
      scratch whose queue has neither.
* [x] `CLAUDE.md`, its template, `docs/00`, `docs/01` §4, `docs/03`,
      `docs/05` §2 and §8, `manuals/process.md` §5 and §6, `docs/06` and the
      queue template updated.
* [x] `docs/06-Queue.md` here and its template carry the opening sentence
      naming the block, with no heading and no entry.
* [x] `VERSION` bumped and `focus-kit install .` run here, the dogfood copy
      in sync (`docs/05-Process.md` §5).

---

## What happened

Built at **0.39.0**. Every file the Slice names was written, and one the page
did not: `manuals/process.md` §4, which is the divergence below.

**Where the text lives, and what points at it.** `manuals/process.md`
§The queue gained five blocks after the Later paragraphs: the block itself
and why it is neither the order nor Later; the heading arriving with the
first entry; the entry's six fields with one worked example; the card with
its question and its two options, carrying the As written phrase; and the
removal. `skills/propose/SKILL.md`, `skills/apply/SKILL.md` and
`skills/discuss/SKILL.md` each cite `docs/manuals/process.md` §The queue by
heading and carry the Named section instruction beside it, the way they
already do for §The git strategy. `docs/01-Architecture.md` §4 records it as
the third occurrence of that shape; the first is the house rules and the
second is the git strategy.

**The three commands.** `/propose` gained the third stop case in Read first
and a Close step before the closing report, whose report line now names the
entries. `/apply` gained Close step 5, between the mark and `git add -A`, and
the old steps 5 and 6 became 6 and 7. `/discuss` gained a paragraph in Read
first, one sentence in Write, and one line in its closing report.
`/initialize` gained nothing.

**What diverged from the plan.** Two things, both additions the page's lists
did not name and neither of them a change to the Contract.

1. **`manuals/process.md` §4 gained a pointer sentence.** The page names §5
   and §6 as the sections that give way, and §4 is where `/discuss` is
   described. `/discuss` gains behaviour in this delivery, so a reader of §4
   would otherwise learn nothing about taking an entry as a starting point.
   One sentence, pointing at §The queue, added under the placement
   paragraphs. Docs are living, and §4 owns that behaviour.
2. **`skills/discuss/SKILL.md` Write gained one sentence.** That section
   holds a closed list, "Nothing else is written ... No existing line is
   edited", and removing an entry is a write the list did not admit. One
   sentence names it and points back at Read first, so the list stays closed
   and true.
3. **`skills/discuss/SKILL.md` Close gained one line.** The page says
   `/discuss` gains one paragraph, and its closing report is a fixed block
   that lists every file the run wrote. A removal it did not name would be a
   report that lies, so the block carries `entry <name> removed from Found,
   not discussed (or: none)`, which is the same shape `/propose`'s report
   already took for the entries it writes.

**What the page left to the run.** The alignment of the entry's two columns.
The page says the scope column of the lines around it, and the three queues
involved disagree: this repository's is column 31, the template's is 26 and
the page's Visual reference is 28. The manual therefore says "the scope
column of the lines around it" and names no number, and the scratch's run
came out at 31, its queue's own. That is the right answer and the reason no
number was written down.

**What was dropped.** Nothing.

**Decisions taken.** One, and it is in the manual because the run would
otherwise have had to invent it: **what happens when `/discuss` removes the
last entry.** The Contract says the heading is never written empty, so the
removal of the last entry takes the heading, its paragraph and the fence with
it; the sentence in the queue's opening prose stays, because the next finding
brings the block back. A `/discuss` that ends in no line leaves the entry
where it is. No ADR: it is a detail of a mechanism ADR-0002 already covers,
and reversing it costs one paragraph.

## The proof

`docs/05-Process.md` §6 wants a real run for a change to a skill or a
template. Four were needed and one scratch carried all four, driven headless
with `claude -p` from this session, the way `proof-is-asked-without-a-screen`
and `git-strategy-is-asked` drove theirs.

**The scratch: kilnwatch**, a command line log for pottery kiln firings,
Python over SQLite, three `.py` files in `src/kilnwatch/` and one in
`tests/`, a `pyproject.toml`, a `README.md` and `notes/glazes.md` as prose,
one commit on `main` by one author, no branch and no remote. Its `docs/00` to
`06`, `CLAUDE.md` and one ADR were written by hand rather than by
`/initialize`, because the subject here is the other three commands and a
seventh run would have proven nothing about them. Its `docs/05` §6 reads
`**Tool.** None`, its §7 reads `**Strategy.** None`, and its `docs/06`
carried **neither the block nor the opening sentence**, which is the target
installed before this version. `git init` plus `focus-kit install` at
**0.39.0**; the installed `.claude/skills/apply/SKILL.md` was grepped first
and carried the new Close step, so the result is about the edit and not about
a stale copy. One delivery was waiting, `summary-shows-the-total`, marked
`[>]`, and two defects were planted next to its slice and kept out of its
Out of scope: no schema creation in `store.py`, and a `README.md` showing a
command line that does not exist.

`AskUserQuestion` does not exist in a headless session, the limit five
earlier records name, so every run put its cards in prose. What is measured
is the content and the moment, and prose carries both.

**Run A, `/apply summary-shows-the-total`, green.** The run built the
delivery, ran its verify command to 4 passed, wrote the record, moved the
page to `work/done/` and marked the line `[x]`. Then, and only then, it asked
about two findings the page did not ask for, one card in prose, the two
planted ones and nothing invented:

> `log-creates-its-table` reaches the queue?
> - **Yes, write it under Found, not discussed.** A entrada vai para
>   `docs/06-Queue.md` e espera um `/discuss`.
> - **No, it does not enter.** Nada é escrito, e o achado fica no que esta
>   execução registrou.

Two options each, the name in English as an identifier, the labels and their
descriptions in the conversation's language, which was Portuguese from this
machine's `~/.claude/CLAUDE.md`. Nothing was written for either finding
before the answer.

**Run A turn 2, one taken and one declined.** `log-creates-its-table` yes,
`readme-commands-do-not-run` no. What the queue received:

````
## Found, not discussed

What a delivery ran into and did not build. An entry carries no mark,
because it is not a line yet. `/discuss <name>` is the only way one leaves:
it writes the line where the milestone paragraphs place it and removes the
entry in the same edit.

```
log-creates-its-table          nothing in the repository creates the firings table: store.py only
                               inserts and selects, so the first add in a fresh checkout dies with
                               "no such table: firings" and the log has to be built by hand before
                               the program can be used at all
                               src/kilnwatch/store.py:14, 2026-09-19, /apply,
                               in summary-shows-the-total
```
````

Six fields in order, no mark, the name in the first column and the scope in
the second at that queue's own column, the address, the date, the command and
the slug on the last continuation line, the delivery named by slug and not by
path although its page had already moved to `work/done/`. The heading landed
directly above `## Later, not scheduled` and below the milestone, and the
opening prose gained its own sentence naming the block, in the same edit, in
the run's own words:

> "Found, not discussed" is neither: an entry there is what a delivery found
> and did not build, waiting for the `/discuss` that turns it into a line.

Nothing was written for the declined finding: it appears in
`work/done/summary-shows-the-total.md` and nowhere in the queue. `git status`
showed `M docs/06-Queue.md` staged with the rest of the delivery.

**One thing the headless method cost, and it is the method's.** In run A the
staging happened before the card was answered and again after, because a
prose card ends the turn and `claude -p` cannot wait inside one. In a session
with `AskUserQuestion` the call blocks and step 6 runs once, after step 5,
which is what the skill's numbering says. The edit reaching the index with
the delivery is what the Done when asks for, and it did.

**Run B, `/propose log-creates-its-table`, green.** It stopped in Read first:

> A linha não está ordenada ainda. [...] Uma entrada em "Found, not
> discussed" não é uma linha da fila [...] O que ordena a linha é
> `/discuss log-creates-its-table`. [...] Nada foi escrito, nenhuma marca
> mudou e o grafo não foi construído.

`work/` held only `done/` afterwards and `graphify-out/` held only `cache`,
so the stop cost neither a page nor a build, which is the same guarantee the
Later case already carries.

**Run C, `/discuss log-creates-its-table`, green.** It opened by reading the
entry back and citing the file and line it named, held the conversation it
always holds, amended the Milestone 1 paragraph on the person's answer, and
made one edit to the queue: the line written under the milestone, before
`summary-marks-incomplete`, and the entry gone. It was the last entry, so the
heading, its paragraph and the fence went with it and the opening sentence
stayed, which is the decision recorded above, taken by the manual and not by
the run. Its closing report named the removal on its own line.

**The scratch was removed.**

## Environments

| Environment | State |
|---|---|
| Kit source | 0.39.0, this commit |
| Dogfood copy | 0.39.0, `focus-kit install .` run here, check 6 green |
| Machine | the CLI is a symlink to the kit source and follows it |
| Target repositories | untouched; each moves when its owner runs `focus-kit update` |

Nothing to publish: the kit has no registry and no release artifact. A target
receives this version when its owner runs `focus-kit update <path>`.
