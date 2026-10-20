# Architecture

One POSIX shell script, `src/greet.sh`, that parses its arguments and
prints one line. Stack: `sh`, `make`. No dependency.

Modules: `src/greet.sh` (the program), `test/greet_test.sh` (the tests,
one `check` line each). A delivery that adds an option adds its `check`
lines there.

Errors: an unknown argument prints `usage: greet.sh [hello|bye] [--lang en|pt]
[--shout]` to stderr and exits 2. Nothing else can fail.

Verify: `make verify`.
