# every-warn-names-its-fix

**Goal.** A person reading `focus-kit doctor` knows, from each `!` line
alone, which command puts that thing right.

**Behaviour.**

* `doctor` on a scratch repository just installed prints ten warns, and
  every one ends with its fix in parentheses: eight name `/initialize`, the
  graph and the hook keep the fix they already name.
* `doctor` on a target with `docs/manuals/process.md` deleted names it
  once, with `(focus-kit update restores it)`, and does not print the drift
  `ok` line. The drift pass still says nothing about a path the presence
  line named, so the wording of the two has to be the same.
* `doctor` on a machine without uv or graphify names `focus-kit update`,
  which is the command that installs both (`ensure_uv`, `ensure_graphify`).
* Check 2 of the verify command asserts the ten warns of the scratch through
  `line="$(warn "$expected")"`, the way it asserts the merged-file probe, so
  the reporter and the assertion cannot drift. Today they are ignored.
* The rule this enforces already exists: `docs/04-Conventions.md` §1, "a
  `warn` says what to do next". No new rule, no new term.

**Contract.** Six warn sites in `doctor` change text. Every other line of
`doctor`, green or warn, is byte for byte what it is today, in the same
order.

| Site today | Line after |
|---|---|
| `uv missing` | `uv missing (run focus-kit update)` |
| `graphify missing` | `graphify missing (run focus-kit update)` |
| `graphify-mcp missing` | `graphify-mcp missing (run focus-kit update)` |
| `/<s> missing` (three commands) | `/<s> missing (focus-kit update restores it)` |
| `<f> missing`, `docs/00` to `06`, `CLAUDE.md` | `<f> missing (run /initialize)` |
| `<f> missing`, the three manuals | `<f> missing (focus-kit update restores it)` |

The kit-owned lines carry the drift wording verbatim, so the Drift term in
`docs/03-Domain.md` keeps three shapes and no fourth. The one loop over the
eleven paths becomes two, project-owned then manuals, in today's order;
`$missing` is fed by both, as it is today.

Check 2 of `selftest` gains two assertions on the scratch: the ten warn
lines of the first `doctor` run, each built by calling `warn`; then one
probe, `docs/manuals/process.md` deleted, one `doctor` run must contain
its line exactly once and not the drift `ok` line, and the manual is
restored by copy from `manuals/`, as the template probe is.

`VERSION` goes from `0.8.0` to `0.8.1`: a target wants a `doctor` that
names its fixes.

**Slice.** `bin/focus-kit`, `doctor` (six sites) and `check_install` (check
2). Kit-owned behaviour. Docs that own it, updated in the same delivery:
`docs/01-Architecture.md` §3 `doctor` row (every warn names its fix);
`docs/04-Conventions.md` §1 warn bullet (the reference `bin/focus-kit:146`
is off by one and points at a line that names why and not what fixes it;
point it at a `doctor` line instead); `docs/05-Process.md` §4 check 2 (the
ten warns are asserted, not ignored, and the manual probe); `docs/03-Domain.md`
Drift (the presence lines print the absent shape for the six they name).

**States.**

* Scratch after install: the Visual reference below.
* Fresh Windows install, first shell: uv and graphify still read missing
  (README says why: `~/.local/bin` is not on that shell's PATH). The line
  names `focus-kit update`, and `update` there dies with "open a new shell
  and run again", which is the real fix. No second parenthesis for this.
* Not a git repository: unchanged, the hook line is skipped.
* A target with no stamp: unchanged, no drift pass and no version line.

**Visual reference.** `doctor` on a scratch repository just installed. This
is the real run, `mktemp -d` plus `git init` plus `focus-kit install`, with
the colour stripped; it is the expectation of the page, line for line:

```
focus-kit 0.8.1 doctor: /var/folders/09/f_09y2b90h3_bpd38q1nfbmr0000gn/T/tmp.s62if1RFBL
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.8.1
  ! docs/00-Product.md missing (run /initialize)
  ! docs/01-Architecture.md missing (run /initialize)
  ! docs/02-Backend.md missing (run /initialize)
  ! docs/03-Domain.md missing (run /initialize)
  ! docs/04-Conventions.md missing (run /initialize)
  ! docs/05-Process.md missing (run /initialize)
  ! docs/06-Queue.md missing (run /initialize)
  ! CLAUDE.md missing (run /initialize)
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ .claude/settings.json
  ✓ kit-owned files as install wrote them
  ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
  ! graphify post-commit hook not installed (graphify hook install)
```

**Out of scope.**

* The `install` warn `graphify-mcp not on PATH; the MCP server in .mcp.json
  needs it` (`ensure_graphify`): names why, not the fix. Its own line in the
  queue if it is wanted; this delivery is `doctor`.
* Collapsing the eight docs lines into one: a bigger contract change for
  the same information, and the per-file green lines are worth keeping.
* A probe for the three tool lines: selftest cannot uninstall uv. Proven by
  reading the code path, recorded in the done page.
* A probe for a deleted command folder: the manual probe proves the shape,
  and `copy_tree` restore is more machinery than the line is worth.
* The pasted output in `work/done/first-target-install.md`: history.

---

## What happened

**Nothing diverged from the plan and nothing was dropped.** The six warn
sites are the six the Contract names, the loop became two in the same order,
and check 2 gained the two assertions. The real scratch run above matches
the page's Visual reference line for line, so the expectation was right and
nothing had to be corrected against it (`docs/05-Process.md` §6).

**One decision the page did not settle: how to assert "exactly once".** The
presence line for a deleted manual and the line the drift pass would print
are the same string, which is the whole point of the Contract, so `grep -q`
cannot tell one from two and the assertion has to count. The count goes
inside the test:

```sh
if [ "$(printf '%s\n' "$out" | grep -cF -- "$line")" -ne 1 ]; then
```

and not into an assignment, because `grep -c` exits 1 on a count of zero and
`set -e` would end the script there, before the `die` that explains what
broke. The file already chose `if` over an `&&` list at the template probe
for the neighbouring reason; this is the second occurrence of that shape and
no abstraction was built for it. No ADR: it is a shell mechanic, recorded in
`docs/05-Process.md` §4 where the probe is described.

**The proof.** `bin/focus-kit selftest`, six `ok` lines, after the install:

```
focus-kit 0.8.1 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

**The two red runs, by hand.** A wrong parenthesis on either of the two new
loops has to turn check 2 red, so both were tried and reverted.

The docs loop, `(run /initialize)` changed to `(run focus-kit update)`:

```
error: check 2: doctor did not report docs/00-Product.md missing (run /initialize) in the scratch repository
```

The manuals loop, `(focus-kit update restores it)` changed to
`(run /initialize)`:

```
error: check 2: doctor did not report a deleted manual exactly once in the scratch repository
```

The second one is the interesting red: the count came back 0, not 2. The
presence line printed the wrong words, and the drift pass stayed silent
because `$missing` holds the path either way, so the probe catches a wording
that drifted from the drift wording and not only a line printed twice. That
is the coupling the Contract asks for, and it is now asserted.

**The three tool lines, proven by reading.** `selftest` cannot uninstall uv,
so these three are read and not run (Out of scope). The whole of what
changed:

```sh
command -v uv >/dev/null 2>&1        && ok "uv"          || warn "uv missing (run focus-kit update)"
command -v graphify >/dev/null 2>&1  && ok "graphify"    || warn "graphify missing (run focus-kit update)"
```

and, inside the `graphify-mcp` branch that runs when graphify itself is
absent, `warn "graphify-mcp missing (run focus-kit update)"`. The three name
`focus-kit update` because it is the command that installs both: `ensure_uv`
and `ensure_graphify` run inside it and nowhere else. The three command
lines (`/initialize`, `/propose`, `/apply`) are covered by no probe either,
for the reason Out of scope gives; their line is
`warn "/$s missing (focus-kit update restores it)"`, the drift wording
verbatim, which the manual probe does assert on a kit-owned path.

**The graph was not consulted.** The `graphify` MCP server failed to connect
in this session (`CONNECTION_CLOSED`), and the slice is one file,
`bin/focus-kit`, so the two functions were read directly. Nothing was
grepped blind. Recorded because the skill asks for the graph first and it
was not available.

**Docs updated, the four the Slice named plus one it did not.**

* `docs/01-Architecture.md` §3: the `doctor` row says every warn names its
  fix and why the eleven paths are two loops. The line numbers of `selftest`
  and of the six `check_*` functions moved with the 72 lines `doctor` and
  `check_install` gained, and were corrected. So did the three references to
  the dispatch `case`, `bin/focus-kit:797` to `:860`, one each in
  `docs/00-Product.md`, `docs/01-Architecture.md` and
  `docs/04-Conventions.md`. Every other `bin/focus-kit:<n>` in the
  repository points above line 349 and did not move. Nothing else quotes a
  `doctor` line as sample output: `README.md`, `manuals/`, `skills/` and
  `docs/manuals/` were grepped for the old bare `missing` wording and are
  clean, so no kit-owned text went stale with this change.
* `docs/04-Conventions.md` §1: the warn bullet pointed at `bin/focus-kit:146`,
  which is the `install` warn that names why and not what fixes it. It now
  points at `bin/focus-kit:355`, the uv line of `doctor`, and says the test:
  a person reading one `!` line, without the rest of the output, knows what
  to type.
* `docs/05-Process.md` §4 check 2: the ten warns are asserted and no longer
  ignored, and the manual probe is described with its `grep -c` mechanic.
* `docs/03-Domain.md` Drift: three shapes and no fourth, because the six
  kit-owned paths the presence lines name print the absent shape word for
  word.
* The fifth, not in the Slice and false after this delivery: check 6 of
  `docs/05-Process.md` §4 said its warns are ignored "as check 2 ignores a
  scratch repository's". Check 2 no longer ignores them. The sentence now
  says why the two differ: a scratch is the same tree every time and this
  repository is not.

**Environments.**

| Environment | State |
|---|---|
| Kit source | `0.8.1`. `bin/focus-kit`, `VERSION` and the four docs edited. |
| Dogfood copy | `0.8.1`, `focus-kit install .` run, check 6 green. |
| Machine (`~/.local/bin/focus-kit`) | a symlink to the kit source, so `0.8.1` with no command. Global `/graphify` skill green. |
| First target (`~/Downloads/vaulted`) | `0.8.1`, `focus-kit update ~/Downloads/vaulted` run. `doctor` there prints the eight `(run /initialize)` lines, which is what the delivery is for: that repository has not had `/initialize` run in it yet (`first-target-initialize` is the next queue line). Nothing committed there: `HEAD` is still `f6e685c`, the kit's files are untracked. |
| Target repositories (anyone else's) | untouched. They move when their owner runs `focus-kit update`. |

**Done when.**

- [x] `bin/focus-kit selftest` green, six `ok` lines.
- [x] Check 2 asserts the ten warns and the manual probe, so a wrong
      parenthesis on the docs lines or the manuals lines makes it red (tried
      once by hand, both reds pasted above). The tool and command lines are
      proven by reading, as Out of scope says, and the code is quoted above.
- [x] `VERSION` is `0.8.1`; `focus-kit install .` run here; check 6 empty.
- [x] The four docs named under Slice updated, and a fifth sentence in
      `docs/05-Process.md` that this delivery made false.
- [x] `focus-kit update ~/Downloads/vaulted` run; nothing committed there.
- [x] Queue line `[>]` to `[x]`; this page moved to `work/done/` with the
      real scratch output in place of the Visual reference.
