# Changelog

What changed in the kit, newest first. The version is the `Version:` line
of `SETUP.md`, the same value a planted repository carries in the
`metadata.version` of its four `SKILL.md`. To move a repository to the
latest version, run `SETUP.md` again and apply any project-document
migrations its report identifies.

Em português: [CHANGELOG.pt.md](CHANGELOG.pt.md).

## 2026.10.25

- The `(PA)` token leaves the queue. `· after` is the only relation, and
  it is read per command: `/propose` of a line starts when every line
  its `after` names is `[>]` or beyond, because the definition needs
  their pages; `/apply` starts when they are integrated, because the
  build needs their code. Integrated is `[x]` on trunk and, with a
  branch or a worktree per delivery, the branch merged into main; a
  `[x]` on an unmerged branch is built, awaiting integration. On
  2026-10-25, in one project, twelve pages stood `[>]` with one
  buildable, all marked `(P-)`: the token asked the proposer to predict
  file overlap before the page existed, and `-` was the only safe
  answer, so it serialized everything. In the same audit, `queue.sh`
  offered a line whose `after` was `[x]` on an unmerged branch, and the
  worktree it opened had none of that delivery's code; one project had
  already written into its own docs/05 that `[x]` counts only after
  integration. The file check moves to where the files are known:
  before its first edit, `/apply` compares the files its page touches
  with the in-flight and unintegrated builds, and an overlap is §4's
  conflict. This displaces the token's `A`, its `P`, which `after` on
  both commands already covered, and the sentence that said `after`
  means `[x]` for both. A rerun reports docs/05 §4 and every token in
  docs/06 as migrations; a `-` becomes an `after` only where the page
  says so.
- The review line of a milestone is written `· after all`, every line
  above it in its milestone, and `queue.sh` reads it so. On 2026-10-25,
  in one project, the review line had no token and no `after` and was
  offered for `/propose` with four lines above it undefined; the kit's
  own fixture gave its review `(--)` and an explicit list, which the
  generator never wrote.
- `queue.sh` reads a branch on origin as a claim: a line whose branch
  exists is in flight, "claimed, progress unknown" while its copy still
  says `[ ]`, since the `[~]` edit need never be committed. The branch's
  copy of a line is the current one for its slug until the merge, main's
  after it, and a `[?]` on any copy blocks. A line only a branch has
  keeps its milestone and is offered there. A wrapped line is read
  whole. With no free line the script says so; with free lines it ends
  `next:` with the first in queue order. It reports a line that waits on
  itself, a cycle, a slug that is nowhere and a slug written twice as
  errors. Nine reproductions of 2026-10-25 against local repositories,
  by three audits: a claimed line offered to a second clone; a blocked
  copy on the branch losing to main's older `[>]`; a new `after` at the
  same mark ignored; the client project's five blocked lines printing an
  empty reason, because it wraps at 80 columns; Ninjobs' tokenless queue
  answered with ten lines to judge and nothing free; a fix written on a
  branch listed and not runnable; a self-dependency offered. The rank of
  marks, which chose the further mark, gives way to the copy rule.
- `claim.sh` creates the branch on origin only when no clone has it,
  with git's create-only push, and removes what it made when another
  clone won the race; a branch on origin with nothing of it here is
  another clone's, `claim: taken`, opened only with `resume` at the end
  of the command, on the person's word; run in the slug's own worktree
  or on its branch it answers `claim: here` instead of refusing; the
  worktree starts from origin's main branch, which the script just
  fetched, and says when local main is behind or ahead. On 2026-10-25
  the repro showed a second clone joining a taken line with `claim:
  existing`, the documented resume route refused by the script, and a
  worktree cut from a stale local main. The Windows probe's assertions
  still hold; it was not rerun for this version.
- A **Design** slot in docs/05 §5: where a screen's reference comes
  from and where it is kept, the person's tool, a design delivery before
  the screen's line whose deliverable is a static HTML or SVG mock the
  person approves, or prototype by choice. A page with a screen and no
  reference is not `[>]` unless the slot says prototype; `/apply`
  compares, corrects or justifies each divergence. `/brainstorm` and
  `/analyze` ask it inside the proof question. Ninjobs' docs/05 §4 had
  the rule from its first day, "a screen without an artboard is born in
  /design", and the delivery `chassi-desktop` shows it catching mobile
  layouts stretched onto desktop; the kit dropped it when it dropped
  the tool, which was Claude's own, and no host-neutral form replaced
  it. It displaces nothing: the rule had never entered the kit.
- The page keeps its definition apart from what `/apply` appends: the
  outcome goes under a heading `## Outcome` below Done when. On
  2026-10-25 a done page of 538 lines held a contradiction between its
  Behaviour and States that `/apply` had to decide, and a reader could
  not tell where the definition ended.
- docs/05 §4's two paragraphs on parallel work, two sessions in one
  tree and a command with several slugs, are written only when the Git
  slot is a branch or a worktree per delivery or the person says
  sessions will overlap. On 2026-10-25 two trunk projects, one with 18
  queue lines, carried a §4 whose length was mostly worktrees, claims,
  boards and subagents, read by every `/apply`. The template is 3,199
  words before a slot is filled; Ninjobs' process was 537 at first
  writing and 1,462 at the beta.
- Setup's step 4: a docs/05 that keeps its own section numbers by an ADR
  migrates by one line under its title mapping the kit's numbers to its
  own, `§4 is §6 here`, which `/propose` and `/apply` read first; until
  one of the two migrations is done, the next step is the migration,
  not a command. Step 4 said in one bullet that an ADR makes a
  divergence a project choice and in the next that numbering migrates
  "whatever an ADR says"; the project the kit was born in keeps its
  numbers by ADR-0026 §3 and could not be rerun without overriding it.
- `apply` gets `allowed-tools: Bash(git:*)`, which `propose` had: typed
  with no slug it runs `queue.sh` through git and Claude Code asked.
- The AGENTS.md template's em dash line points at docs/04 and its
  abstraction line at docs/01, which now own those rules; docs/06's
  definition of a line is the same in `documents.md` and docs/05 §4; the
  README's "one addition" sentence says what the kit added since the
  reset. Each was a rule written in one place only, or two places
  differently.
- The harness: `check` measures a sentence to its full stop, a
  semicolon no longer ending it, so a chain of semicolons is measured
  whole; on 2026-10-25 an 85-word sentence of docs/05 §8 passed as
  pieces of fifty, and the sentences the new rule found are split, one
  of them that §8 sentence. The queue fixture holds the nine
  reproductions with expected outputs, and `claim.sh` gets a
  deterministic test on two clones. The parallel fixture's two pages
  touch different files, and a new `overlap` stage runs a page that
  shares a file with a built, unmerged one and asserts `/apply` stops;
  the fixture had two pages sharing a file and required both built,
  rewarding the behaviour §4 forbids. `test/README.md` said sixty words
  where the script said fifty.
- The kit's `work/` is `notes/`: it holds the design notes of the
  scripts and is not a queue, as `CLAUDE.md` says; `research/`, where
  audits and their reproductions live, is ignored by git.
- Line alarms, read from `check`: `/propose` body 39 lines (ceiling
  40), `/apply` 56 (ceiling 60), `SETUP.md` §1 178 (ceiling 200),
  docs/05 template 297 non-blank (ceiling 320), `documents.md` 582
  (ceiling 600). None crossed; `/propose` is one line from its ceiling.

## 2026.10.24

- What may run now comes from a script, `propose/scripts/queue.sh`,
  run through git like `claim.sh`, with the strategy of docs/05 §5's
  Git slot. It draws docs/06's current milestone as a tree: each line
  under the last line it waits on, its other pending `after` beside it,
  and its state. The state is free for /propose or /apply now, in
  flight, blocked, or waiting and on what, the `-` of the `(PA)` token
  included. It ends with the lines free for /apply and for /propose
  together, and the lines without a token, judged first by the files
  they touch. With a branch or worktree per delivery, it reads every line
  from the default branch on origin and each delivery's line from its
  branch, keeping the further mark, so a worktree's older copy does not
  show a merged line as free, and lists the lines only a branch has. A
  line whose `after` names a dropped line waits for the person to
  re-decide it, as docs/05 §4 says. CRLF endings read the same.
- `/propose` and `/apply` typed with no slug show that tree and ask,
  `/apply` ends with it, and docs/05 §4 says to run it whenever a person
  asks what may run now. The session offers the free lines as one
  command with several slugs, saying each slug is one more agent and
  costs as much as one session. The sentence of §4 that said to answer
  from the queue by hand gives way to it; a rerun reports the new
  sentence as a migration to docs/05 §4.
- On 2026-10-24, in two projects, the person could not tell from the
  queue which lines were free for /propose and which for /apply, and had
  to read every `(PA)` and the end of every line for its `after`. Run on
  one of them, the script showed nine pages `[>]` held by one undefined
  line above them, all nine `(P-)`. Run on the other, it found the
  milestone review with no `after`, free before the lines it reviews.
- docs/06 does not change. A tree written into the queue was weighed and
  left out: in one project 21 lines name two or more lines in `after`
  and 28 name a line of another milestone, so a tree written by hand
  would hide part of what each line waits on. The order would stop
  being the priority, and two boards read the lines as they are. A block
  of free lines written into docs/06 was also left out, because it goes
  stale at every mark and conflicts between worktrees. A fifth command
  was left out too: the commands with no slug answer it.
- Setup writes sixteen files into the skills folders. The script is
  §3.7, and the sections after it are renumbered §3.8 to §3.13.

## 2026.10.20.5

- `SETUP.md` says, in its opening lines, that every path it names is in
  the repository the session works in, never in the folder the file was
  read from. On 2026-10-20 the GitHub Copilot CLI, opened in a test
  project and pointed at `SETUP.md` in another folder, planted the kit
  in that other folder, the kit's own repository, and reported success.
  The README offers that same setup, a `SETUP.md` downloaded next to the
  repository.
- Setup's step 3 says the templates of §3.5, `AGENTS.md` and docs/05,
  are what `/brainstorm` and `/analyze` write later, and are not written
  during setup. The rule was already in the paragraph after the steps;
  it moves into the step an agent reads while it writes. On 2026-10-20
  the GitHub Copilot CLI, planting the kit in the test harness, wrote an
  `AGENTS.md` from the template in one of two runs.
- docs/05 §4 says what `after` requires where it says the line obeys it
  for both commands: neither `/propose` nor `/apply` starts until every
  line it names is `[x]`, whatever the `(PA)` token says. On 2026-10-20
  the Copilot CLI, given `shout (-A) · after farewell` in the test
  harness, read the `-` and the `after` as one rule and defined `shout`
  once `farewell` reached `[>]`. Claude Code and Codex waited. The rule
  is unchanged; a rerun reports the sentence as a migration to docs/05
  §4, as it did on a real project's docs/05 on 2026-10-20.
- Two smaller misses of the same run. A page decided alone says the
  agent chose each answer, not only what was chosen: the Copilot CLI
  wrote a "Decisions" section that did not say who decided, which the
  person reviewing could take for their own. And setup's check confirms
  `claim.sh` ends with a newline: the CLI dropped the last one, so the
  file was no longer byte for byte, though `sh` ran it.
- Seven sentences over fifty words, the limit `CLAUDE.md` sets, are
  split, with no rule changed: `/brainstorm`'s process slots,
  `/propose`'s last paragraph, docs/05 §5's Manuals slot and §6's commit
  paragraph, and three of setup's step 1 and step 4. docs/05 §4 gives
  the four cases a line waits in as a list. A rerun reports no
  migration: wording only.

## 2026.10.20.4

- `/propose` claims the queue line with a script instead of a procedure.
  `propose/scripts/claim.sh`, a POSIX sh file inside the skill, runs
  through git's own shell on every host and shell:
  `git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk
  <slug> <strategy>`, the strategy being what docs/05 §5's Git slot
  says, `trunk`, `branch` or `worktree <hidden> <prefix>`. The script
  checks the remote for the branch, creates or reuses the worktree or
  the branch, pushes it, prints the path the `/apply` session opens in
  and whether a draft page waits in `main/`, refuses to run from a
  worktree or from any branch but the default one, and edits no
  document: the mark `[~]` stays the agent's first edit. The rule stays
  in docs/05 §2; the steps leave `documents.md` §Choices and `/propose`,
  which now say to run it, and `propose` gets `allowed-tools:
  Bash(git:*)` so Claude Code asks nothing. It runs wherever git runs:
  on Windows through the `sh.exe` Git for Windows installs, proven on
  2026-10-20 on a laptop with git and nothing else on the PATH, from
  PowerShell and cmd, under `core.autocrlf=true`; the README says to
  keep that shell and recommends WSL. On 2026-10-20, in one project, a
  delivery was `[*]` in its worktree and `[ ]` on main, its branch never
  pushed, and a `/propose` run in `main/` asked for confirmation at
  every file it wrote in the worktree: steps the prose said and the
  agent dropped, which a script cannot drop. A rerun reports no new
  migration; the skills change, docs/05 does not.
- The host table of `SETUP.md` §1 gives the GitHub Copilot CLI a row of
  its own: it reads `AGENTS.md` directly, merged with `CLAUDE.md` and
  `GEMINI.md`, takes the commands from `.agents/skills/` with no pointer
  file, invokes one as `/<name>` and honours `disable-model-invocation`,
  read off https://docs.github.com/en/copilot/reference/cli-command-reference
  on 2026-10-20. The row that was there describes Copilot in VS Code,
  with its prompt files, and now says so. On 2026-10-20 the kit's own
  test harness, written from that row, told the CLI to ask for the
  skill by name because the row's `/<name>` read as VS Code's; the CLI
  is how the kit reaches a terminal without VS Code, on the Free plan
  included.

## 2026.10.20.3

- `/propose` and `/apply` take several slugs. The session that received
  the command opens one subagent per slug, each following the command's
  file with one slug, in the slug's worktree when the project has one,
  opened at once, not one after another, where the `(PA)` tokens and
  `after` allow; a line still waiting when the others end is reported,
  not waited for; the session edits nothing itself. The skills keep
  `disable-model-invocation`: the command the person typed names every
  slug, and the subagent runs on that word, which both skills now say in
  their first lines, each subagent taking its slug from the message that
  opens it. A subagent cannot ask the person: it reports the question
  with its context and stops, and the session asks and sends the answer
  back. Two things the command may say: to decide alone, each question
  answered by its recommendation and written on the page as the agent's
  answer, so the review finds it; and to build as well, a new subagent
  running `/apply` when a page reaches `[>]`, the page saying it was
  built before the person read it, who reads the pages and the diffs at
  the end. `/apply` in a worktree runs in a session opened there or in a
  subagent sent to its path, every file and command at that path. On
  2026-10-20, in one project, a person asked a session to run three
  `/propose` through subagents at once; the subagents stopped three times
  at the flag, reading an authorization relayed by another agent as
  none, and the session proposed deleting the flag from the installed
  skills with `git update-index --skip-worktree`. The flag stays because
  its two errors stay: Codex building on a message that contained the
  word "apply", and `/propose` offered in the session that asked for the
  change. docs/05 §2 says a subagent is a fresh session and §4 holds the
  rule; a rerun reports both as migrations.

## 2026.10.20.2

- With a worktree per delivery, each session opens where it works:
  `/propose` ends by giving the delivery's worktree path for the fresh
  `/apply` session, and `/apply` opened anywhere else stops before any
  edit and gives that path. The Choices of `documents.md` say `/apply`
  never runs in `main/`, and that the container's manual lets a session
  in `main/`, where `/propose` runs, edit the worktrees; in Claude Code
  that is `"permissions": {"additionalDirectories":
  ["../<hidden>/worktrees"]}` in `.claude/settings.json`, which grants
  file access without loading a second copy of the skills
  (https://code.claude.com/docs/en/permissions). On 2026-10-20, in one
  project, a person could not tell whether to open the session in the
  container or in `main/`, and a `/propose` run in `main/` asked for
  confirmation at every file it wrote in the worktree, the permission it
  was given covering one folder at a time; an `/apply` opened in `main/`
  would read the main branch's queue, where the line is not yet `[>]`,
  and the instructions as they were before the delivery's branch. To
  make room, `/apply` drops its rules on abstraction and the em dash,
  which `AGENTS.md` holds and `/apply` reads. A rerun reports a worktree
  project with no manual letting a session in `main/` edit the worktrees.

## 2026.10.20.1

- A queue line may carry `(PA)` after the slug: whether its /propose and
  its /apply may run while the lines above it are in flight. `P` says the
  definition takes nothing from their pages, `A` that the build touches
  none of their files, and `-` in either place waits, for every line
  above to be `[>]` before /propose and `[x]` before /apply; `after`
  holds for both commands, token or not. Whoever changes the queue
  re-judges the tokens the change affects, /propose corrects one from
  the page, and a line without a token is judged from the pages as
  before. `/brainstorm` writes the tokens of a milestone that will run
  in parallel; `/propose` and `/apply` wait as the token says. On
  2026-10-19, in one project whose milestone ran as several sessions at
  once, /propose sessions started on lines whose definition took from
  pages not yet written, and /apply sessions built lines that changed
  the same files, whose merges conflicted: the queue had `after` for the
  build and nothing for the definition or the files, and the person who
  knew both had nowhere to write it. To make room, docs/05 drops what it
  said twice: that a five-page scope is undecided, §6's lead-in to the
  message format, §4's last paragraph, folded into its first and §8, and
  the Delivery review slot's reason for listing created files. A rerun
  reports a docs/05 §4 without the token.

## 2026.10.20

- With a branch or a worktree per delivery, the delivery's branch is the
  claim of its queue line: `/propose` checks the remote for it and pushes
  it the moment it creates it, before the page exists, and after
  `git fetch` a line whose branch exists is taken, whatever the main
  branch's docs/06 shows. docs/05 §§2 and 4 and the Git slot of §5 say
  so, documents.md §Choices names the check, the AGENTS.md template
  reads the delivery branches when asked where things stand, and
  `/propose` pushes as the slot says. The main branch's docs/06 changes
  only through merges, so no claim lands there and no conflict comes
  from claiming; §4's sentence that marks cost nothing without a board
  went to make room. On 2026-10-20 in one project a delivery was `[*]`
  in its worktree and `[ ]` on main, its branch never pushed: §4 said to
  read the line from its branch, local or remote, but nothing had made
  the branch reach the remote, and a second person reading main's queue
  would have started it again. A near miss, not a caught error; it
  enters because the rule as written could not be followed. A rerun
  reports a branch or worktree Git slot silent on the push.

## 2026.10.19.2

- Running the product from a fresh clone is a manual always owed:
  docs/05 §5's Manuals slot names it, owed by the first delivery after
  which a person can run it, from install to the first screen or call,
  and updated by every delivery that changes a step; `/brainstorm` fills
  the slot that way instead of "none yet", `/analyze` writes that manual
  first, and the AGENTS.md template points to it. In one project on
  2026-10-19 the milestone closed and the person could not run the
  product: install, PATH, hooks, a tmux session and the serve command had
  been assembled by four deliveries, none owing a manual, since the host's
  page had defined its action as one command plus a URL, and the next
  steps `/apply` writes exist only in the conversation, which an agent
  orchestrating the session had run on the person's behalf. A rerun
  reports a Manuals slot that does not name the manual of running it.

## 2026.10.19.1

- docs/05 §4 says how the queue is read with a branch or a worktree per
  delivery: the main branch shows each line as it was until the merge,
  so a board, or a session picking free lines or resolving an `after`,
  takes each slug's line from its worktree's file or its branch, local or
  remote, and the lines only a branch has, reconciled by slug as at
  integration. In one project on 2026-10-19, with twelve worktrees, the
  main branch showed seven of thirteen lines as `[ ]` while their
  branches held them at `[>]` or `[*]`; `[~]`, `[>]`, `[*]` and `[?]` never
  reached it, and a new `/propose`, starting from its HEAD, could not see
  them either. A rerun reports the migration under docs/05 §4, where a
  board sees a mark.

## 2026.10.19

- `/propose` creates the branch or worktree first and marks `[~]` there,
  as docs/05 §2 says; the skill said mark first, then branch. docs/05 §4
  says where a board sees a mark: at once on trunk, at the merge with a
  branch or a worktree per delivery. A review of the whole kit on
  2026-10-19 found the two orders, and that the mark's reason, a board
  people pull work from, holds only on trunk.
- The commands follow every slot of docs/05 §5, the project's own
  included, and a project may add a slot that names `/propose` or
  `/apply`. In one project the skills listed the slots they follow, so a
  Board slot the project added was not read, and the person edited the
  four propose and apply files to refresh its board at every mark
  change, redoing the edit on every kit update. A rerun shows such an
  edit as a diff against the kit file it was made on, with the kit's own
  change apart, so the person can tell which is which; a prior version is
  verified from the kit's history or, without it, by the person's word.
  The Git slot may also say that the agent commits and merges by the
  slot's word, which counts as the asking: in that project the slot said
  the agent commits and the skill said never unless the person asks, and
  nothing said which held.
- The Milestone review slot says who reads the code: the host's deep
  review the person launches over the range, when the host has one that
  takes it whole, or the kit's readers by area; the checker runs either
  way. Ninjobs' slot names `/code-review ultra`, which found a 620 ms
  call, a page that could be framed, a visitor's address sent to a third
  party and a function reaching the internal network, and the previous
  kit told a rerun to replace it with readers and areas and ask whether
  the command "still runs too". Where no earlier review exists, the
  page names the base and why: a project whose first milestones closed
  without a review line had no commit the old wording pointed to.
- `/apply` reads docs/00 and docs/03 and builds with docs/03's
  identifiers. It read neither, while docs/03 says every identifier uses
  its table and docs/00 says nothing contradicts it without changing it
  in the same delivery; the page carried both alone. Found by the same
  review.
- `/brainstorm` and `/analyze` ask whether a second pair of eyes reads
  each delivery and each milestone, with the default stated, instead of
  asking which review tool and which model; `/brainstorm`'s own rule
  forbids asking about a tool by name. Found by the same review.
- docs/05 §6 says one working tree has one index: with two sessions on
  trunk, when the second has staged before the first is committed, the
  person sets its paths aside with `git restore --staged`, commits the
  first and stages them again. The old wording promised an index that
  holds one delivery and said nothing about how, when both sessions
  share it.
- The queue's rules are written once, in docs/05 §4; `documents.md`'s
  docs/06 paragraph points there instead of repeating them. They were two
  copies to keep in sync, which the kit forbids for the commands.
- `SETUP.md` §1's step 4 is a list by document and section, each item
  reported and never done. Its one 45-line sentence was turned into a
  checklist by each of the three agents that ran it on 2026-10-19, on
  three projects, with items they could not place. Step 4 also checks
  docs/05's section numbers, since the commands cite the template's and
  a project that kept its own sent `/propose` to the wrong section; step
  5 names the next command on a documented project from the queue's
  first free line, which it left unsaid; and a rerun replaces only what
  step 1 recognizes, where "those files" read as unconditional. The
  repository's `CLAUDE.md` now gives §1, the docs/05 template and
  `documents.md` a ceiling, as the commands have, so what a command no
  longer holds does not grow without limit elsewhere.
- `AGENTS.md` answers what a delivery decided from its page and ADRs.
  The READMEs say what the kit assumes, one person who proposes, uses,
  reviews the staged diff and commits, where a person who does not read
  code takes part, and that Ninjobs' 91 deliveries ran on its own two
  commands before the kit was planted there on 2026-09-21, two pages
  ago. The kit's audience includes teams and people who do not read
  code, and nothing said what it assumed of them or that the kit itself
  arrived at Ninjobs after the deliveries it cites.
- Copilot's documented order for a skill present in both
  `.agents/skills/` and `.claude/skills/` replaces "not tested" in §1,
  read from its CLI reference on 2026-10-19, which §1 now cites.
- A rerun reports these as migrations to docs/05 §§2, 4, 5, 6 and 8 and
  AGENTS.md's line on where things stand.

## 2026.10.18.1

- Verify stays fast enough to run on every delivery. docs/05 §5's Verify
  slot also names the slow tests kept out of it, and the milestone review
  runs them; a failing one is a finding. `/apply` puts a test too slow for
  verify with the slow ones and says so, never into verify silently, and
  docs/04 says what is tested at each level. The author has seen a
  twenty-minute suite run on every delivery, written by agents that do
  not mind how long a test takes.
- A line that no clause of the current milestone's paragraph needs goes
  under the next milestone, created when missing, whoever adds it; a
  finding of the milestone's own review stays in it. Agents add lines as
  they work, and the author has seen a milestone planned with five end
  with fifty. No new mark: the next milestone already holds them.
- `/propose` may run in the session where the change was asked, on the
  person's word, or in a fresh one; `/apply` always starts in a fresh
  session. In the book's repository Claude Code offered to run `/propose`
  from the conversation that asked for the change, and the rule sent the
  person to a fresh session holding only the draft. The skills still
  disable model invocation: the agent runs one only when the person names
  it.
- `/apply`'s next steps start with using what the delivery changed, as
  its user would, and asking in that session for what is wrong, before
  reviewing the staged diff. On Ninjobs small faults showed only when the
  author used a delivery before committing it.
- The agent never commits or merges on its own; asked, it takes the step
  the person names. In the book's repository the person asked for a
  commit per delivery of a batch, which the rule, read as absolute,
  forbade.
- FOCUS is chapter 4 of the book, at `04-focus`; the old link answered
  404. Its second principle is named "exceptions as values", the book's
  term, and Ninjobs is named under FOCUS whole, which it took, not under
  the two principles.
- The Claude Code row says it reads `AGENTS.md` alone only where no
  `CLAUDE.md` exists, from v2.1.277, as its documentation says on
  2026-10-18; the kit still writes `CLAUDE.md` with `@AGENTS.md`, which
  every version reads.
- On trunk with two sessions, the person commits each delivery from an
  index that holds only it, never by naming paths on `git commit`. A
  comparison of the kit with git's documentation on 2026-10-18
  reproduced the fault the old wording invited: a commit naming
  docs/06 took the file whole from the working tree, the other session's
  unstaged hunk included.
- The Delivery review's read-only agent reads the whole delivery against
  its base: `git diff HEAD`, staged and unstaged, the commits a blocked
  delivery already made on its branch, and the files it created. The same
  comparison reproduced a bare `git diff` showing nothing of an edit that
  was already staged, so a review could pass what it never read.
- `/apply` updates documents and manuals before the review, and nothing
  verify covers changes after its last green run. In the book's
  repository a link added to a document after verify could reach the
  commit without the build that made the delivery green.
- A conflict between two sessions is a line both edited, not a hunk: two
  neighbouring queue lines share a hunk and conflict in nothing. The old
  wording stopped the normal case of parallel work, and the book's
  chapter 19 already said otherwise.
- A `[~]` or `[*]` line whose session ended without blocking it is
  resumed by its command on the person's word; a delivery the person
  cancels ends `[x]` with `· dropped: <reason>`. The six marks had no
  place for a host that closed mid-delivery, nor for the impossible
  request the book's chapter 23 closes without building.
- One step reverts what git holds; a delivery that runs a migration or
  sends a message says in its Done when how that is undone, or that it
  is not. The promise read as if a revert undid a database.
- The milestone review's page names the commit its reading started at,
  so the range stays fixed while readers work in parallel.
- A rerun reports these as migrations to docs/05 §§2, 4, 5, 6 and 8,
  docs/04 and AGENTS.md's commit line.

## 2026.10.18

- A milestone review's base is the commit of the previous milestone's
  review, or the first commit for a first milestone. The range then holds
  the fixes of the previous review's findings, which get no second
  review. In the book's repository the next milestone's first line
  started before the previous milestone's findings closed, and its base
  was neither of the two commits docs/05 §8 named.
- The checker's three labels are each glossed: seen is true in the file
  today. docs/05 §8 glossed latent and weak only.
- A line waits in four cases: the fourth is a milestone review's code
  reading that missed part of its range, and its reason says what was
  read. docs/05 §4 counted three cases while §8 added this one.
- A Delivery review slot that reads `git diff` also reads the files the
  delivery created, which no diff shows before they are staged. A new
  script in the book's repository was untracked when its delivery's
  review ran.
- `/apply` fixes what breaks the page, docs/04 or the text the delivery
  wrote: "its own lines" read as queue lines. `/analyze`'s question on the
  milestone review points to docs/05 §5, where the slot is, not §8.
- A rerun reports these as migrations to docs/05 §§4, 5 and 8.

## 2026.10.17

- `/apply` has each delivery's own changes reviewed before it ends, by a
  context that did not write them, as docs/05 §5's new Delivery review
  slot says: the host's own review, as a skill the agent invokes or a
  command it runs, limited to the delivery's paths, or else a read-only
  agent reading their diff. It fixes what breaks the page, docs/04 or its
  own lines and runs verify again; anything else becomes a `[ ]` line. In
  the book's repository the milestone review added 21 lines of rework,
  ten of them a fault inside one build file, such as a file name every
  check skipped and a hook that missed part of a commit message, each
  waiting for the milestone's end instead of being fixed in the
  delivery that wrote it. No host documents a review of the staged
  changes alone, so the slot says how the host's review is kept to the
  delivery's paths while another session works in the same tree.
- A milestone's code reading is the kit's own, in any host that runs
  agents, not a host's command, and looks for what no delivery's own
  review could see: one delivery against another, a document against
  another. docs/05 §8 reads `git diff <base>..HEAD`
  from the commit that closed the previous milestone, split into the
  areas the Milestone review slot names, one read-only agent each, in
  parallel where the host runs agents and one fresh session per area
  where it does not. Each reader lists the paths it read; when they miss
  part of the range, the review line waits as `[?]`. One checker marks
  each candidate seen, latent or weak against its file before the person
  sees it. In the book's repository the slot's `/code-review ultra` was
  cancelled for cost and speed, a review launched with a bare commit read
  that one commit and not the milestone, the agents that replaced them
  read part of the chapters and no one saw it until the next review, and
  a candidate that did not hold was caught only because each one was
  checked against its file. The cloud review also refuses a change
  larger than its file and line limits, and runs in one host only.
- The Milestone review slot names the areas and the model its readers
  and checker run on, or the session's; `/analyze` and `/brainstorm`
  propose docs/01's modules, and ask for the Delivery review. A rerun
  proposes the areas for a slot that
  names a command, and the person says whether that command still runs.
- The review starts on the person's word, since it costs; the session
  says when it is time. docs/05 §7's "no specialized subagent" makes its
  one exception for these readers and their checker, which in the book's
  repository found a file name that every check, the disclosure scan
  included, silently skipped.
- Windsurf is now Devin Desktop, whose only agent, Devin Local, replaced
  Cascade in September 2026. It reads `AGENTS.md` and the skills in
  `.agents/skills/`, and invokes them as `/<name>`; `@<name>` was
  Cascade's. `SETUP.md` no longer writes `.windsurf/skills/`, which no
  host needs, and a rerun removes the kit's own copies there, so Devin
  Desktop, which still reads that folder, finds no older copy of a
  command beside the current one. Every other file there is reported
  and left. The table of `SETUP.md` §1 cites Codex's documentation at
  its new address, with nothing else changed.

## 2026.10.16.2

- The kit names no tool that plants it. A rerun's migration for a
  worktree Git slot that names no folder, in a container whose hidden
  folder already holds `repo.git/`, writes in that folder's name and the
  prefix its delivery branches already use, so nothing moves; without a
  container, the slot keeps meaning `.focus-kit/` and `focus-kit/`.
  2026.10.16.1 told the agent to write into a project's docs/05 the
  folder name of a tool the person did not use, and a person who found
  that folder could not tell where it came from. The entries of
  2026.10.15 and 2026.10.16.1 below no longer name it.
- 2026.10.16.1 was released twice, with different `SETUP.md` text, so a
  repository that says 2026.10.16.1 does not say which one it has. Run
  `SETUP.md` again; a version number is not reused.

## 2026.10.16.1

- A milestone's review reads the code again: its page names the commit
  that closed the previous milestone, and the person launches the deep
  review docs/05 §5's new Milestone review slot names, such as Claude
  Code's `/code-review ultra <base>`. Each confirmed finding is a line
  under the review, with no second review. In Ninjobs a code review of
  the whole code found a 620 ms call, a page that could be framed, a visitor's address sent to
  a third party and a function reaching the internal network; testing
  clauses by hand finds none of these.
- The last thing `/apply` says is which environment is at which version
  and the command that updates the others, and docs/05's Publish policy
  says so. In Ninjobs a person twice opened a published site believing
  it current after a session that ended without saying it was not.
- `/apply` reads the whole queue again. With 2026.10.16 it read only its
  own lines, so it could not see whether the lines its `after` names are
  done, nor name the next line. Queue lines stay one sentence, which is
  what keeps the read small.
- A change asked outside `/apply` becomes a `[ ]` line, with a draft
  `work/<slug>.md` for what the line cannot hold, and the answer ends
  naming `/propose <slug>` for a fresh session. This replaces 2026.10.16's
  "continue as `/propose` in the same session": that session ran without
  the propose skill, which no host lets the agent invoke on its own, and a
  request not defined now had nowhere to keep its detail. `AGENTS.md`'s
  rule, which still said the answer stops at the line, now says the same.
- The Contract section of the page says again why it must be exact: a
  wrong screen is fixed in a session, a wrong column is a migration, and
  a wrong access rule has already leaked. Ninjobs' process said it, and
  the kit kept the rule without the reason that makes an agent take it
  seriously.
- Smaller: `/analyze` creates `work/done/.gitkeep` as `/brainstorm` does;
  `/brainstorm` asks for the manuals and the milestone review with the
  other slots, and `/analyze` asks for the milestone review; "no gate before implementation" reads "beyond a complete
  page", which the kit does require; the trunk strategy no longer says
  Ninjobs staged per session, which it never did. Found by a review of
  the whole kit on 2026-10-16.
- A mark changes at once: `[~]` is the first thing `/propose` writes,
  `[*]` the first thing `/apply` writes and `[x]` the last, after staging.
  In one project the queue fed a board in Azure DevOps or GitHub Projects
  that people pulled work from, and choosing what to pull needs the board
  to show at once what is taken. Without a board the marks cost nothing.
- docs/05 §4's resumption and §6's commit rules are shorter: `resume:`
  is one sentence, the recovery of old blocked lines and the move of a
  blocked trunk delivery to its own branch are gone, worktree
  reconciliation is one sentence and ownership is "what this delivery did
  not change is not its own". The two-sessions rule and "never `git add
  -A`" stay whole. 2026.10.16 cut a 180KB read before the first edit; the
  process document is part of that read.
- A worktree per delivery, when chosen, defaults to the hidden folder
  `.focus-kit/` and the branch prefix `focus-kit/`, which say what made
  them; the earlier default said nothing to a person who found it.
- Migration: the report of a rerun checks docs/05 §§2, 3, 4, 6, 7 and 8,
  the Milestone review slot, the Publish policy's last sentence and
  `AGENTS.md`'s line on a change asked outside `/apply`. A worktree Git
  slot that names no folder, where the container already uses the
  earlier default, gets that default written in, so nothing moves.

## 2026.10.16

- `/apply` reads in docs/06 only the lines that name its slug and their
  milestone heading, not the whole queue. A queue line is the mark, the
  slug, one sentence and its suffixes; what happened goes on the page.
  A docs/05 §5 slot says what and the command in a few lines; steps go in
  a manual and what a command prints stays in its help. In one project
  every `/apply` read about 180KB of documents before its first edit: an
  80KB queue whose lines reached 4.7KB, and a process document whose
  Environments slot ran about 120 lines.
- A change asked outside `/propose` still becomes a `[ ]` line, but when
  the person wants it defined now, the conversation continues as
  `/propose <slug>` in the same session and what was said becomes the
  page. That project's request lines grew to 4.7KB because the detail of
  a request had nowhere to go but the line.
- A manual in docs/manuals/ also holds a proof `/apply` runs on another
  machine, not only what a person does by hand: that project's proof
  steps had nowhere to go but the slot.
- Migration: the report of a rerun lists queue lines that carry history
  and slots that narrate steps or output, with the shorter wording.

## 2026.10.15

- A worktree per delivery now has one shape, the same for every tool and
  every person: the checkout is the `main/` of a container folder, the
  bare repository lives in a hidden folder of it, and each delivery's
  worktree lives in `<hidden>/worktrees/<slug>/` on the branch
  `<prefix>/<slug>`. docs/05's Git slot may name the hidden folder and the
  prefix; a slot that names neither means a default of the kit. `/propose`
  creates the worktree there, or reuses the one that exists, and a branch
  `<slug>` without the prefix is not the delivery's. A `/propose` running
  in the background entered a worktree its host had created on its own,
  in the host's folder, and the person copied the page to the main branch
  by hand: nothing said where a delivery's worktree belongs.
- No migration: a docs/05 whose Git slot names no hidden folder and no
  prefix already means the default.

## 2026.10.13

- What a person does by hand outside a delivery (publish the site, roll
  back, rotate a secret, set up a service) gets a manual in
  `docs/manuals/`, one file each, named after what it does and readable
  alone: what it does and when, what must be in place, the commands in
  order, how to tell it worked, how to undo it. docs/05 §5 gains the
  Manuals slot that says so and lists them, and a slot that names such a
  command points to its manual instead of holding the steps. `/analyze`
  writes the manuals for what the repository already runs by hand;
  `/apply` writes or updates one when a delivery adds or changes it;
  `AGENTS.md` points to the folder. A user went to republish a project's
  site and found no instructions: the steps existed, but as a sub-item of
  the Environments slot of docs/05 §5, written for the agent, where a
  person looking for how to publish does not look.
- Migration: the Manuals slot in docs/05 §5; each procedure written only
  inside a slot or another document becomes a manual in `docs/manuals/`,
  the slot keeping the command and pointing to it; the `docs/manuals/`
  line in AGENTS.md's Read before acting.

## 2026.10.08.3

- Two sessions in one working tree, on free lines that touch different
  files, are now the normal case of parallel work on trunk, in docs/05
  §§4 and 6 and in the git choice. Another line changing mark, another
  delivery's files in the tree and another session's index entries are
  that session's work, not a conflict; a conflict is the same hunk edited
  by both, or a file the page needs that the other delivery is changing.
  A user ran two Codex sessions on one repository, on different modules;
  the second stopped because the first had changed docs/06, when it had
  everything it needed to go on.
- Queue lines record their order and dependencies: the order is the
  priority, the next delivery is the first free line, and a line that
  needs another done first ends with `· after <slug>`, an order rather
  than a block, free once that line is `[x]`. Asked what can run at the
  same time, a session answers from the queue: the free lines that touch
  different files, judged from their pages and docs/01. The rule that
  order is priority always held and was written nowhere, so a user asked
  for a way to rank deliveries; and nothing said which lines could run
  together, so the person had to work it out alone before opening two
  sessions. The same rule, one line in a template filled by the agent,
  is all GitHub's Spec Kit has for its `[P]` marker.
- `/propose` decides what the documents already answer, writes it on the
  page naming the source, and asks only what they cannot answer, the
  rule `/analyze` already had for code. A user measured the kit against
  working by hand on a copy of the same project and found it much slower,
  in part because `/propose` asked what docs/00 to 05 already settled.
- Migration: docs/05 §4 and §6 and the git slot of §5, on a project that
  runs several sessions; `· after <slug>` on queue lines that depend on
  another, as the person sees fit.

## 2026.10.08.2

- `/apply` shows the suggested commit message in the conversation too, in
  the same `commit` block that ends the page, both when the delivery is
  done and when it stops blocked with a partial message. Since 2026.10.06
  the message lives on the page, and the agent began suggesting it in the
  conversation as plain text; in a terminal it lost the highlight a fenced
  block gave and blended into the rest of the reply.

## 2026.10.08.1

- Every command writes the next one as the host invokes it. Before, a
  Codex user was told to run `/propose`, which Codex does not recognize;
  Codex invokes skills with `$`.
- `/apply` ends with the person's next steps, commands written out:
  review the staged diff, commit (and merge, on a delivery branch), then
  the queue's next line. Before, a person who had just used the kit for
  the first time knew to commit but had to search the documentation for
  what came after. `/propose` also shows the page's queue line.
- `AGENTS.md` answers "where are we?" from docs/06 and `work/`, with the
  next command. There is no status command: the queue already is the
  status. `AGENTS.md` belongs to the project, so rerunning `SETUP.md`
  reports this line as a migration.

## 2026.10.08

- Behaviour scenarios on the page name a concrete input and the result
  the user sees, and include the cases that must fail and the edges the
  documents imply. `/propose` drafts them from the documents; the person
  corrects them instead of writing them. Before, a person who did not know
  the tool being built left the expected result to the agent, which
  delivered one solution, happy path only, and the client rejected it.
- docs/05 §3 belongs to the project, so rerunning `SETUP.md` reports the
  new Behaviour wording as a migration instead of writing it.

## 2026.10.07

- Blocked lines remember whether to resume `/propose` or `/apply`;
  saved drafts must be fully defined before implementation. Parallel
  branches reconcile the queue without losing findings or dependencies.
- `/apply` stages only its delivery and preserves unrelated changes.
  Blocked work keeps a partial message on the page; on trunk, it stays
  uncommitted. docs/05 §6 owns the commit format.
- Setup preserves custom commands, avoids duplicate Gemini pointers and
  fixes Antigravity activation, Claude Code invocation and Copilot inputs.
  `/propose` and `/apply` now point to their shared process rules.
- Existing projects get a migration report for docs/04, docs/05 and
  `AGENTS.md`, with paths and proposed wording; setup preserves those files.

## 2026.10.06.1

- Code changes only inside `/apply`. A change asked anywhere else, however
  small, becomes a `[ ]` line in docs/06 and the answer stops there. Before,
  the rule lived only inside `/apply`, for a fix found in the middle of it:
  asked for a correction in an ordinary session, an agent edited the code
  directly, with no line in the queue, no page and no verify.
- The rule is in docs/05 §2 and in the Non-negotiables of `AGENTS.md`, as
  `/brainstorm` and `/analyze` write them. Both files belong to the
  project, so rerunning `SETUP.md` does not touch them: in a repository
  already planted, add the sentence to each by hand.

## 2026.10.06

- `/apply` ends the page with the commit message it suggests, in a fenced
  block whose info string is `commit`, on the done path and on the blocked
  one. Before, the message lived only in the chat: an agent answered with
  `git commit -m` lines, and whoever committed later, in another window or
  another session, had nowhere to start from.
- docs/05 §3 says the done page ends in that block.

## 2026.10.05

- The queue shows work while it happens. Two marks join `[ ]`, `[>]` and
  `[x]`: `[~]` while `/propose` talks, `[*]` while `/apply` builds.
- `[?]` marks a line that waits: on the person, on an answer not yet
  given, or on other lines. The reason goes at the end of the line, as
  `· blocked: <reason>` or `· blocked: after <slug>, <slug>`.
- `/apply` stops when the work cannot go on, writes into the page what
  was built and what it waits on, and marks the line `[?]`. When it marks
  `[x]` the last line an `after` names, the waiting line goes back to
  `[>]`, or `[ ]` when it has no page.
- docs/05 §4 gains the table of marks: what each one means and who sets it.

## 2026.10.04.1

- `context/` holds what people said: proposals, emails, transcripts. Each
  item is the original, whole, beside a `<name>.md` that says what it is;
  never a summary.
- `/brainstorm` and `/analyze` read `context/` whole when it exists.
- docs/05 §5 gains the Context slot: `context/` is committed or listed in
  `.gitignore`.

## 2026.10.04

- The kit says its version: the `Version:` line of `SETUP.md` and
  `metadata.version` in the four `SKILL.md`.

## Before versions, 2026-09-19 to 2026-09-30

The kit as it is today, before it carried a version. A repository planted
in this period has no `metadata.version` in its skills; running `SETUP.md`
again brings it to the latest version.

- The kit is one file again: `SETUP.md` holds what the agent does, the
  host table, the four commands and their reference. `/brainstorm` and
  `/analyze` start a project; `/propose` and `/apply` deliver. The queue
  is edited by conversation.
- Every host gets its files on every run: skills go to `.claude/skills/`,
  `.agents/skills/` and `.windsurf/skills/`, with pointer files for
  Copilot, Cursor, Gemini CLI and Antigravity.
- The page and its build are one change: one commit on trunk, one merge
  with a branch or a worktree. `/propose` creates the branch or worktree
  before writing the page and ends by asking the person to read it.
- Every milestone ends with its review, run like any delivery. It takes
  the milestone's paragraph clause by clause and says how to test each
  one; the person tests. A finding is a line in the same milestone, and
  the lines a review adds are not reviewed again.

Earlier versions of the kit, with an installer and a CLI, were replaced
on 2026-09-19; `README.md` §Why this shape says why.
