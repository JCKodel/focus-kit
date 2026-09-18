# update-survives-a-moved-section

**Goal.** Someone running `focus-kit doctor` in a target is told which of
that repository's own documents cite a section of a kit-owned manual at an
address the next `focus-kit update` can change under them.

**Behaviour.**

* A project-owned document citing a manual by number, `docs/manuals/process.md`
  §6, gets one warn naming the file, the line and the hand edit. A number is
  not a stable address: a section inserted in a manual renumbers every one
  below it, and the citation goes on pointing at a number that now means
  something else. That is what `discuss-adds-queue-line` (`9f09c7e`) did here
  by inserting `## 4.` into `manuals/process.md`.
* A project-owned document citing a manual by a heading the manual as shipped
  does not have gets one warn naming the file, the line and the hand edit.
  That is the heading renamed or removed.
* One warn per citation, so a target several versions behind sees every line
  it has to fix rather than a count.
* A target whose every manual citation is by a heading the manual has gets one
  green line, and so does a target that cites no manual at all, `/initialize`
  never having run in it: nothing there points at a section that can move.
* The fix is always a hand edit. The CLI never writes a project-owned file,
  and what the citation meant is only in the document.
* The comparison is against the manual the kit ships now, not against the copy
  in the target, because what the warn is about is what the next `update`
  writes.
* `install`, `update` and `copy_tree` write exactly what they write today. A
  kit-owned file is still overwritten, and `doctor` reports and changes
  nothing.

**Contract.**

* `bin/focus-kit`, `doctor`: one pass over the documents a target reads again
  and again, `CLAUDE.md`, `docs/00` to `06` and every file under `docs/adr/`.
  It sits after the Drift pass and before the version and the Unbumped change,
  so what the kit owns stays in one block and the target's own documents come
  after it.
* `work/` is not read, in flight or done. A delivery page is read by the one
  session that builds it, and a Done page is a record of what was: correcting
  a record falsifies it, and this repository alone holds thirteen of them
  citing sections that have moved since.
* The manuals it knows are the ones the kit ships, read from `KIT_DIR` as
  `manuals/*.md` the way every other read of the kit's own files is, so a
  fourth manual is a file and no edit here.
* **What a manual citation is.** The text `manuals/<name>.md` for a manual the
  kit ships, followed by a `§` with nothing between the two but backticks and
  spaces. `manuals/` is part of the key: a target's own `docs/05-Process.md`
  is a file name away from `process.md`, and every citation the kit and its
  targets write carries the folder. By number when what follows the `§` is a
  digit; by heading otherwise, and the heading then runs from the `§` to the
  end of the line.
* **A heading is normalized, then matched as a prefix.** A heading of a manual
  is normalized by removing its `N. ` numbering and cutting it at the first
  comma or opening parenthesis, so `## 5. Errors are values (ch. 8)` gives
  `Errors are values` and `## 6. Vertical slices, DRY, YAGNI, KISS, CQS` gives
  `Vertical slices`. A citation by heading is current when some normalized
  heading of that manual is a prefix of the text after the `§`. A prefix and
  not a whole line, because a citation ends inside the sentence around it and
  no delimiter says where: `§Ensuring the graph` is followed by a comma in one
  document, by a full stop in another and by a table pipe in
  `docs/03-Domain.md`. The normalization is what lets a person cite the
  heading in the words the sentence needs instead of pasting a chapter number
  from the book.
* The three lines, exact:
  * `<path>:<line> cites docs/manuals/<name>.md by number: "§<the rest of the
    line>" (cite the heading by hand; a section added to that manual renumbers
    the ones below it)`
  * `<path>:<line> cites a section docs/manuals/<name>.md does not have:
    "§<the rest of the line>" (fix the citation by hand; the heading moved or
    was renamed)`
  * `project-owned documents (every manual citation by heading, every heading
    there)`, the green one, printed when neither warn did.
  Each warn names its fix (`docs/04-Conventions.md` §1), and both fixes are a
  hand edit because the category forbids the other kind.
* Reading a project-owned file is new and is not what
  `docs/adr/ADR-0002-file-ownership.md` forbids, which is an edit from the
  CLI. `docs/01-Architecture.md` §5, **Touch a project-owned file**, stops
  saying the single read is the one that picks a closing message and names the
  second.
* `docs/05-Process.md` §4, check 2: the green line joins the expected output
  of the normal run, and one probe on the scratch, restored byte for byte
  because check 3 installs into the same scratch. The probe writes one
  project-owned document carrying a citation by number and a citation by a
  heading no manual has, and one `doctor` run must carry both warns and not
  the green line; the document is then rewritten with one citation by a
  heading a manual has, and a second run must carry the green line. Then it is
  removed.
* `docs/00-Product.md`: open decision 5 leaves the list, 1 to 4 keeping their
  numbers, because the answer is taken here and lives in the ADR. Nothing else
  in that document changes.
* `docs/adr/ADR-0002-file-ownership.md`: a dated paragraph in the shape of the
  `mcp-leaves-the-baseline` one already inside Decision, saying that a
  kit-owned file may change shape, that `update` goes on overwriting, that
  `doctor` names the citations the change can invalidate and that a person
  fixes them. **Revisit when** is rewritten to what is still open, and the
  2026-09-15 text is not otherwise touched.
* `docs/03-Domain.md`: the **Manual citation** row, written by this
  `/propose`, the state `doctor` names beside Drift and Leftover.
* `docs/01-Architecture.md`: the `doctor` row of §3 gains the pass, and the §5
  row above.
* **This repository's own citations.** Every manual citation in this
  repository's project-owned documents becomes a citation by heading, and a
  bare `§<number>` later in the same sentence goes with it. They are in
  `docs/01`, `docs/03`, `docs/04`, `docs/06`, `ADR-0003` and `ADR-0006`, and
  the pass itself is what finds them. `ADR-0006` is the one that is wrong
  today: it names the house rules as §6 of `manuals/process.md`, and they are
  §7 since `9f09c7e`.
* A sentence that explains the defect keeps the number away from the file
  name, the way the line above does, so the prose of `docs/03-Domain.md` and
  of the `ADR-0002` amendment does not report itself.
* `skills/initialize/templates/docs/01-Architecture.md`: its one citation by
  number is converted the same way, so `/initialize` stops seeding into a
  target's `docs/01` the defect this pass reports. No other template and no
  skill is touched.
* The manuals keep their numbered headings. Unnumbering them is a change to
  every file that cites them, and the conversion above is what makes it
  unnecessary.
* `VERSION` is bumped: the CLI's behaviour changes and one template changes,
  and a target would want both.
* Independent of `work/an-old-target-gets-the-fragment.md`, whose pass sits
  between the Leftover and the Drift passes where this one sits after the
  Drift pass, and of `work/skill-says-it-is-kit-owned.md`. The three land in
  either order: each adds one row to `docs/03-Domain.md` and turns its own
  mark in `docs/06-Queue.md`, and this tree already holds the other two.

**Slice.** `bin/focus-kit`, the whole CLI, plus one template and this
repository's own docs (`docs/01-Architecture.md` §3, Structure, one file; §4).
No View, Orchestrator, Use case or Repository: §3 says none of the four exists
here. The graph named `bin/focus-kit` and nothing else for `copy_tree`, both
ways, and nothing in what it copies changes. Kit-owned: `bin/focus-kit` and
`skills/initialize/templates/docs/01-Architecture.md`. Project-owned: the
documents the pass reads in a target, and here `docs/00`, `docs/01`, `docs/03`,
`docs/04`, `docs/05`, `docs/06`, `ADR-0002`, `ADR-0003` and `ADR-0006`.

**States.**

* Target whose every citation is by a current heading, and target where
  `/initialize` never ran: the green line, nothing else.
* Target whose documents were written before a manual gained a section: one
  warn per citation by number.
* Target citing a heading the manual no longer has: one warn per citation.
* Target whose `docs/manuals/` is missing or stale: the pass is unaffected,
  because it reads the manuals from `KIT_DIR`, and the presence lines above
  already say the copy is gone.
* A citation inside a comment, a code block or a quotation: reported like any
  other. The pass reads lines, not markdown.
* `install` and `update`: unchanged output, at the new version.

**Visual reference.** No UI. `focus-kit doctor` in a target whose documents
were written before `discuss-adds-queue-line` and one of whose citations named
a heading a later manual renamed, the new pass only, in the `warn` and `ok`
shapes of `bin/focus-kit:46`. The first line is real in this repository today;
the second is the shape, with an invented path, because no heading has been
renamed yet:

```
  ! docs/adr/ADR-0006-focus-is-asked-not-imposed.md:10 cites docs/manuals/process.md by number: "§6 listed" (cite the heading by hand; a section added to that manual renumbers the ones below it)
  ! docs/01-Architecture.md:41 cites a section docs/manuals/process.md does not have: "§The house rules, in one place." (fix the citation by hand; the heading moved or was renamed)
```

and in a current one:

```
  ✓ project-owned documents (every manual citation by heading, every heading there)
```

**Out of scope.**

* A citation between two project-owned documents: `update` never touches
  either, and only a commit in the target moves them.
* The thirteen Done pages of this repository that cite a section that has
  moved: a Done page records what was decided and read at the time, and a
  corrected record is no longer one.
* A citation inside a kit-owned file, a `SKILL.md` naming a section of a
  manual included: `update` replaces the citing file and the cited manual in
  the same run, so neither can go stale against the other.
* A migration notion, a kit-owned notes file `update` prints for the versions
  crossed: the answer taken in this page's conversation. It is a file every
  future delivery has to edit, against `docs/00-Product.md` product question
  2.
* `update` or `install` fixing a citation: the category forbids it, and what
  the citation meant is only in the sentence around it.
* Unnumbering the headings of the three manuals: a change to every file that
  cites them, and a `/discuss` line if it is ever wanted.
* An old target whose `docs/05-Process.md` §7 carries no `**Strategy.**` line,
  the mirror case where the kit gave a project-owned slot a shape later:
  `/initialize`'s review run already asks for it (`docs/03-Domain.md`, Git
  strategy).
* `an-old-target-gets-the-fragment` and `skill-says-it-is-kit-owned`: the
  other two lines of this milestone, each a different mechanism.

**Done when.**

* [x] `bin/focus-kit selftest` is green, six checks, with check 2 carrying the
  green line and the probe.
* [x] `focus-kit doctor` here prints the green line and no citation warn.
* [x] `focus-kit doctor` in a scratch repository holding a project-owned
  document that cites a manual by number names that line, and the transcript
  goes into `work/done/update-survives-a-moved-section.md`
  (`docs/05-Process.md` §6).
* [x] `docs/00-Product.md`, `docs/01-Architecture.md`, `docs/03-Domain.md` and
  `docs/adr/ADR-0002-file-ownership.md` carry what the Contract names, the
  **Manual citation** row and the dated amendment included.
* [x] Every manual citation in this repository's project-owned documents is by
  heading, `ADR-0006` included, and so is the one in
  `skills/initialize/templates/docs/01-Architecture.md`.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy is at the same number (`docs/05-Process.md` §5).

---

## What happened, 2026-09-18

Built as the page defines it, with four divergences and one thing the page
could not have known.

**The position in `doctor`.** The Contract asks for a pass "after the Drift
pass and before the version and the Unbumped change", and the two cannot both
hold: the version and the Unbumped change sit at `bin/focus-kit:413` in the
source the page was written against, before the presence loops, and Drift ends
at 609. The rationale in the same sentence, "what the kit owns stays in one
block and the target's own documents come after it", and the Independent
bullet, "this one sits after the Drift pass", both point the same way, and the
question was put to the person, who took that answer. The pass is the last
thing `doctor` does before the graph and the hook lines.

**A citation the line wrap cuts.** The rule that a heading runs from the `§` to
the end of the line makes a wrapped citation a defect, and the pass found two
of them in this repository on its first run: `docs/01-Architecture.md`, which
ended a line at `§The` and carried `git strategy` to the next, and
`docs/05-Process.md`, which ended at `§The git`. Neither was reported by the
page's Behaviour, which names only the number and the renamed heading. Both
were rewrapped so the whole heading sits on the line the file name is on, and
`docs/03-Domain.md` gained a sentence saying what the pass does with each half
of the case: a heading the wrap cuts gets the second warn, and a file name and
`§` on either side of the wrap are not a citation at all. Every conversion made
here was rewrapped with that constraint in mind, which is why several
paragraphs moved more than the citation did.

**The Visual reference's second line is not reachable.** It shows
`"§The house rules, in one place."` as the shape of the heading warn, and
`The house rules` is a prefix of that text, so the pass calls it current. The
probe in check 2 uses `§A heading no manual ships.` instead. The first line of
the reference is real and was printed verbatim by the first run.

**One more helper than the Contract named.** The heading comparison is
`cites_a_heading` (`bin/focus-kit:402`), one caller, so the normalization lives
in one place rather than nested three loops deep inside `doctor`.
`docs/01-Architecture.md` §3 counts twelve helpers now and carries its row, and
`without_cr` has six callers rather than five, in the code comment and in the
table both.

**Line numbers.** The two insertions moved everything below them, so the Line
column of §3, the dispatch (`bin/focus-kit:1286`), the `awk` of `--help`
(`:1298`), the `docs/00-Product.md` read (`:362`) and the `uv` warn (`:424`)
were refreshed in `docs/00`, `docs/01` and `docs/04`. References that were
already stale before this delivery were left alone: `ADR-0001` (`:35`,
`:117`), `ADR-0002` (`:111`, `:117`, `:196`), `docs/03-Domain.md` (`:337`,
`:292`, `:114`) and `docs/01-Architecture.md` §6 (`:193`, which is `copy_tree`
and means `merge_json`). Fixing them is a queue line, not this delivery.

**Two documents the page did not name.** `docs/03-Domain.md`'s **Project-owned**
row and `ADR-0002`'s Project-owned bullet both said the CLI's one interaction
with the category is the `docs/00-Product.md` test, which the pass makes false.
The row was rewritten; the bullet is 2026-09-15 text the page forbids touching,
so the dated amendment says which word of it is superseded, the way the
`mcp-leaves-the-baseline` amendment does for its own bullet.

**Decisions.** Open decision 5 of `docs/00-Product.md` left the list; the
answer is the dated `2026-09-18` paragraph in
`docs/adr/ADR-0002-file-ownership.md`, which says that a kit-owned file may
change shape, that `update` goes on overwriting, that `doctor` names the
citations the change can invalidate and that a person fixes them. **Revisit
when** was rewritten to what is still open: a target that needs something of
the kit's changed in place rather than reported. No new ADR.

**The conversions.** Thirteen citations, all found by the pass itself:
`docs/01-Architecture.md` (six), `docs/03-Domain.md`, `docs/04-Conventions.md`,
`docs/05-Process.md`, `docs/06-Queue.md` (two), `ADR-0003` and `ADR-0006`, plus
the one in `skills/initialize/templates/docs/01-Architecture.md`. `ADR-0006`
was the one that was wrong: it named the house rules as `§6`, which has been
`/apply <slug>` since `9f09c7e`, and the bare `§6` later in the same paragraph
went with it. `docs/03-Domain.md` now cites `§`/apply <slug>``, backticks
included, because that is the normalized heading and the match is a prefix of
it.

**The proof.** `bin/focus-kit selftest`, six green. `focus-kit doctor .` here
prints the green line and no citation warn. And one run in a scratch
repository, `focus-kit install` into a `mktemp -d` with `git init`, then a
`docs/01-Architecture.md` of three citations written into it by hand, one by
number, one by a heading no manual has and one current:

```
  ✓ docs/01-Architecture.md
  ! docs/01-Architecture.md:3 cites docs/manuals/focus.md by number: "§5 says." (cite the heading by hand; a section added to that manual renumbers the ones below it)
  ! docs/01-Architecture.md:4 cites a section docs/manuals/process.md does not have: "§Rules of the house." (fix the citation by hand; the heading moved or was renamed)
```

The third citation printed nothing, which is the point, and the green line
stood down because two warns printed. The scratch was removed.

The whole verify command was run again under `/bin/bash`, 3.2.57 on this
machine, so the bash 3.2 claim covers the parameter expansions and the nested
herestrings this delivery added rather than assuming them from a newer shell
on PATH.

What was not proven by a run: the template. `docs/05-Process.md` §6 asks for a
real `/initialize` for a change to one, and the change here is inside an
`<!-- init: ... -->` comment the command removes, so a run would show nothing
that a run before it did not. Check 2 proves the copy, and the pass proves the
citation.

**Nothing was dropped.** `work/` is not read, the thirteen Done pages are
untouched, `install` and `update` write exactly what they wrote, and no skill
other than the one template was edited.

**Environments.** Kit source at 0.27.0. Dogfood copy at 0.27.0, `focus-kit
install .` run here, check 6 green. Machine: the CLI is a symlink and follows
the source. Target repositories are untouched and move when their owner runs
`focus-kit update`.

**One thing found on the way, for the queue.** Another session was editing
`docs/03-Domain.md` and `docs/06-Queue.md` in this working tree while this
delivery ran, adding the `copilot-port` rows and queue lines. Nothing
collided, because every edit here was made against an exact string, and the
`git add -A` at the end stages that other work too. That is the cost
`docs/05-Process.md` §7 already names for the git strategy being none.
