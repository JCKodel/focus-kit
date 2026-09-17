# propose-ends-by-naming-the-next-session

**Goal.** A person finishing `/propose` is told, at the moment they decide
where to type, that `/apply` runs in a new session, and an `/apply` typed
into a session that is not clean stops instead of building. Measured on the
first target (`work/done/first-target-delivery.md`, finding 2): `/propose
test-harness` ended at "`/apply test-harness` implementa",
`skills/propose/SKILL.md` has no closing section at all, the next turn of the
same transcript was `/apply`, and it opened with "o grafo foi verificado no
início desta sessão" and never asked the graph. The kit asks for a clean
session in four documents and says it in none of them at that moment.

**Behaviour.**

* `/propose` ends with a Close: what it wrote (the page, the queue line's
  new mark, the `docs/03` row if it added one), that nothing is staged or
  committed, then the last thing it says is the new session and the
  command, with the reason in one clause: `/apply` reads only the page and
  the project documents, and every check it runs, the graph first, is its
  own; this session holds the conversation that wrote the page.
* `/apply` is the first thing typed in its session. When the conversation
  already holds a `/propose`, an `/initialize` or an `/apply` before this
  one, it says one line and stops, before Read first: nothing read, nothing
  built, nothing staged. On the first target as it was, `/apply
  test-harness` at the turn after `/propose` prints the line and changes
  no file.
* A Clean session never sees the guard: nothing is said, Read first begins.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Two skills and one manual kit-owned; a target receives them on
`update`. Applies after `propose-asks-only-what-no-file-answers`, which
edits Talk until it fits of the same skill and the asking sentence of the
same manual section; this page touches neither.

* `skills/propose/SKILL.md`: a section `## Close` between Write and Never.
  It names the three things to list and the "nothing staged, nothing
  committed" line, then the last lines, in a code block as `/initialize`
  Step 4 prints its next step (the first occurrence of a closing that names
  the next step; it names the command alone and stays as it is):
  `Open a new session (/clear here, or a new terminal) and type:` then
  `/apply <slug>`, and the one clause of reason above.
* `skills/apply/SKILL.md`: the first paragraph, after "Implement ... in this
  session, completely", gains the Clean session rule: `/apply` is the first
  thing typed in it; when the conversation already holds one of the three
  commands before this one, say `this session already ran <command>; open a
  new one (/clear, or a new terminal) and type /apply <slug>` and stop,
  before Read first.
* `manuals/process.md` §4: the sentence "When it is done, it turns the queue
  line from `[ ]` to `[>]`" gains "and its last words name the new session
  to type `/apply` in". §5: "Implements the page, in a clean session" gains
  "one where `/apply` is the first thing typed; when it is not, it says so
  in one line and stops".
* `VERSION`: one minor above what `propose-asks-only-what-no-file-answers`
  leaves, `0.17.0` when that page takes `0.16.0`; its own apply reads the
  file.
* This repository: `docs/00-Product.md`, Defining a delivery, "and ends by
  naming the session `/apply` runs in"; Building it, "in which it is the
  first command typed, and when it is not it says so and stops";
  `docs/03-Domain.md` carries the Clean session row, written by this page;
  `docs/06-Queue.md` line `[x]`. The `docs/05` template already says "in a
  clean session" and does not change: a target reads the definition in
  `manuals/process.md` §5.

**Slice.** `skills/propose/SKILL.md`, `skills/apply/SKILL.md` and
`manuals/process.md`, kit-owned; this repository's `docs/`, project-owned.
`graph: explain "skills/propose/SKILL.md" named the file's four sections,
affected named 0`, so nothing outside the three files changes with them.
Nothing in `bin/focus-kit`, `skills/initialize/` or `config/`, so no
function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. In the session, the end of
`/propose`:

```
Written: work/<slug>.md; docs/06-Queue.md line marked [>]; docs/03-Domain.md
row <Term> (or: no new term). Nothing staged, nothing committed.

Open a new session (/clear here, or a new terminal) and type:
/apply <slug>
```

And `/apply` typed into a session that is not clean, its whole output:

```
this session already ran /propose; open a new one (/clear, or a new
terminal) and type /apply <slug>
```

**Visual reference.** The lines above, as the first target's session would
have shown them at [168] and [177] of its transcript.

**Out of scope.**

* `/initialize` naming the session for `/propose`: no rule asks `/propose`
  to run clean, and the one measured incident is `/propose` to `/apply`;
  abstraction on the second occurrence.
* `/propose` staging the page: no command stages a proposal today; here the
  page is committed with its apply (`docs/05` §7), and a target's policy is
  `git-branches-are-queue`.
* The graph procedure run per command rather than per session: the guard
  stops the shared session before the procedure, so that door is shut.
* Resuming an interrupted `/apply` in the same session: the guard stops it
  too; a new session reads the same page and the working tree the run left.
* Tooling detail the page cannot verify:
  `propose-does-not-fix-what-it-cannot-run`.
* A check in `selftest`: nothing checks a skill's prose; the proof is a run
  (`docs/05` §6).
* An ADR: reversing this is deleting a section, a paragraph and a row.

**Done when.** Every line ticked; the two greps that came back short are the
two divergences recorded below, both decided by the Contract.

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what `propose-asks-only-what-no-file-answers` left; `focus-kit install .`
  run here last, after that delivery is `[x]`.
* [x] `grep -n "^## Close" skills/propose/SKILL.md` prints one line; `grep -n
  "already ran" skills/apply/SKILL.md manuals/process.md` prints the
  paragraph and the §5 clause; `grep -n "first thing typed"
  manuals/process.md docs/00-Product.md` prints §5 and Building it.
* [x] Proof: in `~/Downloads/vaulted` as `propose-asks-only-what-no-file-answers`
  leaves it, `focus-kit update ~/Downloads/vaulted`, then in a clean session
  `/propose <slug>` on the first `[ ]` line of its queue, the stakeholder
  answering as the owner would; its last message ends with the two lines.
  Then, in that same session, `/apply <slug>`: the stop line and nothing
  else, `git status --short` equal before and after. `git reset` there,
  nothing committed; the page stays. The done page carries both closings
  verbatim and names the transcript file; a missing line is red, and the
  fix is a queue line, never an edit of this page. What the run produced
  wins over this page.
* [x] The `docs/03` row present; the two `docs/00` clauses; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

`graph: explain "skills/propose/SKILL.md" named the file's four sections,
affected "skills/propose/SKILL.md" named 0.` The graph was current
(`built_at_commit` `6769d868`, equal to `HEAD`; post-commit hook installed),
so the procedure said nothing. The skill is a document node whose only edges
are the headings it contains, and nothing imports or calls it, which is what
a skill is: a file a session reads. So the slice was read from the page,
from `docs/05-Process.md` and from the four files the Contract names.

### What was built

`skills/propose/SKILL.md`, a `## Close` section between Write and Never: the
three things to list (the page, the queue line and its new mark, the
`docs/03-Domain.md` row when a term was added), the "nothing staged, nothing
committed" line with its reason, then the reason clause for the new session,
then the block, last.

`skills/apply/SKILL.md`, one paragraph after "Implement ... in this session,
completely": `/apply` is the first thing typed in its session; when the
conversation already holds a `/propose`, an `/initialize` or an `/apply`
before this one, the stop line and nothing else, before Read first.

`manuals/process.md` §4, the queue sentence gains "and its last words name
the new session to type `/apply` in"; §5, "in a clean session" gains "one
where `/apply` is the first thing typed; when it is not, it says so in one
line and stops".

`docs/00-Product.md`, Defining a delivery: "and ends by naming the session
`/apply` runs in"; Building it: "one in which it is the first thing typed,
and when it is not it says so and stops".

`VERSION` `0.16.0` to `0.17.0`.

### What diverged from the plan

**The two skills say `$ARGUMENTS`, not `<slug>`.** The States section of
this page shows `/apply <slug>` and `work/<slug>.md`, which is what the page
has to write to be readable. In the skill files those are `$ARGUMENTS`, the
convention the three skills already use, substituted across the whole file,
code block included. Written with a literal `<slug>` the closing block would
print `<slug>` at the one moment the person is about to type the command,
which is the failure this delivery exists to remove.

**The `docs/03-Domain.md` row was already there, and its stop line was one
clause short.** The row is "written by this page" and `/propose` had already
written it, in the working tree, unstaged. Read back against the Contract it
agreed on every point but one: it quoted the stop line as `open a new one
and type /apply <slug>`, without `(/clear, or a new terminal)`. The Contract
and the States section both carry the parenthesis, and the parenthesis is
the whole practical content of the line in Claude Code. The row was aligned
to the States line. Nothing else there was touched.

**`grep -n "already ran" skills/apply/SKILL.md manuals/process.md` prints
one line, not two.** "Done when" expects it to print "the paragraph and the
§5 clause". The Contract quotes the §5 clause word for word, and the words
it quotes are "one where `/apply` is the first thing typed; when it is not,
it says so in one line and stops": no "already ran" in them. The Contract is
the section that must be exact (`docs/05` §3), so the clause is as the
Contract wrote it and the grep prints the `skills/apply/SKILL.md` paragraph
alone. The §5 clause is covered by the other grep, `first thing typed`,
which "Done when" already points at §5 for. Recorded, not resolved by
editing the manual into a phrasing the Contract did not ask for.

**`docs/00-Product.md`, Building it, says "the first thing typed", not "the
first command typed".** The Contract quotes "in which it is the first
command typed"; "Done when" greps `first thing typed` across
`manuals/process.md` and `docs/00-Product.md` and expects both. The
`docs/03-Domain.md` row, the vocabulary, defines the term as "one in which
`/apply <slug>` is the first thing typed", and this repository holds a term
to one phrasing everywhere (`docs/03`, Scratch repository). So the document
uses the vocabulary's words, which is also what makes the grep print both
lines.

**Two lines were rewrapped to keep a phrase on one line.** `manuals/process.md`
§5 and `docs/00-Product.md`, Building it, both wrapped between "first thing"
and "typed" at first, and a `grep` over lines cannot see a phrase split
across two. The wrapping changed; no word did.

### What was dropped

Nothing. Every line of the Contract is in.

### Decisions taken

No ADR, as the page said: reversing this is deleting a section, a paragraph
and a row.

### The verify command

```
focus-kit 0.17.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

Run after `focus-kit install .`, which is the order check 6 requires.
`grep -n "^## Close" skills/propose/SKILL.md` prints line 88; `grep -n
"already ran"` prints line 14 of `skills/apply/SKILL.md`; `grep -n "first
thing typed"` prints line 180 of `docs/00-Product.md` and line 96 of
`manuals/process.md`.

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.17.0` in, over the `0.16.0`
the previous delivery left. `HEAD` there is `f6e685c`; the working tree is
as that delivery's run left it, `work/em-dash-sweep.md` included; the first
`[ ]` line of its queue is `sitemap-complete`.

`git status --short` there, before the run, is the fourteen lines the
previous delivery left: `.gitignore` modified, `.claude/`, `.graphifyignore`,
`CLAUDE.md`, the seven `docs/0*` files, `docs/adr/`, `docs/manuals/` and
`work/` untracked. That is the "before" the `/apply` turn is compared
against.

The closing is read as a shape, not as English: the last two lines of the
`/propose` turn name the new session and carry the literal
`/apply sitemap-complete`, and the `/apply` turn is one line with no tool
call. The stakeholder writes in Portuguese and the skills answer in the
language the person writes in, so the rendering is recorded as it came.

A clean session ran `/propose sitemap-complete`, the stakeholder answering
as the owner would, **Not now** at the Graph confirmation (`no graph this
session; reading files directly`). Transcript:
`~/.claude/projects/-Users-jckodel-Downloads-vaulted/cd19fffc-b3d0-42b1-9f1b-35969daa94ee.jsonl`,
turn 8 for the `/propose`, turn 198 for the `/apply`.

**The closing of `/propose`, the last thing the session said**, verbatim:

~~~
Written: `work/sitemap-complete.md`; `docs/06-Queue.md` line marked `[>]`;
`docs/03-Domain.md` row Blog post (updated, no new term). Nothing staged,
nothing committed.

Open a new session (`/clear` here, or a new terminal) and type:
```
/apply sitemap-complete
```
~~~

**Then, in that same session**, two more turns before the guard was tested:
`/export` and a `! git status --short`. Then `/apply sitemap-complete`, its
whole output:

```
this session already ran `/propose`; open a new one (`/clear`, or a new terminal) and type `/apply sitemap-complete`

Nada foi lido, nada foi construído, nada foi preparado no index.
```

**Zero tool calls in that turn**, counted in the transcript: no `Read`, no
graph procedure, nothing. `git status --short` printed the same fourteen
lines before and after, the index empty both times, so `git reset` had
nothing to undo; `HEAD` is still `f6e685c` and the page
`work/sitemap-complete.md` stays where the `/propose` wrote it.

### What the proof found, and the run wins

* **The guard held across two intervening turns, not just the next one.**
  The page predicted the minimal case, `/apply` at the turn right after
  `/propose`. What ran had an `/export` and a shell turn in between, and the
  guard still fired. That is the stronger case and it is the one measured.
* **The stop line came out with one sentence after it, not alone.** States
  says "its whole output" is the one line. The run added `Nada foi lido,
  nada foi construído, nada foi preparado no index.` The skill's paragraph
  ends `and stop, before Read first: nothing read, nothing built, nothing
  staged`, and the session read the clause after the colon as something to
  say and not only as a constraint on itself. The constraint held anyway,
  which is what the tool call count proves. The sentence is true, it is in
  the person's language, and it is the answer to the question the stop line
  raises. So the page's States was wrong about the line count and the run
  wins. Recorded, not ordered: whether the skill should be tightened to say
  one line and nothing else is the stakeholder's to put in the queue
  (`docs/03-Domain.md`, First target).
* **The command came out inside a fenced block.** States shows
  `/apply <slug>` as a bare last line; the run rendered the two lines as
  prose plus a fenced `/apply sitemap-complete`. The skill's block is one
  fence and the session split it, which is what a session does with
  something meant to be copied. The two lines are there, in order, last.
  Nothing to change.
* **The reason clause was not printed, and should not have been.** It is
  written in the skill as the prose that introduces the block, so it tells
  the session why the block is last without becoming output. The Behaviour
  bullet asks for the reason "in one clause" and States does not carry it;
  the run agrees with States.
* **`$ARGUMENTS` was the right call, and this is where it shows.** Both
  closings carry the literal `sitemap-complete`. Written with a `<slug>`
  placeholder the person would have read `/apply <slug>` at the one moment
  the delivery exists to fix.
* **The `docs/03` placeholder resolved to an updated row, not a new one.**
  States offers `row <Term> (or: no new term)`; the run wrote `row Blog post
  (updated, no new term)`, because that session widened an existing row
  instead of adding a term. The third case the placeholder did not name, and
  the session named it correctly without help.

### A parallel session

A `/propose` session wrote `work/propose-does-not-fix-what-it-cannot-run.md`,
added the `Contract` row to `docs/03-Domain.md` and turned that queue line to
`[>]` while this delivery ran. None of the three is staged here: one
delivery, one commit (`docs/05` §7). The queue line was staged at `[ ]` and
left at `[>]` in the working tree, so that session finds it as it left it,
and its `docs/03` row waits for its own apply. This is the fifth time it
happens, after `graph-answers-structure`,
`initialize-asks-for-the-proof-tool`, `every-term-enters-03-first` and
`propose-asks-only-what-no-file-answers`, and the handling is the same.

### Environments

| Environment | Version |
|---|---|
| Kit source (`skills/`, `manuals/`, `config/`, `bin/`) | `0.17.0`, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | `0.17.0`, in sync (`selftest` green, check 6 empty) |
| Machine (`~/.local/bin/focus-kit`) | the CLI untouched, a symlink to the kit source; the global `/graphify` skill at graphify `0.9.63` |
| First target (`~/Downloads/vaulted`) | `0.17.0`, nothing committed |
| Target repositories (anyone else's) | untouched; they move on `focus-kit update <path>`, run by their owner |
