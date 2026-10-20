# Conventions

Documentation language: English. Identifiers in English.

Shell: POSIX `sh`, no bashisms. One script, one `case` over the verb,
options parsed before it. Output is one line on stdout; errors go to
stderr with exit code 2.

Tests: `test/greet_test.sh`, one `check "<args>" "<expected>"` line per
behaviour scenario of the page. `make verify` runs them all and is green
before anything is declared done. No slow tests.

Commit format: docs/05 §6.
