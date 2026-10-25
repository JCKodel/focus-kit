# Queue

The marks, the suffixes, the order as priority, the next milestone and what may run at the same time are docs/05 §4, written once there. A line is the mark, the slug, one sentence and its suffixes; what happened goes on its page.

## M1. Greetings

When this milestone closes, `greet.sh` prints a greeting and a farewell, in English or Portuguese, quietly or shouting, the README says how, and `make verify` proves each one.

```
[x] skeleton    greet.sh prints hello; make verify runs the tests
[ ] farewell    greet.sh bye prints "bye"; any other verb is a usage error
[ ] banner      README.md gets a Usage section listing the verbs and flags, and nothing else changes
[ ] portuguese  greet.sh --lang pt prints "olá", and with bye "tchau"; --lang anything else is a usage error
[ ] shout       greet.sh --shout prints the line in upper case, for both verbs and both languages · after farewell, portuguese
[ ] m1-review   the review of M1 as docs/05 §8 says · after all
```
