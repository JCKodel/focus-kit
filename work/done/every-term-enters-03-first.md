# every-term-enters-03-first

**Goal.** A person running `/initialize` gets documents that keep the rule
`docs/03-Domain.md` states about itself: no identifier in `docs/00`, `01` or
`06` that the terms table does not have. Measured on the first target
(`work/done/first-target-initialize.md`, finding 4): the `vault-repository`
queue line named `VaultRepository`, `LoadResult` and `SaveResult`, none in
the table, three documents after the run wrote "no delivery may name in code
a concept that is not here". Step 2 states the rule while writing and
nothing reads back.

**Behaviour.**

* `/initialize`, green or brown, after Step 2 has written the documents and
  before Step 3, runs the Read-back: every identifier `docs/00`, `01` and
  `06` name is in the Code column of `docs/03`, or one `grep` in the source
  tree decides. Found in the code: a row in `docs/03`, with what the code
  calls it. Not found: the sentence is rewritten in the table's terms, and
  the name waits for the `/propose` that defines that delivery. Greenfield
  has no code, so it is always the second.
* The kit's vocabulary needs no row: view, orchestrator, use case,
  repository, Result, slice, as `docs/manuals/focus.md` defines them. A name
  built on one, `VaultRepository`, is an identifier and goes through the
  rule above. A path, a file name, a command or a branch is not one.
* A review run (`docs/00-Product.md` exists) runs the same pass on the
  documents found, and each hit is a proposed edit, section by section.
* "Not now" at the graph changes nothing: the pass reads files and grep.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Three files kit-owned; a target receives them on `update`.
Applies after `initialize-asks-for-the-proof-tool`, which edits the same
skill and the `docs/05` template. `VERSION` reads `0.14.0` today, so that
page's numbers are one behind: it takes `0.15.0` and this one `0.16.0`.

* `skills/initialize/SKILL.md`, Step 2, one paragraph after the "Rules
  while writing" list, headed by the word Read-back: what it covers (`00`,
  `01`, `06`), what an identifier is here (a type, function, column, table
  or module; backticked or not; not a path, file name, command, branch or a
  term of `docs/manuals/focus.md`), the grep, the two outcomes, greenfield
  always the second. It ends by saying one line, the one under **States**,
  and by naming each identifier and what was done with it.
* Same skill, Step 0, the review paragraph: one sentence, the Read-back
  runs on the documents found and each hit is a proposed edit.
* `skills/initialize/templates/docs/03-Domain.md`, one sentence after "A
  new concept enters here first": the terms of `docs/manuals/focus.md` need
  no row; a name built on one of them is an identifier and does.
* `skills/initialize/templates/docs/06-Queue.md`, the init comment of
  milestone 1, one sentence: a line speaks in the terms of `docs/03`; an
  identifier it names is in that table, or the line says it in words and
  the term enters `docs/03` when `/propose` defines the delivery.
* `VERSION`: one minor up from what the delivery before leaves.
* This repository: `docs/03-Domain.md` carries the Read-back row, written
  by this page; `docs/06-Queue.md` line `[x]`. `docs/00` Initializing and
  `manuals/process.md` stay as they are: "asks only what the code cannot
  answer" and "a new term enters `docs/03` before" already say it.

**Slice.** One skill and two templates, kit-owned; this repository's
`docs/`, project-owned. Nothing in `bin/focus-kit`, `manuals/` or `config/`,
so no function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. In the session, one line after the
pass: `read-back: <n> identifiers in docs/00, 01, 06; <n> rows added; <n>
lines rewritten`, then one line per identifier touched, naming the document,
the identifier and which of the two happened. When nothing was touched, the
first line alone, ending `all in docs/03`. On a review run, the proposed
edits are shown like the others.

**Visual reference.** The lines as the session shows them, on the first
target as it was:

```
read-back: 9 identifiers in docs/00, 01, 06; 0 rows added; 1 line rewritten
  docs/06 vault-repository: VaultRepository, LoadResult, SaveResult are in no
  file; the line now reads "the vault goes behind a repository that returns
  a Result"
```

**Out of scope.**

* The same pass in `/propose`: its skill already says "use only terms from
  `docs/03`", and no run has been measured breaking it.
* `docs/02`, `04`, `05`, the ADRs and `CLAUDE.md`: `04` names identifiers
  as examples of a convention and the ADRs name a stack, not the domain.
* A FOCUS table in the `docs/03` template: `docs/01` and `04` say how each
  piece is named per stack, and the exemption sentence is one line.
* Exempting derived names such as `<Term>Repository`: the case measured was
  one, and the name did not exist in the code.
* A script: the CLI never reads a project-owned file (ADR-0002).
* An ADR: reversing this is deleting a paragraph.
* This repository's own documents: its `docs/03` already carries a FOCUS
  table for the same reason.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what `initialize-asks-for-the-proof-tool` left; `focus-kit install .` run
  here last, after that delivery is `[x]`.
* [x] `grep -n "Read-back" skills/initialize/SKILL.md` prints the Step 2
  paragraph and the Step 0 sentence; `grep -n "focus.md"
  skills/initialize/templates/docs/03-Domain.md` prints the exemption;
  `grep -n "docs/03" skills/initialize/templates/docs/06-Queue.md` prints
  the comment.
* [x] Proof: in `~/Downloads/vaulted`, `git checkout -- . && git clean -fd` so
  the tree is the clone's again, then `focus-kit update ~/Downloads/vaulted`,
  then `/initialize brown` there in a clean session, "Not now" at the graph.
  The transcript of the Read-back lines goes in the done page, and every
  PascalCase word in the `docs/06` it wrote is in the Code column of the
  `docs/03` it wrote, checked by grep. `git reset` there, nothing committed.
  What the run produced wins over this page.
* [x] The `docs/03` row present; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

graph: explain "skills/initialize/SKILL.md" named 1 file, affected named 0.
The skill is a document node whose eight edges are its own sections, and
nothing in this repository imports or calls it, which is what a skill is: a
file a session reads. So the slice was read from the page, from
`docs/05-Process.md` and from the three files the Contract names.

### What was built

`skills/initialize/SKILL.md` gained the Read-back in two places, exactly the
two the Contract names:

* **Step 2**, one paragraph after the "Rules while writing" list and before
  Step 3, headed by the word Read-back. It opens by naming why it exists:
  the pivot rule of that list is stated while you write and nothing reads it
  back. Then what it covers (`docs/00`, `01`, `06`), what an identifier is
  here (a type, a function, a column, a table or a module, backticked or
  not) and what is not (a path, a file name, a command, a branch, a term of
  `docs/manuals/focus.md`, the six named in line), that a name built on one
  of those terms is an identifier like any other, the `grep`, the two
  outcomes, greenfield always the second, and the two output lines. The
  exemption names seven terms and says the manual is the list, which is the
  proof run's doing: see "the run wins" below.
* **Step 0**, the review paragraph, one sentence: the Read-back runs on the
  documents found and each identifier it catches is a proposed edit.

`skills/initialize/templates/docs/03-Domain.md`, one sentence after "A new
concept enters here first": the manual's terms need no row, a name that
builds on one of them does.

`skills/initialize/templates/docs/06-Queue.md`, the init comment of
milestone 1, one sentence: a line speaks in the terms of `docs/03`; an
identifier it names is in that table, or the line says it in words and the
term enters `docs/03` when `/propose` defines the delivery.

`VERSION` `0.14.0` to `0.15.0`. This repository's `docs/03-Domain.md`
already carried the Read-back row, written by `/propose`; it was read back
against the paragraph and the two agree.

### What diverged from the plan

**The version numbers in the Contract were one ahead.** The page says
"`VERSION` reads `0.14.0` today, so that page's numbers are one behind: it
takes `0.15.0` and this one `0.16.0`". `initialize-asks-for-the-proof-tool`
landed at `0.14.0`, not `0.15.0`, so this delivery takes `0.15.0`. The
Contract's own rule ("one minor up from what the delivery before leaves")
and the "Done when" line ("one minor above what
`initialize-asks-for-the-proof-tool` left") both say `0.15.0`; only the
parenthetical prediction was wrong, and it was a prediction about a delivery
that had not run yet.

**The template's sentence carries no example name.** The Contract says "a
name built on one of them is an identifier and does", and `VaultRepository`
is the measured case. This template ships to every target the kit installs,
and a target should not receive another project's type name as the
illustration of a rule. The first wording used the placeholder
`` `<Term>Repository` ``; the final one says "a name that builds on one of
them" in words, for the reason under "the run wins" below.
`VaultRepository` stays where it belongs: the `docs/03` row of this
repository and this page.

**`focus-kit update` on a tree with no stamp.** The "Done when" asks for
`git checkout -- . && git clean -fd` in the first target and then `focus-kit
update`, and the clean removes `.claude/` and with it the version stamp. No
divergence: `install` and `update` are the same branch of the dispatch
(`bin/focus-kit`, `install|update`), so the update installed the whole tree
fresh and left the stamp at `0.15.0`. The clean also removed the target's
`graphify-out/`, 8 KB of a graph that was never built because the last run
answered "Not now"; the run below answers "Not now" again, so nothing was
lost.

### What was dropped

Nothing. Every line of the Contract is in.

### Decisions taken

No ADR, as the page said: reversing this is deleting a paragraph.

### Verify

`bin/focus-kit selftest` green, six checks. Check 6 was red before the
install, naming both numbers, which is the check doing its job:

```
error: check 6: the dogfood copy is at 0.14.0 and VERSION is 0.15.0 (run focus-kit install .)
```

After `focus-kit install .`, green:

```
focus-kit 0.15.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

The three greps of "Done when" print what they were asked to print:
`Read-back` at lines 65 and 233 of the skill, `docs/manuals/focus.md` at
line 33 of the `03` template, `docs/03-Domain.md` at line 17 of the `06`
template.

### Proof, the first target

`~/Downloads/vaulted` was taken back to the clone's tree with `git checkout
-- . && git clean -fd`, which removed the nine documents the previous
delivery's run had left there, and `focus-kit update ~/Downloads/vaulted`
put `0.15.0` in. A clean session then ran `/initialize brown`: brownfield
and English confirmed in Step 0, **Not now** at the Graph confirmation
(`no graph this session; reading files directly`), **None** at the Proof
tool question. So the pass ran with no graph, on files and grep alone, which
is what the page asked for.

The summary line, word for word as the session printed it:

```
read-back: 47 identifiers in docs/00, 01, 06; 14 rows added; 7 lines rewritten
```

The fourteen rows it added to `docs/03`, each one a concept the code already
had and the table did not: `DEFAULT_DATA`, `safeParseData`,
`idbGet`/`idbPut`, `convertToUSD`/`convertFromUSD`/`convertCurrency`,
`formatCurrency`/`formatMonth`/`formatOrdinal`, `saveEntry`/`deleteEntry`,
`saveSnapshotNow`/`createSnapshot`, `clearAll`, `VaultedApp`, the five view
pieces, the five theme helpers, `PostHogProvider`/`initPostHog`,
`ServiceWorkerRegister` and the cache name. Every row carries a `file:line`,
because the grep is what found it.

The seven lines it rewrote, each one a name nobody had written yet:
`docs/01` §3 twice (the per feature hook, the vault repository), `docs/01`
§6 once and `docs/06` three times, all four of the last group being the
three `Failure` variants. `docs/01` §3 now ends "Its code name enters
`docs/03-Domain.md` when `/propose vault-repository` defines it", which is
the rule saying itself in the document.

**The measured finding is closed.** The three names that made this delivery
exist are in none of the three documents the second run wrote:

```
$ grep -n "VaultRepository\|LoadResult\|SaveResult" docs/06-Queue.md docs/00-Product.md docs/01-Architecture.md
(none)
```

**The mechanical assertion.** Every PascalCase word in the `docs/06` the run
wrote, against the `docs/03` it wrote: two words, `IndexedDB` and `PostHog`,
both covered. `PostHog` sits in the Code column of the Analytics row, as
`PostHogProvider` and `initPostHog`. `IndexedDB` sits in the meaning column
of the Local store and Store access rows and in no Code column, which is the
honest result and not a miss: it is a browser API, not a name of this
project, and it reaches `docs/03` through the concept that uses it. The
queue that once named three types of a repository nobody had written now
names none.

### What the proof found, and the run wins

* **The numbers are not the page's numbers, by an order of magnitude.** The
  Visual reference predicted `9 identifiers; 0 rows added; 1 line rewritten`,
  read off the first target as it was. The run found 47, added 14 and
  rewrote 7. The page counted the identifiers of the documents the *previous*
  run had written; this run wrote its own, longer, documents first and then
  read those back. The prediction was of the wrong object. Nothing changes in
  the skill: the pass counts what it finds.
* **The per identifier lines came out grouped, not one per line.** The
  Contract asks the pass to end with "one line per identifier touched". With
  21 identifiers touched the session printed the summary line and then two
  grouped lists, added and rewritten, each naming the document. What it
  produced wins: the information the Contract asked for is all there, and 21
  lines would have buried the summary. The skill keeps the wording it has,
  because at the size the first target measured, one line each is still the
  right instruction and grouping is the session's judgement when the list is
  long.
* **A rewrite in `01` and `06` left `docs/04` stale, and the run fixed it.**
  `docs/04` §4 named the same three `Failure` variants, and the session
  rewrote it too, saying out loud that it did so for coherence and not by
  the rule. The Out of scope of this page keeps `docs/04` out of the pass,
  and that stays right: `04` names identifiers as examples of a convention.
  But a rewrite inside the three can leave a fourth document naming what was
  just removed, and "docs are living" is what covered it here. Recorded, not
  turned into a queue line, because it is the stakeholder's to order
  (`docs/03-Domain.md`, First target). Candidate slug:
  `read-back-follows-the-rewrite`.
* **`focus-kit update` after a full clean is an install.** Noted above under
  divergences: the two are the same branch of the dispatch, so the "Done
  when" sequence works as written and nothing in the CLI needs to change.
* **`Failure` is kit vocabulary and the exemption list did not say so.** The
  mechanical assertion was run a second time the way the skill defines an
  identifier, backticked or not, and not only on two-hump PascalCase. The
  backticked names in the target's `docs/06` are `formatCurrency`,
  `formatOrdinal`, `idbPut`, `safeParseData`, all four in the Code column,
  plus `formatter`, which is the absent tool of `docs/04` §3 and not a name
  of this project, and two file names. Bare, the queue names `Result` four
  times and `Failure` four times. `Result` was in the exemption; `Failure`
  was not, and `docs/manuals/focus.md` defines it in seven places as the
  typed error a Result carries. The run left it bare and added no row, which
  is the right outcome, so nothing was measured broken. What was wrong was
  my wording: both sentences listed six terms in a parenthesis that reads as
  closed. They now name `Failure` among them and say that the manual is the
  list, which is what the Contract said all along ("a term of
  `docs/manuals/focus.md`"). The skill and the `03` template were edited
  after the proof run and reinstalled; `selftest` green again. The proof was
  not re-run for the new wording, because what it proved is that the
  template's prose is copied and not filled, and only the prose changed.
* **The template's example lost its angle brackets.** The first wording
  illustrated the rule with `` `<Term>Repository` ``, and the proof run
  copied it through verbatim into the target's `docs/03` line 34, which is
  the outcome that was wanted: the session read it as generic notation and
  did not fill it. It still sat in body prose of a template whose other
  angle brackets (`<name>`, line 3) are fill-ins, so a later run filling it
  would have put in `docs/03` prose exactly the kind of name the pass says
  nobody has written yet. The rewording above says the same thing in words,
  "a name that builds on one of them", and the hazard is gone with it.
  `VaultRepository` stays where the measurement put it: this repository's
  `docs/03` row and this page.

### What the proof found beyond its own scope

`graphify hook status` in the target printed a fifth state that the four
branches of `docs/manuals/graphify.md` §Ensuring the graph do not name:
`merge driver: partially registered (git config set, .gitattributes line
missing)`. The procedure only reads the `post-commit` line, so nothing
misbehaved and the session correctly said so as a note. This repository
shows `merge driver: not registered` for the same reason. Recorded here, not
ordered. Candidate slug: `graphify-merge-driver`.

`git reset` was run in `~/Downloads/vaulted`: nothing staged, nothing
committed, the working tree left as the run left it.

### A parallel session

A `/propose` session wrote `work/propose-asks-only-what-no-file-answers.md`
and turned its queue line to `[>]` while this delivery ran. Neither is
staged here: one delivery, one commit (`docs/05` §7). The queue line was
staged at `[ ]` and left at `[>]` in the working tree, so that session finds
it as it left it. This is the third time it happens, after
`graph-answers-structure` and `initialize-asks-for-the-proof-tool`, and the
handling is the same.

### Environments

| Environment | Version |
|---|---|
| Kit source | `0.15.0` |
| Dogfood copy | `0.15.0`, in sync (`selftest` green, check 6 empty) |
| Machine | symlink, follows the source; global `/graphify` skill at the package's version |
| First target (`~/Downloads/vaulted`) | `0.15.0`, initialized by the proof run, nothing committed |
| Other targets | untouched, until their owner runs `focus-kit update` |
