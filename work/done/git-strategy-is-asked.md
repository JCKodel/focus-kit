# git-strategy-is-asked

**Goal.** A repository says once which of three ways it works with git, and
every command that writes under a slug puts that work where the answer says,
instead of each run inventing the question.

The error the queue line measured happened a second time while this page was
being written: on 2026-09-18 an `/apply queue-line-finds-its-place` was
building in this same tree, bumping `VERSION` and rewriting `docs/03`,
`docs/05`, `docs/06` and three skills, including the one this `/propose` was
running from, and its `git add -A` stages this page too. Only this session
saw it, so it is recorded here.

**Behaviour.**

* `/initialize` asks which of three git strategies the repository works by:
  a worktree per delivery, a branch per slug, or none. One question, three
  options, each saying what it buys and what it costs. It is asked on a
  brownfield repository, in round 6 of a greenfield one, and on a review run
  whose `docs/05-Process.md` §7 names none of the three. Reading 7 (git log,
  branches, pull requests) is quoted as what the repository does today, and
  the question is asked anyway, because today's state is a fact and not the
  rule.
* The answer opens `docs/05-Process.md` §7: its first line is
  `**Strategy.**` and one of the three, the way `**Tool.**` opens §6. The
  rest of §7 stays what the files answered: who commits, the message format,
  review before merge.
* **The first command that writes under a slug makes the worktree or the
  branch for it, and every later command for that slug works in it.** That is
  `/discuss` when the line is new, and `/propose` when the line was already
  in the queue. Everything relative to one slug is on one branch, named by
  the slug.
* Under **a worktree per delivery**: the command makes a worktree on a new
  branch named by the slug, in a sibling directory of the repository, and
  writes its files there. `/propose`'s Close names that directory as where
  the `/apply` session opens, instead of `/clear here`.
* Under **a branch per slug**: the command makes a branch named by the slug
  in the current tree. When the tree is not clean it first says what the
  checkout will carry with it and asks, because uncommitted work follows a
  checkout and the isolation this strategy promises covers committed work
  alone.
* Under **none**: nothing is made, and the three commands do what they do
  today.
* `/apply` checks where it is standing, beside the clean-session check and
  before Read first. When §7 names worktree or branch and the session is not
  in the one for this slug, it says the strategy, where it expected to be,
  where it is, and the command that gets there, and stops: nothing read,
  nothing built, nothing staged.
* `/apply`'s Close names the merge command, and the worktree removal too
  under the worktree strategy, and runs neither. The agent never commits and
  never merges, whatever the strategy says (`docs/00-Product.md`, Building
  it).
* `/initialize` makes nothing: it writes the whole `docs/` tree and a queue
  of many slugs, not work under one, and it runs before §7 exists.

**Contract.**

* `manuals/process.md` gains one section holding the three strategies and
  what each command does under each, cited by heading and never by number,
  because `discuss-adds-queue-line` renumbers that manual. The skills point
  at it and repeat none of the mechanics (`docs/01-Architecture.md` §4).
* `skills/initialize/SKILL.md`: the Git strategy question, written here once
  and asked as written, three options with FOCUS's answer nowhere in it,
  because this is not a Practice; on a brownfield repository the question
  quotes what reading 7 printed and cites no file, because that reading is
  `git log` and `git shortlog` and not a file. Round 6 of the greenfield
  step loses its trunk-or-branches clause and names this question instead.
  Step 0's review-run paragraph goes from two sections to three: a §7 naming
  none of the three gets the question. The Language section's list of texts
  that are conversation and not document goes from five to six.
* `skills/initialize/templates/docs/05-Process.md` §7: its init comment says
  the first line is `**Strategy.**` and one of the three.
* `skills/discuss/SKILL.md` and `skills/propose/SKILL.md`: each reads §7
  before it writes and does what the manual's section says for the strategy
  named there. `/propose`'s Close names the directory under the worktree
  strategy.
* `skills/apply/SKILL.md`: the location check, in the paragraph that already
  holds the clean-session check, and the merge command in Close.
* The worktree is a sibling directory of the repository and never inside it:
  `config/gitignore.fragment` is appended once (`docs/03-Domain.md`, Appended
  once), so a path inside the tree would never reach a target installed
  before this version, and every one of them would commit a worktree.
* `/apply` of this delivery runs after `work/done/queue-line-finds-its-place.md`
  exists, because that delivery edits `skills/discuss/SKILL.md` and
  `skills/propose/SKILL.md` too. The page names both commands by behaviour and
  quotes no sentence of either: what the run produces wins over what this page
  expected (`docs/05-Process.md` §6).
* Here: `docs/05-Process.md` §7 answers **none** and keeps the reason it
  already gives, one person and no one on the other side of a branch;
  `docs/04-Conventions.md` §6 follows it. `docs/00-Product.md` says, in
  Putting a line in the queue and in Defining a delivery, that the command
  makes the worktree or branch when it is the first to write under the slug,
  and in Building it that `/apply` stops when it is not in one.
* `docs/03-Domain.md`: the **Git strategy** row says who makes the worktree
  or branch and when; **As written** gains the sixth text; **Slot**, **Clean
  session**, **Discuss**, **Propose** and **Apply** say what §7 now adds,
  the **Discuss** row in particular, which says today that the command moves
  nothing and writes one line, and which now makes a branch when the line is
  the slug's first write.
* `docs/06-Queue.md`: `git-branches-are-queue` is restored struck through
  with its reason. It was deleted in this tree, and a cancelled line is never
  deleted (`docs/03-Domain.md`, Queue).
* `VERSION` is bumped: a target receives four changed skills, a changed
  manual and a changed template.

**Slice.** Not the CLI: no verb, no check and no message changes. The content
`bin/focus-kit` moves (`docs/01-Architecture.md` §3, Structure, and §4). No
View, Orchestrator, Use case or Repository: §3 says none of the four exists
here. Kit-owned: the four `SKILL.md` files, `manuals/process.md`, the
`docs/05-Process.md` template. Project-owned: this repository's `docs/00`,
`docs/03`, `docs/04`, `docs/05` and `docs/06`.

**States.**

* A fresh worktree holds no `graphify-out/`, which is gitignored, so the
  first command that reads the graph there takes the first branch of
  §Ensuring the graph and the Graph confirmation is asked, with its cost,
  once per delivery. That is a cost of the worktree option and its
  description says so. What the fourth branch of that procedure reports
  inside a worktree, where `.git` is a file pointing at the common gitdir the
  hooks live in, is a condition the run evaluates there and not a finding
  this page states.
* A repository whose §7 was written before this version names none of the
  three: the review run asks, and nothing is made until it is answered.
* A queue line placed before the strategy existed: `/propose` is the first
  command to write under that slug and makes the worktree or branch.
* A branch or worktree for the slug that already exists: the command says so
  and works in it, because the slug is what names it and the delivery is one.
* Here, with §7 answering none, nothing changes about how a session in this
  repository runs.
* The kit's own output: unchanged. `install`, `doctor` and `selftest` print
  what they printed, at the new version.

**Visual reference.** No UI, and no line of the CLI changes. The shape §7
takes, here and in a target:

```
## 7. Git

**Strategy.** None: work goes straight to the trunk.
```

**Out of scope.**

* Committing, merging, pushing, deleting a branch or removing a worktree:
  the agent names the command and a person runs it
  (`docs/00-Product.md`, Building it).
* A check in `selftest` that §7 names a strategy: nothing here is verified
  automatically (`docs/00-Product.md`, Non-goals).
* No ADR: a slot is reversed by editing one file (`docs/03-Domain.md`, ADR).
* A fourth strategy, and pull requests as a separate answer: the queue line
  names three, and how a branch reaches the trunk is the rest of §7.
* `git-policy-for-a-second-person` under Later: it names when this
  repository's own answer is worth revisiting, not the mechanism this
  delivery adds.
* A target initialized before this version: `docs/05-Process.md` is
  project-owned and no command rewrites it, so its §7 stays prose until a
  review run there asks.

**Done when.**

* [x] `bin/focus-kit selftest` is green, six checks.
* [x] A real run of `/initialize` in a scratch repository asks the Git strategy
  question and writes the answer as the first line of §7, and the transcript
  goes into `work/done/git-strategy-is-asked.md` (`docs/05-Process.md` §6).
* [x] A real run under the **worktree** strategy in a scratch repository: a
  command that writes under a slug makes the worktree and writes there, and
  an `/apply` started outside it stops with the command that gets there. The
  kit could not do this strategy at all before, so a run is what proves it
  can.
* [x] `docs/05-Process.md` §7 here opens with `**Strategy.**` and answers none,
  and `docs/04-Conventions.md` §6 agrees with it.
* [x] `docs/06-Queue.md` holds `git-branches-are-queue` struck through with its
  reason.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy carries the change (`docs/05-Process.md` §5).
* [x] `docs/00`, `docs/03`, `docs/04` §6, `docs/05` §7 and `manuals/process.md`
  updated in this delivery.

---

## What happened

### Where the mechanics landed

One section, `manuals/process.md` §The git strategy, holds all of it: the
three answers, which command makes the worktree or the branch and when, the
`git worktree add ../<repository folder>-<slug> -b <slug>` and `git checkout
-b <slug>` that make them, the dirty-tree ask, the merge and the removal
`/apply` names, and the stop `/apply` runs when it is standing outside. The
four skills carry a pointer and repeat none of it (`docs/01-Architecture.md`
§4, which gained the paragraph saying so and calling the git strategy the
second thing with that shape, after the house rules).

It went in as **§10**, between "What the process deliberately lacks" and
"Commit message", and not after §6 where the commands are described. The
reason is mechanical: four documents cite that manual by number, at §6, §7,
§8 and §9, and an insertion anywhere above §9 makes some of them false.
Placed at §10 nothing above it moves, only "Commit message" and "Updating
the kit" shift down, and no citation in the repository points at either. The
skills cite it by heading anyway, `§The git strategy`, which is what the
Contract asked for and what `docs/03-Domain.md`, Named section, already
calls the way to hang on a manual.

### The three choices the page left to the run

* **The worktree's directory.** `../<repository folder>-<slug>`, a sibling
  of the repository, which the page fixed as a sibling and left unnamed. The
  run in the scratch produced `beeline-report-floor` beside `beeline`.
* **When `/propose` makes it.** At Write, after the conversation, and not at
  Read first. The page does not say, and Read first would cost a worktree
  and a graph build for every run that stops on a question. The proof run
  took a question and made nothing, which is the behaviour this choice buys.
* **What `/apply` reads for the location check.** `docs/05-Process.md` §7 and
  nothing else, said in the skill in those words, because "nothing read" and
  "check where you are standing" are otherwise in contradiction.
* **The merge command.** `git checkout <trunk> && git merge <slug>`, written
  into the manual after the proof run showed why: the scratch's §7 invented
  `git checkout main && git merge --no-ff <slug>` for itself, which is the
  "every run invents the question" the Goal is against. The manual now words
  it, `/apply` names it from there, and neither runs it.

Two wordings follow from the same limit and are worth naming: under a
worktree the command that gets there is not a `cd`, because a Claude Code
session does not change its own working directory, so both the skill and the
manual say opening a session in that directory. And `/propose`'s Close names
that directory instead of `/clear` here, which is the one place the clean
session rule and the git strategy touch.

### What diverged from the plan

Nothing in the behaviour. Two things in the page's description of the tree:

* **`docs/06-Queue.md` already held `git-branches-are-queue` struck through.**
  The page says it "is restored struck through with its reason. It was
  deleted in this tree". It was already there, at its place under milestone
  3, with the reason naming this slug. Nothing was written for that item and
  it is ticked as found.
* **`docs/03-Domain.md` already held the **Git strategy** row**, written by
  the `/discuss` that put the line in the queue. It was rewritten rather than
  added, to say who makes the worktree or the branch and when, which is what
  the Contract asked of it.

Nothing was dropped.

### The error happened a third time, during this run

The page records two occurrences of two deliveries sharing one working tree.
A third happened while this one was being applied, in this repository, on
2026-09-18. Between 09:39 and 09:57, with this `/apply` running, another
session wrote into the same tree: `work/skill-says-it-is-kit-owned.md`,
`work/an-old-target-gets-the-fragment.md` and
`work/update-survives-a-moved-section.md`, a new row in `docs/03-Domain.md`
(**Kit-owned banner**), and a rewrite of `docs/06-Queue.md` that renamed
milestone 3, replaced its paragraph and moved lines between milestones.

Nothing was lost: both sessions edited by anchored replacement, so the six
edits this delivery made to `docs/03-Domain.md` and the other session's row
are all in the file. What could not be separated is the diff. `docs/03` and
`docs/06` now carry two deliveries' work in the same files, and `git add -A`
would stage three delivery pages that belong to deliveries nobody has built.
So the staging was put to the person rather than taken alone; see
**Environments** below for what was staged.

Under the strategy this delivery just shipped, and had this repository
answered anything but none, the third occurrence could not have happened:
each of those pages would have been written on its own branch.

### The proof

`docs/05-Process.md` §6 wanted real runs. Both were driven headless with
`claude -p` from this session, against one scratch repository built from a
fictional brownfield domain: **beeline**, a command line ledger for beehive
inspections, Python over SQLite, six `.py` files in `src/beeline/` and one in
`tests/`, a `pyproject.toml`, a `README.md`, three commits on `main` by one
author, no branch and no remote. `git init` plus `focus-kit install` at
**0.25.0**; the installed `.claude/skills/initialize/SKILL.md` was read first
and confirmed to carry the Git strategy question. No `docs/00-Product.md`, so
the run was a first run and never reached the review branch. The scratch and
its worktree are removed.

**Run 1, `/initialize`, green.** The question was asked, in the
conversation's language, which was Portuguese, quoting what reading 7 printed
and citing no file:

> ### 9. Como este repositório trabalha com git?
>
> O histórico mostra três commits em `main`, um único autor (`apiary`, 3
> commits), nenhum outro branch, nenhum remoto, e mensagens no formato
> `feat:`/`fix:`/`chore:` sem escopo. Isso é o que acontece hoje; esta
> resposta é a regra daqui em diante.

The three options came with what each buys and what it costs, and with no
recommendation first, which is what a question that is not a Practice looks
like. The worktree option carried its cost in full, the queue line living on
the branch until merge and the graph built once per delivery:

> - **a) Um worktree por entrega.** [...] O que custa: um worktree é feito a
>   partir do `HEAD`, então a linha da fila e a sua marca vivem naquele branch
>   até alguém fazer o merge, e uma sessão na árvore principal não as vê; o
>   grafo é construído uma vez por entrega, porque um worktree novo não tem
>   nenhum; e o diretório é removido à mão depois do merge.

`AskUserQuestion` does not exist in a headless `claude -p` session, the same
limit `initialize-trusts-the-argument` and `run-ignores-a-stray-word`
recorded. The run said so and put its nine questions in prose. A second turn
answered them, and §7 came out opening with the fixed first line:

> ## 7. Git
>
> **Strategy.** A branch per slug. The first command that writes under a slug
> makes a branch named by the slug in this tree, and every later command for
> that slug works on it. What each command does under this strategy is
> `docs/manuals/process.md` §The git strategy, and it is not repeated here.

The rest of that §7 stayed what the files answered, and it repeated none of
the mechanics without being told to, which is the half of the Contract a
template comment cannot enforce.

**Run 2, the worktree strategy, green on all three parts.** The scratch's §7
was rewritten to `**Strategy.** A worktree per delivery.` and committed, and
`/propose report-floor` was run from the main tree.

It reached its questions and made nothing, which is the choice above proving
itself: *Nada foi escrito, nenhum worktree foi criado e a marca da fila não
mudou, exatamente como a skill prevê para um run que para.* A second turn
answered, and it wrote where the strategy says:

```
Made: the worktree ../beeline-report-floor, on branch report-floor.
Written: work/report-floor.md; docs/06-Queue.md line marked [>]; no new term.
Nothing staged, nothing committed.

Open a session in .../proof1/beeline-report-floor and type:
/apply report-floor
```

`git worktree list` showed both trees on `b20a89c`, `work/report-floor.md`
existed only in `beeline-report-floor`, and the queue line read `[>]` there
and `[ ]` in the main tree. The run said so itself, unprompted, which is the
cost the option's description promises: *A marca `[>]` e a página estão só no
worktree. A `main` continua com a linha `[ ]` [...] porque um worktree nasce
de `HEAD`.*

Then `/apply report-floor` from the main tree, which is the part the kit
could not do at all before:

> Parei antes de ler qualquer coisa da entrega: nada lido, nada construído,
> nada preparado para commit.
>
> **A estratégia** (`docs/05-Process.md` §7): um worktree por entrega. [...]
> **Onde eu esperava estar:** `.../beeline-report-floor` (branch
> `report-floor`). O worktree já existe, criado pelo comando anterior do slug.
> **Onde eu estou:** `.../beeline` (branch `main`), a árvore principal.
> **O comando que chega lá:** abrir uma sessão no diretório do worktree e
> digitar `/apply report-floor` nela.

Four things the page asked for, in one message, and a stop. What the run
produced wins, and nothing it produced contradicted the page.

### Documents

`docs/00-Product.md`: Putting a line in the queue and Defining a delivery say
which command makes the worktree or the branch and when; Building it says
`/apply` stops when it is not in one, and its Rule of product now reads "it
does not commit, and it does not merge", which the page cites and which that
document did not hold before. `docs/01-Architecture.md` §4: the paragraph
above. `docs/03-Domain.md`: **Git strategy** rewritten, and **As written**,
**Slot**, **Clean session**, **Discuss**, **Propose** and **Apply** updated.
`docs/04-Conventions.md` §6 and `docs/05-Process.md` §7 answer none, §7 with
the fixed first line and the reason it already gave.
`manuals/process.md` and the `docs/05-Process.md` template as above.

No ADR. A slot is reversed by editing one file (`docs/03-Domain.md`, ADR),
and the page says so.

`docs/01-Architecture.md` §3 changes in neither table: this delivery is
markdown that the CLI moves, no verb and no check of `bin/focus-kit` was
touched, and no FOCUS piece appears (ADR-0003).

### Environments

| Environment | State |
|---|---|
| Kit source | 0.25.0, the truth: four skills, `manuals/process.md`, the `docs/05-Process.md` template, `VERSION` |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.25.0, `focus-kit install .` run here, check 6 green |
| Machine (`~/.local/bin/focus-kit`) | a symlink to the kit source, so 0.25.0; global `/graphify` skill at the graphify package's version, 0.9.63 |
| First target (`~/Downloads/vaulted`) | 0.22.5, read from its stamp, so three versions behind. `focus-kit update ~/Downloads/vaulted`, and only if someone works there: milestone 2 is closed and this row leaves `docs/05-Process.md` §5 with it |
| Target repositories (anyone else's) | untouched, at whatever version they installed. Their owner runs `focus-kit update` |

**What was staged.** Everything except the three delivery pages the other
session wrote, `work/skill-says-it-is-kit-owned.md`,
`work/an-old-target-gets-the-fragment.md` and
`work/update-survives-a-moved-section.md`, which stay untracked. The person
chose that when the overlap was put to them. `docs/03-Domain.md` and
`docs/06-Queue.md` are staged as they stand, both deliveries' work in them,
because there is no way to split a file's diff without `git add -p` and this
session has none.
