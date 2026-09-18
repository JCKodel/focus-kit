# asked-as-written-says-which-language

**Goal.** A person running `/initialize` in a conversation that is not in
English reads every fixed text of the command, the three questions and the
two lines, in the language they write in, carrying what the skill wrote and
nothing else, so two runs of the same command say the same thing and a
record of either is compared with the skill. Measured on 2026-09-17 in the
scratch of `practice-questions-all-yes`: one session asked the Language
question in English and said the four Practice questions, the two-patterns
disclaimer and the no screen line in Portuguese, and neither was wrong
against the file (`docs/06-Queue.md`, this line).

**Behaviour.**

* The Language section of `skills/initialize/SKILL.md`, whose third bullet
  already says the conversation follows the language the person writes in,
  gains the rule: a text this file writes once and asks or says as written
  reaches the person in the conversation's language, with every statement,
  every option and their order, nothing added and nothing dropped. The
  kit's own terms, paths and file names stay as the same section already
  keeps them in a document (asked, 2026-09-17).
* The rule names the five texts it covers, so no reading leaves out the two
  that lack the phrase: the Language question (Step 0), the four Practice
  questions and the Proof tool question (Step 1, reused by the greenfield
  rounds), the two-patterns disclaimer and the no screen line
  (`docs/06-Queue.md`, this line: "of none of the five").
* The English text in the skill is the source. A record that quotes what
  was asked is compared with it statement by statement, never byte by byte
  (asked, 2026-09-17). In an English conversation the two are the same
  bytes, and nothing changes.
* The five mentions keep their words: the phrase stays where it is and the
  Language section says once what it means (asked, 2026-09-17).

**Contract.** One skill, kit-owned; a target receives it on `update`.

* `skills/initialize/SKILL.md`, Language section: one paragraph stating the
  rule above, and it must hold four things: which five texts, that they are
  said in the conversation's language, what is carried over and what stays
  in English, and that the English text here is the source a record is
  compared with. The wording is the run's, inside that.
* The five places where the texts are written do not change. Step 0, Step 1
  and Step 2 keep their words; the header row `Practice | Answer | Here it
  is` is a document matter and belongs to
  `work/review-run-finds-a-translated-practice-table.md`.
* `docs/03-Domain.md`: the row As written, added by this page. The three
  rows that already say "asked as written", Documentation language,
  Practice and Proof tool, keep their wording. `docs/06` line `[x]`.
* `VERSION`: one patch above what the file holds.
* Nothing in `bin/focus-kit`, the manuals, the templates or `config/`
  changes.

**Slice.** `skills/initialize/SKILL.md`, kit-owned; this repository's
`docs/03` and `docs/06`, project-owned. `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), affected named 0`.
No function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` asks the same
questions it asks today; in a conversation that is not in English every one
of the five texts comes out in that language, the Language question
included, which is what the other four already did in the measured session.

**Visual reference.** No UI. What the record of a run holds for each text
reached: the text as asked, quoted, and beside it the statements of the
English source, each ticked or missing.

**Out of scope.**

* Asking in English byte for byte whatever the conversation: the Language
  question would then contradict what it says about the conversation
  (asked, 2026-09-17).
* Rewriting the five mentions to spell the rule out each time: one rule, one
  place (asked, 2026-09-17).
* The Graph confirmation of `docs/manuals/graphify.md` §Ensuring the graph,
  also asked "as written" by the three commands: the second occurrence of
  the phrase, with no divergence measured yet, waits for its own error
  (asked, 2026-09-17; `docs/00`, product question 6).
* The writing side of the same collision, the header row of `docs/01` §3:
  `work/review-run-finds-a-translated-practice-table.md`.
* The "talk to the person in the language they write in" lines of `/propose`
  and `/apply`: neither asks a fixed question of its own.
* Translating the kit's own text: `docs/00`, open decision 4.
* An ADR: one paragraph in a skill is not expensive to reverse (`docs/03`,
  ADR).

**Done when.**

* [ ] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch
  above what the file holds; `focus-kit install .` run here last.
* [ ] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
  fictional domain, brownfield with no screen so the disclaimer and the no
  screen line are reached, in a clean session, the stakeholder writing in a
  language other than English throughout, run at least through the Practice
  questions. Green: the Language question, the four Practice questions, the
  disclaimer and the no screen line each come out in the conversation's
  language and carry every statement and option of the English source, in
  its order, compared statement by statement; the Graph confirmation, if
  reached, is the stakeholder's to answer. The record quotes each text as
  asked beside the source's statements. The scratch is removed. What the
  run produced wins; red is a queue line.
* [ ] The `docs/03` row present; the queue line `[x]`.
* [ ] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [ ] The last thing said is which environment is at which version.
