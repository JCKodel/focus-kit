# selftest-reads-the-merged-json

**Goal.** A person running `bin/focus-kit selftest` learns when the two JSON
merges did not happen, instead of a green run over a scratch repository
whose `.mcp.json` is `{}`.

**Behaviour.**

* With neither `python3` nor `uv` on PATH, `selftest` is red at check 2 and
  the detail names python3. Today it is green: `die` inside `$(python_bin)`
  ends only the subshell, `install_repo` runs under `||` where `set -e` is
  off, and check 2 only asks whether `.mcp.json` exists. Reproduced on
  Ubuntu 24.04 with a PATH holding bash, git and coreutils only.
* `focus-kit install` at top level keeps dying with the same message it dies
  with today. Nothing changes for a person installing.
* Check 2 reads what the merges wrote. A scratch repository whose `.mcp.json`
  has no graphify server, or whose `.claude/settings.json` has no graphify in
  `enabledMcpjsonServers` or no baseline permission, is red with a `die`
  naming the file.
* A green run prints the same six lines it prints today.

**Contract.**

`python_bin` stops dying. It echoes the interpreter and returns 0, or prints
nothing and returns 1. `merge_json` becomes the place that dies:

```
py="$(python_bin)" || die "python3 not found (and uv is not installed to supply one)"
```

The message is unchanged, so `docs/04-Conventions.md` §4 still cites it.
That section gains the rule this delivery is the second occurrence of, the
first being the captures in `check_install` (`work/done/kit-selftest.md`,
What happened): **a function whose output is captured never calls `die`;
it returns non-zero and the caller dies.** `docs/01-Architecture.md` §6
gets the same sentence next to its four rules.

`check_install`, after the doctor assertions, greps the scratch with
`grep -qF`:

| File | Must contain | `die` when absent |
|---|---|---|
| `.mcp.json` | `"graphify-mcp"` | `check 2: .mcp.json in the scratch repository has no graphify server (the JSON merge did not run)` |
| `.claude/settings.json` | `"enabledMcpjsonServers"` and `"Bash(graphify *)"` | `check 2: .claude/settings.json in the scratch repository was not merged (the JSON merge did not run)` |

Pure bash, no python: the assertion must hold when python is what is
missing. `docs/05-Process.md` §4 item 2 says the check reads the two merged
files; `docs/03-Domain.md` scratch repository row says the same in half a
line.

`VERSION` goes to `0.4.3`: `selftest` is CLI behaviour.

**Slice.** The CLI, `bin/focus-kit`: `python_bin`, `merge_json`,
`check_install`. This repository's docs. No target receives anything new.

**States.** Green: unchanged. Red with no python and no uv:

```
focus-kit 0.4.3 selftest
  ✓ 1 bin/focus-kit parses
installing focus-kit 0.4.3 into /tmp/.../scratch
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ work/done/
error: python3 not found (and uv is not installed to supply one)
error: check 2: the install into the scratch repository failed
```

The captured install output and its `die` reach the screen before check
2's own `die`, through the capture pattern that already exists.

**Visual reference.** No UI. The lines above.

**Out of scope.**

* Making `python_bin` find a python that `command -v` reports but that does
  not run: `windows-git-bash` owns the probe.
* Passing the baseline as data rather than source: `merge-json-by-argument`.
* Validating the merged files as JSON: `merge_json` wrote them with
  `json.dump`, and a grep is what runs without python.

**Done when.**

* [x] `bin/focus-kit selftest` green, six lines as today.
* [x] Provoked red, then reverted: a PATH with bash, git and coreutils only
  gives the red run above; a scratch `.mcp.json` overwritten with `{}`
  between install and assertion is caught by the first `die` in the table.
  Both recorded in the done page.
* [x] `focus-kit install` into a scratch repository with the same PATH dies
  at the same message it dies at today.
* [x] `VERSION` is `0.4.3`. No skill or manual changed, so `focus-kit
  install .` is not run here and check 6 is green as it is.
* [x] `docs/05-Process.md` §4, `docs/04-Conventions.md` §4,
  `docs/01-Architecture.md` §3 and §6, `docs/03-Domain.md` updated where
  named above.
* [x] Environments: kit source and dogfood copy at 0.4.3, machine follows the
  symlink, targets untouched.

---

## What happened

Four hunks in `bin/focus-kit`, 18 insertions and 3 deletions, and a sweep of
the line references in the docs. The contract was followed as written;
nothing was dropped and nothing was added.

**The code.** `python_bin` (`bin/focus-kit:53`) ends in `return 1` instead of
`die`, with four lines of comment saying why, because a bare `return 1` in a
script whose other failure paths all die reads like an omission. `merge_json`
carries the message now, on one line (`bin/focus-kit:119`), the same bytes it
printed before. `check_install` gains eleven lines after the doctor
assertions: five of comment, one `grep -qF` for `.mcp.json` and a two-value
loop for `.claude/settings.json`. The loop is a loop for the same reason the
doctor assertion above it is: two values, one message, one place to add a
third.

**What the bug actually looked like.** Worth recording, because the delivery
page described it and this run measured it. Same restricted PATH, same
machine, HEAD against the working tree:

```
=== HEAD (0.4.2) ===
focus-kit 0.4.2 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
exit: 0
```

A full green over a scratch repository with no merge in it, on a machine
with no interpreter at all. Checks 3 to 6 pass because nothing they touch
needs python, and check 3 in particular compares two equally unmerged trees
and finds them identical.

**The red, provoked.** The working tree under the same PATH:

```
=== working tree (0.4.3) ===
focus-kit 0.4.3 selftest
  ✓ 1 bin/focus-kit parses
installing focus-kit 0.4.3 into /var/folders/.../tmp.SEbQLGjajG/scratch
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ work/done/
error: python3 not found (and uv is not installed to supply one)
error: check 2: the install into the scratch repository failed
exit: 1
```

Byte for byte the States block of the delivery page, down to the order of
the two `error:` lines.

**The second red, provoked and reverted.** A temporary line inserted between
the install capture and the doctor capture, run, then removed:

```
  echo '{}' > "$scratch/.mcp.json"   # TEMPORARY, provoking the red

focus-kit 0.4.3 selftest
  ✓ 1 bin/focus-kit parses
error: check 2: .mcp.json in the scratch repository has no graphify server (the JSON merge did not run)
```

The same line pointed at `.claude/settings.json`, which the delivery did not
ask for but which is the table's second row:

```
focus-kit 0.4.3 selftest
  ✓ 1 bin/focus-kit parses
error: check 2: .claude/settings.json in the scratch repository was not merged (the JSON merge did not run)
```

Both temporary lines were removed and `git diff bin/focus-kit` confirmed
only the four intended hunks remain.

**The install at top level, item 3.** It dies at the same message, and the
run is worth reading twice because the reason is not the obvious one. With a
PATH of bash, git and coreutils, `focus-kit install` never reaches
`merge_json`: `ensure_uv` finds no uv, tries to `curl` the installer, and
dies there. So the comparison was run on `install_repo` directly, which is
the same function the CLI calls after the dependency phase and the one the
delivery means by "at top level":

```
=== HEAD, install_repo with no python and no uv ===
installing focus-kit 0.4.2 into .../t-old
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ work/done/
error: python3 not found (and uv is not installed to supply one)
HEAD exit: 1

=== working tree, install_repo with no python and no uv ===
installing focus-kit 0.4.3 into .../t-new
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ work/done/
error: python3 not found (and uv is not installed to supply one)
working tree exit: 1
```

Identical apart from the version number. The reason is structural rather
than lucky: at top level `merge_json` is called outside any command
substitution, so its `die` is the script's own exit, which is exactly the
behaviour `python_bin` had before and could not have inside `$(...)`.

**How the restricted PATH was built**, since the delivery page names Ubuntu
and this machine is macOS, where `/usr/bin/python3` cannot be removed from a
PATH by trimming directories. A directory of symlinks, one per tool the
script needs (`bash git mktemp grep diff awk cp rm mkdir cat dirname
basename readlink touch ls`), then `env -i PATH="$D" HOME="$HOME"`. The
first attempt built a broken `grep` symlink, because `command -v grep` in
the session's shell answered with an alias name rather than a path, and the
run failed with `grep: command not found` instead of the expected message.
Worth the note: a proof that depends on a hand-built PATH has to assert what
is absent **and** that what is present still runs. The second attempt
probed `python3`, `uv`, `curl` and `grep` before trusting the result.

**Divergence from the plan.** One, and it is additive. The delivery named
`docs/01-Architecture.md` §3 for the `python_bin` row, and the row did
change. What it did not name is that the edit moves line numbers twice
over: the four-line comment above `python_bin` pushes everything from line
53 down by four, and the eleven-line block in `check_install` pushes
everything below it by eleven more. The docs cite `bin/focus-kit:<line>` in
22 places, and 14 of them were stale after the edit. They were all
refreshed and then verified mechanically, by printing the source line each
reference points at, rather than by eye. `docs/04-Conventions.md` §1 asks
for a document that says what is; a line reference that lands on the wrong
line says nothing at all.

The stale references were in `docs/00-Product.md` (2),
`docs/01-Architecture.md` (4), `docs/03-Domain.md` (2),
`docs/04-Conventions.md` (2), `docs/adr/ADR-0001` (1) and
`docs/adr/ADR-0002` (3). `docs/01-Architecture.md` §3 carries two more
lists of numbers that are not written as references and were stale too: the
seven-row function table and the six check functions named in the prose
below it. Both were refreshed against the same printout.

Two ADRs are edited here. That is a pointer refresh and not a decision
change, and it follows the precedent of `graphify-mcp-starts`, which did the
same.

## Abstraction

None taken. The two new `grep -qF` assertions in `check_install` are the
second occurrence of "assert a fixed string is in a file in the scratch",
the first being the doctor-line loop three lines above. They were not
merged into one helper: the two loops answer different questions, one about
what `doctor` reported and one about what the merge wrote, and their `die`
messages have different shapes. What they share is two lines of bash.

## Decisions

No ADR. The rule this delivery introduces is a convention, not a decision
with alternatives worth recording: **a function whose output is captured
never calls `die`; it returns non-zero and the caller dies.** It lives in
`docs/01-Architecture.md` §6, next to the four rules it belongs with, and in
`docs/04-Conventions.md` §4 with its two occurrences named. The second
occurrence is what this delivery fixed; the first was already in the code
and is cited from `work/done/kit-selftest.md`.

## Environments

| Environment | State |
|---|---|
| Kit source (`bin/focus-kit`) | 0.4.3, the truth. `VERSION` bumped in this delivery. |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | in sync with the kit source: no skill and no manual changed, so `focus-kit install .` was not run and check 6 is green. The stamp `.claude/skills/.focus-kit-version` still reads `0.4.2`, which is the drift `version-bump-ends-with-install` exists to close and which that delivery's page already quotes as `0.4.2`. |
| Machine (`~/.local/bin/focus-kit`) | untouched. It is a symlink to the kit source, so `focus-kit version` prints `0.4.3` as soon as this is on disk. |
| Target repositories | untouched. They move when their owner runs `focus-kit update <path>`. |

`focus-kit doctor .` in this repository warns `kit version 0.4.2 installed,
0.4.3 available`. That warning is correct and expected: it is the exact
symptom `version-bump-ends-with-install`, the next line in the queue, turns
into a red check 6.
