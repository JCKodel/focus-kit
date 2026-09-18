# initialize-names-what-it-skipped

**Goal.** A person who has just run `/initialize` reads, in the same screen,
what the kit itself says about the repository, so a step the run did not take
is named while they are still there.

**Behaviour.**

* `/initialize` finishes writing the documents, then runs `focus-kit doctor .`
  and prints what the command printed. The output is the last thing the person
  reads before the next step.
* A run that skipped a step reads it back. The measured case is the proof run
  of `copilot-port` (`work/done/copilot-port.md`, The proof run): the language
  record said `pt-BR`, Step 4 never happened, and the three manuals were still
  the English files the kit ships. `doctor` names all three with `/initialize`
  as the fix, and the run said nothing, because Step 5 lists files written and
  a manual translated in place is no new file.
* The run names and does not act. A warn already carries the command that
  fixes it, and the person decides.
* A review run closes the same way as a first run.
* On a machine where the command cannot be run, the close says so in one line
  and goes on. Nothing stops.

**Contract.**

The delivery is one edit to `skills/initialize/SKILL.md`, Step 5, plus the
documents that own the behaviour.

* Step 5 gains one act: after the report and before the next-step line, the
  run executes `focus-kit doctor .` at the root of the target and prints what
  that command printed, **whole and unchanged**. Not a summary, not the warns
  alone, not a count.
* Those lines are a quote of what a tool printed, which the Language section's
  closed list keeps in English whatever the conversation's language
  (`docs/03-Domain.md`, As written). The note beside the act says that much
  and no more: the lines reach the person as the command printed them.
  `doctor`'s block is not a seventh text of that section and carries none of
  the phrase the six carry, which says the opposite; the count of six does not
  move.
* The run takes no step back because a warn named one. It adds no line of its
  own after a warn: `doctor` already names the fix
  (`docs/04-Conventions.md` §1).
* Step 5's prose list loses `the state of the graph and the hook`. It keeps
  the files written, the questions left open, and the next step. What the
  graph procedure decided, a `Not now` among them, is still said out loud by
  that procedure (`docs/manuals/graphify.md` §Ensuring the graph).
* Order of the close: the files written, the questions left open, `doctor`'s
  output, the `/propose <first-slug-from-the-queue>` line, then `git add -A`
  and the suggested commit message. `/initialize` still does not commit.
* When the command is absent from `PATH` or exits non-zero, the run says one
  line naming what it could not run, and the rest of the close happens.
* `render_prompt`'s substitution list is untouched: `focus-kit doctor .` names
  no host, so the Ported command follows by generation and nothing is authored
  beside it (`docs/03-Domain.md`, Ported command; `ADR-0007`).
* No new term. `docs/03-Domain.md` is amended, not extended: the entity **The
  kit**, What it is not, says today that after `install` nothing in the target
  calls the kit and that `bin/focus-kit` is needed again only to update, and a
  Command now calls the CLI at every `/initialize` close; the **Initialize**
  row gains the clause saying how the command ends.
* `docs/00-Product.md`, Initializing, and `manuals/process.md` §3 each gain
  one sentence saying the command ends by running `focus-kit doctor` and
  printing what it says.

**Slice.** `skills/initialize/SKILL.md`, kit-owned, plus the two copies that
follow it here, `.claude/skills/initialize/SKILL.md` and
`.github/prompts/initialize.prompt.md`, both written by `focus-kit install .`.
`manuals/process.md` is kit-owned and follows the same way; `docs/00` and
`docs/03` are this repository's own documents and project-owned.
`docs/01-Architecture.md` §3 says the structure here is one file and no piece,
so this delivery names none: `bin/focus-kit` is not edited at all.

**States.** The CLI gains no line and prints nothing new. What varies is the
close: `doctor` green throughout, `doctor` carrying warns, and `doctor`
unreachable. The first two are printed as they came; the third is the one line
above.

**Visual reference.** No UI. The close has this shape, `doctor`'s block being
whatever the command printed in that repository on that day:

```
Written: <the files>
Open questions: <each one, and where it is recorded>

focus-kit <v> doctor: <path>
  <every line focus-kit doctor printed, in the order it printed them>

/propose <first-slug-from-the-queue>
```

**Out of scope.**

* `/discuss`, `/propose` and `/apply`. The queue line and the slug name
  `/initialize` alone (`docs/06-Queue.md`).
* Acting on what `doctor` says. The line asks for a step to be **named** by
  the run (`docs/06-Queue.md`), and a command that redoes a step it skipped
  is the instruction it skipped.
* Any change to `doctor` itself. It already names all three manuals and the
  missing graph, which is what the queue line calls the mechanism being there.
* A new `doctor` verb, flag or output mode. Nothing in `bin/focus-kit` moves.

**Done when.**

* `bin/focus-kit selftest` green.
* Step 5 of `skills/initialize/SKILL.md` runs the command, prints its output
  whole, keeps it in English, acts on nothing, and no longer asks the run for
  the graph and the hook in prose.
* `manuals/process.md` §3, `docs/00-Product.md` (Initializing) and
  `docs/03-Domain.md` (The kit, What it is not; the Initialize row) updated in
  this delivery.
* `VERSION` bumped: a target receives a changed skill and a changed manual.
* `focus-kit install .` run here, and check 6 of the verify command comes back
  empty.
* **Proof** (`docs/05-Process.md` §6), a real run: `/initialize` in a scratch
  repository, and the close carries at least one warn, because a close where
  every line is green proves the command ran and not that anything was named.
  The condition that gets one is the scratch's to hold before the run: a
  markdown file at its root, which no fragment excludes, so the corpus has docs
  and `graphify .` refuses, the Graph confirmation is asked, and the answer is
  **Not now**, which leaves `graphify-out/graph.json` absent for `doctor` to
  name (`docs/manuals/graphify.md` §Ensuring the graph).
  `work/done/initialize-names-what-it-skipped.md` quotes the close as it came
  out, says which of `doctor`'s lines were warns, and says whether the run
  printed them and went on rather than acting on them.
* The environments are as `docs/05-Process.md` §5 requires.
