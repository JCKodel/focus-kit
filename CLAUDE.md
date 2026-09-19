# focus-kit

The installable delivery process (propose/apply) plus the FOCUS
architecture reference, for repositories worked on with Claude Code. This
repository is the kit, not a project that uses it.

Prose in English; identifiers in English. Everything here is in English,
including every string the kit ships, because a target repository chooses
its own documentation language and the kit's text sets the example.
Detail in docs/04-Conventions.md §1.

No em dash anywhere: the kit forbids it in user-facing text, and the kit's
own text sets the example.

## Read before acting
- the product: docs/00-Product.md · the vocabulary: docs/03-Domain.md
- how it is built: docs/01-Architecture.md · the server: docs/02-Backend.md (none)
- style and tests: docs/04-Conventions.md · process: docs/05-Process.md
- queue: docs/06-Queue.md · decisions: docs/adr/ · manuals: docs/manuals/
- the codebase graph: graphify-out/ (who depends on what goes to it, text goes to grep; docs/manuals/graphify.md)

## Layout
- `bin/focus-kit`: the CLI. bash 3.2 (macOS default); no associative
  arrays, no `mapfile`. JSON merging goes through python3. Why:
  docs/adr/ADR-0001-bash-and-python3.md. The functions: docs/01-Architecture.md §3.
- `skills/<name>/SKILL.md`: the commands copied into target repos. The CLI
  names none of them: it reads the folders (`kit_skills`), so a fifth is a
  folder and no edit.
  Frontmatter `description` uses a `>-` block: a bare colon in the value
  breaks the YAML and the skill silently disappears (docs/04-Conventions.md §3).
- `skills/initialize/templates/`: what `/initialize` fills. Guidance to the
  command lives in `<!-- init: ... -->` comments, which it removes.
- `manuals/`: kit-owned files copied to `docs/manuals/` of every target.
- `config/`: the settings baseline and the two fragments, merged or appended
  on install. `merge_json` takes two paths, never source, so a baseline may
  hold any JSON escape.
- The whole tree, and which part owns what: docs/01-Architecture.md §4.

## Non-negotiables
- One delivery = one page in work/<slug>.md. /discuss to put the line in the
  queue, /propose to define, /apply to build. /discuss owns the queue's
  lines, with one narrow exception: /propose and /apply write what they found
  and did not build under "Found, not discussed", which is the antechamber of
  a line and not a line (`docs/manuals/process.md` §The queue).
- Every file is kit-owned, project-owned, merged or appended once. Kit-owned
  files are overwritten on `focus-kit update`; project-owned files (`docs/00`
  to `06`, `CLAUDE.md`, `docs/adr/`, `work/`) are never touched by the CLI.
  Keep that line sharp (docs/adr/ADR-0002-file-ownership.md).
- The skills are stack-agnostic. Anything project-specific (verify
  command, environments, publish policy, git policy, proof) is a slot in
  `docs/05-Process.md`, filled by `/initialize`, read by `/apply`.
- FOCUS (docs/manuals/focus.md) is what the kit teaches, not how the kit is
  built. Do not refactor `bin/focus-kit` into four pieces for consistency
  (docs/adr/ADR-0003-focus-is-taught-not-applied-here.md).
- Errors are values. In bash that is `warn` for a failure inside the flow and
  `die` for a defect (docs/01-Architecture.md §6).
- No em dash in any text a user reads, and none anywhere in this repository.
- The agent stages (`git add`) and suggests the commit message. It never commits.

## How to work
- Verify: `bin/focus-kit selftest` before declaring anything done. Six checks,
  a few seconds, no arguments; what each one is: docs/05-Process.md §4.
- Bump `VERSION` on any change a target repo would want: a skill, a manual, a
  template, or the CLI's behaviour. Not for this repository's own docs.
- Any delivery that touches `skills/` or `manuals/`, or bumps `VERSION`, ends
  by running `focus-kit install .` here, so the dogfood copy in
  `.claude/skills/` and `docs/manuals/` matches its source, at its version
  (docs/05-Process.md §5).
- Ambiguity → AskUserQuestion. Abstraction on the second concrete
  occurrence, and the delivery says which was the first.
- Docs are living: a delivery that changes behaviour updates the doc that
  owns it, in the same delivery.
