# open-source-license

**Goal.** Anyone who finds focus-kit on GitHub sees on the repository page
which license it carries, and every copy the kit makes of itself names that
license and its author.

**Behaviour.**

* GitHub's sidebar reads `AGPL-3.0 license` once the commit is pushed. The
  detection is licensee against the 47 texts of choosealicense.com at 98%
  similarity, so `LICENSE` is the verbatim text and nothing else.
* Every kit-owned file a target receives (three manuals, three skills)
  carries one line naming the copyright holder, the license and the source
  repository. `bin/focus-kit --help` prints the same line.
* `README.md` says how to obtain terms outside the AGPL, and that the
  documents the three commands write into a target belong to that target.
* `docs/adr/ADR-0004` records why AGPL-3.0-only and dual licensing, and why
  a non-commercial license lost.
* `bin/focus-kit selftest` stays green. `LICENSE` is outside check 5's
  scope, but `CLAUDE.md` forbids the em dash anywhere in this repository,
  and the AGPL text contains none (counted before this page was written).

**Contract.**

`LICENSE`, at the root of this repository, project-owned: the CLI never
reads or copies it. Its content is the `body` field of
`https://api.github.com/licenses/agpl-3.0`, byte for byte, with no header,
no copyright line and no trailing addition. That is what GitHub's own
license picker writes, so the match is 100%.

The notice, one line, identical everywhere it appears:

```
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->
```

Where it goes: in `manuals/*.md`, line 2, right under the kit-owned banner.
In `skills/*/SKILL.md`, the first line after the closing `---` of the
frontmatter, so check 4 of the verify command is untouched. In
`bin/focus-kit`, line 2 of the header comment, as `# Copyright (C) 2026 J.C.
Ködel. Licensed under AGPL-3.0-only. Source and terms:
https://github.com/JCKodel/focus-kit`; the header grows by one line, so the
`--help` `sed` range moves from `2,27p` to `2,28p`, and
`help-text-follows-header` still owns the real fix. Templates get no notice:
their text is what `/initialize` writes into a target, and the folder's
`SKILL.md` carries the line.

`README.md` gains a `## License` section, before "Layout of this
repository", with three paragraphs and no more: (1) focus-kit is licensed
under the GNU Affero General Public License, version 3 only; a fork stays
under the same terms, keeps the copyright notices, and use over a network
counts as distribution. (2) Additional permission under AGPL-3.0 section 7:
the documents that `/initialize`, `/propose` and `/apply` write into a
target repository (`docs/00` to `06`, `docs/adr/`, `CLAUDE.md`, `work/`)
are not covered works of focus-kit and belong to that repository under
whatever license its owner chooses; the kit-owned copies in
`.claude/skills/` and `docs/manuals/` remain under the AGPL, and holding
them in a repository is aggregation, which does not extend the AGPL to that
repository's own code. (3) Terms outside the AGPL, for anyone who wants to
use or redistribute the kit without its obligations, are granted only by
the author, J.C. Ködel, on request through this repository's GitHub issues.

`docs/adr/ADR-0004-agpl-and-dual-licensing.md` from the template, status
accepted, plus its row in `docs/adr/README.md`. Alternatives, one line each:
AGPL-3.0-or-later (lets a future FSF text change the terms without the
author's decision), GPL-3.0 (no network clause, so a hosted product
escapes), CC-BY-SA-4.0
(content license, no patent grant, odd for a CLI), non-commercial licenses
such as CC-BY-NC-SA, PolyForm and BUSL (none detected by GitHub, and they
bar the audience `docs/00-Product.md` names), MIT and Apache-2.0 (permit a
closed paid fork, which is the thing to prevent).

`VERSION` goes to `0.3.1`: the six kit-owned files change and a target
would want the copies to carry the line, but no behaviour changes.

**Slice.** `LICENSE`, `README.md`, the ADR, and `docs/00-Product.md`
(Positioning: one sentence on the license), `docs/01-Architecture.md` §4
(the tree gains `LICENSE`): all project-owned. `docs/03-Domain.md` already
has the two rows, License and License notice, added by this page. The three manuals and three skills: kit-owned, so the dogfood
copy is resynced with `focus-kit install .`. `bin/focus-kit`: the CLI, never
copied. No FOCUS piece appears (ADR-0003).

**States.** The defaults. `install`, `update` and `doctor` print nothing
new; `doctor` does not check for `LICENSE` in a target because no target
receives it.

**Visual reference.** No UI. What proves the text is detectable, without
pushing:

```
curl -s https://api.github.com/licenses/agpl-3.0 | python3 -c 'import json,sys; sys.stdout.write(json.load(sys.stdin)["body"])' | diff - LICENSE && echo identical
```

**Out of scope.**

* A non-commercial restriction. Not detectable by GitHub and it bars every
  company from using the kit in its own repositories; decided in this
  page's conversation, recorded in ADR-0004.
* A CLA or DCO. Dual licensing needs the author to hold rights over
  contributions; there is no second contributor yet, and it is its own
  decision.
* A kit-owned banner on the skills beyond the license line. The "Later"
  entry in `docs/06-Queue.md` stays; the license line is not that banner.
* Legal review. This page is research, not advice; the ADR says so.

**Done when.**

* [x] `LICENSE` exists and the `diff` above prints `identical`.
* [x] The notice line is on `manuals/*.md:2`, on the first line after the
  frontmatter of the three `SKILL.md`, and on `bin/focus-kit:2`; `focus-kit
  --help` prints it and still ends on `supply a python.`.
* [x] `README.md` has the `## License` section with the three paragraphs;
  `docs/00`, `docs/01` §4, `docs/03` and `docs/adr/README.md` updated;
  ADR-0004 written.
* [x] Every `bin/focus-kit:NN` citation points at the line it names, since
  the header gained a line: `grep -rn 'bin/focus-kit:' docs CLAUDE.md
  README.md` minus `docs/manuals/`, each hit checked.
* [x] `VERSION` is `0.3.1`; `focus-kit install .` run here.
* [x] `bin/focus-kit selftest` prints six `ok` lines and exits 0.
* [x] Environments: kit source at 0.3.1, dogfood copy in sync, machine
  follows the symlink, targets untouched until their owner runs
  `focus-kit update`.

---

## What happened

Built as written. `LICENSE` came from the API body itself rather than being
retyped, so the proof command is the same bytes compared against their
source, and it printed `identical`. The AGPL text contains no em dash, as
the page said, and `LICENSE` sits outside check 5's paths anyway.

**Diverged from the plan, two things, both small.**

The page said `--help` still ends on `supply a python.`; the real last line
is `supply a python).`, closing a parenthesis the page dropped when quoting
it. What the command produced wins (`docs/05-Process.md` §6), and nothing
was changed in the script for it.

`docs/04-Conventions.md` gained a row in the §2 names table, "License
notice", which the page's Slice did not name. The reason is the row next to
it: the table already declares the kit-owned banner and says the three
`SKILL.md` files carry none, which is now half the picture, because they do
carry the notice. Docs are living and the doc that owns the fixed strings is
that one. The same file also needed two edits the page did anticipate: the
help bullet reads "lines 2 to 28" and its `sed` citation moved.

**Nothing was dropped.** The out-of-scope list held: no non-commercial
restriction, no CLA or DCO (ADR-0004 names it as the trigger for a revisit),
no kit-owned banner on the skills, no legal review, and the ADR says in its
own text that it is research rather than advice.

**Decisions.** `docs/adr/ADR-0004-agpl-and-dual-licensing.md`, accepted,
with the six alternatives one line each and the CLA deferral written into
"revisit when". Its "forbidden" section carries the operational half of the
decision: a kit-owned file without the notice, and any edit to `LICENSE`
that is not a replacement by another verbatim text, because one added byte
breaks the 98% match the choice was made for.

**The proof.** The verify command is green, six `ok` lines, exit 0. Check 6
is what proves the dogfood copy carries the notice: `diff -r skills
.claude/skills` and `diff -r manuals docs/manuals` are empty after
`focus-kit install .`. The citation sweep was run as a list rather than by
eye: every `bin/focus-kit:NN` in `docs/` and the ADRs was incremented by one
and then printed next to the line it now points at. All thirteen match.
GitHub's sidebar cannot be checked without pushing, which this delivery does
not do; the `diff` against the API body is the whole of what is checkable
here.

**One thing left stale on purpose.** `work/graph-rebuilds-on-demand.md`, the
other delivery in flight, cites `bin/focus-kit:204` and `206-209`. The
header grew by one line, so those are off by one and read 205 and 207 to 210
now. It is another delivery's page and outside the sweep this one owns, so
it was not edited; whoever applies that page corrects them there.

**The graph was not consulted.** The graphify MCP server failed to connect
in this session. The slice was enumerated exhaustively in the page, so
nothing was guessed for want of it.

**Environments.** Kit source at 0.3.1. Dogfood copy in sync, check 6 empty.
Machine follows the symlink, `focus-kit version` prints 0.3.1. Target
repositories untouched; they move when their owner runs `focus-kit update`,
and nothing is pushed here.
