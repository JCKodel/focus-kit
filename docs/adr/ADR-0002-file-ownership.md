# ADR-0002: Every file is kit-owned, project-owned, merged or appended once

**Status:** accepted
**Date:** 2026-09-15

---

## Context

The kit writes into repositories it does not own, and it has to be able to
do it twice. An update has to deliver a corrected skill without asking, and
it must never destroy a document somebody spent an afternoon on.

Those two requirements pull in opposite directions, and the usual answers
are bad. Ask on every file and the update becomes a questionnaire nobody
reads to the end. Overwrite everything and the first update costs someone
their `CLAUDE.md`. Merge everything and the merge logic becomes the largest
part of the program, with a heuristic per file type.

The way out is to decide ownership once, per file, at the point the file is
introduced, so the script never has to work it out at runtime.

## Decision

Every file the kit writes belongs to exactly one of four categories, and the
category determines the write:

* **Kit-owned**, written with `copy_tree` (`bin/focus-kit:111`): the
  destination is removed and copied over. The three skills and the three
  manuals. Editing one inside a target is a change the next update erases.
  Each manual carries a banner saying so on its first line; the three
  `SKILL.md` files do not, because their first line is YAML frontmatter and
  a comment above it is not valid. Warning the reader there is a gap, and a
  queue line (`docs/06-Queue.md`).
* **Project-owned**, never written by the CLI at all: `docs/00` to `06`,
  `CLAUDE.md`, `docs/adr/`, `work/`. Only `/initialize` touches them, and it
  merges rather than overwriting. The CLI's single interaction with this
  category is testing whether `docs/00-Product.md` exists, to choose which
  closing message to print (`bin/focus-kit:196`).
* **Merged**, written with `merge_json` (`bin/focus-kit:117`): `.mcp.json`
  and `.claude/settings.json`. Keys are added; nothing is ever removed.

  **2026-09-17, `mcp-leaves-the-baseline`:** `.mcp.json` is no longer one of
  them; `.claude/settings.json` is the only merged file, and the carve-out
  that replaced the `mcpServers` entry whole left with the baseline that
  needed it. "Nothing is ever removed" is what makes an entry the kit stops
  shipping survive every `update`, which is why `doctor` gained the Leftover
  warns and why the person, not the CLI, takes it out.
* **Appended once**, guarded by a marker: `.gitignore`, guarded by
  `# --- focus-kit ---`.

There is no fifth category. A delivery that adds a file to a target declares
which of the four it is, in the delivery page's Contract section.

## Consequences

Easier: `focus-kit update` is safe to run at any time without reading the
diff first, which is what makes shipping a fix to the kit cheap. The
question "will this overwrite my work?" has a one-word answer for every
path. `doctor` can check installation without understanding content.

Harder: the line has to be defended. A kit-owned file that someone wants to
customize per project cannot be customized; the variation has to become a
slot in that project's `docs/05-Process.md` instead. That is a real
constraint on skill design, and it is the reason the three skills name no
language, framework or test runner.

Forbidden: a write that removes a key from a merged file; an edit to a
project-owned file from the CLI; a kit-owned file without its banner, unless
it is data `doctor` reads; a second marker style for appended content. The
qualifier covers exactly two files, `.claude/skills/.focus-kit-version` and
`.claude/skills/.focus-kit-manifest`: a banner in either one would be a line
the reader has to skip, and neither is a document anybody opens.

Revisit when: a kit-owned file needs to change shape between versions in a
way that makes a target's documents point at a section that no longer
exists. There is no migration notion today, and that gap is open decision 5
in `docs/00-Product.md`.

## Alternatives considered

*Inferred from the shape of `install_repo` and the ownership rule stated in
`CLAUDE.md` and `README.md`. No record of the deliberation exists, and the
date above is the commit date of `06e923f`, not a recorded decision date.
The stakeholder confirms or amends.*

* **Overwrite everything, tell people to keep their edits elsewhere.** Lost:
  it makes the first update a data-loss event.
* **Three-way merge per file, like a scaffolding tool.** Lost: it turns the
  installer into a merge engine, with a conflict story to design and a
  failure mode in every file type.
* **Ask per file.** Lost: an update that asks twelve questions is an update
  people postpone, and a postponed update is a target running a known-broken
  skill.
* **Put everything the kit owns under one directory the project agrees not
  to touch.** Lost in part only: it is what `.claude/skills/` and
  `docs/manuals/` already are, but `.mcp.json`, `.claude/settings.json` and
  `.gitignore` have to live where their tools look for them, so the merged
  and appended categories exist regardless.
