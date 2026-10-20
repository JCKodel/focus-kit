# Testing the kit

A harness for the person releasing the kit, not part of the kit: nothing
here is planted in a project. It answers one question before a version is
cut: does `SETUP.md`, as it is in the working tree, still install and run?

```
test/run.sh check                   static checks, no host, no tokens, seconds
test/run.sh plant    [--host H]     plant the kit in a throwaway project; §4 Check
test/run.sh parallel [--host H]     plant, seed documents, /propose three slugs
test/run.sh apply    [--host H]     parallel, then /apply the two defined pages
test/run.sh all      [--host H]     check + apply
```

`--host claude|codex|all` (default: every host installed; a missing one
is reported, not failed), `--dry-run` (build the fixture and print the
host commands without running them), `--keep` (keep the temp folder; it
is kept anyway when something fails), `--strict` (line budgets fail
instead of warning).

## What each stage proves

**check** reads `SETUP.md` and the twins: no em dash; the §3 fences
balanced; the five version strings equal; `$ARGUMENTS` in both commands;
four skills with `disable-model-invocation`; the Codex policy and the
Antigravity trigger; `CHANGELOG.md` and `CHANGELOG.pt.md` leading with
the version, with the same number of entries; `README.md` and
`README.pt.md` with the same sections; the book's queue holding a
milestone for the version. Then the line budgets of `CLAUDE.md` as
warnings, and the longest sentence of each command, docs/05 and §1: the
error of 2026-10-19 was a 45-line sentence, so a sentence over sixty
words is reported wherever it is.

**plant** builds `test/fixture/project` (a shell script with `make
verify`) in a temp container, `<tmp>/main` as the checkout and
`<tmp>/origin.git` as a bare local remote, and gives the host one
sentence: read `SETUP.md` at its working-tree path and do what it says.
Then it asserts §4 Check by file: the twelve skill files, the four
`openai.yaml`, the host command files, the pointer files, the installed
version, `$ARGUMENTS` kept, no slug input in the brainstorm and analyze
prompts, one line in `GEMINI.md`, nothing else changed, nothing staged or
committed.

**parallel** seeds docs/00 to 06, `AGENTS.md`, `CLAUDE.md`, the
container's manual and `.claude/settings.json`, with docs/05 generated
from the kit's own template (§§1 to 4 and 6 to 8 verbatim, §5 from
`test/fixture/05-slots.md`: English, `make verify`, a worktree per
delivery). The queue has one `[x]` line and four free ones with tokens:
`farewell (PA)`, `portuguese (PA)`, `shout (-A) · after farewell`, and
the review. It runs `/propose farewell portuguese shout`, told to decide
alone, and asserts: a worktree and a pushed `focus-kit/<slug>` branch
for `farewell` and `portuguese`, each page in its worktree, each line
`[>]` on its branch (`[~]` is a warning), the page recording the agent's
answers; nothing for `shout`, whose `after` holds; main's queue and tree
untouched. That is the error of 2026-10-20: three subagents stopping at
the flag, and a session proposing to edit the installed skill.

**apply** runs `/apply farewell portuguese` from `main/`, so the session
must send a subagent to each worktree, and asserts per worktree: the
page in `work/done/`, `make verify` green, the line `[x]` in the staged
queue, changes staged and nothing committed, the `commit` block on the
page; main's tree still clean.

## Cost and trust

Every stage but `check` runs the host non-interactively with permission
prompts bypassed (`claude -p --dangerously-skip-permissions`, `codex exec
--sandbox workspace-write`), inside a temp folder that holds only the
fixture. It spends tokens on your account and is not deterministic: a
failing assertion is a reason to open the kept folder and its logs, not
a verdict. The deterministic part is `check`. The other test of a change
is still the dry run of `SETUP.md` on the real repositories that run the
kit.
