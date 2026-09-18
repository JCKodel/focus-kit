# copilot-reads-the-project-rules

**Goal.** Someone working in a target repository under a host other than
Claude Code gets that repository's own rules at the start of every session,
because `/initialize` wrote that host its Host instructions file and the file
points at `CLAUDE.md` instead of holding a second copy of it.

**Behaviour.**

* `/initialize` in a target writes the Host instructions file of every host
  the kit ships a Ported command for, without asking, and names it in Step 4
  among the files it wrote.
* The file it writes points at `CLAUDE.md` and carries no rule of its own, so
  one edit by hand to `CLAUDE.md` moves every host and nothing drifts.
* A review run in a target that already has that file keeps everything that is
  there, adds the pointer and shows the diff first, the way Step 3 already
  does for `CLAUDE.md`.
* A target whose documentation language is not English receives the file in
  that language, its path unchanged.
* `focus-kit doctor` in a target that lacks the file names it missing and
  names `/initialize`.
* `/initialize` run under GitHub Copilot in a scratch repository writes
  `CLAUDE.md` and that host's Host instructions file, and writes no second
  copy of `CLAUDE.md` anywhere. `/apply` runs in Claude Code and cannot drive
  Copilot, so it stops at that step and asks the person for the transcript.

**Contract.**

*Order.* After `copilot-port` (`docs/06-Queue.md`, milestone 5). The proof run
is a Ported command, so it does not exist until that delivery shipped.

*What is written.* One Host instructions file per host the kit ships a Ported
command for, at the directory, file name and extension that host's own
documentation names for repository instructions at the time of the run:
`/apply` reads that and settles it, and its record says what it found. This
page fixes that the file points at `CLAUDE.md`, that it carries no rule of its
own, and that `CLAUDE.md` stays the one file a rule is written in
(`docs/03-Domain.md`, Host instructions).

*Ownership.* Project-owned. The CLI never writes it; `/initialize` does, and a
person may add a line to it, which is why it is not Kit-owned: `update` erases
a Kit-owned file. `docs/adr/ADR-0002-file-ownership.md` gains the path in its
project-owned list, as an amendment and not a new ADR, because the reason for
pointing rather than copying is already `docs/03-Domain.md`, Host
instructions.

*Where its text lives.* A Template under `skills/initialize/templates/`, at
the path it takes in a target, the way every Template mirrors the target tree
(`docs/01-Architecture.md` §4). No Command's text names a host
(`docs/03-Domain.md`, Host), so `skills/initialize/SKILL.md` gains one rule
that names none: every Template that Steps 2 and 3 do not name by path is
written to its mirrored path, filled and translated like the others, its Init
comment removed (Language, "translate the templates as you fill them", "keep
every path and file name as it is"). A second host is then a file under
`templates/` and no edit to the skill, the way a fifth Command is a folder
under `skills/` (`kit_skills`).

*The substitution list.* Loses its entry for the repository instructions file,
the one that maps `CLAUDE.md` to the host's own and that `copilot-port` ships,
whose page still holds it. With that entry in place the Ported `/initialize`
reads Step 3 as writing the `CLAUDE.md` Template to the host's path, which is
exactly the second copy `docs/03-Domain.md`, Host instructions, forbids. Every
host points at `CLAUDE.md`, so a Ported command that says `CLAUDE.md` is
already right, and the list is one entry shorter. The regenerated Ported
commands are what the Manifest records.

*What still names one host.* The CLI's closing message and the header
`--help` prints verbatim both tell the person to open Claude Code and run
`/initialize` (`bin/focus-kit:23`, `bin/focus-kit:363`, `bin/focus-kit:366`),
and `docs/00-Product.md` Positioning names Claude Code as the host the kit is
for. Each stops naming one host, and each is written only after the proof run
came back: `docs/05-Process.md` §6 says a platform is not claimed anywhere a
user reads until it has been run there. If the run did not produce it, the
record says so and all four lines stay as they are.

*`doctor`.* One warn more, the ninth project-owned file, in the wording the
eight already print, `<path> missing (run /initialize)`, from the loop that
already prints them (`bin/focus-kit:513`). It names `/initialize` because
every warn names the command that fixes it (`docs/04-Conventions.md` §1).
The path it names is read out of the Template tree at `KIT_DIR`, the way
`kit_skills` reads `skills/*/` and `doctor` reads `manuals/*.md`, so a second
host stays a file there for `doctor` too and the script keeps naming no host
outside the substitution list (`docs/03-Domain.md`, Host). Presence only: what
is inside the file is the person's.

*`selftest`.* Check 2 asserts one expected warn more, eleven, each built by
calling `warn` rather than by a literal, the way it builds every other
(`docs/05-Process.md` §4). No check gains a shape it did not have: the
Template is one more file copied and fingerprinted, which check 3 and the
Manifest already cover.

*This repository.* It is its own target (`docs/05-Process.md` §5), and
`copilot-port` generates its Ported commands here, so it receives the Host
instructions file too, written from the same Template. Project-owned here as
everywhere, so it is written once and never by `focus-kit install .`.

**Slice.** `bin/focus-kit`, `skills/initialize/SKILL.md`, one new Template,
and this repository's own documents (`docs/01-Architecture.md` §3, Structure,
neither slices nor layers: one file; §4). No View, Orchestrator, Use case or
Repository: §3 says none of the four exists here. The graph named
`skills/initialize/SKILL.md` and its own eight sections, and nothing depends
on it. Kit-owned: `bin/focus-kit`, the skill, the Template, the regenerated
Ported commands. Project-owned: `docs/00`, `docs/01`, `docs/03`, `docs/05`,
`docs/adr/ADR-0002`, and this repository's own Host instructions file. Merged
and Appended once: nothing.

**States.**

* It works: Step 4 lists the file among what was written, and `doctor` stops
  naming it.
* Already there: merged, the diff shown before the write, nothing the person
  put in it removed.
* Missing in a target: one `warn` naming `/initialize`, like the eight others.
* Not a git repository, a dependency missing: the existing wordings,
  unchanged.

**Visual reference.** No UI. The `doctor` line has the shape the eight
project-owned lines already print, with the path filled by what `/apply`
finds:

```
  ! <the host's repository instructions file> missing (run /initialize)
```

**Out of scope.**

* `codex-port`. It takes the same two halves and follows whatever this decides
  (`docs/06-Queue.md`, milestone 5).
* `README.md`. `readme-makes-the-case` is still `[ ]`, and `copilot-port`
  already put the README promise there.
* A new ADR. ADR-0002 is amended instead, which the answer taken in this
  conversation settles.
* A slot saying which host a target uses. `/initialize` writes the file in
  every target, so nothing varies per project and no slot is earned
  (`docs/01-Architecture.md` §2).
* Removing the file from a target. It is project-owned, so it is the person's
  to delete; `uninstall-removes-the-kit`, under Later, is the kit's side.
* The three manuals. `docs/manuals/graphify.md` §Ensuring the graph names
  Claude Code outright, and `copilot-port` already recorded that what the
  proof run finds there is a `/discuss` line and never a fix inside a
  delivery.
* Hooks. The kit ships none, for any host (`docs/01-Architecture.md` §2).

**Done when.**

* `bin/focus-kit selftest` green, six checks, check 2 asserting eleven warns.
* The Dogfood copy in sync: `focus-kit install .` run here
  (`docs/05-Process.md` §5), and check 6 of the verify command empty.
* `VERSION` bumped: a target receives a Template and a `doctor` line it did
  not have.
* `/initialize` run under GitHub Copilot in a scratch repository, by the
  person and not by `/apply`, which stops there and asks for the transcript;
  what it produced is in `work/done/copilot-reads-the-project-rules.md`, every
  divergence from this page included (`docs/05-Process.md` §6).
* `docs/00-Product.md` Positioning and the CLI's three host lines rewritten,
  or the record saying why they were not.
* `docs/01-Architecture.md` §2, §3 and §4, `docs/03-Domain.md`,
  `docs/05-Process.md` §4 and `docs/adr/ADR-0002-file-ownership.md` written.
* The environments of `docs/05-Process.md` §5 in the state that table
  requires.
