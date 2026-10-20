# The container and its worktrees

What it does: lets a session opened in `main/` create and edit the
delivery worktrees under `../.focus-kit/worktrees/`, which is where
`/propose` creates them and where `/apply` runs.
When: once per clone, before the first `/propose`.

Must be in place: the container folder holds `main/` (this checkout) and
`.focus-kit/worktrees/` side by side.

1. `.claude/settings.json` in `main/` holds
   `{"permissions": {"additionalDirectories": ["../.focus-kit/worktrees"]}}`,
   which grants Claude Code file access there without loading a second
   copy of the skills. Codex gets the same with `--add-dir ../.focus-kit/worktrees`.
2. A delivery's worktree is `../.focus-kit/worktrees/<slug>` on the branch
   `focus-kit/<slug>`; `/apply <slug>` runs in a session opened there, or
   in a subagent sent to that path.

It worked when `/propose` writes `work/<slug>.md` inside the worktree
without asking for permission at every file. Undo: remove the entry.
Skipping it makes every write in a worktree a permission prompt.
