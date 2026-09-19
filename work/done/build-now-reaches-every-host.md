# build-now-reaches-every-host

**Goal.** A person who answers **Build now** at the Graph confirmation ends
that session with a graph, whatever Host they run, because the option says
what the session does instead of what the person types.

**Behaviour.**

* Under every Host `kit_hosts` names, a session that reaches the first branch
  of Ensuring the graph with none of the six keys exported, and is told
  **Build now**, ends with `graphify-out/graph.json` present.
* `docs/manuals/graphify.md` says once what graphify's skill is on a Host that
  loads it and offers no command to type, and **Build now** names what the
  session does rather than an invocation the person is assumed to have.
* Neither place names a Host: one text, read the same in every target,
  whatever Host that target is worked in.
* A person under Claude Code, where **Build now** works today, reads an option
  that still describes what their own session does.

**Contract.**

*Order.* After `graph-builds-without-a-key`, which is `[>]` and whose page
carries the nine runs behind this line. Its last "Done when" item asks for
exactly the evidence this delivery's proof run produces, so the run is
recorded in both pages: `/apply` appends it to that page's record, ticks that
item, moves the file to `work/done/` and turns its queue line `[x]`, in this
same delivery. `codex-port` is `[>]` and adds a third Host; whichever of the
two runs second inherits the other, so `/apply` reads `kit_hosts` at the time
of the run for which Hosts it proves under, and never a count written here.
`copilot-reads-the-project-rules` is `[>]` and independent: it writes a Host
instructions file and touches no manual.

*The condition the scope turns on.* Whether a Host that loads graphify's
Global skill and offers no command to type can run the extraction with its own
model at all. **`/apply` measures that first, before it writes anything**: it
reaches the first branch under each Host and reads what that session did with
graphify's `SKILL.md` on the machine. Two outcomes, and the page carries both
rather than a guess at which one the run finds:

* **it can**: **Build now** says what the session does, in words a session
  under any Host acts on, and the exported key stays the alternative it
  already is;
* **it cannot, for some Host**: **Build now** says, for that Host, that the
  exported key is the route there, the record carries the divergence, and
  nothing a user reads claims the graph builds there without one
  (`docs/05-Process.md` §6).

The wording itself is `/apply`'s, out of what the run showed, and never this
page's.

*Who makes the measurement.* Under a Host `/apply` cannot drive, it is a run
the person makes: a scratch repository, none of the six keys exported, and
that session asked to build the graph by following graphify's skill. `/apply`
names what to ask for, stops, and writes the manual only once the transcript
is in front of it. Reading graphify's `SKILL.md` and reasoning about what a
Host there would do is not the measurement (`docs/05-Process.md` §6). So the
delivery has two stops, the measurement before the edit and the proof run
after it, and the Host `/apply` is running under is the one it measures
itself.

*What **Build now** keeps.* The session's own model as what is billed and the
exported key as the alternative (`work/graph-builds-without-a-key.md`,
Contract). The two runs it quotes from the Cost ledger are what already
happened and stay, as does the count line it quotes from graphify
(`docs/03-Domain.md`, Contract). The three options, their order and their
labels are what `docs/03-Domain.md`, As written binds, and none of the three
changes: what changes is what one of them names as the action.

*Where the definition goes.* Once, host-neutral, in `manuals/graphify.md`,
where the manual introduces graphify's skill, saying what it is on a Host that
loads it and offers no command. No Host name and no path in it: the manual is
one file copied to every target as it is and reached by no substitution of
`render_prompt` (`docs/03-Domain.md`, Manual and Ported command), so this is
prose and never a substitution. Which line holds the definition is `/apply`'s,
inside that file. The other lines of the manual that name `/graphify` are read
against that definition and stay as they are.

*`docs/03-Domain.md`.* No new term. One row widens: Global skill opens `The
/graphify command a Host loads in every session`, which is the sentence the
runs of `graph-builds-without-a-key` falsified for the second Host, where the
skill is readable and not invocable, so the row says what a Host loads and
what a session there can do with it. As written is untouched.

*`selftest`.* Unchanged in kind. No check reads the manual's prose beyond
check 5's em dash grep and check 6's Dogfood copy diff, so the verify command
is green on the edit alone and **the proof is the run**
(`docs/05-Process.md` §6).

*No new dependency, no new file, no ownership change.* The manual stays
kit-owned; nothing is merged and nothing is appended once.

*No new ADR.* Nothing here is expensive to reverse: it is prose in one
kit-owned manual. `ADR-0007` is untouched, because no Ported command is added.

**Slice.** `manuals/graphify.md` and its Dogfood copy, plus this repository's
own documents (`docs/01-Architecture.md` §3, Structure, neither slices nor
layers: one file; §4 for where each lives). No View, Orchestrator, Use case or
Repository: §3 says none of the four exists here. The graph named
`manuals/graphify.md` alone for the manual and nothing affected by it, and
`bin/focus-kit` alone both ways for `render_prompt`, which is the confirmation
that the manual sits outside the substitution list. Kit-owned:
`manuals/graphify.md` and `docs/manuals/graphify.md`. Project-owned:
`docs/03-Domain.md`, `docs/06-Queue.md` and
`work/graph-builds-without-a-key.md`. Merged: nothing. Appended once: nothing.
`bin/focus-kit` is not touched: the Host list, the install and `doctor` are
`graph-builds-without-a-key`'s and already shipped.

**States.** The defaults. No line of `bin/focus-kit` changes, so the CLI
prints what it prints today. What changes state is the session: at the first
branch it asks the Graph confirmation as it does now, and after **Build now**
it says what the answer cost in the line §Ensuring the graph already fixes,
`graph built: <N> input tokens (graphify-out/cost.json)`, or `graph built;
graphify-out/cost.json absent` when the run wrote none.

**Visual reference.** No UI, and no output line of the CLI changes. What a
person reads that is new is the manual's own text, whose words come out of the
measurement and not out of this page.

**Out of scope.**

* A graphify prompt among the Ported commands. Whatever the manual says has to
  say it once and for every Host, and a Ported command is rendered from a
  `SKILL.md` under `skills/`, which graphify's is not.
* The other lines of the manual that name `/graphify`. They read against the
  definition this delivery writes; one that still misleads after it is its own
  `/discuss`.
* Codex. `codex-port` is `[>]`; the proof is under the Hosts `kit_hosts` names
  at the time of the run.
* Any change to `bin/focus-kit`, to the install or to `doctor`. All three were
  this delivery's predecessor's.
* The questions under Copilot in VS Code.
  `work/graph-builds-without-a-key.md` names it as a second line the queue is
  missing, and a queue line is `/discuss`'s.
* `README.md`. `readme-makes-the-case` is `[ ]` and is where the kit's own
  case is written.

**Done when.**

* [x] The measurement made first, before anything is written, and recorded per
  Host: what a session that loads graphify's Global skill did with it, with
  none of the six keys exported. Three surfaces, 2026-09-19, §The measurement.
  **The answer is yes on every one.**
* [x] `manuals/graphify.md` says once, host-neutral, what graphify's skill is
  on a Host that loads it and offers no command, and **Build now** names what
  the session does. It says it **inside `Build now`**, which is the second
  wording and not the first: §Why the wording failed and §The second wording.
* [x] The first branch of Ensuring the graph run by the person in a scratch
  repository with none of the six keys exported, under every Host `kit_hosts`
  names at the time of the run, both GitHub Copilot surfaces included,
  **Build now** answered in each, and what each produced recorded. `/apply`
  stops there and asks for the transcript of every Host it cannot drive. Two
  Hosts, three surfaces, five rounds, all 2026-09-19; the rounds that failed
  are recorded beside the one that did not, §The fifth round, and it closes.
* [x] Where a run ended in a graph, `graphify-out/graph.json` present in that
  scratch; where it did not, the record says what it found and nothing a user
  reads claims it (`docs/05-Process.md` §6). All three surfaces ended in one at
  the third wording. The four earlier runs that did not are each written down
  with what they produced, and the one difference the closing round left
  standing, VS Code's hand-authored nodes, is stated and not claimed away.
* [x] `bin/focus-kit selftest` green, six checks. At 0.40.0, after the edit
  and the install.
* [x] The Dogfood copy in sync: `focus-kit install .` run here
  (`docs/05-Process.md` §5), and check 6 of the verify command empty.
* [x] `VERSION` bumped: a target receives a manual whose text changed
  (`CLAUDE.md`, How to work). 0.39.0 to 0.40.0.
* [x] `docs/03-Domain.md`, Global skill written.
* [x] `work/graph-builds-without-a-key.md`: this run appended to its record,
  its last "Done when" item ticked, the file moved to `work/done/` and its
  queue line turned `[x]`. Three of the four were already done by the session
  that closed that page on 2026-09-19, before this one opened; this delivery
  appends the run. §The order this page assumed.
* [ ] The environments of `docs/05-Process.md` §5 in the state that table
  requires.

---

## The order this page assumed

The Contract's *Order* asks `/apply` to close `graph-builds-without-a-key` in
this same delivery: append this run to its record, tick its last "Done when"
item, move the file to `work/done/` and turn its queue line `[x]`. **Three of
those four were already done** when this session opened. That page was closed
on 2026-09-19 by a session of its own, on a **no**: its §Why this page closes
on a no records the deadlock, that its last item asked for a run that could not
end in a graph while **Build now** named `/graphify .`, and that the sentence
which had to change was this delivery's. So the item is ticked, the file is in
`work/done/` and the line is `[x]`, and what was left for here is the append,
which §The measurement and §The proof run are.

That page closed with the behaviour **falsified and not delivered**, left
standing in its Behaviour on purpose (`docs/05-Process.md` §6). This delivery
is what makes it true, and by the route that page could not take: not a
different Host, but a different instruction.

## The measurement

Made first, before a byte of the kit moved, as the Contract requires. What it
had to settle is not whether **Build now** works today, which the nine runs
behind this page already answered no to, but whether a Host that loads
graphify's `SKILL.md` and offers no command to type **can run the extraction
with its own model at all**.

### What was verified before any session opened

* **None of the six keys exported.** `env | grep -cE '^(GEMINI_API_KEY|
  GOOGLE_API_KEY|MOONSHOT_API_KEY|ANTHROPIC_API_KEY|OPENAI_API_KEY|
  DEEPSEEK_API_KEY)='` returned `0`.
* **No version confound.** `graphify --version` is 0.9.63, and both Hosts'
  Skill stamps read 0.9.63. `~/.claude/skills/graphify/SKILL.md` and
  `~/.copilot/skills/graphify/SKILL.md` are **identical byte for byte**, so the
  paragraph that decides this ("when `GEMINI_API_KEY`/`GOOGLE_API_KEY` are
  unset, semantic extraction falls to the host agent itself") is the same text
  F and G read. A `SKILL.md.bak` sits beside the Claude Code copy and is stale;
  the live file is what a session loads.
* **The corpus.** Every scratch of the two pages before this is gone from the
  machine, so `seedledger` was rebuilt to the description
  `work/done/graph-builds-without-a-key.md` gives: a Flask and SQLite seed
  library by layer, rules inside the handlers, three exceptions raised there
  and caught in the web layer, two test files, `README.md` and
  `notes/design.md` as prose. `~/Downloads/seedledger-base`, committed at
  `3528bcf`, clean tree, 12 code files and 2 documents. Every scratch below is
  a copy of it, so the three surfaces were measured on the same bytes.
* **The first branch is real, not asserted.** In each scratch,
  `env -u ... graphify .` exits with
  `error: no LLM API key found (2 doc/paper/image file(s) need semantic
  extraction)` and prints `found 12 code, 2 docs, 0 papers, 0 images`.

### What each surface was asked

Under the Host `/apply` runs in, it measured itself. Under the two it cannot
drive, the run is the person's, and the prompt was the same on both, naming no
mechanism:

```
Build the knowledge graph of this repository by following the graphify skill.
```

Not `/graphify .` and not `graphify .`. Reproducing what F and G were told
would have measured the manual's wording a tenth time, which was not the open
question.

### What each one did

| Surface | Scratch | What the session did | `graphify-out/graph.json` |
|---|---|---|---|
| Claude Code | `seedledger-claude-H` | loaded the skill, ran Part A's AST pass, dispatched one `general-purpose` subagent for the two documents, merged through Part C, clustered, labelled, exported | **present**: 77 nodes, 147 edges, 12 communities |
| GitHub Copilot in VS Code | `seedledger-copilot-H` | read the skill, ran `graphify .`, took the key error, and **recovered**: "The skill explicitly allows the host agent to supply semantic extraction without requesting a key, so I'm delegating the two-document extraction to a subagent". Subagent returned 15 nodes, 16 edges, 1 hyperedge. Then `graphify . --code-only` for the AST side and `graphify.build.merge_raw_extraction` to join them, persisted by hand, `cluster-only` | **present**: 75 nodes, 133 edges, 12 communities |
| GitHub Copilot CLI | `seedledger-copilot-I` | followed the skill from Step 1, never ran the bare `graphify .` at all, dispatched a `task` that read both documents and wrote `.graphify_chunk_01.json` (15 nodes, 11 edges), then Part B3, Part C, Step 4, the health check, the labels and Step 9 | **present**: 75 nodes, 130 edges, 14 communities |

**The answer is yes, on every surface.** Three sessions, none with a key, all
three extracted the two documents on their own model and all three reached a
graph.

### The three took three different routes, and that is the finding

The Contract left the wording to the run. What the run shows is that the
**route** is not portable and the **outcome** is. Claude Code followed Part B
as written. Copilot in VS Code invented a merge path through the package
rather than the skill's Part C. The Copilot CLI ran the pipeline nearly whole.
A wording that names any one of those routes is wrong on the other two. A
wording that names the outcome, the session builds the graph by following
graphify's skill, is right on all three, and that is what **Build now** now
says.

### What separates this from F and G, and it is not the Host

F and G were told an invocation. They had none, fell to the binary, took the
key error and stopped. H, on the same surface as F, ran the **same binary** and
took the **same error**, and then went on, because the instruction it was
following was the skill and the skill says the host is the LLM. So the thing
that changed the outcome is the instruction, not the Host. That is what makes
this a wording delivery and not a porting one, and it is why nothing in the
manual needs a Host's name.

## What was written

Two edits to `manuals/graphify.md`, and the definition is in **one** of them.

**The definition**, once, host-neutral, as a paragraph directly under the
table of §The pieces, where the manual introduces graphify's skill. It says
that the skill is instructions and not a command the kit ships; that the agent
loads it every session and follows it; that typing `/graphify` is what starts
it where the agent offers a way to invoke a skill by name and asking the
session to build the graph is what starts it where it does not; that the route
differs and the outcome does not; and that with no key exported the extraction
runs on the session's own model. No Host is named and no path is in it.

**Build now** names what the session does and points at that paragraph rather
than repeating it:

```
* **Build now.** This session builds the graph, following graphify's skill
  (§The pieces), billed as its tokens. When one of the six keys is exported,
  `graphify .` instead, billed to that key's account. Two runs from the Cost
  ledger, for scale: 38 files cost 187,743 input tokens, 62 files cost
  433,524.
```

What the Contract said it keeps, it keeps: the session's own model as what is
billed, the exported key as the alternative, the two Cost ledger runs verbatim,
and the three options with their order and their labels untouched. The
`(§The pieces)` self-reference follows the shape four other lines of the same
manual already use.

`docs/03-Domain.md`, **Global skill**: the row opened on `The /graphify command
a Host loads in every session`, which is the sentence the nine runs falsified.
It now separates what a Host loads from what a session there can do with it,
and carries this measurement as the other half of the one
`graph-builds-without-a-key` took.

No ADR: this is prose in one kit-owned manual and cheap to reverse, which is
what the Contract predicted. No new term, so `docs/03-Domain.md` gained a
widened row and no line. No dependency, no file, no ownership change, and
`bin/focus-kit` is untouched.

`VERSION` 0.39.0 to 0.40.0: a target receives a manual whose text changed, and
the change is what one of the Graph confirmation's three options does.

## The proof run

Three fresh scratches, same corpus at `3528bcf`, the kit installed at **0.40.0**
so each carries the new manual, no `graphify-out/`. The first branch reached in
each, **Build now** answered.

### Claude Code, `~/Downloads/seedledger-claude-J`, run here

The branch was reached for real: `found 12 code, 2 docs, 0 papers, 0 images`,
no `graph.json`. Acting on the **new** text and not on memory of the skill: one
subagent for the two documents, Part C, build, health check, labels, HTML,
Step 9, then the fourth branch.

One number is left as measured rather than reconciled. Part B3's merge read
the chunk on disk and reported **25 nodes, 44 edges**; the subagent's own
closing tally said 23 and 40. Step 9's cleanup deletes
`.graphify_chunk_*.json`, so the file that would settle it is gone. The graph
was built from what the merge read, and the difference is recorded instead of
smoothed.

**Result: `graphify-out/graph.json` present**, 85 nodes, 163 edges, 19
communities, stamped `3528bcf`, which is `HEAD`. Post-commit hook installed.

### GitHub Copilot, both surfaces

Two runs came back, and **neither delivers this page's Behaviour**. They are
recorded as they happened (`docs/05-Process.md` §6: what the command produced
wins, and the page is what was wrong).

**`~/Downloads/seedledger-copilot-J`, Copilot in VS Code: Build now answered,
no graph.** `/initialize` at 0.40.0 reached the first branch for real, ran the
keyless attempt, printed `12 arquivos de código, 2 de documentação`, asked the
Graph confirmation and was told **Build now** ("A opção escolhida foi construir
o grafo completo"). It then ran `graphify .`, the bare binary, took the key
error and moved on: "A construção completa falhou porque não há chave de LLM
disponível". `focus-kit doctor .` in that scratch closes on
`! graphify-out/graph.json missing`. On disk, `graphify-out/` holds `cache`
and nothing else.

**`~/Downloads/seedledger-copilot-K`, Copilot CLI: Build now was never
answered.** The run asked the Graph confirmation and got no live response, so
it took a default of its own: "The required cards received no live response,
so I'm using their stated defaults: English, brownfield, **code-only graph**".
It then ran `graphify . --code-only && graphify cluster-only . --no-label`.
There is a `graph.json` in that scratch, and it is the **Code only** answer,
not this one: 60 nodes, 119 edges, 9 communities, `file_type` counts
`{code: 44, rationale: 9, concept: 7}` and **zero nodes from either
document**, `cost.json` absent. It measures nothing this page asks about, and
it is recorded so that its `graph.json` is not read later as a **Build now**
that worked.

**Why no card reached a person there, asked and answered on 2026-09-19:** the
CLI was in autopilot mode by mistake, which answers on the session's behalf.
So this is a setup artifact and **not** a Ported command walking past an
unanswered question, which is what `prompt_preamble` forbids and what the run
would otherwise be evidence of. Nothing about it enters the queue. The scratch
re-runs with the card reaching a person.

### Why the wording failed, and it is not the Host

J read the manual. The transcript shows it twice, and it shows exactly how
much: `sed -n '66,202p' docs/manuals/graphify.md`. That range is
§Ensuring the graph and nothing above it. The **Build now** this delivery
wrote sits at line 121, inside that range, and the paragraph it points at
sits at line 38, inside §The pieces, which runs 29 to 46. **The session never
read the definition.** It read an option that said "following graphify's
skill (§The pieces)" and had no §The pieces in front of it, so "builds the
graph" resolved to the only build it could see, `graphify .`.

That is not a Host's limit. It is the kit's own reading discipline turned
against this page: every command reads a named section alone, by
`grep -n '^#'` and the range between two headings, which is what `/apply`
and `/initialize` are told to do in so many words. §Ensuring the graph is the
section the commands read, so it is the only section whose text reaches a run.
A definition placed anywhere else is unreachable prose, however correct.

The measurement did not catch this because its prompt reached the session
directly, with no section boundary between the instruction and the session.
Putting the same instruction behind a cross-reference is what broke it, and
only the proof run could show that, which is the reason the page demanded two
stops.

### What this falsifies, and what it leaves standing

Falsified: this page's *Where the definition goes*, which says the definition
goes "once, host-neutral, in `manuals/graphify.md`, where the manual
introduces graphify's skill". Where the manual introduces the skill is not
where a command reads. It is left standing in the Contract, unedited, as
§6 requires.

Standing: the measurement. A session under either Copilot surface **can** run
the extraction on its own model, which §The measurement proved three times
over. What J lacked was not the ability. It was the instruction.

### The cause, one step past the symptom

The unread §The pieces is the symptom. The cause is sharper, and it is visible
in the two Copilot runs on the **same surface** that went opposite ways.

`seedledger-copilot-H`, the measurement, **read
`~/.copilot/skills/graphify/SKILL.md` as its very first command**, before it
ran anything. It then hit the same key error J hit, and recovered out of that
file's own text. `seedledger-copilot-J`, the proof, **never opened that file
at all**. It read the manual and ran what the manual put in front of it.

So the first wording failed because it *described what happens* instead of
*telling the session to go read the skill*. The prompt that made the
measurement work was an imperative naming the skill as the thing to follow.
The option was a description with a cross-reference. The second wording copies
the shape that worked.

One claim is withdrawn with it. The first wording said the agent "loads" the
skill at the start of every session. It does not, and no run here shows one
doing it: all three measurement sessions **read** the file on demand, by the
Skill tool, by `sed`, by `view`. "Loaded all the same" was a claim the
evidence does not support, and it is gone.

### The second wording

**Build now** now carries the whole instruction, inside §Ensuring the graph,
which is the only section a command reads:

```
* **Build now.** Read graphify's own skill, the `SKILL.md` in the skills
  directory your agent reads on this machine, and follow it. That skill is
  what builds the graph, and with none of the six keys exported it extracts
  the documents on **this session's own model**, so the refusal the attempt
  above printed is not a stop under this option: it is the state the skill is
  written for. Billed as this session's tokens. When one of the six keys is
  exported, `graphify .` instead, billed to that key's account. Two runs from
  the Cost ledger, for scale: 38 files cost 187,743 input tokens, 62 files
  cost 433,524.
```

It names no Host, no path and no invocation. It keeps everything the Contract
said it keeps. It answers, in the same breath, the refusal the session has
just read, which is the sentence J needed and did not have.

**The definition moved with it, and it is still once.** §The pieces keeps one
line, a pointer and not a second definition: whether `/graphify` can be typed
depends on your agent, and what the skill is is §Ensuring the graph under
**Build now**. The Contract's *Where the definition goes* put it where the
manual introduces the skill; the run showed that place is unreachable, so the
definition sits where it is read. That clause is falsified and left standing.

### A third stop the page did not plan for

This page wrote two stops, the measurement and the proof. It got three:
measurement, a proof that falsified the wording, and a second proof round.
`docs/05-Process.md` §6 makes that the correct response rather than a
deviation, since what the command produced wins and the page is what was
wrong. It is recorded because the next page that copies this one's shape
should budget for it: a wording proven by a run is proven by a run that can
fail.

## The second proof round

Fresh scratches, same corpus at `3528bcf`, kit at **0.40.0** carrying the
second wording. No second `VERSION` bump: both wordings ship in one commit,
and only the second one ever reaches a target.

**`~/Downloads/seedledger-claude-L`, Claude Code, run here.** First branch
reached for real, `found 12 code, 2 docs, 0 papers, 0 images`, no
`graph.json`. **Build now** answered, and the option was acted on as written:
graphify's `SKILL.md` read, then followed. One subagent for the two documents,
18 nodes, 29 edges, 3 hyperedges, whose own closing tally matched the file
this time because it was asked for the counts of what it wrote.

**Result: `graphify-out/graph.json` present**, 78 nodes, 148 edges, 15
communities, stamped `3528bcf`, which is `HEAD`. Hook installed. The cost line
came out true, `graph built: 45,485 input tokens (graphify-out/cost.json)`,
because the subagent's usage was written back before the merge.

This row is recorded for completeness and is **not independent evidence**. The
session that ran it had already read graphify's skill twice today, so it
cannot show what a session meeting the option cold would do. Copilot is where
that is decided, and that is the round still open.

### Copilot, both surfaces: the branch was never reached

Neither run answered **Build now**, and neither failed at the wording. Both
skipped §Ensuring the graph altogether.

**`~/Downloads/seedledger-copilot-L`, VS Code.** `/initialize` wrote its seven
documents and staged them. There is **no `graphify-out/` at all** in that
scratch: no directory, so no keyless attempt was ever run and no Graph
confirmation was ever asked. Its own closing `doctor` says so twice,
`! graphify-out/graph.json missing` and `! graphify post-commit hook not
installed`.

**`~/Downloads/seedledger-copilot-M`, CLI, and not in autopilot this time.**
Same outcome, and the transcript shows the decision being made rather than
missed. At line 2232: "I should inspect `docs/manuals/graphify.md` since step
1 mentions ensuring graphify. However, if there's no knowledge graph, that
might not need to be executed... I wonder if I can skip it completely." It
skipped it completely. `grep -c "Ensuring the graph"` over the whole 2,997
line transcript returns **0**.

**This is not the wording, and it cannot be.** A session that never opens
§Ensuring the graph reads no word this delivery wrote. The manual's prose can
only be tested by a run that reaches the section quoting it.

**It is also not new, and it is not deterministic.** It is the shape
`work/done/graph-builds-without-a-key.md` recorded under §It never read
§Ensuring the graph, never ran the keyless attempt. Of the four `/initialize`
runs under Copilot today, at one kit version, **two reached the branch and two
did not**: J asked the confirmation and was answered, K asked it and autopilot
answered, L and M never asked. The only kit change between them is prose
inside a section `/initialize` does not read in order to decide whether to run
the procedure, so the flakiness is the command's reach and not this page's
text.

**One more thing the person saw in L**, recorded and not chased: the Practice
question came out as plain text while every other question came out as a card.
That is the questions under Copilot in VS Code, which this page's Out of scope
already assigns elsewhere.

### The proof route changes, and the reason

`/initialize` is the longest command the kit has, and under Copilot it reaches
§Ensuring the graph about half the time. Proving one option of one question
should not depend on a run that writes nine files first.

`/propose <slug>` ensures the graph in its **Read first**, second item, before
it writes anything, and it writes one page. Both scratches already hold the
seven documents `/initialize` wrote there, so `/propose` is available in each.
That is the route the next round takes. Item 3 asks for the first branch run
and **Build now** answered; it does not ask for a particular command, and the
shortest command that reaches the branch is the honest choice.

## The fourth round, through `/propose`

The short route works: **both surfaces reached the branch and both were
answered Build now.** What they did next is the finding.

**`~/Downloads/seedledger-copilot-L`, VS Code.** Ran the keyless attempt,
refused with `found 12 code, 13 docs`, asked the Graph confirmation, was told
**Build now**. Then it **did what the second wording says**: the transcript
shows `Read skill graphify, lines 1 to 320` and `lines 320 to 620`. It went on
to check for a Gemini key, found none, and wrote: "I'll use the skill's
host-agent path rather than silently downgrading your approved choice." It
then ran `graphify extract . --code-only`. The run ended by deleting
`graphify-out/` and stopping, correctly, because the slug it was given was not
ordered in the queue, which was an error in the asking and not in the command.

**`~/Downloads/seedledger-copilot-M`, CLI**, on the ordered slug
`add-seasons-table`. Answered `build_now`. Ran `graphify .`, took the key
error, and in the **very next command** ran
`graphify . --code-only && graphify cluster-only . --no-label`. It never
opened graphify's `SKILL.md` at all. On disk: 60 nodes, 119 edges,
`file_type` `{code: 44, rationale: 9, concept: 7}`, **zero nodes from any
document**, `cost.json` absent.

### What the second wording fixed, and what it did not

Fixed: L **read the skill**, which J did not. The imperative reaches at least
one surface, and that is a real gain over the first wording.

Not fixed: **neither surface ran the extraction.** Both delivered the **Code
only** result to a person who had answered **Build now**, and neither said so.
That is worse than J's empty `graphify-out/`: an absent graph is visible, and a
code-only graph handed back under the wrong answer is not. The manual's cost
line would then print `graph built: 0 input tokens` or nothing at all over a
graph that holds no document.

### Why they both reach for `--code-only`, and it is in two places

The downgrade is advertised twice, right where the session is looking.

graphify's own refusal, the line the branch is built on, ends: "A code-only
corpus needs no key. **Or pass `--code-only` to index just the code** (local
AST, no key) and skip the non-code files." And the manual's very next option,
**Code only**, hands over the exact command,
`graphify . --code-only && graphify cluster-only . --no-label`.

So a session that has just been refused reads a suggestion to downgrade, then
reads the same downgrade as an offered option one bullet below the one it was
told to take. M took it in one step. L read the skill first, said out loud it
would not downgrade, and downgraded.

**What no wording so far has done is forbid it.** Both wordings said what to
do; neither said what not to do, and neither answered the refusal's own
suggestion. That is the next thing to try, and it is the third wording, not a
fourth theory.

### The third wording

What the two rounds discriminate on is not what the option says. It is **what
the session runs first**. Every Copilot session that reached a graph on its own
model ran the skill's procedure without touching the binary: the CLI
measurement never ran `graphify .` at all, and the VS Code measurement had read
the `SKILL.md` as its first command of the session. Every session that fell to
`--code-only` had run `graphify .` first: J, M, and L, which is the sharpest
cell because it read the skill **and ran the binary anyway**. Once the binary's
refusal is on screen, `--code-only` is the suggestion in front of the session
and both wordings lost to it.

So the third wording carries a prohibition, which neither of the first two did,
and it names the downgrade so it cannot pass for compliance:

```
* **Build now.** Read graphify's own skill, the `SKILL.md` in the skills
  directory your agent reads on this machine, and follow its procedure. With
  none of the six keys exported, that procedure extracts the documents on
  **this session's own model**, and it never calls `graphify .` to do it. The
  refusal printed above is the CLI refusing, not the skill, so **do not run
  `graphify .` here**, and do not take the `--code-only` the refusal suggests:
  that is the next option, **Code only**, and it hands back a graph with no
  document in it. Billed as this session's tokens. When one of the six keys is
  exported, `graphify .` is the whole build instead, billed to that key's
  account. Two runs from the Cost ledger, for scale: 38 files cost 187,743
  input tokens, 62 files cost 433,524. A session that ends this answer with a
  code-only graph anyway says so in place of the cost line, `graph built from
  code only under Build now; the documents are not in it`, because a person
  who chose this one is owed the difference.
```

The last sentence is there on purpose, and it is what lets this delivery close
either way. Four Copilot sessions have now handed back a code-only graph under
a **Build now** answer without saying so. If the prohibition works, that
sentence never fires. If it does not, the person at least learns which answer
they actually got, and the manual stops claiming a graph it did not deliver,
which is what `docs/05-Process.md` §6 requires of a page that cannot make its
Behaviour true.

It is written **inside the option** and not as a fourth entry in the cost-line
list below it, so the change stays inside the one thing this delivery owns.

## The fifth round, and it closes

The third wording holds. **Both Copilot surfaces reached the branch, answered
Build now, and ended with a graph that holds the documents**, with none of the
six keys exported. The prohibition is what did it: neither session ran
`graphify .` after the answer, which is the command every failing round had run
first.

**`~/Downloads/seedledger-copilot-M`, CLI: a clean run.** Keyless attempt,
then graphify's `SKILL.md` read, then the skill's own Part B: the cache check
wrote `.graphify_uncached.txt`, a `task` subagent was dispatched and returned
`.graphify_chunk_01.json` at 32 KB with **53 nodes and 69 edges**, then the
merges, the build, and `explain` and `affected` on the delivery's node.
`--code-only` appears in **zero** executed commands. Final graph: **113 nodes,
141 edges**, `file_type` `{code: 44, concept: 39, document: 16, rationale: 14}`,
**no node violating graphify's extraction spec**, stamped `3528bcf`, which is
`HEAD`.

**`~/Downloads/seedledger-copilot-L`, VS Code: a graph, by a recipe of its
own.** It obeyed the prohibition on the bare binary and read the skill. It then
ran `graphify extract . --code-only --no-cluster` for the AST half, and instead
of running the skill's Part B it **hand-wrote the semantic layer** into
`graph.json` with a python heredoc: 16 nodes and 20 edges it composed itself
from reading the documents, then `cluster-only`. Final graph: **71 nodes, 139
edges**, 11 document nodes carrying `_origin: semantic`, stamped `3528bcf`,
hook installed.

**Half the prohibition held there, and the record should not round it up.**
The option forbids two things. `graphify .` was not run, on either surface,
and that is the half that moved the result. `--code-only` **was** run on VS
Code, under a **Build now** answer, which the option says not to do. It did not
produce the Code only outcome, because the session added documents afterwards,
but the instruction was not followed.

**And it dispatched no subagent.** Part B of graphify's skill mandates the
Agent tool for the documents; VS Code read them itself and composed the nodes
in one heredoc. That is the mechanism behind the off-spec ids below: a
subagent given the extraction spec is what carries the node-ID rule, and a
session writing the JSON by hand never sees it.

### What each round bought

| Round | Wording | VS Code | CLI |
|---|---|---|---|
| Measurement | direct prompt, no option | graph, skill's Part B | graph, skill's Part B |
| 2, `/initialize` | first: description plus a pointer out of the section | **no graph**, ran `graphify .` and stopped | not a run, autopilot answered |
| 3, `/initialize` | second: imperative to read the skill | branch never reached | branch never reached |
| 4, `/propose` | second | read the skill, then `--code-only` | `graphify .`, then `--code-only` |
| 5, `/propose` | third: the prohibition | graph with documents, hand-authored | graph with documents, by the skill |

The line that moved the result is the one no earlier wording had: **do not run
`graphify .` here**, with the reason, plus naming `--code-only` as the other
option so taking it cannot read as compliance.

### What is true, and what is not claimed

True, and this is the Behaviour: under every Host `kit_hosts` names, a session
that reaches the first branch with no key exported and is told **Build now**
ends with `graphify-out/graph.json` present. Measured on 2026-09-19 on all
three surfaces.

**Not claimed:** that the option was followed to the letter on both. The
prohibition on `graphify .` held on both surfaces; the prohibition on
`--code-only` held on one. What is claimed is the Behaviour, a graph, and both
have one.

**Not claimed either:** that the two surfaces get there the same way. The CLI
ran graphify's procedure; VS Code invented one. Its eleven hand-made nodes carry
ids like `concept:season` and `file:docs/00-Product.md`, which hold colons and
slashes and so violate graphify's own node-ID rule of `[a-z0-9_]` with no dots
or slashes. A later `graphify update` there would not match them and would
accumulate duplicates. That is graphify's spec and graphify's skill, not this
option's wording, and it leaves this page as a finding rather than a fix. The
page's Behaviour asks for a graph, and there is one; it does not ask that every
Host build it by the same route, and this record is where the difference is
written down instead of being smoothed over.

## The state of each environment, on 2026-09-19

| Environment | At | Note |
|---|---|---|
| Kit source | 0.40.0 | `manuals/graphify.md` at the third wording, `docs/03-Domain.md` Global skill widened, `VERSION` bumped once for all three wordings because only the last reaches a target |
| Dogfood copy | 0.40.0 | in sync; `focus-kit install .` run here after each wording, check 6 of the verify command empty |
| Machine | 0.40.0 | the CLI is a symlink and follows the source; graphify 0.9.63, its skill placed and current for both Hosts, both green in `doctor`, and both Hosts' `SKILL.md` identical byte for byte |
| Target repositories | untouched | they move when their owner runs `focus-kit update` |
| First target (`~/Downloads/vaulted`) | gone | still gone; the row leaves with milestone 2, which is still open |
| The nine scratches of this delivery | left where they are | `seedledger-base` at `3528bcf` is the corpus every one was copied from. `seedledger-claude-H`, `-J`, `-L` and `seedledger-copilot-H`, `-I` carry the measurement and the Claude Code proofs; `seedledger-copilot-J`, `-K`, `-L`, `-M` carry the five proof rounds, the failures included. They are kept because this page's rounds are only readable beside them |

`focus-kit selftest`: six checks green. `focus-kit doctor .`: zero warns.

**Publish policy** (`docs/05-Process.md` §5): there is nothing to publish. The
kit has no registry and no deploy. 0.40.0 becomes available when this commit is
pushed, and reaches a target when its owner runs `focus-kit update <path>`.
Nothing was pushed here and nothing was committed.

## One correction made in this session

A shell command of `/apply`'s own created an empty `work/graph-builds-without-a-key.md`,
a `cat >>` with no input left waiting on stdin. `work/` is where an in-flight
delivery lives, so an empty file there would have read as one. It was removed
and the append went to `work/done/graph-builds-without-a-key.md`, which is
where that page has been since it closed.
