<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

# graphify in this repository

graphify turns the repository (code and docs) into a persistent knowledge
graph: nodes are files, symbols and concepts; edges say who calls, imports,
defines or mentions whom; communities group what belongs together; "god
nodes" are the few things everything depends on. The graph lives in
`graphify-out/`. This manual is kit-owned.

## Why it is here

An agent that starts a session knows nothing about the codebase. Without a
map it greps, reads, and fills its context with files it did not need.
With the graph it asks "where do business rules for orders live" and gets
the slice, the use case and the repository in one answer. `/propose` uses
it to find what a delivery touches; `/apply` uses it to load the right
slice; `/initialize brown` uses it to describe a codebase it has never
seen.

## The pieces

| Piece | What | Where |
|---|---|---|
| `graphify` | the CLI: build, update, query, path, explain | installed by `focus-kit install` as a uv tool |
| `/graphify` | the Claude Code skill that drives the CLI | `~/.claude/skills/graphify/` (global, installed by the kit) |
| MCP server | lets the agent query the graph without shell calls | `.mcp.json`, command `graphify-mcp graphify-out/graph.json` |
| post-commit hook | rebuilds the graph after every commit, no LLM needed | `.git/hooks/post-commit`, installed by `/initialize`, ensured by `/propose` and `/apply` |
| `graphify-out/` | `graph.json` (the graph), `GRAPH_REPORT.md` (plain-language map), `graph.html` (interactive) | not versioned; rebuilt on demand by `/propose` and `/apply` |

## Everyday use

```
/graphify                      # build or rebuild (asks nothing below graphify's own threshold)
/graphify --update             # re-extract only changed files
graphify query "<question>"    # broad context on a question
graphify query "<q>" --dfs     # trace one path
graphify path "A" "B"          # shortest path between two concepts
graphify explain "X"           # plain-language explanation of one node
graphify hook status           # is the post-commit hook installed
```

From inside a Claude Code session, asking a question about the codebase is
enough: the global skill treats it as a graph query first when
`graphify-out/graph.json` exists.

## Ensuring the graph

`graphify-out/` is not versioned, so a clone starts without a graph and
without a hook. `/propose`, `/apply` and `/initialize` run the procedure
below before they read the graph, and it is written here and nowhere else.
Four branches,
checked in this order, each one announced out loud. When all four are
already satisfied, the command says nothing.

| Condition | Action | Cost |
|---|---|---|
| `graphify-out/graph.json` absent, and `env -u GEMINI_API_KEY -u GOOGLE_API_KEY -u MOONSHOT_API_KEY -u ANTHROPIC_API_KEY -u OPENAI_API_KEY -u DEEPSEEK_API_KEY graphify .` exits with `error: no LLM API key found` | the Graph confirmation, then what its answer names | the session's tokens or the exported key's, only after "Build now" |
| `graphify-out/graph.json` absent, and the same attempt succeeds | nothing further; the CLI already built it | none |
| `Built from commit` in `graphify-out/GRAPH_REPORT.md` differs from `git rev-parse HEAD` | `graphify update .` | none |
| `graphify hook status` says the post-commit hook is absent | `graphify hook install` | none |

The first two branches are one attempt, not an inspection: run the command
the first row names and let the exit decide. A corpus that has docs, papers
or images makes it refuse in graphify's own words, `error: no LLM API key
found (N doc/paper/image file(s) need semantic extraction)`, and print the
count line `found N code, N docs, N papers, N images`; a code-only corpus
makes it succeed for free. Never scan extensions to guess which.

The six variables are the ones the refusal line names today (verified on
graphify 0.9.63), unset for the attempt alone, so that a corpus with docs
always refuses and prints its count line; a key the line names later joins
the row.

The first branch's action is not a judgement call, and the judgement is not
the agent's to make. The agent has no discretion here: it asks the Graph
confirmation, as written below, and does what the answer names. The person
has all of it, "Not now" included, which is an answer the command records
out loud and not a branch it skipped. What the procedure forbids is reaching
this branch and reading, or grepping in place of, a graph nobody was asked
about.

The question is written here once and the commands ask it as written. One
`AskUserQuestion`, the question `graphify refused: <the found line>. Build
the graph?`, where `<the found line>` is the count line above without its
`[graphify extract]` prefix, and three options, in this order:

* **Build now.** `/graphify .` in this session, billed as its tokens. When
  one of the six keys is exported, `graphify .` instead, billed to that
  key's account. Two runs from the Cost ledger, for scale: 38 files cost
  187,743 input tokens, 62 files cost 433,524.
* **Code only.** `graphify . --code-only`, free, no model. Docs, papers and
  images stay out of the graph until you run `/graphify --update`.
* **Not now.** Nothing is built. This command reads files directly and says
  so; the next command that needs the graph asks again.

Then the command says what the answer cost, one line:

* After **Build now**: `graph built: <N> input tokens
  (graphify-out/cost.json)`, N read from the last entry of `runs` in that
  file, or `graph built; graphify-out/cost.json absent` when the run wrote
  none.
* After **Code only**: `graph built from code only; docs enter with
  /graphify --update`.
* After **Not now**: `no graph this session; reading files directly`.

The third branch covers code only. `graphify update .` re-extracts every
code file and rewrites `Built from commit`, so after a pull that changed
only docs the SHA matches HEAD while the doc side of the graph is still old.
That is what §When the graph is rebuilt means by "doc and image changes need
`/graphify --update`", and it is today's behaviour, not something the
branch introduces. A stale SHA is the normal state after `git pull`, which
fires no hook.

The branch invokes `graphify update .`, not the incremental rebuild the hook
runs. Both are free and neither needs a model, but they are not the same
operation: the hook re-extracts only the files one commit touched and keeps
the rest of the graph, while `update` re-extracts all of the code. Measured
on the focus-kit repository under `PYTHONHASHSEED=0`, which is what the hook
pins, `update` gave 494 nodes in 110 communities and was a no-op on a second
run; the hook's incremental rebuild gave 336 in 37. The branch wants the
graph to agree with the code, so it takes the full one.

A rebuild the hook launched may still be running when a command reaches the
third branch, because the hook detaches and `git commit` returns before the
graph is written. Nothing has to be done about it: graphify holds a per-repo
advisory lock (`graphify-out/.rebuild.lock`) and `graphify update .` waits
on it, so the worst case is a wait followed by a second pass, never two
writers on `graph.json`.

## When the graph is rebuilt

* **On every commit**, by the hook, for code files only, without any model
  call. Doc and image changes need `/graphify --update`.
* **By `/propose` and `/apply`**, at the start, through §Ensuring the graph:
  built when absent, updated when the SHA is behind HEAD.
* **By `/initialize`**, fully, on a brownfield project, and after the docs
  are written on a greenfield one.
* **By you**, with `/graphify --update` after a large refactor, or
  `/graphify` from scratch when the report no longer describes the code.

The full extraction uses the model in the session and costs tokens.
`/graphify` by hand asks nothing below graphify's own threshold of 2,000,000
words or 500 files, and above it asks which subfolder to run on, never
whether to run at all; the kit's commands ask, through §Ensuring the graph.
`graphify-out/cost.json` keeps the local ledger, on this machine only.

## What the graph leaves out

`.graphifyignore`, at the repository root, holds the patterns graphify skips.
It is gitignore syntax, it is read on top of `.gitignore`, and it only ever
excludes more.

`focus-kit install` appends a block to it once, under the marker `# ---
focus-kit ---`, naming the six files the kit itself put in the repository:
the three skills and the three manuals. They are the kit's documentation,
not the project's code, and without the block they answer questions asked
about the project. In the first two repositories this ran on they were 214
of 498 nodes and 139 of 502, so more than a quarter of the graph was the
kit describing itself, and a query about one function of the install script
came back with chapter headings from the FOCUS manual.

The block names files, not the two folders. A `.claude/skills/deploy/` or a
`docs/manuals/runbook.md` of the project's own stays in the graph.

**The rest of the file is yours.** Add what the graph should not answer
about: generated clients, vendored code, fixtures, a migrations folder
nobody asks questions about. A second `focus-kit install` or `update`
appends nothing, because the marker is already there, and it never touches
what you added.

Adding a pattern takes effect on the next rebuild. `graphify update .` is
enough today: it prunes the nodes of a file that a live ignore rule now
matches, and it does so without `--force` even when the graph ends up
smaller. The block above removed 139 nodes from 16 files in one `update`,
on graphify 0.9.63. An older graphify that keeps them needs a full rebuild.

## Rules

* `.mcp.json` names the server by executable (`graphify-mcp`), never by an
  absolute path. A path to one machine's Python breaks on the next machine
  and the server silently fails to connect.
* The corpus is what `.gitignore` and `.graphifyignore` leave. A question
  the graph answers badly is often a corpus question first, not a query
  question (§What the graph leaves out).
* The graph is a map, not a source of truth. When the graph and the code
  disagree, the code wins and the graph is rebuilt.
* Do not hand-edit `graphify-out/`.

## Troubleshooting

* **MCP server fails to connect at session start.** This is the normal
  first session in a clone, not an accident: `graphify-out/graph.json` is
  not versioned and does not exist yet. §Ensuring the graph is what fixes
  it, and `/propose` and `/apply` run it on their own. The server connects
  from the next session on. If it still fails once the graph is there, two
  causes are left: `graphify-mcp` is not on PATH, or `.claude/settings.json`
  does not enable the server, which is what a file edited by hand or written
  before the kit arrived looks like. `focus-kit doctor` says which of the two
  it is, and `focus-kit update` merges the entry back.
* **`graphify-mcp` starts and dies with `ImportError: mcp not installed`.**
  graphify is installed without its `mcp` extra, which is the case on every
  machine whose graphify predates that version of the kit. `focus-kit update`
  fixes it: the dependency phase reinstalls `graphifyy[mcp]`, and
  `focus-kit doctor` says so before you try.
* **`graphify-mcp` starts and dies with `ImportError: cannot import name
  'AnyUrl' from 'mcp.types'`.** The extra is there and graphify is too old
  for it. graphifyy asks for `mcp` with no upper bound, so adding the extra
  to a graphify installed long ago pairs old code with the current MCP SDK.
  `uv tool upgrade graphifyy` fixes it, which is what the `ok` line of the
  dependency phase already suggests. The kit never runs it: an upgrade is
  the person's call, not a side effect of installing the kit.
* **Every graphify command warns that the skill is from an older version.**
  The global `/graphify` skill under `~/.claude/skills/graphify/` was written
  by a graphify older than the one installed, and graphify says so on every
  invocation. `focus-kit update` fixes it: the dependency phase runs
  `graphify install --platform claude` and names the version it came from,
  and `focus-kit doctor` says so before you try. When the warning is the
  other way round, a skill newer than the package, the kit leaves the skill
  alone and names `uv tool upgrade graphifyy`, which is the person's call.
* **Hook missing after a clone.** Also normal: git does not transfer
  `.git/hooks/`, and there is no hook that fires at clone time. §Ensuring
  the graph installs it, or run `graphify hook install` by hand.
* **Report names "Community 3".** Community naming needs the model; run
  `graphify cluster-only .` inside a Claude Code session.
