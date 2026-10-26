# Testing the kit

A harness for the person releasing the kit, not part of the kit: nothing
here is planted in a project. It answers one question before a version is
cut: does `SETUP.md`, as it is in the working tree, still install and run?

```
test/run.sh check                   static checks, no host, no tokens, seconds
test/run.sh plant    [--host H]     plant the kit in a throwaway project; §4 Check
test/run.sh parallel [--host H]     plant, seed documents, /propose three slugs
test/run.sh apply    [--host H]     parallel, then /apply the two defined pages
test/run.sh overlap  [--host H]     apply, then a page that shares a file with a built, unmerged one
test/run.sh all      [--host H]     check + overlap
test/windows.ps1     [-Claim F]     on a Windows machine: the git alias and claim.sh, no WSL
```

`--host claude|codex|copilot|all` (default: every host installed; a
missing one is reported, not failed), `--dry-run` (build the fixture and print the
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
milestone for the version. It runs the `queue.sh` of `SETUP.md` §3.7 on
`test/fixture/queue/06-Queue.md`, which holds every case the script
decides, and compares its output with `expected-trunk.txt`; then it
pushes delivery branches to a local bare remote (a line in flight with
a line only its branch has, a claimed line with no mark yet, a blocked
copy, a built and unmerged one, a new `after` at the same mark) and
compares with `expected-worktree.txt`; then merges one and runs from a
stale worktree against `expected-stale.txt`; then runs the file with
CRLF endings. It runs the `claim.sh` of §3.6 on two clones of a local
bare remote: new, taken, resumed, existing, here, refused from another
slug's worktree, the create-only push losing a race, and a worktree cut
from origin's main when local main is behind. It runs the `mark.sh` of
§3.8 on a trunk queue with another session's line staged: that line
kept in the index, the marked line alone staged, a slug that prefixes
another's, a missing or doubled slug refused with the file untouched,
CRLF kept, no temporary file left. Then the line budgets of
`CLAUDE.md` as warnings, and the longest sentence of each command,
docs/05 and §1: the error of 2026-10-19 was a 45-line sentence, so a
sentence over fifty words is reported wherever it is, a semicolon not
ending one.

**plant** builds `test/fixture/project` (a shell script with `make
verify`) in a temp container, `<tmp>/main` as the checkout and
`<tmp>/origin.git` as a bare local remote, and gives the host one
sentence: read `SETUP.md` at its working-tree path and do what it says.
Then it asserts §4 Check by file: the sixteen skill files, the four
`openai.yaml`, the host command files, the pointer files, the installed
version, `$ARGUMENTS` kept, no slug input in the brainstorm and analyze
prompts, one line in `GEMINI.md`, nothing else changed, nothing staged or
committed.

**parallel** seeds docs/00 to 06, `AGENTS.md`, `CLAUDE.md`, the
container's manual and `.claude/settings.json`, with docs/05 generated
from the kit's own template (§§1 to 4 and 6 to 8 verbatim, §5 from
`test/fixture/05-slots.md`: English, `make verify`, a worktree per
delivery). The queue has one `[x]` line and five free ones: `farewell`
and `banner`, which touch different files, `portuguese`, which changes
the file `farewell` changes, `shout · after farewell, portuguese`, and
the review, `· after all`. It runs `/propose farewell banner shout`,
told to decide alone, and asserts: a worktree and a pushed
`focus-kit/<slug>` branch for `farewell` and `banner`, each page in its
worktree, each line `[>]` on its branch (`[~]` is a warning), the page
recording the agent's answers; nothing for `shout`, whose `after`
holds; main's queue and tree untouched. That is the error of
2026-10-20: three subagents stopping at the flag, and a session
proposing to edit the installed skill.

**apply** runs `/apply farewell banner` from `main/`, so the session
must send a subagent to each worktree, and asserts per worktree: the
page in `work/done/`, `make verify` green, the line `[x]` in the staged
queue, changes staged and nothing committed, the `commit` block on the
page; main's tree still clean.

**overlap** runs `/propose portuguese`, then `/apply portuguese`, while
`farewell` is built in its worktree and not merged; both change
`src/greet.sh`. It asserts that `/apply` stopped before its first edit:
the line is `[>]`, not `[*]`, on its branch, and `src/greet.sh` is
unchanged in its worktree. That is the harness error of 2026-10-25: the
parallel fixture made two pages share a file and the apply stage
required both built.

**windows.ps1** runs on a Windows machine with git and nothing else,
without WSL, and proves what the kit's script relies on: that
`git -c "alias.fk=!sh <script>" fk` runs a POSIX sh file through the
`sh.exe` Git for Windows installs, from PowerShell and from cmd, with
`core.autocrlf` on, inside a worktree, and that the `claim.sh` of
`SETUP.md` §3.6 claims a line there against a local bare remote. It
also records why the kit ships no `.ps1`: Windows PowerShell 5.1 blocks
one under its default policy. Run it over ssh, the target in your own
hands, never in this folder; `claim.sh` is extracted from `SETUP.md`
so there is no second copy:

```
awk '/^### 3\.6 `propose\/scripts\/claim\.sh`/{f=1} f&&/^````sh$/{p=1;next} p&&/^````$/{exit} p' SETUP.md > /tmp/claim.sh
scp test/windows.ps1 /tmp/claim.sh "$WIN:C:/Users/$WINUSER/"
ssh "$WIN" "pwsh -NoProfile -File C:\Users\$WINUSER\windows.ps1 -Claim C:\Users\$WINUSER\claim.sh"
```

It builds everything under `%TEMP%`, prints `ok`/`FAIL` lines, removes
what it made and exits with the number of failures. Remove the two files
from the machine afterwards.

## Cost and trust

Every stage but `check` runs the host non-interactively with permission
prompts bypassed (`claude -p --dangerously-skip-permissions`, `codex exec
--dangerously-bypass-approvals-and-sandbox`, since Codex's sandbox keeps
`.agents/` read-only, and `copilot -p --allow-all-tools
--allow-all-paths`), inside a temp folder that holds only the fixture.
Copilot's CLI runs on every Copilot plan, the Free one included, whose
allowance is GitHub AI Credits and whose model is chosen automatically;
each stage is one prompt. The CLI loads the kit's skills from
`.agents/skills/` and `.claude/skills/` and invokes one as `/<name>`,
in `-p` mode too, the words after it reaching the skill; the harness
asks for them by name, which the agent also follows. Every host spends
tokens or requests on your account and is not deterministic: a
failing assertion is a reason to open the kept folder and its logs, not
a verdict. The deterministic part is `check`. The other test of a change
is still the dry run of `SETUP.md` on the real repositories that run the
kit.
