# focus-kit

The delivery process born in Ninjobs, packaged so anyone can install it in
a repository with one sentence to their coding agent. This repository is
the kit, not a project that uses it.

The kit is `SETUP.md` (what the agent does, and the four commands with
their reference), `README.md` and its Brazilian Portuguese twin
`README.pt.md` (for people), and `LICENSE`. There is no CLI, no installer,
no version file, no manifest. Updating a repository is running `SETUP.md`
again.

## Rules

- English prose, English identifiers. The one exception is `README.pt.md`,
  which says what `README.md` says, in Brazilian Portuguese; a change to
  one is a change to both. No em dash anywhere in this repository: it is
  the signature of AI text, and the kit's text sets the example for every
  project it reaches.
- **Nothing enters the kit without naming the concrete error it would have
  caught.** The answer names an error that happened in a real project. This
  is the rule Ninjobs kept in its process document and the one an earlier
  version of this kit broke; `README.md` §Why this shape says how.
- Each command stays about the size of Ninjobs' originals: `/propose`
  eleven lines, `/apply` forty-eight. A command says which documents to
  read, what to do and what never to do. Anything project-specific is a
  slot in the project's `docs/05`, filled once by `/brainstorm` or
  `/analyze` and read by `/apply`. A procedure, a report format or a
  cross-reference chain inside a command is the smell.
- The four commands and their reference live only inside `SETUP.md`, in
  the fenced blocks of §3. There is no second copy to keep in sync.
- Host facts (where Claude Code, Codex and Copilot read skills and rules)
  are verified against the vendors' documentation before they change; the
  table in `SETUP.md` §1 is the only place they are written.

## Verify

Before declaring anything done: read `SETUP.md` §1 as an agent would and
confirm the paths and tokens still hold; a grep for the em dash character
(U+2014) over every `.md` file returns nothing; every fenced block in §3
opens and closes.

## Git

Stage and suggest the commit message. Never commit.
