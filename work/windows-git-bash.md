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

* [ ] `bin/focus-kit selftest` green on macOS.
* [ ] On the Windows host the stakeholder provides over SSH, in Git Bash
  (`"C:/Program Files/Git/bin/bash.exe" -lc`): a clone with
  `core.autocrlf=true`, `bin/focus-kit selftest` green, `focus-kit install`
  into a scratch repository green, `doctor` there agrees, and the merged
  `.mcp.json` has LF endings (`file .mcp.json`). The transcript is the
  proof, in the done page.
* [ ] On the Windows host, with the Store stub as the only `python3`,
  `selftest` still runs: the probe skipped it.
* [ ] On Linux, `install` into a scratch repository holding a
  `pyproject.toml`, with `python3` hidden and uv present, leaves no `.venv`
  and no `uv.lock`.
* [ ] `VERSION` is `0.5.0`; `focus-kit install .` was run and check 6 is
  green.
* [ ] README, header comment, `docs/01` §2 and §3, `docs/05` §6 say the
  three platforms and the wrapper.
* [ ] Environments: kit source and dogfood copy at 0.5.0, machine follows the
  symlink, targets untouched.
