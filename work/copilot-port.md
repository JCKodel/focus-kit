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

* `bin/focus-kit selftest` green, six checks.
* Check 3 green with the transform in place, which is the determinism
  assertion.
* The Dogfood copy in sync, the generated files included: `focus-kit install .`
  run here (`docs/05-Process.md` §5).
* `VERSION` bumped: a target receives files it did not have.
* One generated command run under GitHub Copilot in a scratch repository, by
  the person and not by `/apply`, which stops there and asks for the
  transcript; what it produced is recorded in `work/done/copilot-port.md`,
  every divergence from this page included, the way `docs/05-Process.md` §6
  requires.
* `docs/01-Architecture.md` §3, §4 and §5, `docs/03-Domain.md`,
  `docs/05-Process.md` §4 and §5, and `docs/adr/ADR-0007` written.
* The environments of `docs/05-Process.md` §5 in the state that table
  requires.
