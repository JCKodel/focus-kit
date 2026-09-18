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
  still `[>]`.
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
