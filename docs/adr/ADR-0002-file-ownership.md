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

* **Kit-owned**, written with `copy_tree` (`bin/focus-kit:271`): the
  destination is removed and copied over. The three skills and the three
  manuals. Editing one inside a target is a change the next update erases.
  Each manual carries a banner saying so on its first line; the three
  `SKILL.md` files do not, because their first line is YAML frontmatter and
  a comment above it is not valid. Warning the reader there is a gap, and a
  queue line (`docs/06-Queue.md`).

  **2026-09-18, `skill-says-it-is-kit-owned`:** the gap is closed for the
  four `SKILL.md` files, which now carry the banner on the first line after
  the frontmatter's closing `---`, ahead of the License notice. That is the
  only position a `SKILL.md` allows: a comment above line 1 is still not
  valid YAML, and check 4 of the verify command dies when line 1 is not
  `---`. The ten templates under `skills/initialize/templates/` still carry
  none, because a banner there would reach a target's own
  `docs/00-Product.md` unless `/initialize` stripped it the way it strips an
  Init comment. The Forbidden clause below stands as written: a kit-owned
  file without its banner is forbidden, the two data files `doctor` reads
  are the only exception, and the templates are a gap this amendment
  records rather than closes.

  **2026-09-18, `update-survives-a-moved-section`:** a kit-owned file may
  change shape between versions, and `update` goes on overwriting it. There
  is no migration notion and there will not be one: a notes file the CLI
  prints for the versions crossed is a file every future delivery has to
  edit, against product question 2. What answers the risk instead is
  `doctor`, which names every citation the change can invalidate: a
  reference from one of a target's repeatedly read documents to a section of
  a Manual, by a number a later section shifts or by a heading the manual no
  longer has. A person fixes each one by hand, because the citing file is
  Project-owned and what the citation meant is only in the sentence around
  it. That closes open decision 5 of `docs/00-Product.md`, which has left
  the list.

  The Project-owned bullet above is superseded on one word. Its "single
  interaction" was a read, and there are two reads now: the same test for
  `docs/00-Product.md`, and the pass, which opens `CLAUDE.md`, `docs/00` to
  `06` and every file under `docs/adr/` and reads them line by line. `work/`
  stays unread, in flight and done both. Nothing else about the category
  moves: Forbidden forbids the edit, not the read, and no write was added.
* **Project-owned**, never written by the CLI at all: `docs/00` to `06`,
  `CLAUDE.md`, `docs/adr/`, `work/`. Only `/initialize` touches them, and it
  merges rather than overwriting. The CLI's single interaction with this
  category is testing whether `docs/00-Product.md` exists, to choose which
  closing message to print (`bin/focus-kit:440`).
* **Merged**, written with `merge_json` (`bin/focus-kit:288`): `.mcp.json`
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

Revisit when: a target needs something of the kit's changed in place rather
than reported. The Leftover warns and the Manual citation warns both end in
a hand edit, and a third category of thing the person has to go and fix is
where the reporting answer stops paying for itself.

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
