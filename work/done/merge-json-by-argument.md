# merge-json-by-argument

**Goal.** A person edits `config/settings.baseline.json` freely, escapes and
all, and `focus-kit install` still writes exactly what the file declares.

Builds on `windows-git-bash` at 0.5.0: the encodings in the heredoc and the
probed `python_bin` are already there.

**Behaviour.**

* A settings baseline holding any JSON escape, `\"`, `\\`, `\n` or
  `\uXXXX`, or the sequence `'''`, installs, and the permission reads back
  byte-identical to what the baseline declares. Today the baseline is pasted
  into a non-raw `'''...'''` Python literal, so Python processes the escapes
  before `json.loads` sees them: `\"` becomes `"`, `\\` becomes `\`, `\n`
  becomes a real newline, and `'''` ends the literal. A bare `'` or `$` is
  fine today and stays fine.
* Nothing reaches python as source. The program is the heredoc; argv carries
  two paths, the file and the baseline, and nothing else.
* A target's `.mcp.json` holding another server and a hand-edited `graphify`
  entry (absolute `command`, different `args`): the other server stays, the
  `graphify` entry becomes the kit's, whole.
* A target's `.claude/settings.json` holding its own `allow` items and some
  baseline items already present: keeps its own, gains what is absent, no
  duplicate, order kept. Today's behaviour, now a rule of the merge rather
  than of an expression.
* A fresh target's two merged files are byte-identical to what 0.5.0 writes.
  `focus-kit install .` here changes neither of this repository's own.

**Contract.**

`merge_json file baseline`: both arguments are paths. The heredoc program
reads both as JSON and merges the baseline into the file, then writes as
today (`indent=2`, `ensure_ascii=False`, UTF-8, LF). `exec` goes away. The
rule, in this order:

| The baseline holds | The file ends with |
|---|---|
| a key directly under `mcpServers` | the baseline's entry, replacing the file's whole |
| a key the file lacks | the baseline's value |
| an object | the two merged key by key, recursively, by this table |
| a list | the file's list, then every baseline item absent from it, in baseline order |
| anything else, or the two of different types | the baseline's value |
| nothing for a key the file has | the file's value, untouched |

The rule is the abstraction on the second occurrence: the `.mcp.json`
expression was the first, the settings one the second, and one rule
replaces both.

New kit source file `config/mcp.baseline.json`, the MCP baseline of
`docs/03-Domain.md`:

```json
{
  "mcpServers": {
    "graphify": {
      "command": "graphify-mcp",
      "args": ["graphify-out/graph.json"]
    }
  }
}
```

`config/settings.baseline.json` gains one top-level key after
`permissions`: `"enabledMcpjsonServers": ["graphify"]`. `.gitattributes`
gains `config/mcp.baseline.json text eol=lf`.

`install_repo`: the `baseline="$(cat ...)"` line and both expressions go
away; each call passes `$KIT_DIR/config/<name>.baseline.json`. The two `ok`
lines are unchanged. The `die` in `merge_json` is unchanged.

`VERSION` goes to `0.5.1`: CLI behaviour, nothing a target receives changes
shape.

Docs, in the same delivery: `docs/03` Settings baseline row says permissions
and `enabledMcpjsonServers`, Merged row states the rule in one sentence, and
the target invariant "never removes anything from" the two files carves out
the server entry the MCP baseline names; `docs/01` §3 `merge_json` row, §4
layout, §5 "Write a merged file" row with the same carve-out; `README.md`
layout block and `CLAUDE.md` `config/` line name two baselines. `ADR-0001`
still says heredoc, and it is still true.

**Slice.** The CLI, `bin/focus-kit`: `merge_json`, `install_repo`. `config/`:
one file added, one edited, both kit source that a merged file is made from,
neither copied to a target. This repository's `.gitattributes`. No skill,
manual or template changes.

**States.** The defaults. A merged file in a target that is not valid JSON
makes python exit non-zero with a traceback and `set -e` stops the install,
as today.

**Visual reference.** No UI. The `install` output is unchanged, line for
line.

**Out of scope.**

* The Windows run: `windows-git-bash` owns it, and this page claims no
  platform (`docs/05-Process.md` §6).
* Validating the merged files' JSON in check 2: the `grep -qF` is
  deliberate (`docs/05-Process.md` §4).
* A `die` on an invalid merged file in a target: a traceback is unchanged
  behaviour and no target has reported one.
* `uninstall` and unmerging the two keys: "Later, not scheduled".
* A change to the server's `command` or `args`: same contract as today, the
  entry is replaced whole.

**Done when.**

* [x] `bin/focus-kit selftest` green.
* [x] Proof beyond the selftest, in the done page: a scratch copy of the kit
  whose settings baseline holds the allow item `"Bash(printf \"%s\\\\n\" *)"`
  installs into a scratch repository, and the item reads back through
  `python3 -c` as `Bash(printf "%s\\n" *)`. The same baseline under 0.5.0
  fails.
* [x] A scratch repository seeded with the `.mcp.json` and
  `.claude/settings.json` of the third and fourth Behaviour lines, installed
  into: the other server and the target's own items survive, the `graphify`
  entry equals the MCP baseline, no duplicate.
* [x] `git diff` shows no change to `.mcp.json` and `.claude/settings.json`
  in this repository after `focus-kit install .`.
* [x] `VERSION` is `0.5.1`; `focus-kit install .` was run and check 6 is
  green.
* [x] `docs/03`, `docs/01`, `README.md`, `CLAUDE.md` say what the Contract
  lists.
* [x] Environments: kit source and dogfood copy at 0.5.1, machine follows
  the symlink, targets untouched.

---

## What happened

Built as planned. `merge_json` takes two paths, the heredoc reads both with
`json.load` and one recursive `merge(d, b, parent=None)` applies the five
rows of the Contract table in that order; the sixth row is what the loop
never reaches. `exec` is gone and argv carries nothing but the two paths.
`install_repo` lost the `baseline="$(cat ...)"` line and both expressions,
and its two `ok` lines are unchanged.

### Divergences from the plan

* **None in behaviour.** One addition the page did not list: the line
  numbers in `docs/01` §3 all moved, because the heredoc grew. `merge_json`
  131 to 143, `install_repo` 152 to 179, `doctor` 222 to 234, `selftest` 406
  to 418, the six checks and the dispatch with them, and the inline
  `bin/focus-kit:214` and `:114` to `:226` and `:116`. They are updated.
* While there, two references in `docs/03` were already stale before this
  delivery, `bin/focus-kit:196` and `:137`, both pointing at lines that had
  moved in an earlier delivery. They now read `:226` and `:182`. A
  line-number correction in a file this delivery edits, no behaviour claim
  attached.
* `docs/01` §2 counted "2 config fragments" and now counts three.

Nothing was dropped.

### Found on the way, not fixed here

`grep -rn 'bin/focus-kit:[0-9]' docs/` shows more references that were
already wrong before this delivery, in files it does not touch:
`docs/00-Product.md` `:399` and `:100`, `docs/03-Domain.md` `:44`,
`docs/04-Conventions.md` `:110`, `ADR-0001` `:35` and `:117`, `ADR-0002`
`:111`, `:196` and `:117`. Every one of them points at a line that moved in
an earlier delivery, and the `:117` pair predates this one by two versions.
Fixing them by hand is what produced the drift in the first place, so the
line worth queueing is a check that a `bin/focus-kit:N` reference still
names what it claims, not a pass over ten numbers.

### The proof

Five runs, all in a scratch directory, against a 0.5.0 kit extracted with
`git archive HEAD` (this session never commits, so `HEAD` is 0.5.0 all the
way through).

**1. A fresh target is byte-identical to 0.5.0.** A fresh `git init` under
each kit, then `diff` on both merged files:

```
--- .mcp.json ---
identical
--- settings.json ---
identical
```

**2. The escaped baseline.** A scratch copy of the kit whose settings
baseline gained four allow items, one per escape form the Behaviour line
names. On disk the baseline reads:

```
      "Bash(printf \"%s\\\\n\" *)",
      "Bash(echo '''x''' *)",
      "Bash(two\nlines *)",
      "Bash(café *)"
```

`\"` and `\\`, then the sequence that ends a Python literal, then `\n`, then
`\uXXXX`. Installed into a scratch repository, exit 0, and the four printed
back from the target's `.claude/settings.json` through `python3 -c`, with
the same four decoded from the baseline compared against them:

```
Bash(printf "%s\\n" *)
Bash(echo '''x''' *)
Bash(two
lines *)
Bash(café *)
equal: True
```

Each item in the target decodes to exactly what the baseline declares.

**3. The same baseline under 0.5.0 fails.** With the `'''` item in it, it is
a `SyntaxError` at the `'''`. With the Contract's `printf` item alone, which
is the case the page names, it is worse and quieter in shape: Python turns
the `\"` of the JSON into a bare `"` before `json.loads` sees it, the JSON
string ends early, and the install dies with

```
json.decoder.JSONDecodeError: Expecting ',' delimiter: line 14 column 21 (char 257)
```

`set -e` stops the run there, after `.mcp.json` was written, and the
target's `.claude/settings.json` is left as `{}`. So the 0.5.0 failure is
not only a refusal: it truncates a file it had just created.

**4. The seeded target.** A scratch repository carrying an `.mcp.json` with
a second server `other` and a hand-edited `graphify` entry (absolute
`command`, `args` `["some/other/graph.json", "--verbose"]`), and a
`.claude/settings.json` with its own `allow` list holding two baseline items
mid-list (`Read`, `Bash(graphify *)`) and a top-level `"model": "opus"`.
After the install:

```
other server kept:       True
graphify == baseline:    True
server keys:             ['other', 'graphify']
own items first, order:  True
no duplicate:            True
baseline allow present:  True
ask/deny gained:         True True
untouched own key model: opus
enabledMcpjsonServers:   ['graphify']
```

The target's four `allow` items stay first and in their order, the eight
absent baseline items follow in baseline order, and `Read` and
`Bash(graphify *)` appear once.

**5. This repository.** `focus-kit install .` at 0.5.1, then `git diff
--stat .mcp.json .claude/settings.json` and `git status --porcelain` on the
two: both empty. `bin/focus-kit selftest` green, six `ok` lines, check 6
included.

### Decisions

No ADR. The rule is the abstraction the page asked for on the second
occurrence, and `ADR-0001` already says heredoc and still describes what is
there. The `mcpServers` carve-out is the one thing the rule does that a
plain additive merge does not, and it is now written in three places that a
reader reaches from different directions: the comment above `merge_json`,
`docs/01` §5, and the target invariant in `docs/03`.

One judgment call was made visibly rather than left implicit. `docs/01` §3
"If a piece ever appears" said there was no rule in this codebase to
extract. `merge_json` now holds one: five ordered cases over a key,
callable with literals, two dictionaries in and one out. The section keeps
its empty table and gains a paragraph saying why. Merging two JSON files is
not a rule of this business, it is how a file gets written, and the
repository here is the filesystem; extracting it would produce a second
bash function calling the same heredoc, which is the shape ADR-0003 exists
to refuse.

### Environments

| Environment | State |
|---|---|
| Kit source | **0.5.1.** `bin/focus-kit`, `VERSION`, `.gitattributes`, `config/settings.baseline.json`, new `config/mcp.baseline.json`, `CLAUDE.md`, `README.md`, `docs/01`, `docs/03`, `docs/06` edited and staged, not committed. |
| Dogfood copy | **0.5.1.** `focus-kit install .` was run here; check 6 green. |
| Machine | untouched. `~/.local/bin/focus-kit` is a symlink to the kit source, so `focus-kit version` already prints 0.5.1. |
| Target repositories | untouched. They move when their owner runs `focus-kit update <path>`. |
