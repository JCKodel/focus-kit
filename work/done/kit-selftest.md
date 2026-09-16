# kit-selftest

**Goal.** A person changing focus-kit runs one command, `bin/focus-kit
selftest`, and knows whether a target repository would still receive a
working kit.

**Behaviour.**

* `focus-kit selftest` runs the six checks of `docs/05-Process.md` §4 in
  order, prints one `ok` line per check that passes, and stops at the first
  red with a `die` that names what is broken and what fixes it.
* It takes no path argument and always checks `KIT_DIR`, because four of the
  six checks are about the kit's own sources and a target never receives
  `bin/focus-kit`.
* It creates a scratch repository, uses it for checks 2 and 3, and removes
  it through a `trap ... EXIT` whether the run is green or red.
* It touches nothing else: no network, no `~/.claude/`, no file in this
  repository. Green exits 0, red exits 1.
* On this tree today the six checks pass. A red on the first run is a
  defect in `selftest` itself, not in the kit.

**Contract.**

New verb, `selftest`, in the `case` dispatch. New usage line in the header
comment, after `version`:

```
#   focus-kit selftest         run the six checks that say the kit is deliverable
```

That line shifts the header by one, so the `--help` `sed` range moves from
`2,25p` to `2,27p`, which prints the whole header in this version.
`help-text-follows-header` keeps the fix that survives the next line added.

One function per check, plus `selftest` that calls them in order:

| Check | Function | What is exact |
|---|---|---|
| 1 | `check_parses` | `bash -n "$KIT_DIR/bin/focus-kit"`. |
| 2 | `check_install` | `mktemp -d` plus `git init -q`, then `install_repo "$scratch"` called directly, so the dependency phase never runs. Then `doctor "$scratch"` captured, and the output must contain the line `ok` itself produces for each of `/initialize`, `/propose`, `/apply`, `docs/manuals/process.md`, `docs/manuals/focus.md`, `docs/manuals/graphify.md`, `.mcp.json` and `kit version $KIT_VERSION`. The expected line is built by calling `ok`, so the assertion and the reporter cannot drift. The ten warnings a scratch repository legitimately produces are ignored; a missing version line is red. |
| 3 | `check_idempotent` | `cp -R` the scratch to a snapshot, `install_repo "$scratch"` a second time, `diff -r -x .git snapshot scratch` empty. |
| 4 | `check_frontmatter` | For each of the three `skills/<name>/SKILL.md`: line 1 is `---`, a closing `---` exists, `name:` equals the folder name, one line is exactly `description: >-`, and every line until the next top-level key is indented. Pure bash, no YAML parser: python3 has none in its standard library. |
| 5 | `check_no_em_dash` | The character is built from its bytes, `printf '\xe2\x80\x94'`, and never written in the source, so the grep needs no allowlist. Scope: `bin skills manuals config work CLAUDE.md README.md`, plus `docs` with `docs/manuals/` filtered out of the hits. `graphify-out/` is out because it is generated. Any hit is red, and the hit's file name is printed. |
| 6 | `check_dogfood` | `diff -r -x .focus-kit-version skills .claude/skills` and `diff -r manuals docs/manuals`, both empty. |

`work/` joins the grep scope of check 5, which `docs/05-Process.md` §4 omits
today while `CLAUDE.md` forbids the character anywhere in this repository.
§4 is corrected in the same delivery, together with its "parsed as YAML"
wording, which becomes the structural rules above.

`VERSION` goes to `0.3.0`: a new verb is CLI behaviour.

**Slice.** The CLI, `bin/focus-kit`, which is never copied into a target: no
kit-owned, merged or appended once file changes, so no target receives
anything new. The rest of the delivery is project-owned documents. No skill,
manual, template or config fragment changes.

**States.** Green prints six `ok` lines and a closing `say`, and nothing
else: what `install_repo` and `doctor` print inside checks 2 and 3 is
captured, not shown. Red prints the `ok` lines that passed, then the detail
(that captured output, the `diff`, or the file names the grep found), then
one `die`. `die` names the thing, not the step: `check 6:
.claude/skills differs from skills (run focus-kit install .)`. A missing
python3 or a `mktemp` that fails is the existing `die` path.

**Visual reference.** No UI. The exact lines of a green run:

```
focus-kit 0.3.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

And of a red one:

```
focus-kit 0.3.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
Only in skills/propose: SKILL.md
error: check 6: .claude/skills differs from skills (run focus-kit install .)
```

**Out of scope.**

* The other four lines of milestone 1. Each is a known defect with its own
  line; `selftest` reports, it does not fix them.
* The real `--help` fix. `help-text-follows-header` owns it; here the range
  only moves so nothing is cut in this version.
* A `selftest` that a target repository can run. Four of the six checks are
  about the kit's own sources.
* A test framework, CI, and any check slower than a few seconds. Decided in
  `docs/01-Architecture.md` §2.
* Exercising `ensure_uv` and `ensure_graphify`. They would put the network
  and `~/.claude/CLAUDE.md` inside the verify command.

**Done when.**

* [x] `bin/focus-kit selftest` prints the six `ok` lines above and exits 0.
* [x] `focus-kit --help` prints the header down to its last line, `selftest`
  included.
* [x] `VERSION` is `0.3.0`.
* [x] Every `bin/focus-kit:NN` citation points at the line it names, the ADRs
  included: `grep -rn 'bin/focus-kit:' docs CLAUDE.md README.md` minus
  `docs/manuals/`, each hit checked.
* [x] These documents no longer say `selftest` is absent, each at the place that
  names it: `docs/05-Process.md` §4, `docs/03-Domain.md` (CLI row, verify
  command row), `docs/01-Architecture.md` §2 and §3,
  `docs/04-Conventions.md` §1 and §2, `docs/00-Product.md` (open decision
  1), `CLAUDE.md` (How to work), `docs/06-Queue.md` (milestone 1). Plus
  `docs/04-Conventions.md` §5, which the page did not list.
* [x] The dogfood copies are untouched and check 6 is green: no skill and no
  manual changed, so `focus-kit install .` is not needed here.
* [x] Environments: kit source at 0.3.0, dogfood copy in sync, machine follows
  the symlink, target repositories untouched until their owner runs
  `focus-kit update`.

---

## What happened

Built as planned. `bin/focus-kit selftest` was green on its first run, which
is what the page predicted, and the six `ok` lines match the visual
reference character for character.

**The red paths were proven, not assumed.** A green run says nothing about
what a check does when it finds something, so each red was provoked and
reverted: an em dash written into a throwaway file under `work/` (check 5
printed the file name, then one `die`, exit 1), an extra file dropped into
`.claude/skills/propose/` (check 6 printed `Only in
.claude/skills/propose: EXTRA.md`, then the `die` the page names verbatim),
and `description: >-` replaced by `description: a bare: colon` in
`skills/propose/SKILL.md` (check 4 printed `line 3 is a description that is
not a >- block`). The scratch directory was gone after every run, red
included: the entry count of `$TMPDIR` is the same before and after.

**Two mechanics the page did not name, both forced by `set -euo pipefail`.**
A `die` inside a command substitution exits silently, because its stderr was
captured, so every capture is written `out="$(... 2>&1)" || { printf '%s\n'
"$out"; die ...; }`: the detail reaches the screen before the `die`. And
every `grep` that may legitimately find nothing carries `|| true`, because
a grep with no match is exit 1 and the run would stop on it.

**The scratch is one temporary directory holding two.** `mktemp -d` once,
then `scratch/` inside it for checks 2 and 3 and `snapshot/` for the `cp
-R` of check 3. One `trap ... EXIT` removes the pair, which is what the page
asked for with one directory less to track.

## What diverged

* **`docs/04-Conventions.md` §5 was updated too.** The page listed §1 and §2
  for that file, but §5 held both of the sentences the delivery makes false:
  "This script does not exist yet" and "parsed as YAML". Docs are living;
  leaving them would have been a stale doc in the same commit that broke it.
* **`docs/06-Queue.md` gained a line while the delivery ran.** The person
  added `[ ] open-source license` to milestone 1. The milestone's opening
  sentence therefore does not count the defects below it, since one of them
  is not a defect.
* **The `help-text-follows-header` queue line was reworded.** It said `sed
  -n '2,25p'` cuts the last line mid-sentence. It no longer does: the range
  is `2,27p` and the header is 27 lines. What remains wrong is that the
  range is a literal, and that is now what the line says.
* **No ADR.** `docs/01-Architecture.md` §3 predicted the verify command as
  the most likely place a FOCUS piece would appear, so the prediction was
  checked rather than left standing: each of the six checks runs `bash -n`,
  an install, a `diff` or a `grep` and reports what came back. There is no
  rule to extract and nothing to call with literals, so the four-piece table
  stays empty and ADR-0003 still holds. The section says this now, instead
  of predicting it.

## What was dropped

Nothing from the page. The four things it put out of scope stayed out: the
other queue lines of milestone 1, the real `--help` fix, a `selftest` a
target can run, and any exercise of `ensure_uv` or `ensure_graphify`.

## Abstraction

None taken. `check_install` and `check_idempotent` both capture output and
print it before dying, which is a second occurrence of a shape, but it is
three lines of bash repeated once, not a concept. The first occurrence is
`check_parses`.

## The proof

`docs/05-Process.md` §6 says the proof of a change to `bin/focus-kit` alone
is the verify command, and nothing further. The delivery touched no skill,
no manual, no template and no config fragment, so no target repository
receives anything new and there was no real run of `/initialize`, `/propose`
or `/apply` to do.

The run was repeated under `/bin/bash` explicitly, which on this machine is
bash 3.2.57 and is also what `env bash` resolves to. `bash -n` says the
script parses; only a real run says it runs there, and it does.

Beyond the six checks, two things were read by hand because no check covers
them: `focus-kit --help | tail` now ends on `supply a python.` rather than
cutting mid-sentence, and every `bin/focus-kit:NN` citation in `docs/`,
`docs/adr/` and `CLAUDE.md` was recomputed and opened at its new line. The
header gained one line and the check block sits between `doctor` and the
dispatch, so the helpers moved by one and the dispatch moved by 142.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.3.0. `VERSION`, `bin/focus-kit` and this repository's docs are the delivery. |
| Dogfood copy | in sync. No skill and no manual changed, so `focus-kit install .` was not run and check 6 is green. `.claude/skills/.focus-kit-version` still reads 0.2.0, which is correct: it records the install, and no install happened. |
| Machine | 0.3.0. `~/.local/bin/focus-kit` is a symlink to the kit source and followed it with no action. |
| Target repositories | untouched, at whatever version they installed. They move only when their owner runs `focus-kit update <path>`. |
