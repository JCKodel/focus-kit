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

* [ ] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor
  above what the file holds; `focus-kit install .` run here last.
* [ ] One `grep -n` for `docs/01` §3 prints the three skills.
* [ ] Proof, greenfield: `/initialize` in a scratch repository on a
  fictional domain, at least one practice answered with the non-FOCUS
  option. Green: `docs/01` §3 holds the table, the pieces table says "does
  not exist" for what the answers removed, `CLAUDE.md` lists the practices,
  no init comment survives. Then `/propose` on its first queue line and
  `/apply` on that page, each in a clean session, `/apply` stopped before
  Build: the Slice section and the manual reads follow the table.
* [ ] Proof, first target (`docs/05` §5): `focus-kit update
  ~/Downloads/vaulted`, then `/initialize` in a clean session, a review run,
  the stakeholder answering as the owner would, watched through the Practice
  questions and the proposed edits to `docs/01` §3, `CLAUDE.md` and the
  queue's migration lines. The all-yes FOCUS line is proven by whichever run
  says yes to all four, or by a second scratch when neither does. `git
  reset` there, nothing committed. What the run produced wins; red is a
  queue line, never an edit of this page.
* [ ] ADR-0006; the `docs/00`, `docs/01` §3 and `docs/03` edits; the
  `manuals/process.md` §6 sentence; the queue line `[x]`.
* [ ] The last thing said is which environment is at which version.
