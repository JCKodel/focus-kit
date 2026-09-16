# first-target-install

**Goal.** The kit has been installed into a repository that is not itself,
and one page records what `install` and `doctor` did there and what they
missed, each miss as a queue line. Until now every claim the kit makes about
a brownfield repository is untested (`docs/06-Queue.md`, milestone 2).

The first target is `~/Downloads/vaulted`, a clone of
`https://github.com/douglascorrea/vaulted` at commit `f6e685c`: a Next.js 16
PWA with no `.claude/`, no `CLAUDE.md`, a `docs/` folder of its own holding
two marketing drafts, a README that carries em dashes, and a CI workflow. A
clone of someone else's repository, so nothing is ever staged, committed or
pushed there.

**Behaviour.**

* `focus-kit install ~/Downloads/vaulted`, run through
  `~/.local/bin/focus-kit` at `0.6.1`, completes and ends with `Next: open
  Claude Code in <target> and run /initialize.` The dependency block prints
  three `ok` lines, because uv, graphify with the mcp extra and the global
  skill are already on this machine.
* `focus-kit doctor ~/Downloads/vaulted` prints what the Visual reference
  shows: every machine line green, the three commands, `kit version 0.6.1`,
  the three manuals, `.mcp.json`, the drift `ok` line, and ten warns, eight
  for the project-owned documents and two for the graph and the hook. Those
  ten are the expected state of a target `/initialize` has not run in.
* `git status --short` in the target is empty before the install and shows
  afterwards exactly `.claude/`, `.mcp.json`, `docs/manuals/`, `work/`
  untracked and `.gitignore` modified.
* `graphify --version` and `uv tool list --show-extras` are captured before
  and after: the dependency phase runs `uv tool install` unconditionally and
  reaches the network. A change there is recorded, not a finding by itself.
* Any line that differs from the four points above is a finding. So is
  anything a person installing the kit for the first time would have to
  work out alone: a green line that is not true, silence over something
  wrong, a next step that names the wrong command, a kit file placed where
  the target already had something of its own.
* One hypothesis to confirm or refute, as the model of what a finding looks
  like: `graphify --version` on this machine writes to stderr that the skill
  at `~/.claude/skills/graphify` is from `0.9.10` and the package is
  `0.9.63`. `ensure_graphify` drops that stderr and installs the global
  skill only when absent (`bin/focus-kit:115`); `doctor` tests only that
  `SKILL.md` exists (`bin/focus-kit:314`). If both print green over a stale
  skill, that is a finding.
* If `install` dies midway, the run is recorded as it happened and the
  delivery stops there. The fix is a queue line, not an edit in this session.

**Contract.**

No kit-owned file changes and `VERSION` stays `0.6.1`. Four project-owned
files carry the delivery:

| File | Exactly |
|---|---|
| `work/done/first-target-install.md` | after the page, `## What happened` with the install and doctor transcripts, ANSI stripped, the absolute path written as `<target>`; the two `git status --short` outputs; the two graphify version captures; the hypothesis answered with the lines that answer it. Then `## Findings`, numbered: what was seen, what was expected, the queue line it became. Only the kit's own output is quoted, never a line from the target's files: its README has em dashes and check 5 greps `work/`. |
| `docs/06-Queue.md` | one `[ ]` line per finding, directly after `first-target-install`, in the order found, in the shape of the lines around it: slug naming what it fixes, description of what happens today. Zero findings is a result too, and then the done page says so and the queue gains nothing. Reordering against `first-target-initialize` is the stakeholder's, in conversation. |
| `docs/05-Process.md` §5 | a fifth row, `First target (~/Downloads/vaulted)`, must leave it: installed at the delivery's version while milestone 2 is open; nothing committed there, ever; command: `focus-kit update ~/Downloads/vaulted`. The row leaves with milestone 2. |
| `docs/03-Domain.md` | the term First target, already written by this `/propose` in the Ownership table. |

**Slice.** This repository's own docs and `work/`, all project-owned. No
skill, no manual, no template, no `config/`, no `bin/`. The graph confirms
`install_repo` and `doctor` are reached only from the dispatch and from
`check_install`; nothing here touches either.

**States.** The defaults. The target is a git repository, so the
`not a git repository` warn does not fire. `docs/00-Product.md` is absent
there, so the closing message is the `/initialize` one. python3, uv and
graphify are present, so no `die` is expected; one is a finding.

**Visual reference.** No UI. `doctor` on the target, if nothing is missed:

```
focus-kit 0.6.1 doctor: <target>
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.6.1
  ! docs/00-Product.md missing
  (six more, docs/01 to docs/06)
  ! CLAUDE.md missing
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ kit-owned files as install wrote them
  ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
  ! graphify post-commit hook not installed (graphify hook install)
```

**Out of scope.**

* Fixing anything found: milestone 2 brings friction back as queue lines,
  and a fix here would bump `VERSION` on a page that is a record.
* `/initialize`, the graph and the hook in the target: `first-target-
  initialize`. `graphify .` there would refuse for want of a key or bill
  one, because the target has docs.
* Opening Claude Code in the target to see the three commands and the MCP
  server without a graph: `first-target-initialize` opens it anyway.
* A commit in the target: it is someone else's clone.
* A run on the Windows host: nothing here is platform dependent.
* A row in `docs/01-Architecture.md` §7: its Target repository row already
  covers any other repository, and §7 says how code gets there, not what a
  delivery must leave. The rule lives in `docs/05` §5 alone.
* An ADR: reversing this is `git clean` in a clone and one row removed.

**Done when.**

* [x] `install` and `doctor` ran on the target through `~/.local/bin/focus-kit`
  at `0.6.1`; both transcripts in the done page as the Contract says.
* [x] The two `git status --short` captures and the two graphify captures in
  the done page; the hypothesis answered, with the lines quoted.
* [x] Every finding is a `[ ]` line after `first-target-install` in
  `docs/06`, and the done page maps each finding to its line.
* [x] `docs/05-Process.md` §5 has the First target row.
* [x] `bin/focus-kit selftest` green; `VERSION` still `0.6.1`; `git status`
  here shows changes under `docs/` and `work/` only.
* [x] Environments: kit source and dogfood copy at `0.6.1`, untouched;
  machine follows the symlink; first target installed at `0.6.1`, nothing
  committed there; other targets untouched. The closing message names all
  five.

---

## What happened

The plan held. `install` exited 0, `doctor` exited 0, and both printed what
the Behaviour section and the Visual reference said they would: three `ok`
lines in the dependency block, the `/initialize` closing message, every
machine line green, the three commands, `kit version 0.6.1`, the three
manuals, `.mcp.json`, the drift `ok` line, and ten warns, eight for the
project-owned documents and two for the graph and the hook. Nothing
diverged from the page and nothing was dropped. The three findings below
are not divergences from the plan: they are what the plan asked to be
looked for, a green line that is not true and two things a person
installing the kit for the first time would have to work out alone.

`<target>` stands for the absolute path of `~/Downloads/vaulted`, and `~`
for this machine's home directory, in every transcript here. The target
sat at `f6e685c` throughout, and nothing there was staged, committed or
pushed. No line from the target's own files is quoted anywhere on this
page: its README carries em dashes and check 5 greps `work/`.

The graph was asked before anything was built and confirmed the Slice:
`doctor()` at `bin/focus-kit:298` and `install_repo()` at `bin/focus-kit:226`
are reached from the dispatch and from `check_install()` alone, and this
delivery touches neither. The `graphify` MCP server failed to connect in
this session, so the question went through the CLI instead.

### `focus-kit install <target>`

```
dependencies
  ✓ uv 0.11.14
  ✓ graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
  ✓ global /graphify skill for Claude Code

installing focus-kit 0.6.1 into <target>
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ .claude/skills/.focus-kit-manifest
  ✓ work/done/
  ✓ .mcp.json (graphify server)
  ✓ .claude/settings.json (baseline permissions merged)
  ✓ .gitignore (kit fragment appended)

Next: open Claude Code in <target> and run /initialize.
```

Exit 0.

### `focus-kit doctor <target>`

```
focus-kit 0.6.1 doctor: <target>
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.6.1
  ! docs/00-Product.md missing
  ! docs/01-Architecture.md missing
  ! docs/02-Backend.md missing
  ! docs/03-Domain.md missing
  ! docs/04-Conventions.md missing
  ! docs/05-Process.md missing
  ! docs/06-Queue.md missing
  ! CLAUDE.md missing
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ kit-owned files as install wrote them
  ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
  ! graphify post-commit hook not installed (graphify hook install)
```

Exit 0. The output is the Visual reference line for line, with the six
lines the reference abbreviated as `(six more, docs/01 to docs/06)`
written out.

### `git status --short` in the target

Before the install, the empty output of a clean clone:

```
```

After it, the five lines the Behaviour section named and no sixth:

```
 M .gitignore
?? .claude/
?? .mcp.json
?? docs/manuals/
?? work/
```

### The graphify captures

`graphify --version`, before and after, identical, stderr included:

```
  warning: skill at ~/.claude/skills/graphify is from graphify 0.9.10, package is 0.9.63. Run 'graphify install --platform claude' to update it (a plain 'graphify install' refreshes only the detected platform).
graphify 0.9.63
```

`uv tool list --show-extras`, before and after, the `graphifyy` entry
identical. The other entries are unrelated tools on this machine and are
left out, because they say nothing about the kit:

```
graphifyy v0.9.63 [extras: mcp]
- graphify
- graphify-mcp
```

So the unconditional `uv tool install` in `ensure_graphify` reached the
network, found the requirement already satisfied and changed nothing, as
the comment at `bin/focus-kit:88` says it would. Not a finding.

### The hypothesis

**Confirmed.** `graphify --version` on this machine writes to stderr that
the skill is from `0.9.10` while the package is `0.9.63`, and the warning
appears in neither transcript. Three lines answer it. The first is what
`ensure_graphify` substitutes, `graphify --version 2>/dev/null`, run by
hand:

```
graphify 0.9.63
```

The second is the install line built from it (`bin/focus-kit:110`), green:

```
  ✓ graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
```

The third is `doctor`, which asks only whether `SKILL.md` exists
(`bin/focus-kit:314`), also green:

```
  ✓ global /graphify skill
```

Both commands print green over a skill 53 releases behind, and the one
process that knows better says so on a stream the kit drops. That is
finding 1.

### One command checked rather than assumed

`graphify hook install`, which `doctor` names as the fix for its last
warn, is a real command: `graphify --help` lists `hook install`,
`hook uninstall` and `hook status`, and `graphify hook status` in a fresh
`git init` answers `post-commit: not installed`. The next step names the
right command.

## Findings

**1. `install` and `doctor` print the global `/graphify` skill green
whatever version it is.**

*Seen.* `✓ graphify 0.9.63 with the mcp extra` and `✓ global /graphify
skill`, both green, over a skill at `0.9.10` against a package at
`0.9.63`. *Expected.* Either line saying so, since graphify itself says
it on every invocation. `ensure_graphify` drops that stderr deliberately
(`bin/focus-kit:106`) and `doctor` tests only that `SKILL.md` exists
(`bin/focus-kit:314`), so the notice has nowhere to land. A person
installing the kit for the first time gets two green lines and a stale
skill, and learns about it only by running `graphify` outside the kit.
*Queue line.* `doctor-sees-a-stale-skill`.

**2. `doctor` has no line for `.claude/settings.json`.**

*Seen.* `install` printed seven `✓` lines for what it wrote and `doctor`
speaks to four of them: the three commands, the three manuals, the
manifest through its drift line, and `.mcp.json`. Three are absent from
its output, `work/done/`, `.gitignore` and `.claude/settings.json`, and
only the last is a finding, because it is the file that carries
`enabledMcpjsonServers`, without which the server declared in the
`.mcp.json` on the line above is never enabled. *Expected.* A line, green
or warn, for that one file. The kit already holds the
reasoning: check 2 of the verify command reads both merged files in the
scratch repository precisely because presence does not prove content
(`docs/05-Process.md` §4), and `doctor` on a real target asks neither
question about the settings and only the presence question about
`.mcp.json`. *Queue line.* `doctor-checks-settings-json`.

**3. Eight of the ten warns name nothing that fixes them.**

*Seen.* Every other warn `doctor` can print ends with its command in
parentheses: `(focus-kit update restores it)`, `(run focus-kit update)`,
`(/propose and /apply rebuild it; docs/manuals/graphify.md)`,
`(graphify hook install)`. The eight for `docs/00` to `docs/06` and
`CLAUDE.md` end at `missing`. *Expected.* The same shape, naming
`/initialize`. After an install that printed ten green lines, the person
sees ten `!` and has to work out alone that eight of them are the normal
state of a target `/initialize` has not run in, which is a sentence this
delivery had to write for itself. *Queue line.* `every-warn-names-its-fix`.

Findings 2 and 3 are judgement calls under the Behaviour section's last
criterion rather than divergences from the four points; the stakeholder
took them as findings in conversation during this apply.

## Environments

Kit source at `0.6.1`, untouched: no kit-owned file changed and `VERSION`
did not move, so the dogfood copy at `0.6.1` needed no `focus-kit install
.` and the machine's `~/.local/bin/focus-kit` follows the symlink. The
first target is installed at `0.6.1` with nothing committed there, and
every other target is untouched.
