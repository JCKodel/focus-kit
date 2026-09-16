# version-bump-ends-with-install

**Goal.** The dogfood copy is always at the kit version, so `focus-kit
doctor .` in this repository never warns about the kit's own version and
`selftest` sees the drift the moment it appears.

**Behaviour.**

* Today `.claude/skills/.focus-kit-version` reads `0.4.0` while `VERSION`
  reads `0.4.1`: `help-text-follows-header` bumped `VERSION` and, touching
  no skill or manual, correctly did not run `focus-kit install .`. Check 6
  excludes that file, so `selftest` is green and `doctor .` warns.
* The rule changes: **any delivery that bumps `VERSION` ends with
  `focus-kit install .`**, in addition to any delivery that touches
  `skills/` or `manuals/`. The dogfood copy is a target, and a target one
  version behind is what `doctor` exists to flag.
* Check 6 also compares the installed version with `VERSION`. Different:
  red, naming both and the command that fixes it.
* This delivery bumps `VERSION` and therefore ends with the install, which
  brings the stamp to the same number in the same commit.

**Contract.**

`check_dogfood` gains, before its two diffs:

```
check 6: the dogfood copy is at 0.4.2 and VERSION is 0.4.4 (run focus-kit install .)
```

`0.4.2` because `graphify-mcp-starts` touched a manual and ran the install,
and `selftest-reads-the-merged-json` did not. It is the `die` when `$(cat "$KIT_DIR/.claude/skills/.focus-kit-version")`
differs from `$KIT_VERSION`, or when the file is absent. The `diff -r -x
.focus-kit-version` stays as it is: the file is compared by value, not by
bytes against `skills/`.

Docs that own the rule, each changed at the place that states it:

| Doc | Today | After |
|---|---|---|
| `docs/05-Process.md` §5, environments table, dogfood row | in sync "when the delivery touched a skill or a manual" | "when the delivery touched a skill or a manual, or bumped `VERSION`" |
| `docs/05-Process.md` §5, the bold sentence | touches `skills/` or `manuals/` | adds "or bumps `VERSION`" |
| `docs/05-Process.md` §4 item 6 | both diffs empty except `.focus-kit-version` | adds "and `.focus-kit-version` equal to `VERSION`" |
| `docs/05-Process.md` §3, Done when | dogfood copy in sync (§5) | unchanged wording; §5 carries the new condition |
| `CLAUDE.md`, How to work | install after touching `skills/` or `manuals/` | adds the `VERSION` bump |
| `docs/03-Domain.md`, Installed version row | stamped at install time | adds "in this repository it equals `VERSION` at every commit (check 6)" |

`work/done/kit-selftest.md` keeps its sentence that 0.2.0 was correct then.
Done pages are history.

`VERSION` goes to `0.4.4`: check 6 is CLI behaviour.

**Slice.** The CLI, `bin/focus-kit`, one check. This repository's process
docs and `CLAUDE.md`. No target receives anything new.

**States.** Green: unchanged. Red on this tree before the install:

```
  ✓ 5 no em dash in the paths this repository authors
error: check 6: the dogfood copy is at 0.4.2 and VERSION is 0.4.4 (run focus-kit install .)
```

**Visual reference.** No UI. The line above.

**Out of scope.**

* Whether the dogfood copies stay versioned at all: open decision 2 in
  `docs/06-Queue.md`. If they stop, this check goes with check 6.
* `doctor` on a target other than this repository: its version warning
  already exists and is correct.

**Done when.**

* [x] `bin/focus-kit selftest` red with the line above before `focus-kit
  install .`, green after. Both runs recorded in the done page.
* [x] `focus-kit doctor .` here prints `kit version 0.4.4`.
* [x] `VERSION` is `0.4.4` and `.claude/skills/.focus-kit-version` is
  `0.4.4` in the same commit.
* [x] The six doc places in the table say the new rule.
* [x] Environments: kit source and dogfood copy at 0.4.4, machine follows the
  symlink, targets untouched.

---

## What happened

**The code.** `check_dogfood` (`bin/focus-kit:369`) gains three statements
before its two diffs: the stamp's path, a `die` when the file is absent, and
a `die` when its value differs from `$KIT_VERSION`. The `diff -r -x
.focus-kit-version` below is untouched, so the stamp is compared by value and
never by bytes against `skills/`, where it does not exist. The `ok` line is
unchanged, as the delivery's States section required.

**The absent branch, and why it is two `die`s and not one.** The first draft
read `installed="absent"; [ -f "$stamp" ] && installed="$(cat "$stamp")"`,
one `die` covering both cases. It works under `set -euo pipefail`, which was
the doubt worth testing: a failing `[ -f ]` on the left of an `&&` is exempt
from `set -e`, so the script does not exit silently, and the provoked run
printed `check 6: the dogfood copy is at absent and VERSION is 0.4.4`. It was
rewritten as two branches for the message, not for the control flow: "the
dogfood copy is at absent" is not English. The absent case now reads:

```
error: check 6: the dogfood copy has no .focus-kit-version (run focus-kit install .)
```

provoked by moving the file aside, confirmed to exit 1, and the file restored
in the same command.

**The red, on this tree, before the install.** Exactly the line the delivery
predicted:

```
focus-kit 0.4.4 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
error: check 6: the dogfood copy is at 0.4.2 and VERSION is 0.4.4 (run focus-kit install .)
```

Exit code 1, checked separately because the `sed` that strips the colour
codes would otherwise report its own.

**The green, after `focus-kit install .`.**

```
focus-kit 0.4.4 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

`git status --short` after the install showed
`.claude/skills/.focus-kit-version` as the only file the install moved: the
two JSON merges wrote nothing new, which is what an idempotent install on a
tree already at the kit's content should do.

**Divergence from the plan.** Two, both cosmetic.

*The delivery's first Behaviour bullet was stale.* It says `VERSION` reads
`0.4.1` and the stamp `0.4.0`; the tree read `0.4.3` and `0.4.2`, because
`graphify-mcp-starts` and `selftest-reads-the-merged-json` landed between the
proposal and this run. The Contract section already quoted the right pair,
`0.4.2` and `0.4.4`, so nothing in the work changed. Recorded here rather
than edited into the page, per `docs/05-Process.md` §6: what the command
produced wins.

*A seventh doc place, not in the table.* `docs/01-Architecture.md` §3 lists
each function with its line number, and the three new statements pushed
`selftest` from 382 to 388. Refreshed against the printout. The six
`check_*` line numbers in the prose below the table are unchanged, since
`check_dogfood` grew from its inside.

**What was dropped.** Nothing.

## Abstraction

None taken. Reading `.claude/skills/.focus-kit-version` and comparing it with
`$KIT_VERSION` is the second occurrence; the first is `doctor`
(`bin/focus-kit:225`), which does the same comparison over an arbitrary
target and answers with a `warn`. They were not merged: `doctor` reports on
someone else's repository and tolerates a stale stamp, `check_dogfood`
asserts on this one and dies. What they share is a path and an `=`.

## Decisions

No ADR. The rule is an addition to an existing one in `docs/05-Process.md`
§5, not a choice between alternatives: the dogfood copy was already required
to be in sync, and this delivery says that the version stamp is part of being
in sync. The reason is written where the rule is.

## Environments

| Environment | State |
|---|---|
| Kit source (`bin/focus-kit`, `VERSION`) | 0.4.4, the truth. `VERSION` bumped in this delivery, because check 6 is CLI behaviour. |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.4.4. `focus-kit install .` was run, which is what this delivery makes the rule. `.claude/skills/.focus-kit-version` reads `0.4.4` and check 6 is green. |
| Machine (`~/.local/bin/focus-kit`) | untouched. It is a symlink to the kit source: `focus-kit version` prints `0.4.4`. |
| Target repositories | untouched. They move when their owner runs `focus-kit update <path>`. |

`focus-kit doctor .` in this repository prints `✓ kit version 0.4.4`. The
warning that `selftest-reads-the-merged-json` left behind is gone, and from
here it cannot come back silently: check 6 is red the moment the two numbers
differ.
