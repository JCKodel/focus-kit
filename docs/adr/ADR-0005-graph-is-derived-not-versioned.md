# ADR-0005: The graph is derived, not versioned

**Status:** accepted
**Date:** 2026-09-16

---

## Context

`config/gitignore.fragment` shipped with a rationale written into it: the
graph and its extraction cache are versioned "so a clone does not pay the
extraction again". Only three files were ignored, the local cost ledger and
two machine paths. Everything else in `graphify-out/` was tracked.

The post-commit hook rebuilds the graph after every commit, detached, and
writes `graph.json`, `graph.html`, `GRAPH_REPORT.md`, `manifest.json`, the
label files and the AST cache. All of those were tracked. So every commit
ended the same way: the commit lands, the hook fires, and `git status` comes
back dirty with a graph diff that belongs to the commit that just closed.
The next delivery then either carried that diff or produced a second commit
for it. The committed graph was structurally one commit behind its own
repository: a clone of this repository at `8d1908f` had a `GRAPH_REPORT.md`
saying `Built from commit: 095d5402`.

The claim on the other side is real and was measured rather than assumed.
This repository has 4 code files and 49 doc files. A fresh clone with no
graph runs `graphify .`, which refuses with `error: no LLM API key found (49
doc/paper/image file(s) need semantic extraction)`, so the rebuild needs a
model in the session and costs its tokens. That is the price of not
versioning it.

## Decision

`graphify-out/` is ignored in full, and `/propose` and `/apply` ensure the
graph before they read it, following one procedure written in one place:
`docs/manuals/graphify.md` §Ensuring the graph.

The trade is a cost that landed once per commit, in everybody's worktree,
moved to a cost that lands once per machine, in the session that first needs
the graph. A person who clones and never opens `/propose` or `/apply` pays
nothing, because nothing runs on its own.

The three ignore lines and their comment become one directory and a comment
that says why: the graph is derived, not authored.

## Consequences

Easier: a delivery commit contains the delivery. `git status` is clean after
a commit, whatever the hook does afterwards, and the hook's own guard
against a rebuild loop over tracked graph outputs stops mattering here. The
`graphify-out/` exclusion in the em dash check of the verify command stays
for the same reason it was written, that the files are generated, but it is
now also true that they are untracked.

Harder: the first session in a fresh clone pays a full extraction, and on a
corpus with docs that means a model and its tokens. Curated community labels
do not survive a clone, which is part of the same price. The MCP server
fails to connect in that first session, before the graph exists, and the
manual now says this is the normal first session rather than a fault.

**2026-09-17, `mcp-leaves-the-baseline`:** the kit stopped shipping that
server, so this cost is gone with it. Nothing the kit installs reads
`graphify-out/graph.json` at session start; `/propose` and `/apply` build or
update the graph when they run, and a clone's first session pays the
extraction and nothing else.

Forbidden: versioning a subset of `graphify-out/` to shrink the diff. It
leaves the dirty worktree exactly as it is, which was the problem.

Revisit when: graphify gains a cheap way to rebuild a doc-heavy corpus
without a model, or the kit acquires a shared cache that a clone can pull.
Either one removes the cost this decision accepted.

## Alternatives considered

* **A pre-commit hook instead of a post-commit one.** The graph would land
  in the same commit and the worktree would stay clean. Lost: it blocks
  every commit in every target repository for the length of a rebuild, which
  graphify's own hook comment warns can be hours, and the kit is
  stack-agnostic, so it cannot know how long that is anywhere.
* **A post-clone automation that builds the graph.** Lost: git has no such
  hook. `.git/hooks/` is not transferred by a clone, `core.hooksPath` has to
  be set after one and `init.templateDir` is per machine. Measured, not
  assumed.
* **Keep versioning and let the delivery carry the graph diff.** Lost: it is
  the state this ADR reverses, and it is why the delivery commits of this
  repository each contain a graph that describes the commit before them.
