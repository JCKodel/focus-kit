# initialize-asks-for-the-proof-tool

**Goal.** A person running `/initialize` on a brownfield repository that has
a screen is asked which tool proves it, so the target's `docs/05-Process.md`
§6 names the tool `/apply` reaches for and not only what the files answered.
Measured on the first target (`work/done/first-target-initialize.md`,
finding 3): §6 named two viewports, both themes, two reference images and
the divergence rule, and no tool; `package.json` had no browser driver, and
step 2 of the same document said "Screenshot the changed screen".

**Behaviour.**

* `/initialize brown`, after the seven readings and Ensuring the graph, and
  before writing anything, asks the Proof tool question when the repository
  has a screen: a web page, a mobile or a desktop app, which the sixth
  reading (the source tree) already showed. A repository with no screen is
  not asked, and §6 says how an endpoint or a CLI is proven, as today.
* The answer opens §6: its first line is `**Tool.**` and what was chosen.
  The rest of the section stays what the files answered, each one cited.
* A review run (`docs/00-Product.md` exists) whose §6 names no tool asks
  the same question and proposes the edit to §6, as it proposes every
  other edit, section by section.
* `/initialize green`, round 4, asks the same question in the same words.
* "Not now" at the graph changes nothing here: the question reads no graph.
* `bin/focus-kit selftest` green; check 6 empty after `focus-kit install .`.

**Contract.** Both files kit-owned; a target receives them on `update`.
Applies after `graph-answers-structure`, which rewrites the graph paragraph
of the same Step 1 and takes `0.13.0`.

* `skills/initialize/SKILL.md`, Step 1 (brownfield): one paragraph after
  the last one, the one that begins "When a graph came out of it". It says
  that what the seven readings cannot answer is asked before writing, and
  that today this is one thing, the tool that proves a screen, because no
  file in a repository names what takes a screenshot; a second slot no file
  answers joins this paragraph as a line, not a new step. Then the Proof
  tool question, written once and asked as written, one `AskUserQuestion`:
  `How is a screen proven? No file names the tool.` Three options, in this
  order: **Claude in Chrome**, the browser inside Claude Code, a screenshot
  at the viewports §6 names, nothing added to the repository; **A script or
  driver of the repository**, the person names it (Playwright, an emulator,
  a device) and its command, and it lives in the repository like any other
  tool; **None**, the verify command is the proof and §6 says so in one
  line. "Other" is Claude Code's own fourth option, for what does not fit.
* Same skill, Step 1 (greenfield), round 4: "how a screen is proven"
  becomes "which tool proves a screen: the Proof tool question, as in the
  brownfield step".
* Same skill, Step 0, the review paragraph: one sentence, a
  `docs/05-Process.md` §6 that names no tool gets the Proof tool question
  and a proposed edit, like any other section.
* Same skill, Step 3: "the permission allows this stack needs" gains "and
  the one the Proof tool needs, when it has one".
* `skills/initialize/templates/docs/05-Process.md`, the §6 init comment:
  opens with the tool, from the Proof tool question, never inferred, and
  the finished section opens with `**Tool.**`; the rest of the comment as
  today.
* `VERSION`: `0.13.0` to `0.14.0`.
* This repository: `docs/03-Domain.md` carries the Proof tool row, written
  by this page; `docs/06-Queue.md` line `[x]`. `docs/00` Initializing and
  `manuals/process.md` already say "asks only what the code cannot answer"
  and stay as they are: this delivery makes the sentence true.

**Slice.** One skill and one template, kit-owned; this repository's `docs/`,
project-owned. Nothing in `bin/focus-kit`, `manuals/` or `config/`, so no
function row of `docs/01` §3 changes. No FOCUS pieces (ADR-0003).

**States.** The CLI prints nothing new. In the session: the question, when
there is a screen; when there is none, one line, `no screen found; §6 says
how the endpoint or the CLI is proven`; after an answer, nothing said, §6
carries it. On a review run, the proposed §6 edit is shown like the others.

**Visual reference.** The question as the session shows it:

```
How is a screen proven? No file names the tool.
  Claude in Chrome         the browser inside Claude Code; screenshot at the
                           viewports §6 names; nothing added to the repository
  A script or driver       yours: Playwright, an emulator, a device; name it
  of the repository        and its command
  None                     the verify command is the proof; §6 says so
```

**Out of scope.**

* `/apply` stopping when §6 names no tool: fixed at the source, and the one
  target with such a §6 no longer has it (`~/Downloads/vaulted` has no
  `docs/00` to `06` in its working tree today).
* The other slots the brownfield path fills (environments, publish policy,
  git): the files answered them in the first target; the paragraph above
  is where a second one that no file answers goes.
* The visual reference: read off the first target correctly.
* An ADR: reversing this is deleting a paragraph.
* This repository's own §6: no screen here.

**Done when.**

* [x] `bin/focus-kit selftest` green, check 6 empty; `VERSION` at `0.14.0`;
  `focus-kit install .` run here last, after `graph-answers-structure` is
  `[x]`.
* [x] `grep -n "Proof tool" skills/initialize/SKILL.md` prints the brownfield
  paragraph, round 4, the review sentence and Step 3; `grep -n "Tool"
  skills/initialize/templates/docs/05-Process.md` prints the §6 comment.
* [x] Proof: `focus-kit update ~/Downloads/vaulted`, then `/initialize brown`
  there in a clean session, "Not now" at the graph; the transcript of the
  Proof tool question and the §6 it wrote go in the done page; `git reset`
  there, nothing committed. What the run produced wins over this page.
* [x] The `docs/03` row present; the queue line `[x]`.
* [x] The last thing said is which environment is at which version.

---

## What happened

Two files edited, both the ones the Contract named, plus `VERSION`.
`skills/initialize/SKILL.md` gained the Proof tool question in four places
(Step 1 brownfield, Step 1 greenfield round 4, the Step 0 review paragraph,
Step 3) and `skills/initialize/templates/docs/05-Process.md` gained the tool
as the first thing its §6 comment asks for.

graph: explain "skills/initialize/SKILL.md" named 1 file, affected
"skills/initialize/SKILL.md" named 0 files. The graph was at `e676b43`,
equal to HEAD, hook installed: all four branches of Ensuring the graph
silent, nothing built, nothing asked. The skill is a document node with
eight `contains` edges to its own steps and no dependent, which is what a
kit-owned skill looks like: nothing in this repository calls it, a Claude
Code session reads it.

### What diverged from the plan

* **Where the new paragraph went.** The page said "one paragraph after the
  last one, the one that begins 'When a graph came out of it'". That is not
  the last paragraph of the step: the "Not now" one follows it. The
  paragraph went after the real last one, because the Proof tool question
  reads no graph and belongs after both branches, which is what the page's
  own "Not now" line asks for.
* **The `docs/03-Domain.md` row was already there.** The page said this
  delivery writes it. `/propose` wrote it and it landed in `e676b43` with
  `graph-answers-structure`. Its wording was re-read against the finished
  skill text and asserts exactly what the skill now does, so nothing was
  edited.
* **Two paragraphs, not one.** The brownfield addition is a prose paragraph
  and then the question with its three options, because a bullet list cannot
  live inside a paragraph. The page's "a second slot joins this paragraph as
  a line, not a new step" is carried by the first of the two.

### What was dropped

Nothing.

### Decisions taken

No ADR, as the page said: reversing this is deleting a paragraph.

### Proof, the first target

`focus-kit update ~/Downloads/vaulted` put `0.14.0` there. A clean session ran
`/initialize brown`, brownfield and English confirmed in Step 0, and the Graph
confirmation was answered **Not now**: `no graph this session; reading files
directly`. The Proof tool question was asked anyway, which is what the page
asked for, since it reads no graph.

The question, as the session showed it:

```
How is a screen proven? No file names the tool.
```

The answer was **None**. The §6 it wrote, in full:

```
## 6. Proof

**Tool.** None. The verify command is the proof.

Chosen on 2026-09-17. `npm run lint && npm run build` prerenders every
route, so a screen that cannot render does not pass. Nothing takes a
screenshot, and no screenshot tool is added to the repository.

What that leaves uncovered is behaviour, so every delivery that touches a
screen carries a **manual check** instead: the scenarios in the delivery's
Behaviour section, walked through in `npm run dev` at the two viewports
§3 names, with what was seen written into `work/done/<slug>.md`. A
scenario nobody walked is a scenario that did not pass.

The reference is the screen as it runs today. There is no design file and
no previous screenshot to diff against, so the rule for divergence is
simple: **a change to a surface says in the delivery page what it changes
and why.** An unannounced visual change is a finding, not a bonus.

For the parts with no screen (the sitemap, `robots.txt`, the service
worker, the exported files), the proof is the generated artefact read by
hand out of `out/` after a build.
```

`**Tool.**` is the first line, the answer is on it, and the rest of the
section is what the files answered, cited. The goal is met: the same target
whose §6 came out with viewports, themes and references and nothing that
takes a screenshot now names the tool, and it names it because the person
was asked rather than because a file was read.

Three things the run showed that the page did not expect, and the run wins:

* **The question travelled with a second one.** The session put the Proof
  tool question and a test runner question in the same `AskUserQuestion`.
  The page says "one `AskUserQuestion`", meaning one question and not a
  round; it does not forbid a second question riding along, and bundling is
  what Step 1 greenfield already teaches. Nothing changed for it.
* **None is an answer, not an absence.** The section opens by saying the
  verify command is the proof and then keeps the viewports, which the same §3
  names for the manual check. The tool slot and the viewport slot are
  independent, which the template comment now reflects and the page had only
  implied.
* **The question reached a repository that has a screen and no browser
  driver**, the exact shape finding 3 of `first-target-initialize` measured.
  `package.json` still has only `next` and `eslint`, and the answer came from
  the person in one keystroke instead of from an inference.

### What the proof found beyond its own scope

One friction, new, not this delivery's to fix. Step 4 of `/initialize` tells
the person to suggest the commit message "in the format `docs/05-Process.md`
defines", and that format ends with a line pointing at `work/done/<slug>.md`.
An `/initialize` run produces no such page, so the session improvised and
pointed at `docs/05-Process.md` instead, saying so out loud. Recorded here
and not turned into a queue line, because the Contract of this page does not
carry one and a line is the stakeholder's to order (`docs/03-Domain.md`,
First target). Candidate slug: `initialize-suggests-its-own-last-line`.

`git reset` was run in `~/Downloads/vaulted`: nothing staged, nothing
committed, the working tree left as the run left it.

### A parallel session

A `/propose` session wrote `work/every-term-enters-03-first.md`, added the
Read-back row to `docs/03-Domain.md` and turned its queue line to `[>]` while
this delivery ran. None of the three is staged here: one delivery, one commit
(`docs/05` §7). The queue line was staged at `[ ]` and left at `[>]` in the
working tree, so that session finds it as it left it. This is the second time
it happens, after `graph-answers-structure`, and the handling is the same.

### Environments

| Environment | Version |
|---|---|
| Kit source | `0.14.0` |
| Dogfood copy | `0.14.0`, in sync (`selftest` green, check 6 empty) |
| Machine | symlink, follows the source; global `/graphify` skill at 0.9.63 |
| First target (`~/Downloads/vaulted`) | `0.14.0`, nothing committed |
| Other targets | untouched, until their owner runs `focus-kit update` |

