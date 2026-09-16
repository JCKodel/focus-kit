# ADR-0004: AGPL-3.0-only, with terms outside it granted by the author

**Status:** accepted
**Date:** 2026-09-16

---

## Context

focus-kit is published on GitHub and installed by cloning and symlinking. A
repository with no `LICENSE` file is not open source: the default is
exclusive copyright, so nobody may legally fork it, and GitHub's sidebar
says nothing. The kit also copies itself into other people's repositories,
which raises a question no single-repository project has: what happens to a
target repository that holds `.claude/skills/` and `docs/manuals/` inside a
tree of its own, and to the documents the three commands write there.

Two things were true at the same time and pulled in opposite directions.
The audience `docs/00-Product.md` names is a developer working in their own
repository, often a company one, and anything that bars commercial use bars
that audience. The thing worth preventing is different: a closed paid fork
of the kit, sold as a product, with no obligation to return anything.

The author holds the rights to every line in this repository. There is no
second contributor.

## Decision

**AGPL-3.0-only**, the text verbatim from
`https://api.github.com/licenses/agpl-3.0`, in `LICENSE` at the root, with
no header, no copyright line and nothing appended. GitHub's detection is
licensee matching against the 47 texts of choosealicense.com at 98%
similarity, so the verbatim body is what makes the sidebar read
`AGPL-3.0 license`. `LICENSE` is project-owned: the CLI never reads it and
never copies it, because a target repository receives the kit, not the
kit's terms for itself.

**One notice line, identical everywhere**, in every kit-owned file a target
receives (the three manuals, the three `SKILL.md`) and in the CLI's header,
where `--help` prints it. A copy of the kit names its author and its terms
wherever it is read, which is the whole reason a notice exists.

**Terms outside the AGPL are granted only by the author**, on request
through this repository's GitHub issues. That is what holding the rights
buys: the same code can be licensed twice, once to everyone under the AGPL
and once to whoever wants it without the obligations. It is stated in
`README.md` so that the question does not have to be asked to be answered.

**An additional permission under section 7** settles the target
repository's position: the documents that `/initialize`, `/propose` and
`/apply` write there are not covered works of focus-kit and belong to that
repository. The kit-owned copies stay under the AGPL, and holding them is
aggregation, which does not reach that repository's own code.

This ADR is research, not legal advice. It records why the choice was made
and what was weighed, and a lawyer has not read it.

## Consequences

Easier: the repository is legally forkable, GitHub says under what, and a
company can install the kit without asking anyone. The network clause means
a hosted product built on the kit has to offer its source, which is the
case the plain GPL misses.

Harder: the AGPL frightens some companies' policies, and a few will not
install the kit for that reason alone even though installing it is not
distribution. The additional permission and the notice exist to shorten
that conversation, not to win it.

Forbidden: a kit-owned file without the notice line, and an edit to
`LICENSE` that is not a replacement by another verbatim text. A byte added
to the body breaks the detection that the choice was made for.

Revisit when: a second contributor appears. Dual licensing needs the author
to hold rights over every contribution, which needs a CLA or a DCO. That is
its own decision and is deliberately not taken here, because there is
nothing yet to apply it to.

## Alternatives considered

* **AGPL-3.0-or-later.** Lost: it lets a future FSF text change the terms of
  this repository without the author deciding anything.
* **GPL-3.0.** Lost: no network clause, so a hosted product built on the kit
  escapes the only obligation that matters here.
* **CC-BY-SA-4.0.** Lost: a content license with no patent grant, odd for a
  CLI, and its share-alike is written for documents rather than software.
* **A non-commercial license (CC-BY-NC-SA, PolyForm Noncommercial, BUSL).**
  Lost: GitHub detects none of them, and every one of them bars the audience
  `docs/00-Product.md` names, which is a developer inside a company
  repository.
* **MIT or Apache-2.0.** Lost: both permit a closed paid fork, which is the
  one outcome this decision exists to prevent.
