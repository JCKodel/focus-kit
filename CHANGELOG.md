# Changelog

What changed in the kit, newest first. The version is the `Version:` line
of `SETUP.md`, the same value a planted repository carries in the
`metadata.version` of its four `SKILL.md`. To move a repository to the
latest version, run `SETUP.md` again and apply any project-document
migrations its report identifies.

Em português: [CHANGELOG.pt.md](CHANGELOG.pt.md).

## 2026.10.08.2

- `/apply` shows the suggested commit message in the conversation too, in
  the same `commit` block that ends the page, both when the delivery is
  done and when it stops blocked with a partial message. Since 2026.10.06
  the message lives on the page, and the agent began suggesting it in the
  conversation as plain text; in a terminal it lost the highlight a fenced
  block gave and blended into the rest of the reply.

## 2026.10.08.1

- Every command writes the next one as the host invokes it. Before, a
  Codex user was told to run `/propose`, which Codex does not recognize;
  Codex invokes skills with `$`.
- `/apply` ends with the person's next steps, commands written out:
  review the staged diff, commit (and merge, on a delivery branch), then
  the queue's next line. Before, a person who had just used the kit for
  the first time knew to commit but had to search the documentation for
  what came after. `/propose` also shows the page's queue line.
- `AGENTS.md` answers "where are we?" from docs/06 and `work/`, with the
  next command. There is no status command: the queue already is the
  status. `AGENTS.md` belongs to the project, so rerunning `SETUP.md`
  reports this line as a migration.

## 2026.10.08

- Behaviour scenarios on the page name a concrete input and the result
  the user sees, and include the cases that must fail and the edges the
  documents imply. `/propose` drafts them from the documents; the person
  corrects them instead of writing them. Before, a person who did not know
  the tool being built left the expected result to the agent, which
  delivered one solution, happy path only, and the client rejected it.
- docs/05 §3 belongs to the project, so rerunning `SETUP.md` reports the
  new Behaviour wording as a migration instead of writing it.

## 2026.10.07

- Blocked lines remember whether to resume `/propose` or `/apply`;
  saved drafts must be fully defined before implementation. Parallel
  branches reconcile the queue without losing findings or dependencies.
- `/apply` stages only its delivery and preserves unrelated changes.
  Blocked work keeps a partial message on the page; on trunk, it stays
  uncommitted. docs/05 §6 owns the commit format.
- Setup preserves custom commands, avoids duplicate Gemini pointers and
  fixes Antigravity activation, Claude Code invocation and Copilot inputs.
  `/propose` and `/apply` now point to their shared process rules.
- Existing projects get a migration report for docs/04, docs/05 and
  `AGENTS.md`, with paths and proposed wording; setup preserves those files.

## 2026.10.06.1

- Code changes only inside `/apply`. A change asked anywhere else, however
  small, becomes a `[ ]` line in docs/06 and the answer stops there. Before,
  the rule lived only inside `/apply`, for a fix found in the middle of it:
  asked for a correction in an ordinary session, an agent edited the code
  directly, with no line in the queue, no page and no verify.
- The rule is in docs/05 §2 and in the Non-negotiables of `AGENTS.md`, as
  `/brainstorm` and `/analyze` write them. Both files belong to the
  project, so rerunning `SETUP.md` does not touch them: in a repository
  already planted, add the sentence to each by hand.

## 2026.10.06

- `/apply` ends the page with the commit message it suggests, in a fenced
  block whose info string is `commit`, on the done path and on the blocked
  one. Before, the message lived only in the chat: an agent answered with
  `git commit -m` lines, and whoever committed later, in another window or
  another session, had nowhere to start from.
- docs/05 §3 says the done page ends in that block.

## 2026.10.05

- The queue shows work while it happens. Two marks join `[ ]`, `[>]` and
  `[x]`: `[~]` while `/propose` talks, `[*]` while `/apply` builds.
- `[?]` marks a line that waits: on the person, on an answer not yet
  given, or on other lines. The reason goes at the end of the line, as
  `· blocked: <reason>` or `· blocked: after <slug>, <slug>`.
- `/apply` stops when the work cannot go on, writes into the page what
  was built and what it waits on, and marks the line `[?]`. When it marks
  `[x]` the last line an `after` names, the waiting line goes back to
  `[>]`, or `[ ]` when it has no page.
- docs/05 §4 gains the table of marks: what each one means and who sets it.

## 2026.10.04.1

- `context/` holds what people said: proposals, emails, transcripts. Each
  item is the original, whole, beside a `<name>.md` that says what it is;
  never a summary.
- `/brainstorm` and `/analyze` read `context/` whole when it exists.
- docs/05 §5 gains the Context slot: `context/` is committed or listed in
  `.gitignore`.

## 2026.10.04

- The kit says its version: the `Version:` line of `SETUP.md` and
  `metadata.version` in the four `SKILL.md`.

## Before versions, 2026-09-19 to 2026-09-30

The kit as it is today, before it carried a version. A repository planted
in this period has no `metadata.version` in its skills; running `SETUP.md`
again brings it to the latest version.

- The kit is one file again: `SETUP.md` holds what the agent does, the
  host table, the four commands and their reference. `/brainstorm` and
  `/analyze` start a project; `/propose` and `/apply` deliver. The queue
  is edited by conversation.
- Every host gets its files on every run: skills go to `.claude/skills/`,
  `.agents/skills/` and `.windsurf/skills/`, with pointer files for
  Copilot, Cursor, Gemini CLI and Antigravity.
- The page and its build are one change: one commit on trunk, one merge
  with a branch or a worktree. `/propose` creates the branch or worktree
  before writing the page and ends by asking the person to read it.
- Every milestone ends with its review, run like any delivery. It takes
  the milestone's paragraph clause by clause and says how to test each
  one; the person tests. A finding is a line in the same milestone, and
  the lines a review adds are not reviewed again.

Earlier versions of the kit, with an installer and a CLI, were replaced
on 2026-09-19; `README.md` §Why this shape says why.
