# Process

How an idea becomes code in <name>. The process is the focus-kit one
(`docs/manuals/process.md` is the manual); this document is the part that
is specific to this project: the slots `/apply` reads every time.

---

## 0. Language

<!-- init: one line, the documentation language settled in Step 0, matching
     CLAUDE.md and docs/04-Conventions.md §1. Keep the second sentence. -->

The delivery page and the commit message are written in English.
Identifiers are in English regardless (`docs/04-Conventions.md` §1).

## 1. The rule

**A delivery is a one-page file.** If it does not fit on one page, it is
two deliveries. The page is not a goal of concision: it is the test that
the scope was understood. A scope that needs five pages to describe has
not been decided yet.

## 2. The flow

```
an idea  →  /discuss  →  docs/06-Queue.md  →  /propose <slug>  →  work/<slug>.md
                                                                        ↓
                                                                  /apply <slug>
                                                                        ↓
                                              verify green, environments as §5 says
                                                                        ↓
                                                work/done/<slug>.md + git add -A
                                                                        ↓
                                                   a person reviews and commits
```

**`/discuss <the idea>`** is a conversation that ends in one line of
`docs/06-Queue.md` and in nothing else. It reads `docs/00-Product.md`,
`docs/03-Domain.md`, `docs/06-Queue.md` and what is in `work/`; it offers
alternatives with what each one buys and costs; it places the line against
the milestone paragraphs and asks only what they leave open. **It writes no
delivery page.**

**`/propose <slug>`** is a conversation. It reads `docs/00-Product.md`,
`docs/03-Domain.md`, `docs/06-Queue.md` and what is in `work/`; asks
whenever there is more than one reading; writes `work/<slug>.md`. **It
writes no code, migration or test.** Separating deciding from doing is what
keeps scope from growing during implementation.

**`/apply <slug>`** implements, in a clean session. It reads the delivery,
`CLAUDE.md`, `docs/01-Architecture.md`, `docs/04-Conventions.md` and this
document; builds every piece; runs the verify command; proves the screen
if there is one; leaves the environments as §5 says; updates the docs the
delivery changed; ticks "Done when"; moves the file to `work/done/`; stages
and **suggests** the commit message. **It does not commit.**

## 3. The format of `work/<slug>.md`

```markdown
# <slug>

**Goal.** One sentence: what a user becomes able to do.

**Behaviour.** Verifiable scenarios in user language. Each line becomes a
test or a manual check.

**Contract.** Schema, migration, API shape, message shape, or "none". The
only section that demands precision, because it is the only one that is
expensive to reverse.

**Slice.** Which feature folder, and which of the pieces
`docs/01-Architecture.md` §3 says a slice has here it adds or changes.

**States.** Empty, loading, error, offline: one line each, or "the
defaults".

**Visual reference.** <!-- init: the artboard, the design file, the
existing screen to match, or "no UI". --> And the viewports.

**Out of scope.** What does not go in, half a line of reason each.

**Done when.** Mechanical checklist: test X passes; screenshot matches Y;
verify green; <inviolable proof> passes if the delivery touched it; the
environments in §5 are in the required state.
```

## 4. Verify

```
<verify command>
```

<!-- init: what it runs, how long it takes, what a red means. If parts are
     slow and run only in CI, say which. -->

## 5. Environments

| Environment | A delivery must leave it | Command |
|---|---|---|
<!-- init: one row per environment from docs/01 §7. Examples of the middle
     column: "at the repository's version, always" (the workshop where
     tests run); "untouched; published only at a milestone or on request"
     (production); "updated when the delivery touches the API" (staging).
     Be exact: this table is the rule /apply follows. -->

**A delivery never ends silent about environments.** The last thing
`/apply` says is which environment is at which version and the command
that updates the others. What costs, in every project, is not the missing
deploy: it is someone opening an environment believing it is current.

<!-- init: the publish policy in prose: when publishing happens without
     asking (a milestone, an explicit request, a change only that
     environment can prove), and when it asks first. Which environment is
     production, and since when. -->

## 6. Proof

<!-- init: the tool first, from the Proof tool question or from the No screen
     question, never inferred: no file in a repository names either one. The
     finished section opens with **Tool.** and what was chosen. Then the
     rest of how a screen is proven: viewports, what it is compared to (a
     design canvas, the previous screenshot, a client's mock), and the rule
     for divergence ("the visual wins; copy and flow may diverge with a
     one-line reason"). If there is no UI: how an endpoint or a CLI is
     proven (contract test, golden file). -->

## 7. Git

<!-- init: the first line is **Strategy.** and the answer to the Git strategy
     question, one of the three: a worktree per delivery, a branch per slug,
     or none. It is what /discuss, /propose and /apply read, so it is never
     prose about branches in general. Then the rest: PR or direct; who
     commits (a person, always, is the house rule); review before merge; the
     message format from docs/04 §6. What each command does under each
     strategy is docs/manuals/process.md §The git strategy; do not repeat it
     here. -->

## 8. Queue

`docs/06-Queue.md`: one line per delivery, in order from the first
milestone on, plus `## Later, not scheduled` outside that order. Not a
schedule, not a narrative. `/discuss` is what adds a line, in conversation,
and where it goes is decided against the milestone paragraphs: the
milestone whose paragraph admits the line, the milestone whose paragraph
the person amends to admit it, or Later, for a line no paragraph admits. A
line **never leaves** the queue: it changes mark. `/propose` turns `[ ]`
into `[>]` (defined in `work/<slug>.md`, not yet built) and stops on a slug
standing under Later, which is not ordered yet; `/apply` turns `[>]` into
`[x]` and moves the file to `work/done/`.

## 9. Milestone review

At the close of each milestone, not each delivery, the stakeholder runs a
whole-branch review (`/code-review ultra` in Claude Code, or the team's
equivalent). It exists because the process is light: no formal spec and no
gates means the risk is accumulation, each delivery correct and the whole
crooked. Every confirmed finding becomes a delivery in the queue, named
after what it fixes, not a rushed patch in the middle of the next
milestone. The review is user-triggered and billed; the agent reminds, it
never launches it.

## 10. What does not exist in this process

No formal spec, no spec delta, no archiving, no numbered tasks, no
pre-implementation gate, no specialized subagent. If any of these
reappears, the question is: **which concrete error would it have caught?**
The answer has to name an error that actually happened.
