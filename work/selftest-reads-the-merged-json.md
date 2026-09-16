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

* [ ] `bin/focus-kit selftest` green, six lines as today.
* [ ] Provoked red, then reverted: a PATH with bash, git and coreutils only
  gives the red run above; a scratch `.mcp.json` overwritten with `{}`
  between install and assertion is caught by the first `die` in the table.
  Both recorded in the done page.
* [ ] `focus-kit install` into a scratch repository with the same PATH dies
  at the same message it dies at today.
* [ ] `VERSION` is `0.4.3`. No skill or manual changed, so `focus-kit
  install .` is not run here and check 6 is green as it is.
* [ ] `docs/05-Process.md` §4, `docs/04-Conventions.md` §4,
  `docs/01-Architecture.md` §3 and §6, `docs/03-Domain.md` updated where
  named above.
* [ ] Environments: kit source and dogfood copy at 0.4.3, machine follows the
  symlink, targets untouched.
