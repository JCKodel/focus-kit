# Queue

Every case `queue.sh` decides. `test/run.sh check` runs it on this file
and compares the output with `expected-trunk.txt`; then, on a local bare
remote, it pushes branches: `card` at `[*]` with a `card-fix` line only
that branch has, `login` with no change (claimed, progress unknown),
`export` at `[?]` while main says `[>]` (blocked wins), `colors` at `[x]`
unmerged (built, awaiting integration), `search` with a new `after` at
the same mark; and compares with `expected-worktree.txt`. Then it merges
`colors` into main and runs from the worktree of `card`, whose copy is
stale, against `expected-stale.txt`; and runs the file with CRLF endings
against `expected-trunk.txt`. The `notes` line is wrapped on purpose.

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
[>] colors      colors for the lanes
[ ] search      search the cards · after board, card, missing-slug
[ ] login       log in
[>] export      export the board
[ ] notes       free notes beside the board, kept in the browser and
                shown under the lanes · after colors
[*] sound       a sound when a card moves
[ ] ping        a cycle, one half · after pong
[ ] pong        a cycle, other half · after ping
[ ] revive      bring the idea back · after old-idea
[ ] selfish     waits on itself · after selfish
[ ] m2-review   the review of M2 · after all
```

## M3. Later

When this milestone closes, more.

```
[ ] later       not planned yet · after m2-review
```
