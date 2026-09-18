# ADR-0007: a port to another host is generated, never authored

**Status:** accepted
**Date:** 2026-09-18

---

## Context

The kit's four commands are four `SKILL.md` files, read by Claude Code out
of `.claude/skills/`. Another host reads another tree: GitHub Copilot reads
`.github/prompts/<name>.prompt.md`, and Codex will read something else
again. `copilot-port` is the first delivery that puts the same four commands
in front of a second host, and `codex-port` is queued behind it.

The four skills are not short. Measured at `92554bd`, when
`work/copilot-port.md` was written, they were 9,162 words; measured at
`1330acb`, one delivery later, 9,772. That delivery
(`manuals-follow-the-language`) touched `/initialize` alone and moved the
total by 610 words, which is the size of the problem: the skills change in
most deliveries, and they change in one place today.

A second tree of the same text is a second place. The kit already has a
name for what happens then, and a command that reports it: Drift. The
difference is that Drift inside a target is repaired by `focus-kit update`,
while drift between two hand-written sources in this repository is repaired
by somebody noticing.

## Decision

**A host's command files are generated from `skills/<name>/SKILL.md` at
install time, by `render_prompt`, and are never authored beside them.**

* One file per Command, one per folder `kit_skills()` names. A fifth
  command is a folder under `skills/`, and every host gains it with no edit.
* The body of the `SKILL.md` reaches the generated file word for word,
  except for a fixed substitution list: one pair per thing the text names
  that belongs to Claude Code and to no other host. The list lives in
  `render_prompt` and nowhere else, and a later edit to a skill has to
  respect it.
* What every target has whatever its host is not in the list. `CLAUDE.md`
  is not, because the Host instructions file points at it instead of
  replacing it (`copilot-reads-the-project-rules`);
  `.claude/skills/initialize/templates/` is not, because the install writes
  it in every target at that path.
* The generated files are kit-owned: overwritten on every `install` and
  `update`, in the manifest, and reported by `doctor` in the wordings Drift
  already has. The directory that holds them is not: it is where a person
  keeps their own prompts, and the install writes its own files into it and
  removes nothing, the way `docs/manuals/` works.
* The transform is deterministic over the same `skills/` tree, which check
  3 of the verify command asserts and the Manifest's fingerprints depend on.

## Consequences

**Easier.** One edit to a skill moves every host. `codex-port` inherits the
mechanism and adds a directory, a file name and a substitution column, not a
second copy of 9,772 words. A fifth command is a folder.

**Harder.** The substitution list is a constraint on how the skills may be
written. A sentence whose sense depends on a Claude Code specific that the
list does not name reaches the other host wrong, and nothing catches it: the
verify command proves the transform is deterministic, not that its output is
true. `copilot-port` found two such sentences and recorded them
(`work/done/copilot-port.md`).

**Forbidden.** Writing a prompt file by hand into `.github/prompts/`, in
this repository or in a target. Check 6 compares every one of this
repository's against a regeneration from `skills/`, and it is red the moment
the two differ.

**To revisit.** When a host needs a command the others do not have, or needs
one of them said differently rather than substituted. That is the first
thing this decision does not cover, and the delivery that meets it names it.

## Alternatives considered

* **A hand-written tree per host**, `prompts/<name>.prompt.md` beside
  `skills/<name>/SKILL.md`. It lost on the number above: 9,162 words to keep
  in step at the moment the decision was taken, 9,772 one delivery later,
  and a third copy waiting in `codex-port`. Nothing in the kit would have
  reported the two drifting apart, because both would have been sources.
* **One source in a neutral format**, with every host generated from it.
  It is the same mechanism with one more file per command and a format
  nobody reads directly. The `SKILL.md` is already the neutral format: what
  is host-specific in it is five strings, which is what the list says.
* **Generating at build time and versioning the result alone.** There is no
  build here, and the verify command would then compare a generated file
  with nothing. The generation happens at install, and this repository holds
  its own copy the way it holds the rest of the Dogfood copy.
