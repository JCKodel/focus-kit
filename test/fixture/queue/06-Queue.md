# Queue

Every case `queue.sh` decides. `test/run.sh check` runs it on this file
and compares the output with `expected-trunk.txt`; then, on a local bare
remote, it pushes branches: `card` at `[*]` with a `card-fix` line only
that branch has, `login` with no change (claimed, progress unknown),
`export` at `[?]` while main says `[>]` (blocked wins), `colors` at `[x]`
unmerged (built, awaiting integration), `search` with a new `after` at
the same mark, which it waits on though claimed; and compares with `expected-worktree.txt`. Then it merges
`colors` into main and runs from the worktree of `card`, whose copy is
stale, against `expected-stale.txt`; and runs the file with CRLF endings
against `expected-trunk.txt`. The `notes` line is wrapped on purpose.
`tooltips` is dropped, so `m2-review`'s `after all` leaves it out, while
`revive` names the dropped `old-idea` and waits for the person.
Four lines end `· from <slug>` and are counted by `findings:`. `card-lost`
stands ahead of open planned lines, so the warning names it. `sync-fix`
stands ahead too, but `sync` names it in `blocked: after`, a fix it
waits on, so the warning leaves it out. That is how a queue written
before 2026.11.13 says it, and it is still read; `test/run.sh` writes
today's form, `[>]` with `· after`, in its `pay` case. `lane-gap` is done, counted and
not open. `tip-wrap` sits below the planned lines, above the review,
where a finding that blocks nothing goes. `import`'s `· from CSV files`
is prose, not one slug, so it is a planned line. `later` is in the next
milestone, which is open too and is drawn under M2's tree.

## M1. Done

When this milestone closes, there is a base.

```
[x] base        the base everything stands on
[x] old-idea    an idea nobody wanted · after base · dropped: refused
```

## M2. Board

When this milestone closes, the board shows cards.

```
[>] board       the board · after base
[ ] card        a card on the board · after board
[ ] filter      filter the cards · after board, card
[ ] card-lost   a card is lost on reload · from board
[>] colors      colors for the lanes
[ ] search      search the cards · after board, card, missing-slug
[ ] login       log in
[ ] import      import the cards · from CSV files
[>] export      export the board
[x] lane-gap    a gap between two lanes · from colors
[ ] notes       free notes beside the board, kept in the browser and
                shown under the lanes · after colors
[*] sound       a sound when a card moves
[ ] sync-fix    the sync drops the last card · from sync
[?] sync        sync the board between tabs · resume: apply · blocked: after sync-fix
[ ] ping        a cycle, one half · after pong
[ ] pong        a cycle, other half · after ping
[ ] revive      bring the idea back · after old-idea
[ ] selfish     waits on itself · after selfish
[x] tooltips    tips on hover · dropped: no longer wanted
[ ] tip-wrap    a tip wraps over two lines · from board
[ ] m2-review   the review of M2 · after all
```

## M3. Later

When this milestone closes, more.

```
[ ] later       not planned yet · after m2-review
```
