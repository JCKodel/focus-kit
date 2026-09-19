# pointer-file-is-written-where-the-rule-stands

**Goal.** A person who runs `/initialize` in a target, under whatever Host,
ends that run with the Host instructions file already written, because the
rule that asks for it names a file instead of asking the session to
enumerate a directory and subtract.

**Behaviour.**

* Under every Host `kit_hosts` names, `/initialize` writes each Host
  instructions file the Template tree holds, at the step that asks for it and
  before Step 5 runs `focus-kit doctor .`.
* In a target whose Documentation language is not English, that file comes
  out in that language, at the path its Template mirrors, pointing at
  `CLAUDE.md` and carrying no rule of its own.
* The `doctor` output Step 5 prints carries no `missing` line for it, so
  nothing after the write is what put the file there.
* No Host is named in the text that asks for it, and a third Host stays a
  file under `templates/` and no edit to a Command.
* A person under Claude Code, where the file is one of the same tree's, reads
  a step that works there too.

**Contract.**

*Order.* `codex-port` is `[>]` and adds a third Host, so whichever of the two
runs second inherits the other: `/apply` reads `kit_hosts` at the time of the
run for which Hosts it measures and proves under, and never a count written
here. `tooling-card-follows-the-answer-on-every-host` stands after this line in
the queue and is being defined beside it; it is the second divergence of the
same proof run, it is its own delivery, and it is not this one's to answer.

*The condition the scope turns on.* Whether the step can fire under each Host
at all once it names the file rather than describing what a table does not
account for. **`/apply` measures the text as it stands first, before it
writes anything**: a run of `/initialize` per Host and per surface, in a
Scratch repository, each one in a non-English Documentation language, reading
what that session did at that step today. Three outcomes per Host, which is
what sorts each Host into the work the edit then has to do, and the page
carries all three rather than a guess at which one the runs find:

* **the step is reached and the file is written there**: the wording that
  made it fire is what ships, and the record carries the transcript;
* **the step is reached and the file is not written**: the shape of the rule
  is the cause, and `/apply` rewords and runs again until a transcript shows
  it firing;
* **the step is not reached at all**: no wording fixes it, the record says so
  for that Host and that surface, and nothing a user reads claims the file
  arrives there (`docs/05-Process.md` §6).

The third is not hypothetical. `initialize-skips-ensuring-the-graph`, an
entry under Found, not discussed, records `/initialize` under GitHub Copilot
opening a late section of its own text about half the time while `/propose`
opened it every time.

The wording itself is `/apply`'s, out of what the runs showed, and never this
page's.

*Who makes the measurement.* Under a Host `/apply` cannot drive, it is a run
the person makes: a Scratch repository, that Host, a non-English
Documentation language, and the transcript handed back. `/apply` names what
to ask for, stops, and writes nothing until the transcript is in front of it.
Reading the skill and reasoning about what a Host there would do is not the
measurement (`docs/05-Process.md` §6). The Host `/apply` is running under is
the one it measures itself. So the delivery has two stops, the measurement
before the edit and the proof run after it, and each stop covers both GitHub
Copilot surfaces, VS Code and the CLI, because they have already differed
from each other on this command.

*What the fix may not do.* It may not name a Host, it may not hold the file's
path, and it may not become an entry in `render_prompt`'s substitution list.
The file is written in every target whatever the session's Host
(`docs/03-Domain.md`, Host instructions), and what every target has whatever
its Host is is not what that list holds (`docs/03-Domain.md`, Ported
command). A path per Host in a Command's text would also make a third Host an
edit to that text, where today it is a file under `templates/` and nothing
else (`docs/03-Domain.md`, Template). What the rule may gain instead is an
action the session takes rather than a description it reads.

*Where the fix goes.* `skills/initialize/SKILL.md`, in the step that already
owns the file. Step 2's table is not widened to name it, for the reason
above. Which lines change inside that step, and in what words, is `/apply`'s.

*The rendered copy.* The new text reaches every other Host through
`render_prompt` and nothing else: a diff of the generated prompt against the
`SKILL.md` it came from is what that transform substitutes and adds
(`docs/03-Domain.md`, Ported command) and no line beyond it. That is the
comparison `questions-reach-the-persons-language` already used on this same
file.

*The file's language.* No rule changes: the step already says to fill and
translate it the way the nine documents are filled, and
`docs/03-Domain.md`, Language of the interface excepts only a Manual from the
CLI's English, not what a Command writes into a target. What the delivery
adds is a run that proves it, the second symptom having followed from the
first and neither having been proven closed.

*`docs/00-Product.md` Positioning and the CLI's three Host lines.*
`bin/focus-kit:27`, `:605` and `:608` and `docs/00-Product.md` Positioning
stop naming Claude Code as the one Host, on a condition the run evaluates:
every Host `kit_hosts` names ends its proof run with the file written at the
step that asks for it. Where a Host's run does not, that Host is not claimed
anywhere a user reads, the record says which, and the four lines stay as they
are (`docs/05-Process.md` §6, and milestone 5's own clause). The two `say`
lines take their Host names from `kit_hosts` and never from a literal, which
is the Host list and the only one (`docs/01-Architecture.md` §3); the header
comment `--help` prints verbatim is prose and says the same thing without
naming one. What the three lines say is `/apply`'s; that they stop naming one
Host is this page's.

*`selftest`.* Unchanged in kind. Check 2 asserts on `doctor`'s lines and not
on the install's closing lines, so no check pins the three today, and whether
one is worth adding is `/apply`'s call rather than this page's requirement.
Check 5's em dash grep and check 6's Dogfood copy diff apply as they do to
every delivery, and **the proof is the run** (`docs/05-Process.md` §6).

*No new file, no new dependency, no ownership change.* The Host instructions
file stays Project-owned and the Command stays Kit-owned. Nothing is merged,
nothing is appended once, and the Manifest is unchanged in kind.

*No new ADR.* `ADR-0007` records that a Ported command is generated from one
source and is untouched, because no Ported command is added. `ADR-0002` is
untouched, because nothing moves between ownership categories.

*`docs/03-Domain.md`.* No new term. Two rows state today's mechanism in its
own words, Host instructions and Template, both of them on "every Template
Steps 2 and 3 do not account for". Each is rewritten only where the run
changed what it describes, and the words are `/apply`'s.

**Slice.** `skills/initialize/SKILL.md` and its two Dogfood copies,
`.claude/skills/initialize/SKILL.md` and
`.github/prompts/initialize.prompt.md`, plus `bin/focus-kit` and this
repository's own documents (`docs/01-Architecture.md` §3, Structure, neither
slices nor layers but one file; §4 for where each lives). No View,
Orchestrator, Use case or Repository: §3 says none of the four exists here.
The graph named `skills/initialize/SKILL.md` alone, its nine sections and
nothing affected by it, and `bin/focus-kit` alone both ways for
`render_prompt`, whose seven affected nodes are all inside that file, which
is the confirmation that the Command's text reaches every Host through one
transform. Kit-owned: `skills/initialize/SKILL.md`, `bin/focus-kit` and the
generated Ported commands. Project-owned: `docs/00-Product.md`,
`docs/03-Domain.md` where a row changes, `docs/06-Queue.md` and this page.
Merged: nothing. Appended once: nothing.

**States.** The defaults, with one exception and one non-exception. The
exception is the install's closing line and the header `--help` prints, which
change wording where the condition above fires and stay as they are where it
does not. The non-exception is `doctor`: its warn for a missing Host
instructions file is untouched, because a warn that fires less often is the
delivery working and not a change to the warn.

**Visual reference.** No UI. What a person reads that may change is the
install's closing line and the header text, and their exact words come out of
the runs rather than out of this page. What the page fixes about them is that
neither names one Host while the kit ships Commands for more.

**Out of scope.**

* Step 5's rule that the command names and the run does not act, and
  `doctor`'s warn wording. A run that writes the file earlier never reaches
  that warn, and neither of the two is what failed.
* `tooling-card-follows-the-answer-on-every-host`. Its own line, ordered
  after this one, the same proof run's second divergence.
* `initialize-skips-ensuring-the-graph`. An entry under Found, not discussed,
  and a queue line is `/discuss`'s.
* Codex's own Host instructions file. `codex-port` is `[>]` and owns it.
* A review run of `/initialize` in a target that has the nine documents and
  not this file. The friction measured was a first run, and `doctor` already
  names the file for that case.
* Removing the file from a target. It is Project-owned and the person's to
  delete (`work/uninstall-removes-the-kit.md`).
* `README.md`. `readme-makes-the-case` is `[ ]` and is where the kit's own
  case is written.

**Done when.**

* [ ] The measurement made first, before anything is written, under every
  Host `kit_hosts` names at the time of the run, both GitHub Copilot surfaces
  included, each run in a non-English Documentation language, and recorded
  per Host and per surface: whether the step was reached, and whether the
  file was written there.
* [ ] `skills/initialize/SKILL.md` asks for the Host instructions file as a
  file to write and not as what Step 2's table does not account for, naming
  no Host and no path, so a third Host is still a file under `templates/` and
  no edit to a Command.
* [ ] A proof run per Host and per surface, in a Scratch repository, in a
  non-English Documentation language, with the transcript in the record.
  `/apply` runs the Host it is under and stops for the transcript of every
  Host it cannot drive.
* [ ] In each transcript that ended in the file, the write stands before the
  Step 5 `focus-kit doctor .`, and that output carries no `missing` line for
  it.
* [ ] In each of those Scratch repositories, the file is at the path its
  Template mirrors, in that target's Documentation language, pointing at
  `CLAUDE.md`, with no rule of its own and no Init comment left in it.
* [ ] Where a Host's run did not produce the file, the record says what it
  found, and nothing a user reads claims that Host
  (`docs/05-Process.md` §6).
* [ ] The rendered `.github/prompts/initialize.prompt.md` differs from
  `skills/initialize/SKILL.md` only by what `render_prompt` substitutes and
  adds (`docs/03-Domain.md`, Ported command).
* [ ] `docs/00-Product.md` Positioning and `bin/focus-kit:27`, `:605` and
  `:608` stop naming Claude Code as the one Host, where every Host's run
  produced the file; where one did not, all four stay and the record says
  why.
* [ ] `bin/focus-kit selftest` green, six checks.
* [ ] The Dogfood copy in sync: `focus-kit install .` run here
  (`docs/05-Process.md` §5), and check 6 of the verify command empty.
* [ ] `VERSION` bumped: a target receives a Command whose text changed, and
  the CLI's output with it where the condition fired (`CLAUDE.md`, How to
  work).
* [ ] `docs/03-Domain.md`, Host instructions and Template rewritten where the
  runs changed what they describe, or one line saying neither did.
* [ ] The environments of `docs/05-Process.md` §5 in the state that table
  requires.
