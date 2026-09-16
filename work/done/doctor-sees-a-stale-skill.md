# doctor-sees-a-stale-skill

**Goal.** A person running `focus-kit install` or `focus-kit doctor` learns
when the global `/graphify` skill on their machine is not the version of the
graphify package, and `install` brings it up to date instead of printing
green over it.

**Behaviour.**

* On this machine today the skill stamp reads `0.9.10` and `graphify
  --version` says `0.9.63`. `focus-kit doctor .` warns with both numbers
  where the green line is today. `focus-kit install .` runs `graphify
  install --platform claude`, says so on the skill line, and afterwards
  `graphify --version` prints no warning. Under `~/.claude/`, only
  `skills/graphify/` changed: the installer's global path copies the skill,
  its `references/` and the stamp, and touches `CLAUDE.md` only when it does
  not mention graphify yet (verified in 0.9.63: `install.py`, `install()`
  and `_register_always_on_block`; the hook writer `_install_claude_hook` is
  reached only by `graphify claude install`, which the kit never runs).
* On a machine whose skill matches the package, both commands print the
  green lines they print today, unchanged.
* A skill with `SKILL.md` and no stamp is of unknown version: `doctor`
  warns, `install` refreshes it and graphify writes the stamp.
* A skill newer than the package is never touched: both commands warn and
  name `uv tool upgrade graphifyy`, because graphify's installer would
  downgrade it, as graphify itself says.
* graphify's stderr stays dropped (`docs/04-Conventions.md` §1). The kit
  reads the stamp graphify reads, so the verdict is the same and the line is
  the kit's.
* Check 2 of `selftest` proves every doctor line on any machine, with no
  network and no graphify, through a fake home and a fake `graphify` on PATH.

**Contract.**

`bin/focus-kit`; `VERSION` goes from `0.6.1` to `0.7.0`, a behaviour a target
would want. One new helper, `global_skill_state()`, whose output is captured
and which never dies (`docs/01-Architecture.md` §6). It echoes one line,
`<state> <skill> <package>`, an absent number written as `-`:

| State | When |
|---|---|
| `missing` | `~/.claude/skills/graphify/SKILL.md` absent |
| `unknown` | `SKILL.md` present and the stamp absent, or `graphify` not on PATH |
| `equal` | the stamp, read through `without_cr`, equals the second word of `graphify --version 2>/dev/null` |
| `older` | they differ and the stamp sorts first under `sort -t. -k1,1n -k2,2n -k3,3n` (POSIX; run on this Mac) |
| `newer` | they differ and the package sorts first |

`doctor`, the line at `bin/focus-kit:314`, one line whatever the state:

| State | Line |
|---|---|
| `equal` | `✓ global /graphify skill` (unchanged) |
| `missing` | `! global /graphify skill missing (run focus-kit update)` |
| `unknown` | `! global /graphify skill of unknown version (run focus-kit update)` |
| `older` | `! global /graphify skill <skill> installed, <package> available (run focus-kit update)` |
| `newer` | `! global /graphify skill <skill> is newer than graphify <package> (uv tool upgrade graphifyy)` |

`ensure_graphify`, the block at `bin/focus-kit:112` to `121`, reached with
graphify on PATH, so `unknown` there means no stamp:

| State | Does | Line |
|---|---|---|
| `equal` | nothing | `✓ global /graphify skill for Claude Code` (unchanged) |
| `missing` | `graphify install --platform claude` | unchanged: `✓ global /graphify skill for Claude Code (installed; it also added a graphify section to ~/.claude/CLAUDE.md)` |
| `older`, `unknown` | `graphify install --platform claude` | `✓ global /graphify skill for Claude Code (refreshed from <skill>)`, with `an unknown version` for `<skill>` when there is no stamp |
| `newer` | nothing | the `newer` warn above, same text |
| the installer fails | | unchanged: `! could not install the global /graphify skill (graphify install --platform claude)` |

The header comment, line 13, says the skill is installed when absent and
refreshed when older than the package; it is the `--help` text.

`check_install`: after the missing-template probe, four doctor runs against
a fake home `$SELFTEST_DIR/home` holding `.claude/skills/graphify/SKILL.md`
(one line) and a fake executable `$SELFTEST_DIR/bin/graphify` that prints
`graphify 9.9.9` whatever its arguments, both outside the scratch check 3
snapshots and both removed by the existing trap. Each run is `HOME=... PATH=...
doctor "$scratch"`, each expected line built through `ok` or `warn` as the
other assertions are: stamp `9.9.10` prints the `newer` warn, which is the
run that proves the sort is numeric and not lexical; stamp `9.9.8` prints the
`older` warn; no stamp prints the `unknown` warn; stamp `9.9.9` prints the
`ok` line.

Documents, in the same delivery: `docs/03-Domain.md` already holds Global
skill and Skill stamp (this `/propose`); `docs/00-Product.md` §Installing
stops saying the skill is installed only when absent and says when it is
refreshed and why the `CLAUDE.md` reason no longer holds; `docs/01-
Architecture.md` §3 rows for `doctor`, `ensure_graphify` and the new helper,
and §5 the row Touch the user's home; `docs/05-Process.md` §4 check 2 gains
the probe and §5 the Machine row says the global skill is left at the
package's version; `manuals/graphify.md` §Troubleshooting gains one bullet:
graphify warning on every command that the skill is stale is fixed by
`focus-kit update`. The note in `work/done/graphify-mcp-starts.md` is a
record and stays.

**Slice.** `bin/focus-kit` and `VERSION`, kit source; `manuals/graphify.md`,
kit-owned, copied to every target; this repository's docs, project-owned.
No skill, no template, no `config/`. The helper reads two files and orders
two strings, a reader like `installed_version`; the table in `docs/01` §3
stays empty. The graph confirms `ensure_graphify` and `doctor` are reached
from the dispatch alone, and `doctor` from `check_install`.

**States.** The defaults. `doctor` on a machine without graphify prints
`graphify missing` above and the `unknown` line; `install` never reaches the
block without graphify. The installer failing is the existing warn and the
run continues. A target that is not a git repository is unaffected.

**Visual reference.** No UI. `focus-kit doctor .` on this machine before,
one line changed:

```
  ✓ graphify-mcp (mcp extra)
  ! global /graphify skill 0.9.10 installed, 0.9.63 available (run focus-kit update)
  ✓ /initialize
```

The dependency block of `focus-kit install .` here, once:

```
dependencies
  ✓ uv 0.11.14
  ✓ graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
  ✓ global /graphify skill for Claude Code (refreshed from 0.9.10)
```

**Out of scope.**

* Upgrading the graphify package from the kit: reaffirmed in
  `graphify-mcp-starts`; the hint in the `ok` line stays.
* Skills for graphify's other platforms: the kit installs for Claude Code.
* The `.claude/settings.json` line and the eight `missing` warns: their own
  queue lines.
* Proving graphify's `CLAUDE.md` guard on releases before 0.9.63: the
  refresh runs only on a stale skill, the same touch the person would make
  by hand on graphify's own advice.
* A run on the Windows host: the sort is POSIX and `without_cr` is already
  proven there. The one piece not yet exercised under Git Bash is the probe's
  fake executable, made with `chmod +x` at run time; the next delivery that
  runs `selftest` on that host proves it, and until then nothing a user
  reads claims it.
* An ADR: a branch in one function, cheap to reverse.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 2 with the four skill probes.
* [x] `VERSION` at `0.7.0`; `focus-kit install .` run here; check 6 empty.
* [x] The done page carries, from this machine, before and after the
  refresh: `graphify --version` with stderr, `focus-kit doctor .`, the
  dependency block, and a `diff -r` of a copy of `~/.claude/` taken before
  against the real one after, showing `skills/graphify/` as the only
  difference. The before capture is the first thing `/apply` does, before
  any `install` or `update`, because the first one erases the stale state;
  writing `0.9.10` back into the stamp recreates it if a capture is lost.
* [x] `docs/00` §Installing, `docs/01` §3 and §5, `docs/05` §4 and §5,
  `manuals/graphify.md` §Troubleshooting updated as the Contract says.
* [x] Environments: kit source and dogfood copy at `0.7.0`; machine follows
  the symlink and its global skill is at `0.9.63` after the dogfood install;
  first target updated to `0.7.0` by `focus-kit update ~/Downloads/vaulted`,
  its skill line green because the machine's skill is already refreshed,
  nothing committed there; other targets untouched. The closing message
  names all five.

---

## What happened

The plan held. Every state table in the Contract is in `bin/focus-kit` as
written, the four probes are in check 2, `selftest` is green, and the two
transcripts below are the two the Visual reference predicted, line for line.
Nothing was dropped and nothing was added that the page did not name. `~`
stands for this machine's home directory in every transcript here.

The graph was asked before anything was built, and confirmed the Slice:
`ensure_graphify()` and `doctor()` are reached from the dispatch alone
(`bin/focus-kit:754`), and `doctor()` also from `check_install()` and
`check_dogfood()`. No other caller exists, so the two lines this delivery
rewrites are the only two places the global skill is ever reported.

### The state of the skill before, and the warning it cost

The first thing this session did, before any `install`, was capture the
stale state, because the first `install` erases it:

```
$ graphify --version 2>&1
  warning: skill at ~/.claude/skills/graphify is from graphify 0.9.10, package is 0.9.63. Run 'graphify install --platform claude' to update it (a plain 'graphify install' refreshes only the detected platform).
graphify 0.9.63
```

That line was on the front of **every** graphify invocation, and
`focus-kit doctor .` printed a green line over it. With the new code, still
before the refresh:

```
focus-kit 0.7.0 doctor: <repo>
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ! global /graphify skill 0.9.10 installed, 0.9.63 available (run focus-kit update)
  ✓ /initialize
```

### The refresh

`focus-kit install .`, run once, which is both the dogfood install the
process requires and the one command that brings the skill up to date:

```
dependencies
  ✓ uv 0.11.14
  ✓ graphify 0.9.63 with the mcp extra (to upgrade: uv tool upgrade graphifyy)
  ✓ global /graphify skill for Claude Code (refreshed from 0.9.10)
```

After it, the stamp reads `0.9.63`, `graphify --version 2>&1` prints the
version and nothing else, and the `doctor` line is green again:

```
$ graphify --version 2>&1
graphify 0.9.63
$ cat ~/.claude/skills/graphify/.graphify_version
0.9.63
$ bin/focus-kit doctor .
focus-kit 0.7.0 doctor: <repo>
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
```

### What the refresh touched under `~/.claude/`

`rsync -a` took a copy of `~/.claude/` before anything ran, and
`diff -rq <copy> ~/.claude` was run after. The full result is 35 lines and
every one of them falls in one of two groups.

**graphify's installer**, all four inside `skills/graphify/`:

```
Files BEFORE/skills/graphify/SKILL.md and AFTER/skills/graphify/SKILL.md differ
Files BEFORE/skills/graphify/references/update.md and AFTER/skills/graphify/references/update.md differ
Files BEFORE/skills/graphify/.graphify_version and AFTER/skills/graphify/.graphify_version differ
Only in AFTER/skills/graphify: SKILL.md.bak
```

`SKILL.md.bak` is the one thing the page did not predict: graphify keeps the
skill it replaced beside the new one. It is inside the same directory, it is
graphify's file, and it changes nothing about the claim the proof exists to
make.

**Everything else is this session writing its own state**, and none of it is
reachable from the kit: `backups/.claude.json.backup.*` (four expired, four
new), `context-mode/` logs and session databases, `read-once/`,
`usage-cache.json`, `file-history/<this session>`, `session-env/` and
`sessions/`. Two entries are `diff` errors and not differences:
`debug/latest` and `skills/find-skills` are symlinks, present and identical
on both sides, whose targets do not resolve from inside the copy.
`projects/` and `shell-snapshots/` were left out of the copy for the same
reason, this session writes its transcript into both, and neither is
anything the kit or graphify touches.

The claim the delivery actually rests on was checked directly rather than
read off the list:

```
$ cmp <copy>/CLAUDE.md ~/.claude/CLAUDE.md
identical
```

graphify's guard held. `~/.claude/CLAUDE.md` already mentioned graphify, so
the refresh did not append to it, which is what makes refreshing on every
stale skill cheap enough to do at all.

### Decisions taken

No ADR, as the page said: one branch in one function, cheap to reverse.

Three things the page left to the build:

* **`global_skill_state` sits before `ensure_graphify`**, in the dependency
  section, rather than beside the other readers near `doctor`. It calls
  `without_cr`, which is defined later in the file, and bash resolves that at
  call time. The two pieces of the global skill now read together.
* **The four probes are one loop over the stamp values**, not four blocks,
  with a `case` that builds each expected line through `ok` or `warn`. Each
  `doctor` run is a command substitution, so the `HOME=` and `PATH=` in front
  of a shell function die with the subshell instead of outliving the call,
  which in bash they otherwise can.
* **An empty stamp file counts as no stamp.** The page's table says `unknown`
  when the stamp is absent; a stamp present and empty is the same question
  with the same answer, and the guard is one `-s` test.

One observable the page did not name: during the four probes `doctor` runs
with a fake `HOME`, so its `uv tool list` line warns about the `mcp` extra.
Nothing asserts that line, and the trap removes the fake home.

### Documents

`docs/00` §Installing, `docs/01` §3 and §5, `docs/05` §4 and §5 and
`manuals/graphify.md` §Troubleshooting were updated as the Contract says.
Three more, none of them a change of scope:

* `docs/01` §3 said "three verbs and eight helpers", and `docs/01` §6 lists
  the functions that never die. Both gained `global_skill_state`, and the
  `without_cr` row went from three callers to four.
* **Every `Line` value in the `docs/01` §3 table moved**, because a function
  was inserted at line 104, and so did every `bin/focus-kit:NNN` in `docs/00`,
  `docs/01`, `docs/03` and `docs/04`. All of them were recomputed and each one
  was resolved against the file to confirm it lands on what it claims.
* Two of those references were already wrong before this delivery:
  `docs/00` §Installing pointed at `bin/focus-kit:399` for the dispatch and
  `docs/03` at `:229` for the absolute path of a target. Both are in
  paragraphs this delivery rewrites, so both were corrected here.

The note in `work/done/graphify-mcp-starts.md` that says the skill is
installed only when absent is a record of what was true then, and stays.

### Environments

| Environment | State |
|---|---|
| Kit source | `0.7.0`, in this working tree, staged and not committed |
| Dogfood copy | `0.7.0`; `focus-kit install .` run here, check 6 green |
| Machine | `~/.local/bin/focus-kit` is a symlink and follows the source: `focus-kit version` prints `0.7.0`. Its global `/graphify` skill is at `0.9.63` |
| First target (`~/Downloads/vaulted`) | `0.7.0`, by `focus-kit update ~/Downloads/vaulted`, its skill line green because this machine's skill was already refreshed. Still at `f6e685c`; nothing staged, committed or pushed there |
| Other targets | untouched. They move when their owner runs `focus-kit update` |
