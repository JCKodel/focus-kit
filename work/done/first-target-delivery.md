# first-target-delivery

**Goal.** One delivery has gone through `/propose` and `/apply` in a
repository that is not this one, start to finish, and one page records what
the two commands asked, wrote, verified and left, and what a person had to
work out alone, each miss as a queue line. With it milestone 2 has run the
whole cycle the kit claims (`docs/06-Queue.md`). Until now `/propose` and
`/apply` have only ever run here, on the kit itself.

The first target is `~/Downloads/vaulted` at `f6e685c`, initialized by
`first-target-initialize`: its own `docs/00` to `06`, `docs/adr/` and
`CLAUDE.md`, prose in English, a queue whose first line is `test-harness`
(install Vitest, add `npm run test`, make verify lint + test + build), a
verify slot of `npm run lint && npm run build`, two environments, local and
production on GitHub Pages where merging is publishing, and a git policy of
one branch per delivery. The delivery that runs there is `test-harness`: it
is the first line of that queue and the order is the decision, it changes
the verify slot, so `/apply` there has to edit `docs/05` §4, `docs/04` §5
and `package.json` in the same delivery, and its `/propose` has to name the
one dependency `/apply` is forbidden to add unnamed.

**Behaviour.**

Neither run is `/apply`'s to make. Both commands load from the target's
`.claude/skills/` and `/propose` is interactive, so the stakeholder runs
them in Claude Code opened in the target, before `/apply
first-target-delivery` starts here. Then:

* Before the runs, `focus-kit update ~/Downloads/vaulted` when the stamp
  there differs from `VERSION`, so both use the kit at the delivery's
  version (`docs/05-Process.md` §5).
* The stakeholder types `/propose test-harness` and answers as the person
  owning the repository would. Then, in a new session, `/apply
  test-harness`. The clone stays on its current branch: nothing is committed
  there, so a branch without a commit is ceremony, and whether either
  command notices the policy in the target's `docs/05` §7 is a datum that
  maps to `git-branches-are-queue`. The runs happened while this page was
  being written, in one session with no new session between the two
  commands, and `/apply` there skipped the graph procedure because of it.
  The divergence and its consequence are recorded, and the closing message
  of `/propose`, which ends at "`/apply <slug>` implements" and never says
  to open a new session, is a finding.
* Whatever `/apply` stages, `git reset` in the target undoes before the
  record is written. The working tree stays as the run left it, packages
  included: the clone is disposable and its row leaves with milestone 2.
* `/apply` here reads four sources: the one session transcript under
  `~/.claude/projects/-Users-jckodel-Downloads-vaulted/` newer than the one
  `first-target-initialize` read, which holds both commands; the files the runs wrote,
  `work/done/test-harness.md`, the docs they changed and the code; the
  target's own verify command, run here in the clone; and `focus-kit doctor
  ~/Downloads/vaulted`. The transcript is the session that holds `/propose
  test-harness` and `/apply test-harness` as user turns; any other newer
  session is listed by file name and ignored. It is processed for the
  questions asked, the files read and the commands run, not pasted.
* A finding against `/propose` there is any of: a question asked whose
  answer a file in the target holds, with that file named; the graph not
  ensured or not asked before reading; `work/test-harness.md` longer than
  one page, or its Contract inexact, or a term in it absent from the
  target's `docs/03`; code, config or test written; the queue mark not
  turned to `[>]`; an em dash.
* A finding against `/apply` there is any of: any question asked at all,
  except one whose cause is this project's own protocol, the `/initialize`
  output never committed in the clone, which is recorded and is not a
  finding; the verify command not run to green, or the new one not the one
  `test-harness` names; a slot the delivery changed left stale in `docs/05`
  §4 or `docs/04` §5; a dependency, layer or tool the page did not name;
  "Done when" not ticked, the page not moved to `work/done/`, the queue line
  not `[x]`; no closing message naming local and production and the command
  that moves them; a commit or push there, disqualifying on its own; an em
  dash.
* Against both: the verify red when run here, a warn from `doctor` after the
  runs, and anything a person would have to work out alone, as in the two
  records before this one.
* Each finding becomes a queue line, unless a line here already names it,
  and then the done page maps to that line and adds nothing. Zero findings
  is a result too, and then the done page says so.

**Contract.**

No kit-owned file changes and `VERSION` stays where the apply session finds
it. Four project-owned files carry the delivery:

| File | Exactly |
|---|---|
| `work/done/first-target-delivery.md` | after the page, `## What happened`: the kit version the runs used; the transcript file by name; for `/propose`, every question asked, numbered, with the file that answered it when one did, and the files read before asking; for `/apply`, every question asked, the commands it ran with their exit status as the transcript shows, the files it wrote, the docs it changed, and its closing message; `git status --short` in the target before the runs, after them, and after `git reset`; the verify command as run here with its last lines; the `doctor` transcript after the runs, ANSI stripped, the absolute path written as `<target>`. Then `## Findings`, numbered: seen, expected, the queue line it became or maps to. Only the runs' own text is quoted, never a line from the target's own files; a quoted line that carries an em dash has the character replaced by its codepoint name, and the em dash is a finding. |
| `docs/06-Queue.md` | one `[ ]` line per new finding, directly after `first-target-delivery`, in the order found, in the shape of the lines around it: slug naming what it fixes, description of what happens today. Reordering is the stakeholder's, in conversation. |
| `docs/05-Process.md` §5 | the First target row reads installed, initialized and taken through one delivery at the delivery's version. The row leaves when milestone 2 closes, at the review, not here. |
| `docs/03-Domain.md` | the term First target, already amended by this `/propose`: what any command stages there is undone, and the working tree stays as the last run left it. |

**Slice.** This repository's own docs and `work/`, all project-owned. No
skill, no manual, no template, no `config/`, no `bin/`. What the runs
exercise is `skills/propose/SKILL.md`, `skills/apply/SKILL.md` and
`manuals/process.md` §4 and §5, through the copies `install` put in the
target; a finding about them is a queue line, never an edit here.

**States.** The defaults, in the target, which starts where
`first-target-initialize` left it: `HEAD` at `f6e685c` on `master`, nothing
staged, `doctor` all green. If the transcript is not there, the runs have
not happened: `/apply` stops, names the precondition and writes nothing. If a run stops midway, the record stops there and the fix is a
queue line. The graph and the hook exist there since `/initialize`, and the
report carries no `Built from commit` line (`first-target-initialize`,
finding 2), so what each command does at the third branch of the graph
procedure is recorded and maps to `graph-staleness-without-a-stamp`; a
rebuild that bills tokens is recorded with the cost from the target's
`graphify-out/cost.json` and maps to `graph-cost-is-confirmed`. Neither is a
new line.

**Visual reference.** No UI. `doctor` on the target after the runs prints
every line it printed after `/initialize`, all green, and the verify command
run here in the clone ends with `next build` reporting the static export.

```
  ✓ docs/00-Product.md
  (six more, docs/01 to docs/06)
  ✓ CLAUDE.md
  ✓ graphify-out/graph.json
  ✓ graphify post-commit hook
```

**Out of scope.**

* Fixing anything found: milestone 2 brings friction back as queue lines,
  and a fix here would bump `VERSION` on a page that is a record.
* A second delivery there, one with a screen: the visual proof in the
  target's `docs/05` §6 stays unexercised, a candidate queue line if the
  stakeholder wants it.
* Closing milestone 2: the whole-branch review is the stakeholder's
  (`docs/05-Process.md` §9), and it is what removes the §5 row.
* A branch, commit, push or merge in the target: it is someone else's
  clone, and the branch policy already maps to `git-branches-are-queue`.
* Restoring the clone to `f6e685c`: the tree stays for inspection, and the
  row leaves with the milestone.
* A run on the Windows host: nothing here is platform dependent.
* An ADR: reversing this is `git clean` in a clone and one row edited.

**Done when.**

* [x] Both runs happened in the target through the installed skills at
  `VERSION`, `/propose test-harness` then `/apply test-harness`; the
  transcript file is named in the done page, and the session it shared is
  recorded as a divergence.
* [x] The done page carries every section the Contract names; `git status
  --short` in the target after `git reset` shows nothing staged.
* [x] The target's verify command, run here in the clone, is green, or its
  red is a finding; `focus-kit doctor ~/Downloads/vaulted` prints no warn,
  or every warn it prints is a finding.
* [x] Every new finding is a `[ ]` line after `first-target-delivery` in
  `docs/06`, and the done page maps every finding to a line.
* [x] `docs/05-Process.md` §5 First target row says taken through one
  delivery.
* [x] `bin/focus-kit selftest` green; `VERSION` unchanged; `git status`
  here shows changes under `docs/` and `work/` only.
* [x] Environments: kit source and dogfood copy at `VERSION`, untouched;
  machine follows the symlink; first target installed, initialized and
  taken through one delivery at `VERSION`, nothing committed there; other
  targets untouched. The closing message names all five.

---

## What happened

Both runs happened and both finished. `/propose test-harness` asked four
questions in one call, wrote `work/test-harness.md` and turned the queue
line to `[>]`, writing no code. `/apply test-harness` installed one
devDependency, wrote a test and a config, edited the workflow, brought four
documents into agreement with the new verify command, ran that command red
on purpose and then green, ticked its own eight checks, moved the page to
`work/done/` and staged 42 files without committing. Neither stopped midway.

One thing diverged from the page and it is the one the page itself
anticipated: **the two commands ran in the same session**, with no new
session between them. `/propose` ended, and the next user turn in the same
transcript is `/apply test-harness`. The consequence is recorded below and
it is the first finding.

The headline result is the mirror image of `first-target-initialize`. There,
six questions were asked and not one of them had its answer in a file. Here,
six questions were asked too, four by `/propose` and two by `/apply`, and
they split four ways: **one is answered by two files the earlier run
wrote**; three are real decisions no file can make; one should never have
reached a person, because it exists only to repair a Contract written
without running anything; and one is excluded by this project's own
protocol. All three findings land on `/propose`, including the one whose
visible symptom is `/apply` asking a question.

`<target>` stands for the absolute path of `~/Downloads/vaulted` in every
transcript here. What is quoted is the runs' own text: their questions,
their messages, the commands they ran and the files they wrote. Two of those
files, `docs/06-Queue.md` and `docs/04-Conventions.md` in the target, are
quoted in finding 1; they are not the target's own authored prose but the
output of the `/initialize` run recorded one delivery ago, verified em dash
free on that page and again on this one. No line of the repository's own
writing is on this page.

### The kit version the runs used

`0.8.1`. `.claude/skills/.focus-kit-version` in the target reads `0.8.1`,
and `focus-kit doctor <target>` after the runs prints `kit version 0.8.1`.
The stamp already matched `VERSION` when the session opened, so no
`focus-kit update` was needed before the runs.

### The transcript

One session folder. One file in it is newer than the one
`first-target-initialize` read, and it holds both commands as user turns:

```
~/.claude/projects/-Users-jckodel-Downloads-vaulted/
  d055fa73-b0ed-4b9e-b58c-1b66d6adf905.jsonl
```

357 entries. There is no other newer session to list and ignore: the only
other file in the folder is
`77641228-cc4d-4c03-8516-31b12254ae9e.jsonl`, which is the one the previous
record read. Every quotation and every count below comes from `d055fa73`,
processed rather than pasted. Entry numbers in square brackets are its line
numbers.

### `/propose test-harness`

**The files it read before asking.** Nineteen reads and surveys, in this
order, ending at the question call:

```
ls -la docs, docs/adr, docs/manuals, work, graphify-out
docs/06-Queue.md, docs/00-Product.md
docs/05-Process.md, docs/04-Conventions.md, docs/01-Architecture.md
package.json, next.config.ts, tsconfig.json, ls of the repository root
docs/manuals/graphify.md (first 80 lines), docs/03-Domain.md
graph: grep for "Built from commit", git rev-parse HEAD, graphify hook status
graphify-out/GRAPH_REPORT.md (first 20 lines), graphify-out/manifest.json
graphify query "test framework, vitest, npm scripts, verify command,
  pure functions in lib/vaulted.ts"
.github/workflows/deploy-pages.yml, lib/vaulted.ts (lines 1 to 15, 139 to 160)
```

The graph was asked at [97] and the only code read, `lib/vaulted.ts` and the
workflow, came after it at [108]. `docs/02-Backend.md` was never opened,
which is correct: the target has no server.

**Its assessment before the questions**, at [113], which named the cost of
the delivery before asking anything:

> `test-harness` é a primeira linha da fila e é a única que não entrega nada
> ao usuário: ela existe para que as seis linhas seguintes possam ser
> provadas. O contrato caro aqui não é o vault (ele não muda), são os
> scripts do `package.json` e as quatro frases espalhadas pela documentação
> que hoje dizem que não há testes.

**The four questions, numbered, at [114], all in one call.**

**1. Which test goes with the harness.** "Que teste acompanha o harness? Um
runner sem nenhum teste não prova nada." Three options, recommended: a smoke
test on `getMonthKey`. Answer: **the recommendation**. No file answers it.
`docs/03-Domain.md` holds the UTC month invariant, which is why the option
exists, but which invariant to lock first is a scoping decision.

**2. Which test libraries enter now.** "Quais bibliotecas de teste entram
agora?" Three options, recommended: vitest alone, node environment. Answer:
**the recommendation**. **Two files answer it**, and that is finding 1.

**3. Whether CI starts running the tests.** "O CI passa a rodar os testes?
Hoje o workflow roda apenas npm ci && npm run build, sem lint." Three
options, recommended: CI runs the whole verify. Answer: **the
recommendation**. No file answers it. The workflow states what happens
today, which the question states as fact; whether to change it is a
decision, and it is the one decision on this page that touches production.

**4. Whether verify becomes a script.** "O comando verify vira um script no
package.json?" Two options, recommended: yes, `npm run verify`. Answer:
**the recommendation**. No file answers it. `docs/04` §5 and `docs/05` §4
both wrote the chain out longhand, which is the argument for the script, not
an answer to whether to add one.

**What it wrote.** `work/test-harness.md`, 130 lines, in four passes, and
one edit to `docs/06-Queue.md` turning line 23 from `[ ]` to `[>]`. No code,
no config, no test, nothing staged. It checked its own page for em dashes at
[164] and counted zero.

**Its closing message**, at [168], ends:

> Nada foi estagiado nem commitado. `/apply test-harness` implementa.

That last sentence is finding 2.

### `/apply test-harness`

**Its first words**, at [177], before any tool call:

> O grafo foi verificado no início desta sessão: construído hoje, hook
> `post-commit` instalado. Começo pela instalação.

It never ran `graphify query`. That is the consequence of the shared
session, and it belongs to finding 2.

**The questions it asked. Two.**

**1. Which vitest to install**, at [191], after `npm install -D vitest`
failed. One question, two options, recommended `vitest@4.1.11`. Answer:
**the recommendation**. This is a question asked, and it is finding 3.

**2. How to get the work into history**, at [346], after staging. Three
options, recommended a branch. Answer: **"Ficar em master, só estagiado"**,
which is this project's rule for the clone and not the target's own policy.
Its cause is exactly the one the page excludes: the `/initialize` output has
never been committed in the clone, so `git add -A` swept 37 files of kit
installation in with the 5 of the delivery. Recorded, not a finding. Its
prose, at [345]:

> O repositório carrega **duas** obras não commitadas: esta entrega (5
> arquivos) e a instalação inteira do focus-kit vinda do `/initialize` (37
> arquivos, incluindo `CLAUDE.md`, `docs/` e `.claude/`), que nunca foi
> commitada. `docs/05-Process.md` §7 diz que o branch carrega os commits da
> entrega e nada mais, e estamos em `master`, onde um commit é um deploy.

That is `/apply` reading the target's own §7 and offering the branch it
requires. `/propose` never mentioned §7. The datum maps to
`git-branches-are-queue` and adds no line.

**The commands it ran, with their exit status as the transcript shows.**

| # | Command | Status |
|---|---|---|
| [178] | `node --version && npm --version && npm install -D vitest` | the tool reports no error, because `\| tail -20` masks the pipeline's status; the output is `npm error Conflicting peer dependency: @types/node@22.20.3`, so the install failed |
| [182] | `npm view vitest@{3,4,5}` for `engines` and the `@types/node` peer | ok. vitest 5.0.1 wants Node `^22.12 \|\| ^24 \|\| >=26`; 4.1.11 wants `^20 \|\| ^22 \|\| >=24` |
| [194] | `npm install -D vitest@^4.1.11` | ok, npm warnings only |
| [197] | `node -e` reading the installed versions back | ok. `vitest: ^4.1.11`, `@types/node: ^20`, `installed: 4.1.11` |
| [229] | `npm run verify` | ok, first green run |
| [233] | `npm run test` | `EXIT=0`, `Test Files 1 passed (1)`, with a Vite warning about the config being loaded as CommonJS |
| [242] | `mv vitest.config.ts vitest.config.mts && npm run test` | ok, `Tests 2 passed (2)`, warning gone |
| [247] | one assertion broken on purpose, then `npm run verify` | **`EXIT=1`**, `FAIL lib/vaulted.test.ts`, and `Creating an optimized production build` appears **0** times: the build never started |
| [252] | restore the test, `find out -name "*.test.*"` | ok, 0 test files in the export |
| [289] | grep over `CLAUDE.md` and `docs/0*.md` for the sentences that said there are no tests | ok, six hits, all of them the new text or unrelated |
| [293] | `npm run verify` on the clean tree | **`EXIT=0`**, `Test Files 1 passed (1)`, `Tests 2 passed (2)`, `Compiled successfully in 1639ms`; `tsconfig.json` untouched, no `vitest/globals` anywhere |
| [323] | move the page to `work/done/`, count em dashes | ok, 0 |
| [330] | `git branch --show-current`, `git status --porcelain` | ok, `master`, 20 paths |
| [334] | `git add -A` | ok, 42 paths, `42 files changed, 4812 insertions(+), 48 deletions(-)` |
| [338] | `git diff --cached --stat` split between the delivery and the installation | ok, 5 files against 37 |

The red check at [247] is the one the delivery existed to make, and it is
the strongest single result on this page: a harness that finds nothing also
passes green, and this one does not.

**The files it wrote.** Three created, one renamed, three edited that are
not documents:

```
lib/vaulted.test.ts          (15 lines, describe/it/expect imported explicitly)
vitest.config.ts             written, then renamed to vitest.config.mts
package.json                 test, test:watch and verify scripts; vitest devDependency
package-lock.json            npm's, 1159 lines
.github/workflows/deploy-pages.yml
                             the step "Build (static export)" running npm run build
                             becomes "Verify (lint, test, build)" running npm run verify
work/done/test-harness.md    the page, closed and moved
```

**The docs it changed.** Four, each one a sentence that had said the
repository has no tests:

```
CLAUDE.md               the verify line
docs/01-Architecture.md §2, the Tests line of the stack table
docs/01-Architecture.md §7, the sentence describing what the workflow runs
docs/04-Conventions.md  §5, the verify chain and the runner paragraph
docs/05-Process.md      §4, the block in full
docs/06-Queue.md        line 23 to [x]
```

Both slots the page had to change are current. `docs/05` §4 now reads `npm
run verify` and spells out lint, test and build in order; `docs/04` §5 now
reads `verify = npm run verify = npm run lint && npm run test && npm run
build` and names the runner as Vitest 4 in `vitest.config.mts`. Neither is
stale.

**Its closing message**, at [350], names both environments and what moves
them:

> | Ambiente | Estado |
> | local | na versão do repositório, `npm run verify` verde |
> | produção (vaultedworth.com) | intocada, ainda servindo o build de `f6e685c` |
>
> Produção só se move quando uma pessoa mergear o pull request. A edição do
> workflow é inerte até lá; a partir dela, um lint vermelho ou um teste
> falhando param o deploy antes de qualquer coisa chegar ao Pages.

It then suggested a commit message whose fourth bullet says the commit also
carries the `/initialize` installation, and ended with "Não commitei." No
commit and no push were made: `git log --oneline -1` in the target is still
`f6e685c`.

### `git status --short` in the target

**Before the runs.** Reconstructed, as in the previous record: the
transcript's first command of either run is an `ls`, so there is no bare
capture from immediately before. It is the post-reset block
`first-target-initialize` recorded, and the reconstruction is checkable:
subtract this delivery's five paths from the post-run capture at [330] and
exactly these fifteen remain.

```
 M .gitignore
?? .claude/
?? .gitattributes
?? .mcp.json
?? CLAUDE.md
?? docs/00-Product.md
?? docs/01-Architecture.md
?? docs/02-Backend.md
?? docs/03-Domain.md
?? docs/04-Conventions.md
?? docs/05-Process.md
?? docs/06-Queue.md
?? docs/adr/
?? docs/manuals/
?? work/
```

**After the runs**, the run's own capture at [330], before its `git add -A`,
20 paths:

```
 M .github/workflows/deploy-pages.yml
 M .gitignore
 M package-lock.json
 M package.json
?? .claude/
?? .gitattributes
?? .mcp.json
?? CLAUDE.md
?? docs/00-Product.md
?? docs/01-Architecture.md
?? docs/02-Backend.md
?? docs/03-Domain.md
?? docs/04-Conventions.md
?? docs/05-Process.md
?? docs/06-Queue.md
?? docs/adr/
?? docs/manuals/
?? lib/vaulted.test.ts
?? vitest.config.mts
?? work/
```

Then `git add -A` staged 42 paths.

**After `git reset`**, run in the target by this apply before the record was
written. Nothing staged; the working tree is exactly as the run left it,
`node_modules` and all, which is what the amended term in `docs/03-Domain.md`
now says:

```
 M .github/workflows/deploy-pages.yml
 M .gitignore
 M package-lock.json
 M package.json
?? .claude/
?? .gitattributes
?? .mcp.json
?? CLAUDE.md
?? docs/00-Product.md
?? docs/01-Architecture.md
?? docs/02-Backend.md
?? docs/03-Domain.md
?? docs/04-Conventions.md
?? docs/05-Process.md
?? docs/06-Queue.md
?? docs/adr/
?? docs/manuals/
?? lib/vaulted.test.ts
?? vitest.config.mts
?? work/
```

`git log --oneline -1` is `f6e685c`, on `master`. Nothing was committed or
pushed there.

### The verify command, run here in the clone

`npm run verify` in `~/Downloads/vaulted`, from this apply session, after the
reset. **`EXIT=0`.**

```
> vaulted@0.1.0 verify
> npm run lint && npm run test && npm run build

 Test Files  1 passed (1)
      Tests  2 passed (2)
   Duration  70ms

✓ Compiled successfully in 1461ms
  Finished TypeScript in 1219ms ...
✓ Generating static pages using 9 workers (17/17) in 146ms

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /blog
  (eleven more static routes)
└ ○ /tools/net-worth-percentile

○  (Static)  prerendered as static content
```

It is the Visual reference: `next build` reporting the static export, from a
session that is not the run's, with no session state behind it.

### `focus-kit doctor <target>` after the runs

```
focus-kit 0.8.1 doctor: <target>
  ✓ uv
  ✓ graphify
  ✓ graphify-mcp (mcp extra)
  ✓ global /graphify skill
  ✓ /initialize
  ✓ /propose
  ✓ /apply
  ✓ kit version 0.8.1
  ✓ docs/00-Product.md
  ✓ docs/01-Architecture.md
  ✓ docs/02-Backend.md
  ✓ docs/03-Domain.md
  ✓ docs/04-Conventions.md
  ✓ docs/05-Process.md
  ✓ docs/06-Queue.md
  ✓ CLAUDE.md
  ✓ docs/manuals/process.md
  ✓ docs/manuals/focus.md
  ✓ docs/manuals/graphify.md
  ✓ .mcp.json
  ✓ .claude/settings.json
  ✓ kit-owned files as install wrote them
  ✓ graphify-out/graph.json
  ✓ graphify post-commit hook
```

Exit 0, ANSI stripped, no warn. Twenty-four green lines, the same
twenty-four as after `/initialize`: a delivery ran through the repository
and moved nothing `doctor` watches, which is what a delivery should do.

### The graph procedure, at its third branch

Neither command rebuilt anything. `graphify-out/cost.json` in the target is
byte for byte the file `first-target-initialize` recorded, one run of
433,524 input tokens, so `graph-cost-is-confirmed` was not exercised by this
delivery and gains nothing.

The third branch of the procedure, `Built from commit` against `git rev-parse
HEAD`, behaved in two different ways:

* **`/propose` evaluated it and it was not evaluable.** At [88] it ran the
  grep together with `git rev-parse HEAD`; the grep printed nothing, because
  the report has no such line, and the only output was the HEAD. It then
  read the report's first 20 lines and decided on the date instead: "O grafo
  foi construído hoje, depois dos documentos, e o hook post-commit está
  instalado. Nada a refazer ali." Correct conclusion, reached by a rule that
  is not in the procedure.
* **`/apply` never reached the branch**, because it reused `/propose`'s
  conclusion from earlier in the same session.

Both map to `graph-staleness-without-a-stamp`, already in the queue. No new
line.

### The mechanical checks the Contract names

* **Em dash.** Zero, in all ten files the runs wrote or edited in the target,
  and zero in the runs' own messages. Two of their commands contain the
  character, both of them as the pattern of a `grep -c` counting it in the
  page they had just written, which is the check working, not a violation.
  Nothing on this page reproduces those two lines.
* **`work/test-harness.md` longer than one page.** 130 lines before `/apply`
  closed it, 191 after. The pages in this repository's own `work/done/` run
  from 121 to 157 lines before their record. Not a finding; inventing a line
  count here would be inventing the rule.
* **A term in the page absent from the target's `docs/03`.** None.
  `getMonthKey`, `calculateTotals` and `VaultedData` are all in the terms
  table. `vitest` is a tool, not a concept, and belongs to `docs/04` §5,
  where it is.
* **The Contract inexact.** One character: the page specified
  `vitest.config.ts` and the run produced `vitest.config.mts`, because with
  `.ts` the config loads as CommonJS and Vite warns on every run. `/apply`
  recorded the divergence on its own page rather than absorbing it. It is
  the second occurrence of the pattern behind finding 3, not a finding of
  its own.
* **`/propose` wrote code, config or test.** No. Two files, both prose.
* **The queue marks.** `[ ]` to `[>]` by `/propose` at [136], `[>]` to `[x]`
  by `/apply` at [326]. Both correct.
* **"Done when" ticked and the page moved.** All eight boxes ticked, each
  with the number or the string that proves it, and the page is in
  `work/done/`.
* **The graph ensured before reading.** `/propose` read `package.json`,
  `next.config.ts` and `tsconfig.json` at [68], before ensuring the graph at
  [88]. Not a finding: the skill's instruction is to ask the graph "before
  grepping", and the only grep and the only code read in the session came
  after the query at [97].

## Findings

Three, in the order the transcript produced them. All three are `/propose`,
including the third, whose visible symptom is `/apply` asking a question.
That is the shape of the result: `/apply` did almost everything right, and
what it got wrong it inherited.

**1. `/propose` asked which test libraries to install, and the queue line it
was expanding plus `docs/04` §5 both answer it.**

*Seen.* Question 2 of [114], "Quais bibliotecas de teste entram agora?",
with three options. The line `/propose` was there to expand, written by
`/initialize` one delivery earlier, is:

```
test-harness          install Vitest, add npm run test, make verify lint + test + build
```

One package, named. And `docs/04-Conventions.md` §5, written by the same
run, has a `When` column that says when each of the others arrives: Testing
Library on "every delivery that has one", `fake-indexeddb` on "every
delivery that touches one". This delivery has no view and touches no
repository. The recommended option's own description restates the rule from
the file: "jsdom, Testing Library e fake-indexeddb entram na entrega que
primeiro precisar de cada um."

*Expected.* No question. `/propose` had read both files, cited one of them
inside the option text, and still put a decided matter in front of a person.
The discriminator the previous record used applies cleanly here: a file that
states only today's fact leaves the decision open, and a file that states
the rule closes it. `docs/06` names the package and `docs/04` §5 states the
rule, so this is the first question in two runs whose answer a file in the
target holds. One of four is a good rate and it is still a question that
should not have been asked, because each one spends the attention that
questions 1 and 3, which were real, needed. *Queue line.*
`propose-asks-only-what-no-file-answers`.

**2. `/propose` ends without telling the person to open a new session, and
`/apply` in the same session skipped the graph entirely.**

*Seen.* The last line of [168] is "Nada foi estagiado nem commitado.
`/apply test-harness` implementa." `skills/propose/SKILL.md` has no closing
section at all: it ends at the `Never` block and the language rule, so
nothing tells the run what to say when it finishes. The stakeholder typed
`/apply test-harness` in the same session, which is the reading that
sentence invites, and `/apply` opened with "O grafo foi verificado no início
desta sessão" and went straight to `npm install`. It never ran `graphify
query`, so the delivery was implemented without the slice's own graph ever
being asked about it.

*Expected.* The last thing `/propose` says names the next session, not just
the next command. The kit asks for this in three places and enforces it in
none: `docs/05-Process.md` §2 says `/apply` "implements, in a clean
session", `skills/propose/SKILL.md` line 12 says the page is one that
`/apply` can implement "in one clean session", and `skills/apply/SKILL.md`
opens with "Implement `work/<slug>.md` in this session". Not one of them is
said to the person at the moment they decide where to type `/apply`, which
is the only moment it changes anything. The cost is concrete and it was
paid here: the graph
procedure is the first casualty of a shared session, because the freshness
check looks satisfied by a check another command ran. *Queue line.*
`propose-ends-by-naming-the-next-session`.

**3. `/propose` fixed in the Contract a tooling detail it cannot run, so
`/apply` had to ask.**

*Seen.* The page's Contract says "One devDependency is added, `vitest`, and
nothing else", and three paragraphs later it pre-answers the version
conflict it could see coming: if vitest's `engines.node` floor rises above
the workflow's Node 20, "**the workflow's node version is what moves**".
`/apply`'s first command, at [178], was `npm install -D vitest`, and npm
resolved `vitest@5.0.1`:

```
npm error Could not resolve dependency:
npm error peerOptional @types/node@"^22.0.0 || >=24.0.0" from vitest@5.0.1
npm error Conflicting peer dependency: @types/node@22.20.3
```

The wall was not `engines.node`, it was the `@types/node` peer, and honouring
the pre-answer would have meant three changes against a Contract that allows
one. `/apply` read the two sentences against each other and said so at
[190]: "A página antecipou essa família de problema, mas na direção errada, e
agora ela se contradiz." Then it asked. The same pattern produced the one
other divergence of the run: the Contract pinned `vitest.config.ts` and the
extension had to become `.mts`, which only a run can discover.

*Expected.* `/apply` implements without asking, which is what
`skills/propose/SKILL.md` line 12 promises of the page it writes. Either
`/propose` names the version it verified resolves, or the Contract says of a
dependency only what a document can hold and leaves the resolution to
`/apply`. Today it does neither: the kit forbids `/apply` to add a
dependency the page did not name, and gives `/propose` no way to check that
the name it writes installs. `/propose` is forbidden to write configuration,
not to run a read-only `npm view`, and nothing in the skill suggests it.
The pattern occurred twice in one page, which is what makes it a line rather
than an anecdote: the vitest version at [178] was the first, the config
extension at [242] the second. *Queue line.*
`propose-does-not-fix-what-it-cannot-run`.

### What was not a finding

* The git question at [346]: its cause is this project's own protocol, the
  `/initialize` output never committed in the clone, and the page excludes
  it by name. `/apply` quoting the target's own §7 and offering the branch is
  the command reading the slot correctly; the datum maps to
  `git-branches-are-queue`.
* Three of `/propose`'s four questions, and both the decisions they carried
  into production: putting the whole verify behind the CI gate is the kind
  of decision no file can make.
* `/apply`'s closing message: it named local and production, what moves
  production, and that the workflow edit is inert until that merge, which is
  what the target's own `docs/05` §5 calls the command for that row.
* `npm ci` still installing the devDependencies in CI: the workflow needed
  no other change, and the run said so.
* Two warnings in the verify output, a `DEP0205` deprecation from Node 26
  and a Recharts zero sized container during static generation. Both predate
  the delivery. The target's noise, not the kit's.
* The local machine on Node 26 against CI on Node 20: a gap the run found,
  recorded and correctly declined to close.

## Environments

| Environment | State |
|---|---|
| Kit source | `0.8.1`, untouched. No kit-owned file changed. |
| Dogfood copy | `0.8.1`, in sync. No `focus-kit install .` was needed. |
| Machine | `~/.local/bin/focus-kit` follows the symlink; global `/graphify` skill untouched. |
| First target (`~/Downloads/vaulted`) | installed, initialized **and taken through one delivery** at `0.8.1`. Nothing staged, committed or pushed; `HEAD` is still `f6e685c` on `master`, and the working tree stays as the run left it. |
| Other targets | untouched. |
