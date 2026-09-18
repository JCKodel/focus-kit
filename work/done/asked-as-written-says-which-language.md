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

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch
  above what the file holds; `focus-kit install .` run here last.
* [x] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
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
* [x] The `docs/03` row present; the queue line `[x]`.
* [x] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [x] The last thing said is which environment is at which version.

---

## What happened

**What was built.** One paragraph at the end of the Language section of
`skills/initialize/SKILL.md`, and nothing else in the kit. It names the five
texts, says they reach the person in the conversation's language, says that
the phrase `written here once and asked as written` binds the content and
not the bytes, keeps the kit's own terms, paths and file names as the same
section already keeps them in a document, and names the English text in the
file as the source a record is compared with statement by statement. The
five mentions kept their words, as the Contract requires. `VERSION` 0.22.1
to 0.22.2.

`graph: explain "skills/initialize/SKILL.md" named 1 file (8 sections),
affected "skills/initialize/SKILL.md" named 0`. All four branches of
`docs/manuals/graphify.md` §Ensuring the graph were already satisfied here,
so the command said nothing.

**What diverged from the plan.** The Contract asks for the `docs/03-Domain.md`
row As written, "added by this page". It was already there: `b4611e3` carries
it, one commit before the page itself landed in `79cf575`, and no
`work/done/` record claims it. The `/propose` of this delivery ran alongside
the `/apply` of `doctor-sees-an-unbumped-change` and its row was swept in by
that `git add -A`. It was read statement by statement against the paragraph
this delivery wrote and the two agree: the same five texts by the same names,
the same Conversation language, the same carried over and the same kept in
English, the same source and the same statement-by-statement compare, the
same "in an English conversation the two are the same bytes". Nothing was
written there, and the item is ticked on the file's state.

**What was dropped.** Nothing in scope. The Proof tool question is one of the
five and was not reached: a brownfield repository with no screen never asks
it, which is why the page's green list omits it. One of the five, the no
screen line, came back red, and the Graph confirmation this page had left out
of scope produced the same shape in the same run: both leave as the queue
line `as-written-covers-a-literal`, not as a patch here, because the Contract
forbids touching the mentions and `manuals/graphify.md` is another file's
rule.

## The proof: four of five green, one red, and one more measured beside it

A scratch repository in this session's scratchpad, **seedlib**, a fictional
community seed library that lends seed packets for a season and takes part of
the harvest back. Python over SQLite, a CLI and no screen anywhere, five
modules by technical role, rules inside the handlers next to the SQL, four
exception classes raised and one `except` in the CLI, three tests in
`tests/test_cli.py`. One commit, `git init` plus `focus-kit install` at
**0.22.2**, and its `.claude/skills/initialize/SKILL.md` carries the new
paragraph: verified before the run, which is what makes the red below a
finding about the rule and not about a stale copy. One clean session,
`/initialize brown`, the stakeholder writing in Portuguese throughout,
documentation language answered **Português (Brasil)**.

**1. The Language question. Green, and it was the measured offender.** Asked
in Portuguese, every statement of the English source present:

> Em qual língua os documentos são escritos? A resposta governa a prosa de
> docs/00 a 06, os ADRs, CLAUDE.md, work/<slug>.md, work/done/<slug>.md e as
> mensagens de commit sugeridas, e nada mais: esta conversa acontece na
> língua em que você escrever, e os identificadores permanecem em inglês,
> qualquer que seja sua resposta. Qualquer outra língua é válida: digite-a na
> última opção, Deutsch por exemplo, e ela é tomada como você a escreveu.

Which language the documents get written in, ticked. What the answer governs
and nothing else, with the six paths kept as they are, ticked. The
conversation runs in whichever language you write in, ticked. Identifiers
stay in English whatever you answer, ticked. Any other language typed into
the last option, named by its place and not by a label, with Deutsch as the
example, ticked. Two options, English first because the README and the commit
message are in English, which is the brownfield branch of Step 0, each
description saying what the documents read like in it, ticked. The label
`Português (Brasil)` came out translated, which is the rule working and not a
deviation: the kit's own terms, paths and file names are what stays.

**2. The four Practice questions. Green.** Four in one `AskUserQuestion`, in
the order the file writes them, each stating what the code does today with
the file cited, each with FOCUS's answer first and today's second, each
option saying what it buys:

> O código está organizado por papel técnico, um módulo plano por papel (cli,
> handlers, store, models, errors), e não por feature
> (src/seedlib/handlers.py:1 ...). Como ele deve ser organizado?

> As regras de negócio estão dentro dos handlers, misturadas às chamadas de
> SQL (src/seedlib/handlers.py:19-43 ...). Onde elas devem morar?

> Uma falha viaja como exceção lançada: MemberSuspended, TooManyOpenLoans,
> NotEnoughPackets e LoanAlreadyClosed são raise nos handlers
> (src/seedlib/handlers.py:22,25,29,49,53) e um único except as captura na CLI
> (src/seedlib/cli.py:36). Como ela deve viajar?

> Os testes daqui cobrem os handlers contra um SQLite em memória montado no
> próprio arquivo: três testes em tests/test_cli.py:10-45 ... O que deve
> ganhar teste?

Every statement of the four FOCUS options reached the person: one named
function per rule, no fetching and no persisting inside, the orchestrator
converting one event into one state, tested with literals and no mock; the
Result type and the repository as the one place an infrastructure exception
becomes a value, every caller asked to handle each outcome, a refusal not
swallowed by a `catch` three frames up; the rule as a unit, the orchestrator
as the integration, the view as event in and render out. Two things look like
drift and are not. The second option's nouns were summarized to this
repository (`cli com cli, store com store`), which is what the file asks for
with "summarized". And "the view as event in and render out" was carried into
a repository with no view: nothing added and nothing dropped is the rule, and
dropping it would have been the deviation.

**3. The two-patterns disclaimer. Green.** Said in one line, in Portuguese,
before the questions:

> Escolher a resposta do FOCUS onde o código faz de outro jeito significa dois
> padrões vivendo na árvore ao mesmo tempo, o antigo e o novo, até a migração
> aterrissar. Isso é um estado normal para um projeto que está migrando e ruim
> para um que não está, então a escolha vem com as entregas de migração em
> `docs/06-Queue.md` ou não vem.

Two patterns in the tree until the migration lands, ticked. Normal while
migrating and bad while not, ticked. The choice comes with the migration
deliveries or it does not come, with the path kept, ticked. The `(Step 2)` of
the source is skill-internal navigation and not a statement of the
disclaimer, and was not said.

**4. The no screen line. Red.** It came out in English, quoted inside a
Portuguese sentence:

> Sem tela: **no screen found; §6 says how the endpoint or the CLI is
> proven.** Restam três coisas que nenhum arquivo responde.

The rule names this text and the run did not follow it. The hypothesis, and
it is a hypothesis: the mention writes the line in backticks, as a literal,
while the disclaimer beside it is written as prose, and the run treated the
backticked one as a token to reproduce rather than a sentence to say. The
Contract of this page forbids touching the five mentions, and
`docs/05-Process.md` §6 says what the command produced wins, so it leaves as
a queue line and not as a patch inside this delivery.

**5. The Proof tool question. Not reached, by design.** A brownfield
repository with no screen says the no screen line instead, so the page's
green list omits it.

**The Graph confirmation, out of scope and now measured.** The page left it
waiting for its own error, and the same run produced one. It was reached,
because the README makes graphify refuse, and the question came out in
Portuguese while its three option labels, written in bold in
`manuals/graphify.md`, did not:

> graphify recusou: found 9 code, 1 docs, 0 papers, 0 images. Construir o
> grafo?
> **Build now** · **Code only** · **Not now**

The three descriptions were in Portuguese, including the two cost figures and
the commands, with the commands kept as commands. The stakeholder answered
"Not now", which is theirs to answer and does not enter the green.

That is the no screen line's shape a second time, in the other file: a text
the source sets off as a literal is reproduced rather than said. The two
findings are one queue line, `as-written-covers-a-literal`, on the
stakeholder's word, because the fix is one rule said in two places and this
page's own argument was that a rule lives in one place. The first occurrence
is the no screen line, the second the Graph confirmation's labels, both
measured in the same session.

The scratch was removed.

## Decisions

No ADR. One paragraph in a skill is not expensive to reverse
(`docs/03-Domain.md`, ADR), which is what the page already said.

## What this commit carries that is not this delivery

A `/propose initialize-trusts-the-argument` ran beside this session and its
work was on disk when `git add -A` reached it: the page
`work/initialize-trusts-the-argument.md`, the `docs/03-Domain.md` row Kind of
project, and the queue line turned from `[ ]` to `[>]`. It is staged here for
the same reason the page of this delivery was staged by
`review-run-finds-a-translated-practice-table`: one `git add -A`, and nothing
of it was written or edited by this session.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.22.2 |
| Dogfood copy | 0.22.2, `focus-kit install .` run here last |
| Machine | the CLI untouched, a symlink to the kit source |
| First target (`~/Downloads/vaulted`) | 0.22.2, nothing staged, nothing committed |
| Target repositories | untouched; they move on their owner's `focus-kit update` |
