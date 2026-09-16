# graph-ignores-the-kit

**Goal.** A person who asks the graph of a target repository gets the
target's own code and documents back, not the kit's manuals and skills.

**Behaviour.**

* `focus-kit install` and `update` leave a `.graphifyignore` in the target
  that excludes the six kit-owned files: the three skills and the three
  manuals. Measured before this delivery: 214 of the 498 nodes in the first
  target's graph came from those files, and 139 of the 487 nodes in this
  repository's own graph came from the dogfood copy of the same files.
* A target's own `.claude/skills/deploy/` or `docs/manuals/runbook.md` stays
  in the graph: the fragment names files, not the two folders.
* A second `install` or `update` appends nothing: the marker is already
  there. A target whose `.graphifyignore` already exists gets the fragment
  after one blank line, everything it held kept.
* After `focus-kit update` and the third branch of "Ensuring the graph"
  (`graphify update .`), no node of the graph has a source under either
  path. If the incremental update keeps nodes of files now ignored, the
  record says so and names the full rebuild as the way out.
* This repository is also a target: its graph stops holding every manual and
  skill twice, once from the source and once from the dogfood copy.

**Contract.**

`config/graphifyignore.fragment`, kit source, in gitignore syntax, opening
with the same marker line `# --- focus-kit ---` that `gitignore.fragment`
opens with, one comment line saying why, then six lines:
`.claude/skills/initialize/`, `.claude/skills/propose/`,
`.claude/skills/apply/`, `docs/manuals/process.md`,
`docs/manuals/focus.md`, `docs/manuals/graphify.md`. Nothing else: the two
folders may hold the target's own files, and `work/` is project-owned; the
project decides about both in its own copy of the file.

`install_repo` appends it to `$target/.graphifyignore` right after the
`.gitignore` block, by the same marker test. That is the second concrete
occurrence of "appended once"; the first is the `.gitignore` block at
`bin/focus-kit:320`. Both become one function, `append_once`, taking the
target file and the fragment path, and the two blocks become two calls. The
`ok` line: `.graphifyignore (kit fragment appended)`.

`.graphifyignore` is the target's file, versioned by the target like its
`.gitignore`. `doctor` does not report it, as it does not report
`.gitignore`. Check 3 of `selftest` proves the second run appends nothing:
it copies the scratch, runs `install_repo` again and diffs the two trees
(`bin/focus-kit:742`).

**Slice.** `config/` (one new fragment), `bin/focus-kit` (`install_repo`,
`append_once`), one manual (`manuals/graphify.md`, kit-owned), and the docs
that describe what install writes: `docs/00-Product.md`,
`docs/01-Architecture.md` (tree and the boundaries table), `README.md` (the
ownership table). The Appended once row of `docs/03-Domain.md` already
names both files and `append_once()`; it changes again only if the run
teaches something. Appended once in every target.

**States.** A first install prints, after the settings line:

```
ok .gitignore (kit fragment appended)
ok .graphifyignore (kit fragment appended)
```

A second run prints neither. A target that is not a git repository behaves
as today: the existing warn, then the same two lines.

**Visual reference.** No UI. The lines above.

**Out of scope.** Removing the MCP server from the baselines: twelve places,
its own page, `mcp-leaves-the-baseline`. Ignoring `work/done/`: the project's
decision, in its own copy. A `doctor` line for appended files: neither file
has one today, and adding one to both is a separate choice. Repositioning
the graph in the three skills: `graph-answers-structure`.

**Done when.** `bin/focus-kit selftest` green. `VERSION` bumped: every
target wants this. `focus-kit install .` run here, so the dogfood copy is at
the delivery's version and this repository has its own `.graphifyignore`.
`focus-kit update ~/Downloads/vaulted` run, nothing committed there, and
`graphify update .` in both repositories with the node count from the two
paths recorded, before and after. The docs in **Slice** updated. The queue
line `[x]`. The last thing said is which environment is at which version.

---

## What happened

The delivery landed as written. One fragment, one function, two calls, and
the number the Goal exists for came out exactly as measured: `graphify
update .` pruned **139 nodes in this repository** and **214 in the first
target**, the same counts the page predicted, from 16 files each time.

Nothing was dropped and no ADR was written. Reversing this is deleting eight
lines from a file the target owns.

### The proof

**The two `ok` lines of States, from the real run.** `focus-kit install .`
here printed only the second, because this repository's `.gitignore` already
carried the marker, which is Appended once working:

```
installing focus-kit 0.9.0 into /Users/jckodel/Projects/focus-kit
  ✓ .claude/skills/{initialize,propose,apply}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ .claude/skills/.focus-kit-manifest
  ✓ .mcp.json (graphify server)
  ✓ .claude/settings.json (baseline permissions merged)
  ✓ .graphifyignore (kit fragment appended)
```

A first install prints both, which the scratch probe below shows.

**Behaviour item 3, the pre-existing file, proved by hand.** Nothing in
`selftest` covers it, and `docs/05-Process.md` §3 says every line of
Behaviour becomes a test or a manual check. A scratch repository with a
one-line `.graphifyignore` of its own, then `install`, then `install` again:

```
  ✓ .gitignore (kit fragment appended)
  ✓ .graphifyignore (kit fragment appended)

vendor/
                              <- one blank line, inserted because the file had something in it
# --- focus-kit ---
# graphify: the kit's own skills and manuals are not this project's code
.claude/skills/initialize/
(five more)
```

The second run printed neither line and the file stayed at ten lines.
`vendor/` survived, which is the whole of the promise.

**Behaviour item 4, and the one prediction the page hedged.** The page said:
"If the incremental update keeps nodes of files now ignored, the record says
so and names the full rebuild as the way out." It does not. `graphify update
.` prunes them, and it does it without `--force` even though the graph ends
up smaller, which is the case `--force` exists for. graphify 0.9.63 derives
its prune set from the graph's own `source_file` entries rather than from the
manifest, so a file that became excluded is pruned exactly like a file that
was deleted. Both runs said so in one line:

```
[graphify watch] pruned 139 node(s) from 16 newly-ignored file(s)
  (matched by a live ignore rule while absent from the scan corpus)
[graphify watch] Rebuilt: 376 nodes, 395 edges, 46 communities
```

```
[graphify watch] pruned 214 node(s) from 16 newly-ignored file(s)
  (matched by a live ignore rule while absent from the scan corpus)
[graphify watch] Rebuilt: 403 nodes, 569 edges, 28 communities
```

No full rebuild was needed anywhere, and neither `cost.json` moved: this
repository's ledger is still one run of 187,743 input tokens and the target's
still one of 433,524. The delivery cost no tokens at all.

**The node counts, before and after, both repositories.**

| Repository | Nodes from `.claude/skills/` and `docs/manuals/` | Total |
|---|---|---|
| focus-kit, before | 139 | 502 |
| focus-kit, after | **0** | 376 |
| first target, before | 214 | 498 |
| first target, after | **0** | 403 |

**Behaviour item 2, that the fragment names files and not the two folders.**
The only place it can be proved without creating a file in someone else's
clone is here, and it has a second side the page states and a count alone
would miss: the block must not swallow the kit's own sources. After the
update, `skills/` and `manuals/` still hold **69 nodes**, `manuals/focus.md`
the largest at 18. Every pattern carries a slash, so gitignore anchors it to
the root, and `.claude/skills/initialize/` leaves `skills/initialize/`
alone.

**Behaviour item 5.** This repository's graph stopped holding the manuals
twice. `docs/manuals/focus.md` had 18 nodes and `manuals/focus.md` has 18;
before the change both were in the graph, saying the same things under two
paths.

**The first target's graph is now the target's own.** Its largest sources
after the update are `docs` (116, its own `docs/00` to `06` and its blog),
`app` (59), `package.json` (44), `lib` (43) and `components` (27). Before it,
`docs/manuals/focus.md` alone was 68.

**`focus-kit doctor ~/Downloads/vaulted`**: 24 green lines, no warn, exit 0,
`kit version 0.9.0`. `git status --short` there gained exactly one path,
`?? .graphifyignore`, and nothing else moved. Nothing was staged, committed
or pushed; `git log --oneline -1` is still `f6e685c`.

### What diverged, and why

**The marker is read from the fragment, not written a third time.** The page
said `install_repo` appends "by the same marker test". The literal `# ---
focus-kit ---` lived inside `install_repo`, and a second call would have made
it a third copy of a string that already exists at the top of two fragments.
`append_once` reads it with `head -n 1 "$fragment"` instead, so the marker a
file receives and the marker the next run looks for are the same bytes by
construction. Same test, one fewer place to edit.

**Four line references in `docs/03` and `docs/04` changed, and the Slice does
not name those files.** `append_once` and its comment are 16 lines above
`install_repo`, and the two calls made the append block two lines longer, so
a citation inside `install_repo` moved 16 and one below it moved 18:
`bin/focus-kit:280` became `:296`, and `:328`, `:355` and `:860` became
`:346`, `:373` and `:878`. Those citations
appear in `docs/03-Domain.md` and `docs/04-Conventions.md` as well as in
`docs/01`. Not a word of content changed in either file, only the numbers,
and leaving them would have left two documents pointing at the wrong lines in
the same commit that moved them. Recorded rather than resolved silently, as
`docs/05-Process.md` §6 asks.

The page's own Contract cites `bin/focus-kit:320` and `bin/focus-kit:742`;
after this delivery those are 338 and 760. The page is a record and was right
when it was written.

**One line in `.gitattributes`, which the Slice does not name either.** The
kit claims Windows (`docs/05-Process.md` §6), and `.gitattributes` is what
keeps every file that goes into a target at LF. `git check-attr text eol`
answered `set` and `lf` for `config/gitignore.fragment` and **`unspecified`
for both on the new fragment**. A clone on Windows with `core.autocrlf=true`
would have checked it out as CRLF, and the target's `.graphifyignore` would
have been written with `.claude/skills/initialize/\r` in it, which matches no
path. Appended once would have survived, because the marker is read from the
same file it is compared against, so the failure would have been silent: the
file present, the block there, and the six paths still in the graph. One line
fixes it and it belongs in this delivery, because the file it protects is
this delivery's.

**Two counts in `docs/01` §2 and §3.** The stack line said "3 config
fragments" and there are now four; §3 said "three verbs and nine helpers" and
there are now ten. Both were arithmetic the delivery forced.

**`docs/03-Domain.md` was not touched.** The page said its Appended once row
"changes again only if the run teaches something". It already named both
files, both fragments and `append_once()`, written by this delivery's
`/propose`, and the run taught nothing that belongs there. What the run did
teach, that an incremental update prunes a newly excluded file, is a graphify
fact and went into the manual.

### Decisions

No ADR. The page said so and nothing in the run argued otherwise: the
decision it would record is "the kit's own files are not the project's code",
which `docs/00-Product.md` already states as a rule of product, and undoing
it is deleting a block from a file the target owns.

The abstraction is the one the page named. `append_once` is the second
concrete occurrence of Appended once; the first was the `.gitignore` block,
which was at `bin/focus-kit:320` and is now one of the function's two
callers.

### Done when, ticked

* [x] `bin/focus-kit selftest` green. Six checks, including check 3, which is
  what proves the second install appends nothing.
* [x] `VERSION` bumped, `0.8.1` to `0.9.0`. A minor, on the precedent of
  every other delivery that gave a target something it did not have.
* [x] `focus-kit install .` run here: the dogfood copy is at `0.9.0` and this
  repository has its own `.graphifyignore`.
* [x] `focus-kit update ~/Downloads/vaulted` run. Nothing committed there.
* [x] `graphify update .` in both repositories, node counts from the two
  paths recorded before and after: 139 to 0 here, 214 to 0 there.
* [x] The docs in **Slice** updated: `manuals/graphify.md` (a new section and
  a new rule), `docs/00-Product.md`, `docs/01-Architecture.md` (the tree, the
  boundaries table, the stack line and the function table) and `README.md`
  (the ownership table and the layout).
* [x] The queue line `[x]`.
* [x] The last thing said is which environment is at which version.

### Environments

| Environment | State |
|---|---|
| Kit source | `0.9.0`. `bin/focus-kit`, `config/graphifyignore.fragment` and `manuals/graphify.md` are the delivery. |
| Dogfood copy | `0.9.0`, in sync. `focus-kit install .` was run twice: once before the manual was written, once after. |
| Machine | `~/.local/bin/focus-kit` follows the symlink and is already at `0.9.0`; global `/graphify` skill untouched at graphify `0.9.63`. |
| First target (`~/Downloads/vaulted`) | `0.9.0`, updated. `doctor` prints 24 green lines and no warn. `HEAD` still `f6e685c` on `master`, nothing staged; the working tree gained one untracked file, `.graphifyignore`. |
| Other targets | untouched, at whatever version their owner last installed. |
