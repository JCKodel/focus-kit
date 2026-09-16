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

* [ ] `bin/focus-kit selftest` red with the line above before `focus-kit
  install .`, green after. Both runs recorded in the done page.
* [ ] `focus-kit doctor .` here prints `kit version 0.4.4`.
* [ ] `VERSION` is `0.4.4` and `.claude/skills/.focus-kit-version` is
  `0.4.4` in the same commit.
* [ ] The six doc places in the table say the new rule.
* [ ] Environments: kit source and dogfood copy at 0.4.4, machine follows the
  symlink, targets untouched.
