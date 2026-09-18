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

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch above
  what the file holds; `focus-kit install .` run here last.
* [x] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
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
* [x] The `docs/03` row As written names no open case; the queue line `[x]`.
* [x] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [x] The last thing said is which environment is at which version.

---

## What happened

**What was built.** Three edits and a number, and nothing else in the kit.

The paragraph of the Language section of `skills/initialize/SKILL.md` that
states the As written rule gained three things and kept its four: what stays
in English is now a closed list, the kit's own terms, every path and every
file name, as the section already keeps them in a document, plus every
command and a quote of what a tool printed; an option label is not one of
them and is said in the person's language like the question it belongs to;
and a mark in that file delimits a text so that its start and its end are
visible, never an instruction to reproduce the bytes between the marks.

The sentence of `manuals/graphify.md` §Ensuring the graph that introduces the
Graph confirmation now states the same rule for what that section owns: the
question, the three option labels and their descriptions reach the person in
the conversation's language, carrying every statement and their order, and
the count line the question quotes stays what graphify printed, as do the
commands, the paths and the file names. It is stated there and not by
reference, because `/propose` and `/apply` read that section and never read
the skill.

`docs/03-Domain.md`, the row As written, in its three places: the Code column
names both files; the opening names the two occurrences, the five texts and
the Graph confirmation; the closing sentences that named the open case are
replaced by the second occurrence and what it settled. The row Graph
confirmation kept its words and no row was added. `VERSION` 0.22.3 to 0.22.4,
then `focus-kit install .` here, check 6 empty.

The five texts of `/initialize` and the three bullets of the confirmation
kept their words and their marks, as the Contract requires.

`graph: explain "skills/initialize/SKILL.md" named 1 file (8 sections),
affected "skills/initialize/SKILL.md" named 0; explain "manuals/graphify.md"
named 1 file (1 section), affected "manuals/graphify.md" named 0`. All four
branches of `docs/manuals/graphify.md` §Ensuring the graph were already
satisfied here, so the command said nothing.

**What diverged from the plan.** Nothing in the Contract. One wording
decision the page left to the run: both clauses name the marks the two files
use, "backticks or bold", inside the statement of what a mark **is**. The
page forbids naming a mark as the cause, which neither clause does; naming
them as what delimits is what makes the sentence checkable against the files,
where the five texts and the three bullets carry exactly those two marks.

One thing the commit carries that is not this delivery's: a `/propose
run-ignores-a-stray-word` ran alongside this session, and `git add -A` swept
in its page, `work/run-ignores-a-stray-word.md`, and its queue mark, `[ ]` to
`[>]`. Both are left staged. The queue mark lives in the same file as this
delivery's `[x]`, so splitting the commit would take a `git add -p`, and a
commit holding the `[>]` without the page it names would be the worse half.
The same sweep, from the other side, is recorded in
`work/done/asked-as-written-says-which-language.md`.

**What was dropped.** Nothing. The Proof tool question, one of the five
texts, was not reached: a brownfield repository with no screen asks nothing
and says the line instead, which is why the page's green list omits the
question and names the line.

## The proof: both halves green, in the same run

A scratch repository in this session's scratchpad, **hivebook**, a fictional
logbook for a small apiary that records what an inspection found, decides
when a mite treatment is due and retires a hive. Python over SQLite, a CLI
and no screen anywhere, five modules by technical role, rules inside the
handlers next to the SQL, four exception classes raised and one `except
Exception` in the CLI, three tests in `tests/test_cli.py`, plus `README.md`
and `notes/season.md` as prose so the first branch refuses. One commit, `git
init` plus `focus-kit install` at **0.22.4**, and both installed copies
carried the two edits before the run: verified by grep in
`.claude/skills/initialize/SKILL.md` and `docs/manuals/graphify.md`, which is
what makes the green below a finding about the rule and not about a fresh
copy. The attempt of the first branch refused there for free, `found 7 code,
2 docs, 0 papers, 0 images`. One clean session, `/initialize`, the
stakeholder writing in Portuguese throughout, documentation language answered
**Português (Brasil)**.

**1. The Graph confirmation. Green, and it was half the measured offender.**

> graphify recusou: found 7 code, 2 docs, 0 papers, 0 images. Construir o
> grafo?
>
> **Construir agora.** `/graphify .` nesta sessão, cobrado como tokens dela.
> Quando uma das seis chaves estiver exportada, `graphify .` no lugar,
> cobrado na conta daquela chave. Dois runs do Cost ledger, para escala: 38
> arquivos custaram 187.743 tokens de entrada, 62 arquivos custaram 433.524.
>
> **Só código.** `graphify . --code-only && graphify cluster-only .
> --no-label`, grátis, sem modelo; o segundo comando escreve o Graph report
> com o stamp e as comunidades numeradas. Docs, papers e imagens ficam fora
> do grafo até você rodar `/graphify --update`. `--no-label` é o que mantém a
> resposta grátis: `graphify --help` diz que o backend de rotulagem faz
> auto-detect por padrão, e a flag mantém os placeholders `Community N` e
> pula a nomeação.
>
> **Agora não.** Nada é construído. Este comando lê os arquivos diretamente e
> diz isso; o próximo comando que precisar do grafo pergunta de novo.

The question in the conversation's language, ticked. The count line inside it
exactly as graphify printed it, without the `[graphify extract]` prefix,
ticked. The three labels said in Portuguese, in the file's order, ticked:
this is the line that read Build now, Code only and Not now in the measured
session at 0.22.2. Build now's four statements, the command, the exported-key
variant with its second command, and the two runs of the Cost ledger with
both figures, ticked. Code only's seven, the two commands, free and without a
model, what the second writes, what stays out until `/graphify --update`,
what `--no-label` buys, what `graphify --help` says and what the flag keeps
and skips, ticked. Not now's three, ticked. Every command, path and flag kept
in English; the figures took the Portuguese thousands separator, which is
prose and not a quote of what a tool printed.

**2. The no screen line. Green, and it was the other half.** The Proof tool
question was not asked, which is the file's instruction when there is no
screen, and the line was said:

> Não há tela neste repositório (README.md e src/hivebook/cli.py:1 dizem
> isso), então:
>
> nenhuma tela encontrada; a §6 diz como o endpoint ou a CLI é provado.

Against `no screen found; §6 says how the endpoint or the CLI is proven`: no
screen found, ticked; §6 says how the endpoint or the CLI is proven, ticked,
with §6 carried as the reference it is and `endpoint` and `CLI` as the terms
they are. Nothing added, nothing dropped, the order kept. At 0.22.2 this same
line came out in English inside a Portuguese sentence, which is the queue
line this delivery closes.

The rest of the run is outside the green and is recorded because it was seen:
the Language question, the brownfield confirmation, the two-patterns
disclaimer and the four Practice questions all came out in Portuguese, which
is what they already did at 0.22.2. Which answer was given to the
confirmation, "Agora não", is the stakeholder's and does not enter the green.
The scratch was removed.

**Decisions taken.** None beyond the wording. No ADR: a clause in a skill and
a clause in a manual are not expensive to reverse (`docs/03`, ADR).

**Environments.** Kit source at 0.22.4, the dogfood copy in sync with it
(`focus-kit install .` run after the last edit, check 6 empty), the first
target `~/Downloads/vaulted` at 0.22.4 with nothing staged and nothing
committed there. The machine's CLI is a symlink and followed on its own.
