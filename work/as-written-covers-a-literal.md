# as-written-covers-a-literal

**Goal.** A fixed text of the kit reaches the person in the conversation's
language whatever mark sets it off in the file it is written in, because the
two rules that ask for it say what a mark is and close the list of what stays
in English. Measured on 2026-09-17 in the scratch of
`asked-as-written-says-which-language`, one Portuguese session at 0.22.2: the
no screen line came out in English inside a Portuguese sentence, and the Graph
confirmation of `manuals/graphify.md` asked its question and its three
descriptions in Portuguese while its three option labels stayed English
(`docs/06-Queue.md`, this line).

**Behaviour.**

* The paragraph of the Language section of `skills/initialize/SKILL.md` that
  states the As written rule gains what it does not say today: a mark in that
  file sets a text off so its start and its end are visible, and is never an
  instruction to reproduce the bytes between the marks.
* The same paragraph closes the list of what stays in English. It holds the
  kit's own terms, every path and every file name today; it gains a command
  and a quote of what a tool printed (asked, 2026-09-17), and it says that an
  option label is not one of them and is said in the person's language.
* The sentence of `manuals/graphify.md` §Ensuring the graph that says the
  Graph confirmation is written there once and asked as written holds the same
  rule for what that section owns: the question, its three option labels and
  their descriptions reach the person in the conversation's language, and the
  count line the question quotes stays as graphify printed it.
* The mark is not named as the cause, because it is not one. In the measured
  session the same backticks produced both results: the Language question, the
  four Practice questions and the confirmation's own question came out
  translated, the no screen line did not, and bold behaved the same way across
  the two files. What each rule says is what a mark is not, and what the
  closed list holds.
* The five texts and the confirmation keep their marks. Nothing is rewritten
  to avoid the trap; the rule closes it (asked, 2026-09-17).

**Contract.** One skill and one manual, kit-owned; a target receives both on
`update`.

* `skills/initialize/SKILL.md`, Language section, the paragraph stating the As
  written rule: it must hold three things it does not hold today. That a mark
  in this file delimits a text and never instructs to reproduce its bytes.
  That what stays in English is a closed list: the kit's own terms, every
  path, every file name, every command, and a quote of what a tool printed.
  That an option label is not one of them. The wording is the run's, inside
  that, and the four statements the paragraph already carries stay.
* `manuals/graphify.md`, §Ensuring the graph, the sentence introducing the
  Graph confirmation: it must hold the same rule, scoped to what that section
  owns, naming the question, the three option labels and their descriptions as
  reaching the person in the conversation's language, and the count line the
  question quotes as staying what graphify printed. It is stated there and not
  by reference, because `/propose` and `/apply` read this section and never
  read `skills/initialize/SKILL.md`.
* Second occurrence of the As written rule. The first is the five texts of
  `/initialize` (`work/done/asked-as-written-says-which-language.md`); the
  second is the Graph confirmation, which is why the clause is written in the
  manual as well and each file states it for the texts it owns
  (`CLAUDE.md`, How to work).
* The five places where `/initialize` writes its texts do not change, and
  neither do their marks. The three bullets of the confirmation keep their
  words and their bold, because the same section names those three answers
  again outside the bullets.
* `docs/03-Domain.md`: the row As written, in three places. Its closing
  sentences, which name the no screen line and the confirmation's labels as
  the open case and point at this slug, are replaced by what this delivery
  settled. Its opening, which says the term is what a fixed text of
  `/initialize` keeps and names five texts, must name the two occurrences, the
  five texts and the Graph confirmation. Its Code column, which names the
  phrase in `skills/initialize/SKILL.md` alone, must name both files. The row
  Graph confirmation keeps its words, and no row is added.
* `VERSION`: one patch above what the file holds.
* Nothing in `bin/focus-kit`, `manuals/process.md`, `manuals/focus.md`, the
  other two skills, the templates or `config/` changes.

**Slice.** `skills/initialize/SKILL.md` and `manuals/graphify.md`, kit-owned;
this repository's `docs/03` and `docs/06`, project-owned. `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), explain
"manuals/graphify.md" named 1 file (1 section), affected both named 0`. No row
of `docs/01` §3 changes, in either table. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` asks the same questions
it asks today and the three commands ask the same Graph confirmation. In a
conversation that is not in English, the no screen line and the three option
labels come out in that language, which the other four texts and the
confirmation's question and descriptions already did.

**Visual reference.** No UI. What the record of a run holds: the no screen
line and the confirmation as said, quoted, beside the statements of the
English source, each ticked or missing, and the count line inside the
question shown as graphify printed it.

**Out of scope.**

* Every other line §Ensuring the graph says out loud: the two stale lines, the
  no stamp line and the three lines saying what the answer cost.
  `docs/06-Queue.md`, this line, names the five texts and the confirmation and
  nothing else.
* The status lines `/propose` and `/apply` say of their own, including the
  `decided by files` line and the closing block: same citation, and no run has
  produced an error in either.
* Removing the marks from the five texts or from the confirmation's bullets
  (asked, 2026-09-17): the rule closes the case, the manual names those three
  answers outside the bullets anyway, and every bullet of every manual is
  written as a bold label.
* Naming a backtick or a bold as the cause: the same marks produced both
  results in one session (`docs/06-Queue.md`, this line).
* Translating the kit's own text: `docs/00`, open decision 4.
* An ADR: a clause in a skill and a clause in a manual are not expensive to
  reverse (`docs/03`, ADR).

**Done when.**

* [ ] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch above
  what the file holds; `focus-kit install .` run here last.
* [ ] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
  fictional domain, brownfield with no screen so the no screen line is
  reached, holding prose so the attempt of the first branch refuses and the
  Graph confirmation is reached, installed at the delivery's version and the
  copies verified to carry both edits before the run, in a clean session, the
  stakeholder writing in a language other than English throughout, run at
  least until the no screen line is said, which Step 1 says after the four
  Practice questions and after the confirmation. Green: the no screen line and the
  confirmation's three option labels come out in the conversation's language
  and carry every statement of the English source, in its order, compared
  statement by statement; the count line inside the question is what graphify
  printed. Which answer is given to the confirmation is the stakeholder's and
  does not enter the green. The scratch is removed. What the run produced
  wins; red is a queue line.
* [ ] The `docs/03` row As written names no open case; the queue line `[x]`.
* [ ] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [ ] The last thing said is which environment is at which version.
