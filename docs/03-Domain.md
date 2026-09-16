# Domain and ubiquitous language

**Project:** focus-kit
**Status:** active
**Last updated:** 2026-09-16

---

## Purpose

This document defines the entities of focus-kit, their invariants and the
**ubiquitous language** of the project.

It is the pivot document: every delivery in `work/`, every identifier in
code and every test uses the terms defined here. Each concept has exactly
one meaning, and the same concept never receives two names.

focus-kit is unusual in one way worth stating here: most of its domain is
made of files and paths rather than records in a database. A term's code
name is therefore often a path, a bash function, or a marker string. That
does not make it less normative. A delivery that invents a second name for
`work/done/` has broken the same rule as one that invents a second name for
an aggregate.

## Term in code

Concepts are defined in prose; every identifier in code, schema and API is
written in English, whatever language this document is in. So that the
translation from concept to identifier is made once and not renegotiated
file by file, each term declares its canonical code name. The table is
normative: no delivery may name in code a concept that is not here.

The listed form uses `camelCase` where a symbol is meant. The concrete
casing follows the artifact: `snake_case` for bash functions, lowercase
hyphenated for slugs and file names, uppercase for `VERSION`.

**A new concept enters here first**, with its code term, and only then
appears in a delivery.

### The kit and its parts

| Term | Code | Short meaning |
|---|---|---|
| Kit | `focus-kit` | This repository, and the thing it installs. Both senses are the same artifact: the repository is the kit's source, the installed files are the kit in a target. |
| CLI | `bin/focus-kit` | The single executable. Five verbs: `install`, `update`, `doctor`, `version`, `selftest`. |
| Kit version | `VERSION` | One line, semantic version. Read at startup into `KIT_VERSION` (`bin/focus-kit:45`). |
| Installed version | `.claude/skills/.focus-kit-version`, read by `installed_version()` | The kit version stamped into a target at install time. Written with LF; read with every carriage return removed, so a target cloned on Windows with `core.autocrlf=true` compares equal instead of reading `0.5.2` as not `0.5.2`. Nothing else is trimmed: a leading or trailing space is still a difference. The read goes through `without_cr()`, the one place a carriage return is forgiven. `doctor` compares it with `VERSION` to say whether the target is stale. In this repository it equals `VERSION` at every commit (check 6 of `selftest`). |
| Manifest | `.claude/skills/.focus-kit-manifest`, written by `write_manifest()` | What `install` wrote into a target: one line per kit-owned file, its fingerprint and its path relative to the target, sorted with `LC_ALL=C sort`, LF. Read by `doctor` to tell an edited file from a stale one, which comparing the target with the kit source cannot do once the kit has moved on. Kit-owned: rewritten on every install, never edited by hand. A target installed before it existed has none, and `doctor` says so. |
| Fingerprint | `fingerprint()` | The POSIX `cksum` CRC of a file's content read through `without_cr()`, so a Windows checkout with `core.autocrlf=true` fingerprints the same as the install that wrote the manifest. `cksum` because it is specified by POSIX and present on macOS, Linux and Git Bash without a probe. Written by `write_manifest`, compared by `doctor`. |
| Command | `skills/<name>/SKILL.md` | One of the three things a person types in Claude Code: `/initialize`, `/propose`, `/apply`. Called a skill by Claude Code and a command by this project; the two words mean the same thing here. |
| Manual | `manuals/<name>.md` | A kit-owned how-to document: `process.md`, `focus.md`, `graphify.md`. Copied to `docs/manuals/` of every target. |
| Template | `skills/initialize/templates/` | The skeleton of a document `/initialize` fills. Mirrors the target layout: `CLAUDE.md` and `docs/`. |
| Init comment | `<!-- init: ... -->` | Guidance written to `/initialize` inside a template. It says what goes in the section. `/initialize` fills the section and removes the comment; none may survive into a finished document. |
| Settings baseline | `config/settings.baseline.json` | The permissions and the `enabledMcpjsonServers` entry merged into a target's `.claude/settings.json`. Never replaces what is there. |
| MCP baseline | `config/mcp.baseline.json` | The graphify server entry merged into a target's `.mcp.json`. The entry it names under `mcpServers` is the kit's and is replaced whole; every other key in the file, other servers included, is kept. |
| Gitignore fragment | `config/gitignore.fragment` | The block appended once to a target's `.gitignore`, guarded by the marker `# --- focus-kit ---`. |
| License | `LICENSE` | The terms the kit is published under: GNU AGPL-3.0-only, verbatim so GitHub detects it. Lives only in this repository; the CLI never copies it. Terms outside it are granted only by the author (`docs/adr/ADR-0004`). |
| License notice | (one HTML comment line) | The single line naming the copyright holder, the license and the source repository. Carried by every kit-owned file a target receives and by the CLI's header, so a copy names its author wherever it is seen. |

### Ownership

| Term | Code | Short meaning |
|---|---|---|
| Kit-owned | `copy_tree()` | A file the CLI overwrites on every `install` or `update`: the three skills, the three manuals, the installed version and the manifest. Editing one inside a target is a change that the next update erases, and `doctor` reports it as drift. It is edited in this repository. The two data files carry no banner, because `doctor` reads them. |
| Drift | (three `warn` lines of `doctor`) | A kit-owned file in a target that is not as `install` wrote it: a file in the manifest whose fingerprint changed, a file in the manifest that is absent, or a file added inside one of the three skill folders. Each is lost or already gone on the next `update`, and `doctor` says which: `<path> edited locally (focus-kit update overwrites it)`, `<path> missing (focus-kit update restores it)` and `<path> is not the kit's (focus-kit update removes it)`. An absent file loses nothing, because `update` restores it, and it is still drift: the manifest is the only complete list of kit-owned files a target holds, so silence about one is a green line that was not earned. Three shapes and no fourth: the six kit-owned paths the presence lines of `doctor` name, the three skills and the three manuals, print the absent shape word for word, which is why the drift pass can stay silent about a path they named without the reader seeing two wordings for one state. A stale target is not drift: the kit moved, the file did not. |
| Project-owned | (never written by the CLI) | A file only `/initialize` and the people working in the target may touch: `docs/00` to `06`, `CLAUDE.md`, `docs/adr/`, `work/`. The CLI never reads or writes them, with one exception: it checks whether `docs/00-Product.md` exists, to decide which next step to print (`bin/focus-kit:328`). |
| Merged | `merge_json()` | A file the CLI adds to without removing: `.mcp.json`, `.claude/settings.json`. One rule decides every key a baseline holds: an entry directly under `mcpServers` replaces the file's whole, an absent key is taken, two objects merge recursively, two lists concatenate without duplicates, anything else is the baseline's, and a key the baseline says nothing about is untouched. The merge goes through python3 and is idempotent. `doctor` reads both files back and says, for each, whether the entry its baseline put there is still in it: `.mcp.json` the graphify server, `.claude/settings.json` the `enabledMcpjsonServers` entry that enables it. Presence earns neither green line, because an empty file exists and leaves the session without the graph, and what a warn names is `focus-kit update`, which merges the baseline back. |
| Appended once | (the marker test) | `.gitignore`: the fragment goes in the first time and never again, because the marker is already there. |
| Target repository | `target` | The repository the kit is installed into. Inside the CLI it is always an absolute path (`bin/focus-kit:280`). |
| Dogfood copy | `.claude/skills/`, `docs/manuals/` | This repository is also a target of itself. Those two paths hold copies of `skills/` and `manuals/`. They are versioned, and keeping them equal to their sources is a rule, not a habit (`docs/05-Process.md` §5). |
| First target | `~/Downloads/vaulted` | The one target repository that is not this one and that milestone 2 runs the whole cycle on: a clone of someone else's public repository, installed by `first-target-install`, initialized by `first-target-initialize`, taken through one delivery by `first-target-delivery`. Every friction it produces comes back to the queue as a line. Nothing is committed or pushed there, ever: it is a clone, not a repository this project owns. What a command stages there (`/initialize` and `/apply` both end with `git add -A`) is undone with `git reset` before the record is written, so the clone is never one keystroke from a commit; the working tree stays as the last run left it, because the clone is disposable and nobody needs it back at its first commit. It is a row of `docs/05-Process.md` §5 while milestone 2 is open and leaves with it. |

### The delivery process

| Term | Code | Short meaning |
|---|---|---|
| Delivery | `work/<slug>.md` | One unit of work, defined on one page. The page is the scope. |
| Slug | `<slug>` | A delivery's name: short, lowercase, hyphenated, naming what the user gains rather than the technique. It is an identifier, so it stays in English whatever the documentation language is. |
| Queue | `docs/06-Queue.md` | One line per delivery, in order, grouped by milestone. |
| Mark | `[ ]` `[>]` `[x]` | Where a queue line stands: not yet defined, defined in `work/<slug>.md`, done. A line never leaves the queue; it changes mark. |
| Milestone | (a heading in the queue) | A group of deliveries that together make something a person can use end to end. The unit at which the whole-branch review happens. |
| Done page | `work/done/<slug>.md` | The delivery page after it shipped, carrying what actually happened: what diverged, what was dropped, what the proof found, the state of each environment. |
| Propose | `/propose <slug>` | The conversation that writes the delivery page. Writes no code. |
| Apply | `/apply <slug>` | The clean session that builds the page end to end, and never commits. |
| Initialize | `/initialize` | The command that writes a target's `docs/` and `CLAUDE.md`. Run once, then again as a review. |
| Verify command | `bin/focus-kit selftest` | The one command that must come back green before anything is declared done. Six checks, in order, stopping at the first red (`docs/05-Process.md` §4). |
| Scratch repository | `mktemp -d` plus `git init` | The disposable target the verify command installs into, checks with `doctor`, greps for what the two JSON merges wrote, and removes at the end whether the run passed or failed. It has exactly this name everywhere: not a temp repo, not a temporary directory, not a test fixture. |
| Proof | (see `docs/05-Process.md` §6) | How a delivery is shown to work beyond the verify command. Here it is an install into a scratch repository, since the kit has no screen. |
| House rule | (prose, in the manuals) | A rule fixed in every project the kit installs, not open to a per-project vote: one delivery is one page, FOCUS, errors are values, no em dash, the agent never commits, abstraction on the second occurrence, docs are living, prose in the project's language and identifiers in English. |
| Slot | (a section of `docs/05-Process.md`) | The part of the process that is per-project: the verify command, the environments table, the publish policy, the git policy, the proof. `/initialize` fills a slot; `/apply` reads it. |
| ADR | `docs/adr/ADR-NNNN-<slug>.md` | A decision that is expensive to reverse, numbered, never renumbered, never deleted. |

### Language

| Term | Code | Short meaning |
|---|---|---|
| Documentation language | (declared in three places) | The language the prose is written in: `docs/00` to `06`, the ADRs, `work/<slug>.md`, commit messages. Chosen once by `/initialize` and declared on the language line of `CLAUDE.md`, in `docs/04-Conventions.md` §1 and in `docs/05-Process.md` §0. For this repository it is English. |
| Identifier | (always English) | A name in code, schema, API, file name or branch. Never follows the documentation language. |
| Conversation language | (not recorded anywhere) | The language the person and the agent speak in. A third thing, tied to whoever is writing, and it has no effect on either of the two above. |
| Em dash | `U+2014` | The character forbidden in any text a user reads. In this repository the rule is stricter than the house rule: no em dash anywhere at all, because the kit's own text sets the example (`CLAUDE.md`). It is named by its codepoint here, never written, so that the verify command's grep needs no exception. |

### The graph

| Term | Code | Short meaning |
|---|---|---|
| Graph | `graphify-out/graph.json` | The knowledge graph of the repository. Built by graphify, queried before grepping. Derived, not authored: the whole of `graphify-out/` is ignored by git and rebuilt on demand (`ADR-0005`). |
| Graph report | `graphify-out/GRAPH_REPORT.md` | The plain-language audit of the graph: god nodes, communities, surprising connections, token cost. |
| God node | (a section of the report) | The most connected node in the graph. Reading the list is the fastest map of what a codebase is made of. |
| Ensuring the graph | `docs/manuals/graphify.md` §Ensuring the graph | The procedure `/propose` and `/apply` run before reading the graph, written in exactly one place. Four branches, in order: graph absent and the CLI refuses for want of a model, graph absent on a code-only corpus, graph stale, hook absent. |
| Graph hook | `.git/hooks/post-commit` | The graphify hook that rebuilds the graph after each commit, so it never goes stale. Installed by `graphify hook install`. Never versioned: a clone starts without one, and "Ensuring the graph" puts it back. |
| Global skill | `~/.claude/skills/graphify/SKILL.md` | The `/graphify` command Claude Code loads in every session, on the machine and not in any target. It is graphify's file, in none of the four ownership categories: the kit never writes it, it runs graphify's own installer, `graphify install --platform claude`, when the skill is absent or older than the package, and leaves it alone when it is newer. `doctor` compares it with the package and reports. Its state is one word from `global_skill_state()`: `missing`, `unknown`, `equal`, `older`, `newer`. |
| Skill stamp | `~/.claude/skills/graphify/.graphify_version` | One line beside the global skill: the version of graphify that wrote it. graphify reads it on every invocation to print its own stale-skill warning, and `global_skill_state()` reads the same file through `without_cr` and compares it with the second word of `graphify --version`, so the kit and graphify agree on what stale means without the kit reading graphify's stderr. A skill installed before graphify stamped it has none, and its version is unknown. |
| MCP server | `graphify-mcp` | The server declared in `.mcp.json` that exposes the graph to a session. Installed by the `mcp` extra of graphifyy, which the dependency phase of `install` puts there; without it the executable exists and dies on import. It also fails to start until `graphify-out/graph.json` exists. |

### FOCUS

These terms belong to the architecture the kit teaches, not to the kit's own
code. They are listed because `docs/00`, `docs/01` and the manuals use them,
and the rule is that every term used in a document is defined here.

| Term | Code | Short meaning |
|---|---|---|
| FOCUS | `FOCUS` | Feature-Oriented, Clean, Unidirectional, Scalable. The four-piece architecture the kit installs a reference for. The book is *FOCUS* by J.C. Ködel. |
| View | (per stack) | Fires events, renders state. Forbids business rules and data access. |
| Orchestrator | (per stack) | Converts one event into one state; fetches, calls use cases, publishes. Forbids deciding rules and persisting. |
| Use case | (per stack) | The only place for business rules. A pure function: takes data, returns a Result. Forbids IO, framework and domain exceptions. |
| Repository | (per stack) | CRUD, and the only place an infrastructure exception becomes a Result. Forbids business rules. |
| Result | (per stack) | A return type carrying either success or one named failure, never both. The mechanism behind "errors are values". |
| Slice | (per stack) | One flat folder per feature, holding the four pieces of that feature. The unit of change. |

---

## Entities and invariants

There are four things in this project that have rules about them. None of
them is a row in a database; all four are sets of files, and the invariants
are the sentences a reviewer can check by looking.

### The kit

What it is: this repository. Source of everything installed elsewhere.

Invariants:

* `VERSION` is bumped by any change a target repository would want. A
  change to a skill, a manual, a template or the CLI's behaviour is such a
  change; a change to this repository's own `docs/` is not.
* Every file is either kit-owned, project-owned, merged or appended once.
  There is no fifth category, and a new file declares which it is in the
  delivery that adds it.
* The three commands are stack-agnostic. A command that names a language, a
  framework, a test runner or a deploy target has leaked a slot; the slot
  belongs in the target's `docs/05-Process.md`.
* Nothing the kit writes contains an em dash.

Transitions: a version ships when a person commits. There is no release
artifact, no tag flow, no package registry. A target gets the new version by
running `focus-kit update`.

What it is not: a library, a framework, or a runtime dependency of the
target. After `install`, nothing in the target imports or calls the kit.
`bin/focus-kit` is needed again only to update.

### The target repository

What it is: any git repository the kit is installed into, including this one.

Invariants:

* After `install`, `doctor` reports every kit-owned path present, no
  drift, and the installed version equal to `VERSION`.
* `install` is idempotent. Running it twice leaves the same tree: the trees
  are overwritten, the JSON merges are by key, the gitignore fragment is
  guarded by its marker.
* `install` never removes anything from a target's `.claude/settings.json`
  or `.mcp.json`, except the entry under `mcpServers` the MCP baseline names,
  which is the kit's and is replaced whole. It never edits a project-owned
  file.
* A target whose `docs/00-Product.md` exists is a repository `/initialize`
  reviews, not one it rewrites.

Transitions: absent, installed, initialized, stale (installed version below
`VERSION`), updated.

What it is not: a fork or a clone of the kit. A target holds copies of the
kit-owned files, the installed version and the manifest, and nothing else
of the kit's.

### A delivery

What it is: one page in `work/<slug>.md`, and the work it names.

Invariants:

* It fits on one page. If it does not, it is two deliveries. The page is the
  test that the scope was understood.
* Its **Contract** section is exact. It is the only section that is
  expensive to reverse, so it is the only one precision is demanded of.
* It is defined before it is built, in a separate session. Deciding and
  doing are separated on purpose.
* Its "Done when" is mechanical: every line is something a person can check
  without judgement.
* A delivery that changes behaviour updates the document that owns that
  behaviour, in the same delivery.

Transitions: `[ ]` in the queue, `[>]` once `/propose` wrote the page, `[x]`
once `/apply` finished and moved the page to `work/done/`.

What it is not: a task, a ticket, or a unit of time. It carries no estimate
and no assignee.

### The queue

What it is: `docs/06-Queue.md`, the ordered list of deliveries.

Invariants:

* One line per delivery, in the order they will be done.
* A line never leaves. It changes mark. A cancelled delivery is struck
  through with a reason, not deleted, because the reason is the value.
* The order is the decision. A line moved up is a decision someone took, and
  it is taken in conversation, not by an agent rearranging the file.
* Every finding confirmed by a milestone review becomes a line, named after
  what it fixes.

What it is not: a schedule, a narrative, or a backlog of ideas. Ideas that
are wanted but not ordered live under "Later, not scheduled".

---

## Language of the interface

The kit has no graphical interface. The text a user reads is the terminal
output of `bin/focus-kit` and the three manuals it installs, plus whatever
the three commands say in a session.

All of it is in English, including for a target repository whose
documentation language is something else: the kit's own strings are not
translated, only the documents `/initialize` writes. The no em dash rule
applies to every line of that output.

The terminal output has four shapes and no others (`bin/focus-kit:47`):
`say` for plain lines, `ok` for a green check, `warn` for a yellow warning
that does not stop the run, `die` for a red error that exits. A new message
picks one of the four.

---

## Related documents

* `docs/00-Product.md`: what the product is.
* `docs/01-Architecture.md`: how it is built.
* `docs/02-Backend.md`: the server, which this project does not have.
