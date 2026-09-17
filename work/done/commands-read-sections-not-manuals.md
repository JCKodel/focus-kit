# commands-read-sections-not-manuals

**Goal.** A command reads of a manual the Named section it needs and nothing
else, so a session pays for the rule it uses and not for the manual around
it. Measured over 194 sessions (`docs/06-Queue.md`, this line): the kit costs
no more per session than the hand-written original it came from, and what
every session pays for nothing is a manual read whole for one section,
`graphify.md` (2,626 words) for §Ensuring the graph in all three commands and
`focus.md` (5,152) in every `/apply`. The three skills already name
§Ensuring the graph; none says to read it alone, and a file is read whole
unless the reader is told where to stop.

**Behaviour.**

* `/propose`, `/apply` and `/initialize`, where they send the session to
  `docs/manuals/graphify.md` §Ensuring the graph, say to read that section
  alone: from its heading to the next heading of the same level, nothing
  else of the manual. The procedure stays written there and nowhere else.
* `/apply` names the sections of `docs/manuals/focus.md` it reads at Read
  first: §2, the canonical responsibility table; §3, the four pieces; §10,
  the anti-patterns. Build keeps naming §8 Testing where it already does, read
  the same way when Build reaches it. Nothing else of the manual is read.
* A real run of each command shows the manual read covering the named
  section and no other, and the record quotes the range each read covered.
* The record holds, per command, the words of manual text Read first
  instructs to read, before and after: `wc -w` over the whole manual before,
  over the named sections after, on the kit's sources at the delivery's
  commit. Words and not tokens: the words are what the kit controls and what
  a file pins; a transcript's tokens are the person's session (asked
  2026-09-17).
* `docs/00-Product.md`, Positioning, holds the number, so the next comparison
  with another process is measured and not feared.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Three skills and one manual kit-owned; a target receives them
on `update`. No manual heading changes: the skills now hang on them
(`docs/03-Domain.md`, Named section).

* `skills/propose/SKILL.md`, Read first: the sentence that sends the session
  to §Ensuring the graph gains the reading rule, that section alone, from its
  heading to the next heading of the same level, nothing else of the manual.
* `skills/apply/SKILL.md`, Read first item 4: names §2, §3 and §10 of
  `docs/manuals/focus.md`, read the same way, nothing else of the manual;
  item 5: §Ensuring the graph, the same rule. Build: §Testing stays named,
  and the same rule applies to it. The Prove and Close sections do not change.
* `skills/initialize/SKILL.md`: both places that name §Ensuring the graph gain
  the rule. "Read both first", for `process.md` and `focus.md`, stays as it is.
* The reading rule is one sentence, the same words in the three skills, so one
  `grep` finds every occurrence (`docs/01-Architecture.md` §4: each skill
  repeats what it needs). Its wording, and how it tells the session where a
  section ends, is the run's to settle and to prove by a real run; the page
  holds what must hold, that the read covers the section and no more.
* `manuals/process.md` §5 item 1: "the FOCUS manual" becomes the manual's
  table, four pieces and anti-patterns, one clause.
* `docs/03-Domain.md`: the Named section row, written by this page
  (`every-term-enters-03-first`).
* `docs/00-Product.md`, Positioning: one paragraph, what it costs, holding the
  measured figures the queue line carries (first turn 42k to 49k tokens in the
  project the kit came from, here and in the first target alike; a kit
  `/apply` at 105 turns to a 240k peak against 280 turns and 530k there) as
  measured before this delivery, and the per-command words after it, as the
  run measures them. It says where the figures came from and does not
  reconstruct a method this repository does not hold.
* `VERSION`: one minor above what the file holds, `0.20.0` when it reads
  `0.19.0`; its own apply reads the file.
* This repository: `docs/06-Queue.md` line `[x]`.

**Slice.** `skills/propose/SKILL.md`, `skills/apply/SKILL.md`,
`skills/initialize/SKILL.md` and `manuals/process.md`, kit-owned; this
repository's `docs/`, project-owned. `graph: explain "manuals/graphify.md"
named 1 node, affected named 0; explain "manuals/focus.md" named 3, affected
named 4, the four templates that reference it, which do not change; explain
"skills/propose/SKILL.md" named 5 sections, affected named 0`. Nothing in
`bin/focus-kit`, `manuals/graphify.md`, `manuals/focus.md`, the templates or
`config/`, so no function row of `docs/01` §3 changes. No FOCUS pieces
(ADR-0003).

**States.** The CLI prints nothing new. No command gains a fixed line: what
changes is how far into a manual a session reads.

**Visual reference.** No UI. The record's table, before filled from `wc -w`
on the sources at this commit, after the run's:

```
command      manual        before (words)   after (words)
/propose     graphify.md   2,626            §Ensuring the graph
/apply       graphify.md   2,626            §Ensuring the graph
/apply       focus.md      5,152            §2, §3, §10 at Read first; §8 at Build
/initialize  graphify.md   2,626            §Ensuring the graph
```

**Out of scope.**

* `/initialize` reading `process.md` and `focus.md` whole: it runs once per
  repository and uses most of both to write `docs/01` and the process (asked
  2026-09-17).
* Trimming `skills/propose/SKILL.md`, 67 words at the start and 1,044 today:
  the queue line names what enters, and every paragraph came from a queue
  line of its own.
* Splitting a manual into one file per section: §Ensuring the graph is written
  in one place, and a new kit-owned file is a contract change for every target
  (manifest, `doctor`, `.graphifyignore`).
* A `selftest` check that a section a skill names exists in its manual:
  `docs/00`, product question 6; no heading has moved under a skill yet, and
  the day one does is the concrete error that earns it.
* Tokens from transcripts as the measure: noisy and costly to gather, and not
  what the kit controls (asked 2026-09-17).
* Which pieces a slice has, and what `/apply` reads of `focus.md` once that is
  a table in `docs/01` §3: `focus-is-asked-not-imposed`, the next line.
* An ADR: reversing this is deleting one sentence from three skills
  (`docs/03`, ADR).

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what the file holds; `focus-kit install .` run here last.
* [x] One `grep -n` for the reading rule's sentence prints the three skills,
  five places: `/propose` once, `/apply` twice, `/initialize` twice.
* [x] Proof, in the first target (`docs/05` §5, a row while milestone 2 is
  open): `focus-kit update ~/Downloads/vaulted`, then, each in a clean
  session with the stakeholder answering as the owner would, `/propose` on a
  `[ ]` line of its queue, `/apply` on the page that run wrote, watched
  through Read first and stopped before Build, and `/initialize`, a review
  run there since `docs/00` exists, watched through §Ensuring the graph and
  stopped. Green is every read of a manual covering the named section and
  no other, and the record quotes the range each read covered. Red is a
  queue line, never an edit of this page. `git reset` there, the page
  deleted, nothing committed. What the run produced wins over this page.
* [x] The record holds the before and after table, per command, in words.
* [x] The `docs/00` Positioning paragraph; the `manuals/process.md` §5 clause;
  the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## Record

**The sentence the run settled on.** The page left the wording, and how it
tells the session where a section ends, to the run. It is one sentence,
identical in the five places, and it names the mechanic rather than only the
boundary, because a session with no line numbers has no way to read a range
and reads the file whole:

```
Read the named section alone: one `grep -n '^#'` over the manual gives its
heading's line and the next heading of the same level, and you read that
range and nothing else of the manual.
```

It starts at the beginning of a line in all five places, indented by three
spaces in the two `/apply` items and flush left in the other three, so its
first fragment is never broken by the 76 character wrap and one `grep -n
"Read the named section alone" skills/*/SKILL.md` prints exactly five lines:
`skills/apply/SKILL.md:29` and `:34`, `skills/propose/SKILL.md:20`,
`skills/initialize/SKILL.md:120` and `:192`. Build's `§8 Testing` carries a
back reference, `read the way item 4 of Read first says`, and deliberately
not the sentence, which would have made the grep print six.

**Before and after, per command, in words.** `wc -w` over the whole manual
before, over the named sections after, on the kit's sources at this commit:

```
command      manual        before   after   what is read after
/propose     graphify.md   2,626    1,352   §Ensuring the graph
/apply       graphify.md   2,626    1,352   §Ensuring the graph
/apply       focus.md      5,152    1,870   §2 176, §3 1,167, §10 241 at Read
                                            first (1,584); §8 286 at Build
/initialize  graphify.md   2,626    1,352   §Ensuring the graph, both places
```

The two before figures are the ones the page carries, measured again here and
unchanged. Each command drops 1,274 words of `graphify.md`; `/apply` drops a
further 3,282 of `focus.md`, so a session of it stops paying for 4,556 words
it never used.

**What diverged.** Nothing in the contract. Three things the page did not
say, settled by the run:

* `/apply` item 4 now names the three sections the way Behaviour words them,
  number plus meaning, rather than keeping the old "the four pieces and the
  review rules" and appending numbers. All four named sections of `focus.md`
  are `##`, so "the next heading of the same level" correctly carries §3's
  four `###` subsections along with it.
* `manuals/process.md` §5 item 1 became "and, of the FOCUS manual, its table,
  its four pieces and its anti-patterns", one clause, which needed the item
  to wrap onto a third line.
* This session's own reading. It read `graphify.md` §Ensuring the graph by
  range, lines 58 to 185, which is the behaviour the delivery ships, and it
  read no section of `focus.md` at all, only its heading list, because the
  delivery changes text and adds no code to review against the table. That is
  a divergence from the skill this session was running, 0.19.0, and it is
  recorded rather than hidden.

**What the graph answered.** `graph: explain "skills/apply/SKILL.md" named 4
sections, affected named 0; explain "skills/propose/SKILL.md" named 5,
affected 0; explain "skills/initialize/SKILL.md" named 8, affected 0; explain
"manuals/graphify.md" named 1, affected 0; explain "manuals/focus.md" named
3, affected 4, the four templates that reference it, which do not change;
explain "manuals/process.md" named 1, affected 0`. The page's Slice said the
same, so nothing widened.

**Nothing was dropped**, and no ADR was written: reversing this is deleting
one sentence from three skills (`docs/03-Domain.md`, ADR).

**The proof, in the first target, at 0.20.0.** `focus-kit update
~/Downloads/vaulted` first, then three clean sessions, the stakeholder
answering as the owner: `/propose license-or-claim`, `/apply
license-or-claim` on the page that run wrote, and `/initialize` as a review
run. The ranges below are the tool calls the session transcripts hold, not a
reading of the screen, because what the terminal shows is collapsed and the
range is the whole claim. Every one of them is preceded by the `grep -n '^#'`
the sentence names, which is the mechanic landing.

```
run          call                                        lines      words
/propose     grep -n '^#' docs/manuals/graphify.md         -           -
             Read graphify.md offset=58 limit=128        58-185     1,352
/apply       grep -n '^#' focus.md; grep -n '^#' graphify  -           -
             Read focus.md offset=12 limit=20            12-31        181
             Read focus.md offset=30 limit=50            30-79      1,172
             Read focus.md offset=177 limit=14          177-190       252
             Read graphify.md offset=58 limit=128        58-185     1,352
/initialize  Read process.md, whole                     1-end        out
             Read focus.md, whole                       1-end        of
             grep -n '^#' docs/manuals/graphify.md         -        scope
             Read graphify.md offset=58 limit=130        58-187     1,358
```

**Green, with the overrun named.** §Ensuring the graph is lines 58 to 185 and
the next `##` is 186; §2 is 12 to 29 with §3 at 30; §3 is 30 to 78 with §4 at
79; §10 is 177 to 189 with §11 at 190. So `/propose` and `/apply` read
§Ensuring the graph exactly, and the other four reads each carry the next
heading's own line, and in one case the blank after it: 21 words in `/apply`,
6 in `/initialize`. No read reached another section's body, which is what the
page asked. The `limit` is a count and the heading is the cheapest way to see
that a range ended where it should, so the overrun is recorded and not
treated as a defect.

No read of `focus.md` §8 happened, and that is correct: the delivery `/apply`
ran there added a `LICENSE` and an ADR, no code, so Build wrote no test and
never reached the bullet that names §8. `/initialize` read `process.md` and
`focus.md` whole, which this page put out of scope, and reached only the
first of its two §Ensuring the graph places, because the repository is
brownfield and the second sits in the greenfield path.

**Two things about the proof that did not go as the page wrote them.**

* **The runs were not stopped.** The page said to watch `/apply` through Read
  first and stop before Build, and `/initialize` through §Ensuring the graph
  and stop. Both ran to the end instead. That cost nothing in evidence,
  because every read of a manual happens in Read first and the transcripts
  hold all of them, and it cost the target a full delivery and a review pass,
  which is what the cleanup below had to undo.
* **The ranges were read off the transcripts, not off the screen.** What the
  terminal prints is collapsed (`read 7 files`), and the range is the whole
  claim, so it was taken from the session files under
  `~/.claude/projects/-Users-jckodel-Downloads-vaulted/`, where each `Read`
  carries its `offset` and `limit`. That is the measurement this page wanted
  and the only place it exists.

**The cleanup, and a contradiction the page lost.** This page's Done when
says `git reset` there and the page deleted; `docs/05-Process.md` §5 says
`git reset` and then "leaving the working tree as the last run left it". They
disagree, and with the runs having gone to the end the disagreement was
expensive: what "the page deleted" now covered was a `LICENSE`, an ADR, a
finished delivery page and edits in seven documents of someone else's clone,
all untracked, none of it recoverable by git. Asked rather than resolved
alone, and the stakeholder chose the page: delete everything the three runs
produced. Done by reversing each of the 36 `Edit` calls of the three
transcripts in reverse order, which is byte exact, plus `sed` in reverse on
the one `sed -i` and `rm` on the four created files, after a tar of the whole
untracked tree into this session's scratchpad. The target is back to the
state the earlier `/initialize` left it in: the same `M .gitignore` and the
same thirteen untracked entries, `[ ] license-or-claim` with its original
wording, `work/done/` empty, `work/testing-setup.md` back at ADR-0006.
Nothing staged, nothing committed there, and it sits at 0.20.0.

`docs/05-Process.md` §5 is not changed by this delivery: the two clauses
agree whenever `/apply` is stopped where the page says, and the next page
that asks for a run in the first target is where the sharper wording belongs,
not here.

**The before picture, in the same target.** Three sessions there before
0.20.0 reached it show what the sentence replaced: `grep -n "Ensuring the
graph" -A 40 docs/manuals/graphify.md` followed by `sed -n '98,160p'`, which
reads a fixed 40 lines and then guesses where to continue, on 2026-09-17 at
19:26Z and again at 19:59Z with the target stamped 0.19.0; and `sed -n
'1,80p'` on 2026-09-16 at 21:43Z, 763 words that cover four sections and stop
inside the fifth, on whatever version the target carried that day, which this
delivery did not read. Neither is the section, and both are what a reader
does when nothing told it where the section ends.

**Environments.** Kit source at 0.20.0; dogfood copy at 0.20.0 through
`focus-kit install .`, check 6 of the verify command empty; the machine's CLI
is a symlink and followed on its own; the first target at 0.20.0 through
`focus-kit update ~/Downloads/vaulted`, nothing committed there. Everyone
else's repositories are untouched and move when their owner runs `focus-kit
update`.
