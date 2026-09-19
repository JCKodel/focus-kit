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

* [ ] `bin/focus-kit selftest` green, check 6 included.
* [ ] `manuals/process.md` §The queue carries the block, the six fields, the
      card and the removal, and no skill repeats them.
* [ ] The three skills cite that section by heading and never by number.
* [ ] `/propose` stops on a name that is only an entry, proven by a real run
      in a scratch repository (`docs/05-Process.md` §6).
* [ ] `/apply` writes an entry before `git add -A`, proven by a real run in a
      scratch repository, with the card asked and one finding declined.
* [ ] `/discuss` removes the entry it turned into a line, proven in the same
      scratch.
* [ ] The heading and the prose are written by the first entry, proven in a
      scratch whose queue has neither.
* [ ] `CLAUDE.md`, its template, `docs/00`, `docs/01` §4, `docs/03`,
      `docs/05` §2 and §8, `manuals/process.md` §5 and §6, `docs/06` and the
      queue template updated.
* [ ] `docs/06-Queue.md` here and its template carry the opening sentence
      naming the block, with no heading and no entry.
* [ ] `VERSION` bumped and `focus-kit install .` run here, the dogfood copy
      in sync (`docs/05-Process.md` §5).
