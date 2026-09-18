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

* `bin/focus-kit selftest` is green, six checks.
* A real run of `/initialize` in a scratch repository asks the Git strategy
  question and writes the answer as the first line of §7, and the transcript
  goes into `work/done/git-strategy-is-asked.md` (`docs/05-Process.md` §6).
* A real run under the **worktree** strategy in a scratch repository: a
  command that writes under a slug makes the worktree and writes there, and
  an `/apply` started outside it stops with the command that gets there. The
  kit could not do this strategy at all before, so a run is what proves it
  can.
* `docs/05-Process.md` §7 here opens with `**Strategy.**` and answers none,
  and `docs/04-Conventions.md` §6 agrees with it.
* `docs/06-Queue.md` holds `git-branches-are-queue` struck through with its
  reason.
* `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy carries the change (`docs/05-Process.md` §5).
* `docs/00`, `docs/03`, `docs/04` §6, `docs/05` §7 and `manuals/process.md`
  updated in this delivery.
