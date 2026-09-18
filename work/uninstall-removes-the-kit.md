# uninstall-removes-the-kit

**Goal.** A person who stops using focus-kit gets their repository back with
one command, instead of hunting down the kit's files, keys and blocks by
hand.

**Behaviour.**

* `focus-kit uninstall [path]` removes from a target every Kit-owned file,
  what the Settings baseline merged into `.claude/settings.json`, the two
  Leftover entries an earlier kit merged, and the block each Appended once
  fragment put in the target's own file. It names every group it removed,
  and it never touches a Project-owned file.
* Everything it removes, `focus-kit install .` puts back, git or no git: the
  Kit-owned files are copies of `KIT_DIR`, the baseline merges again, the
  fragments append again. Two things do not, and the run says which: a file
  the person edited, which returns as the kit's version and not theirs, and
  the Leftover entries, which no install writes any more.
* A target installed before this version has a block with no End marker, so
  the run leaves that file alone and names the block for a hand removal.
* A directory the removal emptied goes with it; one that still holds
  something stays, `.claude/` with a `settings.local.json` in it included.
* `docs/00` to `06`, `CLAUDE.md`, `docs/adr/` and `work/` are untouched,
  `work/done/.gitkeep` included, and the closing lines say so.

**Contract.**

*The verb.* `uninstall_repo <target>` in `bin/focus-kit`, a sixth case in the
dispatch, `[path]` defaulting to `.`. It runs no dependency block: nothing on
the machine is touched, so `ensure_uv`, `ensure_graphify` and
`report_upstream` are not called. The script's header gains the verb in the
usage block and a block saying what it removes, and `--help` prints the
header, so there is no second edit (`docs/04-Conventions.md` §1).

*The Kit-owned files.* Every path the Manifest lists, then
`.claude/skills/.focus-kit-manifest` and `.claude/skills/.focus-kit-version`
by name, which `write_manifest` leaves out of the list (`docs/01` §3). The
Manifest is the list because it is the only complete one a target holds
(`docs/03`, Drift), so a file a later version of the kit added is removed
here without this page naming it. A path whose Fingerprint differs from the
Manifest is removed too, with one `warn` naming it, because it is the one
thing `install` does not put back as it was. With no Manifest the run removes
what this kit writes, the `kit_skills` folders and `manuals/*.md`, and one
`warn` says a file an older kit wrote is left.

*The Merged file.* `unmerge_json <file> <baseline>`, two paths and nothing
interpolated, the mirror of `merge_json`'s four cases (`docs/01` §3): a list
on both sides loses every baseline item, an object on both sides is recursed
by this same rule, a scalar equal to the baseline's loses its key, and a
scalar that differs or a key the baseline says nothing about is untouched. An
object or a list the removal emptied loses its key, and the file goes when
nothing but `{}` is left, which mirrors the `{}` `merge_json` creates. Same
python, same explicit UTF-8 and LF, and the same `die` when no python runs.

*The Leftovers.* Two key paths, named in `uninstall_repo`: the `graphify`
entry of `mcpServers` in `.mcp.json`, and the `graphify` item of
`enabledMcpjsonServers` in `.claude/settings.json`. Removed **whatever their
value**, which is why they are not a baseline: what an earlier kit wrote
there is not what this one holds, and the entry existing is the whole
question. Each file goes when the removal leaves it `{}`. Each is an `ok`
line of the file it left, `.mcp.json (graphify server removed, file
removed)`, and not a `warn`: there is nothing for the person to do next, and
the entry going is the point (`docs/04-Conventions.md` §1).

*The Appended once files.* Both fragments gain a last line, the End marker
`# --- focus-kit end ---`, the same style as the first line and the same
block. `append_once` is unchanged: it appends the fragment whole, both
markers included, and still guards on the first line. `remove_block <file>
<fragment>` removes from the first marker to the End marker inclusive, plus
the blank line `append_once` puts in front when the file already had
something in it, and removes the file when the block was the whole of it. A
block whose End marker is absent is left where it is, with one `warn` per
file. The End marker begins with `#`, so it is not a pattern line and no
target gains a Fragment gap warn for it (`docs/03`, Fragment gap).

*The verify command* gains a seventh check, `check_uninstall`, after check 6,
on its own Scratch repository: install, uninstall, and the tree is `.git`
plus `work/done/.gitkeep` and nothing else. Then two probes, each installing
again first, because the run before it left nothing to remove: the Leftover
shape written in, uninstalled, both entries gone and `.mcp.json` removed; and
a block with its End marker cut out, uninstalled, the `warn` carried and that
file byte for byte as it was.

*Ownership.* The verb writes into three categories and never the fourth.
Nothing new is Kit-owned. `ADR-0002` is amended, not replaced: its **Forbidden**
clause forbids a write that removes a key from a Merged file, and its
**Revisit when** is the sentence that admits this, a third thing the person
has to go and fix being where the reporting answer stops paying for itself.
The amendment covers the End marker too, which is the same marker style and
the same block, not a second one.

**Slice.** `bin/focus-kit`, the one file this repository's structure has
(`docs/01` §3): the verb, `unmerge_json`, `remove_block`, `check_uninstall`
and the header. Plus `config/gitignore.fragment` and
`config/graphifyignore.fragment`, Appended once, each gaining the End marker.
Plus two Manuals, Kit-owned: `manuals/process.md` §12, which names `update`
and `doctor` and now names the way out too, and `manuals/graphify.md` §What
the graph leaves out, whose "the rest of the file is yours" gains the
boundary the End marker draws. Plus this repository's own documents and
`docs/adr/ADR-0002`. No skill and no template.

**States.**

* Works: the lines below.
* Nothing to remove: a `say` per absent group, no `die` and no `warn`, since
  there is nothing for the person to do. The command reports and never fails,
  the way `doctor` does not (`docs/01` §6).
* No python: `die`, the wording `merge_json` already has.
* Not a git repository: no extra line. What puts the kit back is
  `focus-kit install .`, not git.

**Visual reference.** A Scratch repository, install then uninstall:

```
uninstalling focus-kit <version> from <target>
  ✓ .claude/skills/{apply,discuss,initialize,propose}
  ✓ docs/manuals/{process,focus,graphify}.md
  ✓ .claude/skills/.focus-kit-manifest, .focus-kit-version
  ✓ .claude/settings.json (baseline permissions unmerged, file removed)
  ✓ .gitignore (kit block removed, file removed)
  ✓ .graphifyignore (kit block removed, file removed)

docs/00 to 06, CLAUDE.md, docs/adr/ and work/ are the project's and were not touched.
Next: focus-kit install . puts the kit back.
```

The two `warn` shapes, each naming its fix (`docs/04-Conventions.md` §1):

```
  ! docs/manuals/focus.md was edited locally (focus-kit install . puts the kit's version back, not yours)
  ! .gitignore has a focus-kit block with no end marker (remove it by hand, from "# --- focus-kit ---" to the end of the block)
```

**Out of scope.**

* Any Project-owned file. The CLI never writes one (`ADR-0002`,
  Project-owned; `docs/00`, Rule of product), so `work/done/` stays with its
  `.gitkeep` and the person deletes their own documents.
* Holding the two Leftover key paths in one place with `doctor`'s two greps.
  A fixed string over the raw file and a key path inside the JSON are not the
  same datum, so this is the first occurrence of the key path and not the
  second of the string (`CLAUDE.md`, abstraction on the second occurrence).
* `doctor`'s two Leftover warns, which go on naming the hand removal: a
  person who keeps the kit wants that fix, and `uninstall` is not it.
* `.graphifyignore` missing from the header's list of what `install` writes.
  That is `help-names-what-install-writes`, and this delivery edits the same
  block without widening into it (`docs/06-Queue.md`, milestone 5).
* A flag, a dry run and a prompt. The command removes and reports, because
  `focus-kit install .` is the undo and the CLI reads no input.
* The Ported commands `copilot-port` and `codex-port` add. They are listed in
  the Manifest, so they are removed by the rule above whichever ships first,
  and neither this page nor the CLI names a file of theirs.

**Done when.**

* `bin/focus-kit selftest` green, seven checks.
* Check 7 green: its three assertions above.
* The Dogfood copy in sync: `focus-kit install .` run here, check 6 empty
  (`docs/05-Process.md` §5).
* This repository's own `.gitignore` and `.graphifyignore` carry the End
  marker, added by hand, because `append_once` never writes into a block that
  is there and no command can put it in either file.
* `VERSION` bumped: a target gains a verb, two manuals and two fragments it
  did not have.
* Every line saying the verify command has six checks says seven: `grep -rn
  "six check"` over `CLAUDE.md`, `bin/` and `docs/` outside `docs/manuals/`
  comes back naming only what `kit-selftest` shipped, which is `docs/00` open
  decision 1 and its copy in `docs/06`. The header's usage line and the
  `six ok lines` of `docs/05` §4 are in the same pass.
* The documents the delivery changed, updated in it: `docs/00` (Mechanics
  gains Removing it), `docs/01` §3 and §5, `docs/03` (CLI, Merged, Leftover,
  Appended once, and the two rows `/propose` already added), `docs/05` §4,
  `CLAUDE.md`, and `docs/adr/ADR-0002` amended.
