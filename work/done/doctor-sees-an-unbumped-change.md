# doctor-sees-an-unbumped-change

**Goal.** A person running `focus-kit doctor` in a target learns that a
kit-owned file there is no longer what the kit source holds, even when the
installed version equals `VERSION`, so a target updated mid-delivery stops
passing as current. Measured on 2026-09-17 in the first target: `update`
ran, `skills/initialize/SKILL.md` then changed without a bump, and `doctor`
printed the version equal and every kit-owned file as install wrote it
(`docs/06-Queue.md`, this line).

**Behaviour.**

* `doctor` asks a third question, after the number and the manifest: is
  each kit-owned file the target holds what the kit source holds now? The
  source is `KIT_DIR`, which the CLI resolves from its own real path
  (`bin/focus-kit:37`) and which is on every machine that runs `doctor`,
  because the kit is installed by clone and symlink (`README.md`). So the
  question is asked in every target, not only in this repository (asked,
  2026-09-17).
* It is asked only when the installed version equals `VERSION` and the
  manifest exists. A target stale by number gets the version warn alone,
  because that line already names the fix and sixteen more lines would say
  it sixteen times (asked, 2026-09-17). A target with no manifest already
  gets the line that says `doctor` cannot tell.
* When every file agrees, the green `kit version <v>` line is the whole
  answer: green now means number and content equal, and no new green line
  is printed (asked, 2026-09-17). When one or more differ, the per-file
  warns stand in place of that green line: one warn per file, in the drift
  family (asked, 2026-09-17), and `doctor` still ends 0, because it reports
  (`docs/01-Architecture.md` §6).
* Behind is any of three things, and all three print the one line with the
  target's path: the source counterpart differs from what the manifest
  recorded, the source counterpart is gone, or the source holds a regular
  file under `skills/` or `manuals/` that the manifest does not list. The
  compare is against what `install` wrote, the manifest's fingerprint, not
  against the file on disk, so a file both edited locally and behind gets
  both lines, each true.
* In this repository nothing changes on screen: the dogfood copy in sync is
  what check 6 already enforces with its two diffs, and `doctor .` here
  compares a copy with the source it was copied from.

**Contract.** `VERSION` moves, because a target wants this
(`docs/05-Process.md` §5).

* `bin/focus-kit`, `doctor`: one new warn, kit-owned behaviour, wording
  exact:
  `<path> behind the kit source (run focus-kit update)`,
  where `<path>` is the target-relative path the manifest holds
  (`.claude/skills/...`, `docs/manuals/...`), and for a file new in the
  source, the path it would have in the target. Counterparts: `.claude/skills/<rest>` is
  `skills/<rest>` of `KIT_DIR`, `docs/manuals/<rest>` is `manuals/<rest>`.
  Fingerprints through `fingerprint()`, as the manifest's are.
  The `ok "kit version <v>"` line is printed only when the number and every
  counterpart agree. No other line of `doctor` changes wording or order.
* `bin/focus-kit`, check 2: proves the new line on the scratch, the way §4
  proves every other line, with a probe whose constraint is that the scratch
  and its manifest agree with each other and not with the source, without a
  byte of the kit source touched, everything restored byte-exact before
  check 3 snapshots the scratch. How the probe does that is the run's.
* `docs/03-Domain.md`: the row Unbumped change, added by this page.
* Documents that state today's behaviour and are updated in the same
  delivery: the `doctor` row of `docs/01-Architecture.md` §3, the Installed
  version row of `docs/03-Domain.md`, check 2 in `docs/05-Process.md` §4.
* Nothing a target receives changes shape: no skill, manual, template or
  config file is edited. The manifest format is unchanged.

**Slice.** `bin/focus-kit`, the `doctor` and `check_install` functions,
kit-owned behaviour; this repository's docs, project-owned. `graph: explain
"doctor" named 1 file (bin/focus-kit, 9 connections), affected "doctor"
named 4 nodes in the same file: check_install, check_dogfood, selftest, the
dispatch`. No function row of `docs/01` §3 is added. No FOCUS pieces
(ADR-0003).

**States.** A current target: unchanged output. A target at the same number
whose source moved: the per-file warns above, no green version line,
exit 0. A target stale by number: today's version warn, nothing per file. A
target with no manifest: today's manifest warn, nothing per file. Not a git
repository, dependency missing: as today.

**Visual reference.** No UI. The lines a target at the same number prints
after one skill changed in the source, in the position of today's version
line:

```
  ! .claude/skills/initialize/SKILL.md behind the kit source (run focus-kit update)
```

**Out of scope.**

* A version warn that also names files: the number line is the number's
  (asked, 2026-09-17).
* A new green line when everything matches: the version line covers it
  (asked, 2026-09-17).
* Telling an unbumped commit from an uncommitted edit: both are the source
  differing from the target, and `update` fixes both the same way; which it
  was is `git`'s to say in this repository, not `doctor`'s.
* A selftest check that the source changed since `VERSION` last moved: that
  fires on every mid-delivery run before the bump, which is when `/apply`
  runs it.
* A distribution without a clone: blocked on open decision 3 (`docs/00`).
* An ADR: a warn line is not expensive to reverse.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` bumped;
  `focus-kit install .` run here (`docs/05` §5).
* [x] Check 2 asserts the new line on the scratch and the green version line
  in the clean run, each built by calling `warn` and `ok`.
* [x] `doctor .` in this repository prints no new line.
* [x] The three documents above updated; the docs/03 row present.
* [x] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, and the `doctor` there before and after recorded
  (`docs/05` §5).
* [x] The queue line `[x]`; the page in `work/done/`.
* [x] The last thing said is which environment is at which version.

---

## What happened

**Built as the page said.** One new `warn` in `doctor`, the wording exact,
asked only at an equal number and with a manifest, standing in place of the
green `kit version <v>` line. Nothing a target receives changed shape. No
FOCUS piece, no new function, no new dependency. `VERSION` 0.21.1 to 0.22.0.

**Three run settlements**, what the page left to the run.

* **One mechanism for the three shapes, not three branches.** What `install`
  would write from today's source is built in the manifest's own format,
  poured together with the manifest, sorted under `LC_ALL=C` and read by
  `uniq -u`, which keeps a line that appears once. A path appears once when
  its fingerprint moved, when the source no longer holds it, and when the
  source holds it and the manifest never listed it. The three the page names
  are one pipeline and there is nothing to keep in step.
* **"A regular file under `skills/` or `manuals/`" is enumerated the way
  `write_manifest` enumerates the target's**, the three named skill folders
  and `manuals/*.md`, and not by a bare `find skills manuals -type f`. The
  warn names `focus-kit update` and that has to be true: a `.DS_Store` beside
  `skills/`, or a stray non-`.md` in `manuals/`, is never copied into a
  target, so a line naming a command that would not clear it is a warn that
  lies (`docs/04-Conventions.md` §1).
* **The check 2 probe puts all three shapes in one `doctor` run**, with no
  byte of the kit source touched: `docs/manuals/focus.md` edited and
  `write_manifest` run over the result, `.claude/skills/apply/ghost.md`
  created and recorded the same way, and the `docs/manuals/graphify.md` line
  cut out of the manifest. Five assertions: three warns, the green version
  line absent, the `edited locally` warn absent and the drift `ok` line
  present. The last two are what say the compare is against the manifest and
  not against the file on disk, and that the two passes stay separate
  questions. The restore runs before the assertions, so a red leaves the tree
  as check 3 needs it.

**Two mutation runs, because an assertion nobody has seen fail is not an
assertion.** Changing `update` to `upgrade` in `doctor`'s new line alone
turned check 2 red on the first warn; adding an unconditional `ok "kit
version $v"` turned it red on the green-line assertion. Both restored from a
copy taken first.

**One thing changed that the page did not name.** The `--help` header line
for `doctor` read `report what is installed, what is missing, and what was
edited locally`; it now reads `and what update would change`. The header is
the help text (`docs/04-Conventions.md` §1), the sentence has to cover two
questions now, and a fourth clause would have run the line past 130
characters. Same length, and true of all four kit-owned shapes: overwrites,
restores, removes, brings forward.

**A staleness found on the way, fixed in the same delivery.** The `Line`
column of `docs/01-Architecture.md` §3 was one line behind the truth for
every function from `ensure_graphify` down, before this delivery moved any of
them. The column and the six check line numbers are now what `grep -n
'^[a-z_]*() {' bin/focus-kit` prints. The three references to the dispatch
that this delivery moved by exactly 100 lines (`docs/00-Product.md:118`,
`docs/01-Architecture.md` §3, `docs/04-Conventions.md` §1) were shifted with
it. References this delivery did not move were left as they are: they are
not this page's.

**Nothing dropped.** No ADR, as the page said: a warn line is not expensive
to reverse.

## What the proof found

`bin/focus-kit selftest`: six green, check 6 empty. `doctor .` here: no new
line, the green `kit version 0.22.0` unchanged.

The first target, `~/Downloads/vaulted`, all three states in order and each
one what the page's **States** section predicted.

```
before, kit at 0.21.1, target at 0.21.1, in sync
  ✓ kit version 0.21.1                       (and every other line green)

after the bump, kit at 0.22.0, target at 0.21.1
  ! kit version 0.21.1 installed, 0.22.0 available (run focus-kit update)
                                             (and no per-file line, as asked)

after focus-kit update ~/Downloads/vaulted
  ✓ kit version 0.22.0                       (and every other line green)
```

The false green the Goal measured could not be reproduced there: a later
delivery had already run `focus-kit update` on that target, so its kit-owned
files and the source agreed before this run started. The behind lines are
proven on the scratch, by check 2, which is where `docs/05-Process.md` §6
puts the proof of a change to `bin/focus-kit` alone. Nothing was staged or
committed in the target; `update` stages nothing, and its working tree is as
the last run left it.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.22.0 |
| Dogfood copy | 0.22.0, `focus-kit install .` run here |
| Machine | the CLI is a symlink and follows the source; global `/graphify` skill at the package's version |
| First target (`~/Downloads/vaulted`) | 0.22.0, `doctor` all green, nothing committed |
| Other targets | untouched; they move when their owner runs `focus-kit update` |
