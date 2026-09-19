# focus-kit

Em português: [README.pt.md](README.pt.md).

A delivery process for repositories worked on with a coding agent. It is
one file, `SETUP.md`, that any agent reads and turns into four commands in
your repository. It works with Claude Code, Codex and GitHub Copilot, in
any language.

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
file. The agent writes the four commands under the folder its host reads
(`.claude/skills/`, `.agents/skills/` or `.github/skills/`) and nothing
else. There is nothing to install on the machine: no CLI, no runtime, no
dependency. To update, say the same sentence again.

## Use

1. **Once.** On an empty repository, `/brainstorm`: a conversation about
   what the product is, for whom, how it is built and how it is delivered.
   On a repository with code, `/analyze`: the agent reads the code and asks
   only what the code cannot answer. Both end by writing `docs/00` to
   `06`, `docs/adr/` and `AGENTS.md`, in the language you choose for the
   documents, whatever language you talk in.
2. **Every delivery.** Pick a line of the queue (`docs/06`) and run
   `/propose <slug>`: a conversation that ends in `work/<slug>.md`, one
   page. Open a fresh session and run `/apply <slug>`: it builds the page,
   runs the verify command, proves the result, updates the documents,
   moves the page to `work/done/`, stages and suggests the commit message.
   You review and commit.
3. **Repeat** until the queue is done. New ideas become new lines in the
   queue, by conversation, in any session.

The documents carry the weight; the commands only point at them. What each
document holds, the format of the page, and the queue are in `SETUP.md`
§3.5, which is also what the agent installs as the commands' reference.

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
one addition Ninjobs did not need: it runs on three hosts and in any
language.

## FOCUS and git, offered and not imposed

`/brainstorm` and `/analyze` each explain two things in a paragraph, with
a recommendation for your stack, and record what you choose:

* **FOCUS**, the architecture the kit is named after: four pieces with flow
  in one direction (View, Orchestrator, Use Case, Repository), errors as
  values, code organized by feature. You can take it whole, take only the
  two principles (vertical slices and errors as values) with the structure
  your stack favors, or keep your own conventions. Ninjobs took the two
  principles. The book is FOCUS by J.C. Ködel (https://books.kodel.com.br).
* **Git**: everything on trunk with one delivery at a time; a branch per
  delivery; or a worktree per delivery, so several agents build different
  deliveries in parallel. In every case the agent never commits or merges.

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
