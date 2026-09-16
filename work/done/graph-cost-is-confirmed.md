# graph-cost-is-confirmed

**Goal.** A person sees what the graph extraction will read and says yes
before a session or an exported key is billed for it, and hears what it cost
when it is done.

**Behaviour.**

* In a clone with no graph and docs in the corpus, `/propose`, `/apply` and
  `/initialize` quote the count line `graphify .` printed when it refused
  and ask the Graph confirmation. Nothing is extracted before the answer.
* "Build now" runs `/graphify .` (or `graphify .` when one of the six keys
  the refusal names is exported), then the command says the `input_tokens`
  of the last entry of the Cost ledger.
* "Code only" runs `graphify . --code-only`, free, and the command says the
  docs, papers and images stay out of the graph until a person runs
  `/graphify --update`.
* "Not now" builds nothing. The command says it is working without a graph,
  reads the files it needs directly, and the next session asks again.
* A code-only corpus never sees the question: `graphify .` succeeds for
  free, as today.
* With a backend key exported, the attempt still refuses and the question
  still comes before the bill; the build answer names the key as who pays.
* Nothing the kit ships says any longer that `/graphify` asks.

**Contract.** Two kit-owned files change; `/propose` and `/apply` inherit by
reference and are not edited.

`manuals/graphify.md`:

* §Everyday use, the comment on the bare `/graphify` line: `build or rebuild
  (asks nothing below graphify's own threshold)`.
* §Ensuring the graph, the first row: Condition, `graphify-out/graph.json`
  absent, and `env -u GEMINI_API_KEY -u GOOGLE_API_KEY -u MOONSHOT_API_KEY
  -u ANTHROPIC_API_KEY -u OPENAI_API_KEY -u DEEPSEEK_API_KEY graphify .`
  exits with `error: no LLM API key found`; Action, the Graph confirmation,
  then what its answer names; Cost, the session's tokens or the exported
  key's, only after "Build now". The six variables are the ones the refusal
  line names today (verified on graphify 0.9.63), unset for the attempt
  alone, so that a corpus with docs always refuses and prints its count
  line; a key the line names later joins the row. The trap paragraph is
  replaced by that sentence. The paragraph
  "The first branch's action is not a judgement call" is rewritten: the
  agent still has no discretion at this branch, the person has all of it,
  and "not now" is an answer the command records out loud, not a branch it
  skipped. The question is written there once, verbatim, and the commands
  ask it as written: one `AskUserQuestion`, the question `graphify refused:
  <the found line>. Build the graph?`, three options in this order. **Build
  now**: `/graphify .` in this session, billed as its tokens; when one of the
  six keys is exported, `graphify .` instead, billed to that key's account. Two runs from
  the Cost ledger for scale: 38 files cost 187,743 input tokens, 62 files
  cost 433,524. **Code only**: `graphify . --code-only`, free, no model;
  docs, papers and images stay out until `/graphify --update`. **Not now**:
  nothing is built; this command reads files directly and the next one asks
  again. After "Build now" the command prints `graph built: <N> input
  tokens (graphify-out/cost.json)`, N read from the last entry of `runs`,
  or `graph built; graphify-out/cost.json absent` when the run wrote none.
* §When the graph is rebuilt, last paragraph: `/graphify` by hand asks
  nothing below its own threshold of 2,000,000 words or 500 files, and above
  it asks which subfolder, never whether; the kit's commands ask through
  §Ensuring the graph. The Cost ledger sentence stays.

`skills/initialize/SKILL.md`: Step 1 (brownfield) replaces the `/graphify .`
block, the "let it" sentence and the hook block by one instruction, ensure
the graph per `docs/manuals/graphify.md` §Ensuring the graph, keeping the
sentences about reading the report; Step 1 (greenfield) says the same in
its closing paragraph; Step 4 already reports the state of the graph.

`docs/03-Domain.md`: Graph confirmation and Cost ledger entered by this
`/propose`; Ensuring the graph names `/initialize` as a third caller.
`docs/00-Product.md` §Keeping the map gains one sentence: an extraction is
billed only after a person confirms it.

**Slice.** `manuals/graphify.md` and `skills/initialize/SKILL.md`, both
kit-owned; `docs/00` and `docs/03`, project-owned; `VERSION`; the dogfood
copy. No change to `bin/focus-kit`. Applied after `graph-ignores-the-kit`
lands, which was in flight in this working tree when this page was written:
both bump `VERSION` and both edit `manuals/graphify.md`, in different
sections, and the two measured runs above predate its `.graphifyignore`.

**States.** All four branches satisfied: the command says nothing, as
today. The refusal: the question above. Then one line per answer:
`graph built: 187,743 input tokens (graphify-out/cost.json)`, `graph built
from code only; docs enter with /graphify --update`, `no graph this
session; reading files directly`.

**Visual reference.** No UI. The question as a person sees it:

```
graphify refused: found 31 code, 23 docs, 0 papers, 8 images. Build the graph?
  Build now   /graphify . in this session, billed as its tokens. Two runs from
              the Cost ledger for scale: 38 files cost 187,743 input tokens;
              62 files cost 433,524.
  Code only   graphify . --code-only, free, no model. Docs, papers and images
              stay out of the graph until you run /graphify --update.
  Not now     Nothing is built. This command reads files directly and says
              so; the next /propose or /apply asks again.
```

**Out of scope.**

* The global skill's own threshold and its "you may not need a graph" line:
  graphify's file, changed upstream, not by the kit.
* Remembering a decline: a kit-owned file inside `graphify-out/`, for a
  question that costs one keystroke.
* Words in the count: needs the uv tool's python, and words do not predict
  tokens (1.8 per word here, 10 on the first target).
* A token estimate before the build: a number that wrong is worse than the
  two measured runs.
* `Built from commit` after a first-branch build: `graph-staleness-without-a-stamp`.
* No ADR: a policy, reversed by editing one paragraph.

**Done when.**

* [x] `bin/focus-kit selftest` green.
* [x] `VERSION` bumped, `focus-kit install .` run, check 6 empty.
* [x] The four manual passages, the two `/initialize` passages and
      `docs/00` §Keeping the map read as the Contract says; no "asks" left
      that names `/graphify` as the asker (`grep -rn "asks before" manuals/
      skills/`).
* [x] Proof, per `docs/05-Process.md` §6: `git clone` of this repository
      into a scratch directory, `focus-kit install <scratch>` from the
      working tree so it holds the new manual, then `/apply` runs the first
      branch there itself, three times, asking the real question: "Not
      now" first (no graph results, the line is said), "Code only" second
      (`graph.json` exists, the line is said, `graphify-out/` removed
      after), "Build now" third (the cost line quotes the ledger). Each
      run's lines go into `work/done/`.
* [x] First target at the delivery's version:
      `focus-kit update ~/Downloads/vaulted`, nothing committed there.
* [x] `docs/06-Queue.md` line turned `[x]`, page moved to `work/done/`.

---

## What happened

`VERSION` went from 0.9.0 to 0.10.0: the three commands behave differently
in a clone with no graph, which is a change a target repository wants. Minor
and not patch, the way every behaviour change before it bumped.

### Divergences from the plan

* **The three proof runs came in the order the person chose, not the page's
  order.** The page scripted "Not now", then "Code only", then "Build now".
  The question was asked for real, three times, and the answers were "Build
  now", "Code only", "Not now". The page's order was a convenience, not a
  requirement: all three branches were exercised, each one from a fresh
  refusal with `graphify-out/` removed in between, and what each answer left
  behind is recorded below. What the run produced wins
  (`docs/05-Process.md` §6).
* **§Ensuring the graph's opening sentence gained `/initialize`.** The
  Contract named only the first row, the trap paragraph, the judgement-call
  paragraph and §When the graph is rebuilt, but the sentence above the table
  still read "`/propose` and `/apply` run the procedure below", while
  `docs/03-Domain.md`, written by this delivery's `/propose`, already says
  the procedure has three callers and this delivery makes `/initialize` the
  third. Leaving it would have shipped a manual that contradicts the domain
  document on the same page that adds the caller.
* **The second table row was reworded** from "`graphify .` succeeds" to "the
  same attempt succeeds". The two rows are one attempt, which the paragraph
  below them says in so many words; with the first row naming the six `env
  -u` flags and the second naming a bare `graphify .`, they would have read
  as two different commands.
* **The `/initialize` report sentences were kept but made conditional.** The
  Contract says to keep them. After "Not now" there is no
  `graphify-out/GRAPH_REPORT.md` to read, so the brownfield step now says to
  read it when a graph came out of the procedure and to keep reading the
  repository directly when it did not. The greenfield closing paragraph lost
  "the graph must exist for the MCP server in `.mcp.json` to start", which
  after "Not now" is false; it now says the graph is what the server reads
  from the next session on.
* **The "Not now" option says "the next command that needs the graph asks
  again"**, where the visual reference pasted "the next `/propose` or
  `/apply` asks again". Same reason as the opening sentence: `/initialize`
  is a third caller as of this delivery.

Nothing was dropped.

### What the proof found

A `git clone` of this repository into a scratch directory, then `focus-kit
install <scratch>` from this working tree, so the clone held the new manual
at 0.10.0. The corpus there: 56 files, 91,129 words, 5 code and 51 docs.

The attempt, run exactly as the first row names it, refused three times with
the same two lines:

```
error: no LLM API key found (51 doc/paper/image file(s) need semantic extraction). ...
[graphify extract] found 5 code, 51 docs, 0 papers, 0 images
```

and the question a person saw, three times:

```
graphify refused: found 5 code, 51 docs, 0 papers, 0 images. Build the graph?
```

* **Run 1, "Build now".** `/graphify .` ran in this session: 56 files
  detected, 51 sent to three extraction subagents, 309 nodes, 516 edges, 25
  communities. The Cost ledger's last entry read 508,219 input tokens on 56
  files, and the line the command said was
  `graph built: 508,219 input tokens (graphify-out/cost.json)`.
* **Run 2, "Code only".** `graphify . --code-only` exited 0 in seconds and
  wrote `graph.json` with 30 nodes, 87 edges, 5 communities. No model was
  called and **no `cost.json` was written at all**, which is the branch
  behaving as designed: free means nothing to bill and nothing to report.
  The line was `graph built from code only; docs enter with /graphify
  --update`.
* **Run 3, "Not now".** Nothing was run. The line was `no graph this
  session; reading files directly`.

Three things the runs settled that reading could not:

* **A refused attempt leaves `graphify-out/cache/` behind and no
  `graph.json`.** The branch condition is `graph.json` absent, so the next
  session still reaches the first branch and still asks. Nothing needs
  cleaning up after a refusal.
* **`/graphify` asked nothing of its own.** 91,129 words and 56 files are
  far below its threshold of 2,000,000 words or 500 files, so the only
  question the person saw was the Graph confirmation. That is the new
  sentence in §When the graph is rebuilt, proven rather than asserted.
* **508,219 input tokens for 56 files** is a third point on the same curve
  as the two the manual quotes (38 files at 187,743; 62 at 433,524). The
  manual keeps the two the Contract names: they are ledger entries from
  ordinary runs, while this one is a proof run measured inside a delivery,
  and two numbers a person can check beat three where one needs a footnote.
  The footnote it would need: this session's harness reports one total token
  count per subagent rather than an input/output split, so all 508,219 went
  into `input_tokens` and `output_tokens` stayed 0.

One thing the run reported that is not a defect: the health check flagged 16
collapsed undirected edges. That is an undirected build folding two
directions between the same pair of nodes, on 532 raw edges, with zero
dangling, missing or self-loop edges. The graph is sound.

`bin/focus-kit selftest` is green, six checks. `grep -rn "asks before"
manuals/ skills/` returns nothing.

### Decisions

No ADR, as the page says: this is a policy, reversed by editing one
paragraph of one manual. `docs/03-Domain.md` needed no edit, because the
`/propose` that wrote this page had already entered Graph confirmation and
Cost ledger and named `/initialize` as a third caller of Ensuring the graph.

### Environments

| Environment | State |
|---|---|
| Kit source | 0.10.0 |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.10.0, `focus-kit install .` run, check 6 empty |
| Machine (`~/.local/bin/focus-kit`) | symlink to the kit source, follows it; global `/graphify` skill at graphify 0.9.63 |
| First target (`~/Downloads/vaulted`) | 0.10.0, `focus-kit update ~/Downloads/vaulted` run, nothing staged and nothing committed there |
| Target repositories (anyone else's) | untouched; they move when their owner runs `focus-kit update` |
