# focus-kit

The delivery process born in Ninjobs, packaged so anyone can install it in
a repository with one sentence to their coding agent. This repository is
the kit, not a project that uses it.

The kit is `SETUP.md` (what the agent does, and the four commands with
their reference), `README.md` and `CHANGELOG.md` with their Brazilian
Portuguese twins `README.pt.md` and `CHANGELOG.pt.md` (for people), and
`LICENSE`. There is no CLI, no installer,
no version file, no manifest. Updating the installed commands is running
`SETUP.md` again; its report lists pending migrations to project documents.
`notes/` holds the design notes of the kit's scripts; it is not a queue,
and the kit runs no process on itself. `research/` is ignored by git:
audits and their reproductions stay out of the public repository.

The version is the `Version: YYYY.MM.DD` line near the top of `SETUP.md`
(a fourth `.N` part for a second release on one day), and the same value in
`metadata.version` of the four `SKILL.md` frontmatters, so a planted
repository says which kit it has. A change to any file of §3 bumps all five
together; ace reads them to tell a person their kit is outdated. Every
bump adds an entry at the top of `CHANGELOG.md` and `CHANGELOG.pt.md`,
headed by the new version, saying what a person who reruns `SETUP.md`
will find changed. Every bump also adds, in the same session, its lines
to the queue of the book that teaches the kit, `../focus-kit-book`
(`docs/06-Queue.md`): a `## M<n>. focus-kit <version>` milestone with
`[ ] kit-<version>` and a `[ ]` line per chapter that teaches what
changed, so the book stays paired with the latest kit. Lines only: the
book changes its chapters through its own `/apply`.

## Rules

- English prose, English identifiers. The exceptions are `README.pt.md`
  and `CHANGELOG.pt.md`, which say what `README.md` and `CHANGELOG.md`
  say, in Brazilian Portuguese; a change to one is a change to both. No em dash anywhere in this repository: it is
  the signature of AI text, and the kit's text sets the example for every
  project it reaches.
- **Nothing enters the kit without naming the concrete error it would have
  caught.** The answer names an error that happened in a real project. This
  is the rule Ninjobs kept in its process document and the one an earlier
  version of this kit broke; `README.md` §Why this shape says how.
- Commands stay readable whole, and what is measured is the sentence,
  not the file. No sentence over fifty words; one rule per sentence; no
  rule inside a parenthesis or in a chain of semicolons longer than two
  clauses. `test/run.sh check` reports the longest sentence of each
  command, of the docs/05 template and of `SETUP.md` §1. On 2026-10-19
  §1's step 4 was one 45-line sentence that an agent running it could not
  hold in mind and rewrote as a list for itself; on 2026-10-20 line
  ceilings produced the opposite error, prose compressed until a sentence
  of docs/05 §2 lost its verb. A command says which documents to read,
  what to do and what never to do. Anything project-specific is a slot in
  the project's `docs/05`, filled once by `/brainstorm` or `/analyze` and
  read by `/apply`. A procedure, a report format or a cross-reference
  chain inside a command is the smell. A change that adds a rule names
  the rule it displaces, or says why none does. Line counts are alarms,
  not gates: `/propose` body over 40 lines, `/apply` over 60, `SETUP.md`
  §1 over 200, the docs/05 template over 320 non-blank, `documents.md`
  over 600; crossing one is said in the CHANGELOG entry, with why.
- The four commands and their reference live only inside `SETUP.md`, in
  the fenced blocks of §3. There is no second copy to keep in sync.
- Host facts (where Claude Code, Codex and Copilot read skills and rules)
  are verified against the vendors' documentation before they change; the
  table in `SETUP.md` §1 is the only place they are written.

## Verify

Before declaring anything done: read `SETUP.md` §1 as an agent would and
confirm the paths and tokens still hold; run `test/run.sh check` (em dash,
fences, versions, twins, book line, sentence lengths, line alarms) and
answer every warning or say why it stays. Before a release, `test/run.sh
parallel` plants the kit in a throwaway project on each installed host and
runs `/propose` with three slugs; `test/README.md` says what it proves and
what it costs.

## Git

Stage and suggest the commit message. Never commit.
