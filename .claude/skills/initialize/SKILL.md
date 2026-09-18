---
name: initialize
description: >-
  Set up the focus-kit process in this repository. Writes docs/00 to 06,
  docs/adr, CLAUDE.md and the work queue, in the documentation language the
  project chooses. On a greenfield project it asks; on a brownfield project
  it reads the code, builds the graphify graph and asks only what the code
  cannot answer.
---
<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are setting up the delivery process described in `docs/manuals/process.md`.
The architecture is not one of the things you bring: the four Practice
questions below ask it, one per practice, and the answers become
`docs/01-Architecture.md` §3. Read `docs/manuals/process.md` first, and
`docs/manuals/focus.md`, which is the reference behind the answer each of
those four questions offers first.
The templates for every document you will write are in
`.claude/skills/initialize/templates/`. Each template carries `<!-- init: ... -->`
comments that say what goes in each section; fill the section and remove
the comment. Never leave a template comment in a finished document.

## Language

Three languages live here and they are not the same thing. Keep them apart.

* **The documentation language** is what you write the prose in: `docs/00`
  to `06`, the ADRs, `CLAUDE.md`, `work/<slug>.md` and the commit messages
  you suggest. It is a per-project choice, asked in Step 0 and recorded in
  `CLAUDE.md` and `docs/04-Conventions.md` §1. The default is English.
* **Identifiers are always in English**, whatever the documentation
  language: types, methods, columns, migrations, file names, branches.
  `docs/03-Domain.md` is the table that translates each concept into its
  English code name once, so the translation is not renegotiated file by
  file.
* **The conversation** follows the language the person writes to you in,
  and has nothing to do with either of the two above.

When the documentation language is not English, translate the templates as
you fill them: headings, fixed prose, table columns, the lot. The finished
document reads as if it had been written in that language, with no seam.
Keep the template structure, the section order and the technical terms this
kit defines (FOCUS, use case, orchestrator, repository, slice, `/propose`,
`/apply`), keep every path and file name as it is, and keep one row of one
table: the header row `Practice | Answer | Here it is` of
`docs/01-Architecture.md` §3 stays in English whatever the documentation
language, because it is what a review run looks for to know the four
Practice questions were already answered (Step 0). The rest of that table
translates like the rest of the document: the four Practice names, the
answers and the third column.

Six texts of this file are conversation and not document, and they reach
the person in the conversation's language: the Language question (Step 0),
the four Practice questions and the Proof tool question (Step 1 brownfield,
reused by rounds 4 and 5 of Step 1 greenfield), the Git strategy question
(Step 1 brownfield, reused by round 6 of Step 1 greenfield), the
two-patterns disclaimer and the No screen question. Each of the six carries
the phrase
`written here once and said entire, in the conversation's language`,
and the rule covers all six. That phrase binds the content and not the
bytes: every statement, every option and their order reach the person in the
language they write to you in, with nothing added and nothing dropped. What
stays in English is a closed list: the kit's own terms, every path and every
file name, as this section already keeps them in a document, plus every
command and a quote of what a tool printed. An option label is not one of
them, and it is said in the person's language like the question it belongs
to. A mark in this file, backticks or bold, delimits a text so that its
start and its end are visible; it is never an instruction to reproduce the
bytes between the marks. The English text here is the source. A record that
quotes what was asked is compared with it statement by statement, never byte
by byte, and in a conversation in English the two are the same bytes.

## Two house rules that shape everything you write

* **No em dash in any text a user of the product reads.** It is the most
  recognizable signature of generated text. Keep it out of the documents
  you write here too, so the habit is set from the start.
* **One delivery is one page.** The process only works if the scope fits in
  `work/<slug>.md`. Everything you write into `docs/` exists to make that
  page short: the product doc so the page need not restate the product, the
  domain doc so it need not define terms, the conventions so it need not
  say how code looks.

## Step 0: which kind of project, and in which language

Count source files (anything that is not docs, config, lockfile or asset).
A repository with real code is brownfield; a repository with none, or only
scaffolding, is greenfield. A word typed after the command reaches you as
text, because Claude Code puts what was typed into the prompt whether or not
this file names an argument. It is neither an instruction nor evidence: the
count decides, whatever the word says, whether it contradicts the count,
agrees with it or names nothing this command ever accepted. Say nothing
about the word, anywhere: not a paragraph, not a clause inside the count
line, not a line of the closing report.

In both cases, if `docs/00-Product.md` already exists, this is a **review**
run: read what is there, compare it with the code and the person's
answers, and propose edits section by section instead of rewriting. A
A section that a question written in this file answers, and that carries no
answer, gets that question and a proposed edit, like any other section. The
rule is one and the sections are three: a `docs/05-Process.md` §6 that names
no tool gets the Proof tool question where there is a screen and the No
screen question where there is none, a `docs/01-Architecture.md` §3 with no
table whose header row is `Practice | Answer | Here it is` gets the four
Practice questions, and a `docs/05-Process.md` §7 that names none of the three
strategies gets the Git strategy question. That header row and not "a table",
because a §3 written before this version has the pieces table and nothing
else, and it is the one that most needs asking. For §7 the marker has §6's
shape: a first line that opens `**Strategy.**` and names one of the three.
Prose about branches and pull requests that names none of the three names
none. The Read-back of Step 2 runs
on the documents you found, and each identifier it catches is a proposed edit
too.

Then settle the documentation language, before you write anything, because
it shapes every document that follows. Before you ask, in every run, say in
one line what the count found and which kind of project that makes this
repository, in the conversation's language, so the option the question puts
first reaches the person with the evidence behind it. One `AskUserQuestion`
carries both questions:

1. **Kind of project.** Say which you detected and let them confirm.
2. **Documentation language.** The question and its options are
   written here once and said entire, in the conversation's language:
   the question `Which language do the documents get written in? The answer
   governs the prose of docs/00 to 06, the ADRs, CLAUDE.md, work/<slug>.md,
   work/done/<slug>.md and the suggested commit messages, and nothing else:
   this conversation runs in whichever language you write in, and
   identifiers stay in English whatever you answer. Any other language is
   valid: type it into the last option, Deutsch for example, and it is taken
   as you write it.` and two options,
   **English** and **Portuguese (Brazil)**, each description saying what the
   documents read like in it. The person answering may be writing to you in
   a third language, or working on a project that documents in one and talks
   in another, and the question is the one place they learn that the two are
   separate. A description carrying half of it leaves the run to improvise
   the other half, which is why all three statements are in the question.

   On a brownfield repository, look first at `README*`, the existing `docs/`
   and `git log --oneline -30`: if the prose there is already in one
   language, offer that one first and say in its description what you saw it
   in. A language typed into the last option is taken as written: record it
   in the three declarations below as the person typed it, with no
   confirmation and no second question. The question names that option by
   its place and not by a label, because Claude Code writes the label itself
   and a person reading `Type something` does not read `Other`.

On a **review** run, do not ask: read the declared language from
`docs/05-Process.md` §0, the language line of `CLAUDE.md` or
`docs/04-Conventions.md` §1, and keep it. A repository set up before this
declaration existed has none of the three: treat the language the existing
documents are written in as the answer, say which you assumed, and add the
declaration to all three places as part of the review.

Record the answer in `docs/05-Process.md` §0, on the language line of
`CLAUDE.md` and in `docs/04-Conventions.md` §1, so `/propose` and `/apply`
know it without asking again.

A fourth place, and the only one written for a program rather than for a
person: `.claude/skills/.focus-kit-language`, one line ending in a newline,
LF, holding the IETF BCP 47 tag of the answer. `en` for English, `pt-BR` for
Portuguese (Brazil), and for a language typed into the last option the tag of
what was typed, `de` for Deutsch. A tag is an identifier, so it stays in
English whatever the documentation language is. It is written on a first run
and on a review run alike, including when the answer is English, so that the
record says what was chosen instead of leaving it to be inferred from a file
that is not there. `focus-kit doctor` reads it to know which language the
manuals of `docs/manuals/` are meant to be in; the CLI never writes it, and
neither does anything else here. Step 4 is where it is acted on.

## Step 1 (brownfield): read the repository before asking anything

The person should not have to tell you what the code already says. Read,
in this order, and keep notes as you go:

1. `README*`, `CONTRIBUTING*`, any existing `docs/`, `CLAUDE.md`,
   `AGENTS.md`, `.cursorrules` or similar.
2. Package manifests and solution files: `*.sln`, `*.csproj`,
   `Directory.Build.props`, `package.json`, `pyproject.toml`, `go.mod`,
   `Cargo.toml`, `pubspec.yaml`, `Gemfile`, `composer.json`. Note language,
   framework, test framework, linters, formatters, and every script or
   target that builds, tests or lints.
3. CI configuration (`.github/workflows`, `.gitlab-ci.yml`, `azure-pipelines*`,
   `Jenkinsfile`, `Makefile`, `justfile`): this is where the real verify
   command lives.
4. Infrastructure: `docker-compose*`, `Dockerfile*`, `terraform/`, `k8s/`,
   `appsettings*.json`, `.env.example`. Note environments and how one gets
   to each.
5. Database: migrations folder, ORM configuration, schema files.
6. The folder layout of the source tree, two levels deep, and a sample of
   three or four files from the largest folder. This is the reading the
   Practice questions quote, so note four things and the file each one is
   read in: whether the code is organized by feature (vertical slices) or by
   layer; whether the business rules sit in pure functions behind an
   orchestrator or inside handlers, screens and queries; whether a failure
   travels as a returned value or as a thrown exception; and what the tests
   beside the code cover, one per piece or something else.
7. `git log --oneline -30` and `git shortlog -sn | head`: who works here,
   what the commit messages look like, whether there are branches and PRs.

Then ensure the knowledge graph, following `docs/manuals/graphify.md`
§Ensuring the graph to the letter. That is where the person is asked what an
extraction may cost, and where the post-commit hook gets installed.
Read the named section alone: one `grep -n '^#'` over the manual gives its
heading's line and the next heading of the same level, and you read that
range and nothing else of the manual.

When a graph came out of it, read `graphify-out/GRAPH_REPORT.md` once: the
god nodes and the community hubs are your map of what the product is made
of. For each god node whose role the report does not make plain, run
`graphify explain "<god node>"` and read what it is connected to.

When the answer was "Not now", there is no report:
keep reading the repository directly, as the seven points above already do,
and say so.

The seven readings answer most of what the documents need, and not all of
it. What they do not answer is asked here, before you write anything, and
today that is three things, in this order.

The first is **the four Practices**: how the code is structured, where the
rules live, how errors travel and what is tested. The sixth reading says
what the code does today, and that is a fact, not a decision. A project may
be organized by layer and want slices, or hold all four pieces and have
removed them on purpose. So the questions below are asked even when the code
already answers them, and what goes into `docs/01-Architecture.md` §3 is the
answers, never the readings.

The second is **the tool that proves a screen**. No file in a repository
names what takes a screenshot, and the sixth reading already showed whether
there is a screen at all, a web page, a mobile or a desktop app. Where there
is one, the Proof tool question; where there is none, the No screen question
in its place. Exactly one of the two, never both and never neither, and
nothing is said before the card.

The third is **the git strategy**. The seventh reading shows what the
repository does today, the branches it has and whether pull requests happen,
and that is a fact and not the rule: the question is asked anyway, and what
goes into `docs/05-Process.md` §7 is the answer. A fourth thing no file
answers joins this list as a line, not as a new step.

The **Practice questions** are
written here once and said entire, in the conversation's language,
one `AskUserQuestion` carrying all four, each explained in a line. The person
answering may be new to this repository and may never have heard of FOCUS, so
every question says two things: **what the code does today**, and, on each of
the two options, **what that answer buys.** Neither is decoration. The first
is how someone new learns where they are standing; the second is how anyone
decides, and it is on both options because the choice is between two
purchases and not between one purchase and one habit.

**On a brownfield repository** the question states what the sixth reading
found, with the file cited, and the two options are FOCUS's answer, naming
how it differs from today, and keeping today's, summarized in the reading's
own terms. **On a greenfield repository** there is no today: the question is
the bare one and the second option is the named alternative. Either way
FOCUS's answer is first, and "Other" is Claude Code's own last option,
carrying what does not fit; do not write a third.

1. **Structure.** Brownfield: `The code is organized <what reading 6 found>
   (<file>). How should it be organized?` Greenfield: `How should the code
   be organized?`
   * **Vertical slices.** One flat folder per feature, holding that
     feature's pieces. What it buys: a change to one feature opens one
     folder, and a feature is deleted by deleting a folder. Brownfield: say
     what it costs here, which is that every existing feature moves.
   * **Layers**, and on a brownfield repository **keep it as it is today**,
     summarized: folders by technical role, controllers with controllers and
     models with models. What it buys: nothing moves, and everyone already
     knows where to look.
2. **Rules.** Brownfield: `The business rules are <where reading 6 found
   them> (<file>). Where should they live?` Greenfield: `Where should the
   business rules live?`
   * **Pure use cases behind an orchestrator.** A use case is one named
     function per rule: it takes the data it needs, decides, and returns a
     Result, with no fetching and no persisting inside it. The orchestrator
     around it converts one event into one state: it fetches, calls the use
     case, saves through the repository, publishes. What it buys: a rule is
     tested by calling it with literals, with no database and no mock.
   * **Where they sit today**, summarized: in the handler, the screen or the
     query, wherever the code puts them. What it buys: no middle layer to
     write, and none to read through.
3. **Errors.** Brownfield: `A failure travels <how reading 6 found it
   travelling> (<file>). How should it travel?` Greenfield: `How should a
   failure travel?`
   * **Values.** A Result type: a refusal is returned like any other answer,
     and the repository is the one place an infrastructure exception becomes
     a value. What it buys: every caller is asked to handle each outcome, and
     a refusal cannot be swallowed by a `catch` three frames up.
   * **Exceptions as flow**, summarized: `throw` signals a refusal and a
     caller up the stack catches it. What it buys: the happy path reads
     straight down, with no Result to unwrap.
4. **Tests.** Brownfield: `The tests here cover <what reading 6 found>
   (<file>). What should get a test?` Greenfield: `What should get a test?`
   * **A test per piece.** The rule as a unit, the orchestrator as the
     integration, the view as event in and render out. What it buys: a red
     test names the piece that broke, before anyone opens it.
   * **The project's own policy**, summarized from what the tests beside the
     code already do, or, on a greenfield repository, from what the person
     names. What it buys: the policy stays the one the team already keeps.

**The two-patterns disclaimer, on a brownfield repository, said in one line
before the person answers.** It is
written here once and said entire, in the conversation's language.
Choosing FOCUS's answer where the code does
otherwise means two patterns live in the tree at once, the old one and the
new, until the migration lands. That is a normal state for a project that is
migrating and a bad one for a project that is not, so the choice comes with
the migration deliveries in `docs/06-Queue.md` (Step 2) or it does not come.

**An option says what it does to the queue, when there is a queue to do
something to.** That is a review run, and any brownfield repository whose
`docs/06-Queue.md` already holds lines that assume one of the answers. Name
them in the option, by slug: which deliveries it keeps, which it cancels,
which it adds, and which milestone leaves. Someone choosing between two
architectures is choosing between two queues, and the queue is the half of
the consequence they can already read. A greenfield repository has no queue
yet, so the option says nothing about one.

The four answers become the Practice table of `docs/01-Architecture.md` §3 in
Step 2, whose header row is `Practice | Answer | Here it is` and is what a
review run looks for, and nothing else in any document you write may assume
an answer that was not given.

The **Proof tool question** is
written here once and said entire, in the conversation's language,
one `AskUserQuestion`, the question `How is a screen proven? No file names
the tool.` and three options, in this order:

* **Claude in Chrome.** The browser inside Claude Code: a screenshot at the
  viewports §6 names, nothing added to the repository.
* **A script or driver of the repository.** The person names it (Playwright,
  an emulator, a device) and its command, and it lives in the repository
  like any other tool.
* **None.** The verify command is the proof, and §6 says so in one line.

"Other" is Claude Code's own fourth option and carries what does not fit; do
not write a fourth. The answer opens `docs/05-Process.md` §6: its first line
is `**Tool.**` and what was chosen. The rest of that section stays what the
files answered, each one cited.

The **No screen question** is
written here once and said entire, in the conversation's language,
one `AskUserQuestion`, the question `How is a delivery proven? There is no
screen, and no file names the tool.` and three options, in this order:

* **A real run in a scratch copy.** The command or the endpoint runs in a
  throwaway directory or repository, and what it printed is read and
  recorded in the delivery.
* **An output compared with a reference.** A contract test or a golden file
  kept beside the code, which the run's output is compared with.
* **None.** The verify command is the proof, and §6 says so in one line.

"Other" is Claude Code's own fourth option and carries what does not fit; do
not write a fourth. The answer opens `docs/05-Process.md` §6 the same way:
its first line is `**Tool.**` and what was chosen, so the slot keeps one
marker whatever the repository has. The rest of that section stays what the
files answered, each one cited.

The **Git strategy question** is
written here once and said entire, in the conversation's language,
one `AskUserQuestion`. This is not a Practice and FOCUS has no answer to
it, so no option comes first as a recommendation and none of the three is
the house's. On a brownfield repository the question quotes what the seventh
reading printed and cites no file, because that reading is `git log` and
`git shortlog` and not a file. The question is `How does this repository
work with git? The git history shows <what reading 7 printed>. That is what
happens today; this answer is the rule from now on.` and, on a greenfield
repository, `How does this repository work with git?` Three options, in this
order:

* **A worktree per delivery.** The first command that writes under a slug
  makes a git worktree on a branch named by the slug, in a sibling directory
  of this one, and every later command for that slug works there. What it
  buys: two deliveries never share a working tree, so `git add -A` of one
  cannot stage the other's files. What it costs: a worktree is made from
  `HEAD`, so the queue line and its mark live on that branch until someone
  merges it and a session in the main tree does not see them; the graph is
  built once per delivery, because a fresh worktree has none; and the
  directory is removed by hand after the merge.
* **A branch per slug.** The first command that writes under a slug makes a
  branch named by the slug in this tree, and every later command for that
  slug works on it. What it buys: one delivery is one branch, so the history
  reads a delivery at a time and a pull request has something to point at.
  What it costs: there is one working tree, so uncommitted work follows the
  checkout, and the command says what it would carry before it switches.
* **None.** Nothing is made and the commands write where you are; work goes
  straight to the trunk. What it buys: no ceremony, which is the answer where
  one person works alone and nobody is on the other side of a branch. What it
  costs: two deliveries in flight share one tree, so `git add -A` of one
  stages whatever the other left there.

"Other" is Claude Code's own fourth option and carries what does not fit; do
not write a fourth. The answer opens `docs/05-Process.md` §7: its first line
is `**Strategy.**` and what was chosen, the way §6 opens with `**Tool.**`.
The rest of §7 stays what the files answered: who commits, the message
format, review before merge. What each command does under each strategy is
`docs/manuals/process.md` §The git strategy, and no document you write
repeats it.

## Step 1 (greenfield): ask in rounds

Do not ask twenty questions at once. Ask in rounds, each round only about
what the previous one settled. A card is one `AskUserQuestion` with at most
four questions, and that ceiling is the card's and not the round's: a round
asks a second card when what it has to offer could not have been written
into the first. Round 5 is the round that does, twice over: its tooling card
is composed from what round 3 answered, and its proof card is one of two,
the Proof tool question or the No screen question, decided by whether rounds
1 to 3 named a UI. Give your recommendation as the first
option whenever you have one. Suggested rounds:

1. **Product.** What it is in one sentence; who uses it (every side, if it
   is a marketplace); what it must never become (the non-goals); what
   already exists (a predecessor, a prototype, a client's system).
2. **Domain.** The five to ten nouns the product cannot be described
   without, and the verbs between them. For each noun, one sentence of
   meaning and its identifier in code. Ask about the ones the person's
   first answer implied but did not name.
3. **Stack.** Language and framework (the house default is C# on .NET,
   with the Mediator pattern as the orchestrator, MediatR or any other
   implementation; see `docs/manuals/focus.md` §9); database;
   where it runs; what the client imposes.
4. **Practices.** The four Practice questions, asked as they are written in
   the brownfield step above, with no third option: there is no code to
   quote. Their answers become `docs/01-Architecture.md` §3 and decide which
   pieces the rest of this round and Step 2 may name.
5. **Environments, tooling and proof.** Which environments exist (local,
   dev, staging, production); how code gets to each; which one a delivery
   must leave up to date. Then a second card, in the same round: the test
   framework, the linter and the formatter of the ecosystem round 3
   answered, and of no other. Three options, in this order: the set that
   ecosystem's projects standardly use, one credible alternative of the
   same ecosystem, and deciding later. No tool is named here, because the
   ecosystem is the answer's and not this file's; where round 3 answered
   the house default, the first option is that stack's usual set. Deciding
   later writes one line in each section that would have named a tool,
   saying that nothing is chosen yet and where the choice gets made, and
   never a placeholder (`docs/00-Product.md`, Initializing). Only then
   what the verify command is (or will be), because it runs the tooling
   that was just chosen: asked before that card the answer is a promise,
   asked after it the answer is a command. Then how a delivery is proven,
   which is one card of two: where rounds 1 to 3 named a UI, what the visual
   reference is and which tool proves a screen, the Proof tool question, as
   in the brownfield step; where they named none, the No screen question, as
   in the brownfield step too. Exactly one of the two, never both and never
   neither.
6. **Conventions and git.** Naming rules the client imposes; the Git
   strategy question, as in the brownfield step, with no history to quote;
   the commit message format. The agent never commits, regardless of the
   answer.
7. **The first milestone.** Three to eight deliveries, in order, each one
   line, that together make something a person can use end to end. This
   becomes `docs/06-Queue.md`.

After the rounds, still ensure the graph, the same way: follow
`docs/manuals/graphify.md` §Ensuring the graph, which asks the person before
anything is billed and installs the post-commit hook.
Read the named section alone: one `grep -n '^#'` over the manual gives its
heading's line and the next heading of the same level, and you read that
range and nothing else of the manual.
The docs you are about
to write are content too, and the graph is what `/propose` and `/apply` read
from the next session on.

## Step 2: write the documents

Write them in this order, because each one leans on the previous:

| File | Template | What it answers |
|---|---|---|
| `docs/03-Domain.md` | `templates/docs/03-Domain.md` | what the words mean, and their names in code |
| `docs/00-Product.md` | `templates/docs/00-Product.md` | what the product is, for whom, what it is not |
| `docs/01-Architecture.md` | `templates/docs/01-Architecture.md` | how it is built: stack, the Practice table, the pieces those answers give, what stays out |
| `docs/02-Backend.md` | `templates/docs/02-Backend.md` | the server: topology, environments, operation, data. "Not applicable" is a valid document, with the reason |
| `docs/04-Conventions.md` | `templates/docs/04-Conventions.md` | names, style, errors, where things are tested, commits |
| `docs/05-Process.md` | `templates/docs/05-Process.md` | the flow, with this project's slots filled: verify command, environments, publish policy, git policy, proof |
| `docs/06-Queue.md` | `templates/docs/06-Queue.md` | the ordered queue, first milestone filled |
| `docs/adr/README.md` and `docs/adr/ADR-0001-*.md` | `templates/docs/adr/` | the decision record, seeded with the stack decisions you found or were given |
| `CLAUDE.md` | `templates/CLAUDE.md` | the entry point every session reads |

Rules while writing:

* **Every document goes out in the documentation language settled in Step
  0.** The templates are in English; if the project is not, translate the
  headings and the fixed prose as you fill each one, and do not leave a
  half-translated page. The code names in the `docs/03-Domain.md` table
  stay in English, and so do paths, file names and the kit's own terms.
* **Brownfield: describe what is, then what should be, and keep them
  apart, when the two differ.** They differ when a Practice answer is not
  what the sixth reading found. If the structure answer is vertical slices
  and the code is organized by layer, `01-Architecture.md` says both, and
  the queue gets a migration delivery per slice (the book's chapter on
  migrating legacy without stopping the factory is the recipe; see
  `docs/manuals/focus.md`). If the structure answer is what the code
  already does, there is one state to describe and the queue gets no
  migration line. Every other practice answered against what the code does
  today gets its own line in the queue too, one at least, because the
  two-patterns disclaimer was said on the promise of them: a repository
  left with two patterns and no queued migration is the state that
  disclaimer warns about. Do not write the architecture you wish existed as
  if it existed, and do not write one nobody chose.
* **Everything you assert about a brownfield project must be traceable to
  a file.** Cite the path. If you inferred it, say "inferred from".
* **The domain document is the pivot.** Every term in 00, 01 and 06 must
  be defined in 03, with its code identifier. If you catch yourself using
  a word in two senses, stop and ask.
* **A document is not a placeholder.** If you do not know what goes in a
  section, ask. If the section does not apply, write one line saying why.
* **Short.** 00 and 03 can be long because they are the product; 01, 02,
  04 and 05 should each fit in a few screens. The verify command, the
  environments table and the publish policy in 05 are the parts `/apply`
  reads every time; get those exact.

**Read-back.** The pivot rule above is stated while you write and nothing
reads it back, so read it back here, after the nine documents exist and
before Step 3. Go through `docs/00`, `docs/01` and `docs/06` and collect
every identifier they name: a type, a function, a column, a table or a
module, backticked or not. A path, a file name, a command, a branch and a
term of `docs/manuals/focus.md` are not identifiers: view, orchestrator, use
case, repository, Result, `Failure`, slice and the rest of that manual's
vocabulary, which is the list and not these seven. A name built on one of
those terms is an identifier, and goes through the rule like any other. For each one, look in the Code
column of `docs/03`. Already there: nothing to do. Not there: one `grep` in
the source tree decides. Found in the code, the concept was missing from the
table and gets a row, with what the code calls it. Not found anywhere, the
name is one nobody has written yet: rewrite the sentence in the table's
terms and let the name wait for the `/propose` that defines that delivery,
which is what "enters here first" means. A greenfield repository has no code
to grep, so it is always the second. End the pass by saying one line,
`read-back: <n> identifiers in docs/00, 01, 06; <n> rows added; <n> lines
rewritten`, and then one line per identifier you touched, naming the
document, the identifier and which of the two happened. When every
identifier was already in the table, that first line alone, ending `all in
docs/03`.

## Step 3: CLAUDE.md

If there is no `CLAUDE.md`, write it from the template. If there is one,
**merge**: keep everything that is there, add the language line and the
"Read before acting", "Non-negotiables" and "How to work" blocks, and move
any rule you found in
the existing file that belongs in a doc (a naming rule, a test command) into
that doc, leaving a pointer. Show the person the diff before writing it.

Also add to `.claude/settings.json` the permission allows this stack needs
(`Bash(dotnet *)`, `Bash(npm *)`, `Bash(make *)`, and so on) and the one the
Proof tool needs, when it has one, so `/apply` does not stop on every build.

## Step 4: the manuals follow the language

The three manuals in `docs/manuals/` are read in this repository by the people
working here and by every command that names a section of one, so they are
written in the documentation language too. The tag Step 0 recorded says which
one, and this is the step that acts on it.

When the tag is `en`, there is nothing to do: say one line, `manuals stay in
English`, and go on.

When it is anything else, rewrite `docs/manuals/process.md`,
`docs/manuals/focus.md` and `docs/manuals/graphify.md` in that language, one
file at a time, each one in place. The body is translated and the finished
manual reads as if it had been written in that language, with no seam, the way
a document filled from a template does.

**Every section heading stays in English, byte for byte.** A command names the
section of a manual it reads, and `focus-kit doctor` matches a citation from
this repository's documents against the manual the kit ships, so one
translated heading breaks both at once. A `§` citation inside a manual's own
body is that same heading's text and stays with it: `§When the graph is
rebuilt` is written as it is, in the middle of a translated sentence.

What else stays as written is the closed list the Language section above
already keeps for a document: the kit's own terms, every path, every file
name, every command and a quote of what a tool printed. The first two lines of
each manual belong to that list and are carried over untouched, the Kit-owned
banner and the License notice, which are the kit's own terms, a path and a
URL.

The no em dash rule covers a translated manual like every other text you
write here.

A manual that says it quotes a source verbatim says, in the translation, that
the quotes are translated. `focus.md` is the one that does: it quotes the book
word for word, and a quotation translated is no longer one. One clause in the
line that already makes the claim, and nothing else added to the file.

On a **review** run the question is asked of each manual on its own: one that
is still the English file the kit ships is translated now, one that is already
in the language is left alone. `focus-kit doctor` answers it in one line per
manual, `docs/manuals/<name>.md in English, not <tag>`, and so does reading
the file's first paragraphs.

The manuals stay kit-owned, so `focus-kit update` writes the English files
back over the translations, as it does over every file the kit owns. That is
not a failure and nothing is lost: `doctor` names each one that came back in
English, and what translates them again is this command.

## Step 5: report

End by listing the files you wrote and the questions you left open (each
one as a line in `docs/06-Queue.md` under "Open decisions" or in
`docs/00`).

Then run `focus-kit doctor .` at the root of this repository and print what
it printed, whole and unchanged: every line, in the order the command wrote
them. Not a summary, not the warns alone, not a count. Those lines are a
quote of what a tool printed, which the Language section above keeps in
English whatever the conversation's language, so they reach the person as
the command printed them.

The command names and you do not act. A warn there already carries the
command that fixes it, so nothing of yours goes after it and no step is
taken back because one appeared: what to do about it is the person's call.
A run that skipped a step reads it back here, which is what the line is
for.

When `focus-kit` is not on `PATH`, or the command exits non-zero, say one
line naming what you could not run, and go on. Nothing stops.

Then the next step:

```
/propose <first-slug-from-the-queue>
```

Stage everything with `git add -A` and suggest the commit message in the
format `docs/05-Process.md` defines. Do not commit.
