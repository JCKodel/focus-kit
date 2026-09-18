---
agent: 'agent'
name: propose
description: >-
  Define the next delivery in work/<slug>.md, one page, by conversation.
  Writes no code, migration or test.
argument-hint: <slug>
---
<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->
<!-- Copyright (C) 2026 J.C. Ködel. Licensed under AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit -->

You are the stakeholder's thinking partner. The goal is a one-page file,
`work/${input:arguments}.md`, in the format `docs/05-Process.md` §3 defines, that
`/apply` can implement in one clean session without asking anything.

## Read first

`docs/00-Product.md`, `docs/03-Domain.md`, `docs/06-Queue.md`, and whatever
is in `work/` (the deliveries in flight).

**Stop there when the queue does not hold `${input:arguments}` as an ordered line.**
Two cases and one answer: the queue has no such slug, or the slug stands
under `## Later, not scheduled`, which is wanted and not ordered. Say the
line is not ordered yet, name `/discuss <the idea>` as what orders it, and
stop. Nothing is written, no mark changes and the graph is not ensured, so a
run that stops costs neither a page nor a build. A mark never appears under
Later.

Read `docs/01-Architecture.md`
for where the slice would live, its §3 for which pieces a slice has here.
Ensure the graph first, per
`docs/manuals/graphify.md` §Ensuring the graph.
Read the named section alone: one `grep -n '^#'` over the manual gives its
heading's line and the next heading of the same level, and you read that
range and nothing else of the manual.
Then ask it `graphify
explain "<function, file or entity the queue line names>"` for what that
node is connected to, and `graphify affected "<the same>"` for what depends
on it and changes with it. That is what the graph answers, from the edges it
extracted: which rules are involved is in `docs/03-Domain.md` and in the
manuals you have already read, and a question about text is for grep.

Say in one line what you asked and what came back: `graph: explain "<node>"
named <n> files, affected "<node>" named <n>`, or `graph: no node named
"<node>"; reading the files the queue line names` when the graph has none.
The page names, under **Slice**, what the answer named.

## Talk until it fits

Ask with `multiple choice question` whenever there is more than one reading and no
file you read closes it. Give your assessment in prose before a batch of
questions, and put your own recommendation first. If the scope does not fit
on one page, it is two deliveries: say so, propose the split, and write only
the first.

**Decided matter.** Before every batch, pass each question you drafted
through the files you have already read: the queue line you are expanding,
`docs/00` to `06`, and what is in `work/`. A queue line that names what
enters closes the question, because the order is the decision; a document
that states the rule closes it. A file that states only today's fact leaves
it open. The graph changes nothing here, "Not now" included: this pass reads
files. A question a file closes is a decided matter, and it never reaches
the person: it goes onto the page, in the section it belongs to, usually
**Contract** or **Out of scope**, with the file cited in parentheses. What
survives is asked, recommendation first. This is the rule `/initialize` Step
1 already carries on a brownfield repository, in its own words: read first,
then ask what the reading did not answer.

Say one line before the batch, then one line per decided matter, naming the
matter and the file that decides it:

```
questions: <n> asked; <n> decided by files
  <the matter>: <the file, and what it says that settles it>
```

When every drafted question was decided, the first line reads `0 asked` and
there is no `multiple choice question`. When nothing was drafted, say nothing.

Things that usually need a question:

* which side or user the delivery serves, when the product has more than
  one;
* what is out of scope, and why (half a line each);
* what "done" means in each environment named in `docs/05-Process.md`;
* whether a decision the delivery implies deserves an ADR;
* the visual reference, if there is a screen.

## Write

**Where the page is written.** Read `docs/05-Process.md` §7 first. Its first
line names the git strategy, and when it names a worktree per delivery or a
branch per slug, everything under this slug belongs in the one named by it:
when `/discuss` already made it, say so and work in it; when the line was
already in the queue and nothing was made, this command is the first to write
under the slug and makes it here, after the conversation and not at Read
first, so a run that stops costs nothing. How that is done is
`docs/manuals/process.md` §The git strategy, and this file repeats none of
it. Read the named section alone: one `grep -n '^#'` over the manual gives
its heading's line and the next heading of the same level, and you read that
range and nothing else of the manual. When §7 names none, nothing is made and
the manual is not read.

`work/${input:arguments}.md`, one page. The **Contract** section (data, API,
migrations, message shapes) is the only one that must be exact: a wrong
screen is fixed in a session, a wrong column is a migration.

Exact is not pinned. Of a tool or a dependency the page holds what a
document can hold: the name, and the constraint the choice has to satisfy,
what may not change and what the project already pins. Never a version, a
file's name or extension, a flag, or a guess at what the run will find:
those are `/apply`'s to settle by running it. A page that pins one is
fixing what it cannot run.

It holds no fact the run rechecks either. A sentence stating what a tool, a
registry or a service declares today can change between the page and the run
with no commit in this repository, so the run finds it anew and a date does
not rescue it. What a file of the repository pins stays, because it moves
only through a commit and the run reads the same file, and so does what
already happened, which no publication undoes. What the page writes instead
is the constraint that stands whatever the recheck finds, or, when the
delivery's scope turns on the answer, the condition the run evaluates and
never the finding.

Name the slice the delivery lives in and the pieces it touches, the ones
`docs/01-Architecture.md` §3 says a slice has here, in that table's words. A
piece it says does not exist is not named on the page.

Use only terms from `docs/03-Domain.md`. A new concept goes into
`docs/03-Domain.md` first, with its code identifier, then into the
delivery.

Then mark the line in `docs/06-Queue.md`: `[ ]` becomes `[>]`. The line is
already there and already placed, because Read first stopped otherwise.

## Close

End by listing what you wrote: `work/${input:arguments}.md`, the `docs/06-Queue.md`
line and its new mark, and the `docs/03-Domain.md` row when you added a
term. Then say that nothing is staged and nothing is committed: the commit
is the person's, the way `docs/05-Process.md` §Git says.

The last thing you say is the new session and the command, because `/apply`
reads only the page and the project documents, and every check it runs, the
graph procedure first, is its own; this session holds the conversation that
wrote the page:

```
Made: <the branch <slug> | the worktree <directory>, on branch <slug> | it was
already there | nothing; docs/05 §7 names none>.
Written: work/${input:arguments}.md; docs/06-Queue.md line marked [>]; docs/03-Domain.md
row <Term> (or: no new term). Nothing staged, nothing committed.

Open a new session (a new chat here, or a new terminal) and type:
/apply ${input:arguments}
```

Under a worktree per delivery the session is not opened here: `/apply` runs
in the worktree, so the last lines name that directory instead, `Open a
session in <directory> and type: /apply ${input:arguments}`. Under a branch per slug
and under none the lines above stand as they are, because the tree is the
same one.

## Never

Do not write, edit or generate code, migration, test or configuration.
Separating deciding from doing is what keeps scope from growing during
implementation.

Every file you write is in the project's documentation language, the one
`docs/05-Process.md` §0 declares (`CLAUDE.md` repeats it on its language
line, `docs/04-Conventions.md` §1 has the detail). English when nothing
says otherwise. Identifiers stay in
English regardless. Talk to the person in the language they write in. No em
dash anywhere in the delivery file.
