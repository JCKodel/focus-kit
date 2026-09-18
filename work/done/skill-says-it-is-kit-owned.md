# skill-says-it-is-kit-owned

**Goal.** Someone who opens a `SKILL.md` inside a target repository is told,
before the first instruction, that the file is the kit's and that the next
`focus-kit update` overwrites whatever they change in it.

**Behaviour.**

* Each of the four `skills/<name>/SKILL.md` carries the Kit-owned banner as
  the first line after the frontmatter's closing `---`, ahead of the License
  notice each of them already has. That is the manuals' own order, banner
  first and notice second, at the only position a `SKILL.md` allows: a
  comment above line 1 is not valid YAML, and check 4 dies when line 1 is
  not `---` (`docs/adr/ADR-0002-file-ownership.md`).
* The banner is the line the three manuals carry, the same bytes, so a
  reader who has seen `docs/manuals/process.md` recognizes it and the kit
  has one wording for one rule.
* Nothing the CLI does changes, and nothing any command says changes. The
  banner is a line in a file `copy_tree` already copies.
* `doctor` still reports an edited `SKILL.md` as drift, as it does today.
  What is new is that the person was warned before they made the edit, not
  after.

**Contract.**

* `skills/apply/SKILL.md`, `skills/discuss/SKILL.md`,
  `skills/initialize/SKILL.md` and `skills/propose/SKILL.md`: one line
  inserted immediately after the frontmatter's closing `---` and immediately
  before the License notice line each already holds. Nothing else in any of
  the four files is touched, and no sentence of any body is quoted here.
* The line is the Kit-owned banner (`docs/03-Domain.md`), taken from
  `manuals/process.md` line 1 rather than retyped, so the kit does not grow a
  second wording of it.
* `bin/focus-kit`: unchanged. No verb, no message, no check.
  `check_frontmatter` breaks its loop at the closing `---`, so the new line
  is never read by it, and the verify command gains nothing: the License
  notice is the same shape on the same four files with no check either, and
  `docs/00-Product.md` product question 6 has no error to name. Decided in
  this page's conversation.
* `docs/adr/ADR-0002-file-ownership.md`: a dated paragraph inside the
  Kit-owned bullet of Decision, in the shape of the
  `mcp-leaves-the-baseline` paragraph already there. It says that the four
  `SKILL.md` files now carry the banner, that the ten templates of
  `skills/initialize/templates/` still do not, and that the Forbidden clause
  stands as written. The 2026-09-15 text is not rewritten, its "three"
  included.
* `docs/03-Domain.md`: the **Kit-owned banner** row, written by this
  `/propose`. `/apply` makes the **Kit-owned** row's sentence about the two
  data files point at it instead of naming a banner that has no row.
* `VERSION` is bumped: a target receives four changed kit-owned files.
* Independent of `work/git-strategy-is-asked.md`, which edits the body of
  all four `SKILL.md`. This delivery inserts one line at a fixed position
  above every body, so the two land in either order. Its one edit to
  `docs/06-Queue.md` is this line's mark and nothing else, because that file
  is already dirty in this tree with the other delivery's work.

**Slice.** The content `bin/focus-kit` moves, not the CLI
(`docs/01-Architecture.md` §3, Structure, and §4). The graph named
`bin/focus-kit` and nothing else for both nodes, and nothing in it changes.
No View, Orchestrator, Use case or Repository: §3 says none of the four
exists here. Kit-owned: the four `SKILL.md` files. Project-owned: this
repository's `docs/03`, `docs/06` and `docs/adr/ADR-0002`.

**States.**

* A target at this version: every installed `SKILL.md` opens with the
  banner, then the License notice, then the body.
* A target below this version: `doctor` prints the stale line it prints
  today, naming `focus-kit update`, and nothing about the banner.
* A `SKILL.md` someone already edited inside a target: drift, reported the
  way it is reported today. The banner does not undo the edit and does not
  change the warn.
* Claude Code reads the banner as body text of the skill, the way it already
  reads the License notice on the line below it.
* The kit's own output: unchanged. `install`, `doctor` and `selftest` print
  what they printed, at the new version.

**Visual reference.** No UI, and no line of the CLI changes. The first lines
of a `SKILL.md` after this delivery, with the frontmatter abridged:

```
---
name: propose
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>
---
<!-- kit-owned: ... -->
<!-- Copyright (C) 2026 ... -->
```

**Out of scope.**

* A check in `selftest` that the banner is there: no error has happened, and
  the notice beside it has no check either.
* The ten templates under `skills/initialize/templates/`: the queue line
  says each `SKILL.md`, and a banner in a template would reach a target's own
  `docs/00-Product.md` unless `/initialize` stripped it the way it strips an
  Init comment. It is a `/discuss` line, not this delivery.
* Changing ADR-0002's Forbidden clause to except the templates: a rule
  change the queue line did not order, so the amendment records the gap
  instead.
* The two data files: ADR-0002 already excepts data `doctor` reads.
* `an-old-target-gets-the-fragment` and `update-survives-a-moved-section`:
  the other two lines of this milestone, each a different mechanism.

**Done when.**

* [x] `bin/focus-kit selftest` is green, six checks.
* [x] Each of the four `skills/<name>/SKILL.md` carries the banner as its first
  line after the frontmatter, ahead of the License notice, and no other line
  of the four moved.
* [x] A `focus-kit install .` into a scratch repository leaves all four
  installed `SKILL.md` carrying the banner, and the transcript goes into
  `work/done/skill-says-it-is-kit-owned.md` (`docs/05-Process.md` §6).
* [x] `docs/adr/ADR-0002-file-ownership.md` carries the dated amendment, and
  `docs/03-Domain.md` carries the **Kit-owned banner** row with the
  **Kit-owned** row pointing at it.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy carries the change (`docs/05-Process.md` §5).

---

## What happened

Built as the page defined it. The banner was inserted by reading
`manuals/process.md` line 1 into a variable and letting one `awk` pass put
it after the first `---` it meets past line 1, so the bytes were never
retyped and the closing line was never hardcoded: it is line 7 in `apply`,
`discuss` and `propose` and line 9 in `initialize`. `git diff --stat
skills/` shows `1 +` and nothing removed for each of the four.

`bin/focus-kit` was not touched, as the Contract required. Check 4 reads
the frontmatter and breaks at the closing `---`, so it never sees the new
line, and it stayed green without an edit.

## What diverged from the plan

**One doc the Contract did not name.** `docs/04-Conventions.md` §2 held two
rows that this delivery makes false: the **Kit-owned banner** row said the
`SKILL.md` files do not carry one, and the **License notice** row said the
notice is the first line after the frontmatter of a `SKILL.md`, which is now
the second. Both were rewritten. The first row now says the banner is taken
from `manuals/process.md` line 1 rather than retyped, which is the rule the
Contract states and which no convention held before. The second names the
banner as what it follows.

The rows were a description of the state, not a rule forbidding the change,
and the queue line ordered that state to change, so the doc changed with the
delivery rather than the delivery being wrong (`docs/05-Process.md` §2,
`/apply` updates the docs the delivery changed). Nothing else in the kit
stated the position: a grep for `banner` over `README.md`,
`docs/00-Product.md`, `manuals/` and `skills/` came back with nothing, so no
kit-owned file went stale and no target receives a contradiction.

**`VERSION` is `0.25.1`, a patch.** The page left the number to the run.
The precedent read from `git log -p -- VERSION`: a minor bump goes with new
behaviour a target can invoke (`0.23.0` `discuss-adds-queue-line`, `0.24.0`
`queue-line-finds-its-place`, `0.25.0` `git-strategy-is-asked`), a patch
with a change to the text of a skill and nothing else (`0.22.4`
`as-written-covers-a-literal`, `0.22.5` `run-ignores-a-stray-word`). This is
one line of text in four skills, no verb, no message and no check, so it is
a patch.

## What was dropped

Nothing. Everything under Out of scope stayed out: no check in `selftest`,
no banner in the ten templates, no change to ADR-0002's Forbidden clause.

## The proof

`docs/05-Process.md` §6 asks for an install into a scratch repository, which
is check 2, plus a real run for a change to a skill. This delivery changes
no instruction any command follows, so the run that proves it is the install
itself: what a target receives is the line, at the top of the file, and a
session that opens the skill reads it before the first instruction.

A `mktemp -d` with `git init`, then `focus-kit install`:

```
installing focus-kit 0.25.1 into /var/folders/.../tmp.QM5JmzjUY7
  ✓ .claude/skills/{apply,discuss,initialize,propose}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ .claude/skills/.focus-kit-manifest
  ✓ work/done/
  ✓ .claude/settings.json (baseline permissions merged)
  ✓ .gitignore (kit fragment appended)
  ✓ .graphifyignore (kit fragment appended)
```

All four installed `SKILL.md` open the same way, `initialize` at line 9
instead of 7 because its frontmatter carries two keys more:

```
7:---
8:<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
9:<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->
```

`focus-kit doctor` in that scratch printed `✓ kit version 0.25.1`, `✓
kit-owned files as install wrote them`, the four skill lines green, and the
ten warnings a repository `/initialize` never ran in is expected to
produce. The scratch was left on disk at
`/var/folders/09/f_09y2b90h3_bpd38q1nfbmr0000gn/T/tmp.QM5JmzjUY7`, because
the `rm -rf` that would have removed it was declined; it is a `mktemp -d`
outside the repository and removing it is a hand step. The scratch check 2
and check 3 create is a different one and its own `trap ... EXIT` removed
it.

Then `focus-kit install .` here and the verify command:

```
focus-kit 0.25.1 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

## Decisions

No ADR. The decision is ADR-0002's and was already taken there; what this
delivery adds is the dated amendment inside its Kit-owned bullet, in the
shape of the `mcp-leaves-the-baseline` paragraph beside it. The 2026-09-15
text is untouched, its "three" included, because an ADR records what was
decided when it was decided.

`docs/03-Domain.md` needed one word: the **Kit-owned** row said the two data
files "carry no banner", which named a thing with no row when `/propose`
wrote it. It now says "no Kit-owned banner" and points at the row.

## Environments

| Environment | State |
|---|---|
| Kit source (`skills/`, `manuals/`, `config/`, `bin/`) | 0.25.1, the truth. Four `SKILL.md` carry the banner; `bin/focus-kit`, `manuals/` and `config/` unchanged. |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.25.1. `focus-kit install .` was run; `.claude/skills/.focus-kit-version` reads `0.25.1` and check 6 is green. |
| Machine (`~/.local/bin/focus-kit`) | untouched. A symlink to the kit source, so `focus-kit version` prints `0.25.1`. The global `/graphify` skill is at the package's version, 0.9.63, which `install` reported green. |
| Target repositories (anyone else's) | untouched, one version behind. They move when their owner runs `focus-kit update <path>`. |
| First target (`~/Downloads/vaulted`) | not updated, and not required to be: every line of milestone 2 in `docs/06-Queue.md` is `[x]`, and `docs/05-Process.md` §5 says the row leaves with that milestone. |

The git strategy is none (`docs/05-Process.md` §7), so `git add -A` stages
what is in the tree. Besides this delivery it stages the other delivery's
`[x] ~~git-branches-are-queue~~` line in `docs/06-Queue.md`, already dirty
before this session, and the two untracked pages
`work/an-old-target-gets-the-fragment.md` and
`work/update-survives-a-moved-section.md`. That is the cost §7 names, not a
failure of this run.
