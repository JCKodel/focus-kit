# graph-builds-without-a-key

**Goal.** A session that reaches the first branch of Ensuring the graph
builds the graph with no model key exported, whatever Host it runs under,
because the graphify skill that branch names is on the machine for that Host
and the manual names it in words a session under any Host can act on.

**Behaviour.**

* `focus-kit install` asks graphify's own installer for its skill once per
  Host the kit ships Commands for, and says one line per Host, in the shapes
  it prints for Claude Code today.
* A Host whose skill graphify's installer does not place gets a warn naming
  what would have placed it, and the install goes on.
* Nothing the install does for graphify's skill writes into the target.
* `focus-kit doctor` reports graphify's skill once per Host, green only where
  that Host's skill matches the package, and names the two versions and the
  fix in every other state.
* `docs/manuals/graphify.md` names no Host where it names graphify's skill or
  the way a session invokes it: a person reading it under any Host reads what
  their own session runs.
* The Graph confirmation carries, beside its question, the phrase the six
  texts of `/initialize` carry, so a Host reads the rule where it asks and not
  only in a paragraph above.
* Under the second Host, in a scratch repository with none of the keys
  exported, the first branch of Ensuring the graph ends in a graph.

**Contract.**

*Order.* After `copilot-port`, which is `[x]` and made the second Host exist
(`docs/06-Queue.md`, milestone 5), and ahead of `codex-port`, which is `[>]`
and reads this page for whether it installs that Host's graphify skill.
`copilot-reads-the-project-rules` is `[>]` and independent: it writes a Host
instructions file and touches neither `ensure_graphify` nor the manual.
`/apply` stops and says so when `copilot-port` is not `[x]`.

*The condition the scope turns on.* graphify's own installer names, for a
Host, a location on the machine where it places its skill, at the time of the
run. `/apply` reads what graphify names then, settles for each Host the
invocation, the platform name and the path the stamp sits at, and its record
says what it found. Where graphify names none for a Host, or names only a
route that writes into the target, that Host gets the warn and no install:
the script never touches a project-owned file (`docs/00-Product.md`,
Installing), and a skill the kit cannot place without one is a failure inside
the flow and not a defect (`docs/01-Architecture.md` §6). Whether the skill
graphify places is the one that Host actually loads is what the proof run
answers, never what this page asserts.

*What install does, and what it still does not.* One call to graphify's own
installer per Host, on the same condition as today: absent, older than the
package or unstamped is installed or refreshed, newer is left alone, because
graphify's installer would downgrade it. The kit goes on writing none of
graphify's files itself. The Global skill stays graphify's, in none of the
four ownership categories (`docs/03-Domain.md`, Global skill), it reaches no
Manifest and no Drift pass, and what changes is how many times the kit asks
for it and for which Host.

*Where the Host list lives.* In `bin/focus-kit` and in no other file
(`docs/03-Domain.md`, Host). Today the kit names Claude Code in
`ensure_graphify` and GitHub Copilot in `render_prompt`'s substitution list,
and this page adds one fact per Host, which is what graphify's installer is
asked for that Host. Whether that fact sits beside the substitution entries
or in a list of its own is `/apply`'s, inside the one file; what is fixed is
that a later Host adds it there and nowhere else, which is what `codex-port`
reads this page for, since that delivery makes the substitution list one per
Host.

*The state per Host.* `global_skill_state` is asked about a Host and reads
what graphify stamped beside that Host's skill, returning the five words it
returns today: `missing`, `unknown`, `equal`, `older`, `newer`. Unstamped
stays `unknown` and is refreshed. `ensure_graphify` and `doctor` each print
one line per Host and never a count, the way the Translated manual, the
Fragment gap and the Manual citation passes already print one line per thing
to fix (`docs/03-Domain.md`). Where graphify's installer leaves no stamp
beside a Host's skill, `unknown` is that Host's permanent state, so
`doctor`'s line for it says which question it could not answer and names no
command: a warn naming a fix that can never clear it is a warn that lies
(`docs/04-Conventions.md` §1), and the Upstream version's third line is the
shape a state no command clears already takes (`docs/03-Domain.md`).
Whether any Host is in that state is the run's to read.

*The manual goes host-neutral where it names graphify's skill.* Every line of
`manuals/graphify.md` that names graphify's skill, the way a session invokes
it, or the Host that loads it says instead what any session runs: the row of
§The pieces, the two lines of the §Everyday use block and the sentence under
it, **Build now**, and the cost line and the §When the graph is rebuilt
sentence that send a person to re-extract the docs. The manual is one file
copied to every target as it is (`docs/03-Domain.md`, Manual), so this is
prose and never a substitution: `render_prompt` writes one file per Command
per Host and a manual is not a Command (`docs/03-Domain.md`, Ported command).
**Build now** goes on naming the session's own model as what is billed, and
the exported key as the alternative, which is the CLI invocation and already
names no Host. The two runs it quotes from the Cost ledger are what already
happened, so they stay (`docs/03-Domain.md`, Contract).

*The phrase beside the confirmation.* The Graph confirmation gains, beside
its question, `written here once and said entire, in the conversation's
language`, the mechanism `questions-reach-the-persons-language` chose over a
rule stated once and far from the text it governs. The paragraph of
§Ensuring the graph that states the rule stays where it is: it says what a
mark means and which words stay English, which the phrase does not carry, and
the Language section of `skills/initialize/SKILL.md` keeps its paragraph
beside its six phrases for the same reason.

*`docs/03-Domain.md`.* No new term. Three rows widen: Global skill and Skill
stamp stop being Claude Code's alone, and As written records that the
confirmation carries the phrase.

*`selftest`.* Check 2 asserts one Global skill line per Host, each built by
calling `ok` or `warn` rather than by a literal (`docs/05-Process.md` §4).
The fake `graphify` it puts on PATH answers for every Host it is asked about,
which is `/apply`'s to widen. Check 6 is unchanged in kind: the manual is a
Dogfood copy and `focus-kit install .` is what syncs it.

*No new dependency.* bash 3.2 and the python3 `python_bin` already probes
(`docs/01-Architecture.md` §2, Out by decision).

*No new ADR.* Nothing here is expensive to reverse: the Host list is an
abstraction a house rule already decides, and the Global skill stays outside
the four ownership categories, so `ADR-0002` is untouched.

*What is claimed after the proof.* Where the scratch run under the second
Host ended in a graph with no key exported, the record says so; where it did
not, the record says what it found and nothing a user reads claims that the
graph builds there (`docs/05-Process.md` §6).

**Slice.** `bin/focus-kit`, `manuals/graphify.md` and this repository's own
documents (`docs/01-Architecture.md` §3, Structure, neither slices nor
layers: one file; §4). No View, Orchestrator, Use case or Repository: §3 says
none of the four exists here. The graph named `bin/focus-kit` and nothing
else for `ensure_graphify`, both ways. Kit-owned: `bin/focus-kit`,
`manuals/graphify.md` and its Dogfood copy. Project-owned: `docs/00`,
`docs/01`, `docs/03`, `docs/05`, `docs/06`. Merged: nothing. Appended once:
nothing.

**States.**

* It works for a Host: one `ok` line naming the Host and the version the
  skill came from, in the three shapes `ensure_graphify` already prints.
* Already current for a Host: the `equal` line, unchanged.
* Newer than the package: the existing warn, per Host, naming
  `uv tool upgrade graphifyy`.
* graphify's installer fails for a Host, or names no location the kit may
  write to: the existing warn, per Host, and the install goes on
  (`docs/01-Architecture.md` §6).
* graphify absent from PATH after the package install: the existing `die`,
  unchanged. It is the one state the run cannot continue past.

**Visual reference.** No UI. The dependency block gains one line per Host, in
the shape it prints today minus the invocation only one Host has, the Host
name coming from the Host list and the rest from `global_skill_state`:

```
  ✓ graphify skill for <the host> (refreshed from <v>)
```

`doctor`'s Global skill line takes that same shape, once per Host, and its
non-green shapes name the two versions and the command, as they do now.

**Out of scope.**

* Codex's graphify skill. `codex-port` is `[>]` and adds its Host to the list
  this page makes, the way it adds its substitution entries.
* A graphify prompt among the Ported commands. The kit renders a Ported
  command from a `SKILL.md` under `skills/`, and graphify's skill is not one
  (`docs/03-Domain.md`, Global skill and Ported command).
* `AskUserQuestion` in the manual. It is what `render_prompt` substitutes for
  a Ported command, and `work/codex-port.md` already routes a divergence on it
  to `/discuss`.
* What a Host does after reading an instruction it received word for word.
  That is the product decision `work/done/copilot-port.md` sent to `/discuss`;
  this page changes the text and not the Host.
* Removing graphify's skill from a machine. `Uninstall` touches no dependency
  on the machine (`docs/03-Domain.md`, Uninstall).
* `README.md`. `readme-makes-the-case` is `[ ]` and is where the kit's own
  case is written.

**Done when.**

* [x] `bin/focus-kit selftest` green, six checks.
* [x] Check 2 green with one Global skill line per Host.
* [x] The Dogfood copy in sync: `focus-kit install .` run here
  (`docs/05-Process.md` §5), and check 6 of the verify command empty.
* [x] `VERSION` bumped: a target's machine receives a skill it did not have and
  the manual's text changed. 0.30.1 to 0.31.0.
* [ ] The first branch of Ensuring the graph run by the person under the second
  Host, in a scratch repository, with none of the keys the branch unsets
  exported, and what it produced recorded in
  `work/done/graph-builds-without-a-key.md`, every divergence from this page
  included (`docs/05-Process.md` §6). `/apply` stops there and asks for the
  transcript, because it runs in Claude Code and cannot drive the other Host.
  **Open.** This is why the file is still in `work/` and the queue line is
  still `[>]`. The run was made on 2026-09-18 and did not reach the branch:
  §The proof run under the second Host has what it found, and why the item
  stays where it is.
* [x] `docs/00-Product.md` Installing, `docs/01-Architecture.md` §3 (the
  `ensure_graphify`, `global_skill_state` and `doctor` rows) and
  `docs/03-Domain.md` (Global skill, Skill stamp, As written) written.
* [x] The environments of `docs/05-Process.md` §5 in the state that table
  requires.

---

## The record

### What the condition the scope turns on evaluated to

The page left the scope turning on what graphify's own installer names, at
the time of the run, for each Host. Read off graphify 0.9.63 on 2026-09-18,
from `graphify install --help` and from the installer's own platform table:

| Host | Platform | Skill and Skill stamp | Writes into the target |
|---|---|---|---|
| Claude Code | `claude` | `~/.claude/skills/graphify/` | no |
| GitHub Copilot | `copilot` | `~/.copilot/skills/graphify/` | no |

So both Hosts get the install and neither gets the warn. The Copilot route
that does write into a target is a different command, `graphify vscode
install`, which appends to `.github/copilot-instructions.md`; the kit does
not call it, and the run confirmed nothing landed in this repository.

The stamp is written for every platform the installer places a skill for, so
**no Host is in the permanent `unknown` state** the page provided wording for.
No new wording was added, and `doctor`'s `unknown` line keeps naming
`focus-kit update`, which still clears it.

### What diverged from the page

1. **`/graphify` is not an invocation only one Host has.** The page's Visual
   reference drops it from the `ok` line as "the invocation only one Host
   has". graphify's own `skill-copilot.md` documents `/graphify` exactly as
   `skill.md` does, so both Hosts invoke it by that word. The person chose,
   in one `AskUserQuestion`, to keep `/graphify` in the manual and drop only
   the Host names. The CLI line follows the Visual reference as written,
   `graphify skill for <host>`, because that is what the page pins.
2. **Three of the manual's enumerated lines needed no edit.** The Contract
   lists the two lines of §Everyday use, **Build now**, the cost line and the
   §When the graph is rebuilt sentence. Under the answer above, all five
   already say what any session runs: they name `/graphify` and no Host. They
   are unchanged. What did change is the row of §The pieces, the sentence
   under the §Everyday use block, and §Troubleshooting.
3. **§Troubleshooting was not in the Contract's list and had to change.**
   Behaviour asks that the manual name no Host where it names graphify's
   skill, and its second bullet named `~/.claude/skills/graphify/` and
   `graphify install --platform claude`. Its last bullet sent a person to "a
   Claude Code session" to run `graphify cluster-only .`; that names a Host
   for a model and not for graphify's skill, so it is outside Behaviour's
   words, but a Copilot reader was being told to open another tool, and it is
   now "a session that has one". The manual now names no Host anywhere.
4. **The `missing` line lost a clause.** It read `(installed; it also added a
   graphify section to ~/.claude/CLAUDE.md)`. graphify appends that section
   only where its platform config sets `claude_md`, which is Claude Code
   alone, so the clause would have been false for GitHub Copilot. The person
   chose dropping it over carrying a fourth fact per Host. Both Hosts now
   print `graphify skill for <host> (installed)`.
5. **`README.md` was out of scope and got one clause anyway.** The page
   excludes it because `readme-makes-the-case` is where the kit's case is
   written. Its install paragraph stated this behaviour as a fact, "the global
   `/graphify` skill for Claude Code", and the behaviour changed, so the
   living-docs rule of `CLAUDE.md` reaches it. One clause, no case written.
   Reverse it in one edit if that reading is wrong.
6. **Four more documents were touched than "Done when" names.**
   `docs/01-Architecture.md` §5 (Touch the user's home), `docs/03-Domain.md`
   Host, whose Code column now names `kit_hosts()` and which is the fourth row
   the page said three of, `docs/05-Process.md` §4 check 2 and §5 Machine, and
   the CLI's own header item 1, which `docs/04-Conventions.md` §1 makes a rule.
   Adding `kit_hosts` moved the script, so every `bin/focus-kit:<line>`
   citation in `docs/00`, `docs/01`, `docs/03`, `docs/04` and the two ADRs was
   renumbered. The one left alone is in the queue line of this delivery, which
   records what was measured before it.

### What was dropped

Nothing in the page's scope. Codex stays out: `codex-port` adds its line to
`kit_hosts` the way it adds its substitution entries, which is the fact this
page existed to fix in place.

### Decisions taken

No ADR. Nothing here is expensive to reverse, as the page said: the Host list
is one function with two callers, and the Global skill is still in none of the
four ownership categories, so `ADR-0002` is untouched.

The Host list is a function of its own, `kit_hosts()` at `bin/focus-kit:126`,
and not an extension of `render_prompt`'s substitution list. The two answer
different questions, one per Host and five per Host, and `render_prompt` is a
transform while this is data. It is the **second** concrete occurrence of a
per-Host fact in the script, the first being `render_prompt`'s `host_to`
pair, which is what makes the list an abstraction rather than a guess.

### What the proof found

`bin/focus-kit selftest`, six checks green, twice: before `focus-kit install .`
it stopped at check 6 on the version, which is the rule working, and green
after. `focus-kit doctor .` here prints zero warns.

The dependency block of `focus-kit install .` on this machine, which is the
first real run of the per-Host loop:

```
  ✓ graphify 0.9.63 (to upgrade: uv tool upgrade graphifyy)
  ✓ graphify skill for Claude Code
  ✓ graphify skill for GitHub Copilot (installed)
```

`~/.copilot/skills/graphify/` then held `SKILL.md`, `references/` and
`.graphify_version` reading `0.9.63`, and `git status` showed no
`.github/copilot-instructions.md`: the install wrote nothing into the target.
`doctor` reports both Hosts green on the second run, which is the `equal`
state reached through the real installer and not through check 2's fake home.

Check 2 proves the other four states for both Hosts: four `doctor` runs
against a fake home holding both skill directories, with stamps at `9.9.10`,
`9.9.8`, none and `9.9.9`, asserting two lines per run. The host names are
written out in the check, the way the four command names are.

**Still open: the run under the second Host.** `/apply` runs in Claude Code
and cannot drive GitHub Copilot, so the last "Done when" item is the person's.
What it asks for is a scratch repository with the kit installed at 0.31.0, none
of `GEMINI_API_KEY`, `GOOGLE_API_KEY`, `MOONSHOT_API_KEY`, `ANTHROPIC_API_KEY`,
`OPENAI_API_KEY` or `DEEPSEEK_API_KEY` exported, and a GitHub Copilot session
taken to the first branch of Ensuring the graph. What the transcript answers is
the one thing this page never asserts: whether the skill graphify placed at
`~/.copilot/skills/graphify/` is the one that Host actually loads, and whether
`/graphify` reaches it there. Nothing a user reads claims the graph builds
there until it has.

### The state of each environment

| Environment | At | Note |
|---|---|---|
| Kit source | 0.31.0 | `bin/focus-kit`, `manuals/graphify.md`, `VERSION` |
| Dogfood copy | 0.31.0 | `focus-kit install .` run here; check 6 green |
| Machine | 0.31.0 | the CLI is a symlink and follows the source; graphify 0.9.63, and its skill now placed for both Hosts |
| Target repositories | untouched | they move when their owner runs `focus-kit update` |
| First target (`~/Downloads/vaulted`) | gone | the directory does not exist on this machine, so the row has nothing to update. `docs/05-Process.md` §5 still carries it, and it leaves with milestone 2 |
| `copilot-port`'s scratch (`~/Downloads/quiltline-copilot-proof`) | 0.30.1 | not a row of §5, and where the open proof run happens: `focus-kit update ~/Downloads/quiltline-copilot-proof` brings it to 0.31.0 |

---

## The proof run under the second Host

Made on 2026-09-18, in the session that reopened this page. It is the run the
last "Done when" item asks for, and **it did not reach the branch**. The item
stays unticked, the file stays in `work/` and the queue line stays `[>]`.

### Two things the run happened under that the page does not say

1. **The scratch is `~/Downloads/seedledger-copilot-proof`, not the
   `quiltline` one this page names.** That directory is gone from this
   machine, so the run needed a new one: a fictional brownfield seed library
   in Flask and SQLite, organized by layer, rules inside the handlers, three
   exceptions raised there and caught in the web layer, two test files,
   `README.md` and `notes/design.md` as prose so the first branch is
   reachable. Committed at `e010bdf`, clean tree.
2. **The kit ran at 0.34.0, not the 0.31.0 this page names.** Three
   deliveries landed between the build and the run, in two commits:
   `initialize-names-what-it-skipped` and `tools-follow-the-stack` share
   `8513b21`, and `proof-is-asked-without-a-screen` is `e52418f`. Nothing in
   the run touched what this page changed, so the drift is recorded and not
   repaired. Two of the three changed `/initialize`, which is what
   §What the run leaves for the next delivery turns on.

### What was verified before the session opened

* None of the six keys the branch unsets exported.
* `graphify --version` and `~/.copilot/skills/graphify/.graphify_version`
  both `0.9.63`.
* `.github/prompts/` holds the four kit commands and no graphify prompt, so
  `/graphify` can only come from the Host's own skill directory. That is what
  makes the run a reading of this delivery and not of a prompt file.
* The first branch is reachable: the keyless attempt refuses with `error: no
  LLM API key found (5 doc/paper/image file(s) need semantic extraction)` and
  prints `found 15 code, 5 docs, 0 papers, 0 images`. `graphify-out/` was
  removed afterwards, so the session started with no graph.

### What the run did

GitHub Copilot in VS Code, the surface `copilot-port`'s proof used
(`work/done/copilot-port.md:317`), `/initialize` in that scratch. It read the
repository the way item 6 of the brownfield reading asks, ran `grep -n '^#'
docs/manuals/graphify.md`, and went straight to writing the seven documents.
**It never read §Ensuring the graph, never ran the keyless attempt, never
asked the Graph confirmation and never typed `/graphify`.** Checked in the
scratch afterwards and not in the transcript: `graphify-out/` does not exist
and `.git/hooks/post-commit` does not exist.

The step reached it word for word. `.github/prompts/initialize.prompt.md:203`
carries `Then ensure the knowledge graph, following docs/manuals/graphify.md
§Ensuring the graph to the letter`, which is `skills/initialize/SKILL.md:202`
rendered. The text the kit owns arrived.

**And the Host was reading it.** It ran Step 5's `focus-kit doctor .` and
printed what the command printed, whole, which is a paragraph
`initialize-names-what-it-skipped` added in `8513b21`, inside this range. So
this is not a Host that ignored the prompt.

**What it did and did not do has a shape.** Every step that reads or writes
files was carried out: Step 1's seven readings, Step 2's documents, Step 3's
`CLAUDE.md`, Step 5's report and its `doctor`. Every step that asks the
person or runs graphify was skipped: Step 0's card, the four Practice
questions, the Proof tool question, the Git strategy question, and the whole
of Ensuring the graph. The split is not old against new in the file. It is
the steps that act on files against the steps that stop and wait.

**It also could not hold the templates.** The transcript shows about ten
attempts to read the eight files under
`.claude/skills/initialize/templates/`, with `sed -n '1,220p'`, then `nl
-ba`, then a python loop, before it gave up and wrote from what it had. What
came out does not follow them: `docs/06-Queue.md` in a shape the template
does not have, and a `work/seedledger-initialization.md` that `/initialize`
never writes.

### What that answers, and what it does not

The question the item exists to answer, whether the skill graphify placed at
`~/.copilot/skills/graphify/` is the one that Host loads and whether
`/graphify` reaches it there, is **unanswered**. It was not answered no: the
run stopped before it asked. Nothing a user reads claims the graph builds
there, which is where this page already stood.

Why it stopped is this page's own **Out of scope**: "What a Host does after
reading an instruction it received word for word", which
`work/done/copilot-port.md` sent to `/discuss`. So the run found no defect in
what this delivery built, and found that the open item cannot be closed
through `/initialize` until that other question is.

### Three more things the run found, none of them this page's

Recorded because a proof run's findings are recorded, and left for the queue
because `/apply` does not widen its scope.

1. **It asked nothing at all.** The person reported that no question was
   made, and the transcript agrees: no Language question, no four Practice
   questions, no Proof tool question, and no Graph confirmation. It guessed
   instead, and `docs/05-Process.md` §0 came out `English.` That is the same
   Host-fidelity question as the graph step, one step larger.
2. **It wrote into the target beyond the seven documents.** `pytest.ini` and
   a `.venv`, a `pip install`, a rewritten `.claude/settings.json`, a
   `work/seedledger-initialization.md` that `/initialize` does not write, and
   a `docs/06-Queue.md` in a shape the template does not have.
3. **`doctor` cannot tell a guessed document from an answered one.**
   `focus-kit doctor ~/Downloads/seedledger-copilot-proof` reproduced what
   the run reported: two warns, `graphify-out/graph.json missing` and
   `graphify post-commit hook not installed`, and every other line green, the
   seven documents and `.claude/settings.json` included. The Manual citation
   pass reads headings, and seven guessed documents have the right headings.

### What the run leaves for the next delivery

The person read this record and said the last deliveries broke `/initialize`.
They did not. Five runs across two Hosts, three surfaces and three kit
versions say so, and the one that settles it is the kit pinned to **0.30.1**
failing in VS Code today at the exact pair that worked when it was measured.
What was checked is kept below in the order it was checked, so the next
delivery starts from the measurements and not from one transcript.

**The question machinery is intact.** The six texts and their phrase are in
`skills/initialize/SKILL.md`, and the rendered Copilot prompt carries all six
`multiple choice question` substitutions, which is what `render_prompt` makes
of `AskUserQuestion`. The diff of the two commits removes no question: it
adds the No screen question, splits round 5 into two cards, and adds Step 5's
`doctor` reading. Nothing was taken away.

**But the same Host asked the same questions three versions ago.**
`work/done/questions-reach-the-persons-language.md` records a run of
`/initialize` under GitHub Copilot in VS Code, the same surface, at kit
**0.30.1**: the Language question came out as a card, merged with the Kind of
project question the way the file asks, and the run went on to the
two-patterns disclaimer and the Git strategy question. This run, at 0.34.0,
produced no card at all. Same command, same Host, same surface, and the
regression window is **0.30.1 to 0.34.0**, which is four deliveries and not
the twelve the line below measures.

**Size is the obvious theory and two measurements are against it.**
`skills/initialize/SKILL.md` was **573 lines at 0.30.1**, the run that
produced cards, and is **629 at 0.34.0**, the run that produced none. Fifty
six lines, ten per cent. And the Claude Code run below executes all 629 of
them. The file did grow from 420 over twelve deliveries, which is worth
watching, but it is not what happened here.

**The run that separates the two readings happened, and the file is
cleared.** `/initialize` under Claude Code, in
`~/Downloads/seedledger-claude-proof`, this run's scratch cloned at `e010bdf`
before `/initialize` touched it, same 15 code files and 5 docs, kit 0.34.0,
the same skill text the Copilot run saw. It carried out the whole file:

* Step 0's card, both questions in one `AskUserQuestion`, the count line said
  before it.
* Ensuring the graph, first branch. The keyless attempt refused with the
  count line this page already quotes, the Graph confirmation was asked with
  its three options, the answer was Build now, and `/graphify .` ran in the
  session. Verified on disk and not in the transcript: `graphify-out/` holds
  `graph.json`, `GRAPH_REPORT.md`, `graph.html` and `cost.json`, the stamp is
  `3d055ff` which is that repository's `HEAD`, `.git/hooks/post-commit`
  exists, and the last entry of `runs` reads 46,188 input tokens over 20
  files.
* The two-patterns disclaimer, then the four Practice questions, each
  quoting the code with its file and line.
* The Proof tool question, correctly and not the No screen question, because
  there are Jinja templates.
* The Git strategy question, and a fourth card on the shape of the first
  milestone.
* Step 2's documents, the read-back over them, Step 4's line on the manuals,
  and Step 5's `doctor` printed whole.

So the three edits in `8513b21` and `e52418f` did not break the command, and
neither did its size. At 629 lines it is executed end to end by the Host it
is written for. **The finding is the Copilot port's, not the file's**, and
the hypothesis this section carried about Step 5's three sentences is
withdrawn: the run that has them asked every question.

What is left standing is the contrast, and it is now controlled. Same corpus,
same kit version, same command, two Hosts: Claude Code skipped nothing,
GitHub Copilot in VS Code skipped every step that stops and waits. That is
one A/B, and the 0.30.1 run says that Host did produce cards once, so
something in that port or in that Host changed between them. Which of the two
is not measurable from here.

### A third run, and it settles this page's own question

`~/Downloads/seedledger-copilot-A`: the same corpus again, with the kit at
**0.30.1**, the version whose Copilot run produced cards, run under **GitHub
Copilot CLI** and not VS Code. It was built to isolate the kit version and
came out on a third surface, so it says nothing about the questions across
versions. It says something better for this page.

**It asked.** Three cards, correct in content: Step 0 with Kind of project
and the Language question together, the four Practice questions in one card
each quoting the code, and the Proof tool and Git strategy questions in a
third. The answer was `Portuguese (Brazil)` and the documents came out in
Portuguese. Four of the five texts that existed at 0.30.1 reached the person;
the two-patterns disclaimer did not, and the only `two patterns` in the
transcript is the prompt being read.

**And it skipped the graph, exactly as the other one did.** The transcript
holds the whole of `docs/manuals/graphify.md` §Ensuring the graph as a file it
read, and nothing follows from it: no keyless attempt, no Graph confirmation,
no `/graphify`. Verified on disk: no `graphify-out/` and no
`.git/hooks/post-commit`. The closing report does not mention a graph.

So Ensuring the graph is skipped by GitHub Copilot across kit versions and
surfaces. It is not a regression of the last deliveries and not a property of
one surface. Under that Host, on this evidence, the branch this page needs
does not run, and that is why the last "Done when" item has no route through
`/initialize` there. It also separates the two failures cleanly: the
questions can work while the graph step does not, so whatever the queue line
proposes about Copilot has two things to fix and not one.

### The grid as it stands

`~/Downloads/seedledger-copilot-B`, the kit at 0.34.1, was run under Copilot
in VS Code rather than the CLI, so it does not isolate the version. It
reproduces instead, which is worth having: verified on disk, the documents
came out in English with `.claude/skills/.focus-kit-language` reading `en`,
and there is no `graphify-out/` and no `.git/hooks/post-commit`. The same
signature as the 0.34.0 run, one patch version later.

| Host and surface | Kit | Asked | Graph |
|---|---|---|---|
| Claude Code | 0.34.0 | every text | built, hook installed |
| Copilot, VS Code | 0.34.0 | nothing | no |
| Copilot, VS Code | 0.34.1 | nothing | no |
| Copilot, VS Code | **0.30.1** | **nothing** | no |
| Copilot, CLI | 0.30.1 | four of the five texts | no |

**The fourth row is the one that settles it, and it clears the kit.** 0.30.1
in VS Code is the exact pair that `work/done/questions-reach-the-persons-
language.md` records as producing cards, and today, on the same corpus, with
`.github/prompts/` byte for byte identical to A's, it asked nothing at all
and guessed English. The kit's text did not move; what the Host does with it
did. Nothing in `8513b21` or `e52418f` caused this, and nothing in the
twelve deliveries before them did either.

Read down the surfaces instead and the split is clean. **Copilot CLI honours
the substituted instruction and Copilot in VS Code no longer does**, at the
same version, on the same day, on the same machine. That is one surface, not
a port, and the queue line is about that.

One more thing repeats across exactly the rows that failed. Both VS Code runs
spent about ten to twelve attempts trying to read the eight files under
`.claude/skills/initialize/templates/`, cycling through `sed`, `nl`, `grep`
and a python loop, before writing from memory. The CLI run did not, and
neither did Claude Code. Whatever stops the questions may be the same thing
that stops those reads.

Every Copilot cell is empty in the graph column, in all four rows, which is
this page's own finding and needed none of this to stand.

### The attempt at a workaround, and what it is waiting on

The person asked for one, knowing the kit is cleared. It is in
`render_prompt` and not in the skill, because `render_prompt` is the Host
adapter and Claude Code has nothing to fix: `git diff -- skills/` is empty
and the Claude skill is untouched.

The reading it acts on is that the substitutions say what a question is
**called** on a Host and never that a question **stops** the command. Under
Claude Code nothing has to say it: `AskUserQuestion` is a tool and a tool
call waits. A Host without one reads the same sentence as a description of
something to produce and goes on writing. So the renderer now emits, right
after the frontmatter and before any step of the command, one paragraph
saying the missing half: every question is a stop, nothing is written before
it is answered, options in plain text where the Host cannot show them, and a
run that decided alone has failed. It reaches all four commands and every
Host the kit renders for.

**It was run, and it holds.** `~/Downloads/seedledger-copilot-D`, the same
corpus as A, B and C byte for byte, kit **0.35.0**, Copilot in VS Code. The
run asked the two Step 0 questions and wrote nothing: verified on disk, the
tree is clean, there are no documents, no `graphify-out/` and no hook. The
three VS Code runs before it wrote nine documents each without asking. The
Language question came out entire, with its three statements and the
invitation to type a third language.

It asked in plain text and put both questions in one message, which is what
the paragraph allows where a Host cannot show options, so that is the
mechanism working and not a divergence. Its own count line read `112 source
files` for a corpus of sixteen, but the counting was done by a script the
Host wrote, not by the kit, and the brownfield verdict was right anyway.

| Host and surface | Kit | Asked | Wrote before asking | Graph |
|---|---|---|---|---|
| Copilot, VS Code | 0.30.1 | nothing | nine documents | no |
| Copilot, VS Code | 0.34.0 | nothing | nine documents | no |
| Copilot, VS Code | 0.34.1 | nothing | nine documents | no |
| Copilot, VS Code | **0.35.0** | **both Step 0 questions** | **nothing** | not reached |

**And a second stop appeared at the answer.** Given the two answers, the run
echoed them, said it would continue, and ended its turn without doing
anything. The graph step was never reached, so this run says nothing about
the finding above.

The gap was in the paragraph and it was plain: it says when to stop and never
says to come back. So the renderer gained a second half at **0.36.0**, saying
that the stop ends when the answer arrives, that the run goes on at once in
the same reply from the step that asked, that echoing an answer or announcing
what comes next finishes nothing, and that the turn ends at the closing
report and nowhere else, not at a question, not at an answer, not between two
steps. It also says to ask each question where the file asks it, rather than
gathering later steps' questions into an earlier one, which is what this run
half did.

`~/Downloads/seedledger-copilot-E` was where that got measured, and it found
a third thing before the resume could be tested at all. The run read the
repository properly this time, §Ensuring the graph included, wrote nothing,
and asked the Step 0 card. But it wrote the options as bare bold bullets with
no label on them, so there was nothing to answer with: D had numbered them
`A.` and `B.` on its own and E did not. The paragraph tells the Host to write
the options as plain text where it cannot show a card and never says how the
person answers, so the Host improvises the convention and sometimes
improvises it away.

**0.37.0 makes the fallback answerable**: where the Host cannot show options,
the question is written as text, its options are numbered from 1 in the
file's order, and one line says that the person replies with the number, one
per question, or types the answer where the file offers that. An option
nobody can point at is not an option.

`~/Downloads/seedledger-copilot-F` carries that, on the same corpus as A to
E. What is still unmeasured, across all of them, is the resume: no run has
yet been answered and watched to the closing report, because D stopped at the
answer and E could not be answered. The graph step sits inside that stretch,
so it is also still unmeasured since the finding above.

### Both halves hold, and the branch this page needs ran

E was answered in words and **went on by itself**: it finished the reading,
ran the keyless attempt, took the refusal and asked the Graph confirmation
with its three options. The resume needed no further instruction. F, at
0.37.0, asked the Step 0 questions with its options numbered and the line
`Responda com um número por pergunta, por exemplo: 1, 1`; given `1, 2` it
went on the same way, and it asked in Portuguese, which is what option 2
answered.

**And F reached the first branch of Ensuring the graph.** It ran

    env -u GEMINI_API_KEY -u GOOGLE_API_KEY -u MOONSHOT_API_KEY \
        -u ANTHROPIC_API_KEY -u OPENAI_API_KEY -u DEEPSEEK_API_KEY graphify .

took `error: no LLM API key found (5 doc/paper/image file(s) need semantic
extraction)`, and asked the Graph confirmation, in the conversation's
language, with the three options numbered and in order. Verified on disk:
both E and F have written nothing, `graphify-out/` holds only the `cache` the
attempt leaves, and there is no `graph.json` and no hook. Both sit at the
question.

That is the step four earlier Copilot runs did not take, at two kit versions
and two surfaces, and it is the step the last "Done when" item of this page
turns on. What it took was not a different Host and not a shorter file: it
was the renderer saying that a question stops the command, that the stop ends
when the answer arrives, and how a person answers where the Host shows no
card.

### The question was answered, and the answer is no

`Construir agora` was chosen in F, and `Build now` in G, which ran under the
Copilot CLI at 0.37.0. Both then ran

    graphify .

took `error: no LLM API key found`, said the graph would not be built, and
went on. Verified on disk: neither has a `graph.json`, both `graphify-out/`
hold only the `cache` the attempt leaves, and neither has a hook.

What **Build now** names is `/graphify .`, the skill, billed to the session,
and `graphify .` only where one of the six keys is exported. None was. So
both Hosts read the option, chose it, and then ran the one command in it that
cannot work, because **the other one does not exist there**. `.github/
prompts/` holds the kit's four Commands and nothing else, and the skill
graphify places at `~/.copilot/skills/graphify/` is readable, E's transcript
shows `Read skill graphify` against it, and is not invocable as a command.

**So this page's own divergence 1 is what the run falsifies.** That entry
records the decision to keep `/graphify` in the manual, on the ground that
graphify's `skill-copilot.md` documents it exactly as `skill.md` does, so
both Hosts invoke it by that word. They do not. Documenting an invocation is
not offering one. The rule is `docs/05-Process.md` §6: what the command
produced wins, and the page was wrong.

The delivery's Behaviour asks that under the second Host the first branch end
in a graph. It does not. **The last "Done when" item stays unticked, the file
stays in `work/` and the queue line stays `[>]`**, and nothing a user reads
claims the graph builds there.

What changed is that the line is now actionable and small. The step is no
longer skipped: both surfaces run the keyless attempt, ask the confirmation
and act on the answer. What is missing is one fact in
`manuals/graphify.md`: **Build now** names a single invocation and assumes
every Host offers it, and it has to say what a Host does when it has the
skill to read and no command to type. That is a manual change, which is a
delivery and not a patch in this session.

### Where the card still works, and the risk the paragraph carries

Asked whether the question mechanism still works elsewhere, the session's own
runs answer for two surfaces.

**Claude Code: whole.** `~/Downloads/seedledger-claude-proof` at 0.34.0 had
six card interactions: Step 0, the Graph confirmation, the four Practices,
the Proof tool question, the Git strategy question and the milestone shape.
Nothing done here touches it: the paragraph is emitted by `render_prompt`
into the Copilot prompts and is in no `SKILL.md`, and `git diff -- skills/`
is one line, the stray `A`.

**Copilot CLI: whole, with its own mechanism.** Repo A at 0.30.1 made three
`ask_user` calls carrying `requestedSchema`, `enum` and `default`, and the
answers came back as `User responded: project_type=..., documentation_
language=...`. A real structured card, not text.

**And the paragraph cost that CLI nothing.** G, the same corpus at 0.37.0
under the Copilot CLI, asked with its own widget: `Copilot needs
information`, the two Step 0 questions as tabs, the options selected with the
arrow keys, `Other (type your answer)` as the last one, and the Graph
confirmation the same way with `Build now`, `Code only` and `Not now`. The
fallback is written for a Host with no way to show options and the CLI has
one, so it kept the card and ignored the text route, which is what the
paragraph asks for.

### The cards came back, where the Host has a widget

The person asked for real cards. F, in VS Code at 0.37.0, drew one: the four
Practice questions as the Host's own question widget, paginated `1/4`, each
option carrying its description and its cost, with a custom answer field. So
that surface has not lost the widget after all; what it had lost was the
stop, and once the run stops at a question it asks with whatever it has.
Step 0 in the same run came out as numbered text and the Practices as a card,
which is the Host's choice and not the file's.

That is the right outcome for a rule that binds content and not bytes: where
the Host has a widget the person gets a widget, and where it does not the
person gets a question with numbered options and one line saying how to
answer. Both carry the same statements in the same order.

**One defect was found and fixed in this session**, and it is not the cause
of anything above. `skills/initialize/SKILL.md:99` ended in a stray `A`,
followed by a line opening `A section that...`. The history says what it was:
before `52a2b27` the sentence read `instead of rewriting. A
docs/05-Process.md §6 that names no tool gets the Proof tool question`, and
that delivery replaced the lines after the article and left the article. The
`A` is gone, `VERSION` is 0.34.1 and `focus-kit install .` ran here. It is a
broken sentence in a file every target receives, and removing it will not
make a Host ask a question it skipped.

### The line the queue is missing

`/apply` names them and does not write them: the queue is `/discuss`'s
(`CLAUDE.md`, Non-negotiables). The grid says there are **two** lines and not
one, and that neither is about the instruction file.

**The graph step, which is this page's.** Four Copilot runs, two versions,
two surfaces, and not one of them ran Ensuring the graph. Two of those runs
read the section and did nothing with it. Whatever the answer is, it is not a
wording change: the text reaches the Host intact and is not acted on. Until
this line has an answer, the last item of this page has no route to being
ticked, because the route it names runs through `/initialize` on that Host.

**The questions under Copilot in VS Code**, which is not this page's and is
now measured. The same kit version asks on the CLI and does not ask in VS
Code, and 0.30.1 in VS Code no longer does what it did when
`questions-reach-the-persons-language` measured it. That line is about one
surface, it carries a reproduction at three kit versions, and it should say
that shortening `skills/initialize/SKILL.md` is not the fix, so that nobody
spends a delivery on it.

### The state of each environment, on 2026-09-18

| Environment | At | Note |
|---|---|---|
| Kit source | 0.37.0 | the stray `A` of `skills/initialize/SKILL.md:99` removed, and `render_prompt` gained the preamble; `VERSION` bumped with them |
| Dogfood copy | 0.37.0 | `focus-kit install .` run here after both; check 6 green |
| Machine | 0.37.0 | the CLI is a symlink and follows the source; graphify 0.9.63, its skill placed and current for both Hosts |
| Target repositories | untouched | they move when their owner runs `focus-kit update` |
| First target (`~/Downloads/vaulted`) | gone | still gone; the row leaves with milestone 2 |
| `~/Downloads/quiltline-copilot-proof` | gone | the row above records it at 0.30.1; the directory no longer exists |
| `~/Downloads/seedledger-copilot-proof` | 0.34.0 | this run's scratch, left where it is with what `/initialize` wrote in it, so the finding can be read again |
| `~/Downloads/seedledger-claude-proof` | 0.34.0 | deliberately not 0.34.1: it ran the same skill text the Copilot run saw, which is what makes the A/B one. Its `doctor` says `kit version 0.34.0 installed, 0.34.1 available`, and that is correct and left alone. `/initialize` ran there, its output is staged and uncommitted, and the directory stays as the control |
| `~/Downloads/seedledger-copilot-A` | 0.30.1 | the same corpus with the kit pinned to the version that produced cards. `/initialize` ran there under GitHub Copilot CLI; its documents and its session transcript are uncommitted and stay as the evidence |
| `~/Downloads/seedledger-copilot-B` | 0.34.1 | run under Copilot in VS Code rather than the CLI, so it reproduces the failure instead of isolating the version. Its output is uncommitted and stays |
| `~/Downloads/seedledger-copilot-C` | 0.30.1 | the cell that settled it: Copilot in VS Code at the version that once produced cards, asking nothing today. Its output is uncommitted and stays |
| `~/Downloads/seedledger-copilot-D` | 0.35.0 | the run that proved the paragraph stops a write and starts a question, and that found the second stop. Its tree is clean because it wrote nothing, which is the finding |
| `~/Downloads/seedledger-copilot-E` | 0.36.0 | answered in words, it resumed by itself and reached the Graph confirmation. Nothing written; waiting at that question |
| `~/Downloads/seedledger-copilot-F` | 0.37.0 | the run that answered this page: numbered text at Step 0, a real card for the four Practices, the keyless attempt, the Graph confirmation, `Construir agora`, and then `graphify .` instead of `/graphify .`. No `graph.json`, no hook |
| `~/Downloads/seedledger-copilot-G` | 0.37.0 | the Copilot CLI at the same version: native widget kept at every question, and the same `graphify .` for `Build now`. No `graph.json`, no hook; its transcript is in the directory |
