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
/graphify                      # build or rebuild (asks before an expensive extraction)
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
without a hook. `/propose` and `/apply` run the procedure below before they
read the graph, and it is written here and nowhere else. Four branches,
checked in this order, each one announced out loud. When all four are
already satisfied, the command says nothing.

| Condition | Action | Cost |
|---|---|---|
| `graphify-out/graph.json` absent, and `graphify .` exits with `error: no LLM API key found` | `/graphify .` in the session | the session's tokens |
| `graphify-out/graph.json` absent, and `graphify .` succeeds | nothing further; the CLI already built it | none |
| `Built from commit` in `graphify-out/GRAPH_REPORT.md` differs from `git rev-parse HEAD` | `graphify update .` | none |
| `graphify hook status` says the post-commit hook is absent | `graphify hook install` | none |

The first two branches are one attempt, not an inspection: run `graphify .`
and let the exit decide. A corpus that has docs, papers or images makes it
refuse in graphify's own words, `error: no LLM API key found (N
doc/paper/image file(s) need semantic extraction)`; a code-only corpus makes
it succeed for free. Never scan extensions to guess which.

That attempt has one trap. `graphify .` looks for a backend key in the
environment, and when one is exported it does not refuse: it extracts every
doc against that provider and bills it. On a corpus whose size you have not
measured, look at the environment first.

The first branch's action is not a judgement call. A command that reaches it
runs `/graphify .`; it does not weigh the extraction against the size of the
delivery and carry on without a graph, because the next session would weigh
the same trade again and the clone would never get one. The place where the
cost is declined is `/graphify` itself, which measures the corpus and asks a
person before an expensive extraction. What the procedure forbids is
skipping the branch and reading, or grepping in place of, a graph nobody
confirmed.

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

The full extraction uses the model in the session and costs tokens; the
skill measures the corpus and asks before running it on a large tree.
`graphify-out/cost.json` keeps the local ledger, on this machine only.

## Rules

* `.mcp.json` names the server by executable (`graphify-mcp`), never by an
  absolute path. A path to one machine's Python breaks on the next machine
  and the server silently fails to connect.
* The graph is a map, not a source of truth. When the graph and the code
  disagree, the code wins and the graph is rebuilt.
* Do not hand-edit `graphify-out/`.

## Troubleshooting

* **MCP server fails to connect at session start.** This is the normal
  first session in a clone, not an accident: `graphify-out/graph.json` is
  not versioned and does not exist yet. §Ensuring the graph is what fixes
  it, and `/propose` and `/apply` run it on their own. The server connects
  from the next session on. If it still fails once the graph is there,
  `graphify-mcp` is not on PATH (`focus-kit doctor`).
* **Hook missing after a clone.** Also normal: git does not transfer
  `.git/hooks/`, and there is no hook that fires at clone time. §Ensuring
  the graph installs it, or run `graphify hook install` by hand.
* **Report names "Community 3".** Community naming needs the model; run
  `graphify cluster-only .` inside a Claude Code session.
