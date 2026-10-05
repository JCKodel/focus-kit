# focus-kit

Em português: [README.pt.md](README.pt.md).

A delivery process for repositories worked on with a coding agent. It is
one file, `SETUP.md`, that any agent reads and turns into four commands in
your repository. It works with Claude Code, Codex, GitHub Copilot, Cursor,
Google Antigravity, Gemini CLI, Windsurf and any other host that reads
`AGENTS.md`, in any language.

```
/brainstorm  or  /analyze     once: the project's documents, by conversation or by reading the code
/propose <slug>               define the next delivery on one page, by conversation
/apply <slug>                 build that page, prove it, update the docs, stage; never commit
```

## Install

Open your agent in the repository and say:

```
Read https://raw.githubusercontent.com/JCKodel/focus-kit/main/SETUP.md and do what it says.
```

Or download `SETUP.md` next to the repository and point the agent at the
file. The agent writes the four commands for every host the kit knows
(`.claude/skills/`, `.agents/skills/`, `.windsurf/skills/` and the pointer
files of Copilot, Cursor, Gemini CLI and Antigravity) and nothing else, so
the repository opens ready in any of them. There is nothing to install on
the machine: no CLI, no runtime, no dependency. To update, say the same
sentence again.

## Use

1. **Once.** On an empty repository, `/brainstorm`: a conversation about
   what the product is, for whom, how it is built and how it is delivered.
   On a repository with code, `/analyze`: the agent reads the code and asks
   only what the code cannot answer. Both end by writing `docs/00` to
   `06`, `docs/adr/` and `AGENTS.md`, in the language you choose for the
   documents, whatever language you talk in.
2. **Every delivery.** Pick a line of the queue (`docs/06`) and run
   `/propose <slug>`: a conversation that ends in `work/<slug>.md`, one
   page. Read it and ask for every correction in that conversation; then
   open a fresh session and run `/apply <slug>`: it builds the page,
   runs the verify command, proves the result, updates the documents,
   moves the page to `work/done/`, stages and suggests the commit message.
   You review and commit.
   The queue shows it while it happens: the line is `[~]` while `/propose`
   talks, `[>]` when the page is written, `[*]` while `/apply` builds and
   `[x]` when it is done.
3. **Repeat** until the queue is done. New ideas become new lines in the
   queue, by conversation, in any session. A line that waits on an answer,
   on another line, or on anything you name becomes `[?]`, with the reason
   at its end, until the reason is resolved.
4. **Every milestone** is planned with a review as its last line, run like
   any delivery. It takes the milestone's paragraph clause by clause and
   says which delivery answers each one and how you test it. You test;
   what is missing or fails in your hands becomes a line in the same
   milestone, under the review, ready for `/propose` and `/apply`. Those
   lines get no second review: your commit is the review.

The documents carry the weight; the commands only point at them. What each
document holds, the format of the page, and the queue are in `SETUP.md`
§3.5, which is also what the agent installs as the commands' reference.

## Documentation

This page is the short version. The long one is a free book, in English
and Portuguese: **One Page at a Time: Delivering Software and Projects
with Coding Agents**, by J.C. Ködel. It takes a reader who has never
followed any process to running whole projects with coding agents:
Spec-Driven Development as the idea, focus-kit as the method and its tool,
FOCUS as the optional architecture, and just enough git to work with
parallel agents and teams.

* Site: https://jckodel.github.io/focus-kit-book/
* PDF and EPUB: https://github.com/JCKodel/focus-kit-book/releases
* Source: https://github.com/JCKodel/focus-kit-book, a book written with
  the kit, as its example of a project that is not software

## Why this shape

The process was born in **Ninjobs** (https://www.ninjobs.app), a job
platform for IT with bilateral matching and progressive disclosure, built
by one developer with Claude Code from a restart on 2026-08-29 to a public
beta on 2026-09-10. By mid-September 2026: 91 one-page deliveries, 46
migrations, about 35k lines of TypeScript, 830 unit tests and 200
end-to-end tests, all through the queue, `/propose` and `/apply`.

What made it work is small, and the kit keeps exactly that:

* **The documents did the work, not the commands.** Ninjobs' `/propose`
  was eleven lines and its `/apply` forty-eight. Both only said which
  documents to read and what never to do. Every project-specific fact
  (verify command, environments, publish policy, how a screen is proven)
  lived in the project's own process document, written once.
* **One page per delivery.** Not a concision goal: the test that the scope
  was understood. What did not fit became two deliveries.
* **Deciding and doing in separate sessions.** `/propose` writes no code;
  `/apply` starts clean, with only the page and the documents. Scope
  cannot grow during implementation because the person who decided is
  not in the room.
* **The agent never commits.** It stages and suggests the message. Every
  delivery passes through a human review because the commit is the
  review.
* **A governor against ceremony.** Ninjobs' process document ends with the
  list of what it does not have (formal spec, change folders, numbered
  tasks, gates, specialized subagents) and one question for anything that
  wants back in: which concrete error would it have caught? The answer has
  to name an error that happened.

An earlier version of this kit forgot the last rule. It grew an installer,
a knowledge graph, a doctor, a self-test, manifests, and commands ten times
longer than the ones that had worked, asking questions their own author
could not answer. This version is the return to the size that worked, with
one addition Ninjobs did not need: it runs on every host that reads
`AGENTS.md` and in any language.

## FOCUS and git, offered and not imposed

`/brainstorm` and `/analyze` each explain two things in a paragraph, with
a recommendation for your stack, and record what you choose:

* **FOCUS**, the architecture the kit is named after: four pieces with flow
  in one direction (View, Orchestrator, Use Case, Repository), errors as
  values, code organized by feature. You can take it whole, take only the
  two principles (vertical slices and errors as values) with the structure
  your stack favors, or keep your own conventions. Ninjobs took the two
  principles. FOCUS is chapter 7 of the book
  (https://jckodel.github.io/focus-kit-book/07-four-pieces/).
* **Git**: everything on trunk with one delivery at a time, for one person
  working alone; a branch per delivery, for sequential work reviewed by pull
  request; or a worktree per delivery, so several agents build different
  deliveries in parallel, once you decide which can run together. In every
  case a delivery's page and build are one change that reverts in one step
  (one commit on trunk, one merge otherwise), and the agent never commits
  or merges.

## Language

The project chooses the language of its documents once, in `/brainstorm`
or `/analyze`. Everything written afterwards follows it: documents,
delivery pages, ADRs, commit messages. Document numbers are fixed
(`docs/00`, `docs/05`); the names after them are in that language. You talk
to the agent in whatever language you like, in any session, and the
documents still come out in the language the project chose.

## Layout of this repository

```
SETUP.md       the kit: what the agent does, and the four commands with their reference
README.md      this file
README.pt.md   the same, in Brazilian Portuguese
CHANGELOG.md   what changed in each version (CHANGELOG.pt.md in Brazilian Portuguese)
LICENSE        AGPL-3.0-only
```

## License

focus-kit is licensed under the GNU Affero General Public License, version 3
only (`LICENSE`).

**Additional permission under AGPL-3.0 section 7.** The documents the four
commands write into a repository (`docs/`, `work/`, `AGENTS.md`,
`CLAUDE.md`) are not covered works of focus-kit. They belong to that
repository, under whatever license its owner chooses. The command files the
agent installs from `SETUP.md` remain under the AGPL, and holding them in a
repository is aggregation, which does not extend the AGPL to that
repository's own code.

Terms outside the AGPL are granted only by the author, J.C. Ködel, on
request through this repository's GitHub issues.
