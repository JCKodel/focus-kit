# Architecture

How focus-kit is built. What the product **is** lives in
`docs/00-Product.md`; the vocabulary in `docs/03-Domain.md`; the reason
behind each decision in `docs/adr/`. The architecture the kit *teaches* is
FOCUS (`docs/manuals/focus.md`). The architecture the kit *has* is the
subject of this document, and the two are not the same thing. Section 3
says why.

---

## 1. The design in one sentence

One bash script copies a fixed set of markdown files into a repository,
merges one JSON file and appends two fragments, and everything else in the
kit is content that the script moves.

## 2. Stack

```
Language    bash 3.2 (the macOS default) · one script, bin/focus-kit
Platforms   macOS · Linux · Windows through WSL (as Linux) or Git Bash
JSON        a python 3, invoked inline via a heredoc (bin/focus-kit:200)
Content     markdown: 3 skills, 3 manuals, 10 templates, 3 config fragments
Deps (host) uv · graphify (uv tool) · git · curl
Deps (kit)  none. Nothing is imported, nothing is linked, nothing is vendored
Tests       bin/focus-kit selftest, six checks in the script itself
CI          none
```

Windows means Git Bash, the shell Claude Code's Bash tool uses on a native
Windows machine, or WSL, which is Linux and needs nothing of its own. Three
things make Git Bash work and each is a line somewhere else:
`.gitattributes` in this repository checks the script and the markdown out
with LF, so bash does not die on a `\r`; `python_bin` probes an interpreter
by running it, because `python3` there is often the Microsoft Store stub;
and `~/.local/bin/focus-kit` is a two-line wrapper rather than a symlink,
because `ln -s` in Git Bash copies (`README.md`).

**Out, by decision** (they come in only by demonstrated need, and the
delivery that introduces one justifies it):

* **Node, npm, and any JavaScript.** The kit is markdown and bash. A target
  project's stack may need Node; the kit does not (`README.md`, Requirements).
* **bash 4 features.** No associative arrays, no `mapfile`, no `${var,,}`.
  macOS ships bash 3.2 and the script has to run there unchanged
  (`CLAUDE.md`).
* **jq.** JSON merging goes through python3, which is already required.
  Adding jq would add a dependency to save four lines.
* **A packaging system.** No npm package, no Homebrew formula, no pip
  distribution. Install is `git clone` plus a symlink (`README.md`).
* **A test framework.** There is no `bats`, no shunit2. The verify command
  is a verb of the kit itself, `focus-kit selftest` (`docs/05-Process.md`
  §4), and its checks are six bash functions in the same script.
* **A configuration file for the kit.** The kit has no settings of its own.
  What varies per project is a slot in that project's `docs/05-Process.md`.
* **Subagents, hooks and MCP servers.** None at all, since
  `mcp-leaves-the-baseline`. The kit declared graphify's server in a target's
  `.mcp.json` and enabled it in `.claude/settings.json`, and nothing the kit
  ships ever called it: the three commands drive the graphify CLI through
  Bash. Measured on 2026-09-17, before the delivery: 38 sessions in this
  repository and 347 in two targets, zero MCP calls. What a target paid was a
  process spawned at the start of every session. A future need for one is a
  delivery that names what would call it.

## 3. The practices in this codebase

| Practice | Answer | Here it is |
|---|---|---|
| Structure | neither slices nor layers: one file | `bin/focus-kit`, the whole CLI, plus the content it moves (§4) |
| Rules | none: there is no business rule to place | nothing decides here; the script copies (ADR-0003) |
| Errors | values | `warn` for a failure inside the flow, `die` for a defect (§6) |
| Tests | the project's own policy | `bin/focus-kit selftest`, six checks in the script itself (`docs/04-Conventions.md` §5) |

This repository answered the four Practice questions the way ADR-0003
already decided them: three against FOCUS's answer and one, errors as
values, with it. That is
the table `/initialize` writes into every project it sets up, and this one is
its own first target: a kit that offered a choice and then assumed the answer
in its own documents would be teaching the opposite of what it ships.

| Piece | Here it is | Lives in |
|---|---|---|
| View | does not exist | |
| Orchestrator | does not exist | |
| Use case | does not exist | |
| Repository | does not exist | |

This is not an omission and it is not a migration waiting to happen. FOCUS
is a four-piece architecture for software that has business rules, state to
publish and data to persist. This project has none of the three. It has a
script that copies files.

The manual's own criterion settles it (`docs/manuals/focus.md` §1): **every
layer pays its own way.** A layer earns its place only if it can point at a
verifiable gain that would vanish without it. Split `install_repo` into a
view, an orchestrator, a use case and a repository and nothing becomes
testable that was not, nothing becomes swappable that needed swapping, and
the only thing that grows is the number of files a reader has to open. That
is Card 4 of the anti-pattern table, layer by ceremony, applied to the kit
that ships the table.

### What does exist

Three verbs and ten helpers, all in `bin/focus-kit`:

| Function | Line | What it does |
|---|---|---|
| `install_repo` | 289 | The whole install into a target: skills, manuals, the manifest, `work/done/`, the one JSON merge, the two appended fragments, the closing message. |
| `doctor` | 359 | Reports what is present on the machine and in the target, whether the installed version matches `VERSION`, and which kit-owned files are not as `install` wrote them: it fingerprints every file the manifest names, reports a file the manifest names and the target does not have, and looks for files added inside the three skill folders. A path the presence lines above already named missing is not named a second time. **Every warn names the command that fixes it** (`docs/04-Conventions.md` §1): the two tool lines name `focus-kit update`, which is what installs uv and graphify; the eight project-owned files name `/initialize`, which is what writes them; the three skills and the three manuals carry the drift wording verbatim, because they are kit-owned and `update` is what restores them. That is why the eleven paths are two loops and not one, in the order the single loop printed. The Global skill gets one line whatever `global_skill_state` returns, green only on `equal`; the other four states name the two versions and the command that fixes it. The one Merged file gets a line, and the question there is not presence but content: a fixed-string `grep` behind an `-f` guard asks `.claude/settings.json` for `"Bash(graphify *)"`, because a file that reads `{}` exists and still leaves every permission unasked for. A `grep` and not python, as in check 2 of `selftest` and for the same reason: the failure to catch is python missing. Then the Leftover pass, two warns at most, the same `grep` behind the same guard, naming a hand removal instead of a command: an `.mcp.json` that still declares the graphify server and a `.claude/settings.json` that still enables it, both merged by a kit before `mcp-leaves-the-baseline` and left where they are by every `update` since. And the number, with the Unbumped change (`docs/03-Domain.md`) behind it: a target whose Installed version equals `VERSION` and whose kit-owned files the kit source has moved past. The question is asked only at an equal number, because a target stale by number already carries the one line that names the fix, and only when the manifest exists, because the compare is against what `install` wrote and never against the file on disk, which is what lets a file both edited locally and behind get two lines, each true. `KIT_DIR` is on every machine that runs `doctor`, since the kit is installed by clone and symlink and `KIT_VERSION` is read out of it at startup, so the question is asked in every target and not only here. One pipeline answers it: what `install` would write from today's source, in the manifest's own format, poured together with the manifest, sorted under `LC_ALL=C` and read by `uniq -u`, which keeps a line that appears once. A path appears once when its fingerprint moved, when the source no longer holds it, or when the source holds it and the manifest never listed it, and the three shapes print the one line, `<path> behind the kit source (run focus-kit update)`. The source side is enumerated the way `write_manifest` enumerates the target's, the three skill folders and `manuals/*.md`, so that behind means exactly what `update` would change: a `.DS_Store` beside `skills/` is never copied into a target, and a warn naming a command that would not clear it is a warn that lies (`docs/04-Conventions.md` §1). While any of those lines prints, the green `kit version <v>` line does not, so that green now means the number and the content both. Reports only; it changes nothing. |
| `selftest` | 988 | The verify command: creates the scratch repository, calls the six checks in order, removes the scratch through a `trap ... EXIT`. |
| `copy_tree` | 175 | Overwrite a kit-owned tree: `rm -rf` the destination, then `cp -R`. |
| `merge_json` | 192 | Merge a baseline file into a target file, through a python heredoc that takes two paths and nothing else, so a baseline holding a quote, a backslash or the sequence `'''` is data and never syntax. One rule decides every key: an absent key is taken, two objects merge recursively, two lists concatenate without duplicates, anything else is the baseline's; a key the baseline says nothing about is never reached. Four cases since `mcp-leaves-the-baseline`, which took the `mcpServers` carve-out with the baseline that needed it, and one caller. The heredoc names its encodings, UTF-8 in and UTF-8 with LF out, because python otherwise follows the system locale and writes CRLF in the code page on Windows. It is also where a missing python dies, because `python_bin` cannot. |
| `append_once` | 233 | Append a fragment to a target file the first time and never again. The marker it tests for is the fragment's own first line, read with `head -n 1`, so the marker the file receives and the marker the next run looks for are the same bytes and a third copy of the string does not exist. Returns 0 when it appended and 1 when the marker was already there; the `ok` line stays with the caller, because the two callers name two different files. A blank line goes in ahead of the fragment only when the target file already has something in it. Two callers, both in `install_repo`: `.gitignore` and `.graphifyignore`. |
| `without_cr` | 250 | `tr -d '\r'` over a file: the one place a carriage return is forgiven. A target cloned on Windows with `core.autocrlf=true` has every kit-owned file, the stamp and the manifest checked out as CRLF, and it receives no `.gitattributes`, so the tolerance belongs to the readers. Four callers: `installed_version`, `fingerprint`, the manifest reader inside `doctor`, and `global_skill_state`. It reads and never dies (§6). |
| `fingerprint` | 258 | The POSIX `cksum` CRC of a file read through `without_cr`, the size column dropped. `cksum` because POSIX specifies it and macOS, Linux and Git Bash all have it with no probe, so the manifest a Mac writes is the one those three read back. Written by `write_manifest`, compared by `doctor`. |
| `write_manifest` | 272 | Write `.claude/skills/.focus-kit-manifest`: one line per regular file under the three skill folders and per manual copied, `<crc> <path relative to the target>`, through `LC_ALL=C sort`. The stamp and the manifest are not in it. The sort is over the whole line, so the order is by CRC; what matters is that the same tree produces the same bytes, which check 3 requires. |
| `installed_version` | 355 | Read the Installed version out of a target: the stamp through `without_cr`, and nothing else trimmed. Its two callers are `doctor` and `check_dogfood`; it reads and never dies (§6). |
| `python_bin` | 63 | Find a python that runs. It probes `python3` then `python` by executing each one, because a name on PATH is not an interpreter: on Windows `python3` is often the Microsoft Store stub. Falls back to `uv run --no-project`. It echoes the interpreter and returns 0, or prints nothing and returns 1; it never dies, because its output is captured (§6). |
| `global_skill_state` | 103 | The state of the Global skill against the graphify package (`docs/03-Domain.md`), one captured line: `<state> <skill> <package>`, a number it could not read written as `-`. Five states: `missing`, `unknown`, `equal`, `older`, `newer`. It reads the Skill stamp through `without_cr` and the second word of `graphify --version`, and orders them numerically field by field through `sort -t. -k1,1n -k2,2n -k3,3n`, because a string comparison puts `0.9.10` before `0.9.8`. Two callers, `ensure_graphify` and `doctor`, which turn the one word into a line each. It reads and never dies (§6). |
| `ensure_uv`, `ensure_graphify` | 76, 128 | Make the machine ready. `ensure_uv` is a no-op when uv is there. `ensure_graphify` always runs `uv tool install graphifyy`, the package plain: the `mcp` extra left with `mcp-leaves-the-baseline`, and someone who runs `graphify-mcp` outside the kit installs it themselves. Unconditional and not behind a `command -v`, because that is the only way a machine that installed `graphifyy[mcp]` under an earlier kit reaches the plain requirement; uv makes the step idempotent, not a branch in the script, and it is not an upgrade, which is `uv tool upgrade graphifyy` and the person's call. It then acts on `global_skill_state`: `equal` and `newer` change nothing, every other state runs `graphify install --platform claude` and says which version it came from. |

Plus one function per check, between `doctor` and the dispatch, each ending
in an `ok` line or a `die`: `check_parses` (570), `check_install` (579),
`check_idempotent` (888), `check_frontmatter` (905), `check_no_em_dash`
(944), `check_dogfood` (956). They are the six checks of
`docs/05-Process.md` §4 in that order, and `selftest` is nothing but the
list of calls.

The dispatch is a `case` over `$1` at the bottom of the file
(`bin/focus-kit:1005`), and `--help` prints the script's own header comment
through `awk`, every comment line after the shebang up to the first line
that is not one, so the usage text and the documentation are the same bytes
however long the header grows.

The four message shapes are `say`, `ok`, `warn`, `die` (`bin/focus-kit:46`).
`warn` does not stop the run; `die` exits non-zero. A new message picks one
of the four rather than calling `echo` directly.

### If a piece ever appears

The moment the kit grows something that decides rather than copies, the
table above is filled in rather than argued with. The candidate named here
before the verify command existed was a check with a verdict to reach, and
`kit-selftest` is now the place to look. It did not produce one: each of the
six checks runs `bash -n`, an install, a `diff` or a `grep` and reports what
that produced. There is no rule to extract, nothing to call with literals,
and so the table stays empty. `check_frontmatter` is the closest, and it
reads a file line by line rather than deciding anything about one.

`merge_json` is the second closest, and `merge-json-by-argument` is where it
was looked at. It does hold a rule now, five ordered cases over a key, and
the rule is callable with literals: two dictionaries in, one dictionary out,
no filesystem. It still does not earn a row. A use case is where a business
rule lives, and merging two JSON files is not a rule of this business: it is
how a file gets written, which is the repository's work, and the repository
here is the filesystem itself. Extracting it would produce a second bash
function calling the same heredoc, and ADR-0003 is the standing answer to
that shape of consistency.

## 4. The layout

```
bin/focus-kit                     the CLI, one file
skills/<name>/SKILL.md            the three commands, kit-owned
skills/initialize/templates/      CLAUDE.md and docs/, mirrors the target tree
manuals/<name>.md                 the three manuals, kit-owned
config/settings.baseline.json     permissions merged into a target
config/gitignore.fragment         the block appended once to a target
config/graphifyignore.fragment    the block that keeps the kit out of the graph
VERSION                           one line
LICENSE                           AGPL-3.0-only, verbatim; never copied to a target
docs/                             this project's own documents (project-owned)
work/                             this project's own deliveries (project-owned)
.claude/skills/                   the dogfood copy of skills/
docs/manuals/                     the dogfood copy of manuals/
```

The organizing axis is ownership, not technical role. `skills/`, `manuals/`
and `config/` hold what goes into a target; `docs/` and `work/` hold what
belongs to this repository alone. A file's folder answers the question the
kit asks most often, which is whether `update` may overwrite it.

The one place the axis bends is `skills/initialize/templates/`, whose layout
mirrors the target's (`CLAUDE.md`, `docs/00` to `06`, `docs/adr/`) rather
than the kit's. That is deliberate: the template tree and the tree it
produces look the same, so a change to one is obvious in the other.

Nothing is shared between the three skills. Each `SKILL.md` is
self-contained and repeats what it needs, because they are read one at a
time by a session that has none of the others in context. That is not
duplicated knowledge in the DRY sense (`docs/manuals/focus.md` §6): the
house rules have exactly one authoritative representation, in
`manuals/process.md` §6, and the skills point at it.

## 5. Data access and boundaries

The kit touches the filesystem and nothing else. There is no network call
except the two dependency installers, no database, no state between runs.

| Situation | How |
|---|---|
| Read the kit's own files | Relative to `KIT_DIR`, resolved from the script's real path through symlinks (`bin/focus-kit:37`). Never relative to the caller's working directory. |
| Write a kit-owned file into a target | `copy_tree`: destination removed, then copied. Overwriting is the contract. The install then records what it wrote in `.claude/skills/.focus-kit-manifest` through `write_manifest`, which is kit-owned itself and rewritten on every run. It is the only record that tells a file someone edited from a file the kit has moved past, because a stale target differs from the kit source in every kit-owned file. |
| Write a merged file into a target | `merge_json`: read the file, read the baseline, merge, write. Never removes a key, and since `mcp-leaves-the-baseline` there is no carve-out: the one the `mcpServers` entry had left with the baseline that needed it. What an earlier kit merged and this one no longer ships therefore stays in the target, and `doctor` names it as a Leftover for the person to remove. |
| Write an appended file | `append_once`, for `.gitignore` and `.graphifyignore`. The guard is the fragment's own first line, read with `head -n 1`, so the marker the test looks for and the marker the file receives are the same bytes. Both files are the target's, versioned by the target, and `doctor` reports neither. |
| Touch a project-owned file | Never. The single read is `[ -f "$target/docs/00-Product.md" ]`, to choose which closing message to print (`bin/focus-kit:337`). |
| Install a machine dependency | `ensure_uv`, a no-op when uv is present and piping a remote script to `sh` when it is not, which is the installer uv publishes. `ensure_graphify` calls `uv tool install graphifyy` on every run and lets uv decide: the same requirement already installed is a no-op, anything else is a reinstall. |
| Touch the user's home | Only `graphify install --platform claude`, and only when `global_skill_state` says the Global skill is `missing`, `older` or `unknown` (`bin/focus-kit:159`). What it writes is graphify's, not the kit's: the skill, its `references/` and the Skill stamp, plus a section appended to `~/.claude/CLAUDE.md` when that file does not mention graphify yet. A skill `newer` than the package is never touched, because the installer would downgrade it. |

The privacy boundary is trivial and worth stating anyway: the kit sends
nothing anywhere. `curl` appears once, to fetch the uv installer. Nothing is
uploaded, logged or reported.

## 6. Errors are values

bash has no Result type, and the kit does not pretend otherwise. What it has
instead is a discipline with the same shape:

* `set -euo pipefail` at the top (`bin/focus-kit:33`). An unhandled failure
  stops the script rather than continuing with a half-installed target.
* `die` is the only exit path for a failure the user has to fix: a missing
  python, a missing directory, an unknown command. It prints in red to
  stderr and exits non-zero.
* `warn` is the value-shaped case: something is not as expected but the run
  is still correct. A target that is not a git repository, a global skill
  that could not be installed, a Leftover an earlier kit merged. The run
  continues and the message stays on screen.
* `doctor` never fails. It reports. Its whole output is `ok` and `warn`
  lines, and a missing file is a `warn`, not a `die`, because the point of
  the command is to list what is missing. A drifted file is a `warn` for the
  same reason: it reports, and what to do about it is the person's call.
* **A function whose output is captured never calls `die`; it returns
  non-zero and the caller dies.** A `die` inside `$(...)` exits the subshell
  and nothing else, so the caller reads an empty string and carries on as if
  nothing had happened. `python_bin` returns 1 and `merge_json` dies
  (`bin/focus-kit:63`, `bin/focus-kit:193`); `without_cr`, `fingerprint` and
  `installed_version` return the status of their `tr` and their callers keep
  their own `-f` guard on the file; `global_skill_state` guards its own two
  files and echoes `missing` or `unknown` where another function would fail;
  `write_manifest` returns the status of
  the pipeline it writes and `install_repo` carries it, which `check_install`
  captures; `check_install` captures `install_repo` and `doctor` the same
  way, and dies on their status.

The distinction is the book's (`docs/manuals/focus.md` §5): a failure that
is part of the flow becomes a value, and a failure that is a defect crashes.
Here, "value" is a `warn` line and a continuing run; "crash" is `die`.

## 7. Environments

| Environment | Where | How code gets there | Used for |
|---|---|---|---|
| Kit source | this repository, `skills/` `manuals/` `config/` `bin/` | a person edits and commits | the truth; everything else is a copy of it |
| Machine | `~/.local/bin/focus-kit`, a symlink, or a two-line wrapper on Windows | `ln -s` once, at setup (`README.md`) | running the CLI anywhere |
| Dogfood copy | this repository, `.claude/skills/` and `docs/manuals/` | `focus-kit install .` | using the kit on itself, in this session |
| Target repository | any other repository | `focus-kit install` or `focus-kit update` there | real use |

The kit source is the truth while building. The dogfood copy is the one that
goes stale without anyone noticing, because a session reads
`.claude/skills/initialize/SKILL.md` and not `skills/initialize/SKILL.md`:
edit the source, and the session you are in is still running the old
version. `docs/05-Process.md` §5 makes keeping it current a rule of every
delivery.

There is no production environment in the usual sense. The closest thing is
a target repository belonging to someone else, which is reached only when
that person runs `focus-kit update`, and never by anything this repository
does.

## 8. What is not rebuilt

Removed on purpose, from the project the kit came from. Each one was tried.
Bringing one back requires naming a concrete error that happened and that it
would have caught (`docs/manuals/process.md` §8):

* a formal spec, and a spec delta between deliveries
* an archiving step for finished work beyond moving the file to `work/done/`
* numbered tasks inside a delivery
* a gate between defining and implementing
* specialized subagents per role
* an architecture linter

Never built, and deliberately so:

* the four FOCUS pieces inside `bin/focus-kit` (§3 above)
* an abstraction over `copy_tree` and `merge_json`. They are two functions
  with one caller each. The second concrete occurrence has not happened.
* a configuration file for the kit
* any dependency the target repository would inherit
