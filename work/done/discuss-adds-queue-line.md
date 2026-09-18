# discuss-adds-queue-line

**Goal.** A person with an idea and no queue line can think it through with
the agent and end with the line, placed, instead of opening a delivery page
too early or editing `docs/06-Queue.md` by hand.

**Behaviour.**

* `/discuss <the idea>` reads `docs/00-Product.md`, `docs/03-Domain.md`,
  `docs/06-Queue.md` and whatever is in `work/`. It runs no graph procedure
  and asks the graph nothing.
* With no argument it asks what the idea is. A word typed after the command
  is the idea, whatever its shape.
* The conversation is exploratory, not a form: the agent offers alternatives,
  says what each buys and what it costs, recommends one first, and asks with
  `AskUserQuestion` whenever more than one reading survives the reading of
  the files. It is where a product decision gets taken, so that the
  `/propose` after it starts from something already decided.
* Where the idea adds a part to the process, the conversation asks the
  question `docs/00-Product.md` asks of every such part: which concrete
  error that happened would it have caught.
* The **Decided matter** pass of `/propose` applies here too: a question a
  file already read closes is not put in front of the person, it is said out
  loud with the file cited.
* When a queue line or a Later bullet already covers the idea, `/discuss`
  says which one and writes nothing.
* It writes one line in `docs/06-Queue.md`, and a row in
  `docs/03-Domain.md` when the idea names a concept the table does not have.
  It writes nothing else: no `work/<slug>.md`, no ADR, no code, no notes
  file. What the conversation settled travels in the queue line's own words.
* Where the line goes is asked, recommendation first, and never assumed:
  until `queue-line-finds-its-place` gives the placement a rule, the order is
  the person's decision, taken in conversation (`docs/03-Domain.md`, Queue).
* It never moves an existing line, never edits one and never changes a mark.
* It ends naming what it wrote and the command that builds on it,
  `/propose <slug>`, in the same session: only `/apply` needs a clean one
  (`docs/03-Domain.md`, Clean session).

**Contract.**

* New kit-owned file, `skills/discuss/SKILL.md`, and nothing else in the
  folder. Frontmatter: `name: discuss`, a `description: >-` block, an
  `argument-hint`. It carries the License notice line every kit-owned file a
  target receives carries, and no kit-owned banner, because its first line is
  frontmatter (`docs/04-Conventions.md`).
* The CLI stops naming the skills. Every place that enumerates them reads
  the kit's `skills/` tree the way it already reads `manuals/*.md`, so a
  fifth command is a folder and no edit: the install, the manifest writer,
  `doctor`'s presence loop, its behind-the-source pipeline, its added-file
  loop, and check 4. No list of skill names survives in the script. The one
  exception is check 2, whose expected lines are assertions and stay literal
  the way each manual is literal there; `/discuss` joins them.
* Check 4's `ok` line stops counting the frontmatters, and the install's
  `ok` line names the folders it wrote from the same enumeration.
* `config/graphifyignore.fragment` gains `.claude/skills/discuss/`. This
  repository's own `.graphifyignore` gets the same line by hand, because the
  fragment is appended once and `focus-kit install .` will not re-append it.
* `manuals/process.md` gains `/discuss` as a new §4, in narrative order
  before `/propose`; §4 to §10 become §5 to §11. Its §1, its §2 file block
  and its last section's "the three skills" follow. Every citation of a
  numbered section of that manual inside this repository is renumbered; one
  grep finds them. No template and no skill cites a numbered section of it,
  so no target receives a citation that moved: the open question about a
  kit-owned file changing shape (`docs/00-Product.md`, open decision 5) is
  not settled here and is not triggered here either.
* `skills/apply/SKILL.md` counts `/discuss` among the commands whose
  presence makes a session not clean, and the Clean session row of
  `docs/03-Domain.md` says so.
* Templates: the flow line of `skills/initialize/templates/docs/05-Process.md`
  starts at the idea and `/discuss` ahead of the queue, and its Queue section
  says `/discuss` is what adds a line. `skills/initialize/templates/CLAUDE.md`
  names the four commands on its delivery line.
* The line `/discuss` writes has the queue's own shape: a Slug, which is an
  Identifier and stays English, plus the scope in the Documentation language
  (`docs/03-Domain.md`, `docs/05-Process.md` §0), and no em dash. The skill
  says so, the way `/propose` says it.
* `docs/03-Domain.md` gains a **Discuss** row and its Command row says four.
  A row `/discuss` writes carries the code name when the conversation knows
  it and otherwise a parenthetical saying where it will be named, the way
  `(per stack)` and `(prose, in the manuals)` already read. Its Read-back row
  and the init comment of the `docs/06` template each name `/propose` as the
  command a term waits for; both gain `/discuss` as the other door.
* Every text of this repository that counts the commands or the kit-owned
  files stops counting or counts the new number: `README.md`,
  `docs/00-Product.md`, `docs/01-Architecture.md`, `docs/03-Domain.md`,
  `docs/04-Conventions.md`, `docs/05-Process.md`, `CLAUDE.md`. `docs/00`
  gains a Mechanics subsection for `/discuss`; `docs/01` §3 and §4 carry the
  enumeration and the new order `doctor` prints in; milestone 3's paragraph
  in `docs/06-Queue.md` stops saying that none of its lines bumps `VERSION`,
  because this one does.
* `VERSION` is bumped: a target receives a new command.

**Slice.** `bin/focus-kit`, the whole CLI, plus the content it moves
(`docs/01-Architecture.md` §3, Structure). No View, Orchestrator, Use case or
Repository: §3 says none of the four exists here. Kit-owned:
`skills/discuss/SKILL.md`, `skills/apply/SKILL.md`, `manuals/process.md`,
the two templates. Appended
once: `config/graphifyignore.fragment`. Project-owned: this repository's
`docs/`, `CLAUDE.md`, `README.md` and its own `.graphifyignore`.

**States.**

* `docs/06-Queue.md` absent: `/discuss` says the repository has no queue,
  names `/initialize`, and writes nothing.
* The idea is already in the queue or in Later: it names the line and writes
  nothing.
* The kit's own output: the defaults. `install`, `doctor` and `selftest`
  gain the fourth skill and change no message shape.

**Visual reference.** No UI. The lines that change, in the enumeration's
order:

```
ok   .claude/skills/{apply,discuss,initialize,propose}
ok   /apply
ok   /discuss
ok   /initialize
ok   /propose
ok   4 the SKILL.md frontmatters are well formed
```

**Out of scope.**

* Where a line belongs: milestone paragraphs, Later as `[ ]` lines, and
  proposing a milestone are `queue-line-finds-its-place`, the next line in
  the queue, which says "After discuss-adds-queue-line".
* `/propose` is untouched, including its clause that adds a missing line:
  the stakeholder's call, this conversation.
* An old target's `.graphifyignore` never receives the new folder, the way
  it never received a changed `.gitignore` block: appended once, and `update`
  leaves it alone (`docs/06-Queue.md`, Later).
* No ADR. A fourth skill is reversible by deleting a folder, and the queue
  line is the decision (`docs/03-Domain.md`, ADR).
* No graph procedure in `/discuss`, and `doctor`'s line about a missing
  graph keeps naming `/propose` and `/apply`.
* A skill that amends a milestone paragraph on its own is
  `queue-line-finds-its-place`; this delivery only corrects the one
  paragraph its own change made untrue.

**Done when.**

* [x] `bin/focus-kit selftest` is green, six checks.
* [x] A real run of `/discuss` in a scratch repository with no queue says so
  and writes nothing, and a real run in this repository writes one line that a
  person reads and keeps; both go into `work/done/discuss-adds-queue-line.md`
  (`docs/05-Process.md` §6). The second run is a conversation, so the idea it
  runs on is the person's to bring, and the line it produces commits with the
  delivery.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy carries the fourth skill (`docs/05-Process.md` §5).
* [x] No text in this repository counts three commands.
* [x] `docs/00`, `docs/01`, `docs/03`, `docs/05`, `README.md` and `CLAUDE.md`
  updated in this delivery.

---

## Record

`VERSION` 0.23.0. A target receives a fourth command.

### What the run settled

**The helper the page did not name.** Six places enumerated the commands:
`install_repo`'s skill loop, `write_manifest`, `doctor`'s presence loop, its
behind-the-source pipeline, its added-file loop, and `check_frontmatter`. The
first concrete occurrence was `install_repo`'s loop, the second
`write_manifest`'s, so the abstraction is earned four times over:
`kit_skills()` (`bin/focus-kit:185`) echoes one folder name per line from
`skills/*/` and is read the way `manuals/*.md` already was. Its output is
captured, so it returns and never dies (`docs/01-Architecture.md` §6). The
install's `ok` line is built from the same walk, which is why it prints
`.claude/skills/{apply,discuss,initialize,propose}` with no list behind it.
No list of skill names survives in the script, the header comment included,
which now reads `.claude/skills/<command>/`. The one exception is check 2 of
`selftest`, where the names are the assertion: a check that read the same
enumeration as the reporter would assert nothing, and the comment there now
says so.

**Three questions the page left open, answered by the stakeholder.**

1. *How far "every citation" and "no text counts three" reach.* Living text
   only: `docs/`, `CLAUDE.md`, `README.md`, the manuals and this page.
   `work/done/` and the bodies of the ADRs stay as they are, because they
   record what was true the day they were written, so `ADR-0006` keeps its
   `manuals/process.md` §6 and the thirty-nine done pages that predate this one
   were not touched.
2. *`manuals/graphify.md`.* Not in the Contract's file list, and its
   §What the graph leaves out described the very fragment this delivery
   changes ("the six files: the three skills and the three manuals"). Both it
   and the §Troubleshooting count were corrected; the manual is kit-owned and
   `VERSION` moved anyway.
3. *Which four commands the template's delivery line names.* All four of the
   kit, `/initialize` included, which is the literal reading and the same four
   the Command row of `docs/03-Domain.md` now counts.

**What the renumbering moved.** `manuals/process.md` gained §4 for `/discuss`
and its old §4 to §10 became §5 to §11. Three citations in living text
followed: `docs/01-Architecture.md` §6 to §7 and §8 to §9, the Clean session
row of `docs/03-Domain.md` §5 to §6, the `focus-is-asked-not-imposed` line of
`docs/06-Queue.md` §6 to §7 and the `queue-line-finds-its-place` line §7 to
§8. No template and no skill cites a numbered section of that manual, so no
target receives a citation that moved and open decision 5 of `docs/00` is
neither settled nor triggered.

**What the new function moved.** `docs/01-Architecture.md` §3 carries a Line
column, and `kit_skills` shifted ten of its entries; the column was refreshed
and the function got its own row, which also took "ten helpers" to eleven.
Five other `bin/focus-kit:NNN` citations in living text pointed at lines that
moved and were refreshed: `docs/00` :1006 to :1029, `docs/01` :200 to :219
and :337 to :359, `docs/04` :364 to :385 and :1005 to :1041. The manifest
grew from sixteen paths to seventeen, which is a sentence in
`docs/05-Process.md` §4 and a comment in `bin/focus-kit`.

### What diverged from the page

* **Two queue lines the page did not name.** `copilot-port` and `codex-port`
  each promised "the three commands as ... repository instructions", which is
  work not yet done and would have shipped wrong. Both now read "the kit's
  commands". No other line was touched, no line moved and no mark changed but
  this delivery's own.
* **One count left standing.** `docs/04-Conventions.md` §6 ends with the
  example commit message of `kit-selftest`, which says "checks the three
  SKILL.md frontmatters". It quotes a commit that is in the history, and
  editing it would make the example differ from `git log`. Left as it is.
* **The closing message of `install` still names `/propose`.** "docs/ already
  exists ... or go straight to /propose <slug>" is a message shape, and the
  page's **States** say the three verbs gain the fourth skill and change no
  message shape. Left alone.

### The proof (`docs/05-Process.md` §6)

Two real runs, as the page asked.

**Run 1, a scratch repository with no queue.** `mktemp -d`, `git init`,
`focus-kit install`, which wrote the four skill folders. `/discuss` then read
what its Read first names and found none of it:

```
docs/00-Product.md     absent
docs/03-Domain.md      absent
docs/06-Queue.md       absent
work/                  done
```

So the first branch: the repository has no queue yet, `/initialize` is what
writes one, and nothing is written. The scratch's `git status --short` after
the run was byte for byte what the install had left, five untracked paths and
no sixth. The scratch was removed.

**Run 2, this repository, the stakeholder's idea.** Git management options
offered to the user: a worktree per delivery, a branch per slug, or none.
The run found `git-branches-are-queue` already in the queue and said so
rather than assuming: that line covers the branch alone, and inside
`/propose`. Two matters were decided by files and said out loud instead of
asked, which is the Decided matter pass working:

```
questions: 3 asked; 2 decided by files
  whether /apply may commit or merge: docs/00-Product.md (Building it) says it
    does not commit, ever, in any configuration, whatever the project's git
    policy says, and manuals/process.md §7 carries it as a house rule
  where the answer lives: docs/03-Domain.md (Slot) and docs/05-Process.md §7
    already make the git policy a per-project slot /initialize fills
```

The three that survived were asked with `AskUserQuestion`, recommendation
first: what happens to the older line (a new line that supersedes it), which
concrete error the new part of the process would have caught, and where the
line goes. The error named is one this session produced: `/apply
discuss-adds-queue-line` ran while a `/propose` of another line changed
`docs/03-Domain.md` and `docs/06-Queue.md` under it, and both delivery pages
sat uncommitted in one tree, so `git add -A` of this delivery stages the
other's page. A worktree per delivery would have prevented it.

The run wrote one line, `git-strategy-is-asked`, in milestone 3 right after
`git-branches-are-queue`, and one row, **Git strategy**, in
`docs/03-Domain.md`. Nothing else: no page, no ADR, no mark moved. Both
commit with this delivery, as the page said they would.

**What the two runs prove that the verify command cannot.** Check 2 proves
the skill file arrives; only a run proves the skill reads as instructions a
session can follow, and that its two branches, no queue and a line that
already covers the idea, are reachable from its own text.

### Environments (`docs/05-Process.md` §5)

* **Kit source**: 0.23.0. The edit itself.
* **Dogfood copy** (`.claude/skills/`, `docs/manuals/`): 0.23.0, in sync.
  `focus-kit install .` was run here and check 6 is green.
* **Machine** (`~/.local/bin/focus-kit`): a symlink to the kit source, so it
  follows on its own. Global `/graphify` skill at the package's version,
  green in `doctor`.
* **Target repositories** (anyone else's): untouched, at whatever version
  they hold. They move only when their owner runs `focus-kit update <path>`.
  An old target's `.graphifyignore` never receives `.claude/skills/discuss/`,
  because the fragment is appended once; that is the page's Out of scope and
  a line under Later.

### Decisions

No ADR. A fourth skill is reversible by deleting a folder, and the queue line
is the decision (`docs/03-Domain.md`, ADR). `kit_skills` is not one either:
it is the abstraction rule applied on the sixth occurrence, not a new layer,
and `docs/01-Architecture.md` §3 keeps its four empty piece rows.
