# graphify-mcp-starts

**Goal.** A person who ran `focus-kit install` opens Claude Code in the
target repository and the graphify MCP server starts, instead of dying with
`ImportError: mcp not installed`.

**Behaviour.**

* On a machine without graphify, `focus-kit install` installs it with the
  `mcp` extra. Afterwards `graphify-mcp graphify-out/graph.json` starts.
* On a machine where graphify was installed without the extra, which is
  every machine that ran a kit before this version, `focus-kit install` or
  `update` adds the extra in the dependency phase. Measured on Ubuntu 24.04:
  under one second, no prompt, no version change.
* On a machine that already has the extra, the dependency phase prints one
  `ok` line and changes nothing. `uv tool install 'graphifyy[mcp]'` is a
  no-op there, and that is what makes the phase idempotent.
* `focus-kit doctor` says when graphify is present but the extra is not, and
  what to run. `doctor` still changes nothing.
* The `ok` line for graphify stops reading `graphify graphify 0.9.62`: the
  version is printed once.

**Contract.**

`ensure_graphify` no longer branches on `command -v graphify`. It runs
`uv tool install 'graphifyy[mcp]'` unconditionally, output captured, and
prints what happened:

| uv said | Line printed |
|---|---|
| `is already installed` | `ok "graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)"` |
| anything else, exit 0 | the same `ok` line, after `say "  installing graphify with the mcp extra (uv tool install 'graphifyy[mcp]')"` and uv's output |
| exit not 0 | uv's output, then `die "graphify could not be installed (uv tool install 'graphifyy[mcp]')"` |

The version in the line comes from `graphify --version`, whose output
already starts with the word `graphify`, so the line uses that output as
is. The `graphify-mcp not on PATH` warn stays. The global skill block stays.

`doctor` replaces its `graphify-mcp` line with a check of the extra: `uv
tool list --show-extras` has a line starting with `graphifyy` and containing
`[extras: mcp]`. Present: `ok "graphify-mcp (mcp extra)"`. graphify present
but no such line: `warn "graphify-mcp installed without the mcp extra (run
focus-kit update)"`. graphify absent: the existing `warn "graphify-mcp
missing"`.

**Slice.** The CLI, `bin/focus-kit`, dependency phase and `doctor`. One
manual, `manuals/graphify.md`, kit-owned. No skill, template or config
fragment changed; no target received a new file.

---

## What happened

The contract shipped exactly as written. Every line of the delivery's
**States** block printed verbatim on this machine, and `uv tool list
--show-extras` renders the extra as `graphifyy v0.9.63 [extras: mcp]`, which
is the string `doctor` greps for.

Three things diverged, and one of them matters.

### 1. The extra alone does not make the server start on an old graphify

This is the divergence. The delivery's second behaviour bullet, the one
about a machine that ran a kit before this version, was wrong, and this
machine was exactly that machine.

`focus-kit update .` ran the install path once, added the extra, and left
graphify at the version it already had, 0.9.10. That part is what the page
predicted, including "no version change". Then `graphify-mcp
graphify-out/graph.json` still died, with a different error:

```
ImportError: cannot import name 'AnyUrl' from 'mcp.types'
```

The cause is one line of graphifyy's own metadata:

```
Requires-Dist: mcp; extra == "mcp"
```

No upper bound. uv resolved the current SDK, `mcp==2.2.0`, and graphify
0.9.10 predates its API. So adding the extra to a graphify installed long
ago pairs old code with a new SDK, and swaps `No module named 'mcp'` for an
`ImportError` one layer further in. The page's Ubuntu measurement did not
see this because that machine's graphify was already recent; "no version
change" was the trap, not the feature.

`docs/05-Process.md` §6 says the run wins, so the page is what was wrong.
Recorded here rather than edited away.

**What was not done about it.** The kit was not changed. `uv tool install
--upgrade` was weighed and rejected: the page puts upgrading out of scope on
purpose, it would turn an idempotent no-op into a network hit on every run,
and an upgrade of someone's tool is not a side effect an install should
have. The remedy was already in the `ok` line the kit prints, `uv tool
upgrade graphifyy`, and it was verified before being recommended: an
ephemeral `uvx --from 'graphifyy[mcp]==0.9.63' graphify-mcp
graphify-out/graph.json` started clean and read the graph that 0.9.10 had
built, so the upgrade costs no rebuild.

The stakeholder was asked and chose to upgrade this machine. `uv tool
upgrade graphifyy` took graphify from 0.9.10 to 0.9.63, and
`graphify-mcp graphify-out/graph.json` now starts with no traceback. The
kit's own diff is unchanged by that decision.

**Known limit, left as it is.** `doctor` prints `graphify-mcp (mcp extra)`
in green whenever `uv tool list` records the extra, and that says nothing
about whether the server can import. A graphify too old for the SDK passes
this check and still fails to start. Checking the import would mean running
the server from `doctor`, which reports and does not execute. Worth a queue
line, not a fix inside this delivery.

### 2. A stray line from graphify leaked into the dependency block

Caught during the proof and fixed. The first version of the new `ok` line
was `ok "$(graphify --version) with the mcp extra (...)"`, dropping the
`2>/dev/null` the old code had. After the upgrade, `graphify --version`
started writing a notice to stderr about the global `/graphify` skill being
stale, and it appeared unshaped in the middle of the `dependencies` block,
between two `ok` lines. `docs/04-Conventions.md` §1 says every line a person
reads picks one of the four shapes, so the redirection is back, with a
comment saying why.

### 3. Line numbers across the docs

Editing `bin/focus-kit` moved every function after line 73, and the
documents carry line references by the dozen: 22 of the form
`bin/focus-kit:NNN` across `docs/00-Product.md`, `docs/01-Architecture.md`,
`docs/03-Domain.md`, `docs/04-Conventions.md`, `ADR-0001` and `ADR-0002`,
plus 14 bare numbers in the two tables of `docs/01-Architecture.md` §3.
Every one that the edit falsified was corrected, and all 36 were checked
against the script afterwards. This is not scope widening:
the edit falsified statements that were true, and fixing them is the same
delivery. It is also a standing cost nothing checks, and no verify check
would have caught it.

## Decisions

No ADR. Nothing here is expensive to reverse: the change is one function and
one branch in `doctor`, and the decision not to upgrade from the kit is
already written in the page's Out of scope and now in the manual.

## Docs updated

* `manuals/graphify.md` §Troubleshooting: two bullets, not the one the page
  planned. The second covers the `AnyUrl` error found during the proof, says
  why it happens and why the kit does not fix it for you. Kit-owned, so the
  dogfood copy in `docs/manuals/` was refreshed by `focus-kit install .`.
* `docs/01-Architecture.md` §3 (the `ensure_graphify` row) and §5 (the
  "Install a machine dependency" row, which said both functions were no-ops
  when the dependency is present, and is no longer true of `ensure_graphify`).
* `docs/03-Domain.md`, the MCP server row: the `mcp` extra, and that without
  it the executable exists and dies on import.
* `docs/00-Product.md` §Mechanics, Installing: the dependency phase is no
  longer "each step is skipped when already present".
* The header comment of `bin/focus-kit`, step 1, which is also the `--help`
  text.

## Proof

```
$ bin/focus-kit update .
dependencies
  ✓ uv 0.11.14
  installing graphify with the mcp extra (uv tool install 'graphifyy[mcp]')
  ... 28 packages installed, among them mcp==2.2.0
  ✓ graphify 0.9.10 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
  ✓ global /graphify skill for Claude Code
```

The second run, after the upgrade, is the idempotent path and the delivery's
**States** block exactly:

```
dependencies
  ✓ uv 0.11.14
  ✓ graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
  ✓ global /graphify skill for Claude Code
```

```
$ bin/focus-kit doctor .
  ✓ graphify-mcp (mcp extra)

$ graphify-mcp graphify-out/graph.json </dev/null
(no output, no traceback)

$ bin/focus-kit selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources
```

The `warn` branch of `doctor`, which is what the page's **Visual reference**
shows, was **not** run on this machine. The order of the proof made that
impossible: `update .` added the extra before the new `doctor` code was ever
called, and reaching the branch afterwards would mean uninstalling the
extra. What was captured is the input the branch reads. Before the fix,
`uv tool list --show-extras` printed

```
graphifyy v0.9.10
- graphify
- graphify-mcp
```

with no `[extras: ...]` suffix, and that line does not match
`^graphifyy .*\[extras: mcp\]`, so the pattern selects the warn on such a
machine. The pattern is proven against real output; the branch is not.

## Left for the person

* **A new Claude Code session listing the graphify MCP tools.** It cannot be
  ticked from inside the session that built this: that session's graphify
  MCP server is the one that failed at startup, which is the bug. The
  command line proves the server starts; the session proves the tools
  appear, and it is the next session that does it.
* **The global `/graphify` skill is stale**, from graphify 0.9.10 while the
  package is 0.9.63. graphify says so itself on every `--version`. The kit
  deliberately installs it only when absent, because `graphify install
  --platform claude` also appends to `~/.claude/CLAUDE.md`, a file the kit
  does not own. Refresh it by hand with `graphify install --platform claude`.

## Out of scope

* Exercising `ensure_graphify` in the verify command: it would put the
  network inside `selftest` (`work/done/kit-selftest.md`). `check_install`
  calls `install_repo` directly and never the dependency phase, which is
  what keeps that true after this change.
* Upgrading graphify from the kit: `uv tool upgrade graphifyy` stays a hint
  in the `ok` line. Reaffirmed during the proof, when the upgrade turned out
  to be necessary on this machine and was still left to a person.
* A graphify not installed by uv (pip, brew): `doctor` warns as "without the
  extra", which is the honest reading of `uv tool list`, and the person
  reinstalls with uv.

## Done when

* [x] `bin/focus-kit selftest` green.
* [x] On this machine, `focus-kit update .` printed the `installing graphify
  with the mcp extra` path once, and `graphify-mcp graphify-out/graph.json`
  starts without a traceback. It took the extra plus `uv tool upgrade
  graphifyy`, not the extra alone; see divergence 1. The Claude Code session
  listing the MCP tools is the next session's, not this one's.
* [x] `doctor .` here prints `graphify-mcp (mcp extra)`.
* [x] `VERSION` is `0.4.2`; `focus-kit install .` was run, so
  `docs/manuals/graphify.md` matches its source and check 6 is green.
* [x] `docs/01-Architecture.md` §3, `docs/03-Domain.md` and the header
  comment say what the dependency phase does now. `docs/00-Product.md` and
  `docs/01-Architecture.md` §5 said the old behaviour too and were updated.
* [x] Environments: kit source and dogfood copy at 0.4.2, machine follows the
  symlink, targets untouched until their owner runs `focus-kit update`.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.4.2 |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.4.2, synced by `focus-kit install .` |
| Machine (`~/.local/bin/focus-kit`) | 0.4.2, a symlink to the kit source |
| Target repositories | untouched, on whatever version they installed |

Targets move when their owner runs `focus-kit update <path>`. Nothing is
published, because the kit has no registry and no release artifact: the
version becomes available when a person commits and pushes.
