# propose-does-not-fix-what-it-cannot-run

**Goal.** A page `/propose` writes says of a tool or dependency what a
document can hold, the name and the constraint the choice has to satisfy,
and leaves what only a run settles to `/apply`, which runs it and records
the choice. Measured on the first target
(`work/done/first-target-delivery.md`, finding 3): the `test-harness` page
fixed "`vitest`, and nothing else", three paragraphs later pre-answered the
version conflict in the wrong direction, `engines.node` when the wall was the
`@types/node` peer, and named `vitest.config.ts`; `/apply` had to ask which
version and renamed the file to `.mts`. The constraint that decides the
version, nothing else changes, was already on the page; the prediction beside
it contradicted it.

**Behaviour.**

* The **Contract** of a delivery names a tool or dependency and the
  constraint the choice must satisfy: what may not change, what the project
  already pins. It never holds a version, a file's name or extension, a flag,
  or a guess at what the run will find. On the first target as it was, the
  page reads "one devDependency, the runner, at whatever version installs
  against the project as it is: Node 20 in the workflow, the `@types/node`
  already in `package.json`, nothing else changed", names no config file,
  and `/apply` resolves `4.1.11` and `.mts` without asking.
* `/apply` settles what the page left to the run by running it, inside the
  constraint the page states, and its record says what it chose. When no run
  satisfies the constraint, it stops and says which, as it does with a doc
  the delivery contradicts; it does not pick a way out alone.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Two skills and one manual kit-owned; a target receives them on
`update`. Applies after `propose-ends-by-naming-the-next-session`, which
adds Close to the same skill and the guard to the other; this page touches
neither section.

* `skills/propose/SKILL.md`, Write: the sentence that defines the
  Contract's exactness ("a wrong screen is fixed in a session, a wrong column
  is a migration") is followed by one paragraph: exact is not pinned; of a
  tool or dependency the page holds the name and the constraint the choice
  has to satisfy, never a version, a file's name or extension, a flag, or a
  guess at what the run will find, which are `/apply`'s to settle by running;
  a page that pins one is fixing what it cannot run.
* `skills/apply/SKILL.md`, Build: after "Do not add a dependency, a layer or
  a tool the delivery did not name", one bullet: what the page leaves to the
  run, a version, a file's name or extension, a flag, you settle by running
  it, inside the constraint the page states, and Close step 1 says what you
  chose; when no run satisfies the constraint, stop and say which, as with a
  doc the delivery contradicts.
* `manuals/process.md` §4, the Contract bullet: "The only section that must
  be exact" gains "exact about what must hold, not about what only a run
  settles: of a tool it names the tool and the constraint, and leaves the
  version to `/apply`". §5 step 2 gains "settling what the page left to the
  run and recording the choice".
* `VERSION`: one minor above what `propose-ends-by-naming-the-next-session`
  leaves, `0.18.0` when that page takes `0.17.0`; its own apply reads the
  file.
* This repository: `docs/00-Product.md`, Defining a delivery, "only the
  contract has to be exact" gains "and exact means what must hold, never
  what only a run settles"; Building it, "it builds each piece in its place"
  gains "settling what the page left to the run"; `docs/03-Domain.md`
  carries the Contract row, written by this page; `docs/06-Queue.md` line
  `[x]`. The `docs/05` template's §3 paragraph does not change: a target
  reads the rule in `manuals/process.md` §4, as `propose-ends-by-naming-the-
  next-session` decided for the same template.

**Slice.** `skills/propose/SKILL.md`, `skills/apply/SKILL.md` and
`manuals/process.md`, kit-owned; this repository's `docs/`, project-owned.
`graph: explain "skills/propose/SKILL.md" named the file's four sections,
affected named 0`, so nothing outside the three files changes with them.
Nothing in `bin/focus-kit`, `skills/initialize/` or `config/`, so no function
row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new, and neither command gains a fixed
line: what changes is what the page holds. The one new state is `/apply`
finding that no run satisfies the constraint, and there it says which
constraint and which run, in its own words, and stops, as the existing
contradiction rule already has it do.

**Visual reference.** The two Contract lines of the first target's page, as
they read and as they should have read:

```
as written:   One devDependency is added, vitest, and nothing else. [...] If
              vitest's engines.node floor rises above the workflow's Node 20,
              the workflow's node version is what moves. [...] vitest.config.ts
as the rule:  One devDependency enters, the runner chosen above, at whatever
              version installs against the project as it is: Node 20 in the
              workflow, the @types/node already in package.json, nothing else
              changed. Its config file is the runner's own, named as its
              documentation names it.
```

**Out of scope.**

* A read-only probe by `/propose` (`npm view` and its kin): the skill may
  name no package manager (`docs/00`, Not stack-specific), and a probe covers
  one of the two occurrences; the `.mts` extension only a run discovers.
* Exactness in Behaviour, States or Visual reference: only the Contract must
  be exact (`docs/05` §3), the rest is fixed in a session.
* The `docs/05` template's §3 paragraph: the rule lives in the manual and the
  skill, as the delivery before this one decided.
* A House rule in `manuals/process.md` §6: two commands carry it, each in its
  own words; a third occurrence earns the house rule.
* A check in `selftest`: nothing checks a skill's prose; the proof is a run
  (`docs/05` §6).
* `/initialize` writing a version into a queue line: none measured.
* An ADR: reversing this is deleting a paragraph, a bullet and a row.

**Done when.** Every line ticked. The proof's third criterion came back red,
which is a ticked line and not a failed one: the criterion was applied, the
red is recorded below, and the fix is the queue line the same criterion
names.

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` one minor above
  what `propose-ends-by-naming-the-next-session` left; `focus-kit install .`
  run here last, after that delivery is `[x]`.
* [x] `grep -n "cannot run" skills/propose/SKILL.md` prints the paragraph;
  `grep -n "leaves to the run" skills/apply/SKILL.md` prints the bullet;
  `grep -n "only a run settles" manuals/process.md docs/00-Product.md` prints
  the §4 bullet and the Defining a delivery sentence.
* [x] Proof: in `~/Downloads/vaulted` as `propose-ends-by-naming-the-next-session`
  leaves it, `focus-kit update ~/Downloads/vaulted`, then in a clean session
  `/propose testing-setup`, the only `[ ]` line there whose Contract carries
  a dependency, the stakeholder answering as the owner would; the runner is
  that repository's Open decision 3, so asking it is right. The page's
  Contract names the runner and the constraint, and holds no version number
  beside the runner's name, no config file name and no sentence about what
  the install will find; any of the three is red, and the fix is a queue
  line, never an edit of this page. `git reset` there, nothing committed; the
  page stays. The done page carries the Contract's tooling lines verbatim.
  What the run produced wins over this page.
* [x] The `docs/03` row present; the two `docs/00` clauses; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

`graph: explain "skills/propose/SKILL.md" named 5 nodes, the file's five
sections, affected "skills/propose/SKILL.md" named 0`; the same for
`skills/apply/SKILL.md` and `manuals/process.md`, both 0. The graph was
current (`built_at_commit` `1bcb0442`, equal to `HEAD`; post-commit hook
installed), so the procedure said nothing. A skill is a document node whose
only edges are the headings it contains, so the slice was read from the page
and from the four files the Contract names.

### What was built

`skills/propose/SKILL.md`, Write: the exactness sentence ends where it ended,
and one paragraph follows it, "Exact is not pinned", holding what a document
can hold (the name and the constraint), what it never holds (a version, a
file's name or extension, a flag, a guess at what the run will find), whose
those are, and the closing line, a page that pins one is fixing what it
cannot run.

`skills/apply/SKILL.md`, Build: one bullet after "Do not add a dependency, a
layer or a tool the delivery did not name", naming what the page leaves to
the run, that you settle it by running it inside the constraint the page
states, that Close step 1 says what you chose, and the stop when no run
satisfies the constraint.

`manuals/process.md` §4, the Contract bullet gains "exact about what must
hold, not about what only a run settles: of a tool it names the tool and the
constraint, and leaves the version to `/apply`"; §5 step 2 gains "settling
what the page left to the run and recording the choice".

`docs/00-Product.md`, Defining a delivery: "and exact means what must hold,
never what only a run settles"; Building it: "settling what the page left to
the run".

`VERSION` `0.17.0` to `0.18.0`.

### What diverged from the plan

**The `docs/03-Domain.md` Contract row was already there.** The page says it
is "written by this page", and `/propose` had already written it in the
working tree, unstaged, as `every-term-enters-03-first` requires. Read back
against Behaviour, it agrees on every point: what the row holds, what it
never holds, whose the settling is, and the stop when no run satisfies the
constraint, with the first occurrence cited. Nothing there was touched.

**`docs/00-Product.md`, Building it, was rewrapped by one line.** Inserting
the clause left "proves the result the way the project's" alone on a short
line; the paragraph was rewrapped. No word changed but the ones the Contract
adds.

### What was dropped

Nothing. Every line of the Contract is in.

### Decisions taken

No ADR, as the page said: reversing this is deleting a paragraph, a bullet
and a row.

### The verify command

```
focus-kit 0.18.0 selftest
  ✓ 1 bin/focus-kit parses
  ✓ 2 install into a scratch repository, doctor agrees
  ✓ 3 the second install leaves the same tree
  ✓ 4 the three SKILL.md frontmatters are well formed
  ✓ 5 no em dash in the paths this repository authors
  ✓ 6 the dogfood copies match their sources

selftest green: a target repository would receive a working kit
```

Run after `focus-kit install .`, which is the order check 6 requires. The
four greps of "Done when": `cannot run` prints line 83 of
`skills/propose/SKILL.md`; `leaves to the run` prints line 56 of
`skills/apply/SKILL.md`; `only a run settles` prints line 78 of
`manuals/process.md` and line 171 of `docs/00-Product.md`.

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.18.0` in, over the `0.17.0` the
previous delivery left. `HEAD` there is `f6e685c`; `git status --short` is
the same fourteen lines before and after, nothing staged, `git reset` run and
a no-op, the page left in place.

A clean session ran `/propose testing-setup`, the stakeholder answering as
the owner would: **Build now** at the Graph confirmation (`graph built:
561,767 input tokens`, 443 nodes in 24 communities), then Vitest as the
runner, `calculateTotals` as the rule, the privacy boundary check as its own
queue line, and the workflow running the verify chain. The page it wrote is
`~/Downloads/vaulted/work/testing-setup.md`.

**The Contract's tooling lines, verbatim:**

~~~
*The runner is **Vitest***, the stakeholder's answer to Open decision 3
(`docs/06-Queue.md`). The page names it and names what the choice has to
satisfy; the version, the config file's name and extension, the environment
flag and the reporter are `/apply`'s to settle by running it.

* It reads TypeScript under `tsconfig.json`'s `strict: true` with no
  separate transpile step, and resolves the `@/*` path alias declared
  there.
* It runs ES modules, which is this project's format
  (`"module": "esnext"`).
* It runs on the Node version `.github/workflows/deploy-pages.yml` pins,
  without a second loader dependency. **That pin moves in this delivery.**
  The workflow pins Node 20, which left support in April 2026, and the
  current runner declares an `engines` range that excludes it (checked
  2026-09-17). So the pin goes to a Node the runner supports and that is
  still in maintenance, and the runner is never held back to an obsolete
  release to satisfy a pin nobody chose. Which number that is, and whether
  `@types/node`, which follows the same pin, moves with it, is what the run
  settles.
* It can later run a test against a real IndexedDB in a browser like
  environment without the runner being replaced, because
  `docs/04-Conventions.md` §5 requires one for the repository row and
  `vault-repository` is two lines down the queue.
* It enters as a **devDependency**. Nothing it brings reaches the client
  bundle: the test file is imported by no module the routes reach, and
  `output: "export"` bundles only what they reach.
~~~

**Two of the three criteria are green, the third is red.**

*No version number beside the runner's name:* green. The runner is named
once and no number follows it anywhere on the page, and the Contract says in
its own words that the version is `/apply`'s to settle. The first target's
`test-harness` page could not have been written this way.

*No config file name:* green, and this is the criterion the old page failed
twice. The runner's config file is referred to three times and named none of
them: "the config file's name and extension" in the sentence that hands it to
`/apply`, and "the runner's config file" where the page notes it becomes a
third default export. No `vitest.config.ts`, no extension, no `.mts`.

*No sentence about what the install will find:* **red.** The Node bullet says
"the current runner declares an `engines` range that excludes it (checked
2026-09-17)". That is a statement about what the install will find, sitting
in the Contract, and it is the same clause of the same field that produced
finding 3 on the first target. Three things separate it from that failure and
none of them makes it green: it is measured rather than guessed, it is dated,
and it resolves nothing, leaving both the Node number and `@types/node` to
the run. What it does not escape is the reason the rule exists: an `engines`
range is the runner's, it changes when the runner publishes, and the sentence
is wrong from that day on while reading as a fact `/apply` may act on.

The fix is a queue line and not an edit of this page, as "Done when" requires:
`propose-holds-no-fact-the-run-rechecks`, added to milestone 2 right after
this delivery's own line. It carries the probe question too: the session ran
a read-only probe of the runner's metadata on its own, which this page put
out of scope. That is one concrete occurrence and not two: the first target's
`test-harness` page did not probe, it guessed, which is the finding this
delivery exists for. So the probe is recorded and not counted, and the rule
of the second occurrence is still waiting for its second. It is recorded here
rather than acted on, because the page's scope is the Contract's words and
not where `/propose` gets its facts.

**What the run produced wins over this page.** The page's Visual reference
predicts "at whatever version installs against the project as it is: Node 20
in the workflow". The run did not write that sentence and was right not to:
it found the Node 20 pin itself unsupported and moved it, inside the same
delivery, rather than holding the runner back to satisfy it. The rule this
delivery writes did not ask for that and does not forbid it: the page states
the constraint ("a Node the runner supports and that is still in
maintenance") and leaves the number to the run, which is the shape the rule
asks for. The Visual reference stays as written, as an illustration of the
two Contract lines and not as a prediction of this run.

### Environments

| Environment | State |
|---|---|
| Kit source | `0.18.0`, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | `0.18.0`, in sync, check 6 empty |
| Machine (`~/.local/bin/focus-kit`) | the symlink, follows the source |
| First target (`~/Downloads/vaulted`) | `0.18.0`, one `/propose` run through it, nothing staged, nothing committed |
| Target repositories | untouched, until each owner runs `focus-kit update` |

