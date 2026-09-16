# Architecture

How focus-kit is built. What the product **is** lives in
`docs/00-Product.md`; the vocabulary in `docs/03-Domain.md`; the reason
behind each decision in `docs/adr/`. The architecture the kit *teaches* is
FOCUS (`docs/manuals/focus.md`). The architecture the kit *has* is the
subject of this document, and the two are not the same thing. Section 3
says why.

---

## 1. The design in one sentence

One bash script copies a fixed set of markdown files into a repository and
merges two JSON files, and everything else in the kit is content that the
script moves.

## 2. Stack

```
Language    bash 3.2 (the macOS default) · one script, bin/focus-kit
JSON        python3, invoked inline via a heredoc (bin/focus-kit:113)
Content     markdown: 3 skills, 3 manuals, 10 templates, 2 config fragments
Deps (host) uv · graphify (uv tool) · git · curl
Deps (kit)  none. Nothing is imported, nothing is linked, nothing is vendored
Tests       bin/focus-kit selftest, six checks in the script itself
CI          none
```

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
* **Subagents, hooks and MCP servers of the kit's own.** The only MCP server
  it installs is graphify's, and it installs it by declaring it, not by
  running it.

## 3. The four pieces in this codebase

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

Three verbs and four helpers, all in `bin/focus-kit`:

| Function | Line | What it does |
|---|---|---|
| `install_repo` | 130 | The whole install into a target: skills, manuals, `work/done/`, the two JSON merges, the gitignore fragment, the closing message. |
| `doctor` | 200 | Reports what is present on the machine and in the target, and whether the installed version matches `VERSION`. Reports only; it changes nothing. |
| `selftest` | 367 | The verify command: creates the scratch repository, calls the six checks in order, removes the scratch through a `trap ... EXIT`. |
| `copy_tree` | 107 | Overwrite a kit-owned tree: `rm -rf` the destination, then `cp -R`. |
| `merge_json` | 113 | Add to a JSON file without removing from it, through a python3 heredoc that takes an expression mutating `d`. |
| `python_bin` | 49 | Find a python3, falling back to `uv run`, and die with a clear message if there is none. |
| `ensure_uv`, `ensure_graphify` | 57, 73 | Make the machine ready. `ensure_uv` is a no-op when uv is there. `ensure_graphify` always runs `uv tool install 'graphifyy[mcp]'`: the `mcp` extra is what makes `graphify-mcp` start, and a machine that installed graphify without it gains it here. uv makes the step idempotent, not a branch in the script. |

Plus one function per check, between `doctor` and the dispatch, each ending
in an `ok` line or a `die`: `check_parses` (250), `check_install` (259),
`check_idempotent` (286), `check_frontmatter` (303), `check_no_em_dash`
(342), `check_dogfood` (354). They are the six checks of
`docs/05-Process.md` §4 in that order, and `selftest` is nothing but the
list of calls.

The dispatch is a `case` over `$1` at the bottom of the file
(`bin/focus-kit:385`), and `--help` prints the script's own header comment
through `awk`, every comment line after the shebang up to the first line
that is not one, so the usage text and the documentation are the same bytes
however long the header grows.

The four message shapes are `say`, `ok`, `warn`, `die` (`bin/focus-kit:44`).
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

## 4. The layout

```
bin/focus-kit                     the CLI, one file
skills/<name>/SKILL.md            the three commands, kit-owned
skills/initialize/templates/      CLAUDE.md and docs/, mirrors the target tree
manuals/<name>.md                 the three manuals, kit-owned
config/settings.baseline.json     permissions merged into a target
config/gitignore.fragment         the block appended once to a target
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
| Read the kit's own files | Relative to `KIT_DIR`, resolved from the script's real path through symlinks (`bin/focus-kit:35`). Never relative to the caller's working directory. |
| Write a kit-owned file into a target | `copy_tree`: destination removed, then copied. Overwriting is the contract. |
| Write a merged file into a target | `merge_json`: read, mutate, write. Never removes a key it did not add. |
| Write an appended file | `.gitignore` only, guarded by the marker `# --- focus-kit ---`. |
| Touch a project-owned file | Never. The single read is `[ -f "$target/docs/00-Product.md" ]`, to choose which closing message to print (`bin/focus-kit:192`). |
| Install a machine dependency | `ensure_uv`, a no-op when uv is present and piping a remote script to `sh` when it is not, which is the installer uv publishes. `ensure_graphify` calls `uv tool install 'graphifyy[mcp]'` on every run and lets uv decide: already installed with the extra is a no-op, anything else is a reinstall that adds it. |
| Touch the user's home | Only `graphify install --platform claude`, and only when `~/.claude/skills/graphify/SKILL.md` is absent, because it also appends to `~/.claude/CLAUDE.md` (`bin/focus-kit:96`). |

The privacy boundary is trivial and worth stating anyway: the kit sends
nothing anywhere. `curl` appears once, to fetch the uv installer. Nothing is
uploaded, logged or reported.

## 6. Errors are values

bash has no Result type, and the kit does not pretend otherwise. What it has
instead is a discipline with the same shape:

* `set -euo pipefail` at the top (`bin/focus-kit:31`). An unhandled failure
  stops the script rather than continuing with a half-installed target.
* `die` is the only exit path for a failure the user has to fix: a missing
  python3, a missing directory, an unknown command. It prints in red to
  stderr and exits non-zero.
* `warn` is the value-shaped case: something is not as expected but the run
  is still correct. A target that is not a git repository, a missing
  `graphify-mcp`, a global skill that could not be installed. The run
  continues and the message stays on screen.
* `doctor` never fails. It reports. Its whole output is `ok` and `warn`
  lines, and a missing file is a `warn`, not a `die`, because the point of
  the command is to list what is missing.

The distinction is the book's (`docs/manuals/focus.md` §5): a failure that
is part of the flow becomes a value, and a failure that is a defect crashes.
Here, "value" is a `warn` line and a continuing run; "crash" is `die`.

## 7. Environments

| Environment | Where | How code gets there | Used for |
|---|---|---|---|
| Kit source | this repository, `skills/` `manuals/` `config/` `bin/` | a person edits and commits | the truth; everything else is a copy of it |
| Machine | `~/.local/bin/focus-kit`, a symlink | `ln -s` once, at setup | running the CLI anywhere |
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
