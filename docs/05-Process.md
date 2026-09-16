# Process

How an idea becomes code in focus-kit. The process is the focus-kit one
(`docs/manuals/process.md` is the manual); this document is the part that is
specific to this project: the slots `/apply` reads every time.

This repository is the kit, so it is also its own first target. The process
described here is the same one the kit installs elsewhere, applied to
itself.

---

## 0. Language

**The documentation language is English.** Prose in English; identifiers in
English.

The delivery page and the commit message are written in English.
Identifiers are in English regardless (`docs/04-Conventions.md` §1).

## 1. The rule

**A delivery is a one-page file.** If it does not fit on one page, it is two
deliveries. The page is not a goal of concision: it is the test that the
scope was understood. A scope that needs five pages to describe has not been
decided yet.

## 2. The flow

```
docs/06-Queue.md  →  /propose <slug>  →  work/<slug>.md  →  /apply <slug>
                                                                 ↓
                                        verify green, environments as §5 says
                                                                 ↓
                                          work/done/<slug>.md + git add -A
                                                                 ↓
                                             a person reviews and commits
```

**`/propose <slug>`** is a conversation. It reads `docs/00-Product.md`,
`docs/03-Domain.md`, `docs/06-Queue.md` and what is in `work/`; asks
whenever there is more than one reading; writes `work/<slug>.md`. **It
writes no code, migration or test.** Separating deciding from doing is what
keeps scope from growing during implementation.

**`/apply <slug>`** implements, in a clean session. It reads the delivery,
`CLAUDE.md`, `docs/01-Architecture.md`, `docs/04-Conventions.md` and this
document; builds every piece; runs the verify command; proves the result the
way §6 says; leaves the environments as §5 says; updates the docs the
delivery changed; ticks "Done when"; moves the file to `work/done/`; stages
and **suggests** the commit message. **It does not commit.**

## 3. The format of `work/<slug>.md`

```markdown
# <slug>

**Goal.** One sentence: what a user becomes able to do.

**Behaviour.** Verifiable scenarios in user language. Each line becomes a
test or a manual check.

**Contract.** The exact shape of what changes: the CLI's output lines, a
file's path and ownership, a template's section names, the JSON keys
merged into a target. The only section that demands precision, because it
is the only one that is expensive to reverse. For this project, a change
to anything a target repository receives is a contract change.

**Slice.** Which part of the kit: `bin/focus-kit`, a skill, a manual, a
template, `config/`, or this repository's own docs. Say whether the change
is kit-owned, project-owned, merged or appended once.

**States.** What the CLI prints when it works, when something is already
there, when a dependency is missing, when the target is not a git
repository. Or "the defaults".

**Visual reference.** No UI. For a change to the CLI's output, paste the
exact lines the run should print.

**Out of scope.** What does not go in, half a line of reason each.

**Done when.** Mechanical checklist: verify green; the dogfood copy in sync
(§5); `VERSION` bumped if a target would want the change; the docs the
delivery changed updated; the environments in §5 are in the required state.
```

## 4. Verify

```
bin/focus-kit selftest
```

It runs six checks, in this order, and stops at the first red:

1. `bash -n bin/focus-kit`, the script parses.
2. `focus-kit install` into a **scratch repository**, a fresh `mktemp -d`
   with `git init` run in it, then `focus-kit doctor` there. The check is
   every kit-owned path present and the installed version equal to
   `VERSION`, **not** a doctor with no warnings. A scratch repository has
   not had `/initialize` run in it, so `doctor` correctly warns that
   `docs/00` to `06`, `CLAUDE.md`, the graph and the hook are missing.
   Those ten warnings are the expected output, and the selftest must not
   treat them as failures.
   Then the check **reads the two merged files** in the scratch, which
   `doctor` only counts: `.mcp.json` must contain `"graphify-mcp"`, and
   `.claude/settings.json` must contain `"enabledMcpjsonServers"` and one
   baseline permission, `"Bash(graphify *)"`. Absent is red, with a `die`
   naming the file. The assertion is a `grep -qF` and not python, because
   the failure it exists to catch is python missing: an empty `.mcp.json`
   satisfies a check that only asks whether the file is there.
   Then one probe: the scratch's `.focus-kit-version` is rewritten as CRLF,
   the way a Windows clone with `core.autocrlf=true` checks it out, `doctor`
   runs again and must still print the same green version line; the stamp is
   then restored with LF, because check 3 installs into this same scratch and
   a CRLF left behind would come back as a false idempotency failure. The
   probe runs on every platform: nothing on macOS or Linux writes that byte
   on its own, so a regression here would otherwise be invisible forever.
   Last, four probes on drift, on the same scratch. **CRLF:**
   `docs/manuals/focus.md` and `.claude/skills/.focus-kit-manifest` are both
   rewritten with `\r\n` line ends and `doctor` must still print `kit-owned
   files as install wrote them`, which it does only while the fingerprint and
   the manifest reader both go through `without_cr`. **Edited:** a line is
   appended to that same manual and `doctor` must name it as edited locally.
   **Added:** `.claude/skills/apply/extra.md` is created and the same
   `doctor` run must name it as not the kit's. Then everything is restored,
   the manifest included, which `write_manifest` rewrites byte for byte
   because it is deterministic over the same tree; check 3 snapshots this
   scratch next and any leftover would come back as a false idempotency
   failure. **Missing:** `.claude/skills/initialize/templates/CLAUDE.md` is
   deleted and one `doctor` run must both name it as missing and not print
   the drift `ok` line, which is the only way a deleted template is ever
   caught: ten of the sixteen paths the manifest names are templates and no
   presence line covers them. It is restored by a copy alone, because a
   deletion does not change the manifest.
3. The same install again into the same scratch repository, trees compared.
   The install is idempotent.
4. The frontmatter of each of the three `SKILL.md` files, against four
   structural rules: line 1 is `---` and a closing `---` exists; `name:`
   equals the folder name; one line reads exactly `description: >-`; every
   line of that block is indented until the next top-level key. The rules
   are checked in pure bash, because python3 has no YAML parser in its
   standard library. A bare colon in the description value breaks the YAML
   and the skill disappears with no error, which has happened.
5. A grep for the em dash across the paths this repository authors:
   `bin/`, `skills/`, `manuals/`, `config/`, `work/`, `docs/` except
   `docs/manuals/`, `CLAUDE.md`, `README.md`. No hits. `graphify-out/` is
   excluded because it is generated: `GRAPH_REPORT.md` and `graph.html`
   contain em dashes that graphify writes, and they come back on every
   rebuild.
6. `.claude/skills/.focus-kit-version` equal to `VERSION`, then `diff -r
   skills .claude/skills` and `diff -r manuals docs/manuals`, both empty
   except for `.focus-kit-version` and `.focus-kit-manifest`. Both are
   excluded because neither is a copy of anything under `skills/`: they are
   what the install writes, and `skills/` has no source for either. The stamp
   is compared by value and not
   by bytes against `skills/`, because it is not a copy of anything: it is
   what the install writes. By value also forgives a trailing carriage
   return, because the stamp is read through the same `installed_version`
   `doctor` uses: the second occurrence of that read, and the two have to
   agree on what the number is. `.gitattributes` keeps this repository's own
   stamp at LF, so the tolerance is never exercised here; it is exercised in
   a target, which receives no `.gitattributes`.
   The `die` names both numbers and the command
   that fixes it; an absent stamp is red too, with a `die` naming the file.
   Then `doctor` is run on this repository and must print `kit-owned files as
   install wrote them`. Only that line is asserted; the warns this repository
   legitimately produces are ignored, as check 2 ignores a scratch
   repository's. It comes after the two `diff` calls because it exists for
   the gap they leave: both copies equal to their sources and the manifest
   stale against them, which is what editing a manual and its dogfood copy by
   hand, without `focus-kit install .`, produces.

It takes a few seconds. There is nothing slow and nothing that runs only in
CI, because there is no CI. A red means a target repository would receive a
broken kit, which is the only failure mode this project has that someone
else pays for.

The command takes no path argument: four of the six checks are about the
kit's own sources, and a target repository never receives `bin/focus-kit`.
It creates a scratch repository for checks 2 and 3 and removes it through a
`trap ... EXIT`, green or red. Green prints six `ok` lines and exits 0; red
prints the detail of what broke, one `die` naming it, and exits 1.

## 5. Environments

| Environment | A delivery must leave it | Command |
|---|---|---|
| Kit source (`skills/`, `manuals/`, `config/`, `bin/`) | at the delivery's version, always. It is the truth. | the edit itself |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | in sync with the kit source, always, when the delivery touched a skill or a manual, or bumped `VERSION` | `focus-kit install .` |
| Machine (`~/.local/bin/focus-kit`) | untouched. It is a symlink to the kit source and follows it automatically. | none; verify with `focus-kit version` |
| Target repositories (anyone else's) | untouched. They move only when their owner runs `focus-kit update`. | `focus-kit update <path>`, run by that person |

**A delivery never ends silent about environments.** The last thing `/apply`
says is which environment is at which version and the command that updates
the others. What costs, in every project, is not the missing deploy: it is
someone opening an environment believing it is current.

Here that risk is concrete and easy to miss. A Claude Code session reads
`.claude/skills/initialize/SKILL.md`, not `skills/initialize/SKILL.md`. Edit
the source and the session you are in keeps running the old version until
`focus-kit install .` has been run. So: **any delivery that touches
`skills/` or `manuals/`, or bumps `VERSION`, ends by running `focus-kit
install .` in this repository**, and its "Done when" includes check 6 of the
verify command coming back empty.

The `VERSION` bump is in that rule because the dogfood copy is a target, and
a target one version behind is what `doctor` exists to flag. A delivery that
bumps `VERSION` and touches no skill and no manual still leaves
`.claude/skills/.focus-kit-version` one number behind, and `focus-kit doctor
.` here warns about the kit's own version. The install brings the stamp to
the same number in the same commit.

**Publish policy.** There is nothing to publish. The kit has no registry, no
release artifact and no deploy. A version becomes available to other people
the moment a person commits and pushes, and it reaches a target only when
that target's owner runs `focus-kit update`. `/apply` never pushes and never
asks to.

What `/apply` does do without asking is bump `VERSION`, in the same commit,
whenever the delivery changed something a target repository would want: a
skill, a manual, a template, or the CLI's behaviour. A change to this
repository's own `docs/` or `work/` is not such a change, and `VERSION`
stays where it is.

## 6. Proof

There is no UI, so there is no screenshot and no visual reference. What
stands in for proof here is an install into a scratch repository, which is
check 2 of the verify command, plus one thing the verify command cannot do.

**The proof of a change to a skill or a template is a real run.** A delivery
that changes `/initialize`, `/propose` or `/apply` is proven by running that
command in a scratch repository and reading what it produced, not by
checking that the file copied. A template whose section headings changed can
copy perfectly and still produce a document with a section nobody fills.

The rule for divergence: **what the command actually produced wins.** If the
run differs from what the delivery page expected, the page is what was
wrong, and `/apply` records the difference in `work/done/<slug>.md` with one
line of reason rather than editing the expectation quietly.

For a change to `bin/focus-kit` alone, the verify command is the proof and
nothing further is needed.

**A change that claims a platform is proven by the verify command on that
platform.** Reading the script and reasoning about what a shell there would
do is not proof: the delivery runs `bin/focus-kit selftest` on that machine
and the transcript goes into `work/done/<slug>.md`. Until it has, the
platform is not claimed anywhere a user reads.

## 7. Git

**Trunk.** Work goes straight to `main`. No branches, no pull requests, no
review before merge. There is one person working here, and a branch would be
ceremony with nobody on the other side of it.

**A person commits, always.** `/apply` stages with `git add -A` and suggests
the message. It does not commit and does not push, whatever else is
configured. `.claude/settings.json` puts `git commit` and `git push` behind
a prompt as a second line of defence.

**One delivery, one commit.** The message format is in
`docs/04-Conventions.md` §6: imperative subject up to 72 characters with the
slug as scope, up to five one-line bullets, and a last line pointing at
`work/done/<slug>.md`.

The post-commit hook rebuilds the graph when the commit lands
(`docs/manuals/graphify.md`).

## 8. Queue

`docs/06-Queue.md`: one line per delivery, in order. Not a schedule, not a
narrative. A line **never leaves** the queue: it changes mark. `/propose`
turns `[ ]` into `[>]` (defined in `work/<slug>.md`, not yet built);
`/apply` turns `[>]` into `[x]` and moves the file to `work/done/`.

## 9. Milestone review

At the close of each milestone, not each delivery, the stakeholder runs a
whole-branch review (`/code-review ultra` in Claude Code, or the team's
equivalent). It exists because the process is light: no formal spec and no
gates means the risk is accumulation, each delivery correct and the whole
crooked. Every confirmed finding becomes a delivery in the queue, named
after what it fixes, not a rushed patch in the middle of the next milestone.
The review is user-triggered and billed; the agent reminds, it never
launches it.

## 10. What does not exist in this process

No formal spec, no spec delta, no archiving, no numbered tasks, no
pre-implementation gate, no specialized subagent. If any of these reappears,
the question is: **which concrete error would it have caught?** The answer
has to name an error that actually happened.
