# graph-staleness-without-a-stamp

**Goal.** `/propose`, `/apply` and `/initialize` decide whether the graph is
stale by one mechanical rule, in every repository, whichever answer built
the graph.

**Behaviour.**

* The third branch of Ensuring the graph reads the Graph stamp, the
  `built_at_commit` line of `graphify-out/graph.json`, and compares it with
  `git rev-parse HEAD`. It no longer reads `GRAPH_REPORT.md`, which has no
  such line after "Build now" (graphify's skill writes the report without
  its freshness section) and does not exist after "Code only".
* Stamp equal to `HEAD`: the branch says nothing, as today.
* Stamp different: the command says so, one line, and runs
  `graphify update .`, which rewrites the stamp in `graph.json` and its copy
  in the report.
* Stamp absent, a graph an older graphify wrote or one built outside a git
  repository: treated as stale, same line shape, same command. Nobody is
  asked, because the fix is free.
* "Code only" now leaves a Graph report behind: the answer runs
  `graphify cluster-only . --no-label` after `graphify . --code-only`, free,
  and `/initialize` brownfield finds the report it is told to read.
  Communities stay numbered until a model names them, as §Troubleshooting
  already says.
* The concrete error this catches: in the first target, `/propose` ran the
  grep, got nothing, and decided on the report's date
  (`work/done/first-target-delivery.md`, "at its third branch").

**Contract.** One kit-owned file changes, `manuals/graphify.md`; the three
skills point at §Ensuring the graph by name and are not edited.

* §Ensuring the graph, third row. Condition:
  `grep -o '"built_at_commit": "[0-9a-f]*"' graphify-out/graph.json` prints
  nothing, or prints a SHA that is not `git rev-parse HEAD`. Action:
  `graphify update .`. Cost: none.
* The paragraph "The third branch covers code only": `Built from commit`
  becomes the Graph stamp in `graph.json` and its copy in the report; the
  rest stands. A new paragraph after it says why the stamp is read from
  `graph.json`: both builds the Graph confirmation can start leave the report
  without the line, `/graphify .` because graphify's skill calls the report
  generator without the commit, `--code-only` because it writes no report;
  `graph.json` is stamped by every path through `to_json`'s fallback, and
  one `grep` reads it because the key sits alone on the file's last line
  (measured in three repositories on graphify 0.9.63).
* The branch's announced lines, in the paragraph above the table where the
  four are said to be announced: `graph stale (built from <stamp>, HEAD
  <head>); graphify update .`, both SHAs cut to eight characters, and
  `graph has no stamp; graphify update .`.
* The **Code only** option of the Graph confirmation: `graphify .
  --code-only && graphify cluster-only . --no-label`, free, no model; the
  second command writes the Graph report with the stamp and numbered
  communities. The rest of the option and the said-line after it stand.
  `--no-label` is what keeps the answer free: `graphify --help` says the
  labeling backend defaults to auto-detect, and the flag keeps the
  `Community N` placeholders and skips the naming.
* §Everyday use, one line: the grep above, commented `which commit the graph
  describes`.
* §The pieces, the `graphify-out/` row: `graph.json` is "the graph, stamped
  with the commit it was built from".
* §Troubleshooting, "Report names Community 3": one clause, also the normal
  report after Code only.

`docs/03-Domain.md`: Graph stamp entered by this `/propose`; Graph report
and Ensuring the graph reworded there in the same edit.

**Slice.** `manuals/graphify.md`, kit-owned; `docs/03`, project-owned,
already done; `VERSION` to `0.11.0`; the dogfood copy. No change to
`bin/focus-kit`, `config/` or the skills. No ADR: one table row, reversed by
editing it.

**States.** All four branches satisfied: silence, as today. Third branch:
one of the two lines above, then `graphify update .` output, then the
fourth branch. The grep on a `graph.json` that does not exist never runs,
because the first two branches come first.

**Visual reference.** No UI. What a person sees at the third branch after
`git pull`:

```
graph stale (built from b31fba49, HEAD 92476833); graphify update .
[graphify watch] graph.json, graph.html and GRAPH_REPORT.md updated in graphify-out
```

**Out of scope.**

* The freshness section missing from the report after Build now: graphify's
  skill file, fixed upstream, and the branch no longer needs it.
* `/apply` reusing another command's freshness check in the same session:
  `propose-ends-by-naming-the-next-session`.
* Naming communities after Code only: needs a model; §Troubleshooting
  already names `graphify cluster-only .` in a session.
* A `graphify` subcommand that prints the stamp: upstream; the grep does it.

**Done when.**

* [x] `bin/focus-kit selftest` green.
* [x] `VERSION` is `0.11.0`, `focus-kit install .` run, check 6 empty.
* [x] `grep -n "GRAPH_REPORT.md" manuals/graphify.md` names no line of the
      §Ensuring the graph table, and `grep -rn "Built from commit" skills/`
      prints nothing.
* [x] Proof, per `docs/05-Process.md` §6: `git clone` of this repository
      into a scratch directory, `focus-kit install <scratch>` from the
      working tree, then `/apply` runs the branch there four times, from
      the manual's text, and pastes each transcript into
      `work/done/<slug>.md`. Code only, both commands: report exists,
      `Community N` in it, stamp equals `HEAD`, no `cost.json`, branch
      silent. Stale: one empty commit in the clone (no hook there, nothing
      rebuilds), the stale line, `update`, stamp and report line equal to
      the new `HEAD`. Absent: the key dropped with a JSON-aware rewrite,
      simulating an older graphify, the no-stamp line, `update`, stamp
      back. Report without its freshness section, stamp equal to `HEAD`:
      silence, proving the report is not read. Scratch removed after.
      Ran five times, not four: the branch has a fifth state the page did
      not know about, below.
* [x] `focus-kit update ~/Downloads/vaulted`, `doctor` green there, nothing
      committed. Green on every kit-owned line and on the version. That tree
      holds no `docs/00` to `06` and no `CLAUDE.md` today, so `doctor` warns
      about the eight, and about the graph; those nine are the repository's
      state, not the kit's.

---

## What happened

**The proof broke the contract's action, and the manual changed with it.**
`graphify update .` was supposed to clear the third branch in every case.
It does not. graphify 0.9.63 writes `built_at_commit` from `git rev-parse
HEAD` only when the graph it is writing does not already carry one; every
later write carries the value already there forward. So:

* a build from scratch stamps `HEAD`;
* `graphify update .` stamps `HEAD` only when the re-extraction changes the
  topology, because only then does it write `graph.json` at all. When it
  changes nothing it writes nothing, `--force` included;
* `graphify cluster-only .` carries the stamp forward and writes `HEAD`
  only when the key is absent.

Two of the page's Behaviour bullets are false against that, and
`docs/05-Process.md` §6 says what the command produced wins:

* "Stamp different: ... runs `graphify update .`, which rewrites the stamp":
  true only when the code changed. After a commit that touched nothing
  graphify extracts, no free command moves the stamp, ever.
* "Stamp absent ... same command": `update` alone never restores an absent
  stamp. `graphify cluster-only . --no-label` does, at once.

**Two decisions, both asked.** First, whether to add a second step and where
(three options): the answer was `cluster-only . --no-label` only when
`update` was not enough, which keeps re-clustering, and the community names
it recomputes, out of the common path. Second, what the branch says in the
case nothing can fix (three options): the answer was one honest line,
`graph agrees with the code; stamp stays at <stamp>`, and no further action.
The branch therefore ends in a fix for the absent stamp and in a sentence
for the stale one. No ADR: it is still one table row plus its paragraphs,
reversed by editing them.

**What the manual says now**, beyond the contract as written: the second
step fires on the grep still printing nothing, never on a SHA that is not
`HEAD`; a new paragraph states the carry-forward rule and why `cluster-only`
is the fix for one case and no fix for the other; the announced lines are
four, not two. `docs/03-Domain.md` carries the same precision in Graph stamp
and one clause in Ensuring the graph saying the third branch is the only one
that can end without fixing what it found.

**Not touched, on purpose.** §When the graph is rebuilt still reads "updated
when the SHA is behind HEAD", which stays true of what the branch does. The
contract did not name that line and the delivery did not widen to it.

**Dropped.** Nothing.

## Proof

A clone of this repository into a scratch directory, `focus-kit install
<scratch>` from the working tree, the branch run from the manual's text.
The clone has no hook, so nothing rebuilds behind the run. The first two
branches were run once first, unedited, to reach the third.

```
$ graphify hook status
post-commit: not installed

$ env -u <the six keys> graphify .
error: no LLM API key found (52 doc/paper/image file(s) need semantic ext...
[graphify extract] found 5 code, 52 docs, 0 papers, 0 images
```

**1. Code only, both commands.** Free, no model, and it leaves a report.

```
$ graphify . --code-only && graphify cluster-only . --no-label
[graphify extract] wrote .../graphify-out/graph.json: 30 nodes, 87 edges, 5 communities
Graph: 30 nodes, 87 edges
Done - 5 communities. GRAPH_REPORT.md, graph.json and graph.html updated.

report:    graphify-out/GRAPH_REPORT.md
Community: - Community 0 / - Community 1 / - Community 2 / - Community 3
stamp:     b31fba497b9f2579bc54e031e2d167f56b06dd42
HEAD:      b31fba497b9f2579bc54e031e2d167f56b06dd42
cost.json: ls: graphify-out/cost.json: No such file or directory
hook:      post-commit: not installed

-- third branch --
(exit 0; nothing printed = silence)
```

**2. Stale, and `update` is enough.** One empty commit. The code-only graph
differs from a full re-extraction, so `update` rebuilds and restamps.

```
HEAD is now 22e362d5
graph stale (built from b31fba49, HEAD 22e362d5); graphify update .
[graphify watch] Rebuilt: 458 nodes, 463 edges, 54 communities
[graphify watch] graph.json, graph.html and GRAPH_REPORT.md updated in graphify-out
stamp:  22e362d5d53d78652e72f49573f925161ad56605
report: - Built from commit: `22e362d5`
HEAD:   22e362d5d53d78652e72f49573f925161ad56605
```

**3. Stale, and nothing can fix it.** The state the page did not know about.
A second empty commit, with the graph already full.

```
HEAD is now 55e6c73d
graph stale (built from 22e362d5, HEAD 55e6c73d); graphify update .
[graphify watch] No code-graph topology changes detected; outputs left untouched.
graph agrees with the code; stamp stays at 22e362d5
stamp:  22e362d5d53d78652e72f49573f925161ad56605
HEAD:   55e6c73d4585ade2450f2b094b158b01b298d91f

-- run it again --
graph stale (built from 22e362d5, HEAD 55e6c73d); graphify update .
[graphify watch] No code-graph topology changes detected; outputs left untouched.
graph agrees with the code; stamp stays at 22e362d5
```

The repeat is deliberate: it is what the next session sees, and the line
above it is why the manual now says so out loud.

**4. Absent, an older graphify.** The key dropped with a JSON-aware rewrite.

```
key dropped, simulating an older graphify
grep prints: ''
graph has no stamp; graphify update .
[graphify watch] No code-graph topology changes detected; outputs left untouched.
graph still has no stamp; graphify cluster-only . --no-label
Done - 54 communities. GRAPH_REPORT.md, graph.json and graph.html updated.
stamp:  55e6c73d4585ade2450f2b094b158b01b298d91f
report: - Built from commit: `55e6c73d`
HEAD:   55e6c73d4585ade2450f2b094b158b01b298d91f
```

**5. Report without its freshness section, stamp equal to `HEAD`.** The
report is not read.

```
freshness section stripped from the report
report line: '0' occurrences
stamp:       55e6c73d4585ade2450f2b094b158b01b298d91f
HEAD:        55e6c73d4585ade2450f2b094b158b01b298d91f
-- third branch --
(exit 0; nothing printed = silence)
```

The scratch directory was removed after. `bin/focus-kit selftest` is green,
six checks.

## Environments

| Environment | State |
|---|---|
| Kit source | `0.11.0`, `manuals/graphify.md` edited |
| Dogfood copy | `0.11.0`, `focus-kit install .` run, selftest check 6 empty |
| Machine | CLI untouched, a symlink to the source; global `/graphify` skill at the package's version |
| First target (`~/Downloads/vaulted`) | `0.11.0`, `focus-kit update` run, nothing staged and nothing committed |
| Other targets | untouched, at whatever version their owner installed. They move with `focus-kit update <path>`, run by that person |
