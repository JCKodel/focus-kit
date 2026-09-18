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

* [x] `bin/focus-kit selftest` is green, six checks, with check 2 carrying the
  two green lines and the two probes.
* [x] `focus-kit doctor` in a scratch repository whose `.gitignore` has had
  `graphify-out/` cut out names that line, and the transcript goes into
  `work/done/an-old-target-gets-the-fragment.md` (`docs/05-Process.md` §6).
* [x] `docs/01-Architecture.md`, `docs/03-Domain.md` and `docs/05-Process.md`
  carry what the Contract names, the **Fragment gap** row included.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy is at the same number (`docs/05-Process.md` §5).

---

## What happened

Built as the Contract defines it, in one pass. `VERSION` 0.25.1 to 0.26.0:
the CLI gained a behaviour a target wants, which is a minor and not a patch.

**The pass**, `bin/focus-kit` in `doctor`, between the Leftover pass and the
Drift pass. One loop over two literal pairs, the marker read with `head -n 1`
from `KIT_DIR` and tested with the same fixed-string `grep` `append_once`
uses, so the two agree on what a block being there means. Where the block is
there, each pattern line is looked for with `without_cr "$target/$file" |
grep -qxF`, its fifth caller and the first over a file the target itself
versions. A herestring feeds the inner loop, for the reason the Drift loop states
at `bin/focus-kit:580`: a pipe would run it in a subshell and the `gap` flag
would come back 0 however many lines it warned about.

**Check 2** gained the two green lines in the `ok` list and two probes,
after the Leftover probe and before the CRLF stamp probe. The `.gitignore`
probe asserts the warn **and** the absence of the green line, which is the
assertion that separates a whole-line test from a substring one; the absence
is written as an `if ... then die`, because `grep -q` failing is the expected
outcome and `|| die` would have read backwards. Both files go aside into
`SELFTEST_DIR` and come back byte for byte, for check 3.

## Diverged from the plan

* **`docs/00-Product.md` was edited after all.** The Contract says it needs
  none, and on content that held: Installing says nothing about `doctor`. But
  its line 119 cites `bin/focus-kit:1029` for the dispatch, and the insertion
  moved the dispatch to 1115. A pointer this delivery broke is this
  delivery's to fix. Same for the citations in `docs/03-Domain.md` (`:291` to
  `:292`) and `docs/04-Conventions.md` (`:385` to `:386`, `:1041` to `:1127`),
  and for fifteen line numbers in `docs/01-Architecture.md`: seven rows of the
  §3 function table, the six `check_*` numbers under it, the dispatch, and the
  §5 read of `docs/00-Product.md`.
  Citations that were already stale before this delivery were left alone:
  §2's `bin/focus-kit:219` for the heredoc and §6's `bin/focus-kit:193` for
  `merge_json` point at the wrong lines and did so yesterday. Correcting a
  pointer nothing here moved is a `/discuss` line.
* Nothing was dropped and nothing in the Contract went unbuilt.

## The proof

Beyond `selftest`, a real run in a scratch repository (`docs/05-Process.md`
§6). `mktemp -d`, `git init`, `focus-kit install`, then `graphify-out/` cut
out of `.gitignore` with `grep -vxF`:

```
focus-kit 0.26.0 doctor: /var/folders/.../tmp.TkdxN0WDNR
  ...
  ✓ .claude/settings.json
  ! .gitignore lacks the kit's line "graphify-out/" (add it by hand; focus-kit update leaves an existing block alone)
  ✓ .graphifyignore (kit fragment current)
  ✓ kit-owned files as install wrote them
```

Then the case the delivery exists for, which no assertion in `selftest`
reaches: `graphify-out/cost.json` appended to that same `.gitignore`, which
is what a target installed before `graph-rebuilds-on-demand` holds, and the
whole block cut out of `.graphifyignore`:

```
  ! .gitignore lacks the kit's line "graphify-out/" (add it by hand; focus-kit update leaves an existing block alone)
  ! .graphifyignore has no focus-kit block (run focus-kit update)
```

A substring test would have printed the green line on the first of those two.
Then `focus-kit update` on the same scratch, which is the other half of the
claim: the `.gitignore` block came back untouched, still without
`graphify-out/` and still with the `cost.json` line a person would have
written, and the empty `.graphifyignore` received the whole fragment, because
it had no marker. Exactly the two behaviours the warns name.

`focus-kit doctor .` here prints both green lines: this repository is current
on both files, which is what installing the kit on itself at every delivery
buys.

## Decisions

No ADR. The three questions this delivery could have raised were answered in
the `/propose` conversation and are in Out of scope: no second marker block
(ADR-0002 forbids it), no `update` writing into an existing block, no
reporting of a line an older fragment dropped. The build found nothing that
reopened any of the three.

One decision the build itself took: the warn for a missing block and the warn
for a missing line are separate wordings and not one with a count, because
the two fixes differ, and `doctor` cannot tell a file that predates the
fragment from one whose block a person removed. One wording covers both,
since the fix is the same command.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.26.0, the pass and the two probes |
| Dogfood copy | 0.26.0, `focus-kit install .` run here; check 6 green |
| Machine | untouched: `~/.local/bin/focus-kit` is a symlink and follows the source |
| First target (`~/Downloads/vaulted`) | at 0.22.5, and left there: milestone 2 has no open line, which is what the `docs/05-Process.md` §5 row makes its condition, and the three deliveries before this one left it there too. `focus-kit update ~/Downloads/vaulted` brings it to 0.26.0, and doing so would make it the first repository to see this pass on a real fragment gap |
| Target repositories | untouched, as always; they move when their owner runs `focus-kit update` |
