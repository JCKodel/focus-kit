# Conventions and tests

How the code looks and where it is tested. The architecture is in
`docs/01-Architecture.md`; the FOCUS review rules in `docs/manuals/focus.md`.

---

## 1. Language

**Prose in English.** Documents, ADRs, `work/<slug>.md`,
`work/done/<slug>.md` and commit messages. This is the project's
documentation language, and for this repository it is also the language of
everything the kit ships: the skills, the three manuals, the
templates and every string `bin/focus-kit` prints. A target repository
chooses its own documentation language when `/initialize` runs there. The
conversation is a separate matter: it follows the language of whoever is
writing.

**What a target may hold in another language is the three manuals, and
nothing else the kit ships.** `/initialize` writes them in the target's
documentation language, with every section heading left in English, and
records the language in `.claude/skills/.focus-kit-language`
(`docs/adr/ADR-0008`). The skills, the templates and the terminal output stay
English wherever they are installed. The source in this repository is English
in all cases: a manual is translated in a target and never here, so nothing
under `manuals/` is ever anything but the English file, and `update` writing
it back over a translation is the mechanism working.

**Identifiers in English**, whatever the prose language. Function names,
file names, slugs, branches, markers. `docs/03-Domain.md` holds the table
that translates each concept into its code name, once.

The kit has no user interface, so there is no UI text. The strings a person
reads are the terminal output of `bin/focus-kit`, which is English wherever
it runs, and the documents `/initialize` writes, which follow the target's
language. The one translation mechanism is that command writing a manual
again in that language; the CLI has none, and it has no model with which to
have one.

### Text a user reads

**No em dash anywhere in this repository.** The house rule forbids it in any
text a user reads; this project goes further and forbids it in every file,
including code comments and these documents, because the kit's own text sets
the example for every repository it is installed into.

It is the most recognizable signature of generated text, and a product that
shows it loses trust before it explains what it does. Where one would
appear, what is wanted is almost always a full stop and a new sentence; when
it is not, a colon or parentheses.

The rule has no exceptions in text this repository authors, including text
about the rule. The character is referred to by its codepoint, `U+2014`, and
never written, so that the verify command's grep needs no per-line
allowlist. A per-line allowlist is how a ban on a character stops being
checkable.

Generated files are outside the rule, because nobody here writes them:
`graphify-out/GRAPH_REPORT.md` and `graphify-out/graph.html` contain em
dashes that graphify produces, and they return on every rebuild. The grep
is scoped to authored paths rather than given exceptions
(`docs/05-Process.md` §4, check 5).

Beyond that, the copy rules this project needs:

* **A terminal line picks one of four shapes.** `say`, `ok`, `warn`, `die`
  (`bin/focus-kit:56`). Never a bare `echo` or `printf` for a message a
  person reads. The shape carries the meaning, so a message whose shape is
  wrong lies even when its words are right.
* **A `warn` says what to do next.** "uv missing" is half a message; the line
  adds the command that puts it right. Compare `bin/focus-kit:575`, and every
  other warn of `doctor` with it: a person reading one `!` line, without the
  rest of the output, knows what to type.
* **A `die` names the thing that is missing, not the step that failed.**
  "python3 not found (and uv is not installed to supply one)" tells the
  person what to install. A red check of the verify command follows the same
  rule: `check 6: .claude/skills differs from skills (run focus-kit install
  .)` names the thing and what fixes it, not the step.
* **The help text is the script's own header.** `--help` prints it through
  `awk` (`bin/focus-kit:1612`), by a rule and not a range: the shebang is
  skipped, then every consecutive line beginning with `#` is printed until
  the first line that does not, each one losing its `#` and one following
  space. A bare `#` becomes an empty line, which is how the header's blank
  lines survive. Documentation and usage are the same bytes, so they cannot
  drift, and a header that grows a line needs no other edit. A change to the
  header is a change to the help text, and that is the point.
* **The header names every path `install` writes into a target.** Item 2 of
  the header is the whole list, so a delivery that makes `install` write a
  new path writes that line in the same delivery. A rule and not a seventh
  check of the verify command: the only enumeration of what `install` writes
  outside `install_repo` itself is its own `ok` lines, and not every write
  has one. The Installed version is written silently under the skills line
  (`bin/focus-kit:465`), so a check comparing the `ok` output with the header
  would have gone green on exactly the omission
  `help-names-what-install-writes` found.
* **A document says what is, not what is wished for.** When the code and the
  intention differ, both are written, and which is which is marked.

## 2. Names

| Thing | Form | Example |
|---|---|---|
| Bash function | `snake_case`, a verb or a noun the verb produces | `install_repo`, `merge_json`, `python_bin` |
| Verify check | `check_<what it proves>`, one per check of `docs/05-Process.md` §4 | `check_idempotent`, `check_dogfood` |
| Bash local | `snake_case`, short, always declared `local` | `local target`, `local baseline` |
| Bash constant | `UPPER_SNAKE`, set once near the top | `KIT_DIR`, `KIT_VERSION`, `SELF` |
| CLI verb | one lowercase word, no flags | `install`, `update`, `doctor`, `version`, `selftest` |
| Skill folder | one lowercase word, matching the command | `skills/propose/` gives `/propose` |
| Manual | one lowercase word plus `.md` | `manuals/process.md` |
| Template | the exact name of the file it produces | `templates/docs/05-Process.md` |
| Project document | `NN-Name.md`, two digits, PascalCase name | `docs/03-Domain.md` |
| ADR | `ADR-NNNN-kebab-slug.md`, never renumbered | `ADR-0001-bash-and-python3.md` |
| Delivery page | `work/<slug>.md` | `work/kit-selftest.md` |
| Slug | lowercase, hyphenated, names what the user gains | `kit-selftest`, not `add-bash-script` |
| Marker in a file | a comment line, fixed string, never a regex | `# --- focus-kit ---` |
| Init comment | `<!-- init: ... -->`, removed by the command | see any template |
| Kit-owned banner | one line, fixed wording, taken from `manuals/process.md` line 1 rather than retyped. Line 1 of a manual, the first line after the frontmatter of a `SKILL.md`, since a comment above line 1 is not valid YAML | `<!-- kit-owned: focus-kit update overwrites this file. -->` |
| License notice | one line, identical in every kit-owned file and in the CLI's header. Line 2 of a manual, the line after the Kit-owned banner in a `SKILL.md`, line 2 of `bin/focus-kit` as a `#` comment | `<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: ... -->` |

The domain vocabulary is `docs/03-Domain.md` and is not translated
independently: if a document says "dogfood copy", nothing else in the
repository calls it a mirror.

## 3. Style

There is no formatter and no linter, because bash has no house default worth
imposing and the rest of the repository is markdown. What the project cares
about instead:

* **bash 3.2 or it does not ship.** No associative arrays, no `mapfile`, no
  `${var,,}`, no `readlink -f`. macOS ships bash 3.2 and the script runs
  there unchanged. The symlink resolution loop at `bin/focus-kit:48` exists
  for exactly this reason.
* **`set -euo pipefail`, and every variable expansion quoted.** Paths in
  this project contain spaces often enough (`/Volumes/Data/...` does not,
  but a target may) that an unquoted `$target` is a bug waiting for the
  first user with a space in a directory name.
* **`local` on every variable inside a function.** bash globals by default,
  and a leaked `target` is the kind of thing that works until the second
  call.
* **Every write is idempotent, or the line says it is not.** Running
  `install` twice leaves the same tree. A new step that cannot be idempotent
  states so where it happens.
* **Markdown wraps at about 76 characters.** Not enforced, followed. The
  documents are read in terminals and diffed in narrow columns, and a
  reflowed paragraph makes a one-word change look like a rewrite.
* **Frontmatter `description` in a `SKILL.md` uses a `>-` block.** A bare
  colon in the value breaks the YAML and the skill disappears without an
  error message. This has happened; it is the reason the verify command
  checks it.

## 4. Errors are values

bash has no Result type. The equivalent discipline, and the four rules that
stand in for it, are in `docs/01-Architecture.md` §6. In short: `die` for a
defect the user must fix, `warn` for a failure that is part of the flow and
leaves the run correct, `set -euo pipefail` so an unhandled failure stops
rather than half-installing, and `doctor` never failing because reporting is
its job.

The one thing to add here, as a convention rather than a design note: **a
new failure path picks `warn` or `die` before it is written, not after.**
The question is the book's, in
`docs/manuals/focus.md` §Errors are values: is this failure part
of the normal flow? A target that is not a git repository is normal, so it
warns and continues. A missing python3 makes everything after it wrong, so
it dies.

And the rule about where it may die: **a function whose output is captured
never calls `die`; it returns non-zero and the caller dies.** A `die` inside
`$(...)` exits the subshell, not the script, so the caller reads an empty
string and continues. The first occurrence was `check_install`, which
captures `install_repo` and `doctor` and dies on their status
(`work/done/kit-selftest.md`, Two mechanics the page did not name); the
second was `python_bin`, which returned nothing and let an install run on
with no interpreter. `python_bin` now returns 1 and `merge_json` carries the
message, unchanged: `python3 not found (and uv is not installed to supply
one)`. It names the thing that is missing, which is the rule above it.

## 5. Where things are tested

| What | With what | When |
|---|---|---|
| The script parses | `bash -n bin/focus-kit` | always, first thing the verify command does |
| An install produces a complete target | `focus-kit install` into a scratch repository, then `focus-kit doctor` there | every delivery that touches `bin/focus-kit`, `skills/`, `manuals/` or `config/` |
| An install is idempotent | the same install run twice, trees compared | every delivery that touches `install_repo` |
| A skill still loads | the frontmatter of each `SKILL.md` against four structural rules | every delivery that touches a `SKILL.md` |
| No em dash in authored text | a grep over the authored paths | automatic, every run |
| The dogfood copy matches its source | `diff -r skills .claude/skills`, `diff -r manuals docs/manuals`, and each `.github/prompts/*.prompt.md` against a fresh `render_prompt` of the skill it comes from | automatic, every run |

```
bin/focus-kit selftest   = bash -n
                         + install into a scratch repository, then doctor there
                         + the same install again, trees compared
                         + the structural rules of the SKILL.md frontmatters
                         + grep for the em dash over authored paths
                         + diff of the dogfood copies against their sources,
                           the generated prompt files against a regeneration
```

Each check is one bash function in `bin/focus-kit`, named `check_<what it
proves>`, ending in an `ok` line or a `die`. `docs/05-Process.md` §4 is the
slot `/apply` reads and holds the checks in detail; this section is where
they live in the code.

There are no fixtures and no test data. The scratch repository is created by
`mktemp -d`, has `git init` run in it, and is removed at the end whether the
run passed or failed.

**What is not a rule:** mandatory red-green, minimum coverage, a test per
function, a test matrix. Write the check that proves the behaviour; do not
write one to satisfy a count.

**What is non-negotiable:** the install-then-doctor check. It is the only
thing standing between a change here and a broken target repository
somewhere else, and it is the check the project already ran by hand before
it had a name (`CLAUDE.md`).

## 6. Commits

The agent stages (`git add`) and **suggests** the message; a person commits,
after reviewing. The commit is the delivery, and the delivery passes through
human review.

The git strategy here is none, so work goes straight to `main`: no branches,
no pull requests, and nothing made for a slug (`docs/05-Process.md` §7).

Message in the imperative, in English, with the slug as scope. The type, the
scope and the slug stay as they are, because they are identifiers:
`feat(kit-selftest): one command that proves an install still works`.

**With a ceiling.** Subject up to 72 characters; body up to five one-line
bullets, the highlights, not the reasoning. The reasoning (what was weighed,
what was dropped, what diverged from the plan, the state of each
environment) lives in `work/done/<slug>.md`, and the body's last line points
at it.

**Bump `VERSION` in the same commit** as any change a target repository
would want: a skill, a manual, a template, or the CLI's behaviour. A change
to this repository's own `docs/` or `work/` is not such a change.

**The subject starts with a letter.** The first commit in this repository,
`06e923f`, begins with a UTF-8 byte order mark (`EF BB BF`) before
`feat(kit)`. It is invisible in most tools and it sorts and greps wrong. The
history is not worth rewriting for it, but no later commit repeats it.

```
feat(kit-selftest): one command that proves an install still works

* bin/focus-kit selftest: parse, install into a scratch repository, doctor, twice
* checks the three SKILL.md frontmatters against four structural rules
* greps the tree for the em dash and diffs the dogfood copies
* VERSION 0.3.0; targets get it on the next focus-kit update

Details in work/done/kit-selftest.md
```
