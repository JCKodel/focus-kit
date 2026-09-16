# doctor-reports-drift

**Goal.** A person who edited a kit-owned file inside a target runs
`focus-kit doctor` and reads which files the next `update` will overwrite
or remove, before it does.

The comparison cannot be against the kit source: when the target is stale,
which is exactly when someone is about to run `update`, every kit-owned
file differs because the kit moved. Only a record of what `install` wrote
into that target tells an edited file from a stale one. That record is the
manifest (`docs/03-Domain.md`).

**Behaviour.**

* A target at `0.6.0` whose `.claude/skills/propose/SKILL.md` gained a line
  gets `! .claude/skills/propose/SKILL.md edited locally (focus-kit update
  overwrites it)` from `doctor`. Today: `✓ /propose`, and `update` erases
  the line without a word.
* The same target with a file added at `.claude/skills/apply/notes.md` gets
  `! .claude/skills/apply/notes.md is not the kit's (focus-kit update
  removes it)`. `copy_tree` is `rm -rf` then `cp -R`, so the file is as
  lost as an edit.
* A target with no drift gets one line, `✓ kit-owned files as install wrote
  them`, and neither warn.
* The same target cloned on Windows with `core.autocrlf=true`, every
  kit-owned file and the manifest itself checked out as CRLF, reads the
  same green line.
* A target installed before `0.6.0` has a stamp and no manifest: one warn
  naming the gap, and the first `update` there is the one that cannot warn.
  A target with no stamp is not installed, and `doctor` says nothing new.
* A kit-owned file that is absent is not drift: `update` restores it and
  the presence lines already say `missing`. The drift pass skips it.
* `doctor` still never fails: every drift line is a `warn`.

**Contract.**

Three functions added to `bin/focus-kit`, none of which dies, because each
one's output is captured (`docs/01-Architecture.md` §6):

| Function | Exactly |
|---|---|
| `without_cr file` | `tr -d '\r' < "$1"`. The one place a carriage return is forgiven. `installed_version` was the first occurrence (`version-stamp-tolerates-cr`) and becomes a caller; the fingerprint and the manifest reader are the second and third. |
| `fingerprint file` | `without_cr "$1" \| cksum \| cut -d' ' -f1`. The CRC only, never the size column. POSIX `cksum`, so the manifest a Mac writes is the one Linux and Git Bash read. |
| `write_manifest target` | One line per regular file under `.claude/skills/{initialize,propose,apply}/` and per manual `install` copied, `<crc> <path relative to target>`, sorted with `LC_ALL=C sort`, LF, to `.claude/skills/.focus-kit-manifest`. Byte-identical on every run of the same tree, which check 3 requires. |

`install_repo`: calls `write_manifest` after the skills and the manuals are
copied and the stamp is written, then `ok ".claude/skills/.focus-kit-manifest"`.
The manifest is **kit-owned** (ADR-0002): rewritten on every install, never
merged. It carries no banner, like the stamp: it is data `doctor` reads,
and ADR-0002's Forbidden clause gains that qualifier in this delivery. The
stamp and the manifest are not in the manifest.

`doctor`: every line printed today is unchanged, character for character.
After the `.mcp.json` line and before the `graphify-out/graph.json` line:

| Case | Prints |
|---|---|
| stamp present, manifest absent | `warn ".claude/skills/.focus-kit-manifest missing: cannot tell whether a kit-owned file was edited locally (run focus-kit update)"` |
| a manifest line whose file exists and whose `fingerprint` differs | `warn "$path edited locally (focus-kit update overwrites it)"` |
| a regular file under one of the three skill folders with no manifest line | `warn "$path is not the kit's (focus-kit update removes it)"` |
| manifest present, neither warn printed | `ok "kit-owned files as install wrote them"` |

Paths are relative to the target, as the manifest holds them. The manifest
is read through `without_cr`, so a CRLF checkout of the manifest itself
does not turn every path into one with a trailing byte that matches
nothing. A manifest line whose file is absent is skipped. The added-file
pass guards on each skill folder existing, so a target with `/propose
missing` gets no `find` error in the middle of `doctor`.

`check_install`: `kit-owned files as install wrote them` joins the expected
`ok` lines. After the CRLF stamp probe, three probes on the same scratch,
each restored before check 3 snapshots it:

| Probe | Exactly |
|---|---|
| CRLF | `docs/manuals/focus.md` and `.claude/skills/.focus-kit-manifest` both rewritten with `\r\n` line ends (`awk '{ printf "%s\r\n", $0 }'`); `doctor` must still print the `ok` line, which fails if either the fingerprint or the manifest reader keeps the byte; red: `die "check 2: doctor reported drift on a CRLF checkout of the scratch repository (a Windows clone with core.autocrlf=true writes one)"` |
| edited | one line appended to the same manual; `doctor` must print `warn "docs/manuals/focus.md edited locally (focus-kit update overwrites it)"`; red: `die "check 2: doctor did not report an edited manual in the scratch repository"` |
| added | `.claude/skills/apply/extra.md` created; the same `doctor` run must print `warn ".claude/skills/apply/extra.md is not the kit's (focus-kit update removes it)"`; red: `die "check 2: doctor did not report a file added to a kit skill in the scratch repository"` |
| restore | `cp "$KIT_DIR/manuals/focus.md"` over the manual, `rm` the added file, `write_manifest "$scratch"` for the manifest, which is deterministic |

`check_dogfood`: `diff -r -x .focus-kit-version -x .focus-kit-manifest
skills .claude/skills`. The `die` texts are unchanged.

The header comment, which is the help text: line 7 reads `report what is
installed, what is missing, and what was edited locally`; the install list
gains `.claude/skills/.focus-kit-manifest  what install wrote, for doctor
(kit-owned)`.

`VERSION` goes to `0.6.0`: a new file reaches every target and `doctor`
gains a kind of line. Builds on `version-stamp-tolerates-cr` at `0.5.2`.

Docs, in the same delivery: `docs/03` already carries Manifest, Fingerprint
and Drift, written by `/propose`; `docs/01` §3 gains three rows, its
"five helpers" count follows, and the `doctor` row says it compares
fingerprints; §5 "Write a kit-owned file" names the manifest; §6 names the
three functions among those whose output is captured; the `bin/focus-kit:N`
references the insertions move are re-measured in `docs/01`, `docs/03` and
`docs/04`; `docs/05` §4 check 2 gains the three probes in one sentence each
and check 6 the exclusion; `ADR-0002` Forbidden clause reads "a kit-owned
file without its banner, unless it is data `doctor` reads"; `README.md`
installed-files table gains the manifest row and the `doctor` sentence says
it reports local edits; `manuals/process.md` §10 says `doctor` names the
kit-owned files that were edited locally and that `update` overwrites them.

**Slice.** The CLI, `bin/focus-kit`: `without_cr`, `fingerprint`,
`write_manifest` added; `installed_version`, `install_repo`, `doctor`,
`check_install`, `check_dogfood`, the header edited. `manuals/process.md`,
kit-owned. `README.md`, `docs/01`, `docs/03`, `docs/04`, `docs/05`,
`docs/adr/ADR-0002`, project-owned. One new file in every target, kit-owned. No skill, template
or `config/` change.

**States.** In the Behaviour section: no drift, edited, added, CRLF
checkout, older install, not installed. A target that is not a git
repository is unchanged: drift is about the manifest, not about git.

**Visual reference.** No UI. `doctor` in a target at `0.6.0` where
`/propose` was edited and a file was added to `/apply`:

```
  ✓ .mcp.json
  ! .claude/skills/propose/SKILL.md edited locally (focus-kit update overwrites it)
  ! .claude/skills/apply/notes.md is not the kit's (focus-kit update removes it)
  ✓ graphify-out/graph.json
```

The same target, untouched: `✓ kit-owned files as install wrote them` in
place of the two warns. `install` prints one more line, `✓
.claude/skills/.focus-kit-manifest`, after the manuals line. `selftest`
prints the same six lines as today.

**Out of scope.**

* `update` printing the drift lines before it copies: the queue line names
  `doctor` as the front door, and the stakeholder kept it there.
* `update` refusing or asking per file: ADR-0002 rejected the questionnaire;
  a target is a git repository and a committed edit is in its history.
* A file added under `docs/manuals/`: manuals are copied one by one, so it
  survives `update`.
* Drift in `.mcp.json`, `.claude/settings.json` or `.gitignore`: merged and
  appended files never lose a key by design.
* A run on the Windows host: `cksum` is POSIX and the delivery claims no
  platform (`docs/05` §6). Welcome as extra proof, not required.
* An ADR: reversing this is deleting one file and one block of `doctor`.
  The reason is on this page and in `docs/01` §5.
* The kit-owned banner on the three `SKILL.md`: a "Later" line of its own.

**Done when.**

* [x] `bin/focus-kit selftest` green, with the three probes inside check 2
  and the exclusion in check 6.
* [x] Counterfactual in the done page: at `0.5.2`, a manual edited in a
  scratch repository, `doctor` green about it and `update` erasing the edit,
  both quoted.
* [x] The CRLF probe proven able to go red at both call sites: `fingerprint`
  reading raw bytes, then the manifest reader reading raw lines, each in
  turn making check 2 die with the message above, each restored.
* [x] `VERSION` is `0.6.0`; `focus-kit install .` was run; this repository
  holds `.claude/skills/.focus-kit-manifest`; `focus-kit doctor .` prints the
  `ok` line and no drift; check 6 green.
* [x] `docs/01`, `docs/03`, `docs/04`, `docs/05`, `README.md` and
  `manuals/process.md` say what the Contract lists; every `bin/focus-kit:N`
  there re-measured.
* [x] Environments: kit source and dogfood copy at 0.6.0, machine follows
  the symlink, targets untouched.

---

## What happened

Built as the Contract says. Nothing was dropped and nothing was added.

**Diverged from the plan, in one place.** The Contract lists the edited and
the added probe as two rows, and they are implemented as one `doctor` run
with two assertions and two separate `die` texts. The added row already said
"the same `doctor` run", so this is the reading of the page, not a change to
it: appending the line to the manual and creating `.claude/skills/apply/
extra.md` both happen, then `doctor` runs once, and each warn is asserted on
its own with its own red message. Two runs would have proven the same thing
twice.

**Two implementation choices the page did not fix.**

* The drift block reads the manifest with a herestring (`done <<< "$lines"`)
  and not a pipe. A pipe puts the `while` in a subshell, and `drift=1` set
  there would never reach the `ok` line that depends on it; the target would
  print both the warns and the green line. The comment in the code says so.
* Membership in the manifest is tested with `grep -qxF` over the path column
  cut out of it, not with a substring `grep` for `" $path"`. A substring
  match would call `x.md` present because `x.md.bak` is listed.

**The proof.**

1. **The counterfactual, at `0.5.2`, before a line of this delivery was
   written.** `mktemp -d`, `git init`, `bin/focus-kit install`, then a line
   appended to `docs/manuals/focus.md` in that scratch:

   ```
   --- tail of the edited manual
   - Sample app: github.com/JCKodel/focus-coffee. ...

   A line a person added to their copy of the manual.
   --- doctor at 0.5.2, the manual line
   19:  ✓ docs/manuals/focus.md
   --- any warn about an edit?
   0
   ```

   `doctor` called the edited manual present and green. Then
   `bin/focus-kit update` on the same scratch:

   ```
   --- the added line survived?
   0
   ```

   The line was gone, and nothing had said it would be. That is the defect
   this delivery closes.

2. **The three drift cases at `0.6.0`**, in a scratch repository, printed
   between the `.mcp.json` line and the graph line, which is where the
   Visual reference put them:

   ```
     ✓ .mcp.json
     ! .claude/skills/propose/SKILL.md edited locally (focus-kit update overwrites it)
     ! .claude/skills/apply/notes.md is not the kit's (focus-kit update removes it)
     ! graphify-out/graph.json missing (/propose and /apply rebuild it; docs/manuals/graphify.md)
   ```

   With the manifest moved away, on the same scratch:

   ```
     ! .claude/skills/.focus-kit-manifest missing: cannot tell whether a kit-owned file was edited locally (run focus-kit update)
   ```

   A `mktemp -d` with `git init` and no install, so no stamp: `doctor`
   printed no manifest line, no drift line and no green drift line. Zero
   matches for all four strings.

3. **The CRLF probe goes red at both call sites.** Each break was made in
   `bin/focus-kit`, `bin/focus-kit selftest` was run, and the break was
   reverted.

   `fingerprint` reading raw bytes (`cat "$1" | cksum`): check 2 died, and
   the output above the `die` showed the one file the probe rewrote:

   ```
     ! docs/manuals/focus.md edited locally (focus-kit update overwrites it)
   error: check 2: doctor reported drift on a CRLF checkout of the scratch repository (a Windows clone with core.autocrlf=true writes one)
   ```

   The manifest reader reading raw lines (`lines="$(cat "$manifest")"`):
   check 2 died with the same message, by a different route. Every path in
   the manifest then ends in `\r`, so every `-f` test fails and the edited
   pass goes silent; the red comes from the added-file pass, which finds no
   manifest line for any file and calls the whole kit not the kit's:

   ```
     ! .claude/skills/propose/SKILL.md is not the kit's (focus-kit update removes it)
     ! .claude/skills/apply/SKILL.md is not the kit's (focus-kit update removes it)
   error: check 2: doctor reported drift on a CRLF checkout of the scratch repository (a Windows clone with core.autocrlf=true writes one)
   ```

   Restored, `selftest` green both times.

4. **The verify command**, after `VERSION` went to `0.6.0` and
   `focus-kit install .` was run:

   ```
   focus-kit 0.6.0 selftest
     ✓ 1 bin/focus-kit parses
     ✓ 2 install into a scratch repository, doctor agrees
     ✓ 3 the second install leaves the same tree
     ✓ 4 the three SKILL.md frontmatters are well formed
     ✓ 5 no em dash in the paths this repository authors
     ✓ 6 the dogfood copies match their sources

   selftest green: a target repository would receive a working kit
   ```

   And `focus-kit doctor .` here: `✓ kit version 0.6.0`, `✓ kit-owned files
   as install wrote them`, no drift line.

**Decisions taken, no ADR.** The page said reversing this is deleting one
file and one block of `doctor`, and that held: `ADR-0002` gained a qualifier
to its Forbidden clause and nothing else. The qualifier is written to cover
exactly two files, the stamp and the manifest, so it does not become a
licence to ship a kit-owned document with no banner.

**Not touched, on purpose.** `.gitattributes` has an entry keeping this
repository's own stamp at LF and gains none for the manifest. The manifest
is meant to survive a CRLF checkout, and `without_cr` is what makes that
true; pinning it here would hide the tolerance rather than exercise it.

The `bin/focus-kit:N` references in `docs/00-Product.md` and in
`ADR-0001`/`ADR-0002` are stale and were left stale: the Contract named
`docs/01`, `docs/03` and `docs/04` as the three to re-measure. They were
already wrong before this delivery moved anything.

The graphify MCP server failed to connect in this session, so the slice was
read from the files directly. It is one file plus six documents, all read in
full.

**Environments.**

| Environment | State |
|---|---|
| Kit source (`skills/`, `manuals/`, `config/`, `bin/`) | 0.6.0 |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.6.0, `focus-kit install .` run, check 6 green, and it now holds `.claude/skills/.focus-kit-manifest` |
| Machine (`~/.local/bin/focus-kit`) | untouched; it is a symlink and `focus-kit version` prints 0.6.0 |
| Target repositories (anyone else's) | untouched, still at whatever version they hold. They move when their owner runs `focus-kit update <path>`. The first update there also writes the manifest, and until it does `doctor` warns that it cannot tell an edited file from a stale one. |
