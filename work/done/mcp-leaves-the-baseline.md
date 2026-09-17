# mcp-leaves-the-baseline

**Goal.** A target repository stops receiving an MCP server that nothing the
kit ships ever calls, so a session no longer spawns `graphify-mcp` at start
and `doctor` stops reporting a tool the process does not use. The three
skills call the `graphify` CLI through Bash; measured before this page, 38
sessions here and 347 in two targets made zero MCP calls.

**Behaviour.**

* `focus-kit install` into a scratch repository writes no `.mcp.json`, and
  the `.claude/settings.json` it writes carries no `enabledMcpjsonServers`.
* `focus-kit install` installs `graphifyy` without the `mcp` extra, and its
  ok line for graphify no longer mentions an extra.
* `doctor` after a fresh install prints one line for `.claude/settings.json`
  and none for `.mcp.json` or `graphify-mcp`.
* `doctor` on a target whose `.claude/settings.json` reads `{}` warns that the
  baseline permissions are missing and names `focus-kit update`.
* `doctor` on a target that installed an earlier kit prints one Leftover warn
  per file still carrying the server, each naming the hand removal and the
  manual section that explains it. `update` leaves both files as they are.
* `bin/focus-kit selftest` is green, and check 2 asserts every line above.

**Contract.** What a target receives shrinks, so this is a contract change.

* `config/mcp.baseline.json`: deleted. `.mcp.json` leaves every ownership
  table (README, `docs/01` §4 and §5, `docs/03` Merged).
* `config/settings.baseline.json`: the `enabledMcpjsonServers` key removed;
  `permissions` byte for byte as today.
* `bin/focus-kit`, kit-owned nowhere, five functions:
  * `ensure_graphify`: `uv tool install graphifyy`; the say, die and ok
    lines drop "with the mcp extra" and name `uv tool install graphifyy`;
    the `graphify-mcp not on PATH` warn goes.
  * `merge_json`: the `mcpServers` rule leaves the comment and the python.
    Four rules remain, one caller.
  * `install_repo`: the `.mcp.json` merge and its ok line go.
  * `doctor`: the three-branch `graphify-mcp` block and the `.mcp.json`
    block go. The `.claude/settings.json` block keeps its missing warn and
    asks `grep -qF '"Bash(graphify *)"'`: ok `.claude/settings.json`, else
    warn `.claude/settings.json lacks the baseline permissions (run focus-kit
    update)`. After it, the Leftover pass, two warns at most, each behind an
    `-f` guard and the same fixed-string heuristic the block it replaces
    accepted: `.mcp.json still declares the graphify server (remove its
    graphify entry by hand; docs/manuals/graphify.md §Troubleshooting)` when
    the file holds `"graphify-mcp"`, and `.claude/settings.json still enables
    the graphify server (remove graphify from enabledMcpjsonServers by hand;
    docs/manuals/graphify.md §Troubleshooting)` when it holds both
    `"enabledMcpjsonServers"` and `"graphify"`.
  * `check_install`: the expected ok list loses `.mcp.json`. After the
    install it asserts that `.mcp.json` is absent and that
    `enabledMcpjsonServers` is not in the settings file, since absence is
    what this delivery ships. The `{}` probe keeps settings only and asserts
    the permissions warn. A second probe writes the shape an earlier kit
    left, `.mcp.json` with the graphify entry and a settings file with
    `enabledMcpjsonServers: ["graphify"]`, asserts the two Leftover warns
    word for word, then restores the scratch byte-exact before check 3
    snapshots it.
* `manuals/graphify.md` (kit-owned): the MCP server row leaves The pieces;
  the `.mcp.json` bullet leaves Rules; the three MCP entries leave
  Troubleshooting and one enters, headed **`doctor` says a file still
  declares or enables the graphify server**: an earlier kit merged the entry,
  this one ships neither and never removes what it merged; delete the
  `graphify` entry under `mcpServers` (the file, when nothing else is in it)
  and the `graphify` item under `enabledMcpjsonServers` (the key, when the
  list is then empty).
* `skills/initialize/SKILL.md`: "the graph is what the MCP server in
  `.mcp.json` reads from the next session on" becomes "the graph is what
  `/propose` and `/apply` read from the next session on".
* `VERSION`: `0.11.0` to `0.12.0`.
* This repository's own files: `.mcp.json` removed with `git rm`;
  `enabledMcpjsonServers` removed from `.claude/settings.json` by hand, the
  CLI never removes; `focus-kit install .` last. The docs the Contract
  names: `docs/00` Installing, `docs/01` §2 (the "Out, by decision" bullet
  on MCP servers records the measurement in the Goal and the date), §3 (the
  five function rows), §4, §5; `docs/03` (Settings baseline rewritten, MCP
  baseline row deleted, Merged rewritten for one file; Leftover is already
  there); `docs/05` §4 check 2; `README.md` install list and ownership
  table; `docs/06` Later (uninstall unmerges one key; the `graphify-mcp not
  on PATH` bullet leaves, resolved). ADR-0001, ADR-0002 and ADR-0005 keep
  their text and gain one dated line where they name `.mcp.json`, pointing
  at this slug.

**Slice.** `bin/focus-kit`, `config/`, one manual, one skill, this
repository's docs. No FOCUS pieces to name (ADR-0003): the functions above
are the whole of it. Kit-owned: the manual and the skill. Merged: the
settings baseline, smaller. Deleted from the kit: the MCP baseline.

**States.** Install prints one ok line fewer, `.claude/settings.json
(baseline permissions merged)` still last among the merges. `doctor` prints
twelve green lines on a fresh install instead of fourteen, and the ten warns
`docs/05` §4 lists are unchanged. On an earlier target, the two Leftover
warns; on a `{}` settings file, the permissions warn; the defaults otherwise.

**Visual reference.** The lines that change in `doctor`, everything else as
today:

```
gone:  ok   graphify-mcp (mcp extra)
gone:  ok   .mcp.json
same:  ok   .claude/settings.json
new:   warn .claude/settings.json lacks the baseline permissions (run focus-kit update)
new:   warn .mcp.json still declares the graphify server (remove its graphify entry by hand; docs/manuals/graphify.md §Troubleshooting)
new:   warn .claude/settings.json still enables the graphify server (remove graphify from enabledMcpjsonServers by hand; docs/manuals/graphify.md §Troubleshooting)
```

**Out of scope.**

* `focus-kit uninstall`: stays in Later. A Leftover warn is not an unmerge.
* Removing the Leftover from a target: the CLI adds and never removes
  (ADR-0002); the person does, told by `doctor`.
* Keeping the extra for someone who runs `graphify-mcp` outside the kit:
  their `uv tool install 'graphifyy[mcp]'` is theirs to run.
* What the skills ask the graph: `graph-answers-structure`, the next line.
* `.claude/settings.local.json` here, which allows two `mcp__graphify__`
  tools: untracked, the person's own.

**Done when.**

* `bin/focus-kit selftest` green, check 2 with the two probes.
* `VERSION` at `0.12.0`; `focus-kit install .` run here, `.mcp.json` gone
  from git, `enabledMcpjsonServers` gone from `.claude/settings.json`.
* Proof, this repository: `doctor` run before the hand removal prints the
  two Leftover warns word for word, transcript in the done page; after it,
  none.
* Proof, machine: what `uv tool install graphifyy` printed over an existing
  `graphifyy[mcp]`, and what `uv tool list --show-extras` says after, in the
  done page.
* The first target: `focus-kit update` there, the two hand removals, `doctor`
  with no warn; nothing committed there.
* Every doc the Contract names updated; the three ADR lines added.
* The queue line `[x]`, the Later list edited.
* The last thing said is which environment is at which version.

---

## What happened

Built as written. Twelve places, no surprise in any of them: the delivery
page's **States** section predicted twelve green lines and ten warns on a
fresh install, and the scratch repository printed exactly twelve and ten.

### What diverged from the plan

* **The plan named five functions in `bin/focus-kit`; six things changed.**
  The script's header comment is the sixth, and it is user-facing text:
  `--help` prints it through `awk`, every line after the shebang
  (`help-text-follows-header`). It named "graphify with its mcp extra" and
  listed `.mcp.json` among what install writes. Both lines are gone. A
  Contract that lists functions and forgets the header ships a `--help` that
  lies.
* **`merge_json` lost a parameter, not only a rule.** The `mcpServers`
  carve-out was the only reader of `merge(d, b, parent)`'s third argument, so
  removing the rule left `parent` dead and the recursive call passing `k` for
  nothing. Both went. Four ordered cases remain, one caller.
* **Three comments counted things that changed.** `doctor`'s "the three tool
  lines" became two when the `graphify-mcp` block went, and "The two Merged
  files" became one. `docs/01` §3 carried the same two counts.
* **`docs/05` §4 gained a paragraph the Contract did not name.** Check 2 now
  asserts two absences (`.mcp.json` not written, `enabledMcpjsonServers` not
  merged) that no line of `doctor` can report, because nothing reports a file
  the kit stopped touching. The verify command's description says so, or the
  next reader assumes `doctor` covers it.
* **`docs/04-Conventions.md` was not in the Contract and was edited.** It
  cites `bin/focus-kit:NNN` four times, and the delivery removed about thirty
  lines from the script. Every `bin/focus-kit:NNN` in `docs/00`, `docs/01`,
  `docs/03` and `docs/04`, plus the Line column of `docs/01` §3, was
  refreshed against the file as it now stands. The ADRs keep their stale
  numbers, because the Contract says they keep their text.

### What was dropped

* **Nothing from the scope.** Every bullet of Behaviour and Contract shipped.
* **The `.graphifyignore` line missing from the script's header.** The header
  lists what install writes and has never named `.graphifyignore`, which
  `graph-ignores-the-kit` added. It is one line in text this delivery already
  edited, and it is that delivery's gap, not this one's. Left out on purpose
  rather than widened into; a queue line is the honest place for it.
* **Removing the Leftover from a target.** As planned: the CLI adds and never
  removes (ADR-0002). The person does, told by `doctor`.

### What the proof found

**The two Leftover warns, this repository, before the hand removal**
(`doctor` run with the new CLI while `.mcp.json` and the
`enabledMcpjsonServers` key were both still there):

```
  ✓ .claude/settings.json
  ! .mcp.json still declares the graphify server (remove its graphify entry by hand; docs/manuals/graphify.md §Troubleshooting)
  ! .claude/settings.json still enables the graphify server (remove graphify from enabledMcpjsonServers by hand; docs/manuals/graphify.md §Troubleshooting)
  ✓ kit-owned files as install wrote them
```

After `git rm .mcp.json` and the key removed by hand, the same run prints
neither, and `.claude/settings.json` stays green on its permissions.

**The machine.** `uv tool install graphifyy` over an existing
`graphifyy[mcp]` is not a no-op: uv resolved thirty packages, uninstalled
twenty-eight (`mcp`, `pydantic`, `starlette`, `uvicorn` and the rest of the
server's tree) and reinstalled the two executables. It printed no "is already
installed", so `ensure_graphify` took its other branch and said
`installing graphify (uv tool install graphifyy)` with uv's output under it,
which is the correct line for what actually happened.

```
$ uv tool list --show-extras        # before
graphifyy v0.9.63 [extras: mcp]
$ uv tool list --show-extras        # after
graphifyy v0.9.63
```

`graphify-mcp` is still on PATH: it is an entry point of graphifyy whether or
not the extra is there, and it now dies on import, which is the state the kit
no longer has an opinion about.

**The three new assertions are not vacuous.** Each was mutation-tested and
each turned check 2 red:

| Mutation | What check 2 said |
|---|---|
| `doctor`'s `.mcp.json` Leftover warn reworded | `doctor did not report .mcp.json still declares the graphify server (...)` |
| `enabledMcpjsonServers` put back in the settings baseline | `the settings baseline put enabledMcpjsonServers into the scratch repository` |
| `install_repo` writing an `.mcp.json` again | `the install wrote .mcp.json into the scratch repository` |

One thing to know about that test: `git checkout -- config/settings.baseline.json`
restores from the index, and the baseline edit had not been staged, so the
revert took the delivery's own change with it. Caught by re-reading the file;
worth remembering the next time a mutation is undone with git.

**`focus-kit selftest`: green**, six checks, before and after the doc sweep.

### Decisions taken

* **The `"graphify"` grep keeps its quotes.** A bare `graphify` matches the
  `"Bash(graphify *)"` permission every target has, which would fire the
  Leftover warn on a clean install. Quoted, the character before `graphify`
  is `(` and after is a space, so it cannot match. The block being replaced
  made the same choice, and the accepted limit is the same: the heuristic
  cannot see which key `"graphify"` sits under.
* **The `.mcp.json` of the Leftover probe is deleted, not moved back.** Check
  3 snapshots the same scratch, and the install never wrote an `.mcp.json`,
  so restoring one would be a false idempotency failure. The settings file
  goes aside and returns byte-exact, as the other probes do.
* **No ADR.** Nothing here is expensive to reverse: the entries a target
  already has stay where they are, and a future delivery that needs an MCP
  server declares one by naming what would call it. Three existing ADRs
  gained a dated line each instead, at the first place they name `.mcp.json`:
  ADR-0001 (a target now keeps no reference to either dependency at all),
  ADR-0002 (`.claude/settings.json` is the only merged file, and "nothing is
  ever removed" is what made the Leftover warns necessary), ADR-0005 (the
  first-session MCP failure it listed as a cost is gone with the server).
* **`docs/03` keeps the MCP server term.** The kit no longer ships the server,
  but two `warn` lines still name it and the manual's new Troubleshooting
  entry explains it. The row now says what it was, when it left and who
  installs it now.

### The first target (`~/Downloads/vaulted`)

`focus-kit update ~/Downloads/vaulted` brought it to 0.12.0. `doctor` there
printed both Leftover warns; the `.mcp.json` held nothing but the graphify
entry and `enabledMcpjsonServers` held nothing but `"graphify"`, so the
manual's own instruction applied in its strongest form: the file deleted and
the key deleted. `doctor` after: neither warn, `.claude/settings.json` green,
`kit version 0.12.0`. Nothing was committed or staged there.

**Divergence from "Done when".** The page asked for `doctor` with no warn.
It printed nine: the eight `docs/00` to `06` and `CLAUDE.md` lines and the
missing graph. That clone no longer has the documents `first-target-initialize`
wrote (`ls docs/` shows only `launch-copy.md`, `show-hn-draft.md` and
`manuals/`), so those warns are the correct report of a target `/initialize`
has not run in, and nothing in this delivery caused or could fix them. What
this delivery is answerable for, the two Leftover warns, went from two to
zero. The expectation was written assuming a state the clone has since lost;
what the command produced wins (`docs/05-Process.md` §6).

### Done when

* [x] `bin/focus-kit selftest` green, check 2 with the two probes (the `{}`
  settings probe and the Leftover probe), plus the two absence assertions.
* [x] `VERSION` at `0.12.0`; `focus-kit install .` run here; `.mcp.json` gone
  from git (`git rm`); `enabledMcpjsonServers` gone from
  `.claude/settings.json`, removed by hand.
* [x] Proof, this repository: the two Leftover warns word for word before the
  hand removal, transcript above; none after.
* [x] Proof, machine: what `uv tool install graphifyy` printed over an
  existing `graphifyy[mcp]`, and `uv tool list --show-extras` after, above.
* [~] The first target: `focus-kit update` run, the two hand removals done,
  nothing committed. **Diverged:** `doctor` there is not warn-free, because
  that clone no longer holds the documents `/initialize` wrote. The two warns
  this delivery owns are gone. Reason above.
* [x] Every doc the Contract names updated, plus `docs/04-Conventions.md`
  (line references) and the script's header comment. The three ADR lines
  added.
* [x] The queue line `[x]`; the Later list edited (uninstall unmerges one key,
  the `graphify-mcp not on PATH` bullet removed as resolved).
* [x] The last thing said is which environment is at which version.

### Environments

| Environment | State |
|---|---|
| Kit source | 0.12.0. `bin/focus-kit`, `config/settings.baseline.json` (one key smaller), `config/mcp.baseline.json` deleted, `manuals/graphify.md`, `skills/initialize/SKILL.md`, `VERSION`. |
| Dogfood copy | 0.12.0. `focus-kit install .` run here; check 6 green. This repository's `.mcp.json` removed with `git rm`, `enabledMcpjsonServers` removed from `.claude/settings.json` by hand, never by the CLI. |
| Machine | CLI untouched, a symlink that follows the source. graphify 0.9.63 **without** the `mcp` extra now, reinstalled by this delivery's own `install` run. Global `/graphify` skill green at the package's version. |
| First target | 0.12.0, both Leftovers removed by hand, nothing committed. |
| Other targets | untouched, as always. Each moves when its owner runs `focus-kit update`, and `doctor` there names the two Leftovers until that person removes them. |
