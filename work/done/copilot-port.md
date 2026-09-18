# copilot-port

**Goal.** Someone working in a target repository with GitHub Copilot gets the
kit's commands there, installed and owned the way the Claude Code skills are,
generated at install from the one source that already holds them.

**Behaviour.**

* `focus-kit install` in a target writes one prompt file per command, at the
  path and in the format GitHub Copilot's own documentation names for a
  reusable prompt, and says on one line which ones it wrote.
* A prompt file carries the same words as the skill it came from, with every
  Claude Code specific replaced by what plays that role under Copilot, and
  nothing else changed.
* `focus-kit install` run twice into the same target leaves the same bytes.
* `focus-kit doctor` in a target reports the prompt files present, and names
  one edited locally, one missing and one added that is not the kit's, in the
  three wordings Drift already has.
* `focus-kit doctor` names a prompt file behind the kit source when the skill
  it came from moved and `VERSION` did not.
* A question asked of a target's graph does not come back as a line of a
  prompt file.
* One of the generated commands, run by the person under GitHub Copilot in a
  scratch repository, reads the documents it names and ends in the file it
  promises. `/apply` runs in Claude Code and cannot drive Copilot, so it stops
  at that step and asks for the transcript.

**Contract.**

*What install writes.* One file per Command, one per folder `kit_skills()`
names, generated from `skills/<name>/SKILL.md`. The directory, the file name,
the extension and the frontmatter keys are what GitHub Copilot's documentation
names for a reusable prompt at the time of the run: `/apply` reads that and
settles it, and its record says what it found. Whatever those keys are, the
value that describes the command is the `description` of the `SKILL.md` it
came from, carried over and not rewritten. This page fixes that there is
exactly one file per Command and that nothing else is written into a target.

*Ownership.* Kit-owned, no fifth category (`docs/adr/ADR-0002-file-ownership.md`):
the destination is written over on every `install` and `update`, so an edit
made inside a target is erased. Each generated file carries the Kit-owned
banner and the License notice, in that order, at the first position the host's
format allows, which for a file that opens with frontmatter is the line after
its closing `---` (`docs/03-Domain.md`, Kit-owned banner; ADR-0002,
Forbidden).

*What the transform does.* The body of `SKILL.md` reaches the generated file
word for word, except for a fixed substitution list with one entry per thing
that names Claude Code and nothing else. Each entry maps to what plays that
role under the host, or, where the host has nothing that plays it, to prose
saying what to do instead. The list lives in one place in `bin/focus-kit`, and
it is what a later skill edit has to respect. A `grep` over `skills/*/SKILL.md`
at this commit finds six: the argument placeholder (`$ARGUMENTS`), the tool
that asks (`AskUserQuestion`), the new session (`/clear`), the host (the words
"Claude Code"), the repository instructions file (`CLAUDE.md`) and the proof
tool option "Claude in Chrome" (`skills/initialize/SKILL.md`). The six are
what the rule finds today and not the rule: `/apply` greps again and its
record says what it found. No tool name is among them, because the skills name
none; `.claude/skills/initialize/templates/` is not among them either, because
the skill already names it by a path every target has whatever its host.

*Determinism.* The transform over the same `skills/` tree writes the same
bytes on every run, on macOS, Linux and Git Bash alike. Check 3 is the
assertion, and the Manifest's fingerprints depend on it.

*No new dependency.* What is available is bash 3.2 and the python3
`python_bin` already probes (`docs/01-Architecture.md` §2, Out by decision).
Which of the two does the substitution, and by what mechanism, is `/apply`'s
to settle by running it.

*`write_manifest`.* Enumerates the generated files the way it enumerates
`.claude/skills/$s` and `manuals/*.md`, so a generated file edited locally,
one that is gone and one the source no longer holds reach the three Drift
wordings and the behind-the-source pipeline with no fourth wording
(`docs/03-Domain.md`, Drift, Unbumped change).

*`doctor`.* One presence line for what the install wrote, in the shape the
skills line already has, carrying the Drift wording when the path is absent.
Every warn names the command that fixes it (`docs/04-Conventions.md` §1).

*`selftest`.* Check 2 asserts the new line the way it asserts every other, by
calling `ok` or `warn` rather than by a literal. Check 3 is unchanged and must
stay green, which is where determinism is proven. Check 6 gains one
comparison: this repository's generated files equal what a regeneration from
`skills/` produces, since `skills/` holds no tree to `diff -r` them against,
the way `.focus-kit-manifest` is excluded for that same reason.

*`config/graphifyignore.fragment`.* Gains the generated paths, so a question
asked of a target's graph comes back as the target's code and not as the kit's
own text (`graph-ignores-the-kit`). Third content change to a fragment, and a
target installed earlier receives it only through the warn
`an-old-target-gets-the-fragment` shipped.

*This repository.* The generated files are versioned here, as the Dogfood copy
is, by the standing answer to open decision 2 (`docs/05-Process.md` §5).
`focus-kit install .` is what writes them, and the rule that any delivery
touching `skills/` ends by running it applies unchanged.

*The ADR.* `docs/adr/ADR-0007-<slug>.md`, a new number: the port is generated
from the one source and never authored beside it. It records the alternative
that lost, a hand-written tree per host, with the number that lost it, 9,162
words of skill at this commit, and it is what `codex-port` inherits.

**Slice.** `bin/focus-kit`, the whole CLI, plus one fragment and this
repository's own docs (`docs/01-Architecture.md` §3, Structure, neither slices
nor layers: one file; §4). No View, Orchestrator, Use case or Repository: §3
says none of the four exists here. The graph named `bin/focus-kit` and nothing
else for `install_repo`, both ways, and the same for `kit_skills` and
`write_manifest`. Kit-owned: `bin/focus-kit` and the generated files.
Appended once: `.graphifyignore`, through `config/graphifyignore.fragment`.
Project-owned: here, `docs/01`, `docs/03`, `docs/05`, `docs/06` and
`docs/adr/ADR-0007`.

**States.**

* It works: one `ok` line naming what was written, built from `kit_skills()`
  the way the skills line is, so a fifth command is a folder and no edit.
* Already there: written over, like every kit-owned tree, and the run says the
  same line.
* A dependency missing: whatever the mechanism is, it is bash or the python3
  `python_bin` finds, and `merge_json` already dies with the wording for a
  missing python. No second wording is added.
* Not a git repository: the existing warn, unchanged.

**Visual reference.** No UI. The install's new line has this shape, the
directory filled by what `/apply` finds and the names by `kit_skills`:

```
  ✓ <the host's prompt directory>/{apply,discuss,initialize,propose}
```

`doctor`'s presence line takes the shape the skills line already prints, and
its absent shape is the Drift wording word for word.

**Out of scope.**

* The repository instructions file, the Copilot twin of `CLAUDE.md`. It is
  project-owned and `/initialize` writes it, so it is the follow-up delivery.
  This page touches no skill and no template.
* `docs/00-Product.md` Positioning and the README promise the queue line
  names. Both wait for that follow-up: `docs/05-Process.md` §6 says a platform
  is not claimed anywhere a user reads until the verify command has run there,
  and `readme-makes-the-case` is still `[ ]`.
* `codex-port`. It follows whatever this decides (`docs/06-Queue.md`,
  milestone 5).
* A check 4 counterpart for the generated frontmatter. It is derived from one
  check 4 already validates, and check 3 proves the derivation deterministic.
* Hooks, the question the queue line asks. The kit ships none, for any host
  (`docs/01-Architecture.md` §2), so there is nothing to port.
* The three manuals. They reach a target as they are, and
  `docs/manuals/graphify.md` §Ensuring the graph names `AskUserQuestion`, the
  `/graphify` Global skill and Claude Code outright, which a Ported command
  reads and the substitution list does not touch. What the proof run finds
  there is recorded as divergence and becomes a `/discuss` line, never a fix
  inside this delivery.
* Removing the generated files from a target. `uninstall-removes-the-kit`,
  under Later, is where that lives.
* A slot saying which host a target uses. The install writes the files in
  every target, so nothing varies per project and no slot is earned
  (`docs/01-Architecture.md` §2).

**Done when.**

* [x] `bin/focus-kit selftest` green, six checks.
* [x] Check 3 green with the transform in place, which is the determinism
  assertion.
* [x] The Dogfood copy in sync, the generated files included:
  `focus-kit install .` run here (`docs/05-Process.md` §5).
* [x] `VERSION` bumped: a target receives files it did not have. 0.29.0 to
  0.30.0.
* [x] One generated command run under GitHub Copilot in a scratch
  repository, by the person and not by `/apply`, which stops there and asks
  for the transcript; what it produced is recorded in
  `work/done/copilot-port.md`, every divergence from this page included, the
  way `docs/05-Process.md` §6 requires.
* [x] `docs/01-Architecture.md` §3, §4 and §5, `docs/03-Domain.md`,
  `docs/05-Process.md` §4 and §5, and `docs/adr/ADR-0007` written.
  `docs/04-Conventions.md` §5, `docs/adr/ADR-0002` and `docs/adr/README.md`
  with them, and the `bin/focus-kit:NNN` citations of `docs/00`, `docs/01`,
  `docs/03`, `docs/04`, `ADR-0001` and `ADR-0002` renumbered.
* [x] The environments of `docs/05-Process.md` §5 in the state that table
  requires.

---

## What happened

**What the run settled**, inside the constraints the Contract stated:

* **The host's format.** `.github/prompts/<command>.prompt.md`, read from
  GitHub's own `Your first prompt file` and VS Code's `Use prompt files in
  VS Code` on 2026-09-18. Prompt files are Markdown with the `.prompt.md`
  extension, in the `.github/prompts` folder at workspace scope, and the
  optional YAML frontmatter names `description`, `name`, `argument-hint`,
  `agent`, `model` and `tools`, none of them required. Public preview and
  available in VS Code, Visual Studio and JetBrains.
* **The frontmatter is carried over whole.** The three keys the four
  `SKILL.md` files already have, `name`, `description: >-` and
  `argument-hint`, are three of the six the format names, so the block
  arrives unrewritten and the `>-` description with it, which is what the
  page asked for. One line is added, `agent: 'agent'`, GitHub's own example
  and the reason its tutorial says Copilot switches to agent mode: a command
  that writes files and runs the verify command needs it. It goes right after
  the opening `---`, so the Kit-owned banner and the License notice stay
  exactly where the source has them, on the two lines after the closing
  `---`.
* **The mechanism is bash, not python3.** Five quoted `${var//"$from"/$to}`
  expansions per line, verified on this machine's bash 3.2.57. It needs no
  interpreter, it is byte for byte the same on the three platforms, and it
  stays out of the trap `docs/01-Architecture.md` §6 names: `doctor` renders
  a prompt inside a command substitution to fingerprint it, and a renderer
  that could die on a missing python would leave the caller with an empty
  answer. `render_prompt` returns non-zero on a missing source and never
  dies.
* **The substitution list has five pairs, not six.** The grep the page
  predicted found the six it named, and `CLAUDE.md` is deliberately not one
  of them. See the next paragraph.
* **The ADR is 0007**, as reserved, slug
  `ports-are-generated-not-authored`. The number that lost the hand-written
  tree is recorded twice, because the page's own number had already moved:
  9,162 words of skill at `92554bd`, when the page was written, and 9,772 at
  `1330acb`, one delivery later, `manuals-follow-the-language` having grown
  `/initialize` by 610 words while touching nothing else. That growth in one
  delivery is the argument, better than the static number was.

**Two questions went to the person** (`CLAUDE.md`, ambiguity goes to the
person), and both answers diverge from the page's letter:

1. **`CLAUDE.md` stays `CLAUDE.md`.** The page listed it among the six the
   grep finds. Two things in the repository cut against substituting it.
   `docs/06-Queue.md`, `copilot-reads-the-project-rules`, says the Host
   instructions file **points at** `CLAUDE.md` instead of copying it, so the
   file that holds a target's rules is `CLAUDE.md` whatever the host; and
   `skills/initialize/SKILL.md:435` names `templates/CLAUDE.md`, a path a
   blanket substitution would turn into
   `templates/.github/copilot-instructions.md`, which no target has. The rule
   the page fixed, one entry per thing that names Claude Code, keeps the
   exception it already made for `.claude/skills/initialize/templates/`:
   what every target has whatever its host is not in the list. The answer
   was the first option, and `ADR-0007` records it as part of the decision.
2. **`.github/prompts/` is the person's directory, not the kit's.** The
   Behaviour section asked `doctor` for all three Drift wordings, including
   `is not the kit's (focus-kit update removes it)`. That third wording
   comes from the added-file scan, and the scan is only true where `install`
   does `rm -rf`, which for that directory would delete the prompts the
   person wrote there on every `update`. The answer was the `docs/manuals/`
   model: `mkdir -p` and one write per file, the directory untouched, the
   files kit-owned. **The consequence is a divergence from Behaviour bullet
   4**: a Ported command reaches `edited locally` and `missing` and never the
   third wording, and a file added beside one is named by nothing. Both were
   probed in a scratch and are in the record below.

**Three divergences the proof run will meet, and none of them is fixed
here**, because the page touches no skill:

* `"Other" is GitHub Copilot's own last option` and `its own fourth option`,
  three times in the generated `/initialize`. It is true of Claude Code's
  ask tool and false of a question asked in Copilot's chat, which adds no
  option. The sentence survives the substitution because what is
  host-specific in it is the tool's behaviour and not its name.
* `The browser inside GitHub Copilot`, in the Proof tool question. VS Code's
  prompt-file documentation names a `browser` tool, so the sentence is true
  there and says nothing about Visual Studio or JetBrains. The option label
  becomes `The browser tool`.
* `nothing added to the repository`, the clause after that option. A browser
  the host drives may need configuring somewhere; the clause was written
  about a browser that needs none.

Each is a `/discuss` line and not an edit inside this delivery.

**What was probed, beyond the verify command.** In a scratch repository:
a generated prompt with a line appended gets `edited locally`; one deleted
gets `missing`, **once**, which is the presence loop and the drift pass
agreeing through the same list; and against a copy of the kit whose
`skills/apply/SKILL.md` had moved while `VERSION` had not, one `doctor` run
named both `.claude/skills/apply/SKILL.md` and
`.github/prompts/apply.prompt.md` as `behind the kit source`, with the green
`kit version` line correctly absent. The `.graphifyignore` fragment's four
new lines reached the scratch whole.

**One thing pasted by hand.** This repository's own `.graphifyignore` was
appended before the fragment gained those lines, and `append_once` never
writes into a block that is there, so the four lines were added by hand. The
post-commit hook would otherwise pull the four prompt files into this
repository's graph, which is the behaviour bullet about a question asked of
a target's graph. The fragment gained four explicit paths rather than
`.github/prompts/`: it mirrors the shape the block already had, four skill
folders named one by one, and a directory line would take a person's own
prompt files out of their own graph as well.

**`ADR-0002` gained an amendment**, appended and not edited into the body:
the category gains the Ported commands without gaining a fifth category, and
the sentence the delivery made necessary is written there for the first
time, that being kit-owned is a property of the file and never of the folder
around it. It was already true of `docs/manuals/`.

**The README was left alone on purpose.** Its ownership table enumerates
what the install writes and is now one row short. Adding that row claims a
platform, and `docs/05-Process.md` §6 forbids claiming one anywhere a user
reads until the verify command has run there, which is why the page puts the
README and `docs/00` Positioning out of scope. Both move with
`readme-makes-the-case` and `copilot-reads-the-project-rules`.

**Line numbers.** The edits to `bin/focus-kit` moved every function, so the
`bin/focus-kit:NNN` citations in `docs/00`, `docs/01`, `docs/03`, `docs/04`,
`ADR-0001` and `ADR-0002` were renumbered against the new file, and so was
the Line column of `docs/01-Architecture.md` §3. Pages under `work/done/`
were left alone: a Done page records what was.

**One thing noticed and not fixed.** `docs/05-Process.md` §5 still carries
the First target row for `~/Downloads/vaulted`, which the row itself says
leaves with milestone 2. Milestone 2 has no open line and the directory is
gone. It is outside this page's scope and belongs to a `/discuss`.

## The proof run

`/initialize` under GitHub Copilot in VS Code, by the person, in
`~/Downloads/focus-kit-copilot-proof`: a bare `git init` with focus-kit
0.30.0 installed and nothing else. `/initialize` and not `/discuss` or
`/propose`, because those two read `docs/00`, `docs/03` and `docs/06`, which
a bare scratch does not have, and because all three predicted divergences
live in `/initialize`.

**The four things `/apply` could not see, answered by the person: all four
yes.** The prompt appeared under `/` in Copilot Chat; `agent: 'agent'`
switched the mode on its own; `multiple choice question` produced real
questions, rendered as a question card with options and a free-text field,
one of four in a round; and the run found the templates under
`.claude/skills/initialize/templates/`.

**It ended in the files it promises.** In the scratch: `docs/00` to `06`,
`CLAUDE.md`, `docs/adr/ADR-0001-stack.md` with its `README.md`, and
`.claude/skills/.focus-kit-language` reading `pt-BR`. The documents are in
Brazilian Portuguese, headings included, and `docs/05-Process.md` opens §6
with `**Tool.** The browser tool.` and §7 with `**Strategy.** A worktree per
delivery.`, which are the two slots whose first line a command reads.
`CLAUDE.md` came out with the four commands named, the Practice answers and
the verify command. The run ended with `git add -A`, as it says it does.
`doctor` in the scratch names no drift on the four prompt files: a full
`/initialize` run left them exactly as `install` wrote them.

**Two divergences, and the transform is not the cause of either.** A `diff`
of `skills/initialize/SKILL.md` against the generated
`.github/prompts/initialize.prompt.md`, the frontmatter aside, is exactly
ten lines and every one of them is one of the five substitutions. The
instructions below reached the host word for word and the host did not
follow them. Whether Claude Code follows them is not what this run tested.

1. **The questions came out in English.** Lines 53 to 66 of the skill name
   six texts that are conversation and not document and must reach the
   person in the conversation's language, the Language question of Step 0
   first among them. The person wrote in Portuguese, the host's own prose
   answered in Portuguese, and every question card was in English. The
   answers the person picked were in Portuguese, so the documents came out
   right; what was wrong was the asking.
2. **The three manuals were not translated.** The language record says
   `pt-BR` and `docs/manuals/*.md` are still the English files the kit
   ships, which is the step `manuals-follow-the-language` added one delivery
   ago. `doctor` names all three, with `/initialize` as the fix, so the kit
   reports the gap rather than hiding it, and that is the mechanism working.

Both become `/discuss` lines. Neither is fixed here: the page touches no
skill, and what to do about a host that skips an instruction is a product
decision and not a substitution.

**Three smaller findings.**

* The three divergences predicted above were all reachable and one was
  reached: `**Tool.** The browser tool.` is in the scratch's
  `docs/05-Process.md`, which is the substituted option label landing in a
  target's own document, where it reads correctly.
* The graph procedure ran and left `graphify-out/cache/` without a
  `graph.json`. `doctor` names the missing graph with the command that
  builds it. Not read further: a graph the run did not build is the
  procedure's own branch and not this delivery's.
* `${input:arguments}` is not exercised by `/initialize`, which takes no
  argument. The placeholder is unproven under a real run and is recorded as
  such rather than claimed.
