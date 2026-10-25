# Queue

Every case `queue.sh` decides. `test/run.sh check` runs it on this file
and compares the output with `expected-trunk.txt`, then pushes the branch
of `card` with its line at `[*]` and compares with `expected-worktree.txt`.
Then it marks `board` `[x]` on main and runs from the worktree of `card`,
whose copy still says `[>]`, against `expected-stale.txt`; and runs the
file with CRLF endings against `expected-trunk.txt`.

## M1. Done

When this milestone closes, there is a base.

```
[x] base        (--) the base everything stands on
[x] old-idea    (PA) an idea nobody wanted · after base · dropped: refused
```

## M2. Board

When this milestone closes, the board shows cards.

```
[>] board       (PA) the board · after base
[ ] card        (PA) a card on the board · after board
[ ] filter      (P-) filter the cards · after board, card
[>] colors      (-A) colors for the lanes
[ ] search      (PA) search the cards · after board, card, missing-slug
[~] login       (PA) log in
[?] export      (PA) export the board · resume: propose · blocked: which format, asked
[ ] notes       free notes beside the board
[*] sound       (PA) a sound when a card moves
[ ] ping        (PA) a cycle, one half · after pong
[ ] pong        (PA) a cycle, other half · after ping
[ ] revive      (PA) bring the idea back · after old-idea
[ ] m2-review   (--) the review of M2 · after board, card, filter, colors, search, login, export, notes
```

## M3. Later

When this milestone closes, more.

```
[ ] later       (PA) not planned yet · after m2-review
```
