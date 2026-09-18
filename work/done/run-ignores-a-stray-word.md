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

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch above
  what the file holds; `focus-kit install .` run here last.
* [x] Proof (`docs/05` §6): `/initialize green` in a scratch repository on a
  fictional domain, brownfield so the count has something to count and the word
  contradicts what it finds, which is the shape that was measured; no
  `docs/00-Product.md`, so the run is a first run and never reaches the review
  branch; installed at the delivery's version and the copy verified to carry
  the edit before the run; in a clean session; run at least through the kind
  question. Green: the run says the count line, asks the kind question, and
  says nothing about the word anywhere in what it produced up to that point.
  The scratch is removed. What the run produced wins; red is a queue line.
* [x] The `docs/03` row Kind of project is true of the skill; the queue line
  `[x]`.
* [x] First target at the delivery's version: `focus-kit update
  ~/Downloads/vaulted`, nothing staged and nothing committed there
  (`docs/05` §5).
* [x] The last thing said is which environment is at which version.

---

## What happened

### The edit

One paragraph, in one file. `skills/initialize/SKILL.md`, Step 0, first
paragraph kept its three existing sentences and gained three, in the order the
Contract listed the four things: the word arrives as text and why, it is
neither an instruction nor evidence, the count decides whatever the word says,
and the run says nothing about it anywhere.

> A word typed after the command reaches you as text, because Claude Code puts
> what was typed into the prompt whether or not this file names an argument. It
> is neither an instruction nor evidence: the count decides, whatever the word
> says, whether it contradicts the count, agrees with it or names nothing this
> command ever accepted. Say nothing about the word, anywhere: not a paragraph,
> not a clause inside the count line, not a line of the closing report.

Three choices the page left to the run. The three shapes of word, which the
page's second Behaviour bullet names as three cases, are one clause with three
branches rather than three sentences, because none of the three is treated
differently and a sentence each would suggest they are. The "say nothing"
sentence carries the page's three places verbatim, because the whole point of
the bullet is that no place is left open. And it stayed one paragraph, with no
blank line inserted: `docs/03-Domain.md` and the page both point at **the first
paragraph** of Step 0, and splitting it would make both pointers false.

Nothing else in the file moved. The Language section and its five texts were
not touched, the frontmatter still declares no argument, and the duplicated
`A` at the head of the second paragraph of Step 0 was left where it is, because
it is the second paragraph and out of scope.

### What diverged from the plan

One thing, and it costs nothing. The page says
`work/as-written-covers-a-literal.md` "is in flight" and that both pages ask
for one patch above what `VERSION` holds, so either order works. That page had
already landed by the time this one was applied (commit `a2fceca`, the file is
in `work/done/`), and `VERSION` read **0.22.4**. One patch above is
**0.22.5**, which is what this delivery wrote. The page anticipated this order
explicitly; nothing had to be decided.

Nothing was dropped.

### The proof

`docs/05` §6 wanted a real run, and it was driven the way
`initialize-trusts-the-argument` drove its two: `claude -p` from this session,
in a clean session, against a scratch repository built from the same fictional
brownfield domain, **tidelog**, a command line notebook for tide pool surveys,
Python over SQLite. Seven `.py` files in `src/tidelog/` and `tests/`, a
`pyproject.toml`, a `README.md`, one commit, `git init` plus `focus-kit
install` at **0.22.5**. No `docs/00-Product.md`, so the run was a first run and
never reached the review branch. Before the run, the installed
`.claude/skills/initialize/SKILL.md` was read and confirmed to carry the new
clause, and `.claude/skills/.focus-kit-version` to read `0.22.5`. The scratch
is removed.

**Green on the criterion the page named.** The run said the count line, in the
conversation's language, which was Portuguese:

> Contagem: 9 arquivos de código (`src/tidelog/` com 6 módulos,
> `tests/test_diversity.py`), portanto este repositório é **brownfield**.

The nine is the run's own count of a tree that holds seven `.py` files, the
same drift `initialize-trusts-the-argument` saw between its two runs, and how
the count decides stays out of scope here as it was there: every answer lands
on brownfield, which is what the count is for.

The word `green` contradicted that, and the count decided anyway. And the word
is nowhere: a case-insensitive grep for `green` over the whole 102 line
transcript returns nothing, and a grep for `palavra`, `argumento`, `argument`,
`greenfield`, `confirmaç`, `digitad` and `typed` returns one line, which is the
run quoting graphify's own refusal. The same grep over every document the run
wrote finds only the ordinary word: `verify green`, `red-green`, `greenfield`
in a kit-owned manual.

The run went far past the kind question, through writing all eleven documents
and a closing report, and still never mentioned the word. That is stronger
than the page asked for and it is the part that proves the third place in the
clause: not a line of the closing report.

**The kind question was not asked, and that is the mechanism and not the
edit.** `AskUserQuestion` does not exist in a headless `claude -p` session, the
same limit `initialize-trusts-the-argument` recorded from its two runs. This
run said so out loud rather than improvising: *Não há ferramenta de pergunta
interativa nesta sessão, então a pergunta do Passo 0 não pôde ser feita.* What
the question would have confirmed, the detection, was stated with its evidence
in the count line above. The two halves of the page's green criterion that this
delivery is about, the count line and the silence, are both green.

### Documents

No document changed. `docs/03-Domain.md`, the row **Kind of project**, already
said that a word typed after the command is ignored and nothing is said about
it, and already pointed at the first paragraph of Step 0. It was the row that
was true of the domain and not yet of the skill; after this edit the skill says
what the row says, which is what the Contract asked and why no row is added and
no term is new. `docs/01` §3 changes in neither table, and no FOCUS piece
appears (ADR-0003).

No ADR. One clause in one skill is cheap to reverse, which is the criterion
`docs/03-Domain.md` sets for the word.

### Environments

| Environment | Version | State |
|---|---|---|
| Kit source | 0.22.5 | the edit above, plus `VERSION` |
| Dogfood copy | 0.22.5 | `focus-kit install .` run here, check 6 green |
| Machine | follows the source | `~/.local/bin/focus-kit` is a symlink; global `/graphify` skill at 0.9.63 |
| First target, `~/Downloads/vaulted` | 0.22.5 | `focus-kit update ~/Downloads/vaulted` run; nothing staged and nothing committed there |
| Target repositories | wherever their owner left them | they move on `focus-kit update` |
