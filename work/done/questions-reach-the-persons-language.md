# questions-reach-the-persons-language

**Goal.** A host running `/initialize` reads, on the line where each question
begins, that the question is said in the person's own language, instead of
reading there a phrase that tells it to reproduce the English bytes.

**Behaviour.**

* At the moment `/initialize` asks the Language question, the file says on
  that same line that the question reaches the person in the conversation's
  language. The same holds for the four Practice questions, the Proof tool
  question, the Git strategy question, the two-patterns disclaimer and the no
  screen line: six texts, one phrase each, one wording.
* Nothing in the file says `asked as written` any more, so no text at the
  point of asking reads as an instruction to reproduce bytes.
* The Language section still holds the whole rule and no occurrence of the
  phrase repeats it: the phrase names the language, the section says what the
  phrase binds and what stays in English.
* A run of `/initialize` in a scratch repository, the conversation in
  Portuguese, asks its questions in Portuguese, option labels included. What
  the run produces wins over this line (`docs/05-Process.md` §6).
* `docs/03-Domain.md` names the new phrase everywhere it named the old one.

**Contract.**

The phrase, one sequence of words, identical in every place:

```
written here once and said entire, in the conversation's language
```

It replaces `written here once and asked as written` in every occurrence in
`skills/initialize/SKILL.md`, and it enters the two texts that carry no
phrase today. Seven occurrences after the delivery: one on the line that
introduces each of the six texts, the Language question in Step 0 and, in
Step 1 brownfield, the Practice questions, the Proof tool question, the Git
strategy question, the two-patterns disclaimer and the no screen line; plus
one in the Language section, which names the phrase once and says it covers
all six.

* Every occurrence stands whole on one line and is never broken by a wrap. A
  phrase cut in two is one no `grep` finds, the way a citation the wrap cuts
  is one `doctor` never sees (`docs/03-Domain.md`, Manual citation). The run
  reflows the sentence around it.
* It names no host and no tool, and holds none of the five strings
  `render_prompt` substitutes (`docs/01-Architecture.md` §3, `render_prompt`),
  so the Ported command carries it unchanged and the substitution list is
  untouched.
* The sentence around each occurrence is the run's to write, so that each one
  reads naturally where it sits. Nothing else of the six texts changes: not a
  statement, not an option, not their order.
* The Language section keeps the paragraph that says what the phrase binds,
  every statement and every option and their order with nothing added and
  nothing dropped, the closed list of what stays in English, and what a
  backtick or a bold mark means. The sentence there saying that four of the
  six carry the phrase and two do not is rewritten: all six carry it.

`docs/03-Domain.md`, three rows, no new term and no rename:

* **As written**: the Code column names the new phrase for
  `skills/initialize/SKILL.md`, and for `docs/manuals/graphify.md` the
  paragraph that states the rule before the Graph confirmation. The term keeps
  its name, which is the older of its two phrasings and the one the Done pages
  cite it by.
* **Practice** and **Proof tool**: each says `asked as written` of its
  question today, and says the new phrase instead.

`bin/focus-kit` is untouched. The four Ported commands change only because
`focus-kit install .` regenerates them from the skills.

**Slice.** One skill, `skills/initialize/SKILL.md`, kit-owned. Its dogfood
copy `.claude/skills/initialize/SKILL.md` and the generated
`.github/prompts/initialize.prompt.md`, both kit-owned and both written by
`focus-kit install .`. `docs/03-Domain.md` and `docs/06-Queue.md`,
project-owned. `VERSION`. No `bin/`, no manual, no template, no `config/`.
This repository has no View, Orchestrator, Use case or Repository
(`docs/01-Architecture.md` §3), so none is named.

**States.** The defaults. The CLI gains no message and no branch.

**Visual reference.** No UI, and no change to what the CLI prints. What the
delivery ships is the phrase above.

**Out of scope.**

* `docs/manuals/graphify.md` and its Graph confirmation: the queue line names
  `/initialize`, and that manual already states the rule in the paragraph
  before its question, which is what this delivery adds to the six texts.
* `/discuss`, `/propose` and `/apply`: the queue line names `/initialize`
  alone.
* Renaming the `docs/03-Domain.md` term **As written**: the Done pages cite it
  by that name, and a Done page records what was.
* Making a host obey. What a host does with an instruction it read is
  measured, not fixed in a skill.
* The other finding of the same proof run, the three manuals left in English:
  it is the queue's own line `initialize-names-what-it-skipped`.

**Done when.**

* [x] `bin/focus-kit selftest` green, six checks.
* [x] A fixed-string `grep -c` of the phrase over
  `skills/initialize/SKILL.md` counts seven, one per text and one in the
  Language section, and a `grep -c` of `asked as written` over the same file
  counts zero.
* [x] `docs/03-Domain.md` rows **As written**, **Practice** and **Proof tool**
  name the new phrase, and no other row of that file still names the old one.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 comes
  back empty and the dogfood copy and the four prompt files are at the
  delivery's version (`docs/05-Process.md` §5).
* [x] The proof ran: `/initialize` in a scratch repository, the conversation
  in Portuguese, and the record says in which language each of the six texts
  came out, whatever that language was (`docs/05-Process.md` §6).
* [x] The record says whether the run under GitHub Copilot in VS Code
  happened, that one being the person's to make, and carries what it produced
  when it did.
* [x] `docs/06-Queue.md` line `[x]`, the page in `work/done/`.

---

## What happened

The seven occurrences went in as the Contract described them, and the
sentence around each one was the run's to write. What was chosen, site by
site, so the next delivery can see the shape rather than re-derive it:

* **Language section.** `Each of the six carries the phrase` followed by the
  phrase in backticks on its own line, then `and the rule covers all six.`
  The backticks stayed because that section is the one place that names the
  phrase rather than carries it, and a mark there delimits, which is what the
  same paragraph says three sentences later.
* **Language question (Step 0).** `The question and its options are` /
  phrase / `: the question ...`. The capital `W` of the old wording went: a
  fixed-string `grep` counts seven only if the seven are the same bytes.
* **Practice questions**, **Proof tool question**, **Git strategy
  question.** The same shape at all three, `The **X** is` / phrase / `one
  AskUserQuestion, ...`, which cost one reflow each and nothing else.
* **Two-patterns disclaimer.** `It is` / phrase, a sentence of its own after
  the bold label, so the label kept its bytes and its full stop.
* **No screen line.** `that line being` / phrase, after the line rather than
  before it, because the line is quoted where it is said and a phrase in
  front of it would have split the quote from the instruction that carries
  it.

Each of the seven stands alone on its line, 65 characters plus at most the
two backticks, so no wrap can cut it.

**What diverged from the plan.** Nothing in the Contract. Two things the plan
left to the run cost more than the page expected, both in the proof. The
Proof tool question and the no screen line cannot both happen in one
`/initialize`, because the first is asked when there is a screen and the
second is said when there is not, so the proof is two scratch repositories
and not one. And `claude -p` in its default mode prints only the final
assistant message, so a run that goes all the way to its closing report
measures the report and not the moment a text is said; the sixth text needed
`--output-format stream-json --verbose` and a second turn to be measured at
all. That is a fact about the method, and it is written here because the next
delivery that proves a skill this way will meet it again.

**What was dropped.** Nothing.

## The proof: six texts green in Claude Code, and the Copilot run that decides

The Claude Code runs were driven with `claude -p` from this session, the way
`git-strategy-is-asked` drove its two, against scratch repositories built
from fictional brownfield domains. `AskUserQuestion` does not exist in a
headless session, so each run said so and put its questions in prose, which
is the limit `initialize-trusts-the-argument`, `run-ignores-a-stray-word` and
`git-strategy-is-asked` already recorded. The language of a text is still
what is measured, and prose carries it as well as a card does. The run under
GitHub Copilot, further down, had cards.

**Run A, quiltline**, a Flask and SQLite web application for a quilting
guild: ten `.py` files by technical role, two Jinja templates, rules inside
the handlers next to the SQL, three exception classes raised and caught in
the web layer, two smoke tests, `README.md` and `notes/program.md` as prose so
the graph branch refuses for free. One commit, `git init` plus `focus-kit
install` at **0.30.1**, and the installed
`.claude/skills/initialize/SKILL.md` carried the seven occurrences before the
run, verified by grep, which is what makes the result a finding about the
phrase and not about a fresh copy.

Five of the six texts were reachable there, and all five came out in
Portuguese:

* **The Language question**, green. `Em que língua os documentos serão
  escritos?` with all three statements, the prose the answer governs, the
  conversation running in whichever language the person writes in, and the
  identifiers staying in English, plus the invitation to type a third
  language into the last option. Two options said in Portuguese, `English`
  kept as the name of a language and `Português (Brasil)` as the name of
  another, each description saying what the documents would read like.
* **The four Practice questions**, green. Each stated what the code does
  today with the file cited, `O código está organizado por camadas
  (src/quiltline/handlers/, ...)`, and each option said what it buys, in
  Portuguese, with `Result`, `catch`, `Block` and the paths left in English.
* **The two-patterns disclaimer**, green, said before the four and in
  Portuguese: `Escolher a resposta do FOCUS onde o código faz outra coisa
  significa dois padrões vivendo na árvore ao mesmo tempo ...`
* **The Proof tool question**, green, question and labels both:

  > ### 5. Como uma tela é provada
  >
  > Existem telas: Flask com Jinja, `src/quiltline/web/templates/member.html`
  > e `year.html`. Nenhum arquivo nomeia a ferramenta que prova uma delas.
  >
  > - **Claude in Chrome.** O navegador dentro do Claude Code: uma captura de
  >   tela nas viewports que a §6 nomear, nada acrescentado ao repositório.
  > - **Um script ou driver do repositório.** Você o nomeia (Playwright, um
  >   emulador, um dispositivo) e o comando dele, e ele vive no repositório
  >   como qualquer outra ferramenta.
  > - **Nenhuma.** O comando de verificação é a prova, e a §6 diz isso em uma
  >   linha.

  `Claude in Chrome` stayed in English, which is the kit's own term for a
  tool and is on the closed list; the other two labels were said in
  Portuguese. At the two earlier measurements the labels of a confirmation
  came out in English beside a translated question, which is the shape this
  delivery was aimed at.
* **The Git strategy question**, green, question and all three labels:
  `Uma worktree por entrega`, `Uma branch por slug`, `Nenhuma`, each with
  what it buys and what it costs, in full and in order.

The Graph confirmation, which this delivery does not touch, also came out in
Portuguese with its count line quoted exactly as graphify printed it. That is
recorded because it was seen, not because it was measured here.

**Run B, tidewatch**, a command line logbook for a coastal survey crew, three
`.py` modules, no screen anywhere, one test, `README.md` and
`notes/stations.md` as prose. Same install at **0.30.1**, same verification of
the installed copy. It exists for the sixth text, the one run A cannot reach:
the Proof tool question and the no screen line are mutually exclusive, the
first asked where there is a screen and the second said where there is not.

It took three attempts to measure, and the first two are recorded because
the method is what the next delivery will reuse. `claude -p` in its default
mode prints the **final assistant message and nothing else**. The first
attempt ran to a closing report, so what came back was the report, in which
the line appears as a quote of what `docs/05-Process.md` §6 already said,
in English inside a Portuguese sentence. That is not the line being said, it
is the file being cited, and a quote of a file is on the closed list. The
second attempt, with `--output-format stream-json --verbose`, kept every turn
but stopped after round 1, before the run reaches the line. The third,
`claude -p -c` answering that round in Portuguese, reached it.

**The no screen line, green.** At the moment the run reaches it, before any
question of round 2:

> E uma linha sobre a prova: `nenhuma tela encontrada; a §6 diz como o
> endpoint ou o CLI é provado`. O `README.md` diz que não há página web nem
> interface gráfica, tudo acontece no terminal por `tidewatch <command>`,
> então não há pergunta de ferramenta de prova a fazer.

Against `no screen found; §6 says how the endpoint or the CLI is proven`: no
screen found, ticked; §6 says how the endpoint or the CLI is proven, ticked,
with `§6` carried as the reference it is and `endpoint` and `CLI` as the
terms they are. Nothing added, nothing dropped, the order kept. At 0.22.2
this same line came out in English inside a Portuguese sentence, which is
what `as-written-covers-a-literal` closed; at 0.30.1 it is said in the
person's language and the Proof tool question is correctly not asked. The
two-patterns disclaimer and the Git strategy question came out in Portuguese
in that same run, a second measurement of both.

So the six texts, in Claude Code: **all six in the person's language.**

**The run under GitHub Copilot in VS Code, and it is the one that decides.**
The person ran it against `~/Downloads/quiltline-copilot-proof`, the run A
repository, kit at **0.30.1**, `graphify-out/` removed so the graph branch
starts clean, the seven occurrences verified in
`.github/prompts/initialize.prompt.md` before it was handed over. The person
could not open in Portuguese, because `/initialize` is the first thing typed
and it only asks; the host's prose came out in Portuguese from its first
line, for a reason neither the person nor this page can name, and the
questions followed it.

* **The Language question**, green, and it is the direct contrast with
  `copilot-port`. The host merged it with the Kind of project question into
  one card, which is what the file asks for, and imposed a 200 character
  limit on its main field, so the run put the three statements whole into the
  context field: `O idioma governa a prosa de docs/00 a 06, ADRs, CLAUDE.md,
  work/<slug>.md, work/done/<slug>.md e mensagens de commit sugeridas, e nada
  mais. Esta conversa segue o idioma em que você escreve; identificadores
  permanecem em inglês. Outro idioma é válido: digite-o na última opção,
  Deutsch por exemplo, e ele será usado como escrito.` The three labels in
  Portuguese: `Brownfield confirmado; English`, `Brownfield confirmado;
  Português (Brasil)`, `Brownfield confirmado; outro idioma`.
* **The four Practice questions**, green, in Portuguese.
* **The Proof tool question and the Git strategy question**, both asked and
  both answered, and the run named the answers in Portuguese: `slices
  verticais, casos de uso puros com orquestrador, Result, um teste por peça,
  navegador do Copilot e worktree por delivery`. The proof tool answer is the
  one to look at twice: `navegador do Copilot` is the person's language over
  `The browser tool`, which is what `render_prompt` substitutes for `Claude in
  Chrome` (`docs/01-Architecture.md` §3). The substitution and the phrase
  worked on the same label, in the right order. The two cards themselves were
  not pasted, so what this page has of them is the run's own sentence.
* **The two-patterns disclaimer** was not pasted either, and this page does
  not say what language it came out in under this host.

At 0.30.0, in `copilot-port`'s own proof run, the person wrote Portuguese,
the host's prose answered in Portuguese and **every question card came out in
English**, while a diff of the generated prompt against the skill was ten
lines, all five substitutions. That is the queue line this delivery answers,
and at 0.30.1 the cards come out in the person's language.

**The control group arrived in the same run, and it was not planned.** The
Graph confirmation of `docs/manuals/graphify.md` is out of this delivery's
scope, so it carries no phrase, only the paragraph that states the rule
before it. Under the same host, in the same session, in the same language, it
came out **half**: the descriptions in Portuguese, the three labels in
English, `Build now`, `Code only`, `Not now`, and the question stem itself
split, `graphify recusou: found 13 code, 4 docs, 0 papers, 0 images. Build
the graph?` The texts with the phrase beside them came out in the person's
language; the one text without it, in the same run, did not. That is the
strongest evidence this delivery has, and it is worth a queue line of its own
for `docs/manuals/graphify.md`. One clause of honesty on it: the control
holds under Copilot only. Under Claude Code the same confirmation came out
whole in Portuguese in run A, without any phrase, so what the contrast shows
is a host that needed the phrase and not a text that cannot do without it.

**Three more things the Copilot run produced, none of them this delivery's,
all three recorded because this is where they were seen.**

* **Build now has no free path under GitHub Copilot.** The person chose it
  and the run answered that it could not build, for want of a model key. The
  option's first path is `/graphify .`, a command of the host, and the kit
  installs that command for one host only: `ensure_graphify` runs `graphify
  install --platform claude` (`bin/focus-kit:152`). Under Copilot there is no
  `/graphify`, so what is left is `graphify .`, which is the path that needs a
  key, and the run took it and failed. The host was right about its own
  situation. `graphify install --help` lists `copilot` among its twenty two
  platforms, so the gap is the kit's and not the package's, and the person's
  own words for the requirement are the line's: the graph should be built
  with the model already in the session. It belongs to `docs/manuals/graphify
  .md` and to `ensure_graphify`, both out of scope here, so it goes to the
  queue through `/discuss`.
* **The Manual language went to the wrong path.** The run wrote
  `.focus-kit-language` at the repository root, holding `pt-BR` with no
  trailing newline, where the kit reads
  `.claude/skills/.focus-kit-language` (`ADR-0008`). A `doctor` that finds no
  tag reads the target as English and never runs the Translated manual pass,
  which is why the run's own `focus-kit doctor` came back clean.
* **Step 4 did not land.** The language was answered `pt-BR` and the three
  `docs/manuals/*.md` in the scratch are byte identical to the kit source,
  verified with `diff` after the run. The run said it would translate them
  and reported nothing about not having. That is a second measurement of
  `initialize-names-what-it-skipped`, already in the queue, and the first
  under a second host.

The three `claude -p` scratches were removed. The Copilot scratch,
`~/Downloads/quiltline-copilot-proof`, is left where it is: it is the
person's, and the three findings above are read off it.

**Decisions taken.** None beyond the wording at each of the seven sites, which
is recorded above. No ADR: a phrase in a skill is not expensive to reverse
(`docs/03-Domain.md`, ADR).

**Docs updated.** `docs/03-Domain.md`, the three rows the Contract names, and
nothing else: no new term, no rename. `docs/01-Architecture.md` is untouched,
the delivery having added no function and changed no behaviour of the CLI.

**Environments.** Kit source at **0.30.1**, and it is the truth. The dogfood
copy (`.claude/skills/`, `docs/manuals/`, `.github/prompts/`) is in sync with
it: `focus-kit install .` was run here after the last edit and check 6 of the
verify command comes back green. The machine's CLI is a symlink to the kit
source and follows it with no command. The first target
(`~/Downloads/vaulted`) is not on this machine: the directory
`docs/05-Process.md` §5 names does not exist here, so there is nothing to
update and nothing that is silently behind. Should it come back, the command
is `focus-kit update ~/Downloads/vaulted`. Every other target repository moves
only when its owner runs `focus-kit update <path>`. Nothing is published:
the kit has no registry and no release artifact, and a version reaches
anyone else when a person commits and pushes.
