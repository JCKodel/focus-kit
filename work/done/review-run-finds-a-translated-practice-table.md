# review-run-finds-a-translated-practice-table

**Goal.** A person running `/initialize` as a review on a repository whose
documentation language is not English is not asked the four Practice
questions a second time, because the review run recognizes the table the
first run wrote. Today Step 0 detects an answered `docs/01` §3 by the
literal header row `Practice | Answer | Here it is` and the Language section
of the same skill tells the run to translate table columns, so the
greenfield proof of `language-question-says-what-it-governs` on 2026-09-17
wrote `Praktik | Antwort | Hier ist sie` and a review there would ask again
(`docs/06-Queue.md`, this line).

**Behaviour.**

* The two rules stop contradicting each other on the side the queue line
  offers second: the header row is a thing the translation keeps. The
  Language section of `skills/initialize/SKILL.md` already names what stays
  as it is in a translated document, the kit's own terms, every path and
  file name; the header row `Practice | Answer | Here it is` joins that
  list, and the sentence says why: it is what a review run looks for
  (asked, 2026-09-17).
* Everything else of the table translates as today: the four cells of the
  Practice column, the answers, the third column. A translated document
  holds one English row in that table, beside `FOCUS`, `use case` and
  `/propose`, which the same sentence already keeps.
* Step 0 and Step 2 do not change: the detection stays the literal header
  row, for the reason Step 0 already gives, a §3 written before this
  version has the pieces table and nothing else.
* A review run on a repository the first run wrote in any documentation
  language finds the row, asks no Practice question and proposes no edit to
  §3 on that account.

**Contract.** One skill, kit-owned; a target receives it on `update`.

* `skills/initialize/SKILL.md`, Language section: the sentence that lists
  what a translated document keeps as it is gains the header row `Practice
  | Answer | Here it is`, written there as the literal Step 0 names, and the
  reason in a clause. Step 0 and Step 2 keep their two mentions of the row
  as they are. The wording is the run's, inside what must hold: the row
  stays in English whatever the documentation language, and the skill says
  it is because a review run detects the table by it.
* `skills/initialize/templates/docs/01-Architecture.md` §3: the header row
  itself does not change. Whether the init comment beside the table points
  at the rule is the run's; the rule is stated once, in the Language
  section.
* `docs/03-Domain.md`, Practice row: gains that the table is recognized by
  its header row, which stays in English whatever the documentation
  language; no new term. `docs/06` line `[x]`.
* `VERSION`: one patch above what the file holds.

**Slice.** `skills/initialize/SKILL.md`, kit-owned; this repository's
`docs/03` and `docs/06`, project-owned. `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), affected named 0;
explain "skills/initialize/templates/docs/01-Architecture.md" named 6
templates, affected named 2 (the 00 and 02 templates, which reference it
and do not change)`. Nothing in `bin/focus-kit`, the manuals or `config/`;
no function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. `/initialize` asks the same
questions it asks today; only what it writes into a translated §3 changes,
by one row.

**Visual reference.** No UI. The row a translated `docs/01` §3 must hold,
as the template writes it today:

```
| Practice | Answer | Here it is |
```

**Out of scope.**

* A marker line that survives translation: a second kind of comment beside
  the init comments that may not survive, with a rule of its own (asked,
  2026-09-17).
* The `**Tool.**` line of `docs/05` §6: the queue line names the Practice
  table alone, and Step 0 detects the tool by reading, "names no tool", not
  by a literal (`skills/initialize/SKILL.md`, Step 0).
* A repository already holding a translated table: none exists, the German
  scratch was removed and the first target's §3 is English with no Practice
  table; a mechanism with no error behind it stays out (`docs/00`, Values,
  Removable; product question 6).
* Which language the Practice questions are asked in: the next queue line,
  `asked-as-written-says-which-language`.
* Translating the kit's own text: `docs/00`, open decision 4.
* An ADR: reversing this is one clause (`docs/03`, ADR).

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one patch
  above what the file holds; `focus-kit install .` run here last.
* [x] Proof (`docs/05` §6): `/initialize` in a scratch repository on a
  fictional domain, greenfield, in a clean session, the stakeholder
  answering the language with one that is not English, run at least until
  `docs/01` is written. Green: its §3 holds the row above byte for byte and
  the rest of the table in the chosen language. Then `/initialize` again in
  the same scratch, a new clean session: green when it asks no Practice
  question and proposes no edit to §3 for want of the table; the Graph
  confirmation, if reached, is the stakeholder's to answer. The record
  quotes the row and what the review run said of §3. The scratch is
  removed. What the run produced wins; red is a queue line.
* [x] The `docs/03` row edited; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## Record

**What the graph answered.** `graph: explain
"skills/initialize/SKILL.md" named 1 file (8 sections), affected named 0`.
The Slice's second line, over the template, was not asked again: the
template's header row does not change, and the two templates that reference
§3 reference the section and not its header row.

**What changed in the kit source.**

* `skills/initialize/SKILL.md`, Language section. The sentence that lists
  what a translated document keeps as it is now reads:

  > Keep the template structure, the section order and the technical terms
  > this kit defines (FOCUS, use case, orchestrator, repository, slice,
  > `/propose`, `/apply`), keep every path and file name as it is, and keep
  > one row of one table: the header row `Practice | Answer | Here it is` of
  > `docs/01-Architecture.md` §3 stays in English whatever the documentation
  > language, because it is what a review run looks for to know the four
  > Practice questions were already answered (Step 0). The rest of that
  > table translates like the rest of the document: the four Practice names,
  > the answers and the third column.

  The literal is the same bytes Step 0 and Step 2 already name, so the file
  now holds it three times and the three agree.
* `skills/initialize/templates/docs/01-Architecture.md`. The init comment
  below the Practice table gained one clause: `The header row above is the
  one row that is not translated; the Language section says why.` The page
  left that to the run, and it earns its place for a reason the page could
  not see: Step 2's own writing rule lists what stays in English while the
  documents are being written, the code names of `docs/03`, paths, file
  names and the kit's terms, and the header row is none of the four. The run
  that is translating the table is reading Step 2 and the template, not the
  Language section. The rule itself is still stated once; this is a pointer
  at it, and the command removes it with every other init comment.
* `VERSION`: `0.22.0` to `0.22.1`.

**What the Contract asked for and was already there.** The `docs/03-Domain.md`
Practice row. The sentence it asks for was written by `b4611e3`
(`doctor-sees-an-unbumped-change`), which cited this slug before this
delivery ran:

> The table is recognized by its header row, `Practice | Answer | Here it
> is`, which stays in English whatever the Documentation language, the one
> row the translation keeps beside the kit's own terms
> (`review-run-finds-a-translated-practice-table`).

It was read word for word against the sentence this delivery put into the
skill and they agree. Nothing was written there, and the "Done when" item is
ticked on the file's state and not on an edit of this delivery.

**The proof: green on both halves.** A scratch repository in this session's
scratchpad, `git init` plus `focus-kit install` at 0.22.1, and two clean
sessions opened by the stakeholder, who wrote in Portuguese throughout. The
fictional domain is **To Do List**, a task list in C# on .NET with Blazor
WebAssembly, no server and no account, and the documentation language
answered was **Deutsch**, typed into the last option.

The first run wrote nine documents, three ADRs and `CLAUDE.md`, all in
German. Its §3, read off the disk by this session:

```
47:| Practice | Answer | Here it is |
48:|---|---|---|
49:| Struktur | Vertikale Slices | `src/Features/<Feature>/`, eine flache Ordnerebene pro Feature, ohne Unterordner |
50:| Regeln | Reine Use Cases hinter einem Orchestrator | eine `public static`-Methode in einer nach dem Verb benannten Klasse, ohne IO und ohne Framework |
51:| Fehler | Als Wert | eine `abstract record`-Familie pro Verb mit `sealed record`-Varianten und handgeschriebenem `Match`; `WarningsAsErrors` macht CS8509 zum Fehler |
52:| Tests | Ein Test pro Stück | `docs/04-Conventions.md` §5 |
```

`grep -c '^| Practice | Answer | Here it is |$'` returns `1`: the row byte
for byte, the four Practice names, the answers and the third column in
German. The run said so on its own, without being asked to check it.

The second run, `/initialize` with no argument in a new clean session, read
the repository and said, before any question:

> docs/01-Architecture.md §3 trägt die Kopfzeile Practice | Answer | Here it
> is, die vier Practices sind also schon beantwortet; docs/05-Process.md §6
> nennt ein Werkzeug. Beide Fragenblöcke entfallen.

and, in its report:

> docs/01-Architecture.md §3 já traz a linha de cabeçalho Practice | Answer
> | Here it is em inglês, com os quatro nomes de Practice, as respostas e a
> terceira coluna em alemão. É exatamente o que o skill especifica, e é o
> sinal de que as quatro perguntas já foram respondidas.

No Practice question was asked. The two edits it did propose to §3 came from
a domain ambiguity it found and asked about, a rejection named only in prose,
and not from the Practice table, which is what the page's green requires. The
scratch was removed.

**What the proof found that is not this delivery.** Step 0 contradicts
itself on the argument. `skills/initialize/SKILL.md:66` says `If $ARGUMENTS
says green or brown, trust it`, and `skills/initialize/SKILL.md:89` says of
the kind of project `Say which you detected and let them confirm`. The first
run was started with `/initialize green` and still asked, and the option's
own description cited the argument it was reconfirming. The run obeyed the
text; the text is what is wrong. A queue line, not a patch inside this
delivery.

**What this commit carries that is not this delivery.** Two things, both
asked for. The `/propose` of `asked-as-written-says-which-language` ran
before this session: its page `work/asked-as-written-says-which-language.md`
and its `[>]` mark in `docs/06` were on disk when `/apply` started and are
staged by the same `git add -A`. And the queue line
`[ ] initialize-trusts-the-argument`, written on the stakeholder's word after
the proof found the defect above.

One grep for completeness, because the rule now lives in one sentence and a
second copy of it would be the thing to keep in step: the literal `Practice |
Answer | Here it is` appears in `skills/`, `manuals/` and the templates only
in `skills/initialize/SKILL.md`, three times, and in
`skills/initialize/templates/docs/01-Architecture.md`, once, which is the row
itself. `manuals/process.md` names the four practices and never the table's
header row, so it owns nothing of this rule and did not change.

## Environments

| Environment | State |
|---|---|
| Kit source | 0.22.1 |
| Dogfood copy | 0.22.1, `focus-kit install .` run here last |
| Machine | the CLI is a symlink to `bin/focus-kit` and follows the source; global `/graphify` skill at the package's version |
| First target (`~/Downloads/vaulted`) | 0.22.1, `focus-kit update` run, `doctor` green on the version, nothing staged and nothing committed |
| Other targets | untouched; they move when their owner runs `focus-kit update` |
