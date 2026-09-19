# focus-kit setup

This file is an instruction to a coding agent: Claude Code, Codex, GitHub
Copilot, or any other that reads markdown and can write files. Read it
whole, then do what section 1 says. A person reading it finds what the kit
is in section 2 and the whole of it in section 3.

## 1. What to do

1. Find out which host you are, and take its row of the table below. A
   host not in the table that follows the Agent Skills standard takes the
   Codex row.
2. Write every file of section 3, byte for byte, at the path its heading
   names, relative to that host's skills folder (so `brainstorm/SKILL.md`
   becomes `.claude/skills/brainstorm/SKILL.md` on Claude Code). The one
   exception is 3.7, whose paths are relative to the repository root. Do
   not reformat, summarize, translate or improve any of them; the only
   thing you fill is the `<name>` placeholder of 3.6 and 3.7, once per
   skill. The same content goes to every path a heading lists. A section
   marked "Codex only" or "GitHub Copilot only" is written on that host
   and skipped on the others.
3. Touch nothing else. Do not run `git init`, do not stage, do not commit.
4. Tell the person which files you wrote and what comes next: on a
   repository with no code, `/brainstorm`; on a repository with code,
   `/analyze`. Both run in a fresh session.

Running this file again replaces those files and nothing else. That is how
the kit is updated. Everything the four commands write afterwards (`docs/`,
`work/`, `AGENTS.md`, `CLAUDE.md`) belongs to the project and is never
touched by this file.

| Host | Skills folder | Invoked as | Also write |
|---|---|---|---|
| Claude Code | `.claude/skills/<name>/SKILL.md` | `/<name> <slug>` | nothing |
| Codex | `.agents/skills/<name>/SKILL.md` | `$<name> <slug>` | nothing |
| GitHub Copilot | `.github/skills/<name>/SKILL.md` | `/<name>` | the four prompt files of 3.7 |

In the skills, `$ARGUMENTS` stands for what the person typed after the
command. Claude Code substitutes it; on any other host, read it as "the
word after the command" and leave the token as it is.

## 2. What the kit is

Four commands and a folder of documents. The documents carry the weight;
the commands only point at them.

```
/brainstorm  or  /analyze          once: writes docs/00 to 06, docs/adr/, AGENTS.md
        ↓
docs/06 (the queue, one line per delivery)
        ↓
/propose <slug>                    a conversation that ends in work/<slug>.md, one page
        ↓
/apply <slug>                      a fresh session builds the page, proves it, updates
        ↓                          the docs, moves it to work/done/ and stages
a person reviews and commits
```

The rules the four commands keep, in every project:

* one delivery is one page. If it does not fit one page, it is two;
* deciding and doing are separate sessions. `/propose` writes no code;
  `/apply` widens no scope;
* the agent stages and suggests the commit message. It never commits;
* project specifics (verify command, environments, proof, git) are slots
  in the project's own `docs/05`, filled once and read by `/apply`;
* documents are living: a delivery that changes behaviour updates the
  document that owns it, in the same delivery;
* nothing enters the process without naming the concrete error it would
  have caught.

Two things are offered and never imposed: the FOCUS architecture and a git
strategy. `/brainstorm` and `/analyze` explain each in a paragraph, with a
recommendation, and record the choice. The kit works in any language: the
project chooses the language of its documents once, and every session
talks in whatever language the person writes in.

## 3. The files

### 3.1 `brainstorm/SKILL.md`

````markdown
---
name: brainstorm
description: >-
  Start a new project by conversation, from what it is to how it is
  delivered. Ends by writing docs/00 to 06, docs/adr/ and AGENTS.md.
  Writes no code.
---
You are the thinking partner of someone starting a product. The outcome is
the set of documents `references/documents.md` describes, which every later
session reads before acting. Read that file first, whole.

## Talk

Talk in the language the person writes in, one subject at a time, in this
order. Move on when you could write the section yourself.

1. **The product** (docs/00): what it is in one sentence, for whom, what it
   is not, what a good decision looks like here.
2. **The vocabulary** (docs/03): the ten to twenty words the product cannot
   be described without, each with its identifier in code.
3. **How it is built** (docs/01): the stack, and the shape of the code.
   Present the two choices of `references/documents.md` §Choices, FOCUS and
   git, in their own words, with your recommendation for this stack, and
   record the answers.
4. **The conventions** (docs/04): documentation language, identifier
   language, style, where tests live, commit format.
5. **The process slots** (docs/05): verify command, environments, how a
   screen is proven, publish policy. What does not exist yet is written as
   "created by the first delivery".
6. **The first milestone** (docs/06): three to eight deliveries, one line
   each, in order. The first ones are the skeleton the others stand on.

Ask only what you cannot decide with a sensible default. State the default
and ask whether it holds: a person who cannot answer must be able to say
"your call" and get a good answer. Never ask about a tool by name when the
question is about what the person wants. Use the host's question form when
it has one, recommendation first, at most four questions per round.

## Write

When the six subjects are covered, write, in the documentation language:
docs/00 to 06 as `references/documents.md` describes them; docs/adr/, one
dated ADR per decision taken here that a future session might undo (stack,
FOCUS or not, git, anything the person hesitated on); `AGENTS.md` from the
template; `CLAUDE.md` holding the single line `@AGENTS.md`; and the folder
`work/done/` with a `.gitkeep`, so it survives a clone. The numbers of the
documents are fixed; the names after them are in the documentation
language.

Show the queue and stop. The next step is `/propose <slug>` for its first
line, in a fresh session. Write no code, no configuration and no dependency
file: the first delivery does that, with a page of its own.
````

### 3.2 `analyze/SKILL.md`

````markdown
---
name: analyze
description: >-
  Document an existing repository. Reads the code, writes docs/00 to 06,
  docs/adr/ and AGENTS.md describing what is there, and asks only what the
  code cannot answer. Writes no code.
---
You are documenting a repository so that every later session can act on it
without rereading it. Read `references/documents.md` first, whole: it says
what each document holds.

## Read

The README and any existing docs; the manifests (package.json, pyproject,
go.mod, *.csproj, pubspec.yaml, Cargo.toml, Gemfile, and the like); the
folder tree two levels deep; the entry points; the tests and how they run;
CI; the last fifty commit subjects; any agent rules file already there
(CLAUDE.md, AGENTS.md, .github/copilot-instructions.md, .cursorrules).

From that, infer the stack, how the code is organized, where business rules
live, how errors travel, what the verify command is, and which environments
exist. What the code says, you do not ask.

## Ask

One round, in the language the person writes in, recommendation first, the
host's question form when it has one:

* the documentation language. Default: the language the README is in;
* what the code cannot say: the product's purpose and audience in the
  person's words, when no README says it;
* the two choices of `references/documents.md` §Choices, FOCUS and git,
  presented in their own words. The default is what the code already does,
  and you say what that is;
* the first milestone: three to eight deliveries, or where to read them
  from (issues, a TODO file, a roadmap).

Everything else you decide from the code and mark as observed. Where the
code contradicts itself, the document records an open question; the person
is not asked to settle it now.

## Write

In the documentation language: docs/00 to 06 describing what exists, not
what should exist; docs/adr/ with the decisions the code already embodies
and the ones this round took, one dated paragraph each; `AGENTS.md` from the
template; `CLAUDE.md` holding the single line `@AGENTS.md`; and the folder
`work/done/`. The rules live in `AGENTS.md`: what an existing `CLAUDE.md`,
`.github/copilot-instructions.md` or similar file already says moves into
it, and that file becomes the one import line (or, when its host cannot
import, a one-line pointer to `AGENTS.md`). Show the diff before writing.
The numbers of the documents are fixed; the names after them are in the
documentation language.

Show the queue and stop. The next step is `/propose <slug>` for its first
line, in a fresh session. Change no code.
````

### 3.3 `propose/SKILL.md`

````markdown
---
name: propose
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>
---
You are the stakeholder's thinking partner. The slug is `$ARGUMENTS`; when
there is none, ask for it.

Read docs/00 (product), docs/03 (domain), docs/05 (process: it holds this
project's slots and the format of the page), docs/06 (queue) and whatever
is in `work/` (deliveries in flight). Read docs/01 for where the change
lives.

Talk until the scope fits one page. Ask whenever there is more than one
reading and no document closes it; give your assessment in prose first, and
your recommendation first in every question. If it does not fit one page,
it is two deliveries: say so, propose the split, and write only the first.

Write `work/<slug>.md` in the format docs/05 §The page defines. The
**Contract** section (data, schema, API, message shapes) is the only one
that must be exact: a wrong screen is fixed in a session, a wrong column is
a migration. Use the terms of docs/03; a new concept goes into docs/03
first, with its identifier, and only then onto the page.

Mark the line in docs/06: `[ ]` becomes `[>]`. When the slug is not in the
queue, add the line where it belongs and say so.

Files in the documentation language docs/05 declares; talk in the language
the person writes in. Do not write, edit or generate code, migration, test
or configuration: separating deciding from doing is what keeps scope from
growing during implementation. End with: open a fresh session and type
`/apply <slug>`.
````

### 3.4 `apply/SKILL.md`

````markdown
---
name: apply
description: >-
  Implement work/<slug>.md end to end: code, tests, verify, proof, docs,
  then stage and suggest the commit. Never commits.
argument-hint: <slug>
---
Implement `work/$ARGUMENTS.md` in this session, completely. The page is the
scope; do not widen it.

Read the page, `AGENTS.md`, docs/01 (architecture), docs/04 (conventions)
and docs/05 (process). docs/05 holds this project's slots and you follow
them literally: the verify command, the environments and what a delivery
leaves up to date in each, how a screen is proven, the publish policy, the
git strategy. Work where the git strategy says. If the page contradicts a
document, stop and say which: the document changes in the same delivery or
the page is wrong. Do not resolve it silently.

Build every piece where docs/01 says it goes, with the error convention
docs/01 names. Write the tests docs/04 asks for. Abstraction on the second
concrete occurrence, and the page says which was the first. Add no
dependency, layer or tool the page did not name. No em dash in any text a
user reads.

Run the verify command until it is green. Prove the delivery the way
docs/05 says (screenshot against the reference, end-to-end run, manual
check): list what diverges, fix it until only what you can justify
remains. Leave every environment as docs/05 requires, and never end silent
about them: the last thing you say is which environment is at which
version and the command that updates the others.

Then write into the page what happened: what diverged from the plan and
why, what was dropped, what the proof found, decisions taken (and the ADR,
if one). Update the documents the delivery changed: a new term into
docs/03, a new rule into the document that owns it, a decision into
docs/adr/. Tick every item of "Done when". Move the page to `work/done/`.
Mark the line in docs/06: `[>]` becomes `[x]`.

`git add -A` and suggest the commit message in the format docs/05 defines.
Do not commit and do not merge, whatever the git strategy is. Files and
message in the documentation language; talk in the language the person
writes in.
````

### 3.5 `brainstorm/references/documents.md` and `analyze/references/documents.md`

The same content at both paths.

````markdown
# The documents

Seven numbered documents, a folder of decisions, a rules file and a work
folder. The numbers are fixed, because the four commands cite them; the
name after the number is in the documentation language (`00-Product.md`,
`00-Produto.md`, `00-Produkt.md`). Prose in the documentation language;
identifiers in English unless docs/04 says otherwise.

## What each one holds

**docs/00, the product.** Purpose in one paragraph. Audience: who uses it,
and when there are two sides, which side each requirement serves.
Mechanics: how it works, in user language. Non-goals: what it is not, one
line each. Values: the five or six words decisions are measured against.
Product questions: the checklist every decision must answer yes to. Open
decisions: what nobody may close alone, so an agent never settles them by
assumption. Nothing may contradict this document without changing it in the
same delivery.

**docs/01, the architecture.** The design in one sentence. The stack, with
the reason for each choice that had an alternative. How the code is
organized (§Choices, FOCUS). How data is accessed. How errors travel. The
environments (local, staging, production, or whatever exists) and what runs
where. What was tried and removed on purpose, so it is not rebuilt.

**docs/02, the backend.** Only when there is a server holding rules the
client must not duplicate: schema, access rules, the functions the client
may call. Otherwise one line: "there is none".

**docs/03, the domain.** One table: term, identifier in code, meaning. Then
entities and invariants. Every page in `work/`, every identifier and every
test uses the terms of this table. A new concept enters here first.

**docs/04, the conventions.** Documentation language and identifier
language. Naming. Style and formatting, and the tool that enforces them.
Where tests live and what is tested at each level. Commit message format.

**docs/05, the process.** The template below, with its slots filled.

**docs/06, the queue.** Milestones, each with a paragraph saying what is
true when it closes, and under it one line per delivery, in order:

```
[ ] <slug>    <what it delivers, one line>
```

`[ ]` not yet defined · `[>]` defined, `work/<slug>.md` exists · `[x]` done,
page in `work/done/`. A line never leaves; it changes mark. The queue is
edited by conversation in any session; no command owns it.

**docs/adr/.** One file per decision, `ADR-NNNN-<slug>.md`: context, the
decision, the consequences, the date. An ADR is amended, never rewritten.

**AGENTS.md.** The template below. Read at the start of every session by
Codex and Copilot; Claude Code reads it through `CLAUDE.md`, which holds
the single line `@AGENTS.md`.

**work/.** One page per delivery in flight; `work/done/` holds the finished
ones. Created with a `.gitkeep` in `work/done/`, so the folder survives a
clone.

## Choices

Two things the kit offers and never imposes. Present each in the person's
language, in your own words, with a recommendation for this stack.

**FOCUS.** An architecture in four pieces with flow in one direction. The
View fires events and renders the state it receives, nothing else. The
Orchestrator turns an event into the next state: it fetches, calls the
rule, publishes one state. Use Cases hold every business rule as pure
functions that take data and return a Result, no IO, no framework. The
Repository fetches and saves, and is the only place an infrastructure
exception becomes a value. Code is organized by feature (vertical slices),
not by layer, and a layer exists only when it pays its own way. The book is
FOCUS by J.C. Ködel (https://books.kodel.com.br). Three answers:

* **FOCUS whole:** the four pieces, errors as values, vertical slices.
  docs/01 gets the responsibility table below and names the pieces a slice
  has in this stack;
* **the two principles only:** vertical slices and errors as values, with
  whatever structure the stack favors. Ninjobs, a thin PWA over a backend
  as a service, chose this: component, one function per feature, client
  library, `{ data, error }` everywhere, `throw` never as flow;
* **neither:** the project's own conventions, written in docs/01.

On a repository with code the default is what the code already does.

| Piece | Does | Forbids |
|---|---|---|
| View | fires events, renders state | business rules, data access |
| Orchestrator | converts event to state, fetches, calls use cases, publishes state | deciding rules, persisting |
| Use Case | the only place for business rules; pure; takes data, returns a Result | IO, framework, domain exception |
| Repository | fetch and save; the only place an infra exception becomes a Result | business rules |

**Git.** Three answers, and in every one the agent never commits and never
merges:

* **trunk:** everything on the main branch, one delivery at a time, the
  person reviews and commits after each. The simplest, and what Ninjobs
  did;
* **a branch per delivery:** `/apply` works on a branch named after the
  slug; the person merges. For teams where a delivery is reviewed by
  someone else before it lands;
* **a worktree per delivery:** each `/apply` runs in its own git worktree
  on its own branch, so several agents build different deliveries at the
  same time; the person merges. Costs a directory per delivery and merges
  that can conflict when two deliveries touch the same files.

## The process document (docs/05)

Write it whole, in the documentation language, with the slots of §5
filled. Keep the section numbers: the commands cite them.

```markdown
# Process

How an idea becomes code in <project>.

## 1. The rule

One delivery is one page, `work/<slug>.md`. If it does not fit one page,
it is two deliveries. The page is not a concision goal: it is the test that
the scope was understood. A scope that needs five pages has not been
decided yet.

## 2. The flow

docs/06 → /propose <slug> → work/<slug>.md → /apply <slug>, in a fresh
session → verify green, environments as §5 says → work/done/<slug>.md and
git add → a person reviews and commits.

/propose talks and writes the page, never code. /apply builds, proves,
updates the documents, stages and suggests the commit, never commits.

## 3. The page

    # <slug>

    **Objective.** One sentence: what the user can do afterwards.

    **Behaviour.** Verifiable scenarios in user language. Each line becomes
    a test or a manual check.

    **Contract.** Data, schema, API, message shapes, or "none". The only
    section that must be exact.

    **States.** Empty, loading, error, offline: one line each, or "the
    defaults". Only when there is a screen.

    **Visual reference.** Where the design is, and the viewports. Only when
    there is a screen.

    **Out of scope.** What does not enter, half a line of reason each.

    **Done when.** A mechanical checklist: tests X pass; verify green;
    screenshot matches Y.

After /apply the page also records what happened: what diverged, what was
dropped, what the proof found, the decisions taken.

## 4. The queue

docs/06: one line per delivery, in order, under milestones. The line never
leaves the queue; it changes mark: `[ ]` not defined, `[>]` defined and not
built, `[x]` done. Edited by conversation in any session.

## 5. This project

* **Documentation language:** <language>. Identifiers in <language>.
* **Verify:** `<command>`, which runs <what>. Green before anything is
  declared done. <Or: created by the first delivery.>
* **Environments:** one line each: name, what runs there, what a delivery
  must leave up to date there, and the command that does it.
* **Proof of a screen:** <tool, viewports, reference>, or "no screens".
* **Publish policy:** when an environment beyond the local one is updated,
  and whether the agent asks first.
* **Git:** trunk | a branch per delivery | a worktree per delivery. The
  agent stages; it never commits or merges.

## 6. Commit

The agent stages and suggests the message; the person commits after
reviewing. Imperative subject up to 72 characters, scope in parentheses
when it helps; body up to five one-line bullets, the highlights and not
the reasoning; last line points to `work/done/<slug>.md`, where the
reasoning lives.

## 7. What this process does not have

No formal spec, no spec delta, no change folder, no numbered tasks, no
gate before implementation, no specialized subagent, no tool the
deliveries did not ask for. When one of these is proposed, the question
is: which concrete error would it have caught? The answer names an error
that happened.

## 8. Closing a milestone

When a milestone closes, review the whole with what the host offers, and
each confirmed finding becomes a line in the queue, not a fix in the middle
of the next milestone.
```

## AGENTS.md

Sixty lines at most. Everything in it points at a document; nothing in it
is the only place a rule is written.

```markdown
# <Project>

<One sentence: what it is.> Prose in <language>; identifiers in <language>.

## Read before acting
- the product: docs/00 · the vocabulary: docs/03
- how it is built: docs/01 · the server: docs/02
- style and tests: docs/04 · process: docs/05 · queue: docs/06

## Non-negotiables
- <three to six rules that protect what the product is; from docs/00 and
  docs/01, one line each>
- One delivery = one page in work/<slug>.md: /propose to define, /apply
  to build.
- No em dash in any text a user reads.
- The agent stages and suggests the commit message. It never commits.

## Do not rebuild
- <what was tried and removed on purpose, with the ADR that says why>

## How to work
- <how the code is organized, in one line>
- <how errors travel, in one line>
- `<verify>` before declaring anything done.
- Abstraction on the second concrete occurrence, and the delivery says
  which was the first.
- Ambiguity → ask. Documents are living: a delivery that changes behaviour
  updates the document that owns it, in the same delivery.
```
````

### 3.6 `brainstorm/agents/openai.yaml`, `analyze/agents/openai.yaml`, `propose/agents/openai.yaml`, `apply/agents/openai.yaml`

Codex only. Four files, one per skill, `<name>` replaced by the skill's
name. They stop a message that happens to contain the word "apply" from
building anything unasked.

````yaml
interface:
  display_name: "focus-kit: <name>"
  short_description: "focus-kit: the <name> command. Read SKILL.md."

policy:
  allow_implicit_invocation: false
````

### 3.7 `.github/prompts/<name>.prompt.md`

GitHub Copilot only, and relative to the repository root, not to the
skills folder. Four files, `<name>` replaced by `brainstorm`, `analyze`,
`propose` and `apply`, so the commands exist as slash commands in the
chat. Each one is three lines:

````markdown
---
agent: 'agent'
---
Read `.github/skills/<name>/SKILL.md` and follow it. `$ARGUMENTS` is `${input:slug}`.
````

## 4. Check

Before reporting, confirm: four `SKILL.md` files under the host's skills
folder; two `references/documents.md`; on Codex, four `agents/openai.yaml`;
on Copilot, four prompt files; no other file changed; the string `$ARGUMENTS`
still present in `propose` and `apply`; no em dash in anything you wrote.
Then report the list and the next command.
