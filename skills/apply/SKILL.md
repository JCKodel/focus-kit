---
name: apply
description: >-
  Implement work/<slug>.md end to end: code, tests, verify, proof, docs,
  then stage and suggest the commit. Never commits.
argument-hint: <slug>
---
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

Implement `work/$ARGUMENTS.md` in this session, completely.

`/apply` is the first thing typed in its session. When the conversation
already holds a `/propose`, an `/initialize` or an `/apply` before this one,
say `this session already ran <command>; open a new one (/clear, or a new
terminal) and type /apply $ARGUMENTS` and stop, before Read first: nothing
read, nothing built, nothing staged.

## Read first

1. `work/$ARGUMENTS.md`: the delivery. It is the scope; do not widen it.
2. `CLAUDE.md`, `docs/01-Architecture.md`, `docs/04-Conventions.md`.
3. `docs/05-Process.md`: it holds this project's **slots**, and you follow
   them literally: the verify command, the environments table and what a
   delivery must leave up to date in each, the publish policy, the git
   policy, and how a screen is proven.
4. `docs/manuals/focus.md`: the four pieces and the review rules. Every
   line of code you write is reviewable against that table.
5. The slice you are touching. Ensure the graph first, per
   `docs/manuals/graphify.md` §Ensuring the graph, then ask it `graphify
   explain "<the slice's entry point or entity>"` and `graphify affected
   "<the same>"`, and read the files the two answers name. Who calls, uses
   or depends on a symbol is asked of the graph and never grepped. Say in
   one line what you asked and what came back: `graph: explain "<node>"
   named <n> files, affected "<node>" named <n>`, or `graph: no node named
   "<node>"; reading the files the page names` when the graph has none.

If the delivery contradicts a doc, stop and say which; the doc changes in
the same delivery or the delivery is wrong. Do not resolve it silently.

## Build

* **Rules go in the use case, and the use case is pure.** Fetching is the
  orchestrator's; persisting is the orchestrator's through the repository;
  one state comes out. If you find yourself writing an `if` that decides a
  business rule anywhere else, move it.
* **Errors are values.** `throw` is not flow. An infrastructure exception
  becomes a Result in the repository and nowhere else.
* **No em dash in any text a user reads**: label, message, email,
  aria-label, log line shown to users.
* Write the test each piece asks for (`docs/manuals/focus.md` §Testing):
  use cases as units, the orchestrator as the integration, the view as
  event in and render out.
* Abstraction on the second concrete occurrence, and the delivery file
  says which was the first.
* Do not add a dependency, a layer or a tool the delivery did not name.

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

Every file you write is in the project's documentation language, the one
`docs/05-Process.md` §0 declares (`CLAUDE.md` repeats it on its language
line, `docs/04-Conventions.md` §1 has the detail), and so is the commit
message you suggest. English when nothing says otherwise. Identifiers stay in English regardless. Talk to the person
in the language they write in.
