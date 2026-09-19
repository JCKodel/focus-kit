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

* [ ] The measurement made first, before anything is written, and recorded per
  Host: what a session that loads graphify's Global skill did with it, with
  none of the six keys exported.
* [ ] `manuals/graphify.md` says once, host-neutral, what graphify's skill is
  on a Host that loads it and offers no command, and **Build now** names what
  the session does.
* [ ] The first branch of Ensuring the graph run by the person in a scratch
  repository with none of the six keys exported, under every Host `kit_hosts`
  names at the time of the run, both GitHub Copilot surfaces included,
  **Build now** answered in each, and what each produced recorded. `/apply`
  stops there and asks for the transcript of every Host it cannot drive.
* [ ] Where a run ended in a graph, `graphify-out/graph.json` present in that
  scratch; where it did not, the record says what it found and nothing a user
  reads claims it (`docs/05-Process.md` §6).
* [ ] `bin/focus-kit selftest` green, six checks.
* [ ] The Dogfood copy in sync: `focus-kit install .` run here
  (`docs/05-Process.md` §5), and check 6 of the verify command empty.
* [ ] `VERSION` bumped: a target receives a manual whose text changed
  (`CLAUDE.md`, How to work).
* [ ] `docs/03-Domain.md`, Global skill written.
* [ ] `work/graph-builds-without-a-key.md`: this run appended to its record,
  its last "Done when" item ticked, the file moved to `work/done/` and its
  queue line turned `[x]`.
* [ ] The environments of `docs/05-Process.md` §5 in the state that table
  requires.
