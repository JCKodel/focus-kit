# Conventions and tests

How the code looks and where it is tested. The architecture is in
`docs/01-Architecture.md`; the FOCUS review rules in `docs/manuals/focus.md`.

---

## 1. Language

**Prose in English.** Documents, ADRs, `work/<slug>.md`,
`work/done/<slug>.md` and commit messages. This is the project's
documentation language, and for this repository it is also the language of
everything the kit ships: the three skills, the three manuals, the
templates and every string `bin/focus-kit` prints. A target repository
chooses its own documentation language when `/initialize` runs there; the
kit's own text is never translated. The conversation is a separate matter:
it follows the language of whoever is writing.

**Identifiers in English**, whatever the prose language. Function names,
file names, slugs, branches, markers. `docs/03-Domain.md` holds the table
that translates each concept into its code name, once.

The kit has no user interface, so there is no UI text and no translation
mechanism. The strings a person reads are the terminal output of
`bin/focus-kit` and the documents `/initialize` writes.

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
  (`bin/focus-kit:42`). Never a bare `echo` or `printf` for a message a
  person reads. The shape carries the meaning, so a message whose shape is
  wrong lies even when its words are right.
* **A `warn` says what to do next.** "graphify-mcp not on PATH" is half a
  message; the line adds why it matters and what fixes it. Compare
  `bin/focus-kit:74`.
* **A `die` names the thing that is missing, not the step that failed.**
  "python3 not found (and uv is not installed to supply one)" tells the
  person what to install. A red check of the verify command follows the same
  rule: `check 6: .claude/skills differs from skills (run focus-kit install
  .)` names the thing and what fixes it, not the step.
* **The help text is the script's own header.** `--help` prints lines 2 to
  27 of the file through `sed` (`bin/focus-kit:370`). Documentation and
  usage are the same bytes, so they cannot drift. A change to the header is
  a change to the help text, and that is the point. The range is still a
  literal that a new header line makes wrong; fixing that is
  `help-text-follows-header` in the queue.
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
| Kit-owned banner | first line of a manual, fixed wording. The three `SKILL.md` files do not carry one: their first line is YAML frontmatter | `<!-- kit-owned: focus-kit update overwrites this file. -->` |

The domain vocabulary is `docs/03-Domain.md` and is not translated
independently: if a document says "dogfood copy", nothing else in the
repository calls it a mirror.

## 3. Style

There is no formatter and no linter, because bash has no house default worth
imposing and the rest of the repository is markdown. What the project cares
about instead:

* **bash 3.2 or it does not ship.** No associative arrays, no `mapfile`, no
  `${var,,}`, no `readlink -f`. macOS ships bash 3.2 and the script runs
  there unchanged. The symlink resolution loop at `bin/focus-kit:33` exists
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
The question is the book's (`docs/manuals/focus.md` §5): is this failure part
of the normal flow? A target that is not a git repository is normal, so it
warns and continues. A missing python3 makes everything after it wrong, so
it dies.

## 5. Where things are tested

| What | With what | When |
|---|---|---|
| The script parses | `bash -n bin/focus-kit` | always, first thing the verify command does |
| An install produces a complete target | `focus-kit install` into a scratch repository, then `focus-kit doctor` there | every delivery that touches `bin/focus-kit`, `skills/`, `manuals/` or `config/` |
| An install is idempotent | the same install run twice, trees compared | every delivery that touches `install_repo` |
| A skill still loads | the frontmatter of each `SKILL.md` against four structural rules | every delivery that touches a `SKILL.md` |
| No em dash in authored text | a grep over the authored paths | automatic, every run |
| The dogfood copy matches its source | `diff -r skills .claude/skills` and `diff -r manuals docs/manuals` | automatic, every run |

```
bin/focus-kit selftest   = bash -n
                         + install into a scratch repository, then doctor there
                         + the same install again, trees compared
                         + the structural rules of the three SKILL.md frontmatters
                         + grep for the em dash over authored paths
                         + diff of the dogfood copies against their sources
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

Work goes straight to `main`. There are no branches and no pull requests
(`docs/05-Process.md` §7).

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
