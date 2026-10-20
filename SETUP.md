# focus-kit setup

This file is an instruction to a coding agent: Claude Code, Codex, GitHub
Copilot, or any other that reads markdown and can write files. Read it
whole, then do what section 1 says. A person reading it finds what the kit
is in section 2 and the whole of it in section 3.

Version: 2026.10.20.4

## 1. What to do

1. Before writing anything, inspect every destination in section 3. An
   existing file may be replaced only when it matches a file shipped by
   focus-kit, in this version or a prior version verified from the kit's
   source history (`git show <commit>:SETUP.md` in
   https://github.com/JCKodel/focus-kit) or, without that history at
   hand, by the person's word that the file was never edited. A familiar
   name or a `metadata.version` alone does not establish ownership. If a
   destination contains a custom command or an unrecognized edit, show
   the edit as a diff against the kit file it was made on, and the kit's
   own change since that file separately and in short, and stop before
   writing or removing any file, steps 4 and 5 still reported; the person decides how to
   preserve or replace it, and a rule the edit added to a command may
   become a slot of docs/05 §5, which the commands follow. `GEMINI.md` is the exception:
   preserve its project content as 3.12 says. Do not create a manifest to
   track ownership.
2. Write every file of section 3, byte for byte, at every path its
   heading names. Sections 3.1 to 3.6 name paths relative to a skills
   folder, and each of those files goes to both `.claude/skills/` and
   `.agents/skills/`; sections 3.7 to 3.12 name paths relative to the
   repository root. Do not reformat, summarize, translate or improve any
   of them; fill only the `<name>` placeholder of 3.7 to 3.10, using the
   two prompt templates of 3.8 for their respective commands. Write 3.6
   with LF line endings, whatever the machine's default.
3. Touch nothing else, with one exception: versions before 2026.10.17
   also wrote 3.1 to 3.5 under `.windsurf/skills/`, which no host needs
   now. Remove each kit file there, as step 1 establishes it, and the
   folders that leaves empty; report and leave any other file. Do not
   run `git init`, do not stage, do not commit.
4. When the project already has docs/ or AGENTS.md, compare its rules with
   the current templates and report every migration still needed, with
   the actual path, section and proposed wording in its documentation
   language. A divergence the project decided and recorded as decided,
   with a date or an ADR, is a project choice: report it as such, with
   what the kit says, not as a migration. Each item below is reported, never done, by
   the actual section of the project's document. Check, one document at
   a time:
   * docs/05's section numbers: the commands cite the template's (§4 the
     queue, §5 the slots, §6 commit, §8 closing a milestone) and read by
     number, so a docs/05 numbered otherwise migrates to them first,
     whatever an ADR says, and until then the report says where each
     cited number lands;
   * docs/05 §2: code only inside /apply; a change asked elsewhere ending
     as a line and a draft page; /propose in that session or a fresh one,
     /apply in a fresh one, a subagent being one; the person using a
     delivery before committing; the agent committing or merging only when asked;
   * docs/05 §3: why the Contract is exact; Behaviour scenarios with
     concrete input and failure cases; the page complete before `[>]`;
     the final `commit` block;
   * docs/05 §4: when each mark changes; resumption; order as priority,
     `after`, the `(PA)` token and a command typed with several slugs; a
     line no clause of the milestone needs going to the next one; two
     sessions in one working tree, shared queue and isolated staging; the
     four cases a line waits in; a line whose session ended and a dropped
     line; a conflict as a line both edited; a board's mark and the claim;
   * docs/05 §5, what each slot says: every slot present, Context,
     Manuals, Delivery review and Milestone review included; the Publish
     policy's last sentence; the Verify slot's slow tests; a Manuals slot
     naming the manual of running it, owed or written; a Delivery review
     that reads `git diff HEAD` and the branch's commits, not a bare `git
     diff`, and the files the delivery created; a Milestone review slot
     that names the host's command stays, and one missing or naming
     neither a command nor areas gets docs/01's modules proposed; a branch
     or worktree Git slot silent on /propose pushing the branch it
     creates; a worktree Git slot that names no folder, in a container
     whose hidden folder already holds `repo.git/`, gets that folder's
     name and its branches' prefix written in, so nothing moves, and one
     with no manual letting a session in `main/` edit the worktrees;
   * docs/05 §5, the shape of a slot: a procedure a person runs by hand
     written only inside a slot or another document becomes a manual in
     docs/manuals/, the slot keeping the command and pointing to it; a
     slot that narrates steps or output shrinks to what and the command;
     a rule the project added to a command's file becomes a slot the
     command follows;
   * docs/05 §6: the commit from an index holding one delivery, never by
     naming paths; the one index of a tree; what a revert does not undo,
     in the Git slot;
   * docs/05 §7: its exception for the reviews' agents;
   * docs/05 §8: the slow tests; the range from the previous review's
     commit, or the one the page names, to the commit the reading started
     at; who reads, as the slot says; the checker, what seen means and
     the paths read;
   * docs/04: the pointer to docs/05 §6 and its tests by level;
   * docs/06: a line that carries history, what happened beyond the one
     sentence of what it delivers, keeps the mark, the slug, that
     sentence and its suffixes, the rest moved to its page, or to a draft
     `work/<slug>.md` for a `[ ]` line, when the page does not already
     hold it; the report names those lines and rewrites one as the
     example;
   * AGENTS.md: the process rules, including the lines on committing, on
     a change asked outside /apply, on where things stand and what a page
     decided, and on docs/manuals/.
   Preserve project choices; do not edit these files during setup. Report
   the installed skill version apart from the pending process migrations;
   an updated skill does not mean an updated process.
5. Tell the person which files you wrote and what comes next, written as
   the table below says this host invokes it: on a repository with no
   code, `/brainstorm`; with code, `/analyze`; both in a fresh session.
   On an already documented project, report the pending migrations
   first, or say there are none, do not ask it to repeat /brainstorm or
   /analyze, and name the command docs/06's first free line wants,
   `/propose` for a `[ ]` line or `/apply` for a `[>]` one.

Running this file again replaces the files step 1 recognizes as the
kit's and nothing else. That is how the kit is updated. Everything the
four commands write afterwards (`docs/`, `work/`, `AGENTS.md`,
`CLAUDE.md`) belongs to the project and is never touched by this file.

Every host gets its files on every run, whichever host runs this file, so
the repository opens ready in any of them and switching hosts changes
nothing. The rules live in `AGENTS.md`, which every host below reads on its
own or through the pointer the table names. Skill folders overlap on
purpose: `.agents/skills/` is read by Codex, Copilot, Antigravity, Devin
Desktop, OpenCode and Zed; `.claude/skills/` by Claude Code, Copilot and
Devin Desktop. Copilot documents what it does with the same name in
both: `.agents/skills/` before `.claude/skills/`, first found wins, the
same file here.

| Host | Reads the rules from | Reads the commands from | Invoked as |
|---|---|---|---|
| Claude Code | `CLAUDE.md`, which imports `AGENTS.md`; it reads `AGENTS.md` alone only where no `CLAUDE.md` exists, from v2.1.277 | `.claude/skills/<name>/SKILL.md` | `/<name> <slug>` |
| Codex | `AGENTS.md` | `.agents/skills/<name>/SKILL.md` | `$<name> <slug>` |
| GitHub Copilot in VS Code | `AGENTS.md` | `.agents/skills/<name>/SKILL.md`, through `.github/prompts/<name>.prompt.md` | `/<name>` |
| GitHub Copilot CLI | `AGENTS.md`, merged with `CLAUDE.md` and `GEMINI.md` | `.agents/skills/<name>/SKILL.md` | `/<name>`; whether a slug typed after it reaches the command is not documented |
| Cursor | `AGENTS.md` | `.agents/skills/<name>/SKILL.md`, through `.cursor/commands/<name>.md` | `/<name>`; whether a slug typed after it reaches the command is not documented |
| Google Antigravity | `AGENTS.md` directly; `.agents/rules/focus-kit.md` is an always-on pointer | `.agents/skills/<name>/SKILL.md` | `/<name> <slug>` |
| Gemini CLI | `AGENTS.md`, through `GEMINI.md` | `.agents/skills/<name>/SKILL.md`, through `.gemini/commands/<name>.toml` | `/<name> <slug>` |
| Devin Desktop, formerly Windsurf | `AGENTS.md` | `.agents/skills/<name>/SKILL.md` | `/<name>`; whether a slug typed after it reaches the command is not documented |
| OpenCode, Zed | `AGENTS.md` | `.agents/skills/<name>/SKILL.md` | by asking for the skill |
| Jules, Junie, Warp, Kiro, Roo Code, Cline | `AGENTS.md` | none; ask in words for `.agents/skills/<name>/SKILL.md` | |

Each row was read off the vendor's documentation on 2026-09-21 and
checked again between 2026-10-07 and 2026-10-20, the Copilot CLI last. A host
enters this table only with its documentation in hand: Claude Code
https://code.claude.com/docs/en/memory and https://code.claude.com/docs/en/skills;
Codex https://learn.chatgpt.com/docs/build-skills and
https://learn.chatgpt.com/docs/agent-configuration/agents-md; Copilot
https://docs.github.com/en/copilot/concepts/agents/about-agent-skills,
https://docs.github.com/en/copilot/reference/cli-command-reference and
https://docs.github.com/en/copilot/tutorials/customization-library/prompt-files/your-first-prompt-file;
Cursor https://cursor.com/docs/rules and
https://cursor.com/docs/cli/reference/slash-commands; Antigravity
https://antigravity.google/docs/rules and
https://antigravity.google/docs/skills/; Gemini CLI
https://geminicli.com/docs/cli/gemini-md/ and
https://geminicli.com/docs/cli/custom-commands/; Devin Desktop
https://docs.devin.ai/cli/extensibility/skills/overview and
https://docs.devin.ai/cli/extensibility/rules; OpenCode
https://opencode.ai/docs/skills/; Zed https://zed.dev/docs/ai/skills; the
last row https://agents.md. What the documentation does not say, the kit
does not rely on: Cursor's skills folder and Amp are left out until their
pages say so. Claude Code's and the Copilot CLI's skills and Codex's
policy disable model invocation: the agent runs one only when the person
names it. On other hosts, invoke them explicitly; the kit claims no
enforcement there.

In the skills, `$ARGUMENTS` stands for what the person typed after the
command. Claude Code substitutes it; the Copilot and Gemini CLI files of
3.8 and 3.10 hand it over themselves; on any other host, read it as "the
words after the command" and leave the token as it is.

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
a person uses it, reviews and commits
```

The rules the four commands keep, in every project:

* one delivery is one page. If it does not fit one page, it is two;
* deciding and doing are separate sessions. `/propose` writes no code;
  `/apply` widens no scope and starts in a fresh session;
* the agent stages and suggests the commit message. It never commits or
  merges on its own; asked, it takes the step the person names;
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
  version: "2026.10.20.4"
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
5. **The process slots** (docs/05): verify command and the slow tests kept
   out of it, environments, how a screen is proven, publish policy,
   whether `context/` is committed, the manuals (running it is owed by
   the first delivery after which a person can; the rest "none yet"), and
   whether a second pair of eyes reads each delivery before it ends and
   the whole milestone at its close (the default is yes: the host's own
   review where it has one, else a read-only agent, and the kit's readers
   over docs/01's modules, on the session's model). What does not exist
   yet is written as "created by the first delivery".
6. **The first milestone** (docs/06): three to eight deliveries, one line
   each, in order, with the `(PA)` token of docs/05 §4 when lines will
   run at the same time, then its review. The first ones are the
   skeleton the others stand on.

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
line; write it as this host invokes commands, which may not be `/`. Write
no code, no configuration and no dependency
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
  version: "2026.10.20.4"
---
You are documenting a repository so that every later session can act on it
without rereading it. Read `references/documents.md` first, whole: it says
what each document holds.

## Read

`context/`, whole, when it exists: what people said that the code cannot.
The README and any existing docs; the manifests (package.json, pyproject,
go.mod, *.csproj, pubspec.yaml, Cargo.toml, Gemfile, and the like); the
folder tree two levels deep; the entry points; the tests and how they run;
CI, and any Makefile or script a person runs by hand; the last fifty commit subjects; any agent rules file already there
(CLAUDE.md, AGENTS.md, .github/copilot-instructions.md, .cursorrules).

From that, infer the stack, how the code is organized, where business rules
live, how errors travel, what the verify command is, which tests are slow
enough to leave out of it, and which environments exist. What the code
says, you do not ask.

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
* the reviews: whether a second pair of eyes reads each delivery before
  it ends and the whole milestone at its close (docs/05 §5). Default:
  yes; the host's own review when it can be limited to a delivery's
  paths, else a read-only agent; and the kit's readers over docs/01's
  modules on the session's model, or the host's deep review when the
  project already launches one;
* the first milestone: three to eight deliveries, or where to read them
  from (issues, a TODO file, a roadmap), then its review.

Everything else you decide from the code and mark as observed. Where the
code contradicts itself, the document records an open question; the person
is not asked to settle it now.

## Write

In the documentation language: docs/00 to 06 describing what exists, not
what should exist; docs/adr/ with the decisions the code already embodies
and the ones this round took, one dated paragraph each; docs/manuals/,
running it first, then one per thing a person already does by hand (a
Makefile target, a deploy script, steps in a README), as docs/05 §5 says;
`AGENTS.md` from the template; `CLAUDE.md` holding `@AGENTS.md`; and the folder
`work/done/` with a `.gitkeep`. The rules live in `AGENTS.md`: what an
existing `CLAUDE.md`, `.github/copilot-instructions.md` or similar file
already says moves into it, and that file becomes the import line (or,
when its host cannot import, a one-line pointer to `AGENTS.md`), keeping
below it only what applies to that host alone. Show the diff before writing.
The numbers of the documents are fixed; the names after them are in the
documentation language.

Show the queue and stop. The next step is `/propose <slug>` for its first
line; write it as this host invokes commands, which may not be `/`. Change
no code.
````

### 3.3 `propose/SKILL.md`

````markdown
---
name: propose
disable-model-invocation: true
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>...
allowed-tools: Bash(git:*)
metadata:
  version: "2026.10.20.4"
---
You are the stakeholder's thinking partner. The slugs are `$ARGUMENTS`:
none, ask for one; several, one subagent per slug, opened at once where
docs/05 §4 allows, each taking its slug from the message that opens it and
running on the word of the person who typed the command, which names them all.

Read docs/00 (product), docs/03 (domain), docs/01 (architecture), docs/05
(process) and docs/06 (queue), and the deliveries in flight in `work/`. Do
not start a blocked line until its recorded reason is resolved, nor a line
docs/05 §4 says waits, by its token or its `after`; a `[~]` line is
resumed only on the person's word that its session ended. Otherwise claim
the line as docs/05 §2 says: run
`git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk <slug> <strategy>`,
the strategy being what docs/05 §5's Git slot says, `trunk`, `branch` or
`worktree <hidden> <prefix>`. Continue at the path it prints; your first
edit there marks it `[~]`. If git cannot find `sh`, Git for Windows was
installed without its shell: say so and stop.
Follow every slot of docs/05 §5 that names this command, the project's own
included. Another line changing mark meanwhile is another session's work.

What the documents answer, you do not ask: decide, write it on the page
and name the document, so the person corrects it in the review instead of
answering twice. Talk until the scope fits one page; where documents leave
more than one reading, give your assessment and ask, recommendation first;
if it does not fit one page, propose a split and write only the first.

Write `work/<slug>.md` as docs/05 §3 defines, using docs/03's terms; add a
new concept there first. Draft the Behaviour scenarios yourself from the
documents, failures and edges included; the person corrects them and does
not write them. Mark `[>]` only when the definition is complete.
If an answer or a dependency is missing, save the draft and block it as
docs/05 §4 says, with `resume: propose`.

Files in docs/05's documentation language; talk in the person's language.
Write no code, migration, test or configuration. End by showing the
page's queue line and asking the person to read and question the page as
docs/05 §3 says, request corrections in this conversation, then run
`/apply <slug>` in a fresh session, written as this host invokes commands,
opened in the delivery's worktree, if any, its path written out.
````

### 3.4 `apply/SKILL.md`

````markdown
---
name: apply
disable-model-invocation: true
description: >-
  Implement work/<slug>.md end to end: code, tests, verify, proof, docs,
  then stage and suggest the commit. Never commits on its own.
argument-hint: <slug>...
metadata:
  version: "2026.10.20.4"
---
The slugs are `$ARGUMENTS`: none, ask for one; several, one subagent per
slug, opened at once where docs/05 §4 allows, each taking its slug from
the message that opens it and running on the word of the person who typed
the command, which names them all. Implement `work/<slug>.md` in this
session, completely; the page is the scope: do not widen it.

Read the page, `AGENTS.md`, docs/00 (product), docs/01 (architecture),
docs/03 (domain), docs/04 (conventions), docs/05 (process) and docs/06
(queue). Follow every slot of docs/05 §5 literally, the project's own
slots included. Before editing, inspect the working tree and index as
docs/05 §6 says. Work on the branch /propose created, if any; with a
worktree, only in a session opened in it or a subagent sent to its path,
every file and command at that path: elsewhere, stop before any edit and
give the path.

If the page contradicts a document, stop and say which: the document changes
in this delivery or the page is wrong. Do not resolve it silently. Follow
docs/05 §4 to resume a blocked line, or a `[*]` line the person says its
session left; refuse an incomplete proposal and point to /propose. Otherwise
only a fully defined `[>]` line that §4's token and `after` let build
becomes `[*]`, your first edit. docs/05 §§4 and 6 say what a conflict is.

When work cannot go on, record what was built and what it waits on, leave
the page in `work/` and block it with `resume: apply` as docs/05 §4 says.
A prerequisite fix becomes a `[ ]` line above this one. End the page with
the partial message, show it in the conversation in the same `commit`
block, and follow docs/05 §6's blocked-work staging rule; report verify
and environments, and stop without claiming completion.

Build where docs/01 says, with its error convention and docs/03's
identifiers. Write docs/04's tests; one too slow for verify goes with
docs/05's slow tests and you say so, never into verify silently. Add no
dependency, layer or tool the page did not name.

Run verify until green. Prove the delivery as docs/05 says, fixing
divergences until only what you can justify remains. Update the documents
and ADRs the delivery changes, and the manual of anything it adds or changes
that a person does by hand (docs/05 §5). Then have this delivery's changes,
by its paths and no other delivery's, reviewed as docs/05 §5's Delivery
review says by a context that did not write them. Fix what breaks the page,
docs/04 or the text this delivery wrote and run verify again; anything else
becomes a `[ ]` line. A later edit to anything verify covers runs it once
more. Leave environments as required. Record divergences, omissions, proof,
the review and decisions on the page; tick every Done when item, move the
page to `work/done/` and resolve dependent lines as docs/05 §4 says.

End the page with one final `commit` block in docs/05 §6's format, replacing
any earlier one; stage only this delivery's changes as that section says;
show the same message in the conversation in a `commit` block. Your last
edit marks the line `[x]` and stages that hunk. Never commit or merge unless
the person asks. Files and message in the documentation language; talk in
the person's language. Give the person's next steps, each command written
as this host invokes commands: use what the delivery changed, as its user
would, and ask here for what is wrong; review the staged diff; commit with
the suggested message, merging a delivery branch as docs/05 §5 says; then
the queue's next line and its command. End saying which environment is at
which version and the command that updates the others; never end silent.
````

### 3.5 `brainstorm/references/documents.md` and `analyze/references/documents.md`

The same content at both paths.

````markdown
# The documents

Seven numbered documents, a folder of decisions, a folder of manuals, a
rules file and a work folder, written from a context folder. The numbers are fixed, because the four commands cite them; the
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
Where tests live and what is tested at each level: business rules
tested in process, the fastest tests there are; end-to-end
tests, and any that need the running application or a network, only
where they prove what the fast ones cannot. A pointer to docs/05 §6
for the commit message format; do not copy that format here.

**docs/05, the process.** The template below, with its slots filled.

**docs/06, the queue.** Milestones, each with a paragraph saying what is
true when it closes, and under it one line per delivery, in order, then
its review (docs/05 §8):

```
[ ] <slug>    <what it delivers, one line>
```

A line holds the mark, the slug, a token, one sentence and its suffixes;
what happened goes on the page. The marks, the token, the suffixes
(`· after`, `· resume:`, `· blocked:`, `· dropped:`), the order as
priority, the next milestone and what may run at the same time are
docs/05 §4, written once there. What is not in the current milestone is
not planned yet.

**docs/adr/.** One file per decision, `ADR-NNNN-<slug>.md`: context, the
decision, the consequences, the date. An ADR is amended, never rewritten.

**docs/manuals/.** One file per action that takes more than one command,
so it is found by its name and not inside a slot: running the product from
a fresh clone, what a person does by hand outside a delivery (publish, roll
back, set up a service), and a proof /apply runs on another machine.
docs/05 §5 says what each one holds. Created with the first one; there is no empty folder.

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
is chapter 4 of the book One Page at a Time by J.C. Ködel
(https://jckodel.github.io/focus-kit-book/04-focus/). Three answers:

* **FOCUS whole:** the four pieces, exceptions as values, vertical slices.
  docs/01 gets the responsibility table below and names the pieces a slice
  has in this stack. Ninjobs chose this;
* **the two principles only:** vertical slices and exceptions as values,
  with whatever structure the stack favors;
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
delivery must be one step. That step undoes what git holds; a migration
run or a message sent is not undone by it, so a page whose delivery acts
outside git says in Done when how that is undone, naming its manual, or
that it is not. The agent never commits or merges on its own:

* **trunk:** everything on the main branch. The
  page waits uncommitted in the working tree between `/propose` and
  `/apply`; page and build land in one commit, which the person makes
  after reviewing. What Ninjobs did, one session at a time. For one
  person, alone or with several sessions open
  on free lines that touch different files: each session stages only its
  delivery, and the person commits one delivery at a time, from an index
  that holds only it (docs/05 §6). Not for two people: their deliveries share one
  branch and one commit carries the other's half-done work;
* **a branch per delivery:** `/propose` creates a branch named after the
  slug, pushes it, and writes the page there; `/apply` builds on it. The
  branch may carry several commits, the page first and the build after;
  the person merges it through a pull request in one merge, so reverting
  the delivery is one revert of that merge. For sequential work reviewed
  by pull request;
* **a worktree per delivery:** the checkout is the `main/` of a container
  folder, which keeps the bare repository in a hidden folder of it
  (`<hidden>/repo.git/`) and each delivery's worktree in
  `<hidden>/worktrees/<slug>/`, on the branch `<prefix>/<slug>`; docs/05's
  Git slot names the hidden folder and the prefix, and a slot that names
  neither means `.focus-kit/` and `focus-kit/`. `/propose` claims the
  line with its `claim.sh`, which checks the remote for the branch,
  creates the slug's worktree there from the main branch's HEAD and
  pushes its branch at once, so the line is taken in every clone, or
  reuses the one that exists, and prints the path; the page is written
  in it. A branch `<slug>` without the prefix is not the delivery's. `/apply` runs
  in a session opened in it, or a subagent sent to its path, never in
  `main/`; the container's manual lets a session in `main/` edit
  `<hidden>/worktrees/`. The branch reaches the
  main branch in one merge, as above. For parallel work by several people,
  or by one person whose deliveries touch the same files: one branch does
  not touch another. Before running two at once, pick free lines
  (docs/06's `after`) and decide which touch the same files, including
  docs/06 and other shared documents. Reconcile the queue by docs/05 §4
  when their branches are integrated. Costs a directory per delivery.

## The process document (docs/05)

Write it whole, in the documentation language, with the slots of §5
filled. Keep the section numbers: the commands cite them.

```markdown
# Process

How an idea becomes code in <project>.

## 1. The rule

One delivery is one page, `work/<slug>.md`. If it does not fit one page,
it is two deliveries. The page is not a concision goal: it is the test that
the scope was understood.

## 2. The flow

docs/06 → /propose <slug> → work/<slug>.md → /apply <slug>, in a fresh
session → verify green, environments as §5 says → work/done/<slug>.md and
git add → a person uses it, reviews and commits.

/propose talks and writes the page, never code. /apply builds, proves,
updates the documents, stages and suggests the commit, never commits on
its own. Code changes only inside /apply: a change asked anywhere else,
however small, becomes a `[ ]` line in docs/06; what was said that the
line cannot hold goes into a draft `work/<slug>.md`. The answer stops
there and names `/propose <slug>`, as this host invokes commands; the
person runs it in this session, whose conversation the draft already
holds, or in a fresh one. /apply always starts in a fresh session, a
subagent being one: it has only what the page says.

Before /propose changes the queue or the page, use §5's git strategy:
create the branch or worktree named after the slug, push its branch, or
reuse its existing one on resumption, bringing into it any draft left
for the slug. Add a missing queue line where it belongs and say so.
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
    section that must be exact: a wrong screen is fixed in a session, a
    wrong column is a migration, and a wrong access rule has already
    leaked.

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

A draft with open scope questions is not ready for /apply, even when its
file exists: before `[>]`, every section above is filled or explicitly
inapplicable and no scope decision remains open. Ask the person to review
the page: Behaviour checkable, Contract exact, Out of scope naming what
they assumed was included, choices made on their behalf explicit.
Corrections happen in the /propose conversation; /apply starts in a
fresh session afterwards.

## 4. The queue

docs/06: one line per delivery, in order, under milestones, edited by
conversation in any session. The order is the priority: the next
delivery is the first free line, and the person reorders by
conversation. A line is the mark, the slug, one sentence and its
suffixes; what happened goes on the page, because /propose reads the
whole queue. A line that needs another done first ends with
`· after <slug>`, written when the line is added; it is free when every
line it names is `[x]`. A line that no clause of the current milestone's
paragraph needs, whoever adds it, goes under the next milestone, created
when missing with a paragraph that line answers and its review last; a
finding of the milestone's own review stays in it (§8). A line may carry
`(PA)` after the slug: whether its /propose and its /apply may run while
the lines above it are in flight. `P`: the definition takes nothing from
their pages; `A`: the build touches none of their files; `-` waits, for
every line above to be `[>]` or beyond before /propose, `[x]` before
/apply; `after` holds for both commands, with or without a token.
Whoever changes the queue re-judges the tokens it affects; /propose
corrects a token from the page. Asked what can run at the same time,
answer from the queue: the free lines, by their tokens where they have
one, else the ones that touch different files, judged from their pages
and docs/01. The line never leaves the queue; it changes mark as the
work changes, so the queue shows what is happening while it happens:

| Mark | Means | Set by |
|---|---|---|
| `[ ]` | not defined | the conversation that adds the line |
| `[~]` | being defined | /propose, when it starts |
| `[>]` | completely defined, page ready for /apply | /propose, when §3 is complete |
| `[*]` | being built | /apply, when it starts |
| `[x]` | done, page in `work/done/`; with `· dropped:`, cancelled | /apply, with verify green; the person, when cancelling |
| `[?]` | waiting | any session, in the four cases below |

A board may read the queue, and people pull work from it, so a mark
changes at once: `[~]` is /propose's first edit, `[*]` is /apply's first,
`[x]` is /apply's last. On trunk the board sees it at once. With a branch
or a worktree per delivery the mark lives on the delivery's branch, pushed
when /propose creates it, and the main branch shows the line as it was
until the merge. After `git fetch`, a line whose branch exists is taken,
whatever main shows. Whoever reads the queue there, a board or a session
picking free lines or resolving an `after`, takes each slug's line from
that branch, local or remote, and the lines only a branch has, reconciled
by slug as below.

A line waits when the person says it is blocked, when it needs an answer
that was asked and not given, or when work already started finds it needs
another line done first, such as a fix found in the middle of an /apply,
or when a milestone review's code reading missed part of its range (§8).
The line ends with the command that picks it up, `· resume: propose` or
`· resume: apply`, then the reason, `· blocked: <reason>` or
`· blocked: after <slug>, <slug>`. A dependency known when the line is
added is `· after <slug>` alone, without `[?]`: an order, not an
interruption. When the reason is resolved (the person says so, the
session that records the answer clears it, or /apply marks `[x]` the last
line of an `after`), remove both suffixes: `resume: propose` returns to
`[ ]`, keeping any draft, and `resume: apply` to `[>]`.

A `[~]` or `[*]` line whose session ended without blocking it (the host
closed, the connection or its limit) keeps its mark; its command resumes
it on the person's word, inspecting the page, the tree and the index
before editing. A delivery the person cancels, because it is impossible,
refused or no longer wanted, ends `[x]` with `· dropped: <reason>` at the
end of the line, its page in `work/done/` saying what was built and
undone; a line whose `after` names it is the person's to re-decide.

Two sessions in one working tree, on free lines that touch different
files, are the normal case of parallel work on trunk. Another line
changing mark, another delivery's page or files in the tree and another
session's index entries are that session's work, not a conflict: do not
stop for them or touch them; change only this delivery's line and stage
only its paths and hunks, its own hunk of docs/06 included. A conflict is
a line edited by both, or a file this page needs that the other delivery
is changing; then stop and report. Two deliveries' edits in one hunk, each
on its own line, as neighbouring queue lines are, conflict in nothing: they
are split when staged. In worktrees, change only this delivery's line; when
branches are integrated, reconcile docs/06 by slug, keeping every line at
its latest state, never one side's whole file.

A command typed with several slugs opens one subagent per slug, each
following the command's file with one slug, sent to the slug's worktree
where §5's Git slot has one (/propose creates it). The subagents the
tokens and `after` let run at once are opened at once, not one after
another; a line still waiting when the others end is reported, not waited
for. The session edits nothing itself. A subagent cannot ask the person: it reports the question
with the context to answer it and stops; the session asks and sends the
answer back, resuming it where the host can, else opening it again on the
slug, whose `[~]` or `[*]` it resumes on the command's word. A command that
says to decide alone has each question answered by its recommendation,
written on the page as the agent's answer, so the review finds it; one
that says to build as well has a new subagent run /apply when a page
reaches `[>]`, the page saying it was built before the person read it,
who reads the pages and the diffs at the end.

## 5. This project

A slot says what and the command, in a few lines: /apply reads it every
time. Steps go in a manual, and what a command prints stays in its help.
The project may add slots of its own; a slot that names /propose or
/apply is followed by that command, with no edit to the skill.

* **Documentation language:** <language>. Identifiers in <language>.
* **Verify:** `<command>`, which runs <what>, fast enough to run on every
  delivery. Green before anything is declared done. <Or: created by the
  first delivery.> Slow tests: `<command>`, which runs <what>, run by the
  milestone review (§8); <or: none>.
* **Environments:** one line each: name, what runs there, what a delivery
  must leave up to date there, and the command that does it, or its
  manual when a person does it by hand.
* **Proof of a screen:** <tool, viewports, reference>, or "no screens".
* **Publish policy:** when an environment beyond the local one is updated,
  and whether the agent asks first. Whatever it is, /apply's last words
  say which environment is at which version.
* **Context:** `context/` is committed | listed in `.gitignore`, and why
  (who reads the repository).
* **Delivery review:** <how /apply has a delivery's changes reviewed by a
  context that did not write them: the host's own review, as a skill the
  agent invokes or a command it runs, and how it is limited to the
  delivery's paths; else a read-only agent on the session's model reading
  the whole delivery against its base: `git diff HEAD` of those paths,
  staged and unstaged, the commits a blocked delivery already made on its
  branch or worktree, and the files it created; or: none>.
* **Manuals:** `docs/manuals/`, one file per action that takes more than
  one command, named after what it does: running the product from a fresh
  clone, what a person does by hand outside a delivery (publish, roll
  back, rotate a secret, set up a service) and a proof /apply runs on
  another machine. Each stands alone for whoever runs it, having read
  nothing else: what it does and when, what must be in place, the commands
  in order, how to tell it worked, how to undo it, what breaks if a step
  is skipped. A slot that names such a command points to its manual
  instead of holding the steps; a delivery that changes one updates its
  manual. <One line each; running it is owed by the first delivery after
  which a person can run it, from install to the first screen or call.>
* **Milestone review:** <who reads the milestone's code in §8: the
  host's deep review the person launches over the range, named with its
  command, when the host has one that takes the whole range; or the
  kit's readers, with the areas a milestone's changes split into, one
  reader each, and the model its readers and checker run on, or the
  session's; or: none>.
* **Git:** trunk | a branch per delivery | a worktree per delivery. A
  delivery's page and build are one change: one commit on trunk, one merge
  otherwise. Reverting it undoes what git holds; a delivery that acts
  outside git (a migration run, a message sent) says in its Done when how
  that is undone, or that it is not. The agent stages; it never commits or
  merges on its own, and asked, it takes the step the person names. <Or:
  the agent commits, and merges, by this slot's word, which is the asking;
  the person reviews the commit.> <A branch or worktree per delivery:
  /propose pushes the branch it creates, the remote checked for one
  first, so the line is taken in every clone; a worktree: the hidden
  folder of the container, `.focus-kit/`, the branch prefix, `focus-kit/`.>

## 6. Commit

This section owns the commit format; docs/04 points here. Before editing,
inspect git status, the diffs and untracked files. What this delivery did
not change (another session's page, files and hunk of docs/06, anyone's
edit) is not its own: preserve it and the existing index entries. When a
change this delivery must edit is not clearly its own, stop and report
the paths; do not reset or stash them.

Stage only this delivery's files or hunks, including the page move and its
documentation changes. Use explicit paths for files wholly owned by it,
and selective staging for mixed files; never `git add -A` or `git add .`.
Inspect the staged diff afterwards and report any unrelated entries
already staged, which a plain commit would include; do not unstage them.
A commit must contain only this delivery for the one-change promise to
hold: with two sessions on trunk, the person commits each delivery as its
session ends, from an index that holds only it, never by naming paths on
`git commit`, which takes each named file whole from the working tree and
carries the other session's hunk of it, staged or not. One working tree
has one index, so when the second session has already staged, the person
sets its paths aside with `git restore --staged <paths>`, commits the
first, and stages them again.

The message: imperative subject up to 72 characters, scope in parentheses
when it helps; body up to five one-line bullets, the highlights and not
the reasoning; last line points to the page's actual path, where the
reasoning lives: `work/done/<slug>.md` when done, `work/<slug>.md` when
blocked. A partial message says it is partial and names the blocker;
it must not imply verify passed or the delivery is done.

When blocked on trunk, keep the work uncommitted and out of the index;
the `commit` block is a draft for the whole delivery. On a delivery
branch or worktree, partial changes may be staged for the person to
commit there, and the branch stays unmerged until the delivery is
complete, so one merge still holds the whole delivery.

## 7. What this process does not have

No formal spec, no spec delta, no change folder, no numbered tasks, no
gate before implementation beyond a complete page, no review of a review,
no subagent beyond a command's one per slug (§4) and the reviews' readers
and checker (§5, §8), no tool the deliveries did not ask for. When one is
proposed, the question is: which concrete error would it have caught? The
answer names an error that happened.

## 8. Closing a milestone

A milestone is planned with its review as its last line,
`<milestone>-review`, a delivery like the others: /propose writes its
page, /apply runs it. It takes the milestone's paragraph clause by clause
and writes, for each, which delivery answers it and how a person tests it.
It fixes nothing. It runs §5's slow tests, when the slot names them; a
failing one is a finding. The person tests each clause by hand: a clause
no delivery answers, or one that fails in the person's hands, is a finding.

The review also reads the code, the one look at the whole instead of a
delivery: every page can be right and the whole wrong. Its page names as
the base the commit of the previous milestone's review, so the range
holds the fixes of its findings, which get no second review, or the
first commit for a first milestone, or, where no earlier review exists,
the commit the page names and why; and the commit HEAD was when the
reading started, so the range stays fixed while readers work; and the
paths `git diff --stat <base>..<that commit>` shows: always the range,
since a bare commit reads that one commit. It costs, so the session says
it is time and starts it only on the person's word. §5's Milestone review
slot says who reads: the host's deep review, which the person launches
over that range, or the kit's readers, one read-only agent per area of
the slot, in parallel where the host runs agents, else one fresh session
per area, opened by the person; an area too large for one careful reading
splits again. Each reader has the whole repository open and reads its
area's changes for what no delivery's own review could see, one
delivery's work against another's, a document against another, the whole
against docs/01, and reports candidates by file and line and the paths it
read. Either way, one checker, an agent or the review's session, opens
each candidate's file and marks it seen (true in the file today), latent
(nothing triggers it today) or weak (the claim does not hold as stated)
before the person sees it. They fix nothing. When the paths read miss
some of the range's, the page says which and the line waits as `[?]` with
`· resume: apply` and `· blocked: <what was read>` (§4). A candidate the
person confirms is a finding like the others.

Each finding becomes a `[ ]` line in the same milestone, under the review
line, waiting for /propose; the milestone closes when they are `[x]`. They
get no second review: each passes through its own page, its proof and the
person's commit, which is the review; a finding is never a fix in the
middle of the next milestone.
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
- running it, and what a person does by hand (publish, roll back):
  docs/manuals/, when it exists

## Non-negotiables
- <three to six rules that protect what the product is; from docs/00 and
  docs/01, one line each>
- One delivery = one page in work/<slug>.md: /propose to define, /apply
  to build. Code changes only inside /apply: a change asked outside it,
  however small, becomes a `[ ]` line in docs/06, with a draft page for
  what the line cannot hold, and the answer stops there, naming /propose
  (docs/05 §2).
- No em dash in any text a user reads.
- The agent stages and suggests the commit message. It never commits or
  merges on its own; asked, it takes the step the person names.
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
- Asked where things stand, answer from docs/06 and work/, and with a
  branch or worktree per delivery from the delivery branches after
  `git fetch`: the lines in flight, their marks, and the next command,
  as this host invokes it.
  Asked what a delivery decided or why, answer from its page and the
  ADRs it names.
```
````

### 3.6 `propose/scripts/claim.sh`

The script `/propose` runs to claim a line, in both skills folders like
3.1 to 3.5, with LF line endings. It runs through git's own shell, which
Git for Windows installs with git, so the skill's one line works from
any shell on any host. It reads no document: the agent passes what
docs/05 §5's Git slot says.

````sh
#!/bin/sh
# focus-kit: claim a queue line as docs/05 says. Run it through git, so it
# starts at the repository's top level on every host and shell:
#   git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk <slug> <strategy>
# <strategy> is the Git slot of docs/05: trunk | branch | worktree <hidden> <prefix>
# Prints key: value lines; exit 0 claimed, 2 refused. Edits no document.
set -eu

die() { printf 'error: %s\n' "$1"; exit 2; }

slug=${1:-}; strategy=${2:-}
[ -n "$slug" ] && [ -n "$strategy" ] || die "usage: claim.sh <slug> trunk | branch | worktree <hidden> <prefix>"
case $slug in -*|*[!a-zA-Z0-9._-]*) die "slug '$slug' holds a character a branch name cannot" ;; esac

top=$(git rev-parse --show-toplevel 2>/dev/null) || die "not inside a repository"
head=$(git symbolic-ref --quiet --short HEAD) || die "HEAD is detached; claim from the default branch"

draft() {
  if [ -f "$top/work/$slug.md" ]; then
    printf 'draft: work/%s.md at %s; bring it into the delivery\n' "$slug" "$top"
  else
    printf 'draft: none\n'
  fi
}

if [ "$strategy" = trunk ]; then
  printf 'claim: none, trunk\nbranch: %s\npath: %s\n' "$head" "$top"
  draft
  exit 0
fi

case $strategy in
  worktree)
    hidden=${3:-}; prefix=${4:-}
    [ -n "$hidden" ] && [ -n "$prefix" ] || die "worktree needs the hidden folder and the branch prefix: worktree .focus-kit focus-kit/"
    hidden=${hidden%/}
    case $top in */"$hidden"/worktrees/*) die "run from main/, not from a worktree: $top" ;; esac
    case $head in "$prefix"*) die "run from main/; HEAD is $head, a delivery branch" ;; esac
    branch="$prefix$slug"
    ;;
  branch) branch=$slug ;;
  *) die "unknown strategy '$strategy': trunk, branch or worktree <hidden> <prefix>" ;;
esac

git remote get-url origin >/dev/null 2>&1 || die "no remote origin; the claim needs one, or the Git slot says trunk"
git fetch -q origin || die "git fetch origin failed"

default=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||') || true
[ -n "$default" ] || for b in main master; do
  if git show-ref --quiet "refs/remotes/origin/$b"; then default=$b; break; fi
done
[ -n "$default" ] || die "cannot tell the default branch; run git remote set-head origin -a"
[ "$head" = "$default" ] || die "on branch $head; claim from $default"

behind=$(git rev-list --count "$head..origin/$default" 2>/dev/null || echo 0)
[ "$behind" -eq 0 ] || printf 'note: %s is behind origin by %s; the delivery starts from the local HEAD\n' "$head" "$behind"

# ls-remote matches a pattern against the tail of a ref, so the full name is given.
if [ "$strategy" = worktree ] && git ls-remote --exit-code --heads origin "refs/heads/$slug" >/dev/null 2>&1; then
  printf "note: a branch %s without the prefix exists on origin; it is not the delivery's\\n" "$slug"
fi

if git ls-remote --exit-code --heads origin "refs/heads/$branch" >/dev/null 2>&1; then remote=1; else remote=0; fi
local=0; git show-ref --quiet "refs/heads/$branch" && local=1

if [ "$strategy" = worktree ]; then
  path="$(dirname "$top")/$hidden/worktrees/$slug"
  if [ -d "$path" ]; then
    if [ "$remote" -eq 1 ]; then claim="existing"
    else
      git -C "$path" push -q -u origin "$branch" || die "push of $branch failed; the line is not claimed"
      claim="existing, branch pushed now"
    fi
  elif [ "$remote" -eq 1 ]; then
    if [ "$local" -eq 1 ]; then git worktree add -q "$path" "$branch"
    else git worktree add -q --track -b "$branch" "$path" "origin/$branch"; fi
    claim="existing"
  else
    git worktree add -q -b "$branch" "$path" "$head"
    git -C "$path" push -q -u origin "$branch" || die "push of $branch failed; the line is not claimed"
    claim="new"
  fi
  path=$(git -C "$path" rev-parse --show-toplevel)
else
  if [ "$remote" -eq 1 ]; then
    if [ "$local" -eq 1 ]; then git switch -q "$branch"
    else git switch -q --track -c "$branch" "origin/$branch"; fi
    claim="existing"
  elif [ "$local" -eq 1 ]; then
    git switch -q "$branch"
    git push -q -u origin "$branch" || die "push of $branch failed; the line is not claimed"
    claim="existing, branch pushed now"
  else
    git switch -q -c "$branch"
    git push -q -u origin "$branch" || die "push of $branch failed; the line is not claimed"
    claim="new"
  fi
  path=$top
fi

printf 'claim: %s\nbranch: %s, on origin\npath: %s\n' "$claim" "$branch" "$path"
draft
````

### 3.7 `.agents/skills/<name>/agents/openai.yaml`

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

### 3.8 `.github/prompts/<name>.prompt.md`

For GitHub Copilot. Four files, `<name>` replaced by `brainstorm`,
`analyze`, `propose` and `apply`, so the commands exist as slash commands
in the chat. For `brainstorm` and `analyze`, which take no slug:

````markdown
---
agent: 'agent'
---
Read `.agents/skills/<name>/SKILL.md` and follow it.
````

For `propose` and `apply`, which take one slug or several in one input:

````markdown
---
agent: 'agent'
---
Read `.agents/skills/<name>/SKILL.md` and follow it. `$ARGUMENTS` is `${input:slug}`.
````

### 3.9 `.cursor/commands/<name>.md`

For Cursor. Four files, `<name>` replaced as in 3.8, so the commands exist
as slash commands in the agent chat. Each one is one line:

````markdown
Read `.agents/skills/<name>/SKILL.md` and follow it. `$ARGUMENTS` is the words typed after the command.
````

### 3.10 `.gemini/commands/<name>.toml`

For the Gemini CLI. Four files, `<name>` replaced as in 3.8, so the
commands exist as slash commands. Each one is two lines:

````toml
description = "focus-kit: the <name> command. Reads .agents/skills/<name>/SKILL.md."
prompt = "Read .agents/skills/<name>/SKILL.md and follow it. $ARGUMENTS is {{args}}."
````

### 3.11 `.agents/rules/focus-kit.md`

For Google Antigravity. One always-on pointer, holding no project rule
of its own; its required frontmatter keeps the pointer active:

````markdown
---
trigger: always_on
---
Read `AGENTS.md` at the repository root before acting: it holds this project's rules. The four commands of the process are the skills in `.agents/skills/`.
````

### 3.12 `GEMINI.md`

For the Gemini CLI, which reads `GEMINI.md` unless told otherwise. Use the
line below without the rule frontmatter of 3.11. If the file exists, remove
only exact occurrences of this pointer line and put one at the top;
preserve every other line in its original order. This also removes copies
left by older updates. A second run produces no further change.

````markdown
Read `AGENTS.md` at the repository root before acting: it holds this project's rules. The four commands of the process are the skills in `.agents/skills/`.
````

## 4. Check

Before reporting, confirm: fourteen files across `.claude/skills/` and
`.agents/skills/` (four `SKILL.md`, two `references/documents.md` and
`propose/scripts/claim.sh` in each, the script with LF line endings); no
kit file left under `.windsurf/skills/`; four `agents/openai.yaml` under
`.agents/skills/`; four prompt files, four Cursor commands and four Gemini
commands; `.agents/rules/focus-kit.md` and `GEMINI.md`; no other file
changed; the string `$ARGUMENTS` still present in every `propose` and
`apply`; no slug input in the brainstorm or analyze Copilot prompts; all
four skills disable model invocation in Claude Code; the Antigravity
pointer has `trigger: always_on`; GEMINI.md has exactly one pointer line;
no em dash in anything you wrote. Check that any existing custom file was
preserved and every pending project migration from §1 was reported.
Then report the list, the installed version and the next command.
