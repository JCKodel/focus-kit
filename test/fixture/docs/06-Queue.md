# Queue

The marks, the suffixes, the order as priority, the next milestone and what may run at the same time are docs/05 §4, written once there. A line is the mark, the slug, its token, one sentence and its suffixes; what happened goes on its page.

## M1. Greetings

When this milestone closes, `greet.sh` prints a greeting and a farewell, in English or Portuguese, quietly or shouting, and `make verify` proves each one.

```
[x] skeleton    (PA) greet.sh prints hello; make verify runs the tests
[ ] farewell    (PA) greet.sh bye prints "bye"; any other verb is a usage error
[ ] portuguese  (PA) greet.sh --lang pt prints "olá", and with bye "tchau"; --lang anything else is a usage error
[ ] shout       (-A) greet.sh --shout prints the line in upper case, for both verbs and both languages · after farewell
[ ] m1-review   (--) the review of M1 as docs/05 §8 says · after farewell, portuguese, shout
```
