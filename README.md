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

Everything it writes is in English. The conversation follows whoever is
writing.

## Install the kit on this machine

```
git clone <this repo> ~/Projects/focus-kit
ln -s ~/Projects/focus-kit/bin/focus-kit ~/.local/bin/focus-kit
```

`~/.local/bin` must be on your PATH (it is, if uv is installed).

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
| `.mcp.json` | merged | the graphify MCP server, by executable name |
| `.claude/settings.json` | merged | baseline permissions: git commit and push always ask |
| `.gitignore` | appended once | session settings, graphify cost and machine paths |
| `work/done/` | project | created if absent |

Then open Claude Code in the repository and run `/initialize`.

`focus-kit update .` repeats the install (kit-owned files are overwritten,
project-owned files are never touched). `focus-kit doctor .` lists what is
installed and what is missing.

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

## Layout of this repository

```
bin/focus-kit                  the CLI (bash 3.2 compatible; macOS and Linux)
skills/<name>/SKILL.md         the three commands
skills/initialize/templates/   CLAUDE.md and docs/ templates the command fills
manuals/                       the three kit-owned manuals
config/                        settings baseline and .gitignore fragment
VERSION
```

## Requirements

macOS or Linux, `curl`, `python3` (or uv, which supplies one), git, Claude
Code. Node is not required by the kit; the target project's stack is.
