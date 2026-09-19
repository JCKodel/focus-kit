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

---

## What happened

**What the run settled.** The page left the Host instructions file's
directory, name and extension to the run. GitHub Copilot's own
documentation, read on 2026-09-19, names three kinds of repository custom
instructions: repository-wide, in `.github/copilot-instructions.md`;
path-specific, in `.github/instructions/NAME.instructions.md`; and agent
instructions, in one or more `AGENTS.md` anywhere in the tree. The first is
the one this delivery wanted, because it is the file read on every request
in that repository, and it is what was taken. `AGENTS.md` was not: it is a
cross-vendor file several tools read, which is a different thing from a
file belonging to one Host, and `codex-port` is where it may be claimed.

**The graph.** `explain "skills/initialize/SKILL.md"` named one file and its
own nine sections, `affected "skills/initialize/SKILL.md"` named none, which
is what the page predicted.

**Three things diverged from the page, and none changed the work.**

1. *The substitution list had nothing to lose.* The page says it loses the
   entry mapping `CLAUDE.md` to the host's own, "the one `copilot-port`
   ships". `copilot-port` never shipped it: its own record says so under
   "The substitution list has five pairs, not six", and its first question to
   the person settled `CLAUDE.md` stays `CLAUDE.md`, on this delivery's queue
   line as the reason. The comment above `render_prompt` already explains the
   exclusion in this delivery's words. Nothing was deleted, and the Ported
   commands changed only because the skill they come from did.
2. *The report step is Step 5, not Step 4.* The page names Step 4 twice as
   the step that lists what was written. Step 4 became "the manuals follow
   the language" in `manuals-follow-the-language`, and Step 5 is the report.
   The new rule makes the file one `/initialize` writes, so Step 5's "list
   the files you wrote" already carries it and nothing was added there.
3. *`bin/focus-kit:513` is `:789`.* The page's address for `doctor`'s
   project-owned loop is the one it had when the page was written, before
   `graph-builds-without-a-key` inserted `prompt_preamble`.

**Where each piece went.**

* **The Template** is `skills/initialize/templates/.github/copilot-instructions.md`,
  at the path it takes in a target, the way every Template mirrors the target
  tree. It points at `CLAUDE.md`, names the process document and the prompt
  folder, and holds no rule of its own. Its Init comment says the one thing
  the run must not do, which is copy a line out of `CLAUDE.md` into it.
* **The skill** gains one paragraph in Step 3, whose heading widened from
  `CLAUDE.md` to `CLAUDE.md, and the files that point at it`. Nothing
  renumbered, so every reference to Step 3 elsewhere still reads right. The
  rule names no host: it says "another tool reads another path", so the
  substitution list leaves it alone and the Ported command carries it word
  for word, which was checked in the regenerated file.
  One wording of the rule diverges from the page's letter, and it had to.
  "Every Template that Steps 2 and 3 do not name by path" would, read
  literally, write `templates/docs/adr/ADR-0000-template.md` into a target,
  because Step 2's table names `templates/docs/adr/` as a directory and not
  that file. The rule as written says the table accounts for a path it names
  **and for everything under a directory it names**, which is the same rule
  with the hole closed.
* **`doctor`** names the ninth project-owned file in the wording the eight
  already print, from the same loop, and holds no literal for the path: it
  reads the Template tree at `KIT_DIR` for the markdown files that are
  neither under `docs/` nor `CLAUDE.md`, which is exactly what Steps 2 and 3
  account for. Markdown only, and that is the one constraint the page did not
  state: a `.DS_Store` at the root of that tree would otherwise print
  `.DS_Store missing (run /initialize)`, a warn naming a command that would
  not clear it, which `docs/04-Conventions.md` §1 forbids. Inline and not a
  helper, the way `manuals/*.md` is read in the same function: one caller,
  and `CLAUDE.md` asks for abstraction on the second occurrence.
* **`selftest`** check 2 asserts eleven warns, the eleventh built by calling
  `warn` like the other ten. The path is a literal there, as the four command
  names and the two host names already are: `doctor` reads it out of the
  Template tree, and an assertion that read the same tree would assert
  nothing.
* **This repository's own file** is `.github/copilot-instructions.md`,
  written by hand from the Template, in English, with the Init comment
  removed. `focus-kit install .` never writes it and never will: it is
  project-owned here as everywhere.

**Two counts in the documents were already stale and were corrected here,
because this delivery moves both.** `docs/05-Process.md` §4 said "ten of the
seventeen paths the manifest names are templates"; the manifest names
twenty-two paths and eleven are templates, `copilot-port` having added four
Ported commands to it without moving the number. And every
`bin/focus-kit:NNN` citation in `docs/00`, `01`, `03` and `04` was re-read
off the script: most were behind by the fifty-four lines
`graph-builds-without-a-key` inserted, and this delivery's own insertions
moved them again. The ADRs were left as they are, dated amendments being a
record of what was.

**What the verify command says.** `bin/focus-kit selftest` green, six checks.
Check 2 asserts the eleventh warn; check 6 is empty after `focus-kit
install .`.

**The proof, first half.** `docs/05-Process.md` §6 asks for a real run in a
scratch repository, and one was made: `mktemp -d`, `git init`, `focus-kit
install .`. The Template arrives at
`.claude/skills/initialize/templates/.github/copilot-instructions.md`, the
manifest records it, and `doctor` there prints

```
  ! .github/copilot-instructions.md missing (run /initialize)
```

ninth in the project-owned block, after `CLAUDE.md`. With the file put there
by hand the same run prints the green `.github/copilot-instructions.md`
instead. `doctor` in this repository prints the green line too.

## The proof run

`~/Downloads/copilot-rules-proof` under GitHub Copilot, 2026-09-19, the kit
at 0.38.0, a greenfield Flutter repository and a Portuguese session. Run by
the person: `/apply` runs in Claude Code and cannot drive Copilot, so it
stopped there and asked for the transcript.

**What it produced.** `CLAUDE.md` and `.github/copilot-instructions.md`,
both at the root, and no second copy of `CLAUDE.md` anywhere. The nine
documents, the ADR, the queue with three open decisions, the language
record at `pt-BR`, and `docs/05-Process.md` §4 reading `flutter test &&
flutter analyze`. `focus-kit doctor .` in that scratch afterwards prints the
green `.github/copilot-instructions.md`. The file points at `CLAUDE.md`,
carries no rule of its own and has no Init comment left in it.

So the file arrives, and the path, the ownership and the content are what
the page asked for. Two things about **how** it arrived are not.

**Divergence 1: the rule did not fire in Step 3. `doctor` is what produced
the file.** The transcript's order is twelve writes, then `focus-kit doctor
.`, whose output the run printed with

```
  ! .github/copilot-instructions.md missing (run /initialize)
```

in it, and only then the write of that file. Step 5 says of that output
that "the command names and you do not act", and the run acted; the file
exists because the warn named it and not because Step 3 asked for it.
Nothing in the transcript shows the template tree being listed, which is
what the rule needs: the nine documents are named by path in Step 2's
table, and this one is named by no path at all, only as what that table
does not account for. A rule that asks a host to enumerate a directory and
subtract is not a rule that names a file, and under this host the
difference was the whole difference. The shape is the one
`build-now-reaches-every-host` already records in its own words:
documenting a thing is not offering it.

**Divergence 2: the file came out in English in a `pt-BR` target.** It is
the Template verbatim, identical modulo line wrapping, while the page's
Behaviour asks that a target whose documentation language is not English
receive it in that language, its path unchanged. This follows from the
first: written in Step 3 it would have been translated with the nine
documents, and written at the end against a warn that says only "missing"
there was nothing telling the run what language it owed. One cause, two
symptoms.

**What the run does not show.** Whether the rule fires under Claude Code.
The kit has two hosts and this run exercised one of them.

**A second finding, of a delivery that already shipped.** The tooling card
came out offering "Padrão do ecossistema .NET, xUnit, dotnet format e um
linter .NET padrão do ecossistema" in a repository whose stack answer was
Flutter. That is `tools-follow-the-stack`, `[x]` since 2026-09-18, whose fix
was moving the question from round 3 to round 5 so the language would
already be answered beside it. The text the host received says it in so many
words, "the test framework, the linter and the formatter of the ecosystem
round 3 answered, and of no other" and "no tool is named here", and the host
offered the house default anyway. Fifth occurrence of the shape and the
first after the move, so the answer is not another move. As in every earlier
occurrence the documents came out right, `docs/05-Process.md` §4 reading
`flutter test && flutter analyze` and no `.NET` tool anywhere under `docs/`
or in `CLAUDE.md`, so only the asking was wrong and no file in that scratch
records it. It is out of this delivery's scope and goes to the queue.

**One finding in the kit's favour, and it belongs beside the two against.**
The reason the outcome is right at all is
`initialize-names-what-it-skipped`, the delivery that made `/initialize`
close by running `focus-kit doctor .` and printing what it said. The
mechanism built to name a step a run did not take named exactly that, on
its first encounter with a step that did not exist when it was built, and a
target that would otherwise have gone without the file has it. That the run
then acted on the warn is Divergence 1; that there was a warn to act on is
the mechanism working.

## What was decided, and what was not written

**The four host lines stay as they are.** `bin/focus-kit:27`, `:605`, `:608`
and `docs/00-Product.md` Positioning go on naming Claude Code. Two texts of
this repository pull apart on the case, so it went to the person
(`CLAUDE.md`, ambiguity goes to the person), with the answer above
recommended and taken. This page says the lines stay if the run did not
produce the file, and it produced it; milestone 5's paragraph says a port
whose proof run finds the host diverging from the text it received word for
word is not ported until the divergence has an answer, and there are two
divergences with no answer yet. Positioning is a product claim, and
`copilot-port` deferred that same line for that same reason. Where they come
back is `pointer-file-is-written-where-the-rule-stands`.

**The rule was not reworded.** The run showed that the shape of the rule is
what failed and not a word in it, and no rewording can be proven without a
second run under both hosts, which `/apply` cannot make. `docs/05-Process.md`
§6 says a change to a skill is proven by a real run, and a platform is not
claimed anywhere a user reads until it has been run there. The precedent is
`graph-builds-without-a-key`, which shipped with its divergence recorded and
left the wording to a line that measures first.

**Two lines went to the queue**, under milestone 5, whose paragraph admits
the friction its own proof runs surface:
`pointer-file-is-written-where-the-rule-stands` and
`tooling-card-follows-the-answer-on-every-host`.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.38.0, this commit |
| Dogfood copy | 0.38.0, `focus-kit install .` run here, check 6 empty |
| Machine | a symlink to the kit source, so 0.38.0; the graphify skill of both Hosts at the package's version |
| Target repositories | untouched, and they move only when their owner runs `focus-kit update <path>` |

`~/Downloads/copilot-rules-proof` is a scratch of this delivery's proof run
and not an environment: nothing was committed there and it is disposable.

**Two warns of `doctor` in this repository were cleared along the way**, and
they were not this delivery's: `docs/06-Queue.md` cited
`docs/manuals/focus.md` and `manuals/process.md` by number inside the
`tools-follow-the-stack` line, both present at `506bdb9`. The Manual
citation pass names them and its fix is a hand edit, the file being
project-owned, and this delivery was editing that file anyway. They are now
`§FOCUS in C#` and `` §`/initialize` ``, backticks included, because a
heading is normalized with its backticks and the first attempt without them
earned the second warn. `focus-kit doctor .` here prints no `!` at all.

**The stage carries another delivery's work.** `git add -A` picked up
`graph-builds-without-a-key`, still in flight: its page, its two queue lines
and the `work/` pages of `build-now-reaches-every-host` and
`a-finding-reaches-the-queue`. That is the cost `docs/05-Process.md` §7
records for the git strategy being none, measured by `git-strategy-is-asked`
on 2026-09-18, and it is named here rather than worked around.
