# Architecture

How focus-kit is built. What the product **is** lives in
`docs/00-Product.md`; the vocabulary in `docs/03-Domain.md`; the reason
behind each decision in `docs/adr/`. The architecture the kit *teaches* is
FOCUS (`docs/manuals/focus.md`). The architecture the kit *has* is the
subject of this document, and the two are not the same thing. Section 3
says why.

---

## 1. The design in one sentence

One bash script copies a fixed set of markdown files into a repository,
merges one JSON file and appends two fragments, and everything else in the
kit is content that the script moves.

## 2. Stack

```
Language    bash 3.2 (the macOS default) · one script, bin/focus-kit
Platforms   macOS · Linux · Windows through WSL (as Linux) or Git Bash
JSON        a python 3, invoked inline via a heredoc (bin/focus-kit:347)
Content     markdown: 4 skills, 3 manuals, 10 templates, 3 config fragments
Deps (host) uv · graphify (uv tool) · git · curl
Deps (kit)  none. Nothing is imported, nothing is linked, nothing is vendored
Tests       bin/focus-kit selftest, six checks in the script itself
CI          none
```

Windows means Git Bash, the shell Claude Code's Bash tool uses on a native
Windows machine, or WSL, which is Linux and needs nothing of its own. Three
things make Git Bash work and each is a line somewhere else:
`.gitattributes` in this repository checks the script and the markdown out
with LF, so bash does not die on a `\r`; `python_bin` probes an interpreter
by running it, because `python3` there is often the Microsoft Store stub;
and `~/.local/bin/focus-kit` is a two-line wrapper rather than a symlink,
because `ln -s` in Git Bash copies (`README.md`).

**Out, by decision** (they come in only by demonstrated need, and the
delivery that introduces one justifies it):

* **Node, npm, and any JavaScript.** The kit is markdown and bash. A target
  project's stack may need Node; the kit does not (`README.md`, Requirements).
* **bash 4 features.** No associative arrays, no `mapfile`, no `${var,,}`.
  macOS ships bash 3.2 and the script has to run there unchanged
  (`CLAUDE.md`).
* **jq.** JSON merging goes through python3, which is already required.
  Adding jq would add a dependency to save four lines.
* **A packaging system.** No npm package, no Homebrew formula, no pip
  distribution. Install is `git clone` plus a symlink (`README.md`).
* **A test framework.** There is no `bats`, no shunit2. The verify command
  is a verb of the kit itself, `focus-kit selftest` (`docs/05-Process.md`
  §4), and its checks are six bash functions in the same script.
* **A configuration file for the kit.** The kit has no settings of its own.
  What varies per project is a slot in that project's `docs/05-Process.md`.
* **Subagents, hooks and MCP servers.** None at all, since
  `mcp-leaves-the-baseline`. The kit declared graphify's server in a target's
  `.mcp.json` and enabled it in `.claude/settings.json`, and nothing the kit
  ships ever called it: the commands that ask the graph drive the graphify
  CLI through Bash. Measured on 2026-09-17, before the delivery: 38 sessions in this
  repository and 347 in two targets, zero MCP calls. What a target paid was a
  process spawned at the start of every session. A future need for one is a
  delivery that names what would call it.

## 3. The practices in this codebase

| Practice | Answer | Here it is |
|---|---|---|
| Structure | neither slices nor layers: one file | `bin/focus-kit`, the whole CLI, plus the content it moves (§4) |
| Rules | none: there is no business rule to place | nothing decides here; the script copies (ADR-0003) |
| Errors | values | `warn` for a failure inside the flow, `die` for a defect (§6) |
| Tests | the project's own policy | `bin/focus-kit selftest`, six checks in the script itself (`docs/04-Conventions.md` §5) |

This repository answered the four Practice questions the way ADR-0003
already decided them: three against FOCUS's answer and one, errors as
values, with it. That is
the table `/initialize` writes into every project it sets up, and this one is
its own first target: a kit that offered a choice and then assumed the answer
in its own documents would be teaching the opposite of what it ships.

| Piece | Here it is | Lives in |
|---|---|---|
| View | does not exist | |
| Orchestrator | does not exist | |
| Use case | does not exist | |
| Repository | does not exist | |

This is not an omission and it is not a migration waiting to happen. FOCUS
is a four-piece architecture for software that has business rules, state to
publish and data to persist. This project has none of the three. It has a
script that copies files.

The manual's own criterion settles it, and the criterion is
`docs/manuals/focus.md` §What FOCUS is: **every layer pays its own way.** A
layer earns its place only if it can point at a
verifiable gain that would vanish without it. Split `install_repo` into a
view, an orchestrator, a use case and a repository and nothing becomes
testable that was not, nothing becomes swappable that needed swapping, and
the only thing that grows is the number of files a reader has to open. That
is Card 4 of the anti-pattern table, layer by ceremony, applied to the kit
that ships the table.

### What does exist

Three verbs and fifteen helpers, all in `bin/focus-kit`:

| Function | Line | What it does |
|---|---|---|
| `install_repo` | 449 | The whole install into a target: skills, the Installed version, manuals, the Ported commands, the manifest, `work/done/`, the one JSON merge, the two appended fragments, the closing message. The prompt files go in after the manuals and before the manifest, because `write_manifest` fingerprints what has just been written and they are in it. Their `ok` line reuses the names the skill loop built, so a fifth command reaches the screen without a second list; `mkdir -p` and one write per file rather than `copy_tree`, because `.github/prompts` is the person's directory and an install that emptied it would take work that was never the kit's, which is what `docs/manuals/` already does and the reason ADR-0007 gives. |
| `doctor` | 569 | Reports what is present on the machine and in the target, whether the installed version matches `VERSION`, and which kit-owned files are not as `install` wrote them: it fingerprints every file the manifest names, reports a file the manifest names and the target does not have, and looks for files added inside the skill folders. Inside those folders and nowhere else: a file beside a Ported command in `.github/prompts/` is the person's own prompt, `update` removes nothing there, and a warn saying it does would be a warn that lies (`docs/04-Conventions.md` §1). The Ported commands therefore reach two of Drift's three wordings and never the third (`docs/03-Domain.md`, Ported command). The fingerprint has one exception and it is the Manual language's: where the target's manuals are meant to be in another language, the three `docs/manuals/*.md` entries are not compared, because the manifest holds the English file `install` wrote and the disk holds the translation. Everything else the manifest names is compared as it always was, and a manual that is absent is still the missing shape. A path the presence lines above already named missing is not named a second time. The Ported commands have a presence loop of their own, right after the skills loop and in the same shape, one line per file rather than one for the four: each absent path goes into the same list the drift pass reads, and a list is what the deduplication is by, so one line for four would leave the pass free to say all four again. **Every warn names the command that fixes it** (`docs/04-Conventions.md` §1): the two tool lines name `focus-kit update`, which is what installs uv and graphify; the eight project-owned files name `/initialize`, which is what writes them; the skills and the three manuals carry the drift wording verbatim, because they are kit-owned and `update` is what restores them. That is why the eleven paths are two loops and not one, in the order the single loop printed. Then the Manual language (`docs/03-Domain.md`) is read, once, for the two passes that ask it, and where it is not `en` the Translated manual pass runs right after the three manual lines: one `warn` per manual that is still the English file the kit ships, `<path> in English, not <tag> (run /initialize to translate it)`, and the green `docs/manuals (<tag>)` when none is. One line per manual and never a count, the way the Fragment gap and the Manual citation passes already print one line per thing to fix. Still English means equal by `fingerprint` to the source at `KIT_DIR`, which reuses the function and with it the `without_cr` tolerance, since a Windows target holds the untranslated manual as CRLF against the kit's LF and a byte comparison would call it translated; against `KIT_DIR` and not against the manifest, because the manifest answers whether a file was edited and this pass asks whether a translation ever happened. The manuals are enumerated as `manuals/*.md` from `KIT_DIR`, so a fourth manual is a file and no edit, and one the target does not have is skipped, the presence line above having said so. The Global skill gets one line whatever `global_skill_state` returns, green only on `equal`; the other four states name the two versions and the command that fixes it. Then the last line of the machine block and the last that is not about the target: `report_upstream`, the clone against its own `origin` (`docs/03-Domain.md`, Upstream version), placed above every line that speaks of the target so that the kit source and the target are never read for each other. The one Merged file gets a line, and the question there is not presence but content: a fixed-string `grep` behind an `-f` guard asks `.claude/settings.json` for `"Bash(graphify *)"`, because a file that reads `{}` exists and still leaves every permission unasked for. A `grep` and not python, as in check 2 of `selftest` and for the same reason: the failure to catch is python missing. Then the Leftover pass, two warns at most, the same `grep` behind the same guard, naming a hand removal instead of a command: an `.mcp.json` that still declares the graphify server and a `.claude/settings.json` that still enables it, both merged by a kit before `mcp-leaves-the-baseline` and left where they are by every `update` since. Then the Fragment gap pass (`docs/03-Domain.md`), one loop over the two pairs `install_repo` appends, in the order it appends them, so what the kit wrote into a target's own files stays together in the output: for each pair the marker is the fragment's own first line, tested with the fixed-string `grep` `append_once` uses, so the two agree on what a block being there means, and an absent marker is one warn naming `focus-kit update`. Where the block is there, every pattern line of the fragment, a line that is neither blank nor beginning with `#`, is looked for as a whole line of the target's file read through `without_cr`, and each one that is missing is its own warn naming the paste, because a target several versions behind needs the lines and not a count. A whole line and never a substring: an old target holds `graphify-out/cost.json` and lacks `graphify-out/`, and a substring test would go green on the one case the pass exists for. The green `<file> (kit fragment current)` prints only when every pattern line is there. It reads the two fragments from `KIT_DIR` and reports; what a target does about a missing line is a hand edit, because `update` never writes into a block that is already there. And the number, with the Unbumped change (`docs/03-Domain.md`) behind it: a target whose Installed version equals `VERSION` and whose kit-owned files the kit source has moved past. The question is asked only at an equal number, because a target stale by number already carries the one line that names the fix, and only when the manifest exists, because the compare is against what `install` wrote and never against the file on disk, which is what lets a file both edited locally and behind get two lines, each true. `KIT_DIR` is on every machine that runs `doctor`, since the kit is installed by clone and symlink and `KIT_VERSION` is read out of it at startup, so the question is asked in every target and not only here. One pipeline answers it: what `install` would write from today's source, in the manifest's own format, poured together with the manifest, sorted under `LC_ALL=C` and read by `uniq -u`, which keeps a line that appears once. A path appears once when its fingerprint moved, when the source no longer holds it, or when the source holds it and the manifest never listed it, and the three shapes print the one line, `<path> behind the kit source (run focus-kit update)`. The source side is enumerated the way `write_manifest` enumerates the target's, the skill folders `kit_skills` names, `manuals/*.md` and the Ported command each command renders, whose CRC comes out of `render_prompt` through the same `cksum` because a generated file has no source file to fingerprint, so that behind means exactly what `update` would change: a `.DS_Store` beside `skills/` is never copied into a target, and a warn naming a command that would not clear it is a warn that lies (`docs/04-Conventions.md` §1). While any of those lines prints, the green `kit version <v>` line does not, so that green now means the number and the content both. After the Drift pass and after everything the kit owns, the Manual citation pass (`docs/03-Domain.md`), over the documents a target reads again and again: `CLAUDE.md`, `docs/00` to `06` and every file under `docs/adr/`, each read through `without_cr` because the warn quotes the line and a Windows clone puts a carriage return inside the quotes. `work/` is not read, in flight or done. It walks the `§` signs of every line, so two citations on one line are two warns, and what stands in front of a `§` is a citation only when it ends in the name of a manual the kit ships, with nothing between the two but backticks and spaces: `manuals/` is part of the key, because a target's own `docs/05-Process.md` is one file name away from `process.md`. The manuals come from `KIT_DIR` as `manuals/*.md`, so a fourth manual is a file and no edit, and the comparison is against what the next `update` writes rather than against the copy the target holds. A digit after the `§` is a citation by number and a warn on sight, since a section inserted in a manual renumbers every one below it; anything else is matched by `cites_a_heading`, and what does not match is the second warn. One warn per citation and not a count, so a target several versions behind sees every line it has to fix. Both fixes are a hand edit: the citing file is project-owned, which ADR-0002 forbids the CLI, and what the citation meant is only in the sentence around it. The green line prints when neither warn did, a target `/initialize` never ran in included. Reports only; it changes nothing. |
| `selftest` | 1560 | The verify command: creates the scratch repository, writes the fake reader that keeps every check offline and puts it on PATH, calls the six checks in order, removes both through a `trap ... EXIT`. The fake is exported here and not inside check 2 because check 6 runs `doctor` on this repository and has to stay offline too, and it lives in its own directory beside the scratch, not the one check 2 puts the fake `graphify` in for four runs. |
| `kit_skills` | 270 | The commands the kit ships, one folder name per line, read from `skills/*/` and written down nowhere. Eight callers, which is why it is a function and not an eighth copy of the list: `install_repo`, whose skill loop, prompt loop and `ok` lines all read it; `write_manifest`, in both of its blocks that enumerate a command; `doctor`'s presence loop for the skills and the one for the Ported commands, its behind-the-source pipeline and its added-file loop; `check_frontmatter`; and `check_dogfood`. A fifth command is a folder under `skills/` and no edit here, the way a fourth manual is a file under `manuals/`. The one place that still names the commands is check 2 of `selftest`, where the names are the assertion and reading the same list as the reporter would assert nothing (`docs/05-Process.md` §4). Its output is captured, so it reads and never dies (§6). |
| `render_prompt` | 300 | One Command as the reusable prompt another Host reads, written to stdout: the Ported command of `docs/03-Domain.md`. The frontmatter is carried over as it is, its three keys being three the host's own format names, with one line added that puts the host in agent mode; the body reaches the output word for word, each line through five quoted expansions. **The substitution list is here and nowhere else**, five pairs, and a later edit to a skill has to respect it. What every target has whatever its host is not in it, which is why `CLAUDE.md` and `.claude/skills/initialize/templates/` are absent from it (ADR-0007). Pure bash and no interpreter, which is what keeps it deterministic on the three platforms and out of the `die`-inside-`$(...)` trap: its output is captured or piped in all three callers, `install_repo`, `doctor`'s behind-the-source pipeline and `check_dogfood`, so it returns non-zero on a missing source and never dies (§6). |
| `copy_tree` | 321 | Overwrite a kit-owned tree: `rm -rf` the destination, then `cp -R`. Still one caller, the skill loop of `install_repo`: the Ported commands arrived and did not take it, because a tree is what `.claude/skills/<name>/` is and `.github/prompts/` is not the kit's to empty. |
| `merge_json` | 338 | Merge a baseline file into a target file, through a python heredoc that takes two paths and nothing else, so a baseline holding a quote, a backslash or the sequence `'''` is data and never syntax. One rule decides every key: an absent key is taken, two objects merge recursively, two lists concatenate without duplicates, anything else is the baseline's; a key the baseline says nothing about is never reached. Four cases since `mcp-leaves-the-baseline`, which took the `mcpServers` carve-out with the baseline that needed it, and one caller. The heredoc names its encodings, UTF-8 in and UTF-8 with LF out, because python otherwise follows the system locale and writes CRLF in the code page on Windows. It is also where a missing python dies, because `python_bin` cannot. |
| `append_once` | 379 | Append a fragment to a target file the first time and never again. The marker it tests for is the fragment's own first line, read with `head -n 1`, so the marker the file receives and the marker the next run looks for are the same bytes and a third copy of the string does not exist. Returns 0 when it appended and 1 when the marker was already there; the `ok` line stays with the caller, because the two callers name two different files. A blank line goes in ahead of the fragment only when the target file already has something in it. Two callers, both in `install_repo`: `.gitignore` and `.graphifyignore`. |
| `without_cr` | 401 | `tr -d '\r'` over a file: the one place a carriage return is forgiven. A target cloned on Windows with `core.autocrlf=true` has every kit-owned file, the stamp and the manifest checked out as CRLF, and it receives no `.gitattributes`, so the tolerance belongs to the readers. Seven callers: `installed_version`, `fingerprint`, the manifest reader inside `doctor`, `global_skill_state`, the Fragment gap pass, whose fifth call is the first over a file the target itself versions, its own `.gitignore` or `.graphifyignore`, which the same Windows clone checks out with the same byte and which no `.gitattributes` of the kit's reaches, the Manual citation pass, which is the second over a file that is the target's own and the one that would otherwise quote the byte back at the person, since its warn carries the rest of the line, and the read of the Manual language (`docs/03-Domain.md`), the third over a file the target versions and the same shape as the stamp: one line, one token, compared with `en` and quoted back in every line the Translated manual pass writes. It reads and never dies (§6). |
| `fingerprint` | 409 | The POSIX `cksum` CRC of a file read through `without_cr`, the size column dropped. `cksum` because POSIX specifies it and macOS, Linux and Git Bash all have it with no probe, so the manifest a Mac writes is the one those three read back. Written by `write_manifest`, compared by `doctor`. |
| `write_manifest` | 423 | Write `.claude/skills/.focus-kit-manifest`: one line per regular file under the skill folders, per manual copied and per Ported command written, `<crc> <path relative to the target>`, through `LC_ALL=C sort`. The third block enumerates `kit_skills` again rather than the directory, so a prompt file the person put there is not recorded as the kit's, and it is guarded by `[ -f ]` the way the manuals are: a target that predates them has none, and `doctor`'s presence lines are what say so. The stamp and the manifest are not in it. The sort is over the whole line, so the order is by CRC; what matters is that the same tree produces the same bytes, which check 3 requires. |
| `installed_version` | 530 | Read the Installed version out of a target: the stamp through `without_cr`, and nothing else trimmed. Its two callers are `doctor` and `check_dogfood`; it reads and never dies (§6). |
| `cites_a_heading` | 553 | Does a manual still have the section a citation names? The text after the `§` is compared with every heading of the manual, normalized first: the `#`s and the `N. ` numbering go, and what is left is cut at the first comma or opening parenthesis, so `## 5. Errors are values (ch. 8)` gives `Errors are values` and `## 6. Vertical slices, DRY, YAGNI, KISS, CQS` gives `Vertical slices`. That is what lets a person cite the heading in the words the sentence needs instead of pasting a chapter number out of the book. A prefix and never a whole line, because a citation ends inside the sentence around it and nothing marks where. The pattern is a quoted variable, so a heading holding a `*` or a `[` is text and not a glob. The manual is read as it is, without `without_cr`: it comes from `KIT_DIR`, whose `.gitattributes` checks every markdown file out with LF (§2). One caller, the Manual citation pass of `doctor`; it reads and never dies, its status being the whole answer (§6). |
| `python_bin` | 73 | Find a python that runs. It probes `python3` then `python` by executing each one, because a name on PATH is not an interpreter: on Windows `python3` is often the Microsoft Store stub. Falls back to `uv run --no-project`. It echoes the interpreter and returns 0, or prints nothing and returns 1; it never dies, because its output is captured (§6). |
| `version_lower` | 104 | The lower of two dotted version numbers, field by field and numerically through `sort -t. -k1,1n -k2,2n -k3,3n`, because a string comparison puts `0.9.10` before `0.9.8` and would call the newer of the two older. Two callers, `global_skill_state` and `report_upstream`, which is what makes it a function: the sort lived inside the first until the second asked the same question of the clone and its `origin` (`CLAUDE.md`, abstraction on the second concrete occurrence). It reads and never dies (§6). |
| `global_skill_state` | 127 | The state of the Global skill against the graphify package (`docs/03-Domain.md`), one captured line: `<state> <skill> <package>`, a number it could not read written as `-`. Five states: `missing`, `unknown`, `equal`, `older`, `newer`. It reads the Skill stamp through `without_cr` and the second word of `graphify --version`, and orders them through `version_lower`. Two callers, `ensure_graphify` and `doctor`, which turn the one word into a line each. It reads and never dies (§6). |
| `ensure_uv`, `ensure_graphify` | 86, 152 | Make the machine ready. `ensure_uv` is a no-op when uv is there. `ensure_graphify` always runs `uv tool install graphifyy`, the package plain: the `mcp` extra left with `mcp-leaves-the-baseline`, and someone who runs `graphify-mcp` outside the kit installs it themselves. Unconditional and not behind a `command -v`, because that is the only way a machine that installed `graphifyy[mcp]` under an earlier kit reaches the plain requirement; uv makes the step idempotent, not a branch in the script, and it is not an upgrade, which is `uv tool upgrade graphifyy` and the person's call. It then acts on `global_skill_state`: `equal` and `newer` change nothing, every other state runs `graphify install --platform claude` and says which version it came from. |
| `report_upstream` | 228 | The clone against its own `origin` (`docs/03-Domain.md`, Upstream version), one of three lines. It derives the remote from `git config --get remote.origin.url`, reads `VERSION` at `HEAD` of that repository over HTTPS with `curl`, takes the body's first line, and compares it with `KIT_VERSION` through `version_lower`. Read-only on the clone: no ref, no object, no cache and no file is written, and the read is bounded, `--connect-timeout 5 --max-time 10`, so an `origin` that does not answer is a line and never a wait in front of an install. Two callers, `doctor`'s machine block and the dependencies block of `install` and `update`, which is why the wording is here and not in either. Every branch ends in an `ok` or a `warn`, so it never dies whatever the network did (§6): an answer that is not digits and dots, an `origin` the derivation does not cover and a `curl` absent from PATH are the same third line, because a page taken for a number is a warn that lies (`docs/04-Conventions.md` §1). |

Plus one function per check, between `doctor` and the dispatch, each ending
in an `ok` line or a `die`: `check_parses` (979), `check_install` (988),
`check_idempotent` (1438), `check_frontmatter` (1455), `check_no_em_dash`
(1494), `check_dogfood` (1506). They are the six checks of
`docs/05-Process.md` §4 in that order, and `selftest` is nothing but the
list of calls.

The dispatch is a `case` over `$1` at the bottom of the file
(`bin/focus-kit:1596`), and `--help` prints the script's own header comment
through `awk`, every comment line after the shebang up to the first line
that is not one, so the usage text and the documentation are the same bytes
however long the header grows.

The four message shapes are `say`, `ok`, `warn`, `die` (`bin/focus-kit:56`).
`warn` does not stop the run; `die` exits non-zero. A new message picks one
of the four rather than calling `echo` directly.

### If a piece ever appears

The moment the kit grows something that decides rather than copies, the
table above is filled in rather than argued with. The candidate named here
before the verify command existed was a check with a verdict to reach, and
`kit-selftest` is now the place to look. It did not produce one: each of the
six checks runs `bash -n`, an install, a `diff` or a `grep` and reports what
that produced. There is no rule to extract, nothing to call with literals,
and so the table stays empty. `check_frontmatter` is the closest, and it
reads a file line by line rather than deciding anything about one.

`merge_json` is the second closest, and `merge-json-by-argument` is where it
was looked at. It does hold a rule now, five ordered cases over a key, and
the rule is callable with literals: two dictionaries in, one dictionary out,
no filesystem. It still does not earn a row. A use case is where a business
rule lives, and merging two JSON files is not a rule of this business: it is
how a file gets written, which is the repository's work, and the repository
here is the filesystem itself. Extracting it would produce a second bash
function calling the same heredoc, and ADR-0003 is the standing answer to
that shape of consistency.

## 4. The layout

```
bin/focus-kit                     the CLI, one file
skills/<name>/SKILL.md            one folder per command, kit-owned
skills/initialize/templates/      CLAUDE.md and docs/, mirrors the target tree
manuals/<name>.md                 the three manuals, kit-owned
config/settings.baseline.json     permissions merged into a target
config/gitignore.fragment         the block appended once to a target
config/graphifyignore.fragment    the block that keeps the kit out of the graph
VERSION                           one line
LICENSE                           AGPL-3.0-only, verbatim; never copied to a target
docs/                             this project's own documents (project-owned)
work/                             this project's own deliveries (project-owned)
.claude/skills/                   the dogfood copy of skills/
docs/manuals/                     the dogfood copy of manuals/
.github/prompts/<name>.prompt.md  the dogfood copy of the Ported commands
```

The organizing axis is ownership, not technical role. `skills/`, `manuals/`
and `config/` hold what goes into a target; `docs/` and `work/` hold what
belongs to this repository alone. A file's folder answers the question the
kit asks most often, which is whether `update` may overwrite it.

`.github/prompts/` is the one folder here that has no source folder beside
it. There is no `prompts/` next to `skills/`, and there is not going to be
one: what a second host reads is rendered from the `SKILL.md` at install
time, and this repository holds the result because it is its own first
target and not because anybody wrote it (`ADR-0007`). The same folder in a
target holds the same four files and whatever else that person keeps there.

The one place the axis bends is `skills/initialize/templates/`, whose layout
mirrors the target's (`CLAUDE.md`, `docs/00` to `06`, `docs/adr/`) rather
than the kit's. That is deliberate: the template tree and the tree it
produces look the same, so a change to one is obvious in the other.

Nothing is shared between the skills. Each `SKILL.md` is
self-contained and repeats what it needs, because they are read one at a
time by a session that has none of the others in context. That is not
duplicated knowledge in the DRY sense, which is
`docs/manuals/focus.md` §Vertical slices: the house rules have exactly one
authoritative representation, in `manuals/process.md` §The house rules, and
the skills point at it. The git strategy is the
second thing with that shape: what `/discuss`, `/propose` and `/apply` do
under each of the three answers is written once in
`manuals/process.md` §The git strategy, and the three skills read the
project's answer in
`docs/05-Process.md` §7 and point at that section for the rest. Cited by
heading and never by number, because a section added to that manual
renumbers the ones below it.

## 5. Data access and boundaries

The kit touches the filesystem and almost nothing else. There is no
database and no state between runs, and three network calls: the two
dependency installers, and one read of a public file that tells a person
their clone is behind.

| Situation | How |
|---|---|
| Read the kit's own files | Relative to `KIT_DIR`, resolved from the script's real path through symlinks (`bin/focus-kit:48`). Never relative to the caller's working directory. |
| Write a generated file into a target | `render_prompt` to a path under `.github/prompts/`, one per Command. Nothing is removed first: the directory is the target's and the files in it are the kit's, so `mkdir -p` and one write per file, the way `docs/manuals/` is written. What the person keeps in that directory survives every `update`, and what the kit wrote there is overwritten by it (`ADR-0007`). |
| Write a kit-owned file into a target | `copy_tree`: destination removed, then copied. Overwriting is the contract. The install then records what it wrote in `.claude/skills/.focus-kit-manifest` through `write_manifest`, which is kit-owned itself and rewritten on every run. It is the only record that tells a file someone edited from a file the kit has moved past, because a stale target differs from the kit source in every kit-owned file. |
| Write a merged file into a target | `merge_json`: read the file, read the baseline, merge, write. Never removes a key, and since `mcp-leaves-the-baseline` there is no carve-out: the one the `mcpServers` entry had left with the baseline that needed it. What an earlier kit merged and this one no longer ships therefore stays in the target, and `doctor` names it as a Leftover for the person to remove. |
| Write an appended file | `append_once`, for `.gitignore` and `.graphifyignore`. The guard is the fragment's own first line, read with `head -n 1`, so the marker the test looks for and the marker the file receives are the same bytes. Both files are the target's, versioned by the target, and the write stays at the whole block: a block that is there is never touched, so no line a person removed comes back. What the kit gained since is a Fragment gap (`docs/03-Domain.md`), which `doctor` reports and a person pastes in, because the alternative is an `update` re-adding a removed line into a file the target versions. |
| Touch a project-owned file | Written, never. Read, three times. `install_repo` tests whether `docs/00-Product.md` exists, to choose which closing message to print (`bin/focus-kit:513`); the Manual citation pass of `doctor` reads `CLAUDE.md`, `docs/00` to `06` and everything under `docs/adr/`, line by line, to name a citation the next `update` can invalidate; and `doctor` reads the Manual language, the one project-owned file no person is expected to type, written by `/initialize` at the step where it asks the documentation language. Reading is not what ADR-0002 forbids, which is an edit: the fix for what the pass finds is a hand edit, in a file the CLI leaves alone. `work/` is read by neither. |
| Install a machine dependency | `ensure_uv`, a no-op when uv is present and piping a remote script to `sh` when it is not, which is the installer uv publishes. `ensure_graphify` calls `uv tool install graphifyy` on every run and lets uv decide: the same requirement already installed is a no-op, anything else is a reinstall. |
| Read the clone's own upstream | `report_upstream`: one `curl` of `VERSION` at `HEAD` of the repository `origin` names, bounded and read-only. The clone is not written to at all, not even a ref or a cache, and the answer is compared and forgotten. Nothing about the machine or the person is sent: the request is a GET of a public file, and what the kit learns is one number. An `origin` the derivation does not cover is never guessed at. |
| Touch the user's home | Only `graphify install --platform claude`, and only when `global_skill_state` says the Global skill is `missing`, `older` or `unknown` (`bin/focus-kit:184`). What it writes is graphify's, not the kit's: the skill, its `references/` and the Skill stamp, plus a section appended to `~/.claude/CLAUDE.md` when that file does not mention graphify yet. A skill `newer` than the package is never touched, because the installer would downgrade it. |

The privacy boundary is nearly trivial and worth stating exactly. `curl`
appears twice: once to fetch the uv installer, and once to read `VERSION` at
the clone's own `origin`. Both are downloads of a public file. Nothing about
the person, the machine or the target is uploaded, logged or reported, and
the kit holds no personal data to send.

## 6. Errors are values

bash has no Result type, and the kit does not pretend otherwise. What it has
instead is a discipline with the same shape:

* `set -euo pipefail` at the top (`bin/focus-kit:43`). An unhandled failure
  stops the script rather than continuing with a half-installed target.
* `die` is the only exit path for a failure the user has to fix: a missing
  python, a missing directory, an unknown command. It prints in red to
  stderr and exits non-zero.
* `warn` is the value-shaped case: something is not as expected but the run
  is still correct. A target that is not a git repository, a global skill
  that could not be installed, a Leftover an earlier kit merged. The run
  continues and the message stays on screen.
* `doctor` never fails. It reports. Its whole output is `ok` and `warn`
  lines, and a missing file is a `warn`, not a `die`, because the point of
  the command is to list what is missing. A drifted file is a `warn` for the
  same reason: it reports, and what to do about it is the person's call.
* **A function whose output is captured never calls `die`; it returns
  non-zero and the caller dies.** A `die` inside `$(...)` exits the subshell
  and nothing else, so the caller reads an empty string and carries on as if
  nothing had happened. `python_bin` returns 1 and `merge_json` dies
  (`bin/focus-kit:73`, `bin/focus-kit:340`); `without_cr`, `fingerprint` and
  `installed_version` return the status of their `tr` and their callers keep
  their own `-f` guard on the file; `global_skill_state` guards its own two
  files and echoes `missing` or `unknown` where another function would fail;
  `write_manifest` returns the status of
  the pipeline it writes and `install_repo` carries it, which `check_install`
  captures; `check_install` captures `install_repo` and `doctor` the same
  way, and dies on their status.

The distinction is the book's, and the section is
`docs/manuals/focus.md` §Errors are values: a failure that is part of the
flow becomes a value, and a failure that is a defect crashes.
Here, "value" is a `warn` line and a continuing run; "crash" is `die`.

## 7. Environments

| Environment | Where | How code gets there | Used for |
|---|---|---|---|
| Kit source | this repository, `skills/` `manuals/` `config/` `bin/` | a person edits and commits | the truth; everything else is a copy of it |
| Machine | `~/.local/bin/focus-kit`, a symlink, or a two-line wrapper on Windows | `ln -s` once, at setup (`README.md`) | running the CLI anywhere |
| Dogfood copy | this repository, `.claude/skills/`, `docs/manuals/` and `.github/prompts/` | `focus-kit install .` | using the kit on itself, in this session |
| Target repository | any other repository | `focus-kit install` or `focus-kit update` there | real use |

The kit source is the truth while building. The dogfood copy is the one that
goes stale without anyone noticing, because a session reads
`.claude/skills/initialize/SKILL.md` and not `skills/initialize/SKILL.md`:
edit the source, and the session you are in is still running the old
version. `docs/05-Process.md` §5 makes keeping it current a rule of every
delivery.

There is no production environment in the usual sense. The closest thing is
a target repository belonging to someone else, which is reached only when
that person runs `focus-kit update`, and never by anything this repository
does.

## 8. What is not rebuilt

Removed on purpose, from the project the kit came from. Each one was tried.
Bringing one back requires naming a concrete error that happened and that it
would have caught, which is what
`docs/manuals/process.md` §What the process deliberately lacks asks for:

* a formal spec, and a spec delta between deliveries
* an archiving step for finished work beyond moving the file to `work/done/`
* numbered tasks inside a delivery
* a gate between defining and implementing
* specialized subagents per role
* an architecture linter

Never built, and deliberately so:

* the four FOCUS pieces inside `bin/focus-kit` (§3 above)
* an abstraction over `copy_tree` and `merge_json`. They are two functions
  with one caller each. The second concrete occurrence has not happened.
* a configuration file for the kit
* any dependency the target repository would inherit
* a source tree per host. What a second host reads is rendered from
  `skills/<name>/SKILL.md` at install time and never authored beside it
  (`ADR-0007`), so there is no `prompts/` next to `skills/` and no second
  copy of the four commands to keep in step.
