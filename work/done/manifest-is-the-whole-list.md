# manifest-is-the-whole-list

**Goal.** The manifest is the only complete list of kit-owned files a
target holds, and two green lines are printed today without consulting it
to the end. `doctor` skips a manifest entry whose file is gone, and check 6
of `selftest` never fingerprints the kit's own tree. Both stop being
possible: a green line means the manifest was read through and agreed with.

Found by the whole-branch review that closes milestone 1
(`docs/05-Process.md` §9), which reproduced both.

**Behaviour.**

* A target at `0.6.0` whose `.claude/skills/initialize/templates/CLAUDE.md`
  was deleted gets `! .claude/skills/initialize/templates/CLAUDE.md missing
  (focus-kit update restores it)` and no green line. Today: `✓ kit-owned
  files as install wrote them`, and `/initialize` then fails to find its
  template with nothing in `doctor` pointing at the cause. Ten of the
  sixteen files the manifest names are templates, and no presence line
  anywhere covers them.
* A target whose `.claude/skills/propose/` folder was removed gets `!
  /propose missing` and no green line. Today it gets `! /propose missing`
  and the green line underneath it, because every propose path is skipped.
* A target whose `docs/manuals/focus.md` was deleted gets one line, `!
  docs/manuals/focus.md missing`, from the presence pass, and no green line.
  The drift pass prints no second line about it: a path the lines above
  already reported gets no repeat, and the rule is by position in the
  output, not a list of paths.
* A target with nothing wrong still gets one line, `✓ kit-owned files as
  install wrote them`, and it now also means that every file the manifest
  names is there.
* The other cases are unchanged, character for character: edited, added,
  CRLF checkout, manifest absent, stamp absent, stale version.
* `doctor` still never fails. Every new line is a `warn`.
* In this repository, `bin/focus-kit selftest` goes red when
  `.claude/skills/.focus-kit-manifest` is stale against the tree it
  describes. Today check 6 excludes the manifest from its `diff` and no
  other check reads it, so a contributor who edits `manuals/process.md` and
  mirrors the edit into `docs/manuals/process.md` by hand, without running
  `focus-kit install .`, gets six green checks and commits a manifest that
  makes `focus-kit doctor .` report a local edit on a tree nobody edited.

**Contract.**

`doctor` (`bin/focus-kit:298`). Every line printed today is unchanged. Two
edits:

| Where | Exactly |
|---|---|
| the two presence loops (316-318, 324-328) | each accumulates the path it just reported as `missing` into one local, in the form the manifest holds it: `.claude/skills/<s>/SKILL.md` for the skill loop, `$f` for the file loop. A present file accumulates nothing. The `ok` and `warn` texts do not change. |
| the manifest loop (346-353) | `[ -f "$target/$path" ] \|\| continue` becomes: set `drift=1`, and `warn "$path missing (focus-kit update restores it)"` unless the accumulator already holds `$path`, tested with `grep -qxF` as the added-file pass tests membership. Then `continue`. |

The comment at 329-333 loses the sentence beginning "A file that is absent
is not drift" and says instead that absence is drift because the manifest is
the only complete list, and that a path the presence lines already named is
not repeated.

Absence sets `drift=1` in every case, including the six paths whose warn is
suppressed. The green line then means *present and as `install` wrote it*,
which is what its text already claims. The suppressed six get their `!` from
the presence lines above, so nothing goes unsaid.

`check_install` (`bin/focus-kit:397`), a fourth drift probe, after the
edited and added probe is restored and before check 3 snapshots the scratch:

| Probe | Exactly |
|---|---|
| missing | `rm "$scratch/.claude/skills/initialize/templates/CLAUDE.md"`; one `doctor` run, two assertions. It must print `warn ".claude/skills/initialize/templates/CLAUDE.md missing (focus-kit update restores it)"`, red: `die "check 2: doctor did not report a kit-owned file deleted from the scratch repository"`. It must **not** print `ok "kit-owned files as install wrote them"`, red: `die "check 2: doctor printed the drift ok line with a kit-owned file deleted from the scratch repository"`. Both expected lines built by calling `warn` and `ok`, as the three probes above do. |
| restore | `cp "$KIT_DIR/skills/initialize/templates/CLAUDE.md"` over it. No `write_manifest`: a deletion does not change the manifest. |

`check_dogfood` (`bin/focus-kit:559`), one assertion added after both
`diff` calls and before its `ok`. It stays check 6; nothing becomes a
seventh check and no "six checks" literal moves.

| Step | Exactly |
|---|---|
| run | `out="$(doctor "$KIT_DIR" 2>&1)"`, red: print `$out`, `die "check 6: doctor failed on this repository"` |
| assert | `$out` contains `ok "kit-owned files as install wrote them"`, red: print `$out`, `die "check 6: doctor reports drift in the dogfood copy (run focus-kit install .)"` |

Only the presence of that one line is asserted. The `warn` lines this
repository legitimately produces are ignored, the same way check 2 ignores
the ones a scratch repository produces. Placed after the two `diff` calls,
so it fires only on the gap they leave: both copies equal to their sources
and the manifest stale against them.

Written inline, no helper, although this is the second call site of capture
`doctor`, build the expected line with `ok`, `grep -qF`, print the output,
`die`. Check 2 already holds four of that shape inside one function, each
with its own `die` text, and the texts are what the shape exists to carry.
The abstraction would hold the loop and not the messages.

`VERSION` goes to `0.6.1`. `doctor` gains a kind of line and every target
reads it, which is what `0.5.2` was; no file is added and no file changes
shape. The check 6 assertion alone would bump nothing: `selftest` never
reaches a target.

Docs, in the same delivery. `docs/03-Domain.md` Drift is already rewritten
by this `/propose`: three `warn` lines, absent among them, with the reason.
`docs/01-Architecture.md` §3 `doctor` row says it also reports a file the
manifest names and the target does not have; §6 is re-read for the
`bin/focus-kit:N` references the insertions move, and so are the function
line numbers in §3 and the ones in `docs/03` and `docs/04`. `docs/05` §4
check 2 gains the fourth probe in one sentence and check 6 the `doctor`
assertion. `manuals/process.md` §10 line 180 reads "and it names the
kit-owned files that are missing, were edited locally, or were added inside
a skill folder". `README.md` lines 80-81 already say "what is missing" and
are left alone.

**Slice.** The CLI, `bin/focus-kit`: `doctor`, `check_install`,
`check_dogfood` edited. Nothing added, nothing removed. `manuals/process.md`,
kit-owned. `docs/01`, `docs/03`, `docs/05`, project-owned. No skill, no
template, no `config/`, no new file in any target. `doctor` has one caller
besides the dispatch, `check_install`, and `check_dogfood` becomes the
second; the graph confirms nothing else reads its output.

**States.** In Behaviour: template deleted, whole skill folder removed,
manual deleted, nothing wrong, and the five unchanged cases. A target with
no stamp is untouched: the drift block does not run. A target installed
before `0.6.0` has no manifest and keeps its one warn.

Removing `.claude/skills/initialize/` is the loud case and it is correct:
`! /initialize missing` from the skill loop, then ten warns, one per
template, because the skill loop reports `SKILL.md` and nothing else. The
suppression is per path, never per folder, so `/apply` should expect eleven
lines there and not treat them as a defect.

**Visual reference.** No UI. `doctor` in a target at `0.6.1` with
`templates/CLAUDE.md` deleted, the drift block in the place
`doctor-reports-drift` gave it:

```
  ✓ .mcp.json
  ! .claude/skills/initialize/templates/CLAUDE.md missing (focus-kit update restores it)
  ✓ graphify-out/graph.json
```

The same target repaired prints `✓ kit-owned files as install wrote them`
in place of the warn. With `.claude/skills/propose/` removed instead, the
block holds no line at all about `propose`: the `! /propose missing` printed
further up, next to `/initialize` and `/apply`, already said it, and the
green line is gone all the same. `selftest` prints the same six lines as
today.

**Out of scope.**

* Correcting `work/done/doctor-reports-drift.md:32`, which carries the same
  false premise. A done page is the record of what happened, not a living
  document. This page supersedes that line, and the done page of this
  delivery says so.
* `update` printing the drift lines before it copies. `doctor` is the front
  door, settled in `doctor-reports-drift` and unchanged here.
* A presence check for `docs/manuals/` beyond the three manuals: a file
  added there survives `update`, because manuals are copied one by one.
* Making the manifest the only presence list, dropping the three manuals
  from the file loop. It would take the manual lines away from a target with
  no stamp, which is where they are the most useful.
* An ADR. Reversing this is restoring one `continue` and deleting one
  assertion. The reason is on this page and in `docs/03`.
* A run on the Windows host. Nothing here is platform dependent; the CRLF
  probe that is already in check 2 covers the manifest reader.

**Done when.**

* [x] `bin/focus-kit selftest` green, with the fourth probe inside check 2
  and the `doctor` assertion inside check 6.
* [x] Counterfactual in the done page, at `0.6.0`, quoted: a scratch
  repository with `templates/CLAUDE.md` deleted, `doctor` printing the green
  line, and no line naming the file.
* [x] The fourth probe proven able to go red on each of its two assertions
  in turn: the `warn` removed from the new branch, then `drift=1` removed,
  each making check 2 die with its own message, each restored.
* [x] The check 6 assertion proven able to go red on the scenario that
  found it: `manuals/process.md` and `docs/manuals/process.md` edited
  identically by hand, without `focus-kit install .`, and `selftest` dying
  on check 6 while checks 1 to 5 pass. Restored with `git checkout --
  manuals/process.md docs/manuals/process.md`, then `selftest` green. No
  install in the restore: installing would carry the stray line into the
  dogfood copy and the manifest and leave the source holding it.
* [x] `VERSION` is `0.6.1`; `focus-kit install .` was run; `focus-kit doctor
  .` prints `✓ kit version 0.6.1` and the drift `ok` line; check 6 green.
* [x] `docs/01`, `docs/05` and `manuals/process.md` say what the Contract
  lists, and every `bin/focus-kit:N` in `docs/01`, `docs/03` and `docs/04`
  re-measured.
* [x] Environments: kit source and dogfood copy at `0.6.1`, machine follows
  the symlink, targets untouched.

---

## What happened

Built as the Contract describes. Three edits in `doctor`, one probe in
check 2, one assertion in check 6, `VERSION` to `0.6.1`.

**The counterfactual, at `0.6.0`.** A scratch repository, installed, with
`.claude/skills/initialize/templates/CLAUDE.md` deleted. ANSI escapes
stripped, the machine and project-owned lines cut:

```
focus-kit 0.6.0 doctor: <scratch>
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.6.0
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ kit-owned files as install wrote them
```

`grep -c "templates/CLAUDE.md"` over the whole run returned `0`. The green
line and not one word about the file. At `0.6.1` the same scratch prints
`! .claude/skills/initialize/templates/CLAUDE.md missing (focus-kit update
restores it)` and no green line.

**The four scenarios of Behaviour, run.** Template deleted: the warn, no
green line. `.claude/skills/propose/` removed: `! /propose missing` and no
green line, and the drift block holds no line about propose. `docs/manuals/
focus.md` deleted: the one presence warn, no green line, no repeat.
Nothing wrong: the green line. Character for character what the Visual
reference asked for.

`.claude/skills/initialize/` removed prints exactly eleven lines naming
`initialize`, counted: `! /initialize missing` plus ten templates. The
loud case is correct, as the page said it would be.

**The two red proofs of the fourth probe.** With the `warn` removed from the
new branch, check 2 died on `doctor did not report a kit-owned file deleted
from the scratch repository`. Restored, green. With `drift=1` removed
instead, the output carried `✓ kit-owned files as install wrote them` and
check 2 died on `doctor printed the drift ok line with a kit-owned file
deleted from the scratch repository`. Restored, green. Each assertion fails
on its own and on nothing else.

**The red proof of check 6, run before the `manuals/process.md` §10 edit.**
Order matters and the page did not say so: the restore is `git checkout --
manuals/process.md docs/manuals/process.md`, which would have silently
reverted this delivery's own §10 edit had that edit already been made. So:
bump and install, append a stray line to both copies by hand, `diff -r
manuals docs/manuals` empty, `selftest` green on 1 to 5 and dead on 6 with
`doctor reports drift in the dogfood copy (run focus-kit install .)`,
preceded by `! docs/manuals/process.md edited locally`. Then `git checkout
--` both, `selftest` green. Then the §10 edit, then `focus-kit install .`,
then `selftest` green again.

## Divergences

* **`&&` became `if` in the second assertion of the fourth probe.** The
  Contract said both expected lines are built by calling `warn` and `ok`, as
  the three probes above do, and those probes use `grep -qF ... || { die; }`.
  The new assertion is the negative one, so the natural mirror is `grep -qF
  ... && { die; }`, and under `set -euo pipefail` an `&&` list whose last
  command fails ends the script: the green case, grep finding nothing, would
  have exited 1 with no message. Written as an `if`, with the reason in a
  comment. The lines and the `die` texts are the Contract's.
* **`manuals/process.md` §10 gained "restores" in the following clause.** The
  Contract quoted the new line 180 exactly and that is what was written, but
  the sentence continues "before the next update overwrites or removes them",
  which is now three verbs against two. It reads "restores, overwrites or
  removes them". Leaving it would have made the sentence false about the
  case the delivery adds.
* **The accumulator takes project-owned paths too.** The file loop reports
  `docs/00` to `06` and `CLAUDE.md` as well as the three manuals, and the
  simplest correct loop accumulates whatever it warned about. Harmless: no
  project-owned path is ever in the manifest, so those entries never
  suppress anything. The alternative was a second condition inside the loop
  to filter by ownership, which is a rule the loop does not otherwise hold.

Nothing was dropped. No ADR: reversing this is restoring one `continue` and
deleting one assertion, as the page said.

**This page supersedes `work/done/doctor-reports-drift.md:32`**, which says
a missing file is not drift. It carried the premise this delivery removes.
The done page is the record of what happened then and is left as it is.

## Line numbers

Only `selftest`, the six check functions and the dispatch moved; everything
at or before `doctor` (298) is where it was. Re-measured and updated:
`selftest` 578 to 639, `check_parses` 388 to 410, `check_install` 397 to
419, `check_idempotent` 491 to 539, `check_frontmatter` 508 to 556,
`check_no_em_dash` 547 to 595, `check_dogfood` 559 to 607, the dispatch 596
to 657 in `docs/01` §3 and `docs/04` §1. Every reference in `docs/03`
(44, 46, 229, 277) was re-checked against the file and is still exact.

## Environments

| Environment | State |
|---|---|
| Kit source | `0.6.1`. `bin/focus-kit`, `manuals/process.md` edited. |
| Dogfood copy | `0.6.1`, `focus-kit install .` run after the last edit. `focus-kit doctor .` prints `✓ kit version 0.6.1` and `✓ kit-owned files as install wrote them`; check 6 green. |
| Machine (`~/.local/bin/focus-kit`) | untouched, a symlink to the kit source, so already `0.6.1`. |
| Target repositories | untouched, still at whatever version their owner installed. They move on `focus-kit update <path>`, run by that person. |
