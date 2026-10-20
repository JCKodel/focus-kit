#!/bin/sh
# The verify command of the fixture. Each test is one line: command, expected.
set -e
fails=0
check() {
  out=$(sh src/greet.sh $1)
  if [ "$out" = "$2" ]; then echo "ok    greet.sh $1 -> $2"
  else echo "FAIL  greet.sh $1: expected '$2', got '$out'"; fails=$((fails + 1)); fi
}
check "" "hello"
[ "$fails" -eq 0 ]
