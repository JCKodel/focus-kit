---
name: initialize
description: >-
  Set up the focus-kit process in this repository. Writes docs/00 to 06,
  docs/adr, CLAUDE.md and the work queue, in the documentation language the
  project chooses. On a greenfield project it asks; on a brownfield project
  it reads the code, builds the graphify graph and asks only what the code
  cannot answer.
argument-hint: "[green|brown]"
---
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are setting up the delivery process described in `docs/manuals/process.md`
and the architecture described in `docs/manuals/focus.md`. Read both first.
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
`/apply`), and keep every path and file name as it is.

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

If `$ARGUMENTS` says `green` or `brown`, trust it. Otherwise count source
files (anything that is not docs, config, lockfile or asset). A repository
with real code is brownfield; a repository with none, or only scaffolding,
is greenfield.

In both cases, if `docs/00-Product.md` already exists, this is a **review**
run: read what is there, compare it with the code and the person's
answers, and propose edits section by section instead of rewriting.

Then settle the documentation language, before you write anything, because
it shapes every document that follows. One `AskUserQuestion` carries both
questions:

1. **Kind of project.** Say which you detected and let them confirm.
2. **Documentation language.** Offer English and Portuguese (Brazil) as
   options; any other language the person names is valid. On a brownfield
   repository, look first at `README*`, the existing `docs/` and
   `git log --oneline -30`: if the prose there is already in one language,
   offer that one first and say what you saw it in. Remind them, in the
   option's description, that identifiers stay in English either way.

On a **review** run, do not ask: read the declared language from
`docs/05-Process.md` §0, the language line of `CLAUDE.md` or
`docs/04-Conventions.md` §1, and keep it. A repository set up before this
declaration existed has none of the three: treat the language the existing
documents are written in as the answer, say which you assumed, and add the
declaration to all three places as part of the review.

Record the answer in `docs/05-Process.md` §0, on the language line of
`CLAUDE.md` and in `docs/04-Conventions.md` §1, so `/propose` and `/apply`
know it without asking again.

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
   three or four files from the largest folder. Decide whether the code is
   organized by feature (vertical slices) or by layer, and whether the four
   FOCUS pieces exist under any name.
7. `git log --oneline -30` and `git shortlog -sn | head`: who works here,
   what the commit messages look like, whether there are branches and PRs.

Then ensure the knowledge graph, following `docs/manuals/graphify.md`
§Ensuring the graph to the letter. That is where the person is asked what an
extraction may cost, and where the post-commit hook gets installed.

When a graph came out of it, read `graphify-out/GRAPH_REPORT.md` once: the
god nodes and the community hubs are your map of what the product is made
of. For each god node whose role the report does not make plain, run
`graphify explain "<god node>"` and read what it is connected to.

When the answer was "Not now", there is no report:
keep reading the repository directly, as the seven points above already do,
and say so.

## Step 1 (greenfield): ask in rounds

Do not ask twenty questions at once. Ask in rounds, each round one
`AskUserQuestion` with at most four questions, and each round only about
what the previous one settled. Give your recommendation as the first
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
   where it runs; what the client imposes. Test framework, linter,
   formatter.
4. **Environments and proof.** Which environments exist (local, dev,
   staging, production); how code gets to each; which one a delivery must
   leave up to date; what the verify command is (or will be). If there is
   a UI, what the visual reference is and how a screen is proven.
5. **Conventions and git.** Naming rules the client imposes; whether work
   goes to trunk or through branches and pull requests; the commit message
   format. The agent never commits, regardless of the answer.
6. **The first milestone.** Three to eight deliveries, in order, each one
   line, that together make something a person can use end to end. This
   becomes `docs/06-Queue.md`.

After the rounds, still ensure the graph, the same way: follow
`docs/manuals/graphify.md` §Ensuring the graph, which asks the person before
anything is billed and installs the post-commit hook. The docs you are about
to write are content too, and the graph is what `/propose` and `/apply` read
from the next session on.

## Step 2: write the documents

Write them in this order, because each one leans on the previous:

| File | Template | What it answers |
|---|---|---|
| `docs/03-Domain.md` | `templates/docs/03-Domain.md` | what the words mean, and their names in code |
| `docs/00-Product.md` | `templates/docs/00-Product.md` | what the product is, for whom, what it is not |
| `docs/01-Architecture.md` | `templates/docs/01-Architecture.md` | how it is built: stack, the four pieces, slices, what stays out |
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
  apart.** If the code is organized by layer and the house architecture
  is by feature, `01-Architecture.md` says both, and the queue gets a
  migration delivery per slice (the book's chapter on migrating legacy
  without stopping the factory is the recipe; see `docs/manuals/focus.md`).
  Do not write the architecture you wish existed as if it existed.
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

## Step 3: CLAUDE.md

If there is no `CLAUDE.md`, write it from the template. If there is one,
**merge**: keep everything that is there, add the language line and the
"Read before acting", "Non-negotiables" and "How to work" blocks, and move
any rule you found in
the existing file that belongs in a doc (a naming rule, a test command) into
that doc, leaving a pointer. Show the person the diff before writing it.

Also add to `.claude/settings.json` the permission allows this stack needs
(`Bash(dotnet *)`, `Bash(npm *)`, `Bash(make *)`, and so on), so `/apply`
does not stop on every build.

## Step 4: report

End by listing the files you wrote, the questions you left open (each one
as a line in `docs/06-Queue.md` under "Open decisions" or in `docs/00`),
the state of the graph and the hook, and the next step:

```
/propose <first-slug-from-the-queue>
```

Stage everything with `git add -A` and suggest the commit message in the
format `docs/05-Process.md` defines. Do not commit.
