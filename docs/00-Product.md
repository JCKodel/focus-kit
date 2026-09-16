# Product

**Project:** focus-kit
**Status:** active
**Last updated:** 2026-09-16

---

## Purpose

This document is the distilled statement of what focus-kit is: its purpose,
audience, mechanics, principles and non-goals. It is the reference every
delivery in `work/` is checked against. Nothing may contradict it without
changing it in the same delivery.

focus-kit exists because working with a coding agent fails in a predictable
way. The failure is not that the agent writes bad code; it is that nobody
decided what the code was supposed to be before it was written. Scope grows
while the implementation is happening, because the person defining and the
agent doing are the same conversation. By the time anyone reads the diff,
the thing built is not the thing asked for, and the reasons are gone.

The kit answers that with a separation and a limit. The separation: deciding
and doing happen in different sessions, `/propose` and `/apply`, and the
first one writes no code. The limit: a delivery is one page, and a scope
that does not fit on one page is two deliveries. Everything else in the kit
exists to make that page short. The product document so the page need not
restate the product. The domain document so it need not define its terms.
The conventions so it need not say how code looks. The architecture, FOCUS,
so it need not say where a rule goes.

What it replaces is the conversation that starts with "let's build X" and
ends three hours later with a diff nobody can review. What it improves on is
the same team's own ad hoc habit: the useful rules already exist in most
projects, scattered across a `CLAUDE.md`, a README and somebody's head. The
kit gives them a fixed address and a command that reads them.

The principle that decides ties: **the page is the product**. When a choice
would make the delivery page longer or make it need something outside
itself, the choice is wrong. That is why there is no formal spec, no
numbered task list, and no gate before implementation. Each was tried in the
project the kit came from, and each one moved weight off the page and into
ceremony.

## Positioning

An installable delivery process for repositories worked on with Claude Code,
built on the FOCUS architecture. Three commands and three manuals, installed
by one script, that make a repository ready for a coding agent to work in
without renegotiating the rules every session.

It is explicitly not sold as: an agent framework, a prompt library, a
project management tool, a linter, or a way to make an agent write code
without review. The last one matters most. The kit's whole shape assumes a
person reads the diff and commits it.

Name: `focus-kit`, lowercase, one word with a hyphen, both as the repository
and as the command. No domain, no brand, no package on any registry. It is
installed by cloning and symlinking (`README.md`).

It is published under the GNU AGPL-3.0-only, so a fork stays open and a
hosted version owes its source, while terms outside those are granted only
by the author (`docs/adr/ADR-0004`).

## Audience

One side, and it is worth being exact about who: **a developer who already
works with Claude Code in their own repository, and who is the person who
commits.** Not a team lead rolling out a process, not an agent operating
unattended. Every rule in the kit assumes the reader can run a command, read
a diff and say no.

There is a second, quieter audience: **the agent itself**. Half of what the
kit installs is written to be read by a model at the start of a session, not
by a person. `manuals/focus.md` is the clearest case. It is a condensed
reference with the book's own words quoted, because a model that has the
rule verbatim argues with it less than a model given a paraphrase.

Markets and languages: the kit's own text is in English. A target repository
picks its own documentation language when `/initialize` runs, and everything
written afterwards follows it while identifiers stay in English. There is no
regulatory context: the kit stores nothing, sends nothing, and holds no
personal data.

## Mechanics

### Installing

A person clones the kit and symlinks `bin/focus-kit` onto their PATH, then
runs `focus-kit install .` inside a repository. The script does two things
in order (`bin/focus-kit:399`): it makes sure the machine has what it needs,
and it writes into the repository.

On the machine: uv, then graphify with its `mcp` extra as a uv tool, then the
global `/graphify` skill for Claude Code. uv is skipped when already present;
graphify is reinstalled on every run and uv decides whether that changes
anything, which is how a machine that installed graphify before the extra
existed gains it. The global skill is installed only when absent, because
installing it also appends a section to the user's `~/.claude/CLAUDE.md`, and
repeating that on every run would keep touching a file the kit does not own
(`bin/focus-kit:100`).

In the repository: the three skills and the three manuals are copied over
whatever is there; `.mcp.json` and `.claude/settings.json` are merged into,
never replaced; the `.gitignore` fragment is appended once; `work/done/` is
created if absent. The script then prints the next step, and which next step
depends on whether `docs/00-Product.md` already exists.

**Rule of product:** the script never touches a project-owned file. Not to
fix it, not to format it, not to add a missing section. A person's document
is theirs, and the only thing allowed to edit it is a command they ran
knowing what it would do.

### Initializing

`/initialize` is run once in the target, inside Claude Code. It writes
`docs/00` to `06`, `docs/adr/`, and `CLAUDE.md`, in the documentation
language it asks for first.

How it gets what it needs depends on what is there. On a greenfield
repository it asks, in rounds of at most four questions, each round about
what the previous one settled. On a brownfield repository it reads first:
manifests, CI, infrastructure, migrations, folder layout, git history, then
builds the graphify graph, and only then asks what the code could not
answer. Everything it asserts about existing code cites the file it came
from.

If `docs/00-Product.md` already exists, the run is a review: it compares the
documents against the code and proposes edits section by section instead of
rewriting.

**Rule of product:** a document is never left with a placeholder. If the
command does not know what goes in a section, it asks. If the section does
not apply, it writes one line saying why and moves on. A half-filled
template is worse than no template, because the next session trusts it.

### Defining a delivery

`/propose <slug>` is a conversation that ends in `work/<slug>.md`. It reads
the product, the domain, the queue and whatever is already in flight; it
asks the graph what the delivery touches; it asks the person whenever there
is more than one reading, with its own recommendation first. It writes no
code, no migration and no test.

The page has a fixed shape: goal, behaviour, contract, slice, states, visual
reference, out of scope, done when. Of those, only the contract has to be
exact, because it is the only one that is expensive to reverse.

**Rule of product:** if the scope does not fit on one page, it is two
deliveries. This is not a style preference about concision. A scope that
needs five pages has not been decided yet, and the page is how you find out
before the code is written rather than after.

### Building it

`/apply <slug>` implements the page in a clean session that reads only that
page and the project documents. It builds each piece in its place, runs the
verify command until green, proves the result the way the project's own
`docs/05-Process.md` says to, and leaves each environment in the state that
document requires.

Then it writes back into the delivery file what actually happened: what
diverged from the plan, what was dropped, what the proof found, what
decisions were taken along the way. It updates the documents the delivery
changed, ticks the "Done when" list, moves the page to `work/done/`, turns
the queue line to `[x]`, stages everything with `git add -A` and suggests a
commit message.

**Rule of product:** it does not commit. Ever, in any configuration, whatever
the project's git policy says. The commit is where a person takes
responsibility for the change, and a process that lets an agent take it has
removed the only review that was guaranteed to happen.

**Rule of product:** it never ends silent about environments. The last thing
it says is which environment is at which version and the command that
updates the others. What costs, in every project, is not the missing deploy.
It is someone opening an environment believing it is current.

### Keeping the map

graphify builds a knowledge graph of the repository and a post-commit hook
rebuilds it after every commit. `/propose` and `/apply` ask the graph before
grepping. The graph is a map, not a source of truth: when it disagrees with
the code, the code wins and the graph gets rebuilt.

## Non-goals

* **Not an agent framework.** The kit adds no runtime, no orchestration
  layer and no subagents. It is markdown and one bash script.
* **Not a replacement for review.** Every path ends at a person reading a
  diff and committing it.
* **Not a project management tool.** The queue has no dates, no estimates,
  no assignees and no status beyond three marks.
* **Not stack-specific.** The three commands name no language, no framework
  and no test runner. Everything specific is a slot in the target's
  `docs/05-Process.md`.
* **Not a linter.** Nothing here checks an architecture automatically. The
  FOCUS review rules are written for a person or an agent to apply while
  reading, and that is deliberate: the rules that mattered were the ones
  phrased so a reviewer could point at a line on screen.
* **Not a package.** No registry, no installer beyond git clone and a
  symlink, no auto-update.
* **Not a book.** `manuals/focus.md` is a condensed reference for an agent
  working in a repository. The book is *FOCUS* by J.C. Ködel, and the manual
  cites it rather than replacing it.

## Values

* **Checkable.** A rule that a reviewer cannot point at on screen is not a
  rule yet. "This `if` decides whether the discount applies, and it sits in
  the orchestrator" is checkable; "this seems coupled" is not.
* **Short.** Length is a cost paid by every future session. The page, the
  documents and the manuals are each as short as they can be while still
  answering the question they own.
* **Honest.** A document says what is, not what was wished for. On a
  brownfield repository, what exists and what the target is are written
  separately and marked as such.
* **Removable.** Every part of the process has to justify its place, and
  the ones that could not were removed. When one is proposed back, the
  question is which concrete error it would have caught, and the answer has
  to name one that happened.
* **Owned.** Every file belongs to the kit or to the project, and the line
  between them is sharp enough that a script can act on it.

## Product questions

Every decision taken during development must answer yes to:

1. Can a reviewer point at a line on screen and say whether this obeys it?
2. Does this make the delivery page shorter, or at least not longer?
3. Does this work in a repository whose stack we have not thought about?
4. Is the rule phrased so that the next session does not have to ask again?
5. Does this keep a person between the change and the commit?
6. If this is a new part of the process, can we name a concrete error that
   happened and that it would have caught?
7. Does the target repository stay able to remove the kit without unpicking
   its own code?
8. Is the text free of em dashes, and would it read the same if a person
   rather than an agent had written it?

## Open decisions

Recorded here so that no agent closes them alone:

1. **Whether the kit ever gets a test suite beyond `selftest`.**
   `bin/focus-kit selftest` exists and runs six checks inside the script
   itself. Whether that grows into a real suite, with a framework and cases
   per function, or stays six checks in one file, is the stakeholder's call.
2. **Whether the dogfood copies stay versioned.** `.claude/skills/` and
   `docs/manuals/` duplicate `skills/` and `manuals/` byte for byte. Keeping
   them means a clone gets a working kit immediately and every diff shows
   the change twice. The decision taken for now is to keep them and keep
   them in sync (`docs/05-Process.md` §5); revisiting it is open. There is a
   measured cost: the first graph build indexed both copies and produced
   mirrored communities, half the graph describing the same files twice,
   with 42 weakly connected nodes as a result
   (`graphify-out/GRAPH_REPORT.md`). Excluding the copies from the graph
   would fix that without settling the versioning question.
3. **How the kit is distributed.** Clone and symlink works for one person.
   Whether it becomes a package, a curl installer, or stays as it is has not
   been decided, and it changes what `update` has to do.
4. **Whether `/initialize` should support a non-English kit.** A target can
   document itself in any language, but the manuals it receives are in
   English. Whether translated manuals are ever shipped is open, and the
   answer affects `copy_tree` and `VERSION` both.
5. **What happens to a target when a kit-owned file changes shape.** Today
   `update` overwrites and the target's documents may silently reference a
   section that moved. There is no migration notion. Whether one is needed
   has not been decided.

---

## Related documents

* `docs/01-Architecture.md`: how the system is built.
* `docs/02-Backend.md`: the server, which this project does not have.
* `docs/03-Domain.md`: entities, invariants and the ubiquitous language.
* `docs/06-Queue.md`: what is left, in order.
* `docs/05-Process.md`: how a delivery is born and declared done.
* `docs/adr/`: the decisions and their reasons.
