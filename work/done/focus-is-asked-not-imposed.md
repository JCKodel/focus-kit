# focus-is-asked-not-imposed

**Goal.** A person initializing a repository chooses, one question per
Practice, how the code is structured, where rules live, how errors travel
and what is tested, with FOCUS's answer offered first and never assumed, so
`docs/01` §3 says what a slice has here and `/propose` and `/apply` read
that table instead of the manual. Measured (`docs/06-Queue.md`, this line):
the first target's `docs/01` wrote a `features/` target layout and a
migration line per slice into a repository that never chose it, and the
project the kit came from removed the four pieces on purpose.

**Behaviour.**

* `/initialize` asks the four Practice questions, brownfield and greenfield,
  in one `AskUserQuestion`, each explained in a line: structure, vertical
  slices or layers; rules, pure use cases behind an orchestrator or where
  they sit today; errors, values or exceptions as flow; tests, a test per
  piece or the project's own policy. FOCUS's answer is the first option of
  each. On brownfield the third option is what the code does today, quoted
  from the sixth reading with the file cited, and the question is asked even
  when that coincides with FOCUS's answer: code is today's fact, not the
  rule (`docs/03`, Decided matter).
* The answers become the Practice table in `docs/01` §3. The pieces table
  below it keeps the pieces the answers give; a piece they remove reads
  "does not exist" with the reason, the way this repository's own §3 does
  (first occurrence, ADR-0003).
* The target's `CLAUDE.md` lists the practices chosen, one line each,
  pointing at `docs/01` §3. When all four are FOCUS's, the one line reads
  FOCUS: the name for saying yes to all of them.
* The queue gets a migration line per slice only when the structure answer
  is slices and the code is by layer.
* A review run whose `docs/01` §3 has no Practice table asks the four
  questions and proposes the edit, the way a §6 that names no tool gets the
  Proof tool question (second occurrence; the first is
  `initialize-asks-for-the-proof-tool`, so the rule is stated once for both).
* `/apply` builds each piece where `docs/01` §3 says, reads of `focus.md`
  only the sections the yes answers name, and writes the tests the tests
  answer names. `/propose` names on the page the pieces that table gives.
* FOCUS and "errors are values" leave the house rules. `manuals/focus.md`
  does not change.

**Contract.** Kit-owned unless said; a target receives it on `update`.
Builds on `commands-read-sections-not-manuals`, applied first: the reads of
`focus.md` that page names stay named and become conditional.

* `skills/initialize/SKILL.md`: the Practice questions, written once here
  and asked as written, one `AskUserQuestion` of four questions, each with
  FOCUS's answer first, the other second, and on brownfield "what the code
  does today" third. Brownfield: in the paragraph of what the readings
  cannot answer, before the Proof tool question. Greenfield: a round of its
  own after Stack. Review: when `docs/01` §3 has no Practice table. In Step
  2, "describe what is, then what should be" and the migration-per-slice
  sentence gain their condition; the opening sentence stops calling the
  architecture FOCUS.
* `templates/docs/01-Architecture.md` §3: heading `3. The practices in this
  codebase`; first a table `Practice | Answer | Here it is`, four fixed rows
  in the questions' order, then the pieces table as today for the pieces the
  answers give. The intro sentence "The architecture itself is FOCUS" says
  instead that §3 holds the answers. §4, §6, §8: init comments conditional
  on the answers; headings stay.
* `templates/CLAUDE.md`: the FOCUS and "Errors are values" lines leave the
  fixed list for an init comment: one line per practice chosen, or the FOCUS
  line as written today when all four are yes.
* `templates/docs/04-Conventions.md` §4 and §5: init comments conditional on
  the errors and tests answers; the §5 rows are the pieces `docs/01` §3
  gives. `templates/docs/05-Process.md` §3, Slice: "which of the four
  pieces" becomes the pieces `docs/01` §3 says a slice has.
  `templates/docs/06-Queue.md`: the migration-per-slice comment gains its
  condition.
* `manuals/process.md` §3, brownfield: the migration sentence conditional;
  §5 item 2: every piece in its place as `docs/01` §3 says; §6: the FOCUS and
  "Errors are values" bullets leave, and one sentence says the four
  practices are asked by `/initialize`, live in `docs/01` §3, and that FOCUS
  is the name for four yes.
* `skills/apply/SKILL.md`, Read first item 4: `docs/01` §3 first; of
  `focus.md`, per yes: rules, §2, §3, §10; errors, §5; structure, §6; tests,
  §8 at Build; nothing for a no. Build: "Rules go in the use case" and
  "Errors are values" become each piece where `docs/01` §3 says and errors
  as that table answers; the test bullet the same. `skills/propose/SKILL.md`,
  Write: "the four pieces" becomes the pieces `docs/01` §3 gives.
* This repository, project-owned: `docs/00` Purpose and Positioning stop
  saying built on FOCUS and say FOCUS is what the kit teaches and offers,
  per practice; `docs/01` §3 gains the Practice table with the answers
  ADR-0003 already gives (one file, no rules, `warn` and `die`, `selftest`);
  `docs/03`: House rule row without FOCUS and errors, FOCUS row and Practice
  row written by this page; `docs/adr/ADR-0006`, slug of this delivery
  (asked 2026-09-17); `docs/06` line `[x]`.
* `VERSION`: one minor above what the file holds.

**Slice.** `skills/initialize/SKILL.md` and its five templates,
`manuals/process.md`, `skills/apply/SKILL.md`, `skills/propose/SKILL.md`,
kit-owned; this repository's `docs/`, project-owned. `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), affected named 0;
explain "manuals/process.md" named 1, affected 0; explain
"skills/initialize/templates/CLAUDE.md" named 1, focus.md, affected 0`.
Nothing in `bin/focus-kit`, `manuals/focus.md`, `manuals/graphify.md` or
`config/`: no function row of `docs/01` §3 here changes. No FOCUS pieces
(ADR-0003).

**States.** The CLI prints nothing new. `/initialize` gains one question,
asked as written; a review run whose `docs/01` §3 has the table asks nothing.

**Visual reference.** No UI. The table `docs/01` §3 receives, rows fixed,
answers the run's:

```
| Practice  | Answer                                                        | Here it is |
|---|---|---|
| Structure | vertical slices / layers                                      | |
| Rules     | pure use cases behind an orchestrator / where they sit today  | |
| Errors    | values / exceptions as flow                                   | |
| Tests     | a test per piece / the project's own policy                   | |
```

**Out of scope.**

* The greenfield stack default (C# on .NET, a mediator as orchestrator):
  `manuals/process.md` §3 says it is defaulted, not asked.
* `manuals/focus.md`: the manual that teaches it (`docs/06`, this line).
* A fifth practice (composition root, CQS): no run asked for one; the
  second concrete need adds a row.
* Deriving the answers from the code without asking: code is today's fact.
* Four `AskUserQuestion` calls: one call carries four, the round's ceiling.
* Targets initialized before this version: a review run there is the
  person's to run; no migration notion (`docs/00`, open decision 5).

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor
  above what the file holds; `focus-kit install .` run here last.
* [x] One `grep -n` for `docs/01` §3 prints the three skills.
* [x] Proof, greenfield: `/initialize` in a scratch repository on a
  fictional domain, at least one practice answered with the non-FOCUS
  option. Green: `docs/01` §3 holds the table, the pieces table says "does
  not exist" for what the answers removed, `CLAUDE.md` lists the practices,
  no init comment survives. Then `/propose` on its first queue line and
  `/apply` on that page, each in a clean session, `/apply` stopped before
  Build: the Slice section and the manual reads follow the table.
  *(All three ran. Green, except that the `focus.md` byte ranges `/apply`
  read were not captured; what those reads exist to produce is proven by
  what it built. See Record.)*
* [x] Proof, first target (`docs/05` §5): `focus-kit update
  ~/Downloads/vaulted`, then `/initialize` in a clean session, a review run,
  the stakeholder answering as the owner would, watched through the Practice
  questions and the proposed edits to `docs/01` §3, `CLAUDE.md` and the
  queue's migration lines. The all-yes FOCUS line is proven by whichever run
  says yes to all four, or by a second scratch when neither does. `git
  reset` there, nothing committed. What the run produced wins; red is a
  queue line, never an edit of this page.
  *(Ran twice: once on the superseded three-option shape, which is what found
  it, and once on the shape that ships. The all-yes FOCUS line is still
  unproven, and so is the two-patterns disclaimer. See Record.)*
* [x] ADR-0006; the `docs/00`, `docs/01` §3 and `docs/03` edits; the
  `manuals/process.md` §6 sentence; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## Record

**What the graph answered.** `graph: explain "skills/initialize/SKILL.md"
named 1 file (8 sections), affected named 0`. The same answer the page
carries, so nothing widened. `manuals/process.md` and the templates were not
re-asked: the page already holds their answers and none of them changed.

**The four questions, as they came out.** The page named the practices and
their two answers; the run settled the wording. One `AskUserQuestion`, four
questions, options labelled exactly as the Answer column of `docs/01` §3
receives them: `Vertical slices` / `Layers`; `Pure use cases behind an
orchestrator` / `Where they sit today`; `Values` / `Exceptions as flow`; `A
test per piece` / `The project's own policy`.

**The brownfield shape diverged from the page, on the stakeholder's word,
mid-run.** The page says the brownfield question gets **a third option**,
"what the code does today", beside FOCUS's answer and the named alternative.
That is what shipped first and it was wrong, for a reason the page could not
see and a run could: on a brownfield repository the named alternative and
what the code does today are usually the same option, so the menu offers the
same answer twice and teaches the person that the question is a formality.

What ships instead: on a brownfield repository the **question itself** states
what the sixth reading found, with the file cited, and there are two options,
FOCUS's answer naming how it differs from today, and keeping today's,
summarized in the reading's words. Greenfield keeps the bare question and the
named alternative. The stakeholder's reason, in their words: the person
answering may be a developer who joined last week, and the question is where
they see where the repository stands before choosing whether to migrate.

Two things came with that, asked for in the same message and both new to the
page:

* **Every FOCUS option says what it buys**, in one line. A use case is
  described by what it is and by the fact that it is tested by calling it
  with literals; values are described by the `catch` three frames up that can
  no longer swallow a refusal. Offering FOCUS first without saying what it
  buys is offering a name.
* **The two-patterns disclaimer**, said out loud on a brownfield repository
  before the person answers: choosing FOCUS where the code does otherwise
  leaves two patterns in the tree until the migration lands, which is normal
  while migrating and bad otherwise. It is said on a promise, so the promise
  is written into Step 2 and into the queue template: a practice answered
  against what the code does today gets at least one migration line, and the
  per-slice migration stays what the page scoped it to, the structure answer.

`ADR-0006` carries the new shape and keeps the three-option version as an
alternative considered and lost during this run. `docs/03`, Practice, says
the same. The greenfield proof below is unaffected: it asked two options per
question, which is what greenfield still does.

**What the page assumed and the file did not do yet: the sixth reading.**
The page says the brownfield third option is "what the code does today,
quoted from the sixth reading with the file cited". Reading 6 observed the
structure and whether the four pieces exist, and nothing else: no reading
looked at how a failure travels, and the test framework came from readings 2
and 3 without anyone looking at what the tests cover. Two of the four third
options therefore had nothing to quote. Reading 6 now names four
observations and the file each one is read in, which is the quote's source.
Recorded rather than treated as scope, because the page assumed the reading
already produced it.

**Three edits the Contract did not name, made because the page's own rule
reaches them.** `manuals/process.md` §2, the file list, said `01-Architecture.md`
holds "the four FOCUS pieces"; §3's greenfield bullet listed what
`/initialize` asks and the practices were missing from it; §5 item 1
described `/apply` reading "the FOCUS manual, its table, its four pieces and
its anti-patterns" unconditionally, which is exactly the read the Contract
says becomes conditional. All three are the same manual and the same
sentence-level fact.

**One line left as it was, on purpose.** `templates/docs/04-Conventions.md`
line 4 still reads "the FOCUS review rules in `docs/manuals/focus.md`". It
is a pointer to a manual and not an assertion about the project, the
Contract does not name it, and `/apply` does not widen a page. A target that
answered no to all four still receives that line, which is the one place the
delivery leaves an unconditional FOCUS mention in a template. If it grates
in a real run, it is a queue line.

**Headings.** Only one heading changed, `docs/01` §3, which the Contract
names: `3. The four pieces in this codebase` became `3. The practices in
this codebase`, in the template and in this repository's own `docs/01`, so
the dogfood copy is the example. `docs/01` §6 and `docs/04` §4 keep
"Errors are values" as headings and carry the condition in their init
comment, because the Contract names init comments there and says headings
stay. A project that answered exceptions as flow gets a §6 that says how its
exceptions travel under a heading that names the other answer. That is the
narrower reading of the page and it is what shipped; the wider one is a
queue line, not a silent edit.

**This repository's own answers.** `docs/01` §3 now opens with the Practice
table, filled with what ADR-0003 already decided: structure, neither slices
nor layers but one file; rules, none, because nothing here decides; errors,
values, which is `warn` and `die` (§6); tests, the project's own policy,
which is `selftest`. Three of the four are not FOCUS's answer. That is the
point of writing them: a kit that offered a choice and then assumed the
answer in its own documents would teach the opposite of what it ships.

**ADR-0006** carries the decision. Its Context names the three cases: the
first target's unasked `features/` layout, the project the kit came from
having removed the four pieces on purpose, and this repository's own §3. Its
Decision carries the brownfield shape above, and its Alternatives record the
three-option menu as lost to this run.

**The proof, greenfield.** A scratch repository at
`<scratchpad>/greenfield`, `git init` plus `focus-kit install .` at 0.21.0,
and the nine documents written by following the installed
`.claude/skills/initialize/SKILL.md`. The fictional domain is **escala**, a
shift-swap board for one clinic's nursing staff.

One honest qualification on "a real run": only round 4, the Practice
questions, was put to the person. Step 0 and rounds 1 to 3 and 5 to 7, the
Proof tool question included, were answered by this session as the fictional
stakeholder, because the domain is fictional and inventing it is what made
the run possible at all. The part under test was answered by the person, and
the rest is a fixture.

The four Practice answers, three of them against FOCUS:

```
Structure  layers
Rules      where they sit today
Errors     values
Tests      the project's own policy
```

Green on all four criteria the page names:

* `docs/01` §3 holds the Practice table, four rows, answers as given.
* The pieces table below it reads `does not exist` for Orchestrator and for
  Use case, with the reason in the paragraph under it, and keeps View and
  Repository with where each lives. Nothing was filled in for symmetry.
* `CLAUDE.md` lists the four practices, one line each, each pointing at
  `docs/01-Architecture.md` §3. The FOCUS line did not appear, which is
  correct: it is reserved for four yes.
* No `<!-- init:` survives anywhere under `docs/` or in `CLAUDE.md`, and no
  em dash either.

Three things the run produced that the page did not predict, and they are
what the run found rather than what was expected:

* `docs/04` §5 came out with four rows written from the project's own
  policy and none of the template's four, which is what the new init comment
  asks for when the tests answer is not a test per piece. The policy is two
  lines above the table and the rows follow it.
* `docs/01` §4, the "A slice" section, came out as the layout of one change
  rather than of one feature, and says so in its first sentence. The heading
  stayed, which is what the template's comment now directs.
* `ADR-0001` came out arguing the three non-FOCUS answers with a revisit
  trigger for each, unprompted by the template. A greenfield project that
  declines FOCUS has something to explain, and the ADR is where it goes.

**The proof, greenfield, `/propose`: green.** The stakeholder ran `/propose
roster-arrives` in a clean session in that scratch. The scope did not fit on
one page, so the run split it and wrote `work/a-nurse-signs-in.md` instead,
which is `docs/05-Process.md` §1 working and not a finding about this
delivery. What this delivery is proven by is the **Slice** section that came
out:

```
The pieces `docs/01-Architecture.md` §3 names, in the order a request crosses
them:

* **View**: `app/page.tsx`, a server component, and the components it needs.
* **Server action**: `lib/actions/load-signed-in-nurse.ts`, which reads the
  session, calls the query, decides and returns.
* **Repository**: `db/nurses.ts`, one query module for the `nurses` entity.
```

Three things in that, and the third is the one worth the delivery:

* It says **"the pieces `docs/01-Architecture.md` §3 names"**, in those
  words. The page's source is the table, not the manual.
* Orchestrator and Use case are absent, and the middle piece is called
  **Server action**, which is the project's own word from the Rules row of
  its §3. The run did not translate the project back into FOCUS's
  vocabulary; it used the table's.
* The run first wrote `There is no orchestrator and no use case, by decision
  (docs/01-Architecture.md §3, ADR-0001)` and then **deleted those three
  lines** before finishing. That is `skills/propose/SKILL.md`'s new sentence
  landing exactly: a piece the table says does not exist is not named on the
  page, not even to say it is absent. Naming it is how it comes back.

Its Tests paragraph follows `docs/04-Conventions.md` §5, the project's own
policy, and not the per-piece list, which is the tests answer landing in the
other command.

**The proof, greenfield, `/apply`: ran, and proves the Build half.** The
first attempt, `/apply roster-arrives`, stopped before Read first item 1,
correctly: that page does not exist, because `/propose` wrote a different
one. The second, `/apply a-nurse-signs-in` in a clean session, built the
whole delivery. What came out of it, against the table:

* The pieces built are **View** (`app/page.tsx`, `components/NurseCard.tsx`,
  `components/RefusalNotice.tsx`), the **server action**
  (`lib/actions/load-signed-in-nurse.ts`, which reads the session, calls the
  query, decides and returns) and the **Repository** (`db/nurses.ts`). No
  orchestrator and no use case were written, and none was proposed.
* Errors as values landed whole: `lib/result.ts` holds `Result<T, Refusal>`,
  `db/nurses.ts` is the one place a Prisma error becomes `Refusal("infra")`,
  and the page renders the refusal by its code.
* The tests are `lib/actions/load-signed-in-nurse.test.ts`, one per refusal,
  and `db/nurses.test.ts` against the container. That is the two-line policy
  of that project's `docs/04-Conventions.md` §5 and not the per-piece list of
  `focus.md` §8, which is the tests answer reaching the other command.

**What is still not literally captured** is the one mechanical fact the page
asks for: which byte ranges of `docs/manuals/focus.md` that session read.
Its transcript collapses the Read first calls. The behaviour those reads
exist to produce is proven by the three points above; the count is not. Said
plainly rather than inferred.

**The proof, first target: ran on the superseded shape, and that is what
found the shape.** `focus-kit update ~/Downloads/vaulted` ran before the
stakeholder's message about the brownfield questions, and it was not run
again after the skill changed, so the review run there asked the
**three-option** version. That is this session's mistake and it is recorded
as one: a skill edited without a `VERSION` bump leaves a target holding
different bytes under the same number, and nothing reports it, because
`doctor` fingerprints against the manifest that install wrote.

The run is worth more than a clean one would have been. Its four questions
came out like this, and the third option is quoted from the sixth reading
with file and line, which is the part that worked:

```
Regras: onde vivem as regras de negócio?
1. Use cases puros atrás de um orchestrator (FOCUS)
2. Onde estiverem hoje
3. Manter o de hoje: dentro do componente
   saveEntry decide o que é entrada válida (components/vaulted-app.tsx:469),
   shouldShowBackupReminder decide quem está em risco (:318), createSnapshot
   decide um por mês (:137).
```

Options 2 and 3 are one answer written twice, one abstract and one concrete.
On all four questions. That is the redundancy the stakeholder predicted from
reading the page, demonstrated by a run, which is why the two-option shape is
what ships and why `ADR-0006` records the three-option menu as lost.

**One thing the run produced that nobody asked for, and it ships.** Every
option named what choosing it does to the queue, by slug: `Camadas` said it
"remove o Milestone 3 da fila"; `Manter o de hoje: falha engolida` said it
"cancela result-type e vault-repository na fila"; `Manter o de hoje: nenhum
teste` said it "cancela a entrega testing-setup e a tabela de docs/04 §5";
and the FOCUS option said "a fila continua como está". Someone choosing
between two architectures is choosing between two queues, and the queue is
the half of the consequence they can already read. It is now a paragraph of
the Practice questions, conditional on there being a queue: a greenfield
repository has none yet.

**The proof, first target, on the shape that ships: green.**
`~/Downloads/vaulted` was brought to the two-option shape with `focus-kit
update` and the stakeholder ran `/initialize` there again, a review run in a
clean session. The four questions came out like this, and this is the record
of what the delivery actually produces:

```
O código está organizado por papel técnico: app/ com as rotas, components/,
lib/, sem features/, e components/vaulted-app.tsx com 1349 linhas. Como ele
deve ser organizado?

1. Vertical slices
   Uma pasta plana por feature, guardando as peças daquela feature. O que
   compra: uma mudança numa feature abre uma pasta só, e apagar a feature é
   apagar a pasta. O que custa aqui: toda feature existente se move. Na fila:
   mantém o milestone 3 inteiro (entries-slice, snapshots-slice,
   backup-slice, settings-slice) e as linhas share-journey-slice e
   percentile-slice em Later.
2. Manter por camada
   Como está hoje: pastas por papel técnico, rotas com rotas, componentes com
   componentes, utilidades em lib/. O que compra: nada se move e todo mundo
   já sabe onde olhar. Na fila: o milestone 3 inteiro sai, share-journey-slice
   e percentile-slice saem de Later, e a ADR-0005 (FOCUS migrado por feature)
   passa a superseded.
3. Type something.
```

Every criterion the page and the two corrections name is in it:

* The question **states what the code does today**, with the path and the
  size, and the question is still asked. On Errors it is the sharpest:
  `Uma falha hoje não viaja: ela é engolida`, with four sites cited
  (`lib/storage.ts:38`, `:53`, `:87`, `lib/vaulted.ts:197`).
* **Two options**, and the third row is Claude Code's own `Type something`.
  The named alternative and "keep today's" are one option, which is the whole
  point of the correction: `Manter por camada / Como está hoje`.
* **What each option buys**, on both, in the option's own words.
* **The brownfield cost**, on the FOCUS option: `O que custa aqui: toda
  feature existente se move`.
* **What it does to the queue**, by slug, on both options of all four
  questions.

Two things the run did better than the text asked, and both were folded back
into it before this was committed:

* It wrote **what it buys on both options**, not only on FOCUS's. The text
  said "every FOCUS option"; a person comparing one purchase against one
  habit is not comparing. It now says each of the two, and `ADR-0006` says
  why.
* On Tests, option 2 went past the queue and named the decision it would
  undo: `testing-setup é cancelada, o que reverte uma decisão que o
  stakeholder tomou hoje`. The queue rule reached a `docs/00` open decision
  on its own. Left as it is: the rule as written produced it, and writing a
  second rule for it would be abstraction on the first occurrence.

**What is not in the capture:** the two-patterns disclaimer. It is supposed
to be one line said before the person answers, and what came back is the
question grid alone, so whether it was said is not recorded either way. It is
the one clause of the brownfield shape with no evidence behind it. Not
claimed as proven.

The other clause with nothing behind it is the `templates/CLAUDE.md` FOCUS
line, the one that replaces the four practice lines when all four answers are
the manual's. Every run on 2026-09-17 said no to at least one practice, so
that branch was never taken. Both are the queue line
`practice-questions-all-yes`, and one scratch answering yes four times closes
them.

Nothing was committed or staged in `~/Downloads/vaulted`.

**What this commit carries that is not this delivery.** A `/propose
language-question-says-what-it-governs` ran in another session while this one
was building, and it turned that queue line from `[ ]` to `[>]`.
`docs/06-Queue.md` is one file and this delivery had to write to it, so the
commit carries that mark. Its page,
`work/language-question-says-what-it-governs.md`, is deliberately **not**
staged: it belongs to that `/propose` and to its own commit. Between the two
commits the queue names a page the tree does not have, which is visible and
short lived, and the alternative was one commit holding two deliveries
(`docs/05-Process.md` §7).

**The second queue line this delivery leaves behind.**
`doctor-sees-an-unbumped-change` is not an artifact of an unusual workflow.
`docs/05-Process.md` §5 says the first target is taken through every delivery
while milestone 2 is open, so `focus-kit update` runs mid-delivery by design,
and that is exactly when a target ends up holding bytes the kit no longer has
under a number that still matches. It cost this delivery one whole proof run.

**Nothing was dropped** from the Contract. Every file it names changed, and
`bin/focus-kit`, `manuals/focus.md`, `manuals/graphify.md` and `config/`
were not touched, as the Slice said.
