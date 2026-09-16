# doctor-checks-settings-json

**Goal.** A person running `focus-kit doctor` learns whether the two merged
files in the target still carry what `install` merged into them, so a
`.mcp.json` that declares the graphify server and a `.claude/settings.json`
that never enables it stop printing green.

**Behaviour.**

* In a target where both merged files are as `install` left them, `doctor`
  prints the `.mcp.json` line it prints today and, right under it, one new
  green line for `.claude/settings.json`. Nothing else in the output moves.
* In a target whose `.claude/settings.json` reads `{}`, or lost the
  `enabledMcpjsonServers` entry, `doctor` warns on that line and names
  `focus-kit update`, which merges the baseline back. The same for a
  `.mcp.json` that lost the graphify server. Presence alone no longer earns
  either green line: that is the finding of `first-target-install` (its
  second), and the reasoning check 2 of `selftest` already holds.
* A file that is absent warns, as today, and now names its fix.
* `doctor` still never dies and still needs no python: the reader is a
  fixed-string `grep` behind an `-f` guard, which is the choice check 2 made
  in `selftest-reads-the-merged-json` and for the same reason, the failure to
  catch is python missing. The strings are a heuristic: they cannot see under
  which key `"graphify"` sits, and the page accepts that.
* Check 2 of `selftest` stops reading the two files itself and asserts the
  two `doctor` lines instead, the way it asserts every other line, so the
  assertion and the reporter cannot drift. This is the second concrete
  occurrence of "read a merged file for a baseline string"; the first was
  check 2 itself. One probe proves the warn branch of both files on any
  machine.

**Contract.**

`bin/focus-kit`; `VERSION` goes from `0.7.0` to `0.8.0`, a new `doctor` line,
as `doctor-reports-drift` and `doctor-sees-a-stale-skill` were. No new helper
is required; if `/apply` writes one it reads and never dies
(`docs/01-Architecture.md` §6) and gets a row in `docs/01` §3.

`doctor`: `.mcp.json` leaves the presence loop at `bin/focus-kit:394` and the
loop ends at `docs/manuals/graphify.md`. Directly after the loop, before the
drift pass, one block for the two merged files, in install order. Each file:
`-f` first, because `grep` on an absent file exits 2 and prints; then
`grep -qF` for each string; the first failure decides the line.

| File | Strings | Line |
|---|---|---|
| `.mcp.json` | absent | `! .mcp.json missing (run focus-kit update)` |
| | no `"graphify-mcp"` | `! .mcp.json has no graphify server (run focus-kit update)` |
| | found | `✓ .mcp.json` (unchanged) |
| `.claude/settings.json` | absent | `! .claude/settings.json missing (run focus-kit update)` |
| | no `"enabledMcpjsonServers"` or no `"graphify"` | `! .claude/settings.json does not enable the graphify server (run focus-kit update)` |
| | all found | `✓ .claude/settings.json` |

No `without_cr`: a fixed substring inside a line is not touched by a CR at
the end of it. Neither path goes into the `$missing` list the drift pass
reads: merged files are not in the manifest, so there is nothing to
suppress; `.mcp.json` was added to it by the loop and that was dead.

`check_install`: `.claude/settings.json` joins the expected `ok` list at
`bin/focus-kit:495`; the two `grep` assertions at `:511` to `:516` go,
including the one on `"Bash(graphify *)"`, because one `merge_json` call
wrote the whole baseline and the enabled key proves it ran. In their place
one probe: both files are moved aside to `$SELFTEST_DIR`, beside the scratch
as the fake home is, each rewritten as `{}`, one `doctor` run must contain
both warns of the second row above, each built through `warn` as the drift
probes are, and both originals are moved back. A move back is byte-exact,
which check 3 needs when it snapshots this scratch; the trap removes anything
left beside it.

Documents, in the same delivery: `docs/03-Domain.md` row Merged gains that
`doctor` reads both files back and says whether the baseline's entry is
there; `docs/01-Architecture.md` §3 row `doctor` gains the two merged files,
and every `bin/focus-kit:NNN` in `docs/00`, `01`, `03` and `04` is recomputed
and resolved, as `doctor-sees-a-stale-skill` had to; `docs/05-Process.md` §4
check 2 says `doctor` reads the two files and the check asserts its lines and
runs the `{}` probe, and carries the "grep and not python" reason to where
the reader now is; `manuals/graphify.md` §Troubleshooting, first bullet, gains
a second cause for a server that fails to connect once the graph is there,
`.claude/settings.json` does not enable it, and `focus-kit doctor` says which.
Header line 7 stays. The finding in `work/done/first-target-install.md` is a
record and stays.

**Slice.** `bin/focus-kit` and `VERSION`, kit source; `manuals/graphify.md`,
kit-owned, copied to every target; this repository's docs, project-owned. No
skill, no template, no `config/`. The graph confirms `doctor` is reached from
the dispatch, `check_install` and `check_dogfood`, and `check_install` from
`selftest` alone.

**States.** The defaults. A target that is not a git repository is
unaffected. A target installed before `0.8.0` and not yet updated prints the
same lines: the strings were merged by every version that wrote the files.

**Visual reference.** No UI. `focus-kit doctor .` here, one line inserted:

```
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ .claude/settings.json
  ✓ kit-owned files as install wrote them
```

The scratch of the probe, both files `{}`:

```
  ! .mcp.json has no graphify server (run focus-kit update)
  ! .claude/settings.json does not enable the graphify server (run focus-kit update)
```

**Out of scope.**

* `.claude/settings.local.json` and the user-level settings, which Claude
  Code also reads: `doctor` reads the file `install` writes, and a warn on it
  is honest because `update` merges the key back.
* Parsing the JSON to prove `"graphify"` sits under the key: needs python,
  which is the thing the reader must not need.
* The eight `missing` warns for `docs/00` to `06` and `CLAUDE.md`:
  `every-warn-names-its-fix`.
* Lines for `.gitignore` and `work/done/`: the finding named only the
  settings, because only that file changes what a session can do.
* A run on the Windows host: `grep -qF` and `mv` are already exercised there.
* An ADR: one block in one function, cheap to reverse.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 2 asserting the two lines and
  running the `{}` probe.
* [x] `VERSION` at `0.8.0`; `focus-kit install .` run here; check 6 empty.
* [x] The done page carries `focus-kit doctor .` here after the change, and
  a scratch made by hand (`mktemp -d`, `git init`, install, both files
  rewritten as `{}`, `doctor`) showing the two warns.
* [x] `docs/01` §3, `docs/03` Merged, `docs/05` §4 and
  `manuals/graphify.md` §Troubleshooting updated as the Contract says.
* [x] Environments: kit source and dogfood copy at `0.8.0`; machine follows
  the symlink; first target updated to `0.8.0` by `focus-kit update
  ~/Downloads/vaulted`, its new line green because its settings already
  hold the key, nothing committed there; other targets untouched. The
  closing message names all five.

---

## What happened

Built as the page describes. Nothing was dropped and nothing diverged from
the plan.

**The code.** `doctor` lost `.mcp.json` from the presence loop, which now
ends at `docs/manuals/graphify.md`, and gained one block of two `if` chains
directly after it, in install order. Each is `-f` first, then `grep -qF` per
string, first failure decides. The `.mcp.json` line stays in the position it
had, so the only movement in the output is the new line under it. Neither
path is added to `$missing`: merged files are not in the manifest, so the
drift pass has nothing to suppress, and the `$missing` entry the loop used to
write for `.mcp.json` was dead.

`"graphify"` is a real test of the `enabledMcpjsonServers` entry and not a
match on the baseline permission `"Bash(graphify *)"`: the character before
`g` there is `(`, so the quoted string does not occur in it. Checked before
choosing it, because a string that matched the permission would have made the
settings line green on a file that enables nothing.

`check_install` gained `.claude/settings.json` in the expected `ok` list, lost
the two `grep` assertions and the now unused `key` local, and gained the `{}`
probe in their place: both files moved aside to `$SELFTEST_DIR`, each
rewritten as `{}`, one `doctor` run, both moved back, then the two `warn`
lines asserted. The move back happens before the assertions, so a red leaves
the scratch as check 3 expects it; the trap removes the two files if a die
lands between the move out and the move back.

**Abstraction.** The second concrete occurrence of "read a merged file for a
baseline string" did not become a helper. The first occurrence was check 2's
own two `grep` calls, and those are the ones that went: one reader is left,
inside `doctor`, and the check asserts its lines. Two occurrences collapsed
into one is not a place for an abstraction.

**No ADR**, as the page said: one block in one function.

## The proof

`bin/focus-kit selftest`, green, six checks:

```
focus-kit 0.8.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

`bin/focus-kit doctor .` here, after the change. The two merged lines are
green and adjacent, and the rest of the output is what it was:

```
focus-kit 0.8.0 doctor: /Users/jckodel/Projects/focus-kit
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.8.0
  ✓ docs/00-Product.md
  ✓ docs/01-Architecture.md
  ✓ docs/02-Backend.md
  ✓ docs/03-Domain.md
  ✓ docs/04-Conventions.md
  ✓ docs/05-Process.md
  ✓ docs/06-Queue.md
  ✓ CLAUDE.md
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ .claude/settings.json
  ✓ kit-owned files as install wrote them
  ✓ graphify-out/graph.json
  ✓ graphify post-commit hook
```

The scratch made by hand: `mktemp -d`, `git init`, `bin/focus-kit install`,
both merged files rewritten as `{}`, then `doctor`. The two warns, in place,
between the manuals and the drift line:

```
  ✓ docs/manuals/graphify.md
  ! .mcp.json has no graphify server (run focus-kit update)
  ! .claude/settings.json does not enable the graphify server (run focus-kit update)
  ✓ kit-owned files as install wrote them
```

Then both files deleted from the same scratch, for the absent branch:

```
  ! .mcp.json missing (run focus-kit update)
  ! .claude/settings.json missing (run focus-kit update)
```

Every line matches the Visual reference. The scratch was removed.

The graph was current and answered before the edit: `doctor()` at `L349`,
reached from the dispatch, `check_install()` and `check_dogfood()`, which is
what the Slice claimed.

## The documents

* `docs/01-Architecture.md` §3, row `doctor`: the two merged files, the
  strings, and the reason the reader is a `grep`. Rows `selftest` and the six
  `check_*` line numbers recomputed.
* `docs/03-Domain.md`, row Merged: `doctor` reads both files back, presence
  earns neither green line, a warn names `focus-kit update`.
* `docs/05-Process.md` §4, check 2: the two files are `doctor`'s to read and
  the check asserts its lines; the "grep and not python" reason moved to
  where the reader now is; the `{}` probe described.
* `manuals/graphify.md` §Troubleshooting, first bullet: the second cause of a
  server that fails to connect once the graph is there.
* Every `bin/focus-kit:NNN` in `docs/00`, `01`, `03` and `04` recomputed and
  resolved. Only one number moved, `:754` to `:797` for the dispatch, in
  `docs/00:91`, `docs/01:111` and `docs/04:66`, plus the seven function line
  numbers in the `docs/01` §3 table. Everything the docs cite at or below
  `:349` is above the insertion and was already right.
* Header line 7 of `bin/focus-kit` unchanged, as the page said.

## Environments

| Environment | State |
|---|---|
| Kit source | `0.8.0`. `bin/focus-kit`, `VERSION` and `manuals/graphify.md` edited here. |
| Dogfood copy | `0.8.0`. `focus-kit install .` run; check 6 green. |
| Machine (`~/.local/bin/focus-kit`) | `0.8.0` by the symlink; nothing to do. The global `/graphify` skill is at the package's version, `0.9.63`. |
| First target (`~/Downloads/vaulted`) | `0.8.0` by `focus-kit update ~/Downloads/vaulted`. Both merged lines green. That the entry was there before the update is inferred and not observed, because `update` rewrites the file before `doctor` can read it; the grounds are the delivery's own, that every version which wrote the file merged the entry in. Nothing staged, committed or pushed there. |
| Target repositories (anyone else's) | untouched. They move when their owner runs `focus-kit update`. |
