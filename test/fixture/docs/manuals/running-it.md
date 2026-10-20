# Running it

What it does: runs `greet.sh` from a fresh clone and proves it works.
When: after cloning, and after every delivery.

Must be in place: `sh` and `make`.

1. `sh src/greet.sh` prints `hello`.
2. `make verify` runs `test/greet_test.sh`; every line says `ok`.

It worked when `make verify` exits 0. Undo: nothing to undo. Skipping
step 2 leaves a delivery unproven.
