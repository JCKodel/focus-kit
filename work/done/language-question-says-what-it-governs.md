# language-question-says-what-it-governs

**Goal.** A person answering the Documentation language question of
`/initialize` reads, in the question itself, what the answer governs and
what it does not, so a developer who writes in one language on a project
that documents in another answers without guessing. Today Step 0 tells the
skill to offer two languages and to remind, in the option's description,
that identifiers stay in English, and nothing else; the first target's run
improvised the missing sentence and it is written nowhere
(`docs/06-Queue.md`, this line; `work/done/first-target-initialize.md`, the
Step 0 question as asked).

**Behaviour.**

* The question's text says that the answer governs the prose of `docs/00`
  to `06`, the ADRs, `CLAUDE.md`, `work/<slug>.md`, `work/done/<slug>.md`
  and the suggested commit messages, and nothing else; that the
  conversation may run in another language, whichever the person writes
  in; and that identifiers stay in English whatever the answer.
* The options stay English and Portuguese (Brazil), the language a
  brownfield repository's prose is already in offered first with what it
  was seen in, as today. A language typed under Other is taken as written:
  recorded in the three declarations as the person typed it, with no
  confirmation and no second question.
* The question is written once, in `skills/initialize/SKILL.md`, and asked
  as written: the third question of the skill to carry that rule, after the
  Proof tool question (first occurrence, `initialize-asks-for-the-proof-tool`)
  and the Practice questions (`focus-is-asked-not-imposed`).
* A review run still does not ask, and reads the declaration as today.

**Contract.** One skill, kit-owned; a target receives it on `update`.

* `skills/initialize/SKILL.md`, Step 0, item 2: the Documentation language
  question, written as asked, with the three statements above in its text
  and the two options; the brownfield rule on the language already seen
  and the rule on Other stay beside it. The Language section of the skill
  and the three declarations (`docs/05` §0, the language line of `CLAUDE.md`,
  `docs/04` §1) do not change. Its wording is the run's, inside what must
  hold: what it governs, what it does not, and identifiers.
* No template changes: `templates/docs/04-Conventions.md` §1 already says
  the conversation is a separate matter, and the queue line puts the
  sentence in the question's own text.
* `docs/03-Domain.md`, Documentation language row: gains that the question
  is written once in the skill and says what the answer governs; no new
  term. `docs/06` line `[x]`.
* `VERSION`: one patch above what the file holds.

**Slice.** `skills/initialize/SKILL.md`, kit-owned; this repository's
`docs/03` and `docs/06`, project-owned. `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), affected named 0`.
Nothing in `bin/focus-kit`, the manuals, the templates or `config/`; no
function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` asks the same two
Step 0 questions in one call; only the second one's text changes.

**Visual reference.** No UI. The record quotes the question as the run
asked it, in the conversation's language, the way
`work/done/first-target-initialize.md` quotes today's.

**Out of scope.**

* A third fixed option beyond English and Portuguese: Other carries it,
  taken as written (`docs/06`, this line).
* One sentence in the skill stating "asked as written" for all three
  questions: prose, not a layer; each page that added one says so.
* Translating the kit's own text: `docs/00`, open decision 4.
* A review run asking the language: it reads the declaration
  (`skills/initialize/SKILL.md`, Step 0).
* An ADR: reversing this is one paragraph (`docs/03`, ADR).

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch
  above what the file holds; `focus-kit install .` run here last.
* [x] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
  fictional domain, greenfield, in a clean session, the stakeholder
  writing in Portuguese and answering the language under Other with a
  third language typed. Green: the question as asked carries the three
  statements, and `docs/05` §0, the language line of `CLAUDE.md` and
  `docs/04` §1 carry the language as typed; the record quotes the question
  and the three lines. Stopped after Step 0 and the three declarations are
  written, or run to the end at the stakeholder's choice; the scratch is
  removed. What the run produced wins; red is a queue line.
* [x] The `docs/03` row edited; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## Record

**What the graph answered.** `graph: explain "skills/initialize/SKILL.md"
named 1 file (8 sections), affected named 0`. The same answer the page
carries, so nothing widened. The four branches of §Ensuring the graph were
all satisfied, so the command said nothing: the graph exists, its stamp is
`52a2b276`, which is `HEAD`, and the hook is installed.

**The question, as it ships.** The page left the wording to the run, inside
what must hold. What went into `skills/initialize/SKILL.md`, Step 0, item 2,
written once and asked as written, the way the Practice questions and the
Proof tool question already are:

```
Which language do the documents get written in? The answer governs the
prose of docs/00 to 06, the ADRs, CLAUDE.md, work/<slug>.md,
work/done/<slug>.md and the suggested commit messages, and nothing else:
this conversation runs in whichever language you write in, and identifiers
stay in English whatever you answer. Any other language is valid: type it
into the last option, Deutsch for example, and it is taken as you write it.
```

Two options, English and Portuguese (Brazil), each description saying what
the documents read like in it; the brownfield rule on the language already
seen and the rule on a language typed into the last option stay beside the
question, as prose to the run. The reminder that used to live in the
option's description is gone from there: the question carries it now.

**The proof: green on the three criteria the page names.** A scratch
repository at `<scratchpad>/greenfield-lang`, `git init` plus `focus-kit
install` at 0.21.1, and `/initialize green` in a clean session opened by the
stakeholder, who wrote in Portuguese throughout. The fictional domain is
**Aufgabenverwaltung**, a personal task manager in C# on .NET with Blazor
and SQLite. The run went to the end: nine documents, three ADRs and
`CLAUDE.md`, all in German.

The question as asked, in the conversation's language, which is what the
Language section of the skill already required:

```
Em que língua os documentos serão escritos? A resposta governa a prosa de
docs/00 a 06, das ADRs, do CLAUDE.md, de work/<slug>.md, de
work/done/<slug>.md e das mensagens de commit sugeridas, e nada além
disso: esta conversa corre na língua em que você escrever, e os
identificadores ficam em inglês qualquer que seja a resposta.

1. Português (Brasil)
2. English
3. Type something.
```

The answer was `Deutsch`, typed into the last option, and the run took it as
written: `Anotado: Deutsch. A língua tomada como você escreveu, sem
confirmação.` No second question followed. The three declarations, in the
scratch:

```
docs/05-Process.md §0   Die Dokumentationssprache dieses Projekts ist **Deutsch**.
CLAUDE.md               Prosa auf Deutsch; Bezeichner auf Englisch. Das Gespräch
                        folgt der Sprache dessen, der schreibt.
docs/04-Conventions.md  **Prosa auf Deutsch.** ... Das Gespräch ist eine eigene
§1                      Sache: es folgt der Sprache dessen, der gerade schreibt.
```

The scratch was removed.

**What the run found, and the one place this delivery diverged.** The
question said what the answer governs and it did not say that the third
option took a language: the person read `1. Português (Brasil)`, `2.
English`, `3. Type something.` and had no sentence telling them the third
one was the way to a language that is neither. The page's "Done when" says a
red is a queue line, and the stakeholder chose otherwise, in one word:
acrescentar agora. So the clause went into the same question, in the same
delivery, plus one line of guidance beside it on why the option is named by
its place and not by a label, because Claude Code writes the label itself
and what a person reads is `Type something` and not `Other`. **That clause
has no run behind it.** The three statements the page asked for were proven
by the run above; the sentence about the last option was added after it, on
the stakeholder's word, and is recorded here rather than proven.

**A second finding, left as a queue line.** The run wrote the Practice table
of `docs/01` §3 as `Praktik | Antwort | Hier ist sie`, which is the Language
section of the skill working exactly as written: table columns get
translated. Step 0 detects an already answered §3 by the literal header row
`Practice | Answer | Here it is`, so a review run in that repository would
not recognize its own table and would ask the four Practice questions again.
The two rules contradict each other and the fix is not this delivery's:
`docs/06`, `review-run-finds-a-translated-practice-table`.

**Decisions taken.** No ADR, as the page says: reversing this is one
paragraph. Two small ones, both inside the wording the page left to the run:
the last option is named by its place; and the `docs/03` row's list of what
the language governs was brought to the question's list, gaining `CLAUDE.md`
and `work/done/<slug>.md`, because `docs/03` is the single vocabulary and
the row now names the question it must not disagree with.

**What the page left to the run.** The wording, settled above, and
`VERSION`, one patch above 0.21.0, which is 0.21.1.

**Environments.** Kit source at 0.21.1. Dogfood copy reinstalled at 0.21.1,
check 6 empty. Machine follows the symlink. First target
(`~/Downloads/vaulted`) updated to 0.21.1, nothing staged and nothing
committed there. Other targets move when their owner runs `focus-kit
update`.
