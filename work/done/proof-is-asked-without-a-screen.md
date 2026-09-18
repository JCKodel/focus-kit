# proof-is-asked-without-a-screen

**Goal.** A repository with no screen is asked how a delivery is proven,
instead of being told in one line what its `docs/05-Process.md` §6 will say.

**Behaviour.**

* Brownfield, no screen found by the sixth reading: `/initialize` asks the
  **No screen question** in one `AskUserQuestion` and writes the answer as
  §6's first line. It says no line before the card and composes no question
  of its own.
* Brownfield, a screen found: nothing changes. The Proof tool question is
  asked exactly as it is today.
* Greenfield, round 5: the round asks the Proof tool card where round 1 to 3
  named a UI, and the No screen card where they did not. Exactly one of the
  two, never both and never neither.
* Review run whose §6 names no tool: it gets the Proof tool question where
  there is a screen and the No screen question where there is none, as a
  proposed edit like any other section.
* A session in another language: the card reaches the person in that
  language, question, three labels and three descriptions, with only paths,
  file names, commands and the kit's own terms staying English.

**Contract.**

1. `skills/initialize/SKILL.md`, Step 1 brownfield, the second of the three
   things asked: the said line `no screen found; §6 says how the endpoint or
   the CLI is proven` and the instruction to ask nothing after it both go.
   In their place the No screen question, one `AskUserQuestion`, carrying
   the phrase `written here once and said entire, in the conversation's
   language` beside it, the way the other five texts do.
2. Its text is the Visual reference below, word for word: the question,
   three options in that order, each a bold label and one sentence, and the
   closing sentence saying that "Other" is Claude Code's own fourth option
   and that no fourth is written. Same shape as the Proof tool question, and
   its third option is that question's `None` option unchanged, so the two
   cards share one wording for one answer.
3. The answer opens `docs/05-Process.md` §6 with `**Tool.**` and what was
   chosen, the same first line the Proof tool question's answer writes. §6
   keeps one marker and gains no second (`docs/03-Domain.md`, Slot: a
   command reads the answer and not the section; a §6 opening otherwise
   would fire Step 0's review marker in every repository with no screen).
4. Step 1 greenfield, round 5: the sentence that today makes the Proof tool
   card conditional on a UI names both cards and says the round asks one of
   the two. The round's numbering, its tooling card and the order of the two
   cards inside it do not change.
5. Step 0, the review run paragraph: the clause `a docs/05-Process.md §6
   that names no tool gets the Proof tool question` names both questions and
   which of the two the screen decides. The other two markers, §3's header
   row and §7's `**Strategy.**`, are untouched.
6. The Language section's list stays six texts: `the no screen line` leaves
   it and `the No screen question` enters it. The word `Six` and the
   paragraph around it do not change.
7. `skills/initialize/templates/docs/05-Process.md`, the §6 init comment:
   the tool comes from the Proof tool question or from the No screen
   question, never inferred. Its other sentences stay.
8. `render_prompt` keeps five substitution pairs and gains no sixth: the No
   screen question names no host and no browser (`docs/03-Domain.md`, Ported
   command). `bin/focus-kit` is not edited; `.github/prompts/initialize.prompt.md`
   changes only by regeneration through `focus-kit install .`.
9. `docs/03-Domain.md` gains one row, **No screen question**, and two
   existing rows are amended: Proof tool, whose greenfield citation reads
   round 4 where the skill has moved the card to round 5, and which names
   the sibling question; and As written, whose list of six swaps the line
   for the question.

**Slice.** One skill and one template: `skills/initialize/SKILL.md` and
`skills/initialize/templates/docs/05-Process.md`, both kit-owned, plus this
repository's own `docs/03-Domain.md` and `docs/05-Process.md`, project-owned.
No piece of `bin/focus-kit` is edited. `docs/01-Architecture.md` §3 says this
codebase has neither slices nor layers and none of the four FOCUS pieces, so
none is named here.

**States.** The defaults. No line of the CLI's output changes, and no new
`warn`, `ok` or `die` is added.

**Visual reference.** No UI. What a target receives is this card, and this is
the English source of it:

```
How is a delivery proven? There is no screen, and no file names the tool.

* **A real run in a scratch copy.** The command or the endpoint runs in a
  throwaway directory or repository, and what it printed is read and
  recorded in the delivery.
* **An output compared with a reference.** A contract test or a golden file
  kept beside the code, which the run's output is compared with.
* **None.** The verify command is the proof, and §6 says so in one line.
```

**Out of scope.**

* The two-patterns disclaimer stays a said line: it has never leaked, and
  abstraction waits for the second concrete occurrence (`CLAUDE.md`).
* The Proof tool question's own text, options and placement: unchanged, it
  stays the question for a repository that has a screen.
* Widening the Proof tool term to cover both answers: it stays what takes a
  screenshot, and the new row sits beside it.
* An ADR: nothing here is expensive to reverse, since the shape of a
  question changes by editing the skill.
* `codex-port`: it renders its prompts from the skills, so it ships this
  text rather than this delivery reaching it.

**Done when.**

* [x] `bin/focus-kit selftest` green.
* [x] `VERSION` bumped and `focus-kit install .` run here, so the dogfood copies
  in `.claude/skills/` and `.github/prompts/` match their source at that
  version (`docs/05-Process.md` §5).
* [x] `docs/03-Domain.md` holds the No screen question row and the two amended
  rows of Contract 9.
* [x] This repository's `docs/05-Process.md` §6 opens with `**Tool.**` and what
  proves a delivery here, so a review run in the kit's own first target does
  not reach the screen question.
* [x] Proof (`docs/05-Process.md` §6, a change to a skill or a template is
  proven by a real run): `/initialize` run in a scratch repository with no
  screen, in a Portuguese session under Claude Code, and the record in
  `work/done/` says whether the card came out whole in that language,
  question, three labels and three descriptions, and whether the run
  composed any question of its own.
* [x] No em dash in anything written.

---

## What happened

**Nine contract items, all shipped, at `VERSION` 0.34.0.** Two files of the
kit moved, `skills/initialize/SKILL.md` and
`skills/initialize/templates/docs/05-Process.md`, plus this repository's own
`docs/03-Domain.md` and `docs/05-Process.md`. No line of `bin/focus-kit` was
edited, and `render_prompt` kept its five substitution pairs: the new text
carries `AskUserQuestion` and `Claude Code`, which pairs 2 and 5 already
cover, and names no browser, so `.github/prompts/initialize.prompt.md` moved
only by regeneration through `focus-kit install .` and renders the card with
`multiple choice question` and `GitHub Copilot` in place.

**One question was asked, and the page is what was ambiguous.** Contract 4
names "the sentence that today makes the Proof tool card conditional on a
UI", and Step 1 greenfield had two: the round 5 bullet, `If there is a UI,
... the Proof tool question`, and the preamble's `its Proof tool card is
asked only where there is a UI`. The preamble one stays literally true after
the change, so the strict reading leaves it; it would then explain half of
what round 5 does, since round 5 now asks a proof card in every case. Asked,
and the answer was both. The preamble now reads `its proof card is one of
two, the Proof tool question or the No screen question, decided by whether
rounds 1 to 3 named a UI`, which is also the reason a second card exists
there. The round's numbering, its tooling card and the order of the two cards
inside it did not change, which is what the rest of Contract 4 asked for.

**Contract 9 was half done before this session started.** `/propose` had
already written the **No screen question** row into `docs/03-Domain.md`, and
it was left as it stood. The two amendments were made: the Proof tool row's
greenfield citation moved from round 4 to round 5 and gained the clause
naming the sibling asked in its place, and the As written row's list of six
swapped `the no screen line` for `the No screen question`. That row's
history, where the no screen line came out in English inside a Portuguese
sentence at 0.22.2, stays as it is: it records what was measured then.

**A third row was amended, past the Contract, and here is why.** The **Slot**
row said §6 carries `**Tool.**` and attributed that marker to the Proof tool
alone, which is behaviour this delivery changed: both questions write it now,
which is the whole of Contract 3. Docs are living (`CLAUDE.md`), so the four
words went in rather than waiting for a delivery of their own. One line about
the rule that changed, and no history rewritten.

`docs/adr/ADR-0006` line 100 says a review run treats a §3 with no table
exactly as it treats a §6 with no Proof tool. It was read and left: it is
still true, since a §6 with no tool still gets asked, and an ADR records what
was decided then in any case.

**Two wordings the page left to the run.** Contract 7 said the §6 init
comment names both questions and keeps its other sentences; its opening
clause also had to lose `no file in a repository names what takes a
screenshot`, which covers only one of the two, and it now reads `no file in
a repository names either one`. And this repository's own §6 opens with
`**Tool.** A real run in a scratch repository`, not `scratch copy`: the
option's label is the kit's question, and `docs/03-Domain.md` gives this
repository one name for that thing and forbids the others.

**What was dropped.** Nothing.

## The proof

`docs/05-Process.md` §6 wants a real run for a change to a skill or a
template. It was driven headless with `claude -p` from this session, the way
`git-strategy-is-asked`, `initialize-trusts-the-argument` and
`questions-reach-the-persons-language` drove theirs, against one scratch
built from a fictional brownfield domain: **millrace**, a command line
ledger for a water mill, Python over SQLite, four `.py` files in
`src/millrace/` and one in `tests/`, a `pyproject.toml`, a `README.md` and
`notes/toll.md` as prose so the graph branch refuses for free, two commits on
`main` by one author, no branch and no remote. No screen anywhere, and the
`README.md` says so in a sentence. `git init` plus `focus-kit install` at
**0.34.0**; the installed `.claude/skills/initialize/SKILL.md` was grepped
first and carried the question at lines 58, 233, 343, 345, 410 and 446, which
is what makes the result a finding about the edit and not about a stale copy.
No `docs/00-Product.md`, so this was a first run and never the review branch.

**Where the Portuguese came from, since the first prompt was not in it.**
Turn 1's prompt was the bare `/initialize`, which is a command name and
carries no language. The run answered in Portuguese from its first line and
stayed there, because `~/.claude/CLAUDE.md` on this machine is written in
Portuguese and a headless session reads it like any other. That is the
conversation's language as the Language section defines it, and the person
had typed no Portuguese before card 4 was measured. It satisfies what the
Done when asks for, and the mechanism is written here because a run without
that file would have to be answered in Portuguese first.

`AskUserQuestion` does not exist in a headless session, the same limit the
four earlier records name, so the run said so and put its cards in prose.
What is measured is the language and the content of a text, and prose carries
both as well as a card does.

**The No screen question, green, whole, and in Portuguese.** Card 4, asked
after the four Practice questions and before the Git strategy question, which
is the order Step 1 brownfield writes:

> ## 4. Como uma entrega é provada
>
> Não há tela (o `README.md` diz que não existe página web, interface
> gráfica nem aplicativo móvel), e nenhum arquivo nomeia a ferramenta.
>
> - **Uma execução real em uma cópia descartável.** O comando ou o endpoint
>   roda em um diretório ou repositório descartável, e o que ele imprimiu é
>   lido e registrado na entrega.
> - **Uma saída comparada com uma referência.** Um teste de contrato ou um
>   arquivo dourado guardado ao lado do código, com o qual a saída da
>   execução é comparada.
> - **Nenhuma.** O comando de verificação é a prova, e a §6 diz isso em uma
>   linha.

Against `How is a delivery proven? There is no screen, and no file names the
tool.`: how a delivery is proven, ticked, as the card's heading; there is no
screen, ticked; no file names the tool, ticked. Three labels in Portuguese,
in the contracted order, three descriptions in Portuguese and complete, the
paths and `endpoint` left in English as the closed list keeps them. One thing
added and it is evidence, not a statement: the run cited the `README.md`
sentence behind "there is no screen", which is what reading 6 is for.

**The two things the Behaviour asked about, both green.** Nothing was said
before the card: `no screen found` appears nowhere in either turn of the run.
And the run composed no question of its own: card 4 is the card the file
writes, where the same repository shape at 0.33.0 produced `Como a CLI é
provada?` with three options the run invented (`tools-follow-the-stack`, the
first occurrence). The Proof tool question was correctly not asked.

**The answer reached §6.** A second turn answered the six cards in Portuguese
and let the run write the nine documents. `docs/05-Process.md` §6 of the
scratch came out:

> ## 6. Prova
>
> **Tool.** Uma execução real em uma cópia descartável.

The marker stayed in English, byte for byte, which is what lets a review run
and `/apply` read it; the heading and the answer are in the documentation
language, which came out `pt-BR`. One marker and no second, which is
Contract 3.

**No regression in the other five texts.** The Language question came out
with all three of its statements, the two-patterns disclaimer was said before
the Practice questions, the four Practice questions each quoted what the code
does with the file and line cited, and the Git strategy question carried its
three options with what each buys and costs. The Graph confirmation came out
in Portuguese with its count line quoted as graphify printed it, `found 7
code, 2 docs, 0 papers, 0 images`.

**The scratch was removed.**
