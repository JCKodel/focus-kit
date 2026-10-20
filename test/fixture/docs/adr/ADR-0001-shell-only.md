# ADR-0001: shell only

Context: the project exists to test a delivery process, not to be used.
Decision: one POSIX shell script and a shell test runner; no language
runtime, no package manager, no dependency.
Consequence: every delivery edits `src/greet.sh` and `test/greet_test.sh`
and nothing else; a proposal that needs more is out of scope.
