# first-target-initialize

**Goal.** `/initialize` has run on a repository that is not this one, and one
page records every question it asked that a file could have answered, every
question it should have asked and did not, and what the documents it wrote
got wrong, each miss as a queue line. Until now the brownfield path of
`/initialize` (`docs/00-Product.md`, Initializing) has only ever run here,
on the kit itself.

The first target is `~/Downloads/vaulted` at `f6e685c`, installed by
`first-target-install` and at `0.8.1` today: a Next.js 16 PWA whose prose is English, with
`package.json` scripts `dev`, `build`, `start` and `lint`, one workflow at
`.github/workflows/deploy-pages.yml`, its own `docs/launch-copy.md` and
`docs/show-hn-draft.md`, 24 TypeScript files, 6 markdown files, 9 images,
no `CLAUDE.md`, and no API key exported in the shell.

**Behaviour.**

The run is not `/apply`'s to make. `/initialize` is interactive and loads
from the target's `.claude/skills/`, so the stakeholder runs it in Claude
Code opened in the target, before `/apply first-target-initialize` starts
here. Then:

* Before the run, `focus-kit update ~/Downloads/vaulted` when the stamp
  there differs from `VERSION`, so the run uses the kit at the delivery's
  version (`docs/05-Process.md` §5).
* The stakeholder types `/initialize` with no argument, so the kind of
  project is detected and not told. In Step 0 they confirm brownfield and
  answer English; the expected offer is English first, naming the file it
  was seen in. Every other question is answered as the person owning the
  repository would, and the cost question `/graphify` asks is theirs.
* Whatever the run stages, `git reset` in the target undoes before the
  record is written, and the done page says so. Nothing is committed or
  pushed there.
* `/apply` here reads three sources: the one session transcript under
  `~/.claude/projects/-Users-jckodel-Downloads-vaulted/`, the files the run
  wrote, and `focus-kit doctor ~/Downloads/vaulted` run after it. The
  transcript is processed for the questions asked and the files read, not
  pasted.
* A finding is any of: a question asked whose answer a file in the target
  holds, with that file named; a section written by assumption, no file
  cited and no question asked; a `<!-- init: -->` comment surviving, an em
  dash in a written document, a term used in `docs/00`, `01` or `06` and
  absent from `03`; a slot in `docs/05` that does not match `package.json`
  or the workflow, or `.claude/settings.json` without the npm allow; a warn
  from `doctor` after the run, or the graph or the hook absent; and anything
  a person would have to work out alone, as in `first-target-install`.
* Each finding becomes a queue line. Zero findings is a result too, and
  then the done page says so and the queue gains nothing.

**Contract.**

No kit-owned file changes and `VERSION` stays where the apply session finds
it. Four project-owned files carry the delivery:

| File | Exactly |
|---|---|
| `work/done/first-target-initialize.md` | after the page, `## What happened`: the kit version the run used; the Step 0 question as asked and the answers given; every further question, numbered, with the file that answered it when one did; the files the run read before asking, as the transcript shows; the files it wrote; `git status --short` in the target before the run, after it, and after `git reset`; the graph and hook state and the token cost from the target's `graphify-out/cost.json`; the `doctor` transcript after the run, ANSI stripped, the absolute path written as `<target>`. Then `## Findings`, numbered: seen, expected, the queue line it became. Only the run's own text is quoted, never a line from the target's own files; a quoted line that carries an em dash has the character replaced by its codepoint name, and the em dash is a finding. |
| `docs/06-Queue.md` | one `[ ]` line per finding, directly after `first-target-initialize` and before `first-target-delivery`, in the order found, in the shape of the lines around it: slug naming what it fixes, description of what happens today. Reordering is the stakeholder's, in conversation. |
| `docs/05-Process.md` §5 | the First target row reads installed and initialized at the delivery's version. |
| `docs/03-Domain.md` | the term First target, already amended by this `/propose`: nothing committed or pushed, and what a command stages is undone. |

**Slice.** This repository's own docs and `work/`, all project-owned. No
skill, no manual, no template, no `config/`, no `bin/`. What the run
exercises is `skills/initialize/SKILL.md` and its templates, through the
copies `install` put in the target; a finding about them is a queue line,
never an edit here.

**States.** The defaults, in the target. `graphify .` refuses there for want
of a key, because the corpus has markdown and images, so `/graphify .` runs
in the session on the stakeholder's tokens. If the transcript folder does
not exist, the run has not happened: `/apply` stops, names the precondition
and writes nothing. If the run stops midway, or the session does not offer
`/initialize`, the record stops there and the fix is a queue line. If the
transcript folder holds more than one session, the done page names the one
it read by file name.

**Visual reference.** No UI. `doctor` on the target after the run, if nothing
is missed, prints every line it prints there today, with each warn turned
green:

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
* The review run, `/initialize` again once `docs/00` exists: a separate
  claim, a candidate queue line if the stakeholder wants it.
* The delivery through `/propose` and `/apply` there: `first-target-delivery`.
* Portuguese documentation: it tests template translation, a claim for a
  later run.
* A commit or push in the target: it is someone else's clone.
* A run on the Windows host: nothing here is platform dependent.
* An ADR: reversing this is `git clean` in a clone and one row edited.

**Done when.**

* [x] The run happened in the target through the installed skill at
  `VERSION`, `/initialize` with no argument, English; the transcript file
  is named in the done page.
* [x] The done page carries every section the Contract names; `git status
  --short` in the target after `git reset` shows nothing staged.
* [x] `focus-kit doctor ~/Downloads/vaulted` prints no warn, or every warn
  it prints is a finding.
* [x] Every finding is a `[ ]` line after `first-target-initialize` in
  `docs/06`, and the done page maps each finding to its line.
* [x] `docs/05-Process.md` §5 First target row says initialized.
* [x] `bin/focus-kit selftest` green; `VERSION` unchanged; `git status`
  here shows changes under `docs/` and `work/` only.
* [x] Environments: kit source and dogfood copy at `VERSION`, untouched;
  machine follows the symlink; first target installed and initialized at
  `VERSION`, nothing committed there; other targets untouched. The closing
  message names all five.

---

## What happened

The run happened, end to end, in one session, and it finished: it wrote
every document, built the graph, installed the hook, ran the target's own
`lint` and `build`, staged 36 files and suggested a commit message without
committing. Nothing in it stopped midway and the session offered
`/initialize` on the first try.

Three things diverged from the page, and none of them changed the scope.

**The Step 0 offer came after twenty files, not before.** The page expected
the kind of project to be detected and not told, and it was: the skill read
the repository first and then asked the person to confirm brownfield, naming
what it had counted. That is the page's intent, and it is worth writing down
because it is the opposite of what "Step 0" sounds like.

**`/graphify` did not ask the cost question.** The page said the cost
question `/graphify` asks is the stakeholder's. It measured the corpus, said
it was inside its limit and extracted, and the person saw no number and no
question before 433,524 input tokens were spent. That is finding 1.

**There is no bare `git status --short` from immediately before the run.**
The transcript's first git command is a `git log`, so the honest pre-run
capture is the one `first-target-install` recorded plus what `focus-kit
update` added since. It is written below as reconstructed, not as observed.

Every question the run asked was answered with the recommended option. The
headline result of the Goal's first category is empty: **not one of the six
questions had its answer in a file in the target.** Two were the Step 0
confirmations the skill is supposed to ask; the other four were decisions
that no file can hold, each one carrying the file and the line that made the
decision necessary. The friction is all on the other side, in what the run
did not ask and in what the kit's own manual promises.

`<target>` stands for the absolute path of `~/Downloads/vaulted` in every
transcript here. No line from the target's own authored files is quoted on
this page: its README carries em dashes and check 5 greps `work/`. What is
quoted is the run's own text: its questions, its messages, the files it
wrote and the files it generated. The documents quoted in findings 3 and 4
are in that set, written by the run in this session, and they carry no em
dash, which is one of the checks below.

### The kit version the run used

`0.8.1`. `.claude/skills/.focus-kit-version` in the target reads `0.8.1`,
and `focus-kit doctor <target>` after the run prints `kit version 0.8.1`.
The stakeholder ran `focus-kit update ~/Downloads/vaulted` before the
session, taking the target from the `0.6.1` that `first-target-install`
left to the delivery's version.

### The transcript

One session folder, one session file:

```
~/.claude/projects/-Users-jckodel-Downloads-vaulted/
  77641228-cc4d-4c03-8516-31b12254ae9e.jsonl
```

601 entries. Every quotation and every count below comes from it, processed
rather than pasted.

### The Step 0 question, as asked

The skill asked both Step 0 questions in one call, in Portuguese, which is
the language the person writes in. The documentation language offered and
chosen is English.

> Detectei brownfield: o repositório tem código real (Next.js 16 App
> Router, TypeScript, ~4.700 linhas em app/, components/ e lib/), 21
> commits, CI de deploy para GitHub Pages e domínio vaultedworth.com.
> Confirma?

Answer: **Brownfield (recomendado)**.

> Em que língua escrevo a documentação (docs/00 a 06, ADRs, CLAUDE.md,
> work/<slug>.md e as mensagens de commit sugeridas)?

Answer: **Inglês (recomendado)**. English was offered first, as the page
expected, and the offer named where it had seen it: "Tudo que já existe de
prosa no repositório está em inglês: README.md, DEPLOY.md,
MARKETING_PLAN.md, os 9 posts do blog, a interface do app e as 21 mensagens
de commit."

### Every further question, numbered

All four came in one call, after the graph was built. Each is followed by
the file that answered it, when one did.

**3. Test framework.** "Não existe nenhum teste nem framework de teste no
repositório (`package.json` só tem `dev`, `build`, `start`, `lint`). O
comando de verificação honesto hoje é `npm run lint && npm run build`. Qual
framework de teste declaro em `docs/04-Conventions.md` §5 como alvo?"
Answer: **Vitest**. No file answers it: `package.json` answers what exists
today, which the question states as fact, and the question is which target
to adopt.

**4. Git and deploy policy.** "`.github/workflows/deploy-pages.yml` faz
deploy para GitHub Pages a cada push em `master`. [...] Isso é o que escrevo
em `docs/05-Process.md` §5 e §7, ou você quer mudar a política?" Answer:
**Branches + PR para master**. No file answers it: the workflow answers what
happens today, which the question states as fact, and the question is
whether to keep it.

**5. Telemetry against the privacy copy.** "Achei uma contradição entre a
promessa e o código. `lib/posthog.ts` inicializa o PostHog com `autocapture:
true` [...] e `components/vaulted-app.tsx` envia eventos como `entry_created`
[...] (linha 502) e `import_json` [...] (linha 565)." Answer: **Decisão
aberta, sem escolher agora**. No file answers it. The files named are what
makes the question necessary, and they disagree with each other; only a
person can say which side is wrong.

**6. Milestone 1.** "O que o marco 1 de `docs/06-Queue.md` deve perseguir?
Hoje `components/vaulted-app.tsx` tem 1.349 linhas e concentra View,
orquestração, regras de negócio e IO num só componente; `lib/storage.ts`
engole falhas com `catch { return null }` em vez de devolver um Result."
Answer: **Estrangular a fatia de entradas**. No file answers it.

**Result: zero questions of the first category.** Four decisions, each one
naming the file and the line that forced it, and none of them answerable by
reading.

### The files the run read before asking

Before the Step 0 offer, twenty files and six surveys, in this order:

```
docs/manuals/process.md, docs/manuals/focus.md
find .claude/skills/initialize/templates, ls -la, ls -R docs, ls -R work
README.md, package.json, DEPLOY.md, LAUNCH_CHECKLIST.md
find app components lib public .github
next.config.ts, tsconfig.json, eslint.config.mjs, postcss.config.mjs
wc -l over app, components, lib, public/sw.js; git log; git shortlog; git branch -a
lib/vaulted.ts, lib/storage.ts
components/vaulted-app.tsx (grepped for structure, then read twice)
app/page.tsx, app/layout.tsx, lib/posthog.ts, components/PostHogProvider.tsx,
  components/service-worker-register.tsx, app/sitemap.ts, app/robots.ts,
  public/manifest.webmanifest, public/sw.js
components/share-journey-modal.tsx, app/tools/net-worth-percentile/page.tsx
MARKETING_PLAN.md, docs/launch-copy.md, docs/show-hn-draft.md
the fifteen files under .claude/skills/initialize/templates/
.claude/settings.json
```

Between Step 0 and the four questions: `docs/manuals/graphify.md`, the
environment checked for a backend key, `graphify hook status`, `graphify .`,
and the whole graph run. Afterwards, two greps to settle `onboarded`, the
`posthog.capture` call sites and the em dashes in the app's own strings.

### The files the run wrote

Twelve written, one copied, one merged file extended, and one written by
`graphify hook install` on the run's behalf:

```
docs/03-Domain.md, docs/00-Product.md, docs/01-Architecture.md,
docs/02-Backend.md, docs/04-Conventions.md, docs/05-Process.md,
docs/06-Queue.md
docs/adr/README.md, docs/adr/ADR-0001-static-export-no-server.md,
docs/adr/ADR-0002-vault-in-indexeddb.md,
docs/adr/ADR-0003-pull-request-to-master.md
docs/adr/ADR-0000-template.md (copied from the templates)
CLAUDE.md
.claude/settings.json (nine allows and two asks added for this stack)
.gitattributes (one line, graphify's merge driver for graphify-out/graph.json)
```

`.gitattributes` is not the kit's: `bin/focus-kit:232` says a target
receives none, and the file holds `graphify-out/graph.json merge=graphify`
and nothing else. `graphify hook install` wrote it, and the run's own end
check reported it as `merge driver: registered`. Not a finding, because
that line names it.

Then eleven edits over `CLAUDE.md`, `docs/01`, `docs/02`, `docs/03` and
`docs/06`, and one `sed` over `docs/04` and `docs/05`, all of them the run
correcting itself against what it had just verified.

The `.claude/settings.json` extension is what `skills/initialize/SKILL.md`
Step 3 instructs, and it survives a later `focus-kit update`: merging
`config/settings.baseline.json` into the file as it stands now returns it
byte for byte, because `merge_json` extends a list with what is not already
in it. Not a finding.

### `git status --short` in the target

**Before the run.** Not captured: the transcript's first git command is a
`git log`. Reconstructed from what `first-target-install` recorded, which
`focus-kit update` changed in content and not in shape, since the update
rewrites kit-owned files already untracked under `.claude/`:

```
 M .gitignore
?? .claude/
?? .mcp.json
?? docs/manuals/
?? work/
```

**After the run**, the run's own capture, 36 files staged by its
`git add -A`:

```
A  .claude/settings.json
A  .claude/skills/.focus-kit-manifest
A  .claude/skills/.focus-kit-version
A  .claude/skills/apply/SKILL.md
A  .claude/skills/initialize/SKILL.md
A  .claude/skills/initialize/templates/CLAUDE.md
A  .claude/skills/initialize/templates/docs/00-Product.md
A  .claude/skills/initialize/templates/docs/01-Architecture.md
A  .claude/skills/initialize/templates/docs/02-Backend.md
A  .claude/skills/initialize/templates/docs/03-Domain.md
A  .claude/skills/initialize/templates/docs/04-Conventions.md
A  .claude/skills/initialize/templates/docs/05-Process.md
A  .claude/skills/initialize/templates/docs/06-Queue.md
A  .claude/skills/initialize/templates/docs/adr/ADR-0000-template.md
A  .claude/skills/initialize/templates/docs/adr/README.md
A  .claude/skills/propose/SKILL.md
A  .gitattributes
M  .gitignore
A  .mcp.json
A  CLAUDE.md
A  docs/00-Product.md
A  docs/01-Architecture.md
A  docs/02-Backend.md
A  docs/03-Domain.md
A  docs/04-Conventions.md
A  docs/05-Process.md
A  docs/06-Queue.md
A  docs/adr/ADR-0000-template.md
A  docs/adr/ADR-0001-static-export-no-server.md
A  docs/adr/ADR-0002-vault-in-indexeddb.md
A  docs/adr/ADR-0003-pull-request-to-master.md
A  docs/adr/README.md
A  docs/manuals/focus.md
A  docs/manuals/graphify.md
A  docs/manuals/process.md
A  work/done/.gitkeep
```

**After `git reset`**, run in the target by this apply before the record was
written. Nothing staged, nothing lost, the clone back to one keystroke away
from nothing:

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

Nothing was committed or pushed there. `git log --oneline -1` in the target
is `f6e685c`, the commit the clone arrived at.

### The graph, the hook and the cost

`graphify .` refused first, in graphify's own words, which is the manual's
first branch exactly as written:

```
error: no LLM API key found (31 doc/paper/image file(s) need semantic
extraction). Set GEMINI_API_KEY or GOOGLE_API_KEY (gemini), ...
[graphify extract] scanning <target>
[graphify extract] found 31 code, 23 docs, 0 papers, 8 images
```

The environment had been checked for a backend key first, as the manual's
trap paragraph says to, and held none. `/graphify .` then ran in the
session. The graph: 498 nodes, 726 edges, 24 communities, 90% EXTRACTED,
10% INFERRED, 0% AMBIGUOUS, with 17 dangling edges and 1 collapsed edge
reported by graphify's own integrity diagnostic. The most connected node in
the repository is `VaultedApp()`, with 24 edges, which is an independent
confirmation of the diagnosis the documents make.

`graphify-out/cost.json` in the target:

```json
{
  "runs": [
    {
      "date": "2026-09-16T21:23:51.557800+00:00",
      "input_tokens": 433524,
      "output_tokens": 0,
      "files": 62
    }
  ],
  "total_input_tokens": 433524,
  "total_output_tokens": 0
}
```

The hook, checked by the run at the end:

```
=== hook ===
post-commit: installed
post-checkout: installed
merge driver: registered
=== ignored? ===
.gitignore:50:graphify-out/	graphify-out/graph.json
```

### `focus-kit doctor <target>` after the run

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

Exit 0, ANSI stripped, no warn. It is the Visual reference line for line,
with the two lines the three earlier deliveries added, `.claude/settings.json`
and the seven now green. Twenty-four green lines and nothing else: the first
time `doctor` has printed a clean target that is not this repository.

### The mechanical checks the Contract names

* **`<!-- init: -->` comments surviving.** None, in any of the eight written
  documents or the four ADRs.
* **Em dash in a written document.** None, in any of them. The run greps its
  own output for it, and it also found the em dashes in the app's own
  strings and turned them into a queue line of the target's own.
* **A slot in `docs/05` against `package.json` and the workflow.** The verify
  slot reads `npm run lint && npm run build`, which is what the four scripts
  allow, and the document says in the same breath that it runs no test
  because there are none and names the target command. The environments table
  names `local` and `production (vaultedworth.com)` and the workflow file
  that moves it. `.claude/settings.json` carries `Bash(npm run *)`,
  `Bash(npm ci *)`, `Bash(npm install *)`, `Bash(npm test *)`, `Bash(npx *)`
  and `Bash(node *)`. All match.
* **A term used in `docs/00`, `01` or `06` and absent from `03`.** Three:
  `VaultRepository`, `LoadResult` and `SaveResult`. That is finding 4.

## Findings

Four. None of them is a question the code could have answered, because there
were none of those. Two are about the kit's graph procedure, one is a
question the brownfield path did not ask, and one is a contradiction the run
wrote into its own documents.

**1. The graph procedure's first branch spends a session's tokens with no
number shown and no question asked.**

*Seen.* `docs/manuals/graphify.md` says of the first branch: "The place
where the cost is declined is `/graphify` itself, which measures the corpus
and asks a person before an expensive extraction." `/graphify .` measured
and did not ask. Its one line on the subject was a statement:

> Corpus: 62 arquivos · ~44.185 palavras (31 código, 23 docs, 8 imagens).
> Dentro do limite, sem necessidade de reduzir escopo.

433,524 input tokens later, the report it wrote opens by disagreeing with
the decision that was never put to anyone:

```
## Corpus Check
- Corpus is ~44,185 words - fits in a single context window. You may not
  need a graph.
```

*Expected.* Either the number and the question in front of the person before
the extraction, or a manual that does not promise one. The manual's own
sentence, "The first branch's action is not a judgement call", is what makes
this sharp: the procedure deliberately removes the agent's discretion and
hands the decision to `/graphify`, and `/graphify` applies a threshold of
its own instead of asking. A person running `/initialize` on a brownfield
repository for the first time is billed for the largest single action of the
session without being shown its size. *Queue line.*
`graph-cost-is-confirmed`.

**2. A graph built through the first branch carries no `Built from commit`,
so the staleness branch can never fire in exactly the repositories that took
it.**

*Seen.* The third branch of the procedure is "`Built from commit` in
`graphify-out/GRAPH_REPORT.md` differs from `git rev-parse HEAD`". The
report `/graphify .` wrote in the target has no such line and no Graph
Freshness section at all. The run hit this itself and worked around it
alone, in its own words, by writing the fallback into the command:

```
grep -n "Built from commit" graphify-out/GRAPH_REPORT.md || echo "(no
'Built from commit' line in this report version)"
```

which printed

```
(no 'Built from commit' line in this report version)
```

This repository's own report, last written by the post-commit hook, does
carry it, under a heading the target's report does not have:

```
## Graph Freshness
- Built from commit: `23242b36`
```

*Expected.* A procedure whose third branch can be evaluated in the state the
first branch leaves, or a fourth line in the table saying what to do when
the line is absent. As it stands, every `/propose` and `/apply` in a target
that needed `/graphify` will grep for a line that is not there and decide
alone, every session, whether the graph is stale. *Queue line.*
`graph-staleness-without-a-stamp`.

**3. The brownfield path wrote the proof slot without asking how a screen is
proven, and left the tool out.**

*Seen.* `docs/05-Process.md` §6 in the target names the viewports
(**390 x 844** and **1280 x 800**), both themes, the references
(`marketing-assets/home.jpg` and `public/og-image.jpg`), the empty state and
the rule for divergence. It names no tool. Step 2 of the written document
says "Screenshot the changed screen", and nothing in the target says with
what: `package.json` has no browser driver, and `.mcp.json` declares
`graphify` and nothing else. *Expected.* The question asked. Round 4 of the
skill's question list is "Environments and proof [...] If there is a UI,
what the visual reference is and how a screen is proven", and the template's
own comment at `docs/05-Process.md` §6 asks for "tool, viewports, what it is
compared to". The viewports and the reference were inferred from the
repository, correctly; the tool is the one part of that slot no file can
hold, and it is the part that was left blank. It is the clearest example
this run produced of a question the brownfield path should have asked and
did not, and `/apply` in the target will reach step 2 of a slot the kit
wrote and improvise. *Queue line.*
`initialize-asks-for-the-proof-tool`.

**4. `docs/06` names three code terms that `docs/03` does not have, in a
document that says it may not.**

*Seen.* The `vault-repository` line of the target's `docs/06-Queue.md` reads
"the vault goes behind VaultRepository with LoadResult and SaveResult".
None of the three is in the terms table of `docs/03-Domain.md`, which says
of itself: "The table is normative: no delivery may name in code a concept
that is not here" and "A new concept enters here first, with its code term,
and only then appears in a delivery." The run wrote both sentences and then
broke them, in the same session, three documents apart. *Expected.* Either
the three terms in the table, or a sentence in `docs/03` placing the four
FOCUS piece names outside its scope and pointing at `docs/01`. The rule is
the kit's, carried in `templates/docs/03-Domain.md`, so the gap is the
skill's: nothing in `/initialize` checks the queue it writes against the
table it wrote first, and a rule a document states about itself is the
cheapest kind to check. *Queue line.* `every-term-enters-03-first`.

### What was not a finding

* Six questions asked, zero answerable by a file.
* No `<!-- init: -->` comment survived, no em dash was written, no `doctor`
  warn, the graph and the hook both present.
* `.claude/settings.json` extended by Step 3 as instructed, and the
  extension survives a re-merge.
* The Step 0 offer arriving after twenty files rather than before: that is
  detection working, and it is what let the offer name where English was
  seen.
* The run's report of a Recharts `width(-1) and height(-1)` warning during
  the static prerender: the target's noise, not the kit's.

## Environments

| Environment | State |
|---|---|
| Kit source | `0.8.1`, untouched. No kit-owned file changed. |
| Dogfood copy | `0.8.1`, in sync. No `focus-kit install .` was needed. |
| Machine | `~/.local/bin/focus-kit` follows the symlink; global `/graphify` skill untouched. |
| First target (`~/Downloads/vaulted`) | installed **and initialized** at `0.8.1`. Nothing staged, committed or pushed; `HEAD` is still `f6e685c`. |
| Other targets | untouched. |
