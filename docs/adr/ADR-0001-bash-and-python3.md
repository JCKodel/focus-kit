# ADR-0001: bash 3.2 and python3, and no other dependency

**Status:** accepted
**Date:** 2026-09-15

---

## Context

The kit has to install a set of files into somebody else's repository. That
repository may be C#, TypeScript, Python, Dart or anything else, and the
person running the installer has whatever their machine came with.

Two constraints were real when the decision was taken. macOS ships **bash
3.2** and has since 2007, for licensing reasons, so anything written for
bash 4 fails on the most likely machine. And the kit must not make a target
repository inherit a dependency: a .NET project that installs a delivery
process should not acquire a Node toolchain to do it.

The work itself is small: copy trees, append to a file, and merge two JSON
files by key without destroying what is already there. Only the last of
those is awkward in shell.

## Decision

`bin/focus-kit` is a single bash script written for bash 3.2, with no
associative arrays, no `mapfile`, no `${var,,}` and no `readlink -f`. The
symlink resolution at the top of the file is a hand-written loop for exactly
this reason (`bin/focus-kit:48`).

JSON merging goes through **python3**, called inline with a heredoc
(`merge_json`, `bin/focus-kit:338`). python3 is already present on macOS and
on every Linux the kit targets, and `python_bin` falls back to `uv run`
when it is not, dying with a clear message if neither exists.

Nothing else is a dependency of the kit. `curl` and `git` are assumed.
**uv** and **graphify** are installed by the script onto the machine, not
into the target repository, and the target keeps no reference to either
except the `graphify-mcp` line in its `.mcp.json`.

**2026-09-17, `mcp-leaves-the-baseline`:** that last reference is gone. The
kit no longer writes `.mcp.json` and installs graphify without the `mcp`
extra, so a target now keeps no reference to either dependency at all.

Node is not required by the kit. jq is not used: it would add a dependency
to save a few lines of the python3 that is already there.

## Consequences

Easier: the script runs on a stock macOS and a stock Linux with nothing
installed. A target repository can delete the kit and lose nothing from its
own build. There is no version skew between the kit and a runtime.

Harder: every contributor has to remember bash 3.2. The constraint is
invisible on Linux, where bash 5 is normal and bash-4 syntax works fine
locally and breaks for the next person. This is why the verify command's
first check is `bash -n` and why an install into a scratch repository is
non-negotiable (`docs/04-Conventions.md` §5).

Forbidden: any new dependency of the kit itself, any bash-4 feature, and any
change that makes a target repository depend on something it did not already
have.

Revisit when: the script stops being about copying files. If the kit grows
logic that has to be tested at a finer grain than "did the install work",
bash stops paying its way and the language question reopens.

## Alternatives considered

*Inferred from the constraints stated in `CLAUDE.md`, `README.md` and the
header of `bin/focus-kit`. No record of the deliberation exists, and the
date above is the commit date of `06e923f`, not a recorded decision date.
The stakeholder confirms or amends.*

* **Node and npm.** Lost: it would make the kit a package, which is a real
  benefit, at the cost of a runtime dependency on machines where the target
  project has nothing to do with JavaScript.
* **Python only, no bash.** Lost: the script's core is file copying and path
  resolution, which shell does natively, and a Python entry point would
  still need a shebang and a PATH story.
* **jq for the JSON merges.** Lost: one more thing to install, to save
  fewer than ten lines.
* **Requiring bash 4 and telling macOS users to `brew install bash`.** Lost:
  the first thing the installer does cannot be to ask the person to install
  a different shell.
