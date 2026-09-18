# every-paragraph-admits-its-lines

**Goal.** A person placing a new line against a Milestone paragraph of
`docs/06-Queue.md` gets the same answer the queue already gives, because
every paragraph says what actually closes its Milestone and admits the
lines already under it.

**Behaviour.**

* Every Milestone paragraph is read against the lines under its own
  heading. A paragraph passes when every line under it is admitted by
  something the paragraph says, and when the paragraph names no Slug that
  stands under another heading.
* Milestone 1's paragraph fails on two counts and both are fixed. It names
  "the queue's front door" as one of three exceptions, and that line,
  `discuss-adds-queue-line`, stands under Milestone 3. And its "most of the
  lines below are defects it reports rather than fixes" does not hold:
  `kit-selftest` is the command itself, `doctor-reports-drift` and
  `graphify-mcp-starts` add checks rather than fix what one reported, and
  `windows-git-bash` is a platform port.
* Milestone 2's paragraph fails on one. "Every piece of friction found on
  the way brought back here as a queue line" admits any friction line at
  all, including one found long after the Milestone closed.
* Milestones 3, 4 and 5 are expected to pass. One that does not is rewritten
  under the same test, and the Done page says which paragraphs changed.
* After the delivery, a friction line found in a Scratch repository today is
  admitted by neither closed paragraph, so `/discuss` cannot place it under
  a Milestone that is already done.

**Contract.** Nothing a Target repository receives changes: no Command, no
Manual, no Template, no `config/` fragment and no line of `bin/focus-kit`.
What is exact here is the test and the two claims.

*The test*, applied to every Milestone paragraph:

1. Every line under the heading is admitted by something the paragraph
   says.
2. The paragraph names no Slug that stands under another heading.
3. What the paragraph says closes the Milestone is what the lines under it
   deliver, so a line the paragraph admits and the Milestone does not hold
   would belong there.

*Milestone 1's claim.* The Milestone closes when one command says whether a
Target repository would still receive a working kit. Its lines are that
command, the defects found building and running it, and the friction the
process itself produced that no check would catch. It names no Slug that
stands under another heading, so "the queue's front door" goes, and the
count of exceptions is whatever applying the test to the twelve lines
yields rather than a number the paragraph carries forward.

*Milestone 2's claim.* The Milestone closes when the kit has been through
one full cycle on a repository that is not itself, installed, initialized,
one Delivery proposed and applied end to end, plus the friction that running
the kit outside this repository surfaced: the First target, and the Scratch
repositories that proved this Milestone's own deliveries. The standing
clause "every piece of friction found on the way" goes, because it is what
admits a line the Milestone never held.

No Mark changes except this Delivery's own, no line moves between headings,
and the order of the lines inside a heading is untouched.

**Slice.** This repository's own `docs/06-Queue.md`, and nothing else.
Project-owned: the CLI never writes it (`docs/03-Domain.md`,
Project-owned). `docs/01-Architecture.md` §3 says this codebase has none of
the four pieces, so no piece is named. The graph was asked and named one
node, the document itself, with nothing affected.

**States.** The defaults. No message of `bin/focus-kit` changes.

**Visual reference.** No UI, and no line of terminal output changes.

**Out of scope.**

* A mechanism that catches a paragraph going stale, in `/discuss`,
  `manuals/process.md` §The queue or the Template: the queue line names the
  paragraphs alone as what enters, and `docs/00-Product.md` question 6 asks
  a new part of the process for a concrete error it would have caught, while
  the Milestone 1 drift (`70945b8`) predates `/discuss` (`9f09c7e`). Where
  such a mechanism gets ordered is a `/discuss` of its own.
* Moving a line, changing the order, or changing a Mark other than this
  Delivery's: the queue line says the placements are right and the
  paragraphs are what is wrong.
* A paragraph for "Later, not scheduled": it sits outside the order and is
  not a Milestone (`docs/03-Domain.md`, Later and Milestone paragraph).
* The "Open decisions" block: it holds no lines placed against a paragraph.
* `VERSION` and the closing `focus-kit install .`: nothing under `skills/`,
  `manuals/`, `config/` or `bin/` changes, and `CLAUDE.md` bumps for a
  change a Target repository would want, not for this repository's own docs.

**Done when.**

* [x] `bin/focus-kit selftest` is green, check 5 included, which greps the queue
  for the Em dash.
* [x] The Done page holds one row per line of Milestones 1 and 2, naming the
  clause of its rewritten paragraph that admits it, and the same for any
  other Milestone the pass changed.
* [x] Every Slug a Milestone paragraph names is found under that paragraph's
  own heading.
* [x] Milestone 1's paragraph no longer contains "the queue's front door", and
  Milestone 2's no longer contains "every piece of friction found on the
  way".
* [x] The Slugs under each heading, in order, are the ones the run listed before
  it edited, this Delivery's own Mark excepted. The tree already carries
  uncommitted `/discuss` changes to `docs/06-Queue.md` and
  `docs/03-Domain.md`, so the check is that list and never the diff against
  `HEAD`.
* [x] The queue line `every-paragraph-admits-its-lines` reads `[x]` and this
  page is in `work/done/`.
* [x] The Dogfood copy and `VERSION` are untouched, and the record says so:
  nothing a Target receives changed.
* [x] The Done page names every file the run edited, and it is
  `docs/06-Queue.md` alone: no other document states a rule this Delivery
  alters.

---

## Record

`VERSION` stays at 0.28.0 and the dogfood copy is untouched. Nothing under
`skills/`, `manuals/`, `config/` or `bin/` changed, so no target receives
anything. One file was edited, `docs/06-Queue.md`, and four paragraphs inside
it.

### What the test found

The page expected two failures, Milestones 1 and 2, and expected 3, 4 and 5
to pass. Milestones 1, 2 and 3 came back as the page predicted; 4 and 5 did
not.

**Milestone 4 fails test 2, and the page did not expect it.** Its paragraph
ends "Proposed out of three lines that sat under Later and shared that
purpose (`queue-line-finds-its-place`, the `/discuss` run that proved it)",
and `queue-line-finds-its-place` stands under Milestone 3. It is a
provenance citation and not a claim of membership, so it never misled a
placement; the test as the Contract words it is flat, and it names a slug
under another heading. The page says what to do with a Milestone expected to
pass that does not: it is rewritten under the same test. The citation became
"by the `/discuss` of 2026-09-18", the register the two Milestone 5 lines
promoted that day already use, which keeps the date and names no slug.

**Milestone 5's second paragraph fails test 2 too, and what counts as "the
Milestone paragraph" is the one thing the page left open.** Line 425 read
"filled by the question `git-strategy-is-asked` adds", and that line stands
under Milestone 3. The reading matters: the `/discuss` of 2026-09-18 amended
Milestone 5's **first** paragraph to admit the three lines it promoted and
left the second alone, so this repository's own practice reads "the
paragraph" as the first one, the one that says what closes the milestone.
The Done when reads flat, "every Slug a Milestone paragraph names". The two
readings do not lead to different work here, because the fix is one clause
inside the Delivery's own slice and harms nothing either way, so it was taken
rather than asked: the clause now reads "filled by the question
`/initialize` asks", which is the present tense `git-strategy-is-asked`
earned by shipping.

**Milestone 3 passes all three checks, unchanged.** Its five lines:
`discuss-adds-queue-line` and `queue-line-finds-its-place` by "an idea
reaches the queue as one line in the milestone it serves, written in
conversation and not as a page opened too early or a hand edit with no
placement"; `~~git-branches-are-queue~~` and `git-strategy-is-asked` by "the
repository says which git strategy a delivery works by"; and this Delivery by
"one line in the milestone it serves", which a paragraph admitting a line
under another heading is what prevents. It names no slug at all.

**"Open decisions" keeps the one foreign mention left in the file.**
Decision 1 names `kit-selftest`, which stands under Milestone 1. The block is
Out of scope on the page's own words: it holds no lines placed against a
paragraph, so no placement reads it.

### Milestone 1, line by line

The paragraph now says the lines are that command, the defects found building
and running it, and two the process itself produced that no check would
catch. The clause that admits each of the twelve:

| Line | Clause that admits it |
|---|---|
| `kit-selftest` | that command, and it is the first line below |
| `graph-rebuilds-on-demand` | the graph policy, friction the process produced |
| `open-source-license` | the license, friction the process produced |
| `help-text-follows-header` | a defect found building and running it |
| `graphify-mcp-starts` | a defect found building and running it |
| `selftest-reads-the-merged-json` | a defect found building and running it |
| `version-bump-ends-with-install` | a defect found building and running it |
| `windows-git-bash` | a defect found building and running it |
| `version-stamp-tolerates-cr` | a defect found building and running it |
| `merge-json-by-argument` | a defect found building and running it |
| `doctor-reports-drift` | a defect found building and running it |
| `manifest-is-the-whole-list` | a defect found building and running it |

Two changes, both the page's: "the queue's front door" is gone, because
`discuss-adds-queue-line` stands under Milestone 3; and "most of the lines
below are defects it reports rather than fixes" is gone, because four of the
twelve fail it. The count of exceptions came out of the test rather than
being carried forward, and it is two, not three. What replaced "defects it
reports" is "defects found building and running it", which is what
`graphify-mcp-starts`, `doctor-reports-drift` and `windows-git-bash` actually
are: a check that was missing, a warn that was missing, a platform the
command did not run on, each found by building the command or running it,
none of them reported by it.

### Milestone 2, line by line

The standing clause "every piece of friction found on the way brought back
here as a queue line" is gone. The paragraph now closes on the full cycle
plus "the friction that running the kit outside this repository surfaced, in
the first target and in the scratch repositories that proved this milestone's
own deliveries", which is bounded: a scratch repository opened today proves
no delivery of this Milestone.

| Line | Clause that admits it |
|---|---|
| `first-target-install` | installed |
| `first-target-initialize` | initialized |
| `first-target-delivery` | one delivery proposed and applied end to end |
| `doctor-sees-a-stale-skill` | friction surfaced in the first target |
| `doctor-checks-settings-json` | friction surfaced in the first target |
| `every-warn-names-its-fix` | friction surfaced in the first target |
| `graph-cost-is-confirmed` | friction surfaced in the first target |
| `graph-staleness-without-a-stamp` | friction surfaced in the first target |
| `graph-ignores-the-kit` | friction surfaced in the first target |
| `mcp-leaves-the-baseline` | friction surfaced in the first target |
| `graph-answers-structure` | friction surfaced in the first target |
| `initialize-asks-for-the-proof-tool` | friction surfaced in the first target |
| `every-term-enters-03-first` | friction surfaced in the first target |
| `propose-asks-only-what-no-file-answers` | friction surfaced in the first target |
| `propose-ends-by-naming-the-next-session` | friction surfaced in the first target |
| `propose-does-not-fix-what-it-cannot-run` | friction surfaced in the first target |
| `propose-holds-no-fact-the-run-rechecks` | friction surfaced in the first target |
| `commands-read-sections-not-manuals` | friction surfaced in the first target |
| `focus-is-asked-not-imposed` | friction surfaced in the first target |
| `doctor-sees-an-unbumped-change` | friction surfaced in the first target |
| `language-question-says-what-it-governs` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `practice-questions-all-yes` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `review-run-finds-a-translated-practice-table` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `asked-as-written-says-which-language` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `initialize-trusts-the-argument` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `as-written-covers-a-literal` | friction surfaced in a scratch that proved this Milestone's own delivery |
| `run-ignores-a-stray-word` | friction surfaced in a scratch that proved this Milestone's own delivery |

Three rows are the ones to watch, and all three were written rather than
smoothed. `commands-read-sections-not-manuals` measured 194 sessions in
ninjobs, here and in the first target alike, so part of what it measured is
this repository; what it fixes is a cost paid in every target, and the first
target is where the comparison was taken, so the clause holds.
`doctor-sees-an-unbumped-change` was measured on `~/Downloads/vaulted` during
another delivery's run, which is the first target, so it sits with the
seventeen and not with the seven. `language-question-says-what-it-governs` is
the one row whose clause its own line does not carry: the line is a reading
of Step 0 and names no run, and the scratch is the greenfield proof that
`review-run-finds-a-translated-practice-table` cites by date, 2026-09-17. A
reader checking that row reads the next line to confirm it.

### Milestone 4 and Milestone 5, line by line

Both paragraphs pass tests 1 and 3 unchanged; only the slug citation moved.

| Line | Clause that admits it |
|---|---|
| `skill-says-it-is-kit-owned` | it does not erase an edit the person made without warning them first |
| `an-old-target-gets-the-fragment` | it does not leave a fragment that a later version rewrote |
| `update-survives-a-moved-section` | it does not leave a document pointing at a section that has moved |
| `uninstall-removes-the-kit` | a repository that stops using the kit gets its files back without unpicking them by hand |
| `readme-makes-the-case` | a person who has never heard of focus-kit reads `README.md` and knows what problem it solves |
| `readme-real-walkthrough` | the same clause, the part a person reads before the first command |
| `copilot-port` | the same commands run under GitHub Copilot and under Codex |
| `copilot-reads-the-project-rules` | the same commands run under GitHub Copilot and under Codex |
| `codex-port` | the same commands run under GitHub Copilot and under Codex |
| `manuals-follow-the-language` | a target that documents itself in another language reads the three manuals in that language |
| `update-alert` | a target installed several versions ago learns that a new one exists |
| `help-names-what-install-writes` | the usage text the CLI prints names everything install writes |

Milestone 5's "Seven of the nine describe or replicate the whole kit" was
checked against the same rows and holds: the two that do not are
`update-alert` and `uninstall-removes-the-kit`, which the paragraph names
separately in the sentences that follow.

### Proof

There is no UI and no line of terminal output changed, so `docs/05-Process.md`
§6 asks for the verify command and nothing further. `bin/focus-kit selftest`
green, six of six, check 5 included.

Two mechanical checks the verify command cannot make, both run against a list
taken before the first edit and kept in the session's scratch directory:

* The Slugs under each heading, in order, with their Marks: identical before
  and after except `[>] every-paragraph-admits-its-lines` becoming `[x]`. The
  check is that list and not `git diff HEAD`, because the tree carries another
  session's uncommitted work.
* Every slug named in prose under a Milestone heading, against where that slug
  stands: one hit left, `kit-selftest` under "Open decisions", which the page
  puts Out of scope.

One fact the run corrected: a read of the queue showed
`help-names-what-install-writes` as `[ ]`, and the bytes say `[>]`. The
before-and-after list is built from the file by the same command twice, so
the check never depended on that read.

### Nothing diverged in the two the page named

Milestone 1's and Milestone 2's rewrites are the claims of the Contract in
the Contract's own words. Nothing was dropped. No ADR: the delivery states no
rule that outlives it, and the rule it applies is already
`docs/manuals/process.md` §The queue and `docs/03-Domain.md`, The queue. No
document but the queue changed, because no document states a rule this
Delivery alters: the placement rule was already written by
`queue-line-finds-its-place`, and this Delivery only applies it to the
paragraphs that predate it.

### The staged tree

The git strategy is none (`docs/05-Process.md` §7), so `git add -A` stages
whatever else sits uncommitted in this working tree. It staged four files
that are not this Delivery's: `docs/03-Domain.md` and part of
`docs/06-Queue.md` from the `/discuss` that was already there, and
`work/help-names-what-install-writes.md` and
`work/manuals-follow-the-language.md`, two pages a `/propose` wrote in
another session while this one ran. That is exactly the cost
`git-strategy-is-asked` measured on 2026-09-18 and `docs/05-Process.md` §7
accepts by name. They are named here so the person can unstage them before
committing.

### Environments

| Environment | State |
|---|---|
| Kit source | 0.28.0, unchanged: nothing under `skills/`, `manuals/`, `config/` or `bin/` was edited |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.28.0, check 6 green. No `focus-kit install .` was needed or run |
| Machine (`~/.local/bin/focus-kit`) | a symlink to the kit source, so 0.28.0 |
| First target (`~/Downloads/vaulted`) | 0.22.5, read from its stamp, six versions behind. `focus-kit update ~/Downloads/vaulted`, and only if someone works there: Milestone 2 is closed and this row leaves `docs/05-Process.md` §5 with it |
| Target repositories (anyone else's) | untouched, at whatever version they installed. Their owner runs `focus-kit update` |
