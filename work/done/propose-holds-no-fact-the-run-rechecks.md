# propose-holds-no-fact-the-run-rechecks

**Goal.** The Contract of a page `/propose` writes holds no fact that
`/apply`'s run rechecks. Measured on the first target
(`work/done/propose-does-not-fix-what-it-cannot-run.md`, Proof): the
`testing-setup` page's Node bullet said "the current runner declares an
`engines` range that excludes it (checked 2026-09-17)" and moved the
workflow's Node pin on it. It was measured rather than guessed, dated, and
resolved nothing, and none of the three saves it: the range is the runner's,
it changes when the runner publishes, and from that day the sentence is wrong
while reading as a fact `/apply` may act on.

**Behaviour.**

* The **Contract** holds no sentence stating what a tool, a registry or a
  service declares today. The test is whether it can change between the page
  and the run with no commit in this repository: if it can, the run finds it
  anew and the page is not where it is written. Dating it changes nothing,
  because `/apply` rechecks it either way and acts on what it finds.
* What a file of the repository pins stays on the page: it moves only through
  a commit, and the run reads the same file. So does what already happened,
  which no publication undoes. On the first target, "Node 20 in the workflow",
  "the `@types/node` already in `package.json`" and "Node 20 left support in
  April 2026" are the page's to hold.
* What the page writes instead is the constraint that stands whatever the
  recheck finds. When the delivery's scope turns on the answer, it writes the
  condition the run evaluates, never the finding: "the workflow's Node pin
  moves in this delivery if the runner does not support it, and stays if it
  does", not "the current range excludes it".
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** One skill and one manual kit-owned; a target receives them on
`update`. Applies after `propose-does-not-fix-what-it-cannot-run`, extending
the paragraph that delivery added to the same section; the surrounding
sections do not change.

* `skills/propose/SKILL.md`, Write: the "Exact is not pinned" paragraph is
  followed by one more, which says that the Contract holds no fact the run
  rechecks; the test, whether it can change between the page and the run with
  no commit in this repository; that a date does not rescue it; that what a
  file of the repository pins, and what already happened, stay; and what is
  written instead, the constraint that stands whatever the recheck finds, or,
  when the scope turns on the answer, the condition the run evaluates and
  never the finding. One paragraph and no longer: the skill's length is what
  `commands-read-sections-not-manuals` measures next.
* `manuals/process.md` §4, the Contract bullet: after "leaves the version to
  `/apply`", one clause saying it holds no fact the run rechecks, because what
  a tool declares today changes with no commit here, so the page writes the
  constraint or the condition and never the finding.
* `docs/03-Domain.md`, the Contract row: the same rule, with this first
  occurrence cited. Written by this page (`every-term-enters-03-first`).
* `VERSION`: one minor above what the file holds, `0.19.0` when it reads
  `0.18.0`; its own apply reads the file.
* This repository: `docs/00-Product.md`, Defining a delivery, "exact means
  what must hold, never what only a run settles" gains "and never a fact the
  run rechecks"; `docs/06-Queue.md` line `[x]`.

**Slice.** `skills/propose/SKILL.md` and `manuals/process.md`, kit-owned;
this repository's `docs/`, project-owned. `graph: explain
"skills/propose/SKILL.md" named 5 nodes, the file's five sections, affected
named 0`, so nothing outside the file changes with it. Nothing in
`bin/focus-kit`, `skills/initialize/`, `skills/apply/` or `config/`, so no
function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new and neither command gains a fixed
line: what changes is what the page holds. `/apply` gains no state either, a
condition the page leaves to the run being what its Build already settles by
running.

**Visual reference.** The first target's Node bullet, as it read and as the
rule asks:

```
as written:  It runs on the Node version .github/workflows/deploy-pages.yml
             pins, without a second loader dependency. That pin moves in this
             delivery. The workflow pins Node 20, which left support in April
             2026, and the current runner declares an engines range that
             excludes it (checked 2026-09-17). So the pin goes to a Node the
             runner supports [...]
as the rule: It runs on the Node version .github/workflows/deploy-pages.yml
             pins, without a second loader dependency. That pin is Node 20,
             which left support in April 2026, so it moves in this delivery
             if the runner does not support it, and stays if it does. Which
             number it takes, and whether @types/node moves with it, is what
             the run settles.
```

**Out of scope.**

* A read-only probe by `/propose`: one occurrence, recorded and not counted
  (`docs/06-Queue.md`, and `work/done/propose-does-not-fix-what-it-cannot-run.md`),
  and where the page gets its facts is not what this page decides, a fact the
  run rechecks being forbidden whatever its source.
* Behaviour, States and Visual reference: only the Contract must be exact
  (`docs/05` §3), and the queue line names the Contract as what still holds
  the fact.
* A bullet in `skills/apply/SKILL.md`: no error happened on its side
  (`docs/00`, product question 6), and a condition the page leaves to the run
  is what Build already settles by running.
* A check in `selftest`: nothing checks a skill's prose; the proof is a run
  (`docs/05` §6).
* The `docs/05` template's §3 paragraph: the rule lives in the manual and the
  skill, as `propose-ends-by-naming-the-next-session` decided.
* A House rule in `manuals/process.md` §6: one command carries it, in one
  place; a second occurrence is what would earn the house rule.
* An ADR: reversing this is deleting a paragraph and two clauses
  (`docs/03`, ADR).

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what the file holds; `focus-kit install .` run here last.
* [x] `grep -n "the run rechecks" skills/propose/SKILL.md manuals/process.md
  docs/00-Product.md docs/03-Domain.md` prints the paragraph, the §4 clause,
  the Defining a delivery clause and the Contract row.
* [x] Proof: `focus-kit update ~/Downloads/vaulted`; then `work/testing-setup.md`
  there is deleted and its queue line put back to `[ ]`, so the run meets the
  conditions the red was measured under and cannot read the dated sentence out
  of the page it is rewriting. Nothing is lost: that page is recorded verbatim
  in `work/done/propose-does-not-fix-what-it-cannot-run.md`, and the clone is
  disposable (`docs/03`, First target). Then, in a clean session, `/propose
  testing-setup`, the same line that produced the red, the stakeholder
  answering as the owner would. Green is a Contract
  with no sentence stating what the runner, a registry or a service declares
  today, dated or not, the Node bullet being a constraint or a condition the
  run evaluates, and the three criteria of the previous delivery still green:
  no version beside the runner's name, no config file name, no sentence about
  what the install will find. Any of them red is a queue line, never an edit
  of this page. `git reset` there, nothing committed. The done page carries
  the Node bullet as it was and as it came back, verbatim. What the run
  produced wins over this page.
* [x] The `docs/03` Contract row extended; the `docs/00` clause; the queue
  line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

`graph: explain "skills/propose/SKILL.md" named 5 nodes, the file's five
sections, affected "skills/propose/SKILL.md" named 0`. The graph was current
(`built_at_commit` `6e2ad59f`, equal to `HEAD`; post-commit hook installed),
so §Ensuring the graph said nothing. A skill is a document node whose only
edges are the headings it contains, so the slice was read from the page and
from the four files the Contract names.

### What was built

`skills/propose/SKILL.md`, Write: one paragraph after "Exact is not pinned",
opening "It holds no fact the run rechecks either", holding the test (a
sentence about what a tool, a registry or a service declares today can change
between the page and the run with no commit in this repository), that a date
does not rescue it, what stays (what a file of the repository pins, because
it moves only through a commit and the run reads the same file, and what
already happened, which no publication undoes), and what the page writes
instead (the constraint that stands whatever the recheck finds, or the
condition the run evaluates and never the finding).

`manuals/process.md` §4, the Contract bullet gains, after "leaves the version
to `/apply`": "It holds no fact the run rechecks either, because what a tool,
a registry or a service declares today changes with no commit in the
repository, so the page writes the constraint, or the condition the run
evaluates, and never the finding."

`docs/00-Product.md`, Defining a delivery: "exact means what must hold, never
what only a run settles" gains "and never a fact the run rechecks".

`VERSION` `0.18.0` to `0.19.0`.

### What diverged from the plan

**The `docs/03-Domain.md` Contract row was already there.** As on the
previous delivery, `/propose` had written it in the working tree, unstaged,
which is what `every-term-enters-03-first` requires and what this page's
Contract says ("Written by this page"). Read back against Behaviour it agrees
on every point: the rule, the test, that a date does not rescue it, what
stays, what is written instead, and both first occurrences cited. Nothing
there was touched.

**Nothing else diverged in the build.** The proof is where the divergence is.

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.19.0` in, over the `0.18.0` the
previous delivery left. Then the conditions the red was measured under:
`work/testing-setup.md` deleted there and its queue line put back from `[>]`
to `[ ]`, the mark alone.

What was **not** put back, because the page asked for the mark and the file
and nothing more: the Open decision 3 record of that queue line, which the
previous `/propose` had written ("Decided by the stakeholder on 2026-09-17:
**Vitest** ... Until it runs, this line is the record"). It carries no fact a
run rechecks: a decision is what already happened, which the rule this
delivery writes leaves on the page. Its effect on the run is one the rule
before this one asked for: the runner was a decided matter and never reached
the person. The run said `questions: 1 asked; 9 decided by files`; the first
run, whose transcript is
`~/.claude/projects/-Users-jckodel-Downloads-vaulted/66a35513-55e9-45fd-b4b9-205c657cd91b.jsonl`,
said `4 asked; 9 decided by files`, the runner among the four.

A clean session ran `/propose testing-setup`, the stakeholder answering as
the owner would: one question, which rule receives the test, answered
`calculateTotals`. The page it wrote is
`~/Downloads/vaulted/work/testing-setup.md`.

**The Node bullet, as it was:**

~~~
* It runs on the Node version `.github/workflows/deploy-pages.yml` pins,
  without a second loader dependency. **That pin moves in this delivery.**
  The workflow pins Node 20, which left support in April 2026, and the
  current runner declares an `engines` range that excludes it (checked
  2026-09-17). So the pin goes to a Node the runner supports and that is
  still in maintenance, and the runner is never held back to an obsolete
  release to satisfy a pin nobody chose. Which number that is, and whether
  `@types/node`, which follows the same pin, moves with it, is what the run
  settles.
~~~

**As it came back: it did not.** The Contract has no Node bullet. `grep -n -i
"node\|engines\|version"` over the page returns six lines and not one of them
is about a Node version or a runner's metadata: "conversion rate" twice,
"the current version" of the app loading a backup, "It runs in Node, with no
browser like environment in this delivery", `node_modules` inside a grep
command, and "the delivery's version" of the deployment. The one date on the
page is outside that grep, on line 34, and is the stakeholder's decision. The
four tooling bullets the page does carry are constraints over files of the
repository:

~~~
* It runs the project's TypeScript under `tsconfig.json` as it stands:
  `strict`, ESM, bundler resolution, the `@/*` alias. No separate compile
  step and no second type configuration to keep in sync.
* It runs in Node, with no browser like environment in this delivery. The
  repository row of `docs/04-Conventions.md` §5 wants a real IndexedDB, and
  that belongs to `vault-repository`, the delivery that touches the store.
  The runner chosen must be able to take such an environment later without
  being replaced.
* It enters `devDependencies` only. Nothing it adds may reach the static
  export: `next.config.ts` sets `output: "export"` and the shipped bundle is
  where the privacy promise is structural (ADR-0001, ADR-0002).
* It does not change how the app builds or lints. `npm run lint` and
  `npm run build` behave exactly as they do today, apart from the test file
  now being linted and type checked like any other source file.
~~~

**The four criteria are green.**

*No sentence stating what a tool, a registry or a service declares today,
dated or not:* green. The only date on the page is the stakeholder's decision
of 2026-09-17, which is what already happened. Every other tooling sentence
is a constraint over `tsconfig.json`, `next.config.ts` or
`docs/04-Conventions.md` §5, files that move only through a commit and that
the run reads itself.

*The Node bullet a constraint or a condition:* green by removal, which is the
divergence. The page expected the bullet to come back as a condition ("moves
in this delivery if the runner does not support it, and stays if it does");
the run instead dropped the Node concern from the delivery and put the
workflow in **Out of scope**, because the queue line names two documents and
nothing else and the workflow does not run `npm run lint` today either.
`docs/05-Process.md` §6 says the run wins. It is a sounder outcome than the
prediction: moving a deployment's Node pin inside a delivery whose queue line
is a test runner was scope the line never asked for, and the first run
reached it only through the fact this delivery forbids. The rule does not ask
for the condition to be written; it forbids the finding, and a scope that
does not turn on the answer needs neither.

*No version beside the runner's name:* green. Vitest is named once and no
number follows it anywhere.

*No config file name, and no sentence about what the install will find:*
green. The runner's configuration is referred to once, in "Done when", as
"The runner's own configuration at the repository root", with no name and no
extension.

**No red, so no queue line.** The visual reference of this page stays as
written, an illustration of the rule and not a prediction of the run.

`git reset` in the target, a no-op: `git status --short` is the same fourteen
lines before and after, `HEAD` still `f6e685c`, nothing staged and nothing
committed. The page the run wrote stays there, and its queue line is `[>]`
again, which is where the previous delivery left it.

### Environments

| Environment | State |
|---|---|
| Kit source | `0.19.0`, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | `0.19.0`, in sync, check 6 empty |
| Machine (`~/.local/bin/focus-kit`) | the symlink, follows the source |
| First target (`~/Downloads/vaulted`) | `0.19.0`, one `/propose` run through it, nothing staged, nothing committed |
| Target repositories | untouched, until each owner runs `focus-kit update` |
