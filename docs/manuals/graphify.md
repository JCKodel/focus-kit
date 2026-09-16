<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->

# graphify in this repository

graphify turns the repository (code and docs) into a persistent knowledge
graph: nodes are files, symbols and concepts; edges say who calls, imports,
defines or mentions whom; communities group what belongs together; "god
nodes" are the few things everything depends on. The graph lives in
`graphify-out/` and is versioned. This manual is kit-owned.

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
| post-commit hook | rebuilds the graph after every commit, no LLM needed | `.git/hooks/post-commit`, installed by `/initialize` |
| `graphify-out/` | `graph.json` (the graph), `GRAPH_REPORT.md` (plain-language map), `graph.html` (interactive) | versioned, except cost and machine paths |

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

## When the graph is rebuilt

* **On every commit**, by the hook, for code files only, without any model
  call. Doc and image changes need `/graphify --update`.
* **By `/initialize`**, fully, on a brownfield project, and after the docs
  are written on a greenfield one.
* **By you**, with `/graphify --update` after a large refactor, or
  `/graphify` from scratch when the report no longer describes the code.

The full extraction uses the model in the session and costs tokens; the
skill measures the corpus and asks before running it on a large tree.
`graphify-out/cost.json` keeps the local ledger and is not versioned.

## Rules

* `.mcp.json` names the server by executable (`graphify-mcp`), never by an
  absolute path. A path to one machine's Python breaks on the next machine
  and the server silently fails to connect.
* The graph is a map, not a source of truth. When the graph and the code
  disagree, the code wins and the graph is rebuilt.
* Do not hand-edit `graphify-out/`.

## Troubleshooting

* **MCP server fails to connect at session start.** Either
  `graphify-out/graph.json` does not exist yet (run `/graphify .`) or
  `graphify-mcp` is not on PATH (`focus-kit doctor`).
* **Hook missing after a clone.** Hooks are not versioned; run
  `graphify hook install` in the clone.
* **Report names "Community 3".** Community naming needs the model; run
  `graphify cluster-only .` inside a Claude Code session.
