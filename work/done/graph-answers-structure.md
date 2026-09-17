# graph-answers-structure

**Goal.** A person running `/propose`, `/apply` or `/initialize brown` gets
from the graph an answer the graph can give, the structure around what the
delivery names, instead of a list of headings cut at the budget. Measured
before this page, on this repository at `4e226a8`: the question `/propose`
asks, `graphify query "<what this delivery touches>"`, came back as 57 of
69 nodes, all of them headings of `work/done/` pages and of the graphify
manual, truncated, with no function of `bin/focus-kit` among them; `graphify
explain "install_repo"` gave twelve connections with file and line, `graphify
affected "merge_json"` gave its four callers, and 18 of 21 sessions that
consulted the graph grepped first anyway.

**Behaviour.**

* `/propose`, after Ensuring the graph, asks a Structure question about what
  the queue line names and writes into the page what the answer named. It
  no longer says the graph tells which slices, entities and rules are
  involved.
* `/apply` asks a Structure question about the slice the page names and
  reads the files the answer names. A grep for who calls or depends on a
  symbol is what a reviewer points at.
* `/initialize brown` reads `graphify-out/GRAPH_REPORT.md` once, god nodes
  and community hubs, and runs `graphify explain` on a god node whose role
  the report does not make plain. It runs no `graphify query`; the "Not now"
  branch is as today.
* Every `CLAUDE.md` the kit writes states the rule by shape of question, not
  by order: who depends on what goes to the graph, text goes to grep.
* `docs/manuals/graphify.md` promises what the graph answers and lists the
  commands that answer it. The "where do business rules for orders live"
  example is gone.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Every file below is kit-owned; a target receives all of them
on `update`. Applies after `mcp-leaves-the-baseline`, which edits the same
manual and the same initialize skill in sections that do not overlap.

* `skills/propose/SKILL.md` §Read first: the sentence from "then ask it
  before grepping" to "rules are involved" leaves. In its place: after
  Ensuring the graph, `graphify explain "<function, file or entity the queue
  line names>"` for what it is connected to and `graphify affected "<the
  same>"` for what depends on it and changes with it; that is what the graph
  answers, from the edges it extracted; which rules are involved is in
  `docs/03-Domain.md` and the manuals already read; a question about text
  is for grep. The page names, under Slice, what the answer named.
* `skills/apply/SKILL.md` §Read first, item 5: `graphify query "<slice or
  entity>"` becomes `graphify explain "<the slice's entry point or entity>"`
  and `graphify affected "<the same>"`, and the files the two answers name
  are what is read; one sentence says that who calls or depends on a symbol
  is asked of the graph, never grepped.
* `skills/initialize/SKILL.md` Step 1 (brownfield), the paragraph "When a
  graph came out of it": the report is read once, god nodes and community
  hubs; `graphify explain "<god node>"` for each one whose role the report
  does not make plain; the `graphify query` sentence and its two example
  questions leave. The "Not now" sentence stays word for word.
* `manuals/graphify.md` §Why it is here: the sentence quoting "where do
  business rules for orders live" and the three uses after it become what
  the graph answers, the three Structure questions with file and line on
  every edge, and what it does not, which rules, because a rule is text;
  `/propose` asks what depends on what the delivery names, `/apply` the
  structure of the slice, `/initialize brown` reads god nodes and
  communities once. §Everyday use: `graphify query` keeps its two lines with
  the comment `# word-seeded traversal; headings on a prose corpus`; the
  block gains `graphify affected "X"   # what depends on X, two hops`,
  `graphify god-nodes --top 10   # the hubs, without the report` and the
  `path` line gains `--undirected` with `# the directed form misses a shared
  definer`. §Rules gains one bullet: a Structure question goes to the graph
  and never to grep; a question about text goes to grep; the graph never
  answers which rules apply.
* `manuals/process.md` §4: "it asks the graph what the delivery touches"
  becomes "it asks the graph what depends on what the delivery names"; §5
  item 1: "asks the graph for the slice" becomes "asks the graph the
  structure of the slice".
* `skills/initialize/templates/CLAUDE.md`, the graph line: `- the codebase
  graph: graphify-out/ (who depends on what goes to it, text goes to grep;
  docs/manuals/graphify.md)`.
* `VERSION`: `0.12.0` to `0.13.0`.
* This repository's own files: `CLAUDE.md` graph line, same words as the
  template; `docs/00` Defining a delivery ("asks the graph what the
  delivery touches" as in `process.md` §4) and Keeping the map ("ask the
  graph before grepping" becomes the shape rule); `docs/03` already carries
  the Structure question row, written by this page; `docs/06` line `[x]`.

**Slice.** Three skills, two manuals, one template, all kit-owned; this
repository's docs, project-owned. Nothing in `bin/focus-kit` or `config/`,
so no function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. At the graph step, after the lines
Ensuring the graph prints or its silence, each command says in one line
which Structure question it asked and what came back: `graph: explain
"<node>" named <n> files, affected "<node>" named <n>`, or `graph: no node
named "<node>"; reading the files the queue line names` when the graph has
none, which is the shape after Code only on a corpus whose names are in
docs. On "Not now", the line the manual already prescribes and nothing else.

**Visual reference.** The three shapes, measured here:

```
$ graphify explain "install_repo"        # 12 connections, file and line each
  --> merge_json() [calls] [EXTRACTED] bin/focus-kit:L329
$ graphify affected "merge_json"         # 4 callers, two hops
  - install_repo() [calls] bin/focus-kit:L329
$ graphify query "what this delivery touches"
  [!] TRUNCATED: showing 57 of 69 nodes (~2000-token budget)
  NODE What happened [src=work/done/first-target-delivery.md loc=L160 ...]
```

**Out of scope.**

* `graphify query` leaving the manual's command list: the CLI has it and the
  global skill uses it; the manual says what it is instead.
* A `--budget` or `--context call` on the query: tuning a question the
  commands should not ask.
* Ensuring the graph: all four branches unchanged; the Graph confirmation
  and its cost lines are as today.
* The global `/graphify` skill: graphify's file, not the kit's.
* Measuring the sessions again: the 18 of 21 is the reason, not a check;
  nothing reads transcripts.
* An ADR: reversing this is editing three paragraphs.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` at `0.13.0`;
  `focus-kit install .` run here last, after `mcp-leaves-the-baseline` is
  `[x]`.
* [x] `grep -rn "graphify query" skills/` prints nothing; `grep -rn "before
  grepping" skills/ manuals/ CLAUDE.md docs/00-Product.md` prints nothing.
* [x] Proof, this repository: the transcripts of the three Structure questions
  on the functions above, with the query beside them for the shape, in the
  done page.
* [x] Proof, the first target: `focus-kit update ~/Downloads/vaulted`, then the
  same three questions on a god node of its own code, transcript in the done
  page; `git reset` there, nothing committed.
* [x] Every doc the Contract names updated; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

Ten files edited, all ten the Contract named, plus `docs/03`, which the
Contract said needed nothing.
The three skills stopped asking `graphify query` and now ask
`explain` and `affected`; the graphify manual promises structure and lists
the commands that answer it; `process.md`, the template `CLAUDE.md`, this
repository's `CLAUDE.md` and `docs/00` carry the shape rule; `VERSION` went
to `0.13.0`.

### Proof, this repository

The graph was at `7ae0dfd`, equal to HEAD, hook installed: all four branches
of Ensuring the graph silent, nothing built, nothing asked. 400 nodes.

```
$ graphify explain "install_repo"
Node: install_repo()
  Source:    bin/focus-kit L289
  Degree:    12
Connections (12), 7 shown:
  <-- focus-kit [defines] [EXTRACTED] bin/focus-kit:L289
  --> merge_json() [calls] [EXTRACTED] bin/focus-kit:L325
  --> write_manifest() [calls] [EXTRACTED] bin/focus-kit:L314
  --> copy_tree() [calls] [EXTRACTED] bin/focus-kit:L300
  --> append_once() [calls] [EXTRACTED] bin/focus-kit:L330
  <-- check_install() [calls] [EXTRACTED] bin/focus-kit:L534
  <-- check_idempotent() [calls] [EXTRACTED] bin/focus-kit:L791

$ graphify affected "merge_json"
Depth: 2
- install_repo() [calls] bin/focus-kit:L325
- focus-kit script [calls] bin/focus-kit:L912
- check_idempotent() [calls] bin/focus-kit:L791
- check_install() [calls] bin/focus-kit:L534

$ graphify path "merge_json" "copy_tree"
No directed path found between 'merge_json' and 'copy_tree'. Re-run with --undirected to search ignoring edge direction.

$ graphify path "merge_json" "copy_tree" --undirected
Shortest path (2 hops):
  merge_json() <--defines [EXTRACTED]-- focus-kit --defines [EXTRACTED]--> copy_tree()

$ graphify query "what this delivery touches"
Graph: graphify-out/graph.json (400 nodes) | Traversal: BFS depth=2 | Start: ['first-target-delivery', 'first-target-delivery.md', 'A delivery'] | 21 nodes found
NODE first-target-delivery [src=work/done/first-target-delivery.md loc=L1 community=What happened]
NODE A delivery [src=docs/03-Domain.md loc=L193 community=Term in code]
NODE What happened [src=work/done/first-target-delivery.md loc=L160 community=What happened]
```

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.13.0` there. `graphify-out/`
was absent, so Ensuring the graph reached its first branch: the attempt
refused with `found 30 code, 8 docs, 0 papers, 8 images`, the Graph
confirmation was asked and the answer was **Build now**. `graph built:
240,695 input tokens (graphify-out/cost.json)`. 319 nodes, 16 communities,
one health warning surfaced as the skill requires: 17 dangling-endpoint
edges. `VaultedApp()` is the first god node whose source is code, 24 edges.

```
$ graphify explain "VaultedApp"
Node: VaultedApp()
  Source:    components/vaulted-app.tsx L335
  Community: Dashboard App Shell
  Degree:    24
Connections (24), 5 shown:
  <-- vaulted-app.tsx [contains] [EXTRACTED] components/vaulted-app.tsx:L335
  --> loadData() [calls] [EXTRACTED] components/vaulted-app.tsx:L352
  --> convertToUSD() [calls] [EXTRACTED] components/vaulted-app.tsx:L418
  --> saveData() [calls] [EXTRACTED] components/vaulted-app.tsx:L361
  --> parseCsv() [calls] [EXTRACTED] components/vaulted-app.tsx:L571

$ graphify affected "convertToUSD"
Depth: 2
- EntriesPanel() [calls] components/vaulted-app.tsx:L1272
- VaultedApp() [calls] components/vaulted-app.tsx:L418
- calculateTotals() [calls] lib/vaulted.ts:L155
- convertCurrency() [calls] lib/vaulted.ts:L129
- vaulted-app.tsx [imports] components/vaulted-app.tsx:L37
- app/page.tsx [imports] app/page.tsx:L1

$ graphify path "VaultedApp" "parseCsv" --undirected
Shortest path (1 hops):
  VaultedApp() --calls [EXTRACTED]--> parseCsv()
```

`affected` is the answer the page was built for: one question, three files,
a line on every edge, and nothing a grep for the symbol would have given
without reading each hit. `git reset` ran there; nothing staged, nothing
committed, the working tree as the update left it.

A parallel `/propose` session wrote `work/initialize-asks-for-the-proof-tool.md`
and turned its queue line to `[>]` while this delivery ran. Neither is staged
here: one delivery, one commit (`docs/05` §7). They are left for that
session.

### What diverged

* **The measurement in Goal no longer reproduces.** `graphify query "what
  this delivery touches"` came back as 21 nodes untruncated, not 57 of 69:
  the graph was rebuilt at `7ae0dfd` and is smaller. The shape held, which
  is what the page argued from: every node a heading of `work/done/` or of
  `docs/03`, not one function of `bin/focus-kit`.
* **The Visual reference line numbers moved.** `merge_json()` is called at
  `bin/focus-kit:L325`, not L329. The code moved between `4e226a8` and
  `7ae0dfd`. What the command produced wins (`docs/05` §6).
* **`path` proves the `--undirected` comment, with a different pair.**
  `install_repo` to `doctor_repo` finds no path either way; `merge_json` to
  `copy_tree` is exactly the shared definer case the manual's comment
  names, so that is the pair recorded.
* **The `--dfs` line keeps a meaning.** The Contract gave both `query` lines
  the comment `# word-seeded traversal; headings on a prose corpus`. The
  second reads `# word-seeded traversal, depth-first; headings on a prose
  corpus`, so the flag still says what it does while carrying the warning.
* **`docs/03` line 106 changed, although the Contract said `docs/03` needed
  nothing.** The Graph row still read "queried before grepping", which is
  the order rule this page removes. It now reads "asked the Structure
  question and never a question about text". Docs are living.
* **The States line went into `/propose` and `/apply`, not `/initialize`.**
  The page words the fallback for a queue line and for a delivery page, and
  `/initialize brown` has neither: it explains god nodes the report already
  named, so there is no node it can fail to find. Decided rather than asked.
* **Six SVGs shared one extraction chunk.** graphify's own skill gives each
  image its own chunk because vision needs separate context; six icon files
  are text. That is graphify's rule, not the kit's, and the whole corpus
  cost 240,695 tokens in four subagents instead of nine.
* **The cost ledger records input tokens only.** The subagent results carry
  one token total each, not an input and output split, so `output_tokens` is
  `0` in `cost.json` for this run. The number the manual makes the command
  say is the input one, and it is honest.

No ADR: reversing this is editing three paragraphs, as the page said.

### Environments

| Environment | State |
|---|---|
| Kit source | `0.13.0`, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | `0.13.0`, check 6 empty |
| Machine (`~/.local/bin/focus-kit`) | symlink, follows the source; global `/graphify` skill at graphify 0.9.63 |
| First target (`~/Downloads/vaulted`) | `0.13.0`, graph built, nothing staged, nothing committed |
| Other targets | untouched; they move on `focus-kit update <path>` |
