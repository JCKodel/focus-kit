# windows-git-bash

**Goal.** A person on Windows with Git for Windows installs the kit from Git
Bash, and `bin/focus-kit selftest` is green there. WSL already behaves as
Linux and gets its line in the docs.

**Behaviour.**

* A clone on Windows with `core.autocrlf=true` still runs: `bin/focus-kit`
  and every `.md` check out with LF, so bash does not die on `\r` and check
  4 still matches `---`.
* `python_bin` picks an interpreter that runs, not one that `command -v`
  reports. On Windows `python3` is often the Microsoft Store stub, which is
  on PATH and fails when executed, and python.org installs `python`, not
  `python3`.
* The two merged files are UTF-8 with LF on every platform, and a target's
  `.claude/settings.json` with non-ASCII content survives the merge. Today
  a native Python on Windows writes CRLF in the system code page.
* The uv fallback inside a target that has a `pyproject.toml` leaves no
  `.venv` and no `uv.lock` behind. Reproduced on Ubuntu 24.04: today it
  creates both.
* `focus-kit` reaches PATH on Windows through a two-line wrapper, because
  `ln -s` in Git Bash copies the file and the copy cannot find `KIT_DIR`.
* The docs say where the kit runs: macOS, Linux, Windows through WSL (as
  Linux) or Git Bash. GoW and PowerShell without Git Bash are not named.
* `ensure_uv` is unchanged: the installer uv publishes recognises
  CYGWIN, MSYS and MINGW and installs to `$HOME/.local/bin`, which is
  `%USERPROFILE%\.local\bin`.

**Contract.**

New file `.gitattributes` at the root of this repository, not copied to
targets:

```
bin/focus-kit                 text eol=lf
VERSION                       text eol=lf
config/gitignore.fragment     text eol=lf
config/settings.baseline.json text eol=lf
*.md                          text eol=lf
```

`VERSION` is in the list because `KIT_VERSION` is a `cat` of it, and a
`\r` there would reach every target's `.focus-kit-version`; the two config
files because one is appended verbatim into targets and the other is
parsed. `python_bin`, in order, first hit wins; each candidate is probed by
running `-c 'import json, sys; sys.exit(sys.version_info[0] != 3)'` with
output discarded, so a `python` that is 2.7 is skipped too:

| Candidate | Echoes |
|---|---|
| `python3` runs | `python3` |
| `python` runs | `python` |
| `uv` on PATH | `uv run --no-project --python 3.12 python` |
| none | returns 1 (`selftest-reads-the-merged-json` makes `merge_json` die) |

`merge_json`'s heredoc opens the file with `encoding="utf-8"` to read and
`"w", encoding="utf-8", newline="\n"` to write. Nothing else in the
heredoc changes.

Header comment line: "Runs on macOS (bash 3.2), Linux, and Windows through
WSL or Git Bash." `README.md` Requirements: the same sentence, plus a
Windows paragraph under "Install the kit on this machine" with the wrapper:

```
printf '#!/usr/bin/env bash\nexec bash "$HOME/Projects/focus-kit/bin/focus-kit" "$@"\n' > ~/.local/bin/focus-kit
chmod +x ~/.local/bin/focus-kit
```

`README.md` layout line and `docs/01-Architecture.md` §2 Stack say the same
three platforms. `docs/01-Architecture.md` §3, `python_bin` row: "Find a
python that runs". `docs/05-Process.md` §6 gains one sentence: a change
that claims a platform is proven by the verify command on that platform.

`VERSION` goes to `0.5.0`: a new platform is CLI behaviour a target wants.

**Slice.** The CLI, `bin/focus-kit`: `python_bin`, `merge_json`, header.
This repository's `.gitattributes`, `README.md`, `docs/01`, `docs/05`. No
skill, manual, template or config fragment changes.

**States.** The defaults. A Windows machine with no python and no uv reaches
`ensure_uv` first on `install`, and the `python3 not found` die only on
`selftest`, exactly as on Linux.

**Visual reference.** No UI. The green `selftest` run, unchanged, printed
by Git Bash on the Windows host.

**Out of scope.**

* The Python expression travelling through argv, which MSYS may rewrite
  when it looks like a POSIX path: `merge-json-by-argument` moves the data
  off argv and owns that.
* GoW: last released in 2014 with bash 3.1 and no `mktemp`, `readlink`,
  `git` or `python`. Not named in the docs, not supported.
* PowerShell or CMD without Git Bash: the skills run in Claude Code's Bash
  tool, which on native Windows is Git Bash.
* A Windows CI: there is no CI (`docs/01-Architecture.md` §2).
* Files under `/mnt/c` from WSL: slow and without exec bits; the docs say
  the clone lives on the WSL side, nothing in the CLI changes for it.

**Done when.**

* [x] `bin/focus-kit selftest` green on macOS.
* [x] On the Windows host the stakeholder provides over SSH, in Git Bash
  (`"C:/Program Files/Git/bin/bash.exe" -lc`): a clone with
  `core.autocrlf=true`, `bin/focus-kit selftest` green, `focus-kit install`
  into a scratch repository green, `doctor` there agrees, and the merged
  `.mcp.json` has LF endings (`file .mcp.json`). The transcript is the
  proof, in the done page.
* [x] On the Windows host, with the Store stub as the only `python3`,
  `selftest` still runs: the probe skipped it. The stub was simulated; the
  real one is unreachable from Git Bash, and What happened says why.
* [x] On Linux, `install` into a scratch repository holding a
  `pyproject.toml`, with `python3` hidden and uv present, leaves no `.venv`
  and no `uv.lock`.
* [x] `VERSION` is `0.5.0`; `focus-kit install .` was run and check 6 is
  green.
* [x] README, header comment, `docs/01` §2 and §3, `docs/05` §6 say the
  three platforms and the wrapper.
* [x] Environments: kit source and dogfood copy at 0.5.0, machine follows the
  symlink, targets untouched.

---

## What happened

Everything the page asked for was built and proven, on three machines:
macOS, Ubuntu 24.04.4 and a Windows 11 host in Git Bash. The Windows run is
transcribed below, because §6 of `docs/05-Process.md`, in the sentence this
delivery added to it, says a change that claims a platform is proven by the
verify command on that platform, and `README.md`, the CLI's header and
`docs/01` §2 now claim Windows.

The one question that could have stopped the delivery is settled: **MSYS did
not rewrite the expression travelling through argv.** The merged
`.claude/settings.json` on the Windows host came out with every baseline
permission and `enabledMcpjsonServers` intact, so this delivery does not wait
on `merge-json-by-argument`, and that queue line keeps its own reason to
exist (a quote in the JSON) without inheriting this one.

### Proven here

| What | Where | Result |
|---|---|---|
| The verify command | macOS (Darwin 25.6), bash 3.2 | six `ok` lines, green at 0.5.0 |
| The verify command | Ubuntu 24.04.4, bash 5.2.21 | green |
| The verify command | Windows 11, Git Bash (MINGW64, bash 5.3.15, git 2.55.0) | green |
| The probe skips an interpreter that does not run | all three, with `python3` and `python` replaced by stubs exiting 9009, first on PATH | green every time; `python_bin` echoed `uv run --no-project --python 3.12 python` |
| The uv fallback leaves no `.venv` and no `uv.lock` | Ubuntu 24.04.4, `install` into a scratch repository holding a `pyproject.toml`, `python3` hidden, uv 0.12.15 | both absent; the whole install green |
| The same, counterfactual | macOS, `uv run --python 3.12 python` without `--no-project`, same directory | `.venv` and `uv.lock` both created, which is the defect the flag removes |
| Non-ASCII survives the merge | macOS, `LC_ALL=C LANG=C`, a target `.claude/settings.json` holding `Ködel, açúcar, 日本語` | the string is intact after the merge and the baseline permission is in |
| LF out of the merge | both hosts | no CR byte in `.mcp.json` or `.claude/settings.json` |
| The attributed paths are already LF in the index | `git ls-files --eol` | every one `i/lf`; no `git add --renormalize` needed |

The Ubuntu host is the stakeholder's `i7`, reached over SSH. Its proof
directories were removed afterwards.

### Divergences from the plan

* **The contract's `.gitattributes` has six lines, not five.**
  `.claude/skills/.focus-kit-version` is tracked and no other line covers
  it, so a Windows clone with `core.autocrlf=true` checks it out as
  `0.5.0\r\n`. `check_dogfood` reads it with `cat` and compares by value,
  so check 6 dies, and the message it prints is `the dogfood copy is at
  0.5.0 and VERSION is 0.5.0`. Reproduced here by writing the CRLF stamp by
  hand. The delivery's own argument for putting `VERSION` in the list is
  the argument for the stamp: it is read as a value, not as a file.
* **The header's second sentence changed too.** The contract named only the
  platform sentence. The sentence under it said `Needs curl and python3 (or
  uv, which can supply a python)`, and after this change a `python` that is
  3 also satisfies the CLI. It now reads `Needs curl and a python 3 on
  PATH, as python3 or as python (or uv, which can supply one)`, and
  `README.md` Requirements says the same. A document says what is
  (`docs/04-Conventions.md` §1).
* **`docs/01` gained a paragraph and lost its stale line numbers.** §2 has
  three sentences saying what Windows means here and naming the three
  mechanisms, because a platform line with no explanation sends the reader
  to the script. Growing `python_bin` by nine lines moved every function
  below it, so the §3 table, the six check line numbers, the dispatch and
  the four references in §5 and §6 were corrected in the same pass. The
  dispatch reference was already wrong before this delivery (399, and the
  `case` was at 406).
* **`file .mcp.json` cannot prove what the Done when asks of it.** The Done
  when says the merged `.mcp.json` has LF endings and names `file` as the
  way to see it. libmagic's JSON rule prints `JSON data` and `JSON text
  data` with no line-terminator clause, on both hosts, whatever the endings
  are. The run below counts the CR bytes instead (`tr -cd '\r' | wc -c`, and
  `0` is the proof), which is how it was checked on all three hosts.
* **`docs/04-Conventions.md` had four line references this change moved**,
  and they were corrected with the ones in `docs/01`: `:44` to 45, `:96` to
  110, `:35` to 36, and `:412` to 436, which was already wrong before this
  delivery. The file is otherwise untouched and outside the slice.
* **Nothing changed in `ensure_uv`**, as the delivery said. uv's own
  installer recognises MSYS and MINGW; it was not touched.

### Dropped

Nothing was dropped.

### Found, not fixed: the same stamp in a target on Windows

The sixth `.gitattributes` line protects this repository. A **target**
repository does not receive a `.gitattributes` (the delivery says so on
purpose), so a target cloned on Windows with `core.autocrlf=true` checks
out its own `.claude/skills/.focus-kit-version` as CRLF and `focus-kit
doctor` there compares `0.5.0\r` with `0.5.0` and warns that the target is
out of date when it is not. `selftest` never sees it, because it takes no
path. The fix belongs in the CLI, not in an attributes file the kit does
not ship: `doctor` and `check_dogfood` would strip a trailing `\r` when
reading the stamp. It is a queue line, not a widening of this delivery.

### The Windows run

The machine was reached over SSH, whose shell there is PowerShell 5.1, so
every command went through `& "C:\Program Files\Git\bin\bash.exe" -lc`. The
tree under test travelled as a tarball rather than as a clone of `main`,
because the fix was not committed yet and the `.gitattributes` proof needs a
clone whose history already has the file. A throwaway repository on the
Windows box gives exactly that, without touching this one: extract, `git
init`, one commit, then `git clone -c core.autocrlf=true` from it.

```
=== 0. the host ===
MINGW64_NT-10.0-26200 KMS-NB304 3.6.10-710e5275.x86_64 x86_64 Msys
bash 5.3.15(2)-release
git version 2.55.0.windows.5
core.autocrlf in this clone: true

=== 1. line endings after a clone with core.autocrlf=true ===
bin/focus-kit                     CR bytes: 0
VERSION                           CR bytes: 0
README.md                         CR bytes: 0
config/gitignore.fragment         CR bytes: 0
config/settings.baseline.json     CR bytes: 0
.claude/skills/.focus-kit-version CR bytes: 0
LICENSE                           CR bytes: 661

=== 2. which interpreters are on this machine ===
python3 -> none    python -> none    uv -> /c/Users/.../.local/bin/uv
graphify -> .../graphify    graphify-mcp -> .../graphify-mcp
python_bin chooses: uv run --no-project --python 3.12 python

=== 3. the verify command ===
focus-kit 0.5.0 selftest
  1 bin/focus-kit parses
  2 install into a scratch repository, doctor agrees
  3 the second install leaves the same tree
  4 the three SKILL.md frontmatters are well formed
  5 no em dash in the paths this repository authors
  6 the dogfood copies match their sources
selftest green: a target repository would receive a working kit
selftest exit 0

=== 4. a python3 that is on PATH and does not run ===
command -v python3 -> /c/Users/.../fk-stub/python3
python3 -c 1       -> Python was not found; run without arguments to install
                      from the Microsoft Store
0.4.4 python_bin would choose: python3
0.5.0 python_bin chooses:      uv run --no-project --python 3.12 python
focus-kit 0.5.0 selftest ... six ok lines ... selftest exit 0

=== 5. install into a scratch repository, and doctor there ===
installing focus-kit 0.5.0 into /c/Users/.../fk-target
  .claude/skills/{initialize,propose,apply}
  docs/manuals/{process,focus,graphify}.md
  work/done/
  .mcp.json (graphify server)
  .claude/settings.json (baseline permissions merged)
  .gitignore (kit fragment appended)
install exit 0
focus-kit 0.5.0 doctor: /c/Users/.../fk-target
  ok: uv, graphify, graphify-mcp (mcp extra), global /graphify skill,
      /initialize, /propose, /apply, kit version 0.5.0,
      the three manuals, .mcp.json
  warn: docs/00 to 06, CLAUDE.md, the graph, the hook
        (the ten a scratch repository legitimately produces)

=== 6. the two merged files ===
.mcp.json             CR bytes: 0
.claude/settings.json CR bytes: 0
```

`.claude/settings.json` came out with the ten baseline `allow` entries, the
four `ask` entries, the one `deny` entry and `enabledMcpjsonServers`, all
intact. That is the argv answer: **MSYS did not rewrite the expression.**

Line 4 is the whole delivery in five lines. The stub is a `python3` that is
on PATH and exits 9009, which is what the Microsoft Store redirector does.
0.4.4 asks `command -v` and picks it, and the install dies. 0.5.0 runs it,
sees it fail, and reaches uv.

### Three things the Windows run found

* **The real Store redirector is invisible to Git Bash on this machine.**
  `~/AppData/Local/Microsoft/WindowsApps/python3.exe` is there and points at
  `AppInstallerPythonRedirector.exe`, but it is an app execution alias, a
  reparse point bash does not resolve: with `WindowsApps` first on PATH,
  `command -v python3` still answers nothing. So the exact scenario could
  not be staged from its real source, and the stub above stands in for it.
  The danger the delivery named is not hypothetical, it simply arrives by
  another door on this host: from PowerShell, from a shell where the alias
  is enabled, or from a python.org install that provides `python` and not
  `python3`. The probe covers all three, because it asks the same question
  of every candidate.
* **The first run on that machine had no python and no uv**, and `selftest`
  died at check 2 with `python3 not found (and uv is not installed to
  supply one)`. That is the States section of this page, word for word, and
  it is the correct behaviour: `install` is what makes a machine ready, and
  it then installed uv 0.12.15 and graphify 0.9.63 with the mcp extra.
  The run above is the one after that.
* **After that install, a separate `doctor` reported uv, graphify and
  graphify-mcp missing.** `ensure_uv` exports `$HOME/.local/bin` into its
  own process, and on Windows that directory is not on a fresh Git Bash
  PATH, which uv's installer says in its own output. A new shell, or
  `. ~/.local/bin/env`, and `doctor` is green on all three. `README.md`
  gained one sentence about it, because a first install on Windows ends
  with a `doctor` that looks wrong and is not.

### A cost worth recording: the transport

The first tarball was built on macOS with `tar -czf`, and the files on this
volume carry a `com.apple.provenance` extended attribute. bsdtar wrote an
AppleDouble member beside each file and then hid those members from its own
`tar tzf` listing, so the archive looked clean here. GNU tar on Windows
materialised all 68 of them, and `._.focus-kit-version` landed inside
`.claude/skills/`, where `check_dogfood` compares trees and does not exclude
it. Check 6 went red for a reason that had nothing to do with the kit. The
fix is `COPYFILE_DISABLE=1` and `--no-mac-metadata`, and the lesson is that
a macOS tarball is not a neutral way to move a tree to another operating
system.

### Environments

| Environment | State |
|---|---|
| Kit source | 0.5.0. `.gitattributes`, `bin/focus-kit`, `VERSION`, `README.md`, `docs/01`, `docs/04`, `docs/05` edited and staged, not committed. |
| Dogfood copy | 0.5.0. `focus-kit install .` was run here; check 6 green. |
| Machine | untouched. `focus-kit version` prints 0.5.0 through the symlink. |
| Target repositories | untouched. |
| `i7` (Ubuntu 24.04.4, a proof host) | **changed.** It now has uv 0.12.15, graphify 0.9.63 with the mcp extra and the global `/graphify` skill, and its `~/.claude/CLAUDE.md` gained a graphify section. uv was approved; the rest came with `focus-kit install`. The proof directories under `/tmp` were removed. |
| The Windows host (a proof host) | **changed**, and it is the first time the kit touched it. Same three: uv 0.12.15, graphify 0.9.63 with the mcp extra, the global `/graphify` skill, and a graphify section in its `~/.claude/CLAUDE.md`. The proof directories in its home were removed; `~/fk-proof.txt` was left, and it is what this section transcribes. |
