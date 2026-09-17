# focus-kit

A delivery process for repositories worked on with Claude Code, built on
the FOCUS architecture (Feature-Oriented, Clean, Unidirectional, Scalable).

It installs three commands into a repository:

* **`/initialize`**: writes the project's `docs/` (product, architecture,
  backend, domain, conventions, process, queue, ADRs) and `CLAUDE.md`. On a
  greenfield project it asks, in short rounds. On a brownfield project it
  reads the code, builds a graphify knowledge graph, and asks only what the
  code cannot answer.
* **`/propose <slug>`**: defines the next delivery in a one-page file, by
  conversation. Writes no code.
* **`/apply <slug>`**: builds that page end to end, proves it, updates the
  docs, stages the result and suggests the commit. Never commits.

And three manuals into `docs/manuals/`: the process, the FOCUS reference
for coding agents, and graphify in the repository.

The kit is **bilingual**: English and Portuguese. `/initialize` asks which
of the two the project documents itself in, and everything written
afterwards follows that choice: docs, deliveries, ADRs, commit messages.
English is the default. The conversation is a separate matter: you talk to
the agents in whatever language you like, in any session, and the generated
documentation still comes out in the language the project chose.
Identifiers are always in English, so a Portuguese project still names its
types and columns in English, with `docs/03-Domain.md` holding the
translation.

## Install the kit on this machine

```
git clone <this repo> ~/Projects/focus-kit
ln -s ~/Projects/focus-kit/bin/focus-kit ~/.local/bin/focus-kit
```

`~/.local/bin` must be on your PATH (it is, if uv is installed).

**On Windows**, in Git Bash. `ln -s` there copies the file instead of
linking it, and the copy cannot find the kit it came from, so the line on
PATH is a wrapper that calls the clone:

```
printf '#!/usr/bin/env bash\nexec bash "$HOME/Projects/focus-kit/bin/focus-kit" "$@"\n' > ~/.local/bin/focus-kit
chmod +x ~/.local/bin/focus-kit
```

The first `focus-kit install` on a Windows machine installs uv into
`~/.local/bin`, which is not yet on that shell's PATH. The install itself
finishes, but the `focus-kit doctor` you run next reports uv and graphify
missing until you open a new shell or run `. ~/.local/bin/env`.

Under WSL nothing is different: it is Linux, and the clone lives on the WSL
side of the filesystem, not under `/mnt/c`.

## Install into a repository

```
cd <your repo>
focus-kit install .
```

This installs the dependencies on the machine (uv, graphify, the global
`/graphify` skill for Claude Code), then in the repository:

| Path | Owner | What |
|---|---|---|
| `.claude/skills/{initialize,propose,apply}/` | kit | the three commands; overwritten on update |
| `docs/manuals/{process,focus,graphify}.md` | kit | the manuals; overwritten on update |
| `.claude/skills/.focus-kit-manifest` | kit | what the install wrote, so `doctor` can tell an edited file from a stale one |
| `.claude/settings.json` | merged | baseline permissions: git commit and push always ask |
| `.gitignore` | appended once | session settings, graphify cost and machine paths |
| `.graphifyignore` | appended once | keeps the kit's own skills and manuals out of your graph |
| `work/done/` | project | created if absent |

Then open Claude Code in the repository and run `/initialize`.

`focus-kit update .` repeats the install (kit-owned files are overwritten,
project-owned files are never touched). `focus-kit doctor .` lists what is
installed, what is missing, and which kit-owned files were edited locally,
which is what the next update would erase.

## What the process is

One page: `manuals/process.md`. The short version:

```
docs/06-Queue.md → /propose <slug> → work/<slug>.md → /apply <slug>
                                                          ↓
                                       verify green, environments as docs/05 says
                                                          ↓
                                        work/done/<slug>.md + git add -A
                                                          ↓
                                            a person reviews and commits
```

House rules, fixed in every project: one delivery is one page; FOCUS;
errors are values; no em dash in any text a user reads; the agent never
commits; abstraction on the second concrete occurrence; docs are living.

## What FOCUS is

Four pieces with a checkable contract:

| Layer | Does | Forbids |
|---|---|---|
| View | fires events, renders state | business rules, data access |
| Orchestrator | converts event to state, fetches, calls use cases, publishes state | deciding rules, persisting |
| Use Case | the only place for business rules; a pure function; takes data, returns a Result | IO, framework, domain exception |
| Repository | CRUD; the only place an infra exception becomes a Result | business rules |

The full reference for agents is `manuals/focus.md`. The book is FOCUS by
J.C. Ködel (https://books.kodel.com.br).

## A project built with this process

**Ninjobs** (https://www.ninjobs.app) is where the process was born. It is
a job platform for IT with bilateral matching and progressive disclosure:
candidate and company pick each other, and the company only learns who the
person is after both sides declared interest and a handoff was paid. One
developer with Claude Code, from a restart on 2026-08-29 to a public beta on
2026-09-10. Every line of the product went through the queue, `/propose`
and `/apply` exactly as described above.

The numbers, as of 2026-09-16:

| | |
|---|---|
| Deliveries in `work/done/` (one page each) | 90 |
| ADRs | 14 |
| Commits | 124 |
| Migrations | 45, about 20k lines of SQL |
| Application code | about 35k lines of TypeScript and TSX |
| Living documentation | about 7k lines in `docs/` |
| Unit and boundary tests (Vitest) | 830 in 58 files |
| End-to-end tests (Playwright) | 202 in 23 specs |
| Screenshot references, two viewports | 198 |

What the process produced there, beyond feature count, is a set of
guarantees that are checked by machine on every `verify`:

* **Nothing crosses the disclosure boundary.** Every table is born with
  forced row-level security and its policies in the same migration. Data of
  the other side reaches the browser only through an allowlist of
  `security definer` functions documented in `docs/02`, with the exact
  column set of each projection asserted in tests. An end-to-end proof
  sweeps every public table over the REST API in three pair states and
  fails if a single sentinel value leaks. The client never filters.
* **Privacy is structural, not a filter.** The product stores a postal code
  and a shared coordinate catalog, never an address; what leaves the server
  is a proximity verdict, not a distance or a point. Salary, precise
  location and identity have no path to the browser before the right level.
* **The database linter fails the build.** Supabase's `splinter` runs in
  `verify`; a new warning is a red build, and every ignored warning is a
  line in an allowlist with its reason beside it.
* **Copy is checked like code.** A sweep of every live screen fails on any
  word from the domain jargon list (level, side, handoff, and so on) and on
  any em dash. Screens speak the user's language, not the domain model's.
* **Every screen is proven against its design.** The `/apply` of a screen
  ends with Playwright screenshots in both viewports compared to the design
  artboard, with each divergence listed and justified.
* **Performance is a delivery, with numbers.** The candidate triage of a
  job answers in 94 ms; a query that scored the whole database (1227 ms)
  was cut to 34 ms, and the lesson is written in the queue next to the
  delivery. The landing page makes no request outside its own origin.

Two things worth knowing when reading Ninjobs as an example. It predates the
kit, so its files are in Portuguese and named `trabalho/` and `06-Fila.md`
rather than `work/` and `06-Queue.md`. And it does **not** use the FOCUS
layers: its ADR-0022 rejects use cases, repositories and stores on purpose
for a product that is a thin PWA over Supabase. That is a decision of that
product, not of the house. The process (queue, one-page delivery, propose
then apply, the agent never commits, machine-checked house rules) is the
part the kit generalizes, and Ninjobs is the proof that it holds for
twelve days of daily deliveries up to a public release.

## License

focus-kit is licensed under the GNU Affero General Public License, version 3
only (`LICENSE`). A fork stays under the same terms and keeps the copyright
notices, and running a modified version so that people use it over a network
counts as distribution: the source of that version has to be offered to them.

**Additional permission under AGPL-3.0 section 7.** The documents that
`/initialize`, `/propose` and `/apply` write into a target repository
(`docs/00` to `06`, `docs/adr/`, `CLAUDE.md`, `work/`) are not covered works
of focus-kit. They belong to that repository, under whatever license its
owner chooses. The kit-owned copies in `.claude/skills/` and `docs/manuals/`
remain under the AGPL, and holding them in a repository is aggregation,
which does not extend the AGPL to that repository's own code.

Terms outside the AGPL, for anyone who wants to use or redistribute the kit
without its obligations, are granted only by the author, J.C. Ködel, on
request through this repository's GitHub issues.

## Layout of this repository

```
bin/focus-kit                  the CLI (bash 3.2 compatible; macOS, Linux, Windows)
skills/<name>/SKILL.md         the three commands
skills/initialize/templates/   CLAUDE.md and docs/ templates the command fills
manuals/                       the three kit-owned manuals
config/                        the two JSON baselines and the two ignore fragments
VERSION
```

## Requirements

The kit runs on macOS (bash 3.2), Linux, and Windows through WSL or Git
Bash. It needs `curl`, a python 3 on PATH as `python3` or as `python` (or
uv, which supplies one), git, and Claude Code. Node is not required by the
kit; the target project's stack is.
