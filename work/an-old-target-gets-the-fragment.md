# an-old-target-gets-the-fragment

**Goal.** Someone running `focus-kit doctor` in a repository installed
several versions ago is told which lines the kit's `.gitignore` and
`.graphifyignore` blocks have gained since, and that `update` will not add
them.

**Behaviour.**

* A target whose `.gitignore` carries the marker but not `graphify-out/`
  gets one warn naming that line and the hand edit that ends it. That is the
  repository installed before `graph-rebuilds-on-demand`, which commits a
  graph diff after every commit.
* A target whose `.graphifyignore` carries the marker but not
  `.claude/skills/discuss/` gets the same warn for that line. That is the
  repository installed before `discuss-adds-queue-line`, whose graph indexes
  the kit's own `/discuss` skill.
* One warn per missing line, so a target several versions behind sees every
  line it needs rather than a count.
* A target whose file has no marker at all, because it predates the fragment
  and never received it, or because the file was deleted or the block removed
  by hand, gets one warn naming `focus-kit update`, which appends the whole
  fragment.
* A target current on both files gets one green line each.
* `install`, `update` and `append_once` write exactly what they write today.
  A block that is there is never touched, and no line the person removed
  comes back.
* A line an old fragment had and the current one dropped is not reported.
  `doctor` cannot tell one from a line the person wrote themselves.

**Contract.**

* `bin/focus-kit`, `doctor`: one pass over the two pairs the CLI already
  appends, `.gitignore` with `config/gitignore.fragment` and
  `.graphifyignore` with `config/graphifyignore.fragment`, read from
  `KIT_DIR` the way every other read of the kit's own files is. It sits after
  the Leftover pass and before the Drift pass, so what the kit wrote into a
  target's own files stays together in the output. It reports and changes
  nothing, the way the rest of `doctor` does.
* What it looks for is a pattern line, a line of a fragment that is neither
  blank nor beginning with `#` (`docs/03-Domain.md`, Fragment gap). The marker
  and the comments around it carry no behaviour, and the marker's presence is
  what `append_once` already tests.
* **Present means a whole line.** A pattern line counts as present only when
  a line of the target's file equals it, byte for byte, with carriage returns
  removed. Not a substring: an old target holds `graphify-out/cost.json` and
  lacks `graphify-out/`, and a substring test would go green on the one case
  this delivery exists for. Removing the carriage return makes `without_cr`
  the reader here as it is everywhere else, so a Windows checkout of the
  target's own `.gitignore` compares equal; its caller count in
  `docs/01-Architecture.md` §3 goes from four to five.
* The three lines, exact, per file:
  * `<file> has no focus-kit block (run focus-kit update)`
  * `<file> lacks the kit's line "<the line>" (add it by hand; focus-kit
    update leaves an existing block alone)`
  * `<file> (kit fragment current)`, the green one, printed only when every
    pattern line is present.
  Each warn names its fix (`docs/04-Conventions.md` §1), and the two fixes
  differ because the two states do: a missing block is a command, a missing
  line is a paste.
* `docs/05-Process.md` §4, check 2: the two green lines join the expected
  output of the normal run, and two probes on the scratch, each restored byte
  for byte because check 3 installs into the same scratch. `graphify-out/` is
  cut out of `.gitignore` and one `doctor` run must carry that line's warn and
  not `.gitignore`'s green line; the whole block is cut out of
  `.graphifyignore` and one `doctor` run must carry the no block warn. One
  branch per file, so the pass is proven over both pairs and not over one.
* `docs/01-Architecture.md`: the `doctor` row of §3 gains the pass, the
  `without_cr` row its fifth caller, and the **Write an appended file** row of
  §5 stops saying `doctor` reports neither.
* `docs/03-Domain.md`: the **Fragment gap** row, the third state `doctor`
  names after Drift and Leftover, written by this `/propose`. `/apply` makes
  the **Appended once** row stop saying `doctor` reports neither and point at
  it.
* `VERSION` is bumped: the CLI's behaviour changes and a target would want
  it. No skill, manual or template is touched.
* `docs/00-Product.md` needs no edit: Installing says the two fragments are
  appended once and claims nothing about `doctor`.
* Independent of `work/git-strategy-is-asked.md`, which reasons about this
  staleness to keep the worktree outside the tree and changes no fragment,
  and of `work/skill-says-it-is-kit-owned.md`, which amends ADR-0002's
  Kit-owned bullet where this delivery amends no bullet at all.

**Slice.** `bin/focus-kit`, the whole CLI, plus this repository's own docs
(`docs/01-Architecture.md` §3, Structure, one file; §4). No View,
Orchestrator, Use case or Repository: §3 says none of the four exists here.
The graph named `bin/focus-kit` and nothing else for `append_once`, both
ways. Kit-owned: `bin/focus-kit` and the two fragments, unchanged in content.
Appended once: the two files `doctor` now reads in a target. Project-owned:
this repository's `docs/01`, `docs/03`, `docs/05` and `docs/06`.

**States.**

* Target current on both files: two green lines, nothing else.
* Target installed before `graph-rebuilds-on-demand`: the `graphify-out/`
  warn, plus one per line of `.graphifyignore` it also lacks.
* File deleted or block removed by hand: the no block warn, naming
  `focus-kit update`.
* Target with an extra line of its own inside or below the block: silent. The
  pass asks only whether the kit's lines are there.
* A line the kit stopped shipping: silent, and it stays in the target's file.
* `install` and `update`: unchanged output, at the new version.

**Visual reference.** No UI. `focus-kit doctor` in a target installed before
0.4.0, the two new passes only, in the `warn` and `ok` shapes of
`bin/focus-kit:46`:

```
  ! .gitignore lacks the kit's line "graphify-out/" (add it by hand; focus-kit update leaves an existing block alone)
  ! .graphifyignore has no focus-kit block (run focus-kit update)
```

and in a current one:

```
  ✓ .gitignore (kit fragment current)
  ✓ .graphifyignore (kit fragment current)
```

**Out of scope.**

* A line an older fragment had and this one dropped: with no end marker
  `doctor` cannot tell it from a line the person wrote, and the targets this
  serves predate any marker the kit could add now.
* A second marker block carrying only what is missing: ADR-0002 forbids a
  second marker style for appended content.
* `install` or `update` writing into an existing block: the answer taken in
  this page's conversation. It would re-add on every update a line the person
  removed, in a file the target versions.
* A manual section explaining the warn: the warn carries the line to paste,
  so there is nothing to look up.
* ADR-0002's Appended once bullet naming one file where there are two, a gap
  `graph-ignores-the-kit` left: the category does not change here, so
  correcting it is a `/discuss` line and not this delivery's.
* `update-survives-a-moved-section`: the other mechanism of this milestone,
  blocked on open decision 5.

**Done when.**

* `bin/focus-kit selftest` is green, six checks, with check 2 carrying the
  two green lines and the two probes.
* `focus-kit doctor` in a scratch repository whose `.gitignore` has had
  `graphify-out/` cut out names that line, and the transcript goes into
  `work/done/an-old-target-gets-the-fragment.md` (`docs/05-Process.md` §6).
* `docs/01-Architecture.md`, `docs/03-Domain.md` and `docs/05-Process.md`
  carry what the Contract names, the **Fragment gap** row included.
* `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy is at the same number (`docs/05-Process.md` §5).
