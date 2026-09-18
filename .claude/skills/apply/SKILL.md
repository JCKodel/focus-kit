---
name: apply
description: >-
  Implement work/<slug>.md end to end: code, tests, verify, proof, docs,
  then stage and suggest the commit. Never commits.
argument-hint: <slug>
---
<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

Implement `work/$ARGUMENTS.md` in this session, completely.

`/apply` is the first thing typed in its session. When the conversation
already holds a `/discuss`, a `/propose`, an `/initialize` or an `/apply`
before this one,
say `this session already ran <command>; open a new one (/clear, or a new
terminal) and type /apply $ARGUMENTS` and stop, before Read first: nothing
read, nothing built, nothing staged.

Then check where you are standing, still before Read first. Read
`docs/05-Process.md` §7 and nothing else to do it: its first line names the
git strategy. When it names a worktree per delivery or a branch per slug and
this session is not in the one for `$ARGUMENTS`, say the strategy, where you
expected to be, where you are and the command that gets there, and stop:
nothing read, nothing built, nothing staged. What the one for this slug is,
and which command gets there, is `docs/manuals/process.md` §The git strategy.
When §7 names none, there is nothing to check and the manual is not read.

## Read first

1. `work/$ARGUMENTS.md`: the delivery. It is the scope; do not widen it.
2. `CLAUDE.md`, `docs/01-Architecture.md`, `docs/04-Conventions.md`.
3. `docs/05-Process.md`: it holds this project's **slots**, and you follow
   them literally: the verify command, the environments table and what a
   delivery must leave up to date in each, the publish policy, the git
   policy, and how a screen is proven.
4. `docs/01-Architecture.md` §3 before anything of the manuals: it holds the
   four practices this project answered and the pieces a slice has here.
   Then, of `docs/manuals/focus.md`, only the sections those answers name,
   and nothing at all for an answer that is not the manual's:
   * rules in pure use cases behind an orchestrator: §2, the canonical
     responsibility table; §3, the four pieces; §10, the anti-patterns.
     Every line of code you write is then reviewable against that table.
   * errors as values: §5.
   * vertical slices: §6.
   * a test per piece: §8, at Build and not here.

   Read the named section alone: one `grep -n '^#'` over the manual gives its
   heading's line and the next heading of the same level, and you read that
   range and nothing else of the manual.
5. The slice you are touching. Ensure the graph first, per
   `docs/manuals/graphify.md` §Ensuring the graph.
   Read the named section alone: one `grep -n '^#'` over the manual gives its
   heading's line and the next heading of the same level, and you read that
   range and nothing else of the manual.
   Then ask it `graphify
   explain "<the slice's entry point or entity>"` and `graphify affected
   "<the same>"`, and read the files the two answers name. Who calls, uses
   or depends on a symbol is asked of the graph and never grepped. Say in
   one line what you asked and what came back: `graph: explain "<node>"
   named <n> files, affected "<node>" named <n>`, or `graph: no node named
   "<node>"; reading the files the page names` when the graph has none.

If the delivery contradicts a doc, stop and say which; the doc changes in
the same delivery or the delivery is wrong. Do not resolve it silently.

## Build

* **Every piece goes where `docs/01-Architecture.md` §3 says it goes.** When
  that table answers rules with pure use cases behind an orchestrator, the
  rule is a pure function, fetching is the orchestrator's, persisting is the
  orchestrator's through the repository, one state comes out, and an `if`
  that decides a business rule anywhere else moves. When it answers
  otherwise, the rule goes where the table says and nowhere else. A piece
  that table says does not exist does not appear in the diff.
* **A failure travels the way `docs/01-Architecture.md` §3 answers.**
  Values: `throw` is not flow, and an infrastructure exception becomes a
  Result in the repository and nowhere else. Exceptions as flow: it is
  thrown and caught where `docs/01-Architecture.md` §6 says, and nowhere
  else.
* **No em dash in any text a user reads**: label, message, email,
  aria-label, log line shown to users.
* Write the test the tests answer of that table asks for. A test per piece
  is use cases as units, the orchestrator as the integration, the view as
  event in and render out (`docs/manuals/focus.md` §8 Testing, read the way
  item 4 of Read first says). The project's own policy is the rows of
  `docs/04-Conventions.md` §5.
* Abstraction on the second concrete occurrence, and the delivery file
  says which was the first.
* Do not add a dependency, a layer or a tool the delivery did not name.
* What the page **leaves to the run**, a version, a file's name or
  extension, a flag, you settle by running it, inside the constraint the
  page states, and Close step 1 says what you chose. When no run satisfies
  the constraint, stop and say which, the way you do with a doc the
  delivery contradicts: do not pick a way out alone.

## Prove

Run the verify command from `docs/05-Process.md` until it is green. If
there is a screen, prove it the way §Proof of `docs/05-Process.md` says
(screenshot at the named viewports against the named reference; list the
differences and fix them until only what you can justify remains).

Leave every environment in the state `docs/05-Process.md` §Environments
requires of a delivery. Publish further only when the policy there says
so. **Never end silent about environments**: the last thing you say is
which environment is at which version, and the command that updates the
others.

## Close

1. Write into `work/$ARGUMENTS.md` what happened: what diverged from the
   plan and why, what was dropped, what the proof found, decisions taken
   (and the ADR you wrote, if any), the state of each environment.
2. Update the docs the delivery changed: a new term goes into
   `docs/03-Domain.md`, a new rule into the doc that owns it, a decision
   into `docs/adr/`. Docs are living; a delivery that changes behaviour
   and leaves the doc stale is not done.
3. Tick every item of "Done when". Move the file to `work/done/`.
4. Mark the line in `docs/06-Queue.md`: `[>]` becomes `[x]`.
5. `git add -A`. Suggest the commit message in the format
   `docs/05-Process.md` defines: subject up to 72 characters, body up to
   five one-line bullets, last line pointing at `work/done/<slug>.md`.
   **Do not commit.** The graph rebuilds itself on the person's commit
   (post-commit hook).
6. When `docs/05-Process.md` §7 names a worktree per delivery or a branch
   per slug, name the command that brings this slug's branch to the trunk,
   and under a worktree the removal of the directory too, the way
   `docs/manuals/process.md` §The git strategy words them. Name them and run
   neither: the agent never commits and never merges, whatever the strategy
   says (`docs/00-Product.md`, Building it).

Every file you write is in the project's documentation language, the one
`docs/05-Process.md` §0 declares (`CLAUDE.md` repeats it on its language
line, `docs/04-Conventions.md` §1 has the detail), and so is the commit
message you suggest. English when nothing says otherwise. Identifiers stay in English regardless. Talk to the person
in the language they write in.
