# queue-line-finds-its-place

**Goal.** A person adding a queue line ends with it in the milestone whose
paragraph it serves, or in Later, by a rule that is written down, instead of
a placement decided again in every conversation.

**Behaviour.**

* Every milestone carries a name and a paragraph saying what closes it. That
  paragraph is what a line is placed against: a line whose scope the
  paragraph already admits belongs in that milestone, and a line no paragraph
  admits does not.
* `/discuss` ends with a placement step, in this order. It places the line in
  the milestone whose paragraph the line serves, and that placement is no
  longer a question: the paragraph decided it. When the line serves a
  milestone and the paragraph does not say so, it asks, the amendment and the
  placement together against leaving the line in Later, and writes the answer.
  When no paragraph admits the line, the line goes into Later.
* When three lines in Later share a purpose, `/discuss` says which three and
  proposes a milestone: a name and a paragraph saying what closes it. On yes
  it writes the heading and the paragraph where the person says it belongs
  and moves the three lines into it. That move and the promotion below are
  the only two `/discuss` makes, and the conversation is what decided each
  (`docs/03-Domain.md`, Queue).
* "Later, not scheduled" holds `[ ]` lines in the queue's own shape, a slug
  plus its scope, and no prose bullet. A Later line is a delivery that is
  wanted and not ordered; the order starts at the first milestone.
* A Later line that another delivery already did is struck through with the
  reason naming that slug, never deleted (`docs/03-Domain.md`, Queue).
* A Later line is promoted by `/discuss` and by nothing else. When the idea
  it is given is already covered by a line in Later and a milestone paragraph
  now admits it, `/discuss` offers the move of that one line instead of
  writing nothing, and the conversation is what decides it, as with the
  proposed milestone.
* `/propose <slug>` stops while reading for a slug the queue does not hold
  and for a slug that stands in Later: it says the line is not ordered yet,
  names `/discuss`, and writes no page and marks nothing. A mark never
  appears under Later.
* Everything else about the queue is unchanged. A line never leaves,
  `/propose` marks `[>]`, `/apply` marks `[x]`, and no command reorders the
  lines of a milestone.

**Contract.**

* `/apply` runs only after `work/done/discuss-adds-queue-line.md` exists,
  because `skills/discuss/SKILL.md` is what this delivery edits and that
  delivery is what creates it. The page names `/discuss` by behaviour and
  quotes no sentence of it: what that run produced wins over what its page
  expected (`docs/05-Process.md` §6).
* `skills/discuss/SKILL.md` gains the placement step as its last act before
  it writes, in the cases above. The paragraph that asks where the line
  goes and offers a placement with a recommendation first is replaced by that
  step: a paragraph that admits the line decides it, and what stays a
  question is the amendment, the proposed milestone and the promotion. Its
  branch for an idea a queue line or a Later line already covers gains the
  promotion case. The sentence that says no existing line moves keeps its
  rule and names the two exceptions, a promoted line and the lines of a
  milestone the person accepted, each one a move the conversation decided.
* `skills/propose/SKILL.md`: the clause of Write that adds a missing line
  where it belongs leaves, and Read first gains the stop, for an absent slug
  and for one standing in Later, so a `/propose` that stops costs no page.
  Its Close stops offering a line it added.
* `manuals/process.md` §The queue carries the rule: the milestone paragraph,
  what it admits, Later as `[ ]` lines, and what a placement ends in, the
  milestone whose paragraph admits the line, the milestone whose paragraph is
  amended to admit it, or Later. Cited by heading and never by number,
  because `discuss-adds-queue-line` renumbers that manual.
* `skills/initialize/templates/docs/06-Queue.md`: its opening paragraph says
  what a `[ ]` line under Later is; the milestone init comment says the
  paragraph is what later lines are placed against; the Later section becomes
  a fenced block of `[ ]` lines with an init comment of its own.
* `skills/initialize/templates/docs/05-Process.md` §8 and `docs/05-Process.md`
  §8: "one line per delivery, in order" admits a Later line outside the
  order.
* `docs/06-Queue.md` here: the opening paragraph gains the same sentence, and
  every bullet under Later becomes a `[ ]` line, each keeping its own reason
  as scope. The bullets standing at this commit, in their order, take these
  slugs, and a bullet that arrived after it takes one of the same shape:
  `skill-says-it-is-kit-owned`, `uninstall-removes-the-kit`,
  `help-names-what-install-writes`, `distribution-beyond-clone`,
  `an-old-target-gets-the-fragment`, `update-survives-a-moved-section`,
  `manuals-follow-the-language`, `git-policy-for-a-second-person`. The first
  bullet, keeping the dogfood copies out of the graph, is
  `dogfood-copies-out-of-the-graph` and is the struck-through case:
  `.graphifyignore` and `config/graphifyignore.fragment` hold the kit-owned
  paths of this repository, so the run reads both and strikes the line naming
  `graph-ignores-the-kit` when they still do.
* `docs/03-Domain.md` gains **Milestone paragraph**, the paragraph under a
  milestone heading, what closes the milestone and what it admits, the thing
  a placement is decided against; and **Later**, the `## Later, not
  scheduled` block, `[ ]` lines that are wanted and not ordered. The
  **Milestone**, **Mark**, **Queue** and **Discuss** rows and the Queue
  entity say what changed: a `[ ]` line is not always the next one, and
  `/discuss` moves lines in the one case above.
* `VERSION` is bumped: a target receives a changed skill, a changed manual
  and a changed template.

**Slice.** Not the CLI: no verb, no check and no message changes. The content
`bin/focus-kit` moves (`docs/01-Architecture.md` §3, Structure, and §4). No
View, Orchestrator, Use case or Repository: §3 says none of the four exists
here. Kit-owned: `skills/discuss/SKILL.md`, `skills/propose/SKILL.md`,
`manuals/process.md`, the two templates. Project-owned: this repository's
`docs/03`, `docs/05` and `docs/06`.

**States.**

* A queue with no Later section and a line no paragraph admits: `/discuss`
  writes the section and the line under it.
* A queue with milestones and fewer than three Later lines: no milestone is
  proposed, and nothing is said about it.
* Later here after the conversion holds lines that do share a purpose, what
  `update` does to a target the kit has moved past among them, so the proof
  run is likely to propose a milestone on its first pass. The answer is the
  person's, either way, and the record says which was given.
* A repository with no queue at all: `/discuss` already names `/initialize`
  and writes nothing (`work/done/discuss-adds-queue-line.md`).
* The kit's own output: unchanged. `install`, `doctor` and `selftest` print
  what they printed, at the new version.

**Visual reference.** No UI, and no line of the CLI changes. The shape Later
takes, here and in the template:

```
## Later, not scheduled

[ ] <slug>               <one line of scope>
[ ] ~~<slug>~~           done by <the slug that did it>
```

**Out of scope.**

* Normalizing the paragraphs already written: milestones 1, 2 and 3 each
  carry a name and a paragraph that opens at what closes them
  (`docs/06-Queue.md`).
* A check in `selftest` that a milestone has a paragraph: nothing here is
  verified automatically (`docs/00-Product.md`, Non-goals).
* No ADR: a placement rule is reversed by editing one file
  (`docs/03-Domain.md`, ADR).
* Reordering: the two moves above are `/discuss`'s and no other, the order
  inside a milestone is untouched, and the order stays the person's decision.
* `/apply` and `/initialize`: neither places a line. The template carries
  what `/initialize` needs.
* A target initialized before this version: `docs/06-Queue.md` is
  project-owned and no command rewrites it, so its Later block stays prose
  until someone there changes it.

**Done when.**

* [x] `bin/focus-kit selftest` is green, six checks.
* [x] A real run of `/discuss` in this repository places a line and says which
  outcome it took, and the transcript goes into
  `work/done/queue-line-finds-its-place.md` (`docs/05-Process.md` §6). The
  idea it runs on is the person's to bring, and the line it writes commits
  with the delivery.
* [x] `docs/06-Queue.md` holds no prose bullet under Later.
* [x] No text of this repository says the queue is one line per delivery in order
  without admitting a Later line: `docs/03`, `docs/05` §8, `docs/06`,
  `manuals/process.md` and the two templates.
* [x] `VERSION` bumped and `focus-kit install .` run here, so check 6 is green
  and the dogfood copy carries the change (`docs/05-Process.md` §5).
* [x] `docs/03` rows added and amended, `docs/05` §8 and `manuals/process.md`
  §The queue updated, in this delivery.

---

## Record

`VERSION` 0.24.0. A target receives a changed `/discuss`, a changed
`/propose`, a changed `manuals/process.md` and two changed templates.

### What the run settled

**The placement step is a section of its own.** The Contract asked for it
"as its last act before it writes", and the paragraph it replaces sat inside
Write. A step with three ordered cases and a milestone proposal after them
does not read as a paragraph, so it became `## Place the line`, between Talk
and Write. Write kept the shape of a line and gained the shape of a Later
line; the placement left it entirely.

**`/propose`'s Close had nothing to remove.** The Contract says "Its Close
stops offering a line it added." Its Close never offered one: it lists what
was written and names the new session. The clause that added a missing line
lived only in Write, and that is the one that left. Write's remaining
sentence now says why the line is already there, which is the stop in Read
first.

**Three files the Contract did not name changed, because their behaviour
did** (`CLAUDE.md`, docs are living). `docs/00-Product.md`, Putting a line in
the queue, said "Where the line goes it asks, and never assumes"; it now
says the placement is decided against the paragraphs and what stays a
question. `docs/05-Process.md` §2 and the template's §2 carried the same
sentence about `/discuss`, one line each. `manuals/process.md` §4 said
`/discuss` "moves no existing line" and named a bullet under Later, and §5
said nothing about a `/propose` that stops. `README.md`, one line, for the
same reason: its `/discuss` bullet said the command asks where the line
goes. None of the five is in the Contract and each states behaviour this
delivery changed.

**One literal the conversion corrected.** The Later bullet about the
kit-owned banner read "the three `SKILL.md` files". There are four since
`discuss-adds-queue-line`, so the line reads "each SKILL.md". The bullet
about the gitignore fragment said "Related to the line below"; a line that
now has a slug is named by it, `update-survives-a-moved-section`, because a
positional reference dies the moment the lines move, which they did in the
same session.

**The struck-through case was checked and not assumed.** `.graphifyignore`
and `config/graphifyignore.fragment` both hold the four skill folders and
the three manuals, so the first Later line is struck with the reason naming
`graph-ignores-the-kit`, per the page's own instruction.

### The deleted queue line, and what put it back

The working tree arrived with `git-branches-are-queue` removed from
milestone 3 rather than struck through, which contradicts the Queue
invariant (`docs/03-Domain.md`: a line never leaves, a cancelled one is
struck through with a reason) and the text of `git-strategy-is-asked`, which
says that line is struck "when this one is proposed". Offered three ways:
restore it, strike it now, or keep it. The stakeholder chose to keep it
deleted, and this delivery wrote nothing there.

It came back anyway, and not from here. While this session was running, a
`/propose git-strategy-is-asked` in another session restored the line struck
through with its reason and marked its own line `[>]`, which is what that
queue line always said would happen when it was proposed. The invariant
holds again in the file, by that session's hand. What this delivery did was
notice it and ask; the fix belongs to the other one.

**And it produced the collision it describes.** That same concurrent session
left `work/git-strategy-is-asked.md` in the tree and a `[>]` in
`docs/06-Queue.md` under this delivery's feet, which is word for word the
error its own queue line records as measured on 2026-09-18. The Close of
this delivery had to decide what to stage rather than run `git add -A` and
find out, and the decision went to the stakeholder. Second occurrence of the
same failure, in the same repository, two days running; `git-strategy-is-asked`
is the delivery that ends it.

### No conflict with `git-strategy-is-asked`

The two deliveries were checked against each other, which is what opened
this session. They do not collide: the rows they add to `docs/03-Domain.md`
are different (Milestone paragraph and Later here, Git strategy there), the
slot one writes is `docs/05` §7 and the rules the other writes are §8 and
the queue's own shape, and `git-policy-for-a-second-person`, the Later line
this delivery named, is about revisiting this repository's trunk policy when
a second person arrives, not about what `/initialize` asks a target. The one
place they touch is `docs/06-Queue.md` itself, and that is the struck line
above and not a rule.

`git-strategy-is-asked` does sit under a milestone 3 paragraph that does not
admit it, which is exactly the pathology this delivery names. Moving it is
Out of scope here, and the `/discuss` run below queued the line that fixes
it.

### The proof run

`/discuss` in this repository, after `focus-kit install .`, so the session
read the new `.claude/skills/discuss/SKILL.md` and not the old one. The idea
was the stakeholder's: normalize the milestone paragraphs already written,
so the placement rule decides the queue as it stands.

**What it did.** Read `docs/00`, `docs/03`, `docs/06` and `work/`; asked the
graph nothing. Said three decided matters out loud with the file that closed
each: no new term (`docs/03` already holds Milestone paragraph), not the
same delivery (`work/queue-line-finds-its-place.md`, Out of scope, names it)
and which concrete error (`docs/06` itself, milestone 3's paragraph and the
four lines under it). Asked two questions: how far the normalization goes,
and the milestone proposal.

**Which outcome the placement took: the third.** No paragraph admits the
line. Milestone 3 closes when someone reads `README.md` and understands the
kit, and normalizing the queue's own paragraphs does not serve that;
milestones 1 and 2 are closed. So the line went under Later, and nothing was
asked about the placement, which is what the page says step 3 does.

**The milestone proposal fired on the first pass**, as States predicted.
Later held three lines sharing one purpose, what an `update` does to a
target the kit has moved past: `skill-says-it-is-kit-owned`,
`an-old-target-gets-the-fragment` and `update-survives-a-moved-section`. The
stakeholder accepted it after milestone 3, so `## Milestone 4: the kit
reaches the targets it left behind` was written with a paragraph of its own
and the three lines moved out of Later into it. That move and the promotion
are the only two the command makes, and this was the first one exercised.

**What the run proves that the verify command cannot.** Check 2 proves the
new `SKILL.md` copies into a target. It cannot prove that a placement step
with three cases produces one of them and says which, that a proposal out of
three Later lines is recognized rather than invented, or that a line refused
by every paragraph lands under Later with no question asked. The run did all
three, and it wrote two of this delivery's own outputs: the queue line
`every-paragraph-admits-its-lines` and milestone 4.

**Nothing diverged from the page.** The three placement outcomes, the Later
shape and the milestone proposal behaved as Behaviour describes them. The
one thing the page left to the run, which outcome the proof would take, came
back as Later plus a milestone proposal.

### Environments

| Environment | State |
|---|---|
| Kit source | 0.24.0, the truth |
| Dogfood copy (`.claude/skills/`, `docs/manuals/`) | 0.24.0, check 6 green |
| Machine (`~/.local/bin/focus-kit`) | a symlink to the kit source, so 0.24.0; global `/graphify` skill at the graphify package's version |
| First target (`~/Downloads/vaulted`) | 0.22.5, read from its stamp, so two versions behind. `focus-kit update ~/Downloads/vaulted`, and only if someone works there: milestone 2 is closed and this row leaves `docs/05-Process.md` §5 with it |
| Target repositories (anyone else's) | untouched, at whatever version they installed. Their owner runs `focus-kit update` |
