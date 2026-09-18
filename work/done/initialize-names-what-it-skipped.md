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

* [x] `bin/focus-kit selftest` green.
* [x] Step 5 of `skills/initialize/SKILL.md` runs the command, prints its output
  whole, keeps it in English, acts on nothing, and no longer asks the run for
  the graph and the hook in prose.
* [x] `manuals/process.md` §3, `docs/00-Product.md` (Initializing) and
  `docs/03-Domain.md` (The kit, What it is not; the Initialize row) updated in
  this delivery.
* [x] `VERSION` bumped: a target receives a changed skill and a changed manual.
* [x] `focus-kit install .` run here, and check 6 of the verify command comes back
  empty.
* [x] **Proof** (`docs/05-Process.md` §6), a real run: `/initialize` in a scratch
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
* [x] The environments are as `docs/05-Process.md` §5 requires.

---

## What happened

**The page held, line for line.** Nothing in the Contract was contradicted by a
document and nothing had to be settled by the run: Step 5 is one edit, the four
documents each took the sentence the page named, and no file outside the Slice
was touched. `bin/focus-kit` is byte for byte what it was.

**What the skill says now.** Step 5 lost `the state of the graph and the hook`
from its prose list and gained three paragraphs: the act (`focus-kit doctor .`
at the root of the target, printed whole and unchanged, not a summary, not the
warns alone, not a count), the note that those lines are a quote of what a tool
printed and so stay in English by the closed list the Language section already
holds, and the two rules the page asked for, that the run adds nothing after a
warn and that a command it cannot run becomes one line and the close goes on.

**One choice inside the Contract, taken and recorded.** The page's Visual
reference draws the close with the labels `Written:` and `Open questions:`.
Those labels did not go into the skill. The Contract asks for an **order**, and
the order is what the prose now gives; the labels are conversation text, which
the Language section keeps in the person's language, and a shape block pasted
into an English skill is the one way that text comes out in English in a
`pt-BR` session. The proof run confirms the cost is nil: the order came out
exactly as drawn, with the run's own labels, in the run's own language.

**What the proof found.** The run is `~/Downloads/lanternfile-initialize-proof`,
greenfield, documentation language `pt-BR`, the Graph confirmation answered
**Not now**. The close came out in this order: the files written, the questions
left open, `doctor`'s block, `/propose toolchain`, then `git add -A` and the
suggested message, with no commit. The block:

```
focus-kit 0.32.0 doctor: /Users/jckodel/Downloads/lanternfile-initialize-proof
  ✓ uv
  ✓ graphify
  ✓ graphify skill for Claude Code
  ✓ graphify skill for GitHub Copilot
  ✓ kit source 0.32.0 (nothing newer on origin)
  ✓ /apply
  ✓ /discuss
  ✓ /initialize
  ✓ /propose
  ✓ .github/prompts/apply.prompt.md
  ✓ .github/prompts/discuss.prompt.md
  ✓ .github/prompts/initialize.prompt.md
  ✓ .github/prompts/propose.prompt.md
  ✓ kit version 0.32.0
  ✓ docs/00-Product.md
  ✓ docs/01-Architecture.md
  ✓ docs/02-Backend.md
  ✓ docs/03-Domain.md
  ✓ docs/04-Conventions.md
  ✓ docs/05-Process.md
  ✓ docs/06-Queue.md
  ✓ CLAUDE.md
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ docs/manuals (pt-BR)
  ✓ .claude/settings.json
  ✓ .gitignore (kit fragment current)
  ✓ .graphifyignore (kit fragment current)
  ✓ kit-owned files as install wrote them
  ✓ project-owned documents (every manual citation by heading, every heading there)
  ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
  ✓ graphify post-commit hook
```

**One warn, and the run printed it and went on.** The one `!` line is
`graphify-out/graph.json missing`, which is the **Not now** of that same run
read back by the CLI, and it is the whole of what this delivery is for. The run
added no line after it, took no step back, and did not build the graph: the
next thing it printed was `/propose toolchain`. Thirty-two green lines and one
warn, in the order `doctor` wrote them, whole, in English, inside a conversation
that was in Portuguese throughout. The block reached the person as the command
printed it, which is the Language section's closed list working: the count of
six conversation texts did not move and `doctor`'s block carries none of the
phrase the six carry.

**What the close looks like is the run's and not the page's.** The Visual
reference draws `Written:` and `Open questions:`; the run printed a table headed
`Arquivos escritos` and a paragraph headed `Perguntas deixadas em aberto`, and
headed the block `focus-kit doctor .` before quoting it. §6 says what the
command produced wins, and nothing in the Contract is about those labels: the
order is, and the order held.

**A defect the proof found and this delivery did not fix.** Round 3 of Step 1
greenfield asks Language and `Test framework, linter, formatter` in the same
round, so the tooling options cannot depend on an answer given in the same card
set. The person answered TypeScript on Node and the tooling card came out
offering `xUnit e dotnet format` and `NUnit e dotnet format`, the house default
of `skills/initialize/SKILL.md` §Step 1 (greenfield) item 3, citing
`docs/manuals/focus.md` §9. The third option, `Você decide depois`, is what the
person took, so the documents came out right and only the asking was wrong,
which is why no file in that scratch records it. It is out of this delivery's
scope by the Out of scope section and by the queue line, which name `/initialize`
Step 5 alone, and no queue line was written here because the queue is
`/discuss`'s to write (`docs/05-Process.md` §2). The kit's own repository is
where it belongs, as `questions-reach-the-persons-language` and this line both
came from an earlier proof run.

**What was dropped.** Nothing the page named. No probe was added to check 2 for
the new act, and none was asked for: `doctor` is unchanged, the new behaviour is
a run of an existing command by a skill, and the verify command does not run
skills (`docs/05-Process.md` §4).

**Environments.**

| Environment | State |
|---|---|
| Kit source | 0.32.0, the delivery's version |
| Dogfood copy | 0.32.0, `focus-kit install .` run here, check 6 green |
| Machine | untouched: the CLI is a symlink and follows the source |
| Proof scratch (`~/Downloads/lanternfile-initialize-proof`) | 0.32.0, initialized, nothing committed there; it is a scratch and not a target of anyone's, and it can be removed |
| First target (`~/Downloads/vaulted`) | not on this machine: the directory does not exist. Nothing to update and nothing written there |
| Target repositories (anyone else's) | untouched; they move when their owner runs `focus-kit update` |
