# help-names-what-install-writes

**Goal.** A person who types `focus-kit --help` reads every path an install
writes into their repository, including the two the usage text does not name
today.

**Behaviour.**

* `focus-kit --help` names `.graphifyignore` and says it is a kit fragment
  appended once, beside the `.gitignore` line it already has.
* `focus-kit --help` names `.claude/skills/.focus-kit-version` and says which
  version is installed and that `doctor` reads it, in the words the manifest
  line beside it already uses.
* Every path `install_repo` writes into a target appears in the usage text,
  and each one says what it is and how it is written.
* `focus-kit help`, `focus-kit -h` and `focus-kit` with no argument print the
  same block, because they are one case of the dispatch.
* `docs/04-Conventions.md` §1 says the header names every path `install`
  writes, so the next delivery that makes `install` write something new knows
  the header line is part of it.
* `bin/focus-kit selftest` comes back green, unchanged: a comment changes no
  behaviour any of the six checks reads.

**Contract.** The header comment of `bin/focus-kit`, which is the usage text
(`docs/04-Conventions.md` §1: `--help` prints it through `awk`, by a rule and
not a range, so documentation and usage are the same bytes). Item 2 gains two
lines and loses none, each in the position `install_repo` writes it: the stamp
after the skills line it sits under, `.graphifyignore` after the `.gitignore`
line it is appended beside. Item 2 reads, in full, `#` and six spaces, then the
path in a field 44 characters wide, then the description, which is the
alignment the block already has and which neither new path widens, since
`docs/manuals/{process,focus,graphify}.md` stays the longest at 40:

```
#   2. in the target repository:
#      .claude/skills/<command>/                   copied, overwriting (kit-owned)
#      .claude/skills/.focus-kit-version           which version is installed, for doctor (kit-owned)
#      docs/manuals/{process,focus,graphify}.md    copied, overwriting (kit-owned)
#      .claude/skills/.focus-kit-manifest          what install wrote, for doctor (kit-owned)
#      .claude/settings.json                       baseline permissions merged in
#      .gitignore                                  kit fragment appended once
#      .graphifyignore                             kit fragment appended once
#      work/done/.gitkeep                          created if absent
```

*The rule that keeps it true.* One bullet in `docs/04-Conventions.md` §1,
beside the one that already says the help text is the script's own header: the
header names every path `install` writes into a target, so a delivery that
makes `install` write a new one writes that line in the same delivery. A rule
and not a seventh check, for two reasons that are facts and not preferences.
The only enumeration of what `install` writes outside `install_repo` itself is
its own `ok` lines, and the stamp has none: `bin/focus-kit:404` writes it
silently under the skills line, so a check comparing the `ok` output with the
header would have missed exactly the omission this delivery found. And a
seventh check turns "six" into an edit in `docs/05-Process.md` §4,
`docs/03-Domain.md` (Verify command), `docs/01-Architecture.md` §2 and §3,
`docs/00-Product.md` (open decision 1) and line 9 of the header itself, the
shape `discuss-adds-queue-line` already paid for "three". The rule is
pointable by a reviewer on screen, which is what `docs/00-Product.md` product
question 1 asks of a rule.

*The same omission in this repository's own prose.* Two sentences describe
what `install` writes and leave something out, and both are corrected here
because the delivery has them open and the defect is the same one. The
`install_repo` row of `docs/01-Architecture.md` §3, whose list runs "skills,
manuals, the manifest, `work/done/`, the one JSON merge, the two appended
fragments, the closing message", gains the Installed version. The "In the
repository" paragraph of `docs/00-Product.md`, Installing, gains the Installed
version and the Manifest, which it omits both. Those two additions and nothing
else in either sentence. The rule written above binds the header and not these
two: they are this repository's own prose, not the text a user of the CLI
reads.

*`VERSION`.* Bumped, in its patch component, because the CLI's behaviour is a
change a target repository would want (`docs/03-Domain.md`, The kit,
invariants) and `--help` is behaviour. The cost the rule accepts is named
rather than avoided: `bin/focus-kit` is never copied into a target, so no
kit-owned file there changes, every target reports stale by number and
`focus-kit update` rewrites identical bytes. The dogfood install follows the
bump (`CLAUDE.md`, How to work; `docs/05-Process.md` §5), or check 6 goes red.

**Slice.** `bin/focus-kit`, the whole CLI, one file
(`docs/01-Architecture.md` §3, Structure: neither slices nor layers). No View,
no Orchestrator, no Use case and no Repository: §3's second table says none of
the four exists here, so none is named. The graph named one file both ways:
`explain "install_repo"` returned 12 edges and `affected "install_repo"` four
callers, all in `bin/focus-kit`; the header comment has no node, because the
graph holds edges and a comment is text. Kit-owned: `bin/focus-kit`, in the
sense the row of `docs/03-Domain.md` ends on, edited in this repository and
nowhere else, which is what `work/copilot-port.md` already says of the same
file. It is never copied into a target, so nothing there changes; the two
paths it gains name a Kit-owned file and an Appended once file. Project-owned:
`docs/04-Conventions.md`, `docs/01-Architecture.md`, `docs/00-Product.md` and
`docs/06-Queue.md`.

**States.** The defaults. `--help` has no branch: one `awk` over the script's
own header, reached by `""`, `-h`, `--help` and `help` alike, and it neither
reads a target nor touches the network.

**Visual reference.** What `focus-kit --help` prints for item 2, the block
above with the `#` and one following space removed from each line, which is
the `awk` rule:

```
  2. in the target repository:
     .claude/skills/<command>/                   copied, overwriting (kit-owned)
     .claude/skills/.focus-kit-version           which version is installed, for doctor (kit-owned)
     docs/manuals/{process,focus,graphify}.md    copied, overwriting (kit-owned)
     .claude/skills/.focus-kit-manifest          what install wrote, for doctor (kit-owned)
     .claude/settings.json                       baseline permissions merged in
     .gitignore                                  kit fragment appended once
     .graphifyignore                             kit fragment appended once
     work/done/.gitkeep                          created if absent
```

**Out of scope.**

* Item 3 of the header, which says `install` prints the next step and names
  Claude Code while `install_repo` prints one of two messages. Both halves are
  claimed by `copilot-reads-the-project-rules`
  (`work/copilot-reads-the-project-rules.md:67`), which stops the header
  naming one host and is in flight.
* The Ported command line item 2 gains when `copilot-port` lands. That page
  owns what `install_repo` starts writing; the rule written here is what makes
  the header line part of it, and whichever of the two lands second writes it.
* A seventh check of `selftest`, for the two reasons in the Contract.
* `install_repo`'s own `ok` lines, and the stamp's silence among them. A
  different text with a different reader, and no line of this delivery depends
  on it.
* Any change to what `install` writes. The delivery corrects a description and
  adds a rule; the behaviour it describes is already what the script does.

**Done when.**

* [x] `focus-kit --help` prints the block in Visual reference, the two new
  lines included, column-aligned with the six already there.
* [x] `bin/focus-kit --help | grep -cF '.graphifyignore'` and `bin/focus-kit
  --help | grep -cF '.focus-kit-version'` each print `1`.
* [x] `docs/04-Conventions.md` §1 carries the bullet naming the header's
  obligation.
* [x] `docs/01-Architecture.md` §3's `install_repo` row names the Installed
  version, and `docs/00-Product.md`, Installing, names the Installed version
  and the Manifest.
* [x] `bin/focus-kit selftest` is green.
* [x] `VERSION` bumped in its patch component.
* [x] `focus-kit install .` run here, so the dogfood copy carries the new
  version (`docs/05-Process.md` §5).
* [x] `docs/06-Queue.md` line marked `[x]` and the page moved to `work/done/`.

---

## What happened

Built as the Contract defines it, in one pass, with one thing added by the
person in conversation and one thing left alone by the person in
conversation. `VERSION` 0.28.0 to 0.28.1, the patch component the page asked
for.

**The header**, `bin/focus-kit`, item 2. Two lines, each in the position
`install_repo` writes it: `.claude/skills/.focus-kit-version` after the
skills line it sits under, `.graphifyignore` after the `.gitignore` line it
is appended beside. The bytes are the Contract's block, not retyped, and the
alignment claim held: the description field starts at column 50 on all eight
lines, and the longest path is still
`docs/manuals/{process,focus,graphify}.md` at 40, which neither new path
comes near. Nothing else in the script changed.

**The rule**, `docs/04-Conventions.md` §1, one bullet after the one that
already says the help text is the script's own header. It names item 2 as the
whole list, so a delivery that makes `install` write a new path writes that
line in the same delivery, and it carries the two reasons the Contract gives
for a rule rather than a seventh check, with `bin/focus-kit:404` as the
evidence that an `ok`-versus-header check would have gone green on this very
omission.

**The two sentences**, corrected as the Contract names them and no further.
`docs/01-Architecture.md` §3's `install_repo` row now reads "skills, the
Installed version, manuals, the manifest, ..."; `docs/00-Product.md`,
Installing, "In the repository", now says the Installed version is stamped
and the Manifest written over what was just copied. Both use the domain's own
capitalization (`docs/03-Domain.md`, Installed version and Manifest).

## Diverged from the plan

**The line-number citations, added by the person.** The two new header lines
push every line of `bin/focus-kit` below the header down by two, and the page
named nothing about it. Asked in conversation, the answer was to renumber
everything: the 17-row function table of `docs/01-Architecture.md` §3, which
carries 18 numbers because `ensure_uv` and `ensure_graphify` share a row, the
six check line numbers in the paragraph under it, and the 25 inline
`bin/focus-kit:<n>` citations across `docs/00-Product.md`,
`docs/01-Architecture.md`, `docs/03-Domain.md`, `docs/04-Conventions.md`,
`ADR-0001` and `ADR-0002`.

Two facts came out of doing it, and neither is a shift of two. The whole
function table was already **one line behind** reality before this delivery:
it read `install_repo` at 385 where the function is at 386, and the same off
by one held for all 17 rows and for most of the inline citations. It came
from `update-alert`, the last delivery that touched the CLI, and its own diff
says so: `git show 545a0e2 -- docs/01-Architecture.md` moves `install_repo`
from 310 to 385 and `doctor` from 418 to 493, one short of the 386 and 494
the file held. And four citations
were stale by much more: `docs/03-Domain.md`'s Target repository row pointed
at 292, inside `merge_json`, for a claim about the absolute path in
`install_repo`, 99 lines away; `ADR-0001` and `ADR-0002` pointed at 117 for
`merge_json`, which is at 288, and at 111 for `copy_tree`, which is at 271.

So each citation was resolved by **what it claims**, against the file, and
not by adding a number. Every one now names the line that holds the thing the
sentence describes. The three citations of the symlink resolution, which
pointed at 35, 37 and 37 for three different lines of the same block, all
name 41 now, the `while [ -L "$SELF" ]` that is literally the loop. The four
citations in `work/copilot-reads-the-project-rules.md` were left alone: that
is another delivery's page, in flight, and theirs to fix.

**`docs/06-Queue.md` was already damaged, and was left that way.** The file
arrived in this session with 22 lines missing against `HEAD`: the
`distribution-beyond-clone` and `git-policy-for-a-second-person` lines of
"Later, not scheduled" and the entire "Open decisions" section, alongside two
marks that are legitimate (`uninstall-removes-the-kit` to `[>]`,
`dogfood-copies-out-of-the-graph` to `[x]`). It is not this delivery's
change and no command of this delivery made it. Asked in conversation, the
answer was to leave it as it is: this delivery marks only its own line `[x]`,
and `git add -A` stages the truncation with everything else, which the
strategy in `docs/05-Process.md` §7 already names as the cost of having no
branch. It is a thing to catch at review, before the commit, and the
recovery is `git show fe845ce:docs/06-Queue.md`, by the SHA and not by
`HEAD`, because once this delivery is committed `HEAD` is the truncated file.

## The proof

`docs/05-Process.md` §6: a change to `bin/focus-kit` alone is proven by the
verify command. Nothing here touches a skill or a template, so no real run
was needed.

`bin/focus-kit selftest`, green, six checks, at 0.28.1:

```
focus-kit 0.28.1 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

The Behaviour list, item by item. `focus-kit --help` prints item 2 byte for
byte as the Visual reference has it, the two new lines included. The two
counts print `1` each. The four forms of the dispatch, `--help`, `-h`,
`help` and no argument, were compared and are the same block, which they are
because they are one case of the `case` at `bin/focus-kit:1427`. The
alignment was measured and not read: the description field starts at column
50 on all eight lines.

## Decisions

No ADR. Nothing here decides anything an ADR records: the delivery corrects a
description, adds a rule to a document that already holds rules of that kind,
and fixes citations. `ADR-0001` and `ADR-0002` are untouched in substance;
what changed in each is a line number.

Two decisions were the person's, in conversation, and both are written up
under Diverged from the plan: renumber every citation, and leave the queue's
truncation where it is.

One decision was the delivery's own and the page had already taken it: a rule
in `docs/04-Conventions.md` §1 rather than a seventh check of `selftest`. The
reason that survived contact with the code is the first of the two the page
gives. `install_repo` writes the stamp at `bin/focus-kit:404` with no `ok`
line, so a check that compared the `ok` output against the header would have
passed while the header was missing that exact path.

## Environments

| Environment | State |
|---|---|
| Kit source (`bin/`) | 0.28.1. `bin/focus-kit` is the only file of `skills/`, `manuals/`, `config/` or `bin/` that changed |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.28.1, `focus-kit install .` run here, check 6 green. No skill and no manual changed, so only the stamp moved |
| Machine (`~/.local/bin/focus-kit`) | a symlink to the kit source, so 0.28.1. The global `/graphify` skill is at the graphify 0.9.63 package, reported green by the install |
| First target (`~/Downloads/vaulted`) | 0.22.5, read from its stamp, seven versions behind. `focus-kit update ~/Downloads/vaulted`, and only if someone works there: Milestone 2 is closed and this row leaves `docs/05-Process.md` §5 with it |
| Target repositories (anyone else's) | untouched, at whatever version they installed. Their owner runs `focus-kit update`, and gets a `--help` that names all eight paths |
