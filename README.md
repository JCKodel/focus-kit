# focus-kit

Em português: [README.pt.md](README.pt.md).

**Nothing lives only in the chat.** Everything decided about a project
is written down, and the coding agent works from what is written, not
from what was said.

Think of a restaurant. The waiter talks with you and writes the order
ticket. The kitchen never hears that conversation: it cooks what the
ticket says, by the house's recipe book. That is why the dish comes out
right, and when it does not, the ticket shows where the mistake was.

In focus-kit the recipe book is the project's documents, written once.
The ticket is one page per delivery, written by `/propose`. The kitchen
is `/apply`, which starts in a new session with only that page and the
documents. And you taste before it leaves: the agent never commits on
its own.

What that gave two real projects:

* **[Ninjobs](https://www.ninjobs.app)**, a job platform built by one developer, went from a
  restart to a public beta in twelve days. By mid-September it had 91
  one-page deliveries behind it.
* **A client project** came back from the client's acceptance test with
  dozens of failed cases. Read against the documents and the contracted
  specification, each failure turned out to be a bug, a request outside
  the scope, or a mistake in running the test. The bugs became a queue
  of fixes. The mistakes became a guide for the client's testers, people
  who are not engineers, so the retest fails only where the system is
  wrong.

focus-kit is a delivery process for repositories worked on with a coding agent. It is
one file, `SETUP.md`, that any agent reads and turns into four commands in
your repository. It works with Claude Code, Codex, GitHub Copilot, Cursor,
Google Antigravity, Gemini CLI, Devin Desktop and any other host that reads
`AGENTS.md`, in any language.

```
/brainstorm  or  /analyze     once: the project's documents, by conversation or by reading the code
/propose <slug>               define the next delivery on one page, by conversation
/apply <slug>                 build that page, prove it, update the docs, stage; commit only when asked
```

The `/` is how Claude Code and most hosts invoke them; Codex uses
another prefix, which the table in `SETUP.md` §1 gives. Every command
writes the next one in the form your host expects.

## See it working

Two films recorded on real projects, the client project above among them,
anonymized. Click a cover to watch it on YouTube.

| For engineering teams | For business teams |
|---|---|
| [![focus-kit in practice: engineering](https://img.youtube.com/vi/Ywp1iUtEVyY/maxresdefault.jpg)](https://youtu.be/Ywp1iUtEVyY) | [![focus-kit in practice: business](https://img.youtube.com/vi/4cqpi5CfnVc/maxresdefault.jpg)](https://youtu.be/4cqpi5CfnVc) |
| Install, `/brainstorm`, `/analyze` on a legacy system, `/propose`, `/apply`, and Codex and Copilot reading the same queue. | Project status, two reports compared, a client file committed without knowing git, an email reply, a spreadsheet and a deck, from the desktop app. |

Both films are in [the English playlist](https://youtube.com/playlist?list=PLCoT-CR09np8).
The Portuguese recordings are in [the Portuguese playlist](https://youtube.com/playlist?list=PLd13b_CIAdxo).

## Install

Open your agent in the repository and say:

```
Read https://raw.githubusercontent.com/JCKodel/focus-kit/main/SETUP.md and do what it says.
```

Or download `SETUP.md` next to the repository and point the agent at the
file. The agent writes the four commands for every host the kit knows
(`.claude/skills/`, `.agents/skills/` and the pointer
files of Copilot, Cursor, Gemini CLI and Antigravity) and nothing else, so
the repository opens ready in any of them. There is nothing to install on
the machine: no CLI, no runtime, no dependency. To update, say the same
sentence again.

On Windows, keep the shell that Git for Windows installs with git, the
installer's default: the commands' scripts run through it, from
PowerShell or cmd, without WSL. Developing inside WSL is still strongly
recommended, and the kit works the same there. Codex, planting the kit
inside its default sandbox, asks before writing under `.agents/`:
approve it, the folder is the kit's.

Setup checks existing destinations before writing: a custom command or
unrecognized edit is reported with a diff for you to resolve. Updates
replace recognized kit files and keep one pointer in `GEMINI.md`, preserving
its project content. They leave your documents intact and report any rules
still needing migration, with their paths and proposed wording. The skills'
version describes the installed commands, not completion of those migrations.

### Hosts nobody on the team uses

Their files can go, but every update writes them back, and whoever opens
the repository in that host later finds no commands and no warning. Never
remove `AGENTS.md`, `docs/`, `work/` or `.agents/skills/`: despite its
name, `.agents/` is not one host's folder but the copy of the commands
that Codex, Copilot, Cursor, Gemini CLI, Antigravity, Devin Desktop,
OpenCode and Zed all read. What belongs to a single host:

| Host | Its files | Before removing |
|---|---|---|
| Gemini CLI | `.gemini/commands/` and `GEMINI.md` | `GEMINI.md` may hold project content; remove only the pointer line |
| Cursor | `.cursor/commands/` | |
| GitHub Copilot in VS Code | the four `.github/prompts/<name>.prompt.md` | the rest of `.github/` is not the kit's; the Copilot CLI needs no file of its own |
| Antigravity | `.agents/rules/focus-kit.md` | only this file, not `.agents/` |
| Claude Code | `.claude/skills/` and `CLAUDE.md` | `CLAUDE.md` may hold notes besides `@AGENTS.md` |
| Codex | the four `.agents/skills/<name>/agents/openai.yaml` | they stop Codex from running `apply` because a message contains the word |

## Use

1. **Once.** On an empty repository, `/brainstorm`: a conversation about
   what the product is, for whom, how it is built and how it is delivered.
   On a repository with code, `/analyze`: the agent reads the code and asks
   only what the code cannot answer. Both end by writing `docs/00` to
   `06`, `docs/adr/`, `docs/manuals/` when something is done by hand, and
   `AGENTS.md`, in the language you choose for the
   documents, whatever language you talk in.
2. **Every delivery.** Pick a line of the queue (`docs/06`) and run
   `/propose <slug>`: a conversation that ends in `work/<slug>.md`, one
   page. What the documents already answer it decides and writes on the
   page, naming the source; it asks only what they cannot answer. Read
   the page and ask for every correction in that conversation; then
   open a fresh session and run `/apply <slug>`: it builds the page,
   runs the verify command, proves the result, has the delivery's own
   changes reviewed by a context that did not write them, with your
   host's own review where it has one, fixes what that review confirms,
   updates the documents,
   moves the page to `work/done/`, ends it with the commit message it
   suggests, stages and shows that message in the conversation too, in
   the same `commit` block. It gives your next
   steps, commands written out: use what it changed, review, commit, then
   the next line of the queue, and ends saying which environment is at
   which version. You use it as its user would and ask in that session
   for what is wrong, then review and commit, or ask the agent to commit.
   The queue shows it while it happens, so a board
   that reads it stays current: the line is `[~]` from the first thing
   `/propose` writes, `[>]` when the page is completely defined, `[*]`
   from the first thing `/apply` writes and `[x]` as its last. Only the delivery's changes are staged;
   unrelated edits and existing index entries are preserved and reported.
   A blocked build on trunk stays uncommitted until the whole delivery is
   ready; its page keeps a draft message pointing to its current path.
3. **Repeat** until the queue is done. Lost? Ask the agent where things
   stand, in any session: it answers from `docs/06` and `work/`, with the
   next command. New ideas become new lines in the
   queue, by conversation, in any session, and `/propose` for one can run
   right there or in a fresh session; a line the current milestone does
   not need goes under the next one. A line that waits on an answer,
   on another line, or on anything you name becomes `[?]`, with the reason
   at its end, until the reason is resolved. It also records whether to
   resume `/propose` or `/apply`: a partial proposal must finish definition
   before it can be built. The order of the queue is the priority: the
   next delivery is the first free line, and you reorder by conversation.
   A line that needs another done first says so at its end, `· after
   <slug>`, and is free once that one is `[x]`. Free lines that touch
   different files can run at the same time, one session each, in the
   same working tree; ask the agent which ones can. A line can say so in
   advance with `(PA)` after the slug: whether its `/propose` and its
   `/apply` may run while the lines above it are still in flight; whoever
   changes the queue re-judges the tokens. Several at once: type
   `/propose` or `/apply` with several slugs, and the session opens one
   subagent per slug, each in its worktree when there is one, together
   where the tokens allow; their questions come to you through that
   session, with the context to answer them. Say in the command to decide
   alone, or to build each page as soon as it is defined, and read the
   pages and the diffs at the end.
4. **Every milestone** is planned with a review as its last line, run like
   any delivery. It takes the milestone's paragraph clause by clause and
   says which delivery answers each one and how you test it, and runs
   the slow tests that every delivery's verify leaves out. You test,
   and on your word the milestone's whole code is read, the one look at
   the whole instead of a delivery, for what no delivery's own review
   could see: by your host's deep review when it has one that takes the
   whole range, or by the kit's readers, the range since the previous
   review split into areas, one read-only agent each, in any host that
   runs agents; either way every candidate is checked against its file
   before you see it. What is missing, fails in your hands or you confirm from
   the code reading becomes a line in the same milestone, under the review, ready
   for `/propose` and `/apply`. Those lines get no second review: your
   commit is the review.

How to run the product from a fresh clone, what you do by hand outside a
delivery (publish the site, roll back, set up a service), and a proof
`/apply` runs on another machine, are in `docs/manuals/`, one file each,
named after what it does and readable without the other documents.
`/analyze` writes the manuals for what the repository already runs by
hand; `/apply` writes or updates one when a delivery adds or changes it,
and the first delivery after which a person can run the product writes
the manual of running it.

The kit assumes one person who proposes, uses the delivery, reviews the
staged diff and commits. On a team, whoever commits is that reviewer;
the kit does not split the roles further. A person who does not read
code takes part in `/propose`, where the page is written in user
language, tests the delivery as its user, and asks any session where
things stand or what a page decided.

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

Those deliveries ran on Ninjobs' own two commands, the ones this kit was
extracted from. The kit itself was planted in Ninjobs on 2026-09-21,
after the beta. What the kit learned since then came from the
repositories that run it, the book's own among them, and each change
names its error in `CHANGELOG.md`.

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
* **The agent never commits on its own.** It stages and suggests the
  message, and commits only when the person asks. Every
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
  in one direction (View, Orchestrator, Use Case, Repository), exceptions
  as values, code organized by feature. You can take it whole, take only
  the two principles (vertical slices and exceptions as values) with the
  structure your stack favors, or keep your own conventions. Ninjobs took
  it whole. FOCUS is chapter 4 of the book
  (https://jckodel.github.io/focus-kit-book/04-focus/).
* **Git**: everything on trunk, for one person, alone or with several
  sessions on free lines that touch different files, each staging only
  its delivery and committed one at a time; a branch per delivery, for
  sequential work reviewed by pull request; or a worktree per delivery,
  so several people, or deliveries that touch the same files, build in
  parallel without touching each other, each worktree inside a hidden
  folder of the folder whose `main/` is the checkout. In every
  case a delivery's page and build are one change that reverts in one step
  (one commit on trunk, one merge otherwise); what a delivery did outside
  git, a migration run or a message sent, its page says how to undo, or
  that it cannot be. The agent never commits
  or merges on its own. With a branch or a worktree per delivery,
  `/propose` pushes the branch it creates, and that branch is the claim:
  a line whose branch exists on the remote is taken, whatever main's
  queue shows. Parallel worktrees each show their own queue state; when their
  branches are integrated, reconcile `docs/06` by slug, preserving every
  delivery and its latest state. The queue is a shared file even when the
  deliveries change different code.

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
