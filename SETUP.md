# focus-kit setup

This file is an instruction to a coding agent: Claude Code, Codex, GitHub
Copilot, or any other that reads markdown and can write files. Read it
whole, then do what section 1 says. A person reading it finds what the kit
is in section 2 and the whole of it in section 3.

Version: 2026.10.08

## 1. What to do

1. Before writing anything, inspect every destination in section 3. An
   existing file may be replaced only when it matches a file shipped by
   focus-kit, in this version or a prior version verified from the kit's
   source history. A familiar name or a `metadata.version` alone does not
   establish ownership. If a destination contains a custom command or an
   unrecognized edit, show its diff against the proposed file and stop
   before writing any file; the person decides how to preserve or replace
   it. `GEMINI.md` is the exception: preserve its project content as 3.11
   says. Do not create a manifest to track ownership.
2. Write every file of section 3, byte for byte, at every path its
   heading names. Sections 3.1 to 3.5 name paths relative to a skills
   folder, and each of those files goes to all three: `.claude/skills/`,
   `.agents/skills/` and `.windsurf/skills/` (so `brainstorm/SKILL.md`
   is written three times). Sections 3.6 to 3.11 name paths relative to
   the repository root. Do not reformat, summarize, translate or improve
   any of them; fill only the `<name>` placeholder of 3.6 to 3.9, using
   the two prompt templates of 3.7 for their respective commands.
3. Touch nothing else. Do not run `git init`, do not stage, do not commit.
4. When the project already has docs/ or AGENTS.md, compare its rules with
   the current templates and report every migration still needed, with
   the actual path, section and proposed wording in its documentation
   language. Check docs/05 §§2, 3, 4 and 6 (code only inside /apply,
   completed proposals, Behaviour scenarios with concrete input and
   failure cases, resumption, shared queue and isolated staging),
   docs/04's pointer to docs/05 §6, and AGENTS.md's process rules. Include
   any missing slots of docs/05 §5, such as Context. Preserve project
   choices; do not edit these files during setup. Report installed skill
   version separately from pending process migrations; an updated skill
   version does not mean the project's process is updated.
5. Tell the person which files you wrote and what comes next: on a
   repository with no code, `/brainstorm`; on a repository with code,
   `/analyze`. Both run in a fresh session. On an already documented
   project, report the pending migrations first, or say there are none;
   do not ask it to repeat /brainstorm or /analyze to update its process.

Running this file again replaces those files and nothing else. That is how
the kit is updated. Everything the four commands write afterwards (`docs/`,
`work/`, `AGENTS.md`, `CLAUDE.md`) belongs to the project and is never
touched by this file.

Every host gets its files on every run, whichever host runs this file, so
the repository opens ready in any of them and switching hosts changes
nothing. The rules live in `AGENTS.md`, which every host below reads on its
own or through the pointer the table names. Skill folders overlap on
purpose: `.agents/skills/` is read by Codex, Copilot, Antigravity, OpenCode
and Zed; `.claude/skills/` by Claude Code and Copilot. What a host that
reads two of them does with the same name in both, the kit has not tested.

| Host | Reads the rules from | Reads the commands from | Invoked as |
|---|---|---|---|
| Claude Code | `CLAUDE.md`, which imports `AGENTS.md` | `.claude/skills/<name>/SKILL.md` | `/<name> <slug>` |
| Codex | `AGENTS.md` | `.agents/skills/<name>/SKILL.md` | `$<name> <slug>` |
| GitHub Copilot | `AGENTS.md` | `.agents/skills/<name>/SKILL.md`, through `.github/prompts/<name>.prompt.md` | `/<name>` |
| Cursor | `AGENTS.md` | `.agents/skills/<name>/SKILL.md`, through `.cursor/commands/<name>.md` | `/<name>`; whether a slug typed after it reaches the command is not documented |
| Google Antigravity | `AGENTS.md` directly; `.agents/rules/focus-kit.md` is an always-on pointer | `.agents/skills/<name>/SKILL.md` | `/<name> <slug>` |
| Gemini CLI | `AGENTS.md`, through `GEMINI.md` | `.agents/skills/<name>/SKILL.md`, through `.gemini/commands/<name>.toml` | `/<name> <slug>` |
| Windsurf | `AGENTS.md` | `.windsurf/skills/<name>/SKILL.md` | `@<name> <slug>` |
| OpenCode, Zed | `AGENTS.md` | `.agents/skills/<name>/SKILL.md` | by asking for the skill |
| Jules, Junie, Warp, Kiro, Roo Code, Cline | `AGENTS.md` | none; ask in words for `.agents/skills/<name>/SKILL.md` | |

Each row was read off the vendor's documentation on 2026-09-21; the Claude
Code invocation policy, Copilot prompts and Antigravity rules were checked
again on 2026-10-07. A host
enters this table only with its documentation in hand: Claude Code
https://code.claude.com/docs/en/memory and https://code.claude.com/docs/en/skills;
Codex https://developers.openai.com/codex/skills and
https://developers.openai.com/codex/guides/agents-md; Copilot
https://docs.github.com/en/copilot/concepts/agents/about-agent-skills and
https://docs.github.com/en/copilot/tutorials/customization-library/prompt-files/your-first-prompt-file;
Cursor https://cursor.com/docs/rules and
https://cursor.com/docs/cli/reference/slash-commands; Antigravity
https://antigravity.google/docs/rules and
https://antigravity.google/docs/skills/; Gemini CLI
https://geminicli.com/docs/cli/gemini-md/ and
https://geminicli.com/docs/cli/custom-commands/; Windsurf
https://docs.windsurf.com/windsurf/cascade/skills and
https://docs.devin.ai/desktop/cascade/agents-md; OpenCode
https://opencode.ai/docs/skills/; Zed https://zed.dev/docs/ai/skills; the
last row https://agents.md. What the documentation does not say, the kit
does not rely on: a skills folder for Cursor and Amp altogether are left
out until their pages say so. Claude Code's skills disable model invocation;
Codex's policy disables implicit invocation. On other hosts, invoke these
workflows explicitly; the kit does not claim equivalent host enforcement.

In the skills, `$ARGUMENTS` stands for what the person typed after the
command. Claude Code substitutes it; the Copilot and Gemini CLI files of
3.7 and 3.9 hand it over themselves; on any other host, read it as "the
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
disable-model-invocation: true
description: >-
  Start a new project by conversation, from what it is to how it is
  delivered. Ends by writing docs/00 to 06, docs/adr/ and AGENTS.md.
  Writes no code.
metadata:
  version: "2026.10.08"
---
You are the thinking partner of someone starting a product. The outcome is
the set of documents `references/documents.md` describes, which every later
session reads before acting. Read that file first, whole. When the root
holds `context/`, read it whole too, before talking: it is what people
already said, and a question it answers is not asked.

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
   language, style, where tests live; commit format lives in docs/05 §6.
5. **The process slots** (docs/05): verify command, environments, how a
   screen is proven, publish policy, whether `context/` is committed. What
   does not exist yet is written as
   "created by the first delivery".
6. **The first milestone** (docs/06): three to eight deliveries, one line
   each, in order, then its review. The first ones are the skeleton the
   others stand on.

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
template; `CLAUDE.md` holding the line `@AGENTS.md` and nothing else yet;
and the folder `work/done/` with a `.gitkeep`, so it survives a clone. The numbers of the
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
disable-model-invocation: true
description: >-
  Document an existing repository. Reads the code, writes docs/00 to 06,
  docs/adr/ and AGENTS.md describing what is there, and asks only what the
  code cannot answer. Writes no code.
metadata:
  version: "2026.10.08"
---
You are documenting a repository so that every later session can act on it
without rereading it. Read `references/documents.md` first, whole: it says
what each document holds.

## Read

`context/`, whole, when it exists: what people said that the code cannot.
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
* whether `context/` is committed. Default: committed when the repository
  stays with the team, in `.gitignore` when it is delivered or public;
* the first milestone: three to eight deliveries, or where to read them
  from (issues, a TODO file, a roadmap), then its review.

Everything else you decide from the code and mark as observed. Where the
code contradicts itself, the document records an open question; the person
is not asked to settle it now.

## Write

In the documentation language: docs/00 to 06 describing what exists, not
what should exist; docs/adr/ with the decisions the code already embodies
and the ones this round took, one dated paragraph each; `AGENTS.md` from the
template; `CLAUDE.md` holding the line `@AGENTS.md`; and the folder
`work/done/`. The rules live in `AGENTS.md`: what an existing `CLAUDE.md`,
`.github/copilot-instructions.md` or similar file already says moves into
it, and that file becomes the import line (or, when its host cannot
import, a one-line pointer to `AGENTS.md`), keeping below it only what
applies to that host alone. Show the diff before writing.
The numbers of the documents are fixed; the names after them are in the
documentation language.

Show the queue and stop. The next step is `/propose <slug>` for its first
line, in a fresh session. Change no code.
````

### 3.3 `propose/SKILL.md`

````markdown
---
name: propose
disable-model-invocation: true
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>
metadata:
  version: "2026.10.08"
---
You are the stakeholder's thinking partner. The slug is `$ARGUMENTS`; when
there is none, ask for it.

Read docs/00 (product), docs/03 (domain), docs/01 (architecture), docs/05
(process) and docs/06 (queue), and the deliveries in flight in `work/`.
Follow docs/05 §§2, 4 and 5 to start or resume the definition in the right
branch or worktree and mark the queue `[~]`. Do not start a blocked line
until its recorded reason is resolved.

Talk until the scope fits one page. When documents leave more than one
reading, give your assessment and ask, recommendation first. If it does
not fit one page, propose a split and write only the first delivery.

Write `work/<slug>.md` as docs/05 §3 defines, using docs/03's terms; add a
new concept there first. Draft the Behaviour scenarios yourself from the
documents, failures and edges included; the person corrects them and does
not write them. Mark `[>]` only when the definition is complete.
If an answer or a dependency is missing, save the draft and block it as
docs/05 §4 says, with `resume: propose`.

Files in docs/05's documentation language; talk in the person's language.
Write no code, migration, test or configuration. End by asking the person
to read and question the page as docs/05 §3 says, request corrections in
this conversation, then run `/apply <slug>` in a fresh session.

````

### 3.4 `apply/SKILL.md`

````markdown
---
name: apply
disable-model-invocation: true
description: >-
  Implement work/<slug>.md end to end: code, tests, verify, proof, docs,
  then stage and suggest the commit. Never commits.
argument-hint: <slug>
metadata:
  version: "2026.10.08"
---
Implement `work/$ARGUMENTS.md` in this session, completely. When the slug
is missing, ask for it. The page is the scope; do not widen it.

Read the page, `AGENTS.md`, docs/01 (architecture), docs/04 (conventions),
docs/05 (process) and docs/06 (queue). Follow docs/05's project slots
literally: verify, environments, proof, publish policy and git strategy.
Before editing, record the working tree and index as docs/05 §6 says.
Work on the branch or worktree /propose created, if any.

If the page contradicts a document, stop and say which: the document changes
in this delivery or the page is wrong. Do not resolve it silently. Follow
docs/05 §4 to resume a blocked line; refuse an incomplete proposal and
point to /propose. Only a fully defined `[>]` line becomes `[*]`.

When work cannot go on, record what was built and what it waits on, leave
the page in `work/` and block it with `resume: apply` as docs/05 §4 says.
A prerequisite fix becomes a `[ ]` line above this one. End the page with
the partial message and follow docs/05 §6's blocked-work staging rule;
report verify and environments, and stop without claiming completion.

Build where docs/01 says, with its error convention. Write docs/04's tests.
Abstraction on the second concrete occurrence; the page names the first.
Add no dependency, layer or tool the page did not name. No em dash in any
text a user reads.

Run verify until green. Prove the delivery as docs/05 says; list divergences
and fix them until only what you can justify remains. Leave environments
as required. Record divergences, omissions, proof and decisions on the
page; update their owning documents and ADRs. Tick every Done when item,
move the page to `work/done/` and mark `[x]`. Resolve dependent queue lines
by docs/05 §4, preserving their definition or implementation phase.

End the page with one final `commit` block in docs/05 §6's format, replacing
any earlier suggestion.
Stage only this delivery's changes as that section says and suggest the
same message. Never commit or merge. Files and message in the documentation
language; talk in the person's language. End by reporting which environment
is at which version and the command that updates the others.

````

### 3.5 `brainstorm/references/documents.md` and `analyze/references/documents.md`

The same content at both paths.

````markdown
# The documents

Seven numbered documents, a folder of decisions, a rules file and a work
folder, written from a context folder. The numbers are fixed, because the four commands cite them; the
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
Where tests live and what is tested at each level. A pointer to docs/05 §6
for the commit message format; do not copy that format here.

**docs/05, the process.** The template below, with its slots filled.

**docs/06, the queue.** Milestones, each with a paragraph saying what is
true when it closes, and under it one line per delivery, in order, then
its review (docs/05 §8):

```
[ ] <slug>    <what it delivers, one line>
```

`[ ]` not yet defined · `[~]` being defined · `[>]` completely defined,
`work/<slug>.md` ready for /apply · `[*]` being built · `[x]` done, page in
`work/done/` · `[?]` waiting, with `· resume: propose` or `· resume: apply`
before `· blocked: <reason>` or `· blocked: after <slug>, <slug>` at the
end of the line (docs/05 §4). A line never
leaves; it changes mark, at the moment the work changes (docs/05 §4). The
queue is edited by conversation in any session; no command owns it.

**docs/adr/.** One file per decision, `ADR-NNNN-<slug>.md`: context, the
decision, the consequences, the date. An ADR is amended, never rewritten.

**AGENTS.md.** The template below. Read at the start of every session by
every host in the table of SETUP.md §1, on its own or through the pointer
the table names; Claude Code reads it through `CLAUDE.md`, which holds `@AGENTS.md`
and, below that line, only what applies to Claude Code alone: a tool name,
a command that exists only there. `AGENTS.md` itself names no host's tool,
so it reads the same in every one.

**work/.** One page per delivery in flight; `work/done/` holds the finished
ones. Created with a `.gitkeep` in `work/done/`, so the folder survives a
clone.

**context/.** What people said, as it arrived: the proposal, the client's
emails, the notes of a meeting, a brief. `context/` is what the agent reads
from; `docs/` is what it writes. Each item is a pair: the original, kept
byte for byte, and beside it `<original name>.md` (`proposal.pdf.md`)
holding what the original says, whole, in Markdown; a summary is not a
conversion. An item that arrives as text is the `.md` alone. Subfolders
are the project's. `/brainstorm` and `/analyze` read it whole; an item that
arrives later is read on the person's request, and what it changes goes
into the documents (a rule into docs/00, a term into docs/03, a line into
docs/06), so `/propose` reads the decision, not the message. Whether it is
committed is a slot of docs/05 §5; personal data and anything under a
confidentiality clause stay out of a committed folder, because git keeps a
removed file in its history.

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
not by layer, and a layer exists only when it pays its own way. FOCUS
is chapter 7 of the book One Page at a Time by J.C. Ködel
(https://jckodel.github.io/focus-kit-book/07-four-pieces/). Three answers:

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

**Git.** A strategy, not a silver bullet: pick the one that fits how the
project is worked. Three answers, and in every one a delivery's page and
build are one change that reverts in one step, because undoing a whole
delivery must be one step; the agent never commits and never merges:

* **trunk:** everything on the main branch, one delivery at a time. The
  page waits uncommitted in the working tree between `/propose` and
  `/apply`; page and build land in one commit, which the person makes
  after reviewing. Only for one person working
  alone: with two, their deliveries share one branch and one commit
  carries the other's half-done work. What Ninjobs did;
* **a branch per delivery:** `/propose` creates a branch named after the
  slug and writes the page there; `/apply` builds on it. The branch may
  carry several commits, the page first and the build after; the person
  merges it through a pull request in one merge, so reverting the delivery
  is one revert of that merge. For sequential work reviewed by pull
  request;
* **a worktree per delivery:** `/propose` creates a git worktree on a
  branch named after the slug and writes the page there; `/apply` runs in
  it; the branch reaches the main branch in one merge, as above. For
  parallel work: one branch does not touch
  another, so several agents build different deliveries at the same time.
  Before running two at once, decide which deliveries can run in parallel
  and which touch the same files, including docs/06 and other shared
  documents. Reconcile the queue by docs/05 §4 when their branches are
  integrated. Costs a directory per delivery.

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
Code changes only inside /apply: a change asked anywhere else, however
small, becomes a `[ ]` line in docs/06 and the answer stops there.

Before /propose changes the queue or the page, use §5's git strategy:
create the branch or worktree named after the slug, or reuse its existing
one on resumption. Add a missing queue line where it belongs and say so.
Start defining with `[~]`; start building only a completely defined `[>]`
page, with `[*]`. Follow §4 for blocked lines and §6 before changing code
or staging. Keep project slots and rules current before using them; report
a missing process rule rather than falling back to a retired instruction.

## 3. The page

    # <slug>

    **Objective.** One sentence: what the user can do afterwards.

    **Behaviour.** Verifiable scenarios in user language, each an action
    with concrete input and the result the user sees. Include the cases
    that must fail and the edges the documents imply. Each line becomes a
    test or a manual check.

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
dropped, what the proof found, the decisions taken. It ends with the commit
message /apply suggested, in a fenced block whose info string is `commit`.
There is one final block: a resumed /apply replaces the earlier suggestion.

A draft with unanswered scope questions is not ready for /apply, even
when its file exists. Before marking `[>]`, every section above is filled
or explicitly inapplicable and no scope decision remains open. Ask the
person to review the page: Behaviour is checkable, Contract exact, Out of
scope names what they assumed was included, and choices made on their
behalf are explicit. Corrections happen in the /propose conversation;
/apply starts in a fresh session afterwards.

## 4. The queue

docs/06: one line per delivery, in order, under milestones. The line never
leaves the queue; it changes mark, at the moment the work changes, so the
queue shows what is happening while it happens:

| Mark | Means | Set by |
|---|---|---|
| `[ ]` | not defined | the conversation that adds the line |
| `[~]` | being defined | /propose, when it starts |
| `[>]` | completely defined, page ready for /apply | /propose, when §3 is complete |
| `[*]` | being built | /apply, when it starts |
| `[x]` | done, page in `work/done/` | /apply, with verify green |
| `[?]` | waiting | any session, in the three cases below |

A line waits when the person says it is blocked, when it needs an answer
that was asked and not given, or when it needs another line done first,
such as a fix found in the middle of an /apply. The reason goes at the end
of the line, `· blocked: <reason>` or `· blocked: after <slug>, <slug>`.
Before that reason, record the phase to resume: `· resume: propose` for
`[ ]` or `[~]`, and `· resume: apply` for `[>]` or `[*]`. A draft saved
by /propose always uses `resume: propose` until §3 is complete.
Any mark before `[x]` can become `[?]`. The line leaves `[?]` when the
reason is resolved: the person says so, the session that records the
answer clears it, or /apply clears it when it marks `[x]` the last line of
an `after`. Remove both suffixes and return `resume: propose` to `[ ]`,
keeping any draft for /propose to finish; return `resume: apply` to `[>]`
only when its page still satisfies §3. Existence alone is insufficient.
If scope became undecided, return `[ ]` and say what /propose must settle.
For an old blocked line without `resume`, recover the phase from its page
and history; if completeness cannot be established, return `[ ]`.

In parallel work, each worktree's queue shows that branch's state, not a
global live view. Change only the current delivery's line, its new findings
and the dependent lines this session can resolve. When branches are
integrated, reconcile docs/06 by slug: retain every delivery and finding,
and each owning branch's latest state. Do not replace the whole file with
one side or downgrade a completed line using a stale copy. Check the page
at the expected path and keep a dependency blocked until its completed
changes are available in the branch that needs them. A conflicting state
or scope is reported for resolution, never guessed. Apply the same care
to shared domain terms and ADRs.

Each milestone is planned with its review as the last line (§8). Edited by
conversation in any session.

## 5. This project

* **Documentation language:** <language>. Identifiers in <language>.
* **Verify:** `<command>`, which runs <what>. Green before anything is
  declared done. <Or: created by the first delivery.>
* **Environments:** one line each: name, what runs there, what a delivery
  must leave up to date there, and the command that does it.
* **Proof of a screen:** <tool, viewports, reference>, or "no screens".
* **Publish policy:** when an environment beyond the local one is updated,
  and whether the agent asks first.
* **Context:** `context/` is committed | listed in `.gitignore`, and why
  (who reads the repository).
* **Git:** trunk | a branch per delivery | a worktree per delivery. A
  delivery's page and build are one change: one commit on trunk, one merge
  otherwise. The agent stages; it never commits or merges.

## 6. Commit

This section owns the commit format; docs/04 points here. Before editing,
inspect git status, the staged and unstaged diffs, and untracked files.
Record which changes already belong to this delivery (its /propose page
and queue changes, or a previous partial /apply) and which are unrelated;
do not assume an existing edit belongs to it because it shares a path.
Preserve unrelated edits and the pre-existing index entries. If ownership
cannot be established or changes overlap inseparably, stop and report the
affected paths before editing them or staging; do not reset or stash them.

Stage only this delivery's files or hunks, including the page move and its
documentation changes. Use explicit paths for files wholly owned by it,
and selective staging for mixed files; never `git add -A` or `git add .`.
Inspect the staged diff afterwards and report any unrelated entries that
were already staged, so the person knows a plain commit would include
them. Do not unstage those entries yourself. A commit must contain only
this delivery for the one-change promise to hold.

The agent suggests the message; the person commits after reviewing.
Imperative subject up to 72 characters, scope in parentheses
when it helps; body up to five one-line bullets, the highlights and not
the reasoning; last line points to the page's actual path, where the
reasoning lives: `work/done/<slug>.md` when done, `work/<slug>.md` when
blocked. A partial message says it is partial and names the blocker;
it must not imply verify passed or the delivery is done.

When blocked on trunk, keep the work uncommitted and do not add it to the
index; the `commit` block is a draft for the eventual whole delivery.
Resume with the same page and record the current verify result. If a
prerequisite must be implemented separately before resumption, move this
partial delivery to its own branch/worktree, preserving its edits and
index ownership, before starting the prerequisite; ask for help if safe
separation is not possible. Do not mix their commits on trunk.
On a delivery branch or worktree, partial changes may be staged and
suggested for the person to commit there. Keep the branch unmerged until
the delivery is complete, so one merge still contains the whole delivery.

## 7. What this process does not have

No formal spec, no spec delta, no change folder, no numbered tasks, no
gate before implementation, no review of a review, no specialized
subagent, no tool the deliveries did not ask for. When one of these is
proposed, the question is: which concrete error would it have caught? The
answer names an error that happened.

## 8. Closing a milestone

A milestone is planned with its review as its last line,
`<milestone>-review`, a delivery like the others: /propose writes its
page, /apply runs it. It takes the milestone's paragraph clause by clause
and writes, for each, which delivery answers it and how a person tests it.
It reviews no code and fixes nothing. The person tests each clause by
hand: a clause no delivery answers, or one that fails in the person's
hands, is a finding.

Each finding becomes a `[ ]` line in the same milestone, under the review
line, waiting for /propose. The milestone closes when those lines are
`[x]`. They get no second review: each one passes through its own page,
its proof and the person's commit, which is the review. A finding is
never a fix in the middle of the next milestone.
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
  to build. Code changes only inside /apply: a change asked outside it,
  however small, becomes a `[ ]` line in docs/06 and the answer stops
  there.
- No em dash in any text a user reads.
- The agent stages and suggests the commit message. It never commits.
- Stage only this delivery's changes as docs/05 §6 says; preserve unrelated
  edits and existing index entries.

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

### 3.6 `.agents/skills/<name>/agents/openai.yaml`

For Codex. Four files, one per skill, `<name>` replaced by `brainstorm`,
`analyze`, `propose` and `apply`, next to the `SKILL.md` of `.agents/skills/`
only. They stop a message that happens to contain the word "apply" from
building anything unasked.

````yaml
interface:
  display_name: "focus-kit: <name>"
  short_description: "focus-kit: the <name> command. Read SKILL.md."

policy:
  allow_implicit_invocation: false
````

### 3.7 `.github/prompts/<name>.prompt.md`

For GitHub Copilot. Four files, `<name>` replaced by `brainstorm`,
`analyze`, `propose` and `apply`, so the commands exist as slash commands
in the chat. For `brainstorm` and `analyze`, which take no slug:

````markdown
---
agent: 'agent'
---
Read `.agents/skills/<name>/SKILL.md` and follow it.
````

For `propose` and `apply`, which take a slug:

````markdown
---
agent: 'agent'
---
Read `.agents/skills/<name>/SKILL.md` and follow it. `$ARGUMENTS` is `${input:slug}`.
````

### 3.8 `.cursor/commands/<name>.md`

For Cursor. Four files, `<name>` replaced as in 3.7, so the commands exist
as slash commands in the agent chat. Each one is one line:

````markdown
Read `.agents/skills/<name>/SKILL.md` and follow it. `$ARGUMENTS` is the word typed after the command.
````

### 3.9 `.gemini/commands/<name>.toml`

For the Gemini CLI. Four files, `<name>` replaced as in 3.7, so the
commands exist as slash commands. Each one is two lines:

````toml
description = "focus-kit: the <name> command. Reads .agents/skills/<name>/SKILL.md."
prompt = "Read .agents/skills/<name>/SKILL.md and follow it. $ARGUMENTS is {{args}}."
````

### 3.10 `.agents/rules/focus-kit.md`

For Google Antigravity. One always-on pointer, holding no project rule
of its own; its required frontmatter keeps the pointer active:

````markdown
---
trigger: always_on
---
Read `AGENTS.md` at the repository root before acting: it holds this project's rules. The four commands of the process are the skills in `.agents/skills/`.
````

### 3.11 `GEMINI.md`

For the Gemini CLI, which reads `GEMINI.md` unless told otherwise. Use the
line below without the rule frontmatter of 3.10. If the file exists, remove
only exact occurrences of this pointer line and put one at the top;
preserve every other line in its original order. This also removes copies
left by older updates. A second run produces no further change.

````markdown
Read `AGENTS.md` at the repository root before acting: it holds this project's rules. The four commands of the process are the skills in `.agents/skills/`.
````

## 4. Check

Before reporting, confirm: eighteen files across `.claude/skills/`,
`.agents/skills/` and `.windsurf/skills/` (four `SKILL.md` and two
`references/documents.md` in each); four `agents/openai.yaml` under
`.agents/skills/`; four prompt files, four Cursor commands and four Gemini
commands; `.agents/rules/focus-kit.md` and `GEMINI.md`; no other file
changed; the string `$ARGUMENTS` still present in every `propose` and
`apply`; no slug input in the brainstorm or analyze Copilot prompts; all
four skills disable model invocation in Claude Code; the Antigravity
pointer has `trigger: always_on`; GEMINI.md has exactly one pointer line;
no em dash in anything you wrote. Check that any existing custom file was
preserved and every pending project migration from §1 was reported.
Then report the list, the installed version and the next command.
