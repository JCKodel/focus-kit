# version-stamp-tolerates-cr

**Goal.** A person whose target was cloned on Windows with
`core.autocrlf=true` runs `focus-kit doctor` and reads `kit version 0.5.0`
as a green line, not a warning that 0.5.0 is not 0.5.0.

Found by `windows-git-bash` (its done page, "Found, not fixed"). That
delivery protects this repository's own stamp through `.gitattributes`; a
target receives no `.gitattributes`, so the fix has to be in the reader.

**Behaviour.**

* A target whose `.claude/skills/.focus-kit-version` reads `0.5.1\r\n`,
  the kit at `0.5.1`, gets `ok kit version 0.5.1` from `doctor`. Today:
  `warn kit version 0.5.1\r installed, 0.5.1 available (run focus-kit
  update)`, the `\r` invisible on the terminal.
* The same stamp in this repository's dogfood copy leaves check 6 green.
  Today it dies with `the dogfood copy is at 0.5.1 and VERSION is 0.5.1`.
* A stamp that is genuinely behind still warns, and check 6 still dies,
  with the messages of today. Only the carriage return is forgiven:
  a stamp reading ` 0.5.0` or `0.5.0 ` is still not `0.5.0`.
* Check 2 proves it on every platform: after the install and the `doctor`
  that agrees, it rewrites the scratch stamp as CRLF, runs `doctor` again
  and requires the same green line. A regression here would otherwise be
  invisible on macOS and Linux forever, and this defect actually happened.
* `install` and `update` are unchanged: they write the stamp with LF, as
  today.

**Contract.**

New function `installed_version target`, the reader of the Installed
version of `docs/03-Domain.md`. It echoes the content of
`$target/.claude/skills/.focus-kit-version` with every carriage return
removed (`tr -d '\r' <` the file; the trailing newline goes with the `$()`
as today). Nothing else is trimmed. It reads and never dies: its output is
captured, and the callers keep their own `-f` guards
(`docs/01-Architecture.md` §6). `doctor` is the first occurrence,
`check_dogfood` the second; both `cat` lines become a call.

`doctor`: the `ok` and `warn` lines are unchanged, character for character.

`check_install`: after the two `grep -qF` on the merged files, one probe:

| Step | Exactly |
|---|---|
| write | `printf '%s\r\n' "$KIT_VERSION" > "$scratch/.claude/skills/.focus-kit-version"` |
| run | `doctor "$scratch"`, output captured, and the line `ok "kit version $KIT_VERSION"` must be in it |
| red | `die "check 2: doctor did not tolerate a CRLF .focus-kit-version in the scratch repository (a Windows clone with core.autocrlf=true writes one)"`, after printing the output |
| restore | `printf '%s\n' "$KIT_VERSION" >` the same path, the byte-exact line `install_repo` writes |

The restore is part of the check, not a courtesy: check 3 snapshots the
scratch and installs again, and a CRLF stamp left behind would turn into a
false idempotency failure. The `ok "2 ..."` line is unchanged.

`VERSION` goes to `0.5.2`: `doctor` behaving differently in a target is
CLI behaviour a target wants. Builds on `merge-json-by-argument` at
`0.5.1`, already in `work/done/`.

Docs, in the same delivery: `docs/03` Installed version row, Code column
gains `installed_version()` and the meaning says the comparison ignores a
trailing carriage return; `docs/01` §3 gains the `installed_version` row
and `/apply` corrects the line numbers the insertion moves, in §3, in the
six check references, in §5 and §6, and the `bin/focus-kit:N` references
in `docs/03` and `docs/04`; `docs/05` §4 check 2 gains the
probe in one sentence and check 6's "compared by value and not by bytes"
gains the carriage return and why. `README.md` and the manuals do not
mention the stamp and do not change.

**Slice.** The CLI, `bin/focus-kit`: `installed_version` added, `doctor`,
`check_install`, `check_dogfood` edited. This repository's `docs/01`,
`docs/03`, `docs/05`. No skill, manual, template or `config/` change; no
file a target receives changes shape.

**States.** The defaults. A target with no stamp: `doctor` prints no
version line, as today, and check 2 dies on the missing `ok` line, as
today.

**Visual reference.** No UI. `doctor` in a fresh Windows clone, made with
`core.autocrlf=true`, of a target whose committed stamp is `0.5.2`, with
no `update` run there (an `update` rewrites the stamp as LF and hides the
defect):

```
  ✓ kit version 0.5.2
```

The `selftest` run prints the same six lines as today.

**Out of scope.**

* `KIT_VERSION`, the `cat` of `VERSION`: covered by `.gitattributes` in
  this repository and never reaches a target.
* Shipping a `.gitattributes` to targets: a fifth ownership category for
  one line, and the target's line-ending policy is the target's.
* Trimming spaces or tabs from the stamp: no error happened, and a stamp
  with a space in it was not written by the kit.
* A run on the Windows host: this claims no platform (`docs/05` §6), and
  the byte is the same on every one. Welcome as extra proof, not required.
* `update` rewriting a CRLF stamp: it already writes LF, and git with
  `core.autocrlf=true` normalises to the same index content.

**Done when.**

* [x] `bin/focus-kit selftest` green, with the probe inside check 2.
* [x] Counterfactual in the done page: at `0.5.1`, the probe's CRLF stamp
  makes `doctor` warn and check 6 die with the messages of today, quoted.
* [x] In this repository, `.claude/skills/.focus-kit-version` rewritten as
  CRLF by hand, `selftest` green through check 6, the stamp restored with
  `git checkout`, `git status` clean of it.
* [x] `VERSION` is `0.5.2`; `focus-kit install .` was run and check 6 is
  green.
* [x] `docs/03`, `docs/01`, `docs/05` say what the Contract lists.
* [x] Environments: kit source and dogfood copy at 0.5.2, machine follows
  the symlink, targets untouched.

---

## What happened

Built as written. `installed_version()` sits between `install_repo` and
`doctor` (`bin/focus-kit:242`), one line of body, `tr -d '\r' <` the stamp.
`doctor` and `check_dogfood` each lost a `cat` and gained a call. The probe
went into `check_install` after the two `grep -qF` on the merged files.

**Order of work.** The counterfactual was run first, on the untouched code at
`0.5.1`, then the CLI was edited, then `selftest` was proven green still at
`0.5.1`, then the hand-CRLF of the dogfood stamp, and only then the bump to
`0.5.2` and `focus-kit install .`. That order is not cosmetic: the third
"Done when" item asks for the stamp to be restored with `git checkout` and
`git status` to be clean of it, and `git checkout` brings back the committed
`0.5.1`. After the bump that would be a red check 6, so the item is only
satisfiable literally while `VERSION` is still `0.5.1`.

### The counterfactual, at 0.5.1, before the fix

`doctor` against a scratch whose stamp was written with `printf '%s\r\n'`,
piped through `cat -v` so the byte shows:

```
  ! kit version 0.5.1^M installed, 0.5.1 available (run focus-kit update)
```

The same stamp written by hand into this repository's dogfood copy, then
`bin/focus-kit selftest`:

```
  ✓ 5 no em dash in the paths this repository authors
error: check 6: the dogfood copy is at 0.5.1^M and VERSION is 0.5.1 (run focus-kit install .)
```

Both messages are exactly the ones the Behaviour section predicted, and on a
terminal without `cat -v` both read as a number that is not itself. That is
the whole defect.

### The probe catches the regression it exists for

With the CLI fixed, `installed_version`'s body was temporarily changed back
to `cat "$1/.claude/skills/.focus-kit-version"` and `selftest` run:

```
error: check 2: doctor did not tolerate a CRLF .focus-kit-version in the scratch repository (a Windows clone with core.autocrlf=true writes one)
```

The body was restored immediately. A probe that cannot go red proves nothing,
and this one goes red on macOS, where no `\r` is ever written by anything.

### Proof

`bin/focus-kit selftest` at `0.5.2`, after `focus-kit install .`:

```
focus-kit 0.5.2 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

`focus-kit doctor .` prints `✓ kit version 0.5.2`. The delivery claims no
platform (`docs/05` §6), so nothing was run on Windows; the byte the probe
writes is the same one Git Bash would check out, and the probe now runs on
every platform on every `selftest`.

### Divergences and decisions

* **The delivery's Slice omits `docs/04` while its Contract names it.** The
  Contract wins, because it is the section precision is demanded of
  (`docs/05` §3), and the omission is real: `docs/04:66` cites
  `bin/focus-kit:436` for the `awk` that prints the help text, and the
  dispatch moved to 463. `docs/04` was edited, that one line only. Nothing
  else in `docs/04` moved: its `:45`, `:110` and `:36` were re-measured and
  are still right.
* **Pre-existing drift corrected in `docs/03`.** Its `bin/focus-kit:42` for
  `KIT_VERSION` and `:44` for the four message shapes were each one line
  behind, from a line added near the top of the script in an earlier
  delivery. They sit above the insertion point and so were not moved by this
  one, but the Contract names "the `bin/focus-kit:N` references in `docs/03`
  and `docs/04`" without qualifying, and a reference that points at the wrong
  line is worth no more than none. Now `:43` and `:45`.
* **`docs/01` §5 and §6 needed no line-number change.** Every reference there
  (`:36`, `:226`, `:116`, `:32`, `:62`, `:145`) is above the insertion or
  inside `install_repo`, and all six were re-measured against the text on
  that line. §6 gained a clause instead: `installed_version` is now named in
  the bullet that lists the functions whose output is captured and that
  therefore return a status rather than dying.
* **`docs/01` §3 said "Three verbs and four helpers".** The new row makes it
  five, and the sentence was corrected in the same edit. The Contract did not
  name it; leaving it would have made the paragraph disagree with the table
  directly under it.
* **One `die`, not two.** The Contract's table gives check 2's probe a single
  red message. A captured `doctor` that exited non-zero would otherwise fall
  to `set -e` with no message at all, so the guard is one `if` with two
  conditions, `! out="$(doctor ...)"` or the missing line, reaching that one
  `die`. `doctor` never fails by design (`docs/01` §6), so the first
  condition is a belt, not a branch anyone expects to take.
* **`docs/05` check 6 says why, and the why is not the clone.**
  `.gitattributes` here already lists
  `.claude/skills/.focus-kit-version text eol=lf`, so a Windows clone of this
  repository gets an LF stamp and check 6's tolerance is never exercised on
  its own. The reason it exists anyway is that `check_dogfood` is the second
  occurrence of the read and the two callers have to agree on what the number
  is; the sentence in `docs/05` says that, and names `.gitattributes` so a
  reader is not left thinking the check is defending against something it
  will never see. The hand-CRLF of the third "Done when" item is the only way
  to exercise it here, which is why that item is worded the way it is.
* **Nothing was dropped.** No ADR: the decision here is which layer forgives
  the byte, and `docs/01` §3's new row says it in the place a reader looks.

### Found, not fixed

Out of the Slice, left for a later delivery to name in the queue:

* `docs/00-Product.md:91` cites `bin/focus-kit:399` for the order `install`
  runs in, and points at the wrong line. `docs/00:101` cites `:100`.
* `docs/adr/ADR-0001` cites `:35` and `:117`, `ADR-0002` cites `:111`,
  `:196` and `:117`. All predate several deliveries.

None of them is wrong about behaviour; they point at the wrong line. An ADR
is also a record of what was decided when, so renumbering one is a decision
in itself and not a side effect of this delivery.

### Environments

| Environment | State |
|---|---|
| Kit source (`bin/`, `skills/`, `manuals/`, `config/`, `VERSION`) | 0.5.2 |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.5.2, `focus-kit install .` run, check 6 green |
| Machine (`~/.local/bin/focus-kit`) | 0.5.2 through the symlink, `focus-kit version` confirms |
| Target repositories (anyone else's) | untouched, still at whatever they installed |

A target moves only when its owner runs `focus-kit update <path>` there
(`docs/05` §5). Nothing was pushed and nothing was committed.
