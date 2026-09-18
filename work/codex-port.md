# codex-port

**Goal.** Someone working in a target repository with Codex gets the kit's
commands there and that repository's own rules at the start of every session,
installed and owned the way the Claude Code skills are, generated at install
from the one source that already holds them.

**Behaviour.**

* `focus-kit install` in a target writes one Ported command per Command for
  Codex, at the path and in the format Codex's own documentation names at the
  time of the run, and says on one line which ones it wrote.
* A Ported command carries the same words as the skill it came from, with
  every Claude Code specific replaced by what plays that role under Codex, and
  nothing else changed.
* `focus-kit install` run twice into the same target leaves the same bytes.
* `focus-kit doctor` in a target reports the Codex Ported commands present,
  and names one edited locally, one missing and one added that is not the
  kit's, in the three wordings Drift already has.
* `focus-kit doctor` names a Codex Ported command behind the kit source when
  the skill it came from moved and `VERSION` did not, and names the Codex Host
  instructions file missing in the wording the other project-owned files print.
* `/initialize` in a target writes Codex its Host instructions file, without
  asking, pointing at `CLAUDE.md` and carrying no rule of its own.
* A question asked of a target's graph does not come back as a line of a Codex
  file.
* One of the generated commands, and `/initialize`, run by the person under
  Codex in a scratch repository, read the documents they name and end in the
  files they promise. `/apply` runs in Claude Code and cannot drive Codex, so
  it stops at that step and asks for the transcript.

**Contract.**

*Order.* After `copilot-port` and `copilot-reads-the-project-rules`
(`docs/06-Queue.md`, milestone 5). The transform, the substitution list, the
Manifest enumeration, the `doctor` lines and the rule that writes an unnamed
Template to its mirrored path are all theirs; this page adds a second Host to
each. `/apply` stops and says which when either line is not `[x]`.

*The condition the scope turns on.* Codex's own documentation names a
repository-scoped location for a Command, and one for repository instructions,
at the time of the run. `/apply` reads that and settles both, and its record
says what it found. Where it names none for a Command, that half has nothing
to write into a target, and the run stops and says so rather than inventing a
path (`docs/03-Domain.md`, Ported command). A location another Host already
scans is a stop too and never a write: one file per Command per Host, and no
target where one Command is read twice (`docs/03-Domain.md`, Host).

*What install writes.* One Ported command per Command, one per folder
`kit_skills()` names, generated from `skills/<name>/SKILL.md`, the way
`copilot-port` writes Copilot's. Kit-owned, listed in the Manifest, carrying
the Kit-owned banner and the License notice in that order at the first
position the host's format allows (`docs/03-Domain.md`, Ported command;
`docs/adr/ADR-0002-file-ownership.md`). This page fixes that there is exactly
one file per Command and that nothing else is written into a target for this
Host.

*The substitution list becomes one per Host.* This is the second concrete
occurrence of a host-specific list, the first being `copilot-port`
(`CLAUDE.md`: abstraction on the second occurrence, and the delivery says
which was the first). It stays inside `bin/focus-kit` and in no other file
(`docs/03-Domain.md`, Host), and it does not become a data file the script
reads, because a configuration file for the kit is out by decision
(`docs/01-Architecture.md` §2). What the rule fixes is that each Host's
entries live in that one place and that no Command's text names a Host. What
each entry maps to under Codex is `/apply`'s to read and settle.

*What the list may have to gain.* A Host whose Command invocation is not
`/<name>` makes the invocation syntax an entry, which none of the six
`copilot-port` found needed. Whether Codex is such a Host is the run's to
read; that the list can carry an entry of that kind is this page's.

*What the list does not gain.* No entry mapping `CLAUDE.md` to a second file.
`copilot-reads-the-project-rules` removes that entry for every Host: a Ported
command that says `CLAUDE.md` is already right, because every Host instructions
file points at `CLAUDE.md` and no Host reads a second copy of it
(`docs/03-Domain.md`, Host instructions).

*The Host instructions file.* One Template under
`skills/initialize/templates/`, at the path it takes in a target, filled and
translated like every other, its Init comment removed. No edit to
`skills/initialize/SKILL.md` and none to `doctor`: the rule that writes a
Template Steps 2 and 3 do not name by path to its mirrored path, and the warn
whose path is read out of the Template tree, are both
`copilot-reads-the-project-rules`'s, and a second Host is a file there and no
edit. Project-owned, because a person may add a line and `update` erases a
Kit-owned file. The ninth project-owned warn becomes the tenth, in the wording
the others print.

*Determinism.* The transform over the same `skills/` tree writes the same
bytes on every run, on macOS, Linux and Git Bash alike, for this Host as for
the other. Check 3 is the assertion, and the Manifest's fingerprints depend on
it.

*No new dependency.* What is available is bash 3.2 and the python3
`python_bin` already probes (`docs/01-Architecture.md` §2, Out by decision).

*`config/graphifyignore.fragment`.* Gains the Codex generated paths, so a
question asked of a target's graph comes back as the target's code and not as
the kit's own text (`graph-ignores-the-kit`). Fourth content change to a
fragment, and a target installed earlier receives it only through the warn
`an-old-target-gets-the-fragment` shipped.

*`selftest`.* Check 2 asserts the new presence line and one expected warn
more, each built by calling `ok` or `warn` rather than by a literal, the way
it builds every other (`docs/05-Process.md` §4). Check 3 is unchanged and must
stay green, which is where determinism is proven. Check 6 gains the Codex
generated files in the comparison `copilot-port` added, this repository's
against what a regeneration from `skills/` produces.

*This repository.* Its Codex Ported commands are versioned here, as the
Dogfood copy is, by the standing answer to open decision 2
(`docs/05-Process.md` §5), and `focus-kit install .` is what writes them. Its
own Codex Host instructions file is project-owned here as everywhere, written
once and never by the install.

*The ADR.* None new. `ADR-0007` records that a port is generated from the one
source and never authored beside it, and says it is what `codex-port`
inherits (`work/copilot-port.md`, The ADR). This delivery is that inheritance,
and the per-Host list is an abstraction a house rule already decides, not a
decision expensive to reverse.

*What is claimed after the proof.* `docs/00-Product.md` Positioning and the
CLI's host lines stop naming one host in `copilot-reads-the-project-rules`.
Where the proof run came back, Codex joins whatever names the hosts the kit
ships a Ported command for; where it did not, the record says so and nothing a
user reads claims Codex (`docs/05-Process.md` §6).

**Slice.** `bin/focus-kit`, one new Template, one fragment and this
repository's own documents (`docs/01-Architecture.md` §3, Structure, neither
slices nor layers: one file; §4). No View, Orchestrator, Use case or
Repository: §3 says none of the four exists here. The graph named
`bin/focus-kit` and nothing else for `install_repo`, both ways. Kit-owned:
`bin/focus-kit`, the Template, the generated Ported commands. Appended once:
`.graphifyignore`, through `config/graphifyignore.fragment`. Project-owned:
`docs/00`, `docs/01`, `docs/03`, `docs/05`, `docs/06`, and this repository's
own Codex Host instructions file. Merged: nothing.

**States.**

* It works: one `ok` line naming what was written for this Host, built from
  `kit_skills()` the way the other two lines are, so a fifth command is a
  folder and no edit.
* Already there: written over, like every kit-owned tree, and the run says the
  same line.
* The host names no repository-scoped location for one of the two: the run
  stops and says which half it could not write. No path is guessed into a
  target.
* A dependency missing: whatever the mechanism is, it is bash or the python3
  `python_bin` finds, and `merge_json` already dies with the wording for a
  missing python. No second wording is added.
* Not a git repository: the existing warn, unchanged.

**Visual reference.** No UI. The install's new line has the shape
`copilot-port` gave it, the directory filled by what `/apply` finds and the
names by `kit_skills`:

```
  ✓ <the host's command directory>/{apply,discuss,initialize,propose}
```

`doctor`'s presence line takes the shape the skills line already prints, and
its absent shape is the Drift wording word for word. The Template's warn takes
the shape the project-owned files print:

```
  ! <the host's repository instructions file> missing (run /initialize)
```

**Out of scope.**

* Hooks, the question the queue line asks. The kit ships none, for any host
  (`docs/01-Architecture.md` §2), so there is nothing to port.
* A third host. The substitution list is one per Host since this delivery, so
  a third is that same work again and a line of its own, never a widening of
  this page.
* `README.md`. `readme-makes-the-case` is still `[ ]`, and `copilot-port`
  already put the README promise there.
* The three manuals. They reach a target as they are, and
  `docs/manuals/graphify.md` §Ensuring the graph names `AskUserQuestion`, the
  `/graphify` Global skill and Claude Code outright, which a Ported command
  reads and no substitution list touches. What the proof run finds there is
  recorded as divergence and becomes a `/discuss` line, never a fix inside
  this delivery.
* Removing the generated files from a target. `uninstall-removes-the-kit`,
  under Later, is where that lives.
* A slot saying which host a target uses. The install writes every Host's
  files in every target, so nothing varies per project and no slot is earned
  (`docs/01-Architecture.md` §2).
* A new ADR, for the reason the Contract gives.

**Done when.**

* `bin/focus-kit selftest` green, six checks.
* Check 3 green with the second Host in place, which is the determinism
  assertion.
* The Dogfood copy in sync, the Codex generated files included: `focus-kit
  install .` run here (`docs/05-Process.md` §5), and check 6 of the verify
  command empty.
* `VERSION` bumped: a target receives files and a Template it did not have.
* One generated command and `/initialize` run under Codex in a scratch
  repository, by the person and not by `/apply`, which stops there and asks
  for the transcript; what they produced is recorded in
  `work/done/codex-port.md`, every divergence from this page included, the way
  `docs/05-Process.md` §6 requires.
* `docs/00-Product.md` Positioning and the CLI's host lines naming Codex, or
  the record saying why they do not.
* `docs/01-Architecture.md` §2, §3 and §4, `docs/03-Domain.md` (the Host row's
  count and the Ported command row), and `docs/05-Process.md` §4 and §5
  written.
* The environments of `docs/05-Process.md` §5 in the state that table
  requires.
