# run-ignores-a-stray-word

**Goal.** A word typed after `/initialize` changes nothing and is never
explained back to the person, because Step 0 says so instead of leaving the
run to decide alone. Measured on 2026-09-17 in the second scratch of
`initialize-trusts-the-argument`, the kit at 0.22.3: `/initialize green`
produced the same count line and the same kind question as the bare run, and
one paragraph more, naming the word that was typed and saying it was not
taken as an early confirmation (`docs/06-Queue.md`, this line).

**Behaviour.**

* The first paragraph of Step 0 of `skills/initialize/SKILL.md` gains what it
  does not say today: the word reaches the run as text, it is neither an
  instruction nor evidence, the count of source files decides alone, and the
  run says nothing about the word.
* The rule holds whatever the word is: one that contradicts the count, one
  that agrees with it, one that names nothing the command ever accepted. None
  of the three is evidence and none of the three is mentioned (asked,
  2026-09-17).
* Saying nothing means nothing anywhere the run speaks: not a paragraph, not
  a clause inside the count line, not a line of the closing report.
* The clause states that the word arrives, because it does. Claude Code puts
  what was typed into the prompt whether or not the skill names an argument,
  and a rule written as if the text were absent leaves the run reconciling
  what it can see with a file that pretends it cannot
  (`work/done/initialize-trusts-the-argument.md`, The proof).
* The frontmatter still declares no argument and the count stays the only
  source, which `initialize-trusts-the-argument` settled and this page does
  not reopen.

**Contract.** One skill, kit-owned; a target receives it on `update`.

* `skills/initialize/SKILL.md`, Step 0, first paragraph: it must hold four
  things it does not hold today. That a word typed after the command reaches
  the run as text. That it is neither an instruction nor evidence. That the
  count of source files is what decides, whatever the word says. That the run
  says nothing about the word. What the paragraph already carries, the count,
  what it counts and the two definitions, stays. The wording is the run's,
  inside that.
* It goes in as prose of Step 0 and not as a sixth entry in the Language
  section's list of texts asked as written: there is no text to say, and the
  precedent for a Step 0 rule that is prose is the count line
  (`work/done/initialize-trusts-the-argument.md`, What the page left to the
  run).
* `docs/03-Domain.md`, the row Kind of project, keeps its wording and its Code
  column. It already states the rule, that a word typed after the command is
  ignored and nothing is said about it, and it already points at the first
  paragraph of Step 0, which is where the clause lands. No row is added and no
  term is new.
* The Language section and its five texts do not change here. They belong to
  `work/as-written-covers-a-literal.md`, which is in flight and edits the same
  file in a different section; both pages ask for one patch above what
  `VERSION` holds, so either order works.
* `VERSION`: one patch above what the file holds.
* Nothing in `bin/focus-kit`, the three manuals, the other two skills, the
  templates or `config/` changes.

**Slice.** `skills/initialize/SKILL.md`, kit-owned; this repository's `docs/06`,
project-owned. `graph: explain "skills/initialize/SKILL.md" named 1 file
(8 sections), affected "skills/initialize/SKILL.md" named 0`. No row of
`docs/01` §3 changes, in either table. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` says the same count line
and asks the same questions it asks today, in every run. A run started with a
word after the command says nothing a bare run in the same repository does not
say.

**Visual reference.** No UI. What the record of a run holds: the count line and
the kind question as said, and the transcript through the kind question read
for any mention of the word that was typed.

**Out of scope.**

* Making the word an argument again: the count is the only source
  (`docs/03-Domain.md`, Kind of project), and reopening it would undo
  `initialize-trusts-the-argument`.
* A word typed after `/propose` or `/apply`: both take a slug, and
  `docs/06-Queue.md`, this line, names `/initialize` and nothing else.
* How the count decides what a source file is: it was not the defect there
  (`work/done/initialize-trusts-the-argument.md`) and it is not this one.
* What makes a run a review run: `docs/00-Product.md` existing decides it
  (`skills/initialize/SKILL.md`, Step 0).
* The five As written texts and the Graph confirmation:
  `work/as-written-covers-a-literal.md` owns them.
* An ADR: one clause in one skill is not expensive to reverse (`docs/03`, ADR).

**Done when.**

* [ ] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch above
  what the file holds; `focus-kit install .` run here last.
* [ ] Proof (`docs/05` §6): `/initialize green` in a scratch repository on a
  fictional domain, brownfield so the count has something to count and the word
  contradicts what it finds, which is the shape that was measured; no
  `docs/00-Product.md`, so the run is a first run and never reaches the review
  branch; installed at the delivery's version and the copy verified to carry
  the edit before the run; in a clean session; run at least through the kind
  question. Green: the run says the count line, asks the kind question, and
  says nothing about the word anywhere in what it produced up to that point.
  The scratch is removed. What the run produced wins; red is a queue line.
* [ ] The `docs/03` row Kind of project is true of the skill; the queue line
  `[x]`.
* [ ] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [ ] The last thing said is which environment is at which version.
