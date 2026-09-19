# tooling-card-follows-the-answer-on-every-host

**Goal.** A person setting up a greenfield repository is offered the test
framework, the linter and the formatter of the ecosystem they have just
answered, on whatever host they run `/initialize` under.

**Behaviour.**

* Under every Host `kit_hosts` names, a greenfield `/initialize` whose round
  3 answered a language that is not the house default composes a round 5
  tooling card whose two real options are of that ecosystem and of no other.
* Round 3 goes on offering the house default and asking nothing about a test
  framework, a linter or a formatter, and the file goes on naming no tool.
* Whatever the delivery writes it writes once and host-neutral: one text,
  read the same under every Host, naming none of them.
* A person under Claude Code, where the card was measured composing
  correctly, reads a step that still describes what their own session does.

**Contract.**

*Order.* `pointer-file-is-written-where-the-rule-stands` is `[ ]` above this
line and measures the same command under the same Hosts; `codex-port` is
`[>]` and adds a third. `/apply` reads `kit_hosts` at the time of the run for
which Hosts it measures under, and never a count written here
(`work/done/build-now-reaches-every-host.md`, Contract). A greenfield run for
this delivery passes through Step 3, which that other line owns: what it sees
there is recorded and fixed nowhere in this delivery.

*The condition the run evaluates.* Whether the card round 5 composes names
the ecosystem round 3 answered, under each Host. **`/apply` measures that
first, before it writes anything**: a greenfield scratch repository per Host,
`focus-kit install` run there, round 3 answered with a language that is not
the house default, and the round 5 tooling card read as the session composed
it. Three branches, and the page carries all three rather than a guess at
which one the runs find:

* **it reproduces under every Host**: one text in
  `skills/initialize/SKILL.md` makes the card unable to be composed without
  the answered ecosystem, and the record carries the card from before and
  after;
* **it reproduces under some Host and not others**: still one text and still
  host-neutral, because no Command's text names a Host (`docs/03-Domain.md`,
  Host), and the record says which Host showed it;
* **it reproduces nowhere**: nothing under `skills/` changes, the delivery
  closes on the record of the runs, and the queue line goes `[x]` saying what
  was measured and under what.

The wording itself is `/apply`'s, out of what the runs showed, and never this
page's. Why a Host offered the house default is not written here and is not
guessed: what the page holds is the condition and the branches.

*What grounds a verdict.* One run that reproduces the defect settles that
Host. One run that does not is not a pass: a passes verdict for a surface
needs the run made again under that same surface, because the same command is
already recorded reaching a step in two of four runs under one Host
(`docs/06-Queue.md`, Found, not discussed, `initialize-skips-ensuring-the-graph`).
How many runs that takes is `/apply`'s out of what it sees; what the page
fixes is the asymmetry between the two verdicts.

*Who makes the measurement.* Under a Host `/apply` cannot drive, it is a run
the person makes, and `/apply` names what to ask for, stops, and writes
nothing until the transcript is in front of it. Reading
`skills/initialize/SKILL.md` and reasoning about what a Host there would
compose is not the measurement (`docs/05-Process.md` §6). So the delivery has
two stops, the measurement before the edit and the proof run after it, and
the Host `/apply` is running under is the one it measures itself.

*What the measurement answers with.* The card as the session composed it,
question and options, quoted. Documents that came out right are not a pass on
their own: what is measured is the asking, which is where the defect was, and
the run the queue line quotes wrote `docs/05` §4 correctly while offering
another ecosystem's tools.

*What stays.* Round 3's house default and its citation of
`docs/manuals/focus.md` §9, which the command defaults rather than asks
(`docs/manuals/process.md` §`/initialize`). The tooling card's three options
and their order, and the rule that no tool is named in the file
(`work/done/tools-follow-the-stack.md`, Contract). The card is not a fixed
text and gains no `written here once and said entire` phrase: its offer is
computed from the previous round's answer, and what was measured wrong is
content and not language, the card having come out in the conversation's
language.

*Where a change goes.* `skills/initialize/SKILL.md` alone, plus the four
files `focus-kit install .` generates from it,
`.claude/skills/initialize/SKILL.md`,
`.github/prompts/initialize.prompt.md`, the manifest and the stamp. Whether
the text is prose inside item 5, a rule the step carries before the card, or
both, is `/apply`'s out of the measurement; whatever it is, it names no Host,
no language, no framework, no test runner, no linter and no formatter
(`docs/00-Product.md`, Non-goals; `docs/03-Domain.md`, Host).

*`docs/03-Domain.md`.* No new term, and no row moves unless the measurement
makes one false.

*`VERSION` and the dogfood copy.* Bumped and reinstalled where the branch
taken changes `skills/initialize/SKILL.md`, because a target receives a
changed Command; untouched where the third branch is taken, because nothing a
target receives moved (`docs/05-Process.md` §5).

*`selftest`.* Unchanged in kind. No check reads the step's prose beyond check
5's em dash grep and check 6's Dogfood copy diff, so the verify command is
green on the edit alone and **the proof is the run**
(`docs/05-Process.md` §6).

*No new ADR, no new file, no new dependency, no ownership change.* Nothing
here is expensive to reverse: it is prose in one kit-owned skill. Nothing is
merged and nothing is appended once.

**Slice.** `skills/initialize/SKILL.md`, plus its Dogfood copy and its Ported
command, and this repository's own documents (`docs/01-Architecture.md` §3,
Structure, neither slices nor layers: one file; §4 for where each lives). No
View, Orchestrator, Use case or Repository: §3 says none of the four exists
here. The graph named `skills/initialize/SKILL.md` with its nine sections and
nothing affected by it, which is the confirmation that what changes reaches
`bin/focus-kit` through the install and not through an edit. Kit-owned:
`skills/initialize/SKILL.md`, `.claude/skills/initialize/SKILL.md`,
`.github/prompts/initialize.prompt.md`, the manifest and the stamp.
Project-owned: `docs/06-Queue.md` and this page. Merged: nothing. Appended
once: nothing.

**States.** The defaults. No line of `bin/focus-kit` changes, so the CLI
prints exactly what it prints today.

**Visual reference.** No UI and no new CLI output. What a person reads that
may change is one question card, whose two real options are the answered
ecosystem's, so their text is the run's to compose and is not pinned here.

**Out of scope.**

* The brownfield step and the review run: the code answers the tooling there
  (`work/done/tools-follow-the-stack.md`, Out of scope).
* Moving the tooling card again, out of round 5 to anywhere: the queue line
  says a second move is not the answer.
* Round 3's house default: the command defaults it rather than asking it
  (`docs/manuals/process.md` §`/initialize`).
* Step 3 and the Host instructions file:
  `pointer-file-is-written-where-the-rule-stands` owns them, and a run here
  that passes through Step 3 records what it saw and fixes none of it.
* The deciding-later option's effect on the documents, still unproven by a
  run (`work/done/tools-follow-the-stack.md`, What the proof did not
  exercise): that is a third option's outcome and not the composition this
  line measures.
* Any text that names a Host: one Command, one text
  (`docs/03-Domain.md`, Host).

**Done when.**

* [x] `bin/focus-kit selftest` is green, check 6 included. Run before the
  measurement and again at the Close, six checks green both times at 0.40.0.
* [x] The measurement ran under every Host `kit_hosts` named at the time of
  the run, on each surface reached, with round 3 answered a language that is
  not the house default, and each card is quoted in this page as the session
  composed it. Two Hosts, three surfaces, six runs; the five that reached the
  card are quoted, and run 6 is recorded as never having reached it.
* [x] Every Host and surface the measurement says passes was run again there,
  and the second run is quoted too. **Ticked with what it cost**: Claude Code
  and Copilot CLI each got their second run, quoted. Copilot in VS Code did
  not: its second run was made and is quoted, and it stalled in round 2
  before the card, after which the person's Copilot credits ran out. That
  surface stands on one card-reaching run and the record says so.
* [x] The branch taken is named in the record, with the run that decided it.
  The third, decided by run 3.
* [ ] Where the branch changed `skills/initialize/SKILL.md`: the diff adds no
  line naming a Host, a language, a framework, a test runner, a linter or a
  formatter; `VERSION` is bumped; `focus-kit install .` has been run here, so
  the Dogfood copy, the Ported command, the manifest and the stamp match
  their source at that version. **Not this branch.**
* [x] Where the third branch was taken: `skills/`, `manuals/`, `config/`,
  `bin/` and `VERSION` are untouched, and the record says what was measured
  and under what.
* [x] The proof ran: for a branch that edited the skill, one further
  `/initialize` in a greenfield scratch repository under the Host that showed
  the defect, with the card quoted (`docs/05-Process.md` §6). For the third
  branch no skill changed, so that section asks for no run and the
  measurement is the record.
* [x] `git status` names this page moved from `work/` to `work/done/`,
  `docs/06-Queue.md` with its line at `[x]`, and, where the branch edited the
  skill, `skills/initialize/SKILL.md`, `VERSION`, the two generated copies,
  the manifest and the stamp, and nothing else of this delivery's.

---

## The measurement

`bin/focus-kit selftest` green at 0.40.0 before anything was touched, six
checks. `kit_hosts` named two Hosts at the time of the run, Claude Code and
GitHub Copilot, and Copilot was reached on both of its surfaces, so the
measurement covers three surfaces. Six greenfield scratch repositories, each
one `git init` plus a single `README.md` and no code, the kit installed at
**0.40.0** in each.

**The text under test did not move between the defect and these runs.** The
defect was measured under GitHub Copilot in VS Code on 2026-09-19 at kit
**0.38.0** (`work/done/copilot-reads-the-project-rules.md`, A second finding).
`git diff 876dd64..HEAD -- skills/initialize/SKILL.md` produces no hunk at all,
and 876dd64 is the commit that shipped 0.38.0, so the file is byte for byte the
one that composed the wrong card. Every run below exercises that same text, and
a correct composition here is not a fix taking effect.

| Run | Surface | Scratch | Round 3 | The card |
|---|---|---|---|---|
| 1 | Claude Code | `tooling-card-claude` | Flutter | of the answered ecosystem |
| 2 | Claude Code, cold | `tooling-card-claude-2` | Dart / Flutter | of the answered ecosystem |
| 3 | Copilot in VS Code | `tooling-card-copilot-vscode` | Flutter with BLoC | of the answered ecosystem |
| 4 | Copilot CLI | `tooling-card-copilot-cli` | flutter and bloc | of the answered ecosystem |
| 5 | Copilot CLI | `tooling-card-copilot-cli-2` | Flutter with Bloc | of the answered ecosystem, off the contracted shape |
| 6 | Copilot in VS Code | `tooling-card-copilot-vscode-2` | never reached | never reached |

**Five runs reached the card and not one named another ecosystem.** The sixth
never got there.

### Run 1. Claude Code, run here

Conversation in Portuguese, documentation language `pt-BR`. Round 3 answered
Flutter and asked nothing about a test framework, a linter or a formatter.
Round 5's first card asked the environments; its second card:

```
Q: O ferramental do ecossistema Flutter: framework de teste, linter e
   formatador.
   - O conjunto padrão do Flutter :: flutter_test com package:test para os
     testes, flutter analyze com package:flutter_lints para o linter e dart
     format do próprio SDK. É o que vem no template do flutter create e o que
     qualquer pessoa reconhece ao abrir o repositório.
   - flutter_test com very_good_analysis :: Mesmos testes e mesmo formatador,
     com o conjunto de lints da Very Good Ventures no lugar do flutter_lints:
     bem mais rígido, exigindo tipos explícitos e documentação pública.
   - Decidir depois :: Nada é escolhido agora. Cada seção que nomearia uma
     ferramenta ganha uma linha dizendo que a escolha ainda não foi feita e
     onde ela será feita, e uma decisão aberta entra em docs/00-Product.md.
```

**A caveat this page keeps rather than smooths.** The session that composed it
is the `/apply` session, which had read this page's diagnosis and the step's
text before the run. It cannot show what a session meeting the card cold
composes. Same shape as `work/done/build-now-reaches-every-host.md`, where a
session that had read graphify's skill twice that day ran the branch. Run 2 is
what answers it, and the Claude Code verdict does not rest on this run alone.

### Run 2. Claude Code, a cold session

Made by the person in a session that had read neither this page nor the
diagnosis. Conversation in Portuguese, documentation language English,
greenfield, sixteen cards. Round 3 offered the house default first, as
`C# no .NET (padrão da casa)`, and was answered **Dart / Flutter**. The
transcript first supplied was the `/propose lot-list` session that followed,
which holds no round 5 card; the `/initialize` itself was read from
`~/.claude/projects/-Users-jckodel-Downloads-tooling-card-claude-2/126d406c-993f-4905-9928-70fc85facdfb.jsonl`,
card 8:

```
Q: Qual ferramental de teste, lint e formatação?
   - O conjunto padrão do Flutter :: flutter_test para os testes, flutter
     analyze com o pacote flutter_lints para o lint, dart format para a
     formatação. Vem no template do framework, ninguém precisa instalar nada,
     e é o que qualquer pessoa que abrir o repositório já espera.
   - very_good_analysis no lugar do lint padrão :: Mesmo flutter_test e mesmo
     dart format, com o conjunto de regras da Very Good Ventures no
     analysis_options.yaml: bem mais severo, pega coisas que o flutter_lints
     deixa passar. Custa discutir regra em vez de código nas primeiras semanas.
   - Decidir depois :: Nenhuma ferramenta é nomeada agora. Cada seção que
     nomearia uma ganha uma linha dizendo que a escolha ainda não foi feita e
     onde ela será feita, e o comando de verificação fica incompleto até lá.
```

**With run 1, Claude Code has two runs and both compose correctly, and the pass
does not depend on the contaminated one.**

### Run 3. Copilot in VS Code

Documentation language English, round 3 answered Flutter with BLoC. The
transcript supplied elides every card behind `Analyzing your answers...`; the
card was read from VS Code's own chat store, tool call
`call_7GnIqnf7Azahpms5JIgvkmBF:0`, `vscode_askQuestions`:

```
title:   "Flutter tooling"
message: "Which test framework, linter, and formatter should this Flutter
          project use?"
 - "Flutter standard set - Use flutter_test for tests, dart analyze for
    linting, and dart format for formatting."
 - "Alternative Flutter set - Choose a credible Flutter ecosystem alternative
    and name the test framework, linter, and formatter in your response."
 - "Decide later - Choose nothing yet. The tooling choice will be made in the
    delivery that first needs it, with no placeholder tool names."
```

**This is the surface that produced the defect at 0.38.0, and against the same
text it composed correctly.** The run went to the end: nine documents, the ADR,
the language record at `en`, `docs/05-Process.md` §4 reading `flutter test &&
dart analyze && dart format --output=none --set-exit-if-changed .`, and no
`.NET` tool anywhere under `docs/` or in `CLAUDE.md`. `focus-kit doctor .`
there closes with no warning at all.

### Run 4. Copilot CLI

English throughout, round 3 answered flutter and bloc. From
`copilot-session-57e6770b-cec5-40d1-8fc0-f530600e6c9b.md`, the tooling field of
a four-field card:

```
"title": "Test, lint, and format set",
"description": "Choose the Flutter standard set, a credible alternative, or
                decide later.",
"enum": [
  "Flutter standard: flutter_test, dart analyze, dart format",
  "Alternative: very_good_analysis, flutter_test, dart format",
  "Decide later"
]
```

### Run 5. Copilot CLI, the second run

Conversation in English, documentation language Portuguese (Brazil), round 3
answered Flutter with Bloc. From
`copilot-session-08cef921-dbe9-481a-8ad9-8142e3d5ad90.md`, stopped at this card
as asked:

```
"title": "What are the test framework, linter, and formatter for this stack?",
"description": "For Flutter, examples include flutter test, dart format, and
                flutter analyze. If you're unsure, say the standard set for
                your chosen stack.",
"default": "flutter test · dart format · flutter analyze"
```

Every tool named is of the answered ecosystem, which is what this page
measures. **The shape is not the contracted one**: a free text field with a
default, no options at all, so the credible alternative was never offered and
neither was deciding later.

### Run 6. Copilot in VS Code, the second run

It **never reached the card**. Read from
`~/Library/Application Support/Code/User/workspaceStorage/a9ad4e9a82c6c37179614b212f821fe8/chatSessions/af3bbeb0-188a-4be0-985c-9671898d034c.jsonl`:
greenfield confirmed, documentation language Portuguese (Brazil), round 1
answered, and then the run stalled in round 2, asking the domain question four
times in four differently worded cards. Six cards in all and none of them the
tooling card. The `xUnit` and `dotnet` strings in that session are the
`docs/01-Architecture.md` template's own Init comment read off disk, not an
option offered to anyone.

It measures nothing this page asks about, and it is recorded so that its
scratch is not read later as a run that passed.

## The branch taken

**The third: it reproduces nowhere.** Nothing under `skills/` changes,
`VERSION` stays at 0.40.0, and no `focus-kit install .` is run, because nothing
a target receives moved (`docs/05-Process.md` §5). The run that decided it is
run 3: the same surface, against the same bytes, composing correctly where it
had composed wrongly.

**Why the page's asymmetry is reported and not quietly met.** One run that does
not reproduce is not a pass, and a passing surface needs the run made again
there. Claude Code got two and Copilot CLI got two. **Copilot in VS Code got
one**, because the second run stalled before the card and the person's Copilot
credits ran out, so no further run was available to this delivery. That surface
is therefore short of the bar the page set, and the record says so rather than
counting run 6 as anything.

What the runs establish is what they establish: the same text composed the card
of the answered ecosystem five times out of five that reached it, across three
surfaces, having composed another ecosystem's once at 0.38.0. Why that one run
offered the house default is not written here and is not guessed, which is what
the page asked for.

## What the runs showed at Step 3, owned by another line

Runs 2, 3 and 4 went to the end and passed through Step 3, which
`pointer-file-is-written-where-the-rule-stands` owns. Recorded here and fixed
nowhere in this delivery: run 3 produced `.github/copilot-instructions.md` at
the root and a `focus-kit doctor .` with no warning at all, which is the green
that line is about. Run 4 ended the same way, its `doctor` naming every
project-owned document present.

## Environments

Nothing moved. **Kit source** at 0.40.0, untouched: no file under `skills/`,
`manuals/`, `config/` or `bin/` was edited, and `VERSION` stayed where it was.
**Dogfood copy** at 0.40.0 and in sync, which is what it already was; no
`focus-kit install .` was needed or run. **Machine**: the CLI is a symlink and
follows the source. **Target repositories** untouched, as always, and they move
only when their owner runs `focus-kit update`. The six scratch repositories are
throwaway and nothing reads them.
