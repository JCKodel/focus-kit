# graph-rebuilds-on-demand

**Goal.** A person finishes a delivery, commits, and `git status` comes back
clean, because the graph is no longer a versioned file that the post-commit
hook rewrites behind the commit.

**Behaviour.**

* After `/apply` stages and a person commits, the post-commit hook rebuilds
  the graph and `git status` stays clean, because `graphify-out/` is
  ignored. No delivery commit carries a graph diff.
* `/propose` and `/apply` begin by ensuring the graph, following the named
  procedure in `docs/manuals/graphify.md`. Neither command reads a graph it
  has not first confirmed.
* In a fresh clone there is no `graphify-out/`. The command says the graph
  is absent, builds it, and only then queries it. On a corpus that has docs,
  papers or images that means `/graphify .` inside the session, which costs
  the session's tokens; on a code-only corpus the CLI does it for free.
* When `Built from commit` in `graphify-out/GRAPH_REPORT.md` differs from
  `git rev-parse HEAD`, the command runs `graphify update .`, which costs
  nothing, and says it did. This is the normal state after `git pull`,
  which fires no hook.
* When the post-commit hook is missing, the command installs it. Hooks are
  never versioned, so every fresh clone starts without one.
* A person who never opens `/propose` or `/apply` is unaffected: nothing
  runs on its own, and no hook is added at clone time, because git has none
  that fires then.

**Contract.**

`config/gitignore.fragment`, its graphify block only. The three lines
`graphify-out/cost.json`, `graphify-out/.graphify_python` and
`graphify-out/.graphify_root` and the comment above them become:

```
# graphify: the graph is derived, not authored. It is rebuilt on demand by
# /propose and /apply (docs/manuals/graphify.md), so no commit carries a
# graph diff and the post-commit hook never leaves the worktree dirty
graphify-out/
```

The duplicate `.claude/settings.local.json` line in the same file is not
touched; `gitignore-no-duplicates` owns it.

This repository's own `.gitignore` receives the same block, and
`git rm -r --cached graphify-out` removes the tracked copy. The files stay
on disk.

`manuals/graphify.md`, kit-owned, three changes:

| Place | Today | Becomes |
|---|---|---|
| Line 9 | "`graphify-out/` and is versioned" | the same sentence without "and is versioned" |
| Line 29, the `graphify-out/` row | "versioned, except cost and machine paths" | "not versioned; rebuilt on demand by `/propose` and `/apply`" |
| Troubleshooting, the MCP and clone entries | an MCP server that fails to connect is an edge case | it is the normal first session in a clone, and the ensure procedure is what fixes it |

Plus one new section, `## Ensuring the graph`, which is the single place the
procedure is written. It has four branches, checked in this order:

| Condition | Action | Cost |
|---|---|---|
| `graphify-out/graph.json` absent, and `graphify .` exits with `error: no LLM API key found` | `/graphify .` in the session | the session's tokens |
| `graphify-out/graph.json` absent, and `graphify .` succeeds | nothing further; the CLI already built it | none |
| `Built from commit` in `GRAPH_REPORT.md` differs from `git rev-parse HEAD` | `graphify update .` | none |
| `graphify hook status` says the post-commit hook is absent | `graphify hook install` | none |

The first two branches are one attempt, not an inspection: the procedure
runs `graphify .` and lets the exit decide. A corpus with docs, papers or
images makes it refuse in graphify's own words, `error: no LLM API key found
(N doc/paper/image file(s) need semantic extraction)`; a code-only corpus
makes it succeed for free. The skill never scans extensions to guess which.

The third branch covers code only. `graphify update .` re-extracts code and
rewrites `Built from commit`, so after a docs-only pull the SHA matches HEAD
while the doc side of the graph is still old. The section says so and points
at its own lines 49 and 50, which already tell a person that doc changes
need `/graphify --update`. That is today's behaviour, not something this
delivery introduces.

`skills/propose/SKILL.md` and `skills/apply/SKILL.md`, kit-owned, one line
each in "Read first", replacing the conditional that assumes the graph may
or may not be there: ensure the graph first, per
`docs/manuals/graphify.md` §Ensuring the graph, then query it.

`skills/apply/SKILL.md:71-73` loses its closing sentence, the one that tells
`/apply` to suggest `graphify hook install` when the hook is missing. Once
the hook is ensured in "Read first", that sentence is stale and is the third
place the same check is written, after `bin/focus-kit:206-209`, which was
the first.

`bin/focus-kit:204`: the warning text only. The hint stops reading as a
defect and names the procedure. The check itself, the `warn` shape and the
scratch repository's expected warning count are unchanged.

`docs/adr/ADR-0004-graph-is-derived-not-versioned.md`: new. It reverses a
rationale the fragment stated in writing, so it records the measurement that
decided it, on this repository, 4 code files and 47 docs: a fresh clone
rebuilding from zero needs a model for the 47, while the worktree was left
dirty by every single commit. The cost lands once per machine instead of
once per commit.

`VERSION` goes to `0.4.0`: the fragment, the manual and two skills are all
things a target receives.

**Slice.** Three kit-owned files (`manuals/graphify.md`,
`skills/propose/SKILL.md`, `skills/apply/SKILL.md`) and one appended once
(`config/gitignore.fragment`), plus `bin/focus-kit` and this repository's
project-owned documents. No merged file changes:
`.mcp.json` keeps pointing at `graphify-out/graph.json`, which is correct,
only no longer versioned.

**States.** The three commands say what they did and never do it silently: a
line when the graph was absent and was built, a line when it was stale and
was updated, a line when the hook was installed, and nothing at all when all
four conditions are already satisfied. `doctor` keeps reporting a missing
graph as a `warn`, never a `die`: a repository with no graph is incomplete,
not broken.

One race the procedure has to answer, and `/apply` decides how: the hook
rebuilds detached, so a person who commits and opens `/propose` moments
later finds `Built from commit` behind HEAD while `_rebuild_code` is still
writing, and the stale branch would fire on top of it. Two seconds here,
minutes in the repositories the hook's own comment warns about. Either the
procedure checks whether a rebuild is in flight (the mtime of
`~/.cache/graphify-rebuild.log`, which the hook names) or it accepts the
double rebuild and the delivery records that it did.

**Visual reference.** No UI. `bin/focus-kit:204` prints, on a target with no
graph:

```
  ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
```

**Out of scope.**

* **Targets that already installed the old fragment.** The block is appended
  once and guarded by its marker, so `focus-kit update` will not replace it;
  their owner edits it by hand. It is filed under "Later, not scheduled" in
  `docs/06-Queue.md`, blocked on open decision 5 like the overwrite case
  beside it.
* A post-clone automation. Git has no such hook, `.git/hooks/` is not
  transferred by a clone, `core.hooksPath` has to be set after one and
  `init.templateDir` is per machine. Measured, not assumed.
* Versioning a subset of `graphify-out/`. It shrinks the diff and leaves the
  dirty worktree exactly as it is.
* Replacing the post-commit hook with a pre-commit one. It would put the
  graph in the same commit, at the price of blocking every commit in every
  target, and the kit is stack-agnostic.
* Curated community labels surviving a fresh clone. They do not, and that is
  part of the price the ADR records.

**Done when.**

* [x] `bin/focus-kit selftest` green, six `ok` lines.
* [x] `git status` is clean in this repository after a commit, with the hook
  installed and having run. Proven in a clone, not here, because `/apply`
  does not commit: see "What the proof found", the clean-worktree run.
* [x] `graphify-out/` is ignored and no longer tracked:
  `git ls-files graphify-out | wc -l` is 0, and the files are still on disk.
* [x] The ensure procedure exists in exactly one place.
  `grep -rn "Built from commit" skills/ manuals/` hits `manuals/graphify.md`
  and nothing else.
* [x] A real run, per `docs/05-Process.md` §6: in a scratch clone with
  `graphify-out/` removed, `/propose` reports the graph absent and builds it
  before querying. **Half of this held and the other half is the divergence
  the run found.** It reported the graph absent, in the procedure's own
  words, and then declined to build it. §6 says the run wins: the manual
  gained the sentence that makes the first branch not a judgement call, and
  that sentence is unproven until the next fresh-clone session.
* [x] `graphify update .` and the hook's incremental rebuild are compared on
  this corpus, **both under `PYTHONHASHSEED=0`**, which is what the hook
  pins and what the observation below lacked. Unpinned, the CLI full update
  gave 475 nodes in 99 communities where the hook gave 343 in 36; louvain
  churns without the seed, so that gap is not evidence of anything until the
  comparison is rerun. The procedure then names which command it invokes and
  why. Only a difference that survives the pinned seed is an upstream
  graphify report, and it is not a change here either way.
* [x] `VERSION` is `0.4.0`, `focus-kit install .` has been run, and check 6
  is green.
* [x] The documents that assert the old policy no longer do:
  `manuals/graphify.md` lines 9 and 29, `docs/03-Domain.md` (the Graph and
  Graph hook rows; the "Ensuring the graph" row was added by `/propose`),
  `docs/06-Queue.md`.
* [x] Environments: kit source at 0.4.0, dogfood copy in sync, machine
  follows the symlink, target repositories untouched until their owner runs
  `focus-kit update`.

---

## What happened

Built as written. Five divergences, none of them a change of scope. The
fifth was found by the proof and is under "What the proof found": the first
branch of §Ensuring the graph had to be made explicit that it is not the
agent's cost to weigh, because a real run weighed it and skipped the build.

**The ADR number.** The page asked for `ADR-0004`. That number was taken by
`ADR-0004-agpl-and-dual-licensing.md`, from the delivery before this one, so
the decision is `ADR-0005-graph-is-derived-not-versioned.md` and the index in
`docs/adr/README.md` gained its row. `docs/03-Domain.md` cites `ADR-0005`.

**The line numbers in the contract.** `manuals/graphify.md` had the
"and is versioned" phrase on line 10 and the `graphify-out/` row on line 30,
not 9 and 29. The same two places, one line further down than the page said.

**The race, answered by graphify rather than by the procedure.** The page
gave `/apply` two options, an mtime check on `~/.cache/graphify-rebuild.log`
or an accepted double rebuild. Neither was needed. graphify holds a per-repo
advisory `fcntl.flock` on `graphify-out/.rebuild.lock`
(`graphify/watch.py:94`), and the `update` command calls
`_rebuild_code(..., block_on_lock=True)` (`graphify/__main__.py:3827`), so a
command that reaches the stale branch while the hook's detached rebuild is in
flight waits for it and then runs, serialized. The worst case is a wait and a
second incremental pass; two writers on `graph.json` cannot happen. The mtime
check was also the worse of the two options on its own terms: that log is one
file per machine, shared by every repository, so it would have reported "in
flight" for a rebuild belonging to some other clone. The manual's
§Ensuring the graph records the lock and why nothing is done about the race.

**Two additions the contract did not name, both consequences of it.**
`manuals/graphify.md` line 59 said `cost.json` "is not versioned", which read
as the exception when the whole directory became one; it now says the ledger
is local to the machine. And §When the graph is rebuilt gained a bullet for
`/propose` and `/apply`, because that section owns the list of who rebuilds
the graph and would otherwise have been stale on the day it shipped.

One thing the page did not mention and the build found: `graphify .` refuses
for want of a key only when there is no key. When a backend key is exported,
it does not refuse, it extracts every document against that provider and
bills it. §Ensuring the graph now carries that warning next to the branch
that relies on the refusal.

## What the proof found

Every branch of the procedure was run against graphify 0.9.10, on a clone of
this repository, before the manual was written. The numbers in
§Ensuring the graph are these.

**Branch 1, the refusal, verbatim.** In a clone with `graphify-out/` removed
and no key in the environment (`env | grep -ci api_key` was 0), `graphify .`
printed `error: no LLM API key found (49 doc/paper/image file(s) need
semantic extraction).` and exited 1, after reporting `4 code, 49 docs, 0
papers, 0 images`. The page's quote was right and the corpus is 4 and 49, not
4 and 47.

**Branch 3, the comparison, both under `PYTHONHASHSEED=0`.** The gap
survives the pinned seed, so it was not louvain churn: `graphify update .`
gave 494 nodes in 110 communities, twice, from two different starting graphs,
and was a no-op on the third run ("No code-graph topology changes detected");
the hook's incremental rebuild gave 336 nodes in 37 communities. It is not an
upstream report either, because the two are different operations by design:
the hook passes `changed_paths` and re-extracts one file, `update` passes
none and re-extracts all of the code. What the numbers do show is that a
chain of incremental rebuilds drifts below a full extraction, which is the
reason the branch invokes `update`. It cost 1.1 seconds and no model.

**The clean worktree, which is the goal.** In a clone carrying this
delivery's `.gitignore` and with `graphify-out` removed from the index, with
the post-commit hook installed: commit a code change, let the detached
rebuild land, and `git status --porcelain` returns zero lines while
`Built from commit` in `GRAPH_REPORT.md` equals `git rev-parse HEAD`. That is
the delivery's goal observed directly. It could not be observed in this
repository, because `/apply` does not commit.

**The evidence for the ADR, found on the way.** A clone of this repository at
`8d1908f` has a committed `GRAPH_REPORT.md` that says
`Built from commit: 095d5402`. The versioned graph was not merely dirty after
each commit, it described the commit before it, permanently.

**One piece of friction, recorded and not fixed.** The third branch needs
`git rev-parse HEAD`, and `config/settings.baseline.json` allows
`Bash(graphify *)`, `git add`, `status`, `diff` and `log`, but not
`rev-parse`. In a real target the first session will therefore be asked to
approve it. `settings.json` is a merged file and this delivery's Slice says
no merged file changes, so it stays as it is; it belongs to the
`first-target-*` lines of `docs/06-Queue.md`, which exist to collect exactly
this.

**The real run of `/propose`, which diverged and changed the manual.**
`claude -p "/propose help-text-follows-header"` was run inside a fresh clone
with the new kit installed, no `graphify-out/`, no hook and no key in the
environment. `/propose` did reach §Ensuring the graph, did run `graphify .`,
did get the refusal, and did say so out loud, quoting the count of files that
would need semantic extraction. Then it declined to build: *"Não construí o
grafo. Caí no primeiro ramo de §Ensuring the graph. Para uma mudança de uma
linha que eu já tinha lido, testado e rastreado, a troca não compensava.
Anunciado, não pulado."* It wrote a coherent delivery page without a graph.

So the page expected "reports the graph absent and builds it before
querying" and the run produced "reports the graph absent, weighs the cost,
and works without one". `docs/05-Process.md` §6 says the run wins and the
divergence is recorded rather than quietly edited, and the finding is real:
the section as first written gave the branch an action and a cost and left
the agent to decide between them. An agent with no person to ask decided
against it, soundly, and the consequence is that the next session faces the
same trade and the clone never gets a graph, which is the thing ADR-0005
pays for once per machine. §Ensuring the graph now says the first branch is
not a judgement call, and names `/graphify` itself as the one place where the
cost is declined, by a person. That corrected branch has not been run in a
fresh clone; it is the first thing the next fresh-clone session proves.

Two other things the run reported are artifacts of the scratch setup and not
findings: it saw selftest check 6 red and `work/graph-rebuilds-on-demand.md`
missing, both because the clone was made from `8d1908f` and then had the new
kit installed over it. It also counted 53 files needing extraction rather
than 49, because the clone carried the extra `work/` pages.

## Decisions taken

* `ADR-0005`, the decision itself, with the measurement that reversed the
  rationale the fragment stated in writing.
* The stale branch invokes `graphify update .` and not the hook's
  incremental rebuild, on the evidence above. Recorded in the manual, not
  only here, because the procedure is what a target reads.
* Nothing is done about the in-flight rebuild, on the evidence of graphify's
  own lock. Recorded in the manual for the same reason.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.4.0. `config/gitignore.fragment`, `manuals/graphify.md`, `skills/propose/SKILL.md`, `skills/apply/SKILL.md`, `bin/focus-kit`. |
| Dogfood copy | in sync. `focus-kit install .` was run; selftest check 6 is green. |
| Machine (`~/.local/bin/focus-kit`) | untouched, a symlink, reports 0.4.0 through the source. |
| Target repositories | untouched. They move when their owner runs `focus-kit update`, and a target that already has the old gitignore block keeps it: the block is appended once and guarded by its marker, which is the queue line under "Later, not scheduled". |

This repository's own `graphify-out/` is still on disk and now untracked.
The commit that closes this delivery carries 104 index deletions for it,
once; no commit after it carries a graph diff.
