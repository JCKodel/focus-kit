# claim

The first script of the kit: a POSIX sh file inside the `propose` skill,
run through git's own shell on every host, that claims a queue line the
way docs/05 §§2 and 5 and `documents.md` §Choices describe, so no agent
has to hold the ls-remote, worktree and push procedure in mind.

**Objective.** `/propose <slug>` claims the line with one command, and
the person opens the `/apply` session at the path that command printed.

**Error it would have caught.** 2026.10.20: a delivery `[*]` in its
worktree and `[ ]` on main, its branch never pushed, so a second clone
would have started it again. 2026.10.20.2: `/propose` run in `main/`
asking for confirmation at every file, and an `/apply` opened in the
wrong folder reading the wrong queue. Both are steps the prose said and
the agent dropped; a script cannot drop them. Proven on 2026-10-20 on a
Windows laptop with git and nothing else: `test/windows.ps1`.

**Behaviour.** The skill's line, the same on every host and shell:

    git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk <slug> <strategy>

`<strategy>` is what docs/05 §5's Git slot says, passed by the agent:
`trunk`, `branch`, or `worktree <hidden> <prefix>` (`worktree .focus-kit
focus-kit/`). The script reads no document: the agent reads the slot,
the script does the steps.

* Worktree, free line: in `main/`, `fk farewell worktree .focus-kit
  focus-kit/`. `git ls-remote --exit-code --heads origin
  focus-kit/farewell` finds nothing; the script adds
  `../.focus-kit/worktrees/farewell` on a new branch `focus-kit/farewell`
  from main's HEAD and pushes it with `-u`. Prints `claim: new`,
  `branch: focus-kit/farewell, pushed`, `path: <absolute path>`,
  `draft: none`. Exit 0.
* Worktree, branch already on the remote (another clone claimed it, or a
  resumption): fetches; reuses the worktree folder when it exists, else
  adds it on the remote branch. Prints `claim: existing`; the agent
  applies docs/05 §4 (a `[~]` line resumes only on the person's word).
* Worktree folder exists, branch not on the remote (the 2026.10.20 near
  miss): pushes the branch now and prints `claim: existing, branch
  pushed now`.
* Branch per delivery: `fk farewell branch`. Same check on `farewell`;
  new: `git switch -c farewell` from HEAD and push `-u`; existing: fetch
  and switch. `path:` is the checkout.
* Trunk: `fk farewell trunk` prints `claim: none, trunk` and the path of
  the checkout. Exit 0, so the skill's line is the same whatever the slot
  says.
* A draft `work/farewell.md` exists where the script runs: `draft:
  work/farewell.md at <path>; bring it into the delivery`. The script
  moves nothing.
* A branch `farewell` without the prefix exists in a worktree project:
  one `note:` line saying it is not the delivery's, then the claim as
  above (`documents.md` §Choices).
* Run inside a worktree of the hidden folder, or on a branch carrying the
  prefix: `error: run from main/, at <path>`. Exit 2. Nothing created.
* HEAD is not the default branch (compared with `origin/HEAD`), in any
  strategy: `error: on branch <name>; claim from <default>`. Exit 2. With
  a branch per delivery this is the second `/propose` typed while the
  first slug's branch is still checked out, which would fork the new
  delivery from the old one.
* The base is the local default branch's HEAD, as the prose says. The
  script fetches first and, when local main is behind `origin/main`,
  prints `note: main is behind origin by <n>; the delivery starts from
  the local HEAD`. It never pulls.
* No remote `origin` with a strategy that pushes: `error: no remote
  origin; the claim needs one, or the Git slot says trunk`. Exit 2.
* Windows, git installed without its shell: git itself fails before the
  script runs. The skill and the README say what that means (below).

**Contract.** One file, `propose/scripts/claim.sh`, written to both
skills folders like 3.1 to 3.5, so the path above exists on every host.
POSIX sh and git only: no bash arrays, no GNU flags, no awk; macOS bash
3.2, GNU and Git for Windows' MSYS sh all run it. Writes LF; the file
ends every line with LF in `SETUP.md`. Output is stdout, one `key: value`
per line, keys fixed: `claim`, `branch`, `path`, `draft`, `note`,
`error`. Exit 0 claimed, 2 refused. It edits no document: the mark
`[~]` stays the agent's first edit, in the path printed. `path:` comes
from git (`git -C <dir> rev-parse --show-toplevel`, which printed
`C:/Users/...` on the Windows test), never from `pwd`, `$PWD`,
`realpath` or `readlink -f`: MSYS `pwd` prints `/c/Users/...`, which
PowerShell cannot open, and the last two are not on macOS bash 3.2. The
hidden-folder argument tolerates a trailing slash (ace's slot writes
`.face/`). Minimum git 2.23, for `switch`; every host in the table
clears it. The path is `.agents/skills/`, never `.claude/skills/`: the
README lets a team remove `.claude/skills/`, and `.agents/skills/` is
the copy every other host reads and the one never removed. On Claude
Code a `git -c alias...` call is a Bash permission prompt; the `propose`
frontmatter gets `allowed-tools: Bash(git:*)`, the experimental field
of the Agent Skills specification that Claude Code honours, so the
claim runs without the prompt-per-file of 2026.10.20.2.

**README requirement, both languages.** A short paragraph under Install:
on Windows, install Git for Windows with its bundled shell, the
installer's default, because the commands' scripts run through it; and
developing inside WSL is strongly recommended. No install script: the
kit killed its installer on 2026-09-19, an installer in PowerShell meets
the execution policy that blocked the `.ps1` twin, and the test
machine's winget has no working source.

**Out of scope.** Marking the line (the agent's edit, as today). Moving a
draft into the worktree (reported, not done). Parsing docs/05 (five
languages; the agent passes the slot's values). An `/apply` guard script
that refuses the wrong folder (second script, same mechanism, its own
page). A `.gitattributes` line `*.sh text eol=lf` (the bundled sh
tolerates CRLF; the line protects Mac and Linux from a script committed
with CRLF, and would be written like the `GEMINI.md` pointer; decide at
the second script, when there are two files to protect).

**What it displaces.** In `/propose`: "start or resume the definition in
the right branch or worktree, a worktree where docs/05's Git slot puts
it, reused when it exists, its branch pushed" becomes "claim the line
with the command above and continue at the path it prints". In
`documents.md` §Choices, the worktree bullet's procedure (the ls-remote
form, the worktree path, the push, the reuse) becomes one sentence naming
the script; the rule stays in docs/05 §2. `SETUP.md` §1 step 2 lists 3.1
to 3.6 as skill files; §4 Check counts fourteen files, and says the
script keeps LF.

**Done when.** `test/run.sh check` green with the version bumped in the
five places, CHANGELOG twins and the book line; `test/run.sh parallel`
still asserts a worktree and a pushed branch for the two free lines;
`test/windows.ps1` runs the real `claim.sh` through the alias against a
local bare remote, worktree and branch cases, from PowerShell and cmd,
green on the Windows machine; a dry run of `SETUP.md` on a worktree
project and a trunk project reports the migration and nothing else; one
interactive `/propose` on a worktree project in Claude Code claims the
line without a permission prompt, which the harness cannot see because
`parallel` runs with permissions skipped.
