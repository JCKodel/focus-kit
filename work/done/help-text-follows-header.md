# help-text-follows-header

**Goal.** A person who adds a line to the header comment of `bin/focus-kit`
sees it in `focus-kit --help` without editing anything else.

**Behaviour.**

* `focus-kit --help` today prints exactly what it prints now: 27 lines,
  from the license notice to `supply a python).`, byte for byte.
* A header that gains a line prints the new line in `--help`, and the
  dispatch at the bottom of the file is not edited. That is the defect:
  `open-source-license` grew the header by one line and had to move the
  range from `2,27p` to `2,28p` by hand.
* A header that loses a line never prints `set -euo pipefail` or anything
  below the header.
* `focus-kit`, `focus-kit -h`, `focus-kit --help` and `focus-kit help`
  print the same thing.
* `bin/focus-kit selftest` stays green: six `ok` lines, exit 0.

**Contract.**

The help text is the header comment, defined by a rule rather than a range:

* Line 1, the shebang, is skipped. It starts with `#` too, so a rule that
  reads "every comment line" without the skip is wrong.
* From line 2, every consecutive line that begins with `#` is printed. The
  run stops at the first line that does not begin with `#`. Today that is
  line 29, which is blank.
* Each printed line loses its leading `#` and one following space when
  there is one, exactly as today's `s/^# \{0,1\}//`. A bare `#` becomes an
  empty line, so the four blank-looking lines of the header (lines 4, 10,
  22 and 26 today) stay in the output. A rule that stopped at the first
  empty-looking line would truncate at line 4.
* The output for the file as it is today is byte-identical to what
  `sed -n '2,28p' "$0" | sed 's/^# \{0,1\}//'` prints. That is the
  regression guard.

The constraint is bash 3.2 with the `sed` and `awk` macOS ships. Both are
already used in the script; which one carries the rule is `/apply`'s call,
and it is one line replacing one line at `bin/focus-kit:371`.

`VERSION` goes to `0.4.1`: the CLI's behaviour changes, even though today's
output does not.

**Slice.** `bin/focus-kit`, the CLI, never copied to a target: the `help`
branch of the dispatch. Two project-owned documents say how the help text
is produced and are rewritten in the same delivery: the bullet "The help
text is the script's own header" in `docs/04-Conventions.md` §1, which today
says "lines 2 to 28", cites the range as a literal and points at this slug
in the queue; and the sentence in `docs/01-Architecture.md` §3 that says the
header is printed "through `sed`". Both describe the rule above, name no
range, and name the tool `/apply` chose or none. No skill, manual, template
or `config/` file is touched, so the dogfood copy is not resynced and check
6 is unaffected; `.claude/skills/.focus-kit-version` keeps reading `0.4.0`,
because it records the last install and no install happens here, the same
way `kit-selftest` left it at `0.2.0` when `VERSION` went to `0.3.0`. No FOCUS piece
appears (ADR-0003).

**States.** The defaults. `install`, `update`, `doctor` and `selftest`
print nothing new. There is no failure state: the rule reads the script's
own file, which exists because it is running.

**Visual reference.** No UI. The proof is the run compared against the old
range on the file as it is today:

```
diff <(bin/focus-kit --help) <(sed -n '2,28p' bin/focus-kit | sed 's/^# \{0,1\}//') && echo identical
```

First line of the output: `Copyright (C) 2026 J.C. Ködel. Licensed under
AGPL-3.0-only. Source and terms: https://github.com/JCKodel/focus-kit`.
Last line: `supply a python).`, with the closing parenthesis.

**Out of scope.**

* A selftest assertion on `--help`. Deleting the literal removes the drift,
  and a seventh check would turn every "six" in the docs and the header
  into "seven", a bigger diff than the fix. Decided in this page's
  conversation.
* A `--version` or `-v` alias. A different verb, not the help text.
* The other count literals in the docs ("three" skills, "six" checks).
  `discuss-adds-queue-line` names that.
* The bare `#` lines becoming empty lines. That is today's output and the
  contract is byte-identity with it.

**Done when.**

* [x] The `diff` above prints `identical`, and `focus-kit`, `-h`, `--help`
  and `help` produce the same 27 lines.
* [x] `grep -rn "lines 2 to\|28 of the file\|2,28p" bin docs CLAUDE.md
  --exclude-dir=manuals` finds no hit. Today it finds three, at
  `bin/focus-kit:371` and `docs/04-Conventions.md:65-66`, where the range
  wraps across two lines. `work/done/` keeps its mentions, they are history.
* [x] `docs/04-Conventions.md` §1 and `docs/01-Architecture.md` §3 describe
  the rule and cite no line range.
* [x] `bin/focus-kit` keeps 374 lines, so every `bin/focus-kit:NN` citation
  in `docs/` and `CLAUDE.md` still points at its line; if the count moved,
  the citation sweep from `work/done/open-source-license.md` is repeated.
* [x] `VERSION` is `0.4.1`.
* [x] `bin/focus-kit selftest` prints six `ok` lines and exits 0.
* [x] Environments: kit source at 0.4.1, dogfood copy in sync (check 6
  empty) with its version stamp still at 0.4.0, machine follows the
  symlink, targets untouched until their owner runs `focus-kit update`.

---

## What happened

**The tool is `awk`.** The page left the choice open. `sed` could do it in
one command (`sed -n '1d; /^#/!q; s/^# \{0,1\}//p'`) and was tried and
proven identical, but it encodes the three rules as three cryptic commands
whose order matters. The `awk` line names them:

```
awk 'NR == 1 { next } !/^#/ { exit } { sub(/^# ?/, ""); print }' "$0"
```

Rule one skips the shebang, rule two stops at the first line that is not a
comment, rule three strips the marker. `sub(/^# ?/, "")` is exactly today's
`s/^# \{0,1\}//`, so a bare `#` still becomes an empty line. One line
replaced one line; `bin/focus-kit` is still 374 lines and every
`bin/focus-kit:NN` citation still points where it did.

`"$0"` was kept rather than switched to the resolved `"$SELF"`. Reading
through the symlink works and the swap is outside this page.

**Nothing diverged from the plan and nothing was dropped.**

**The proof.** The `diff` in Visual reference prints `identical`, and the
four invocations produce the same 27 lines, first line the license notice
and last line `supply a python).`. The verify command is green: six `ok`
lines, exit 0, check 6 empty.

Two behaviours the `diff` cannot reach were proven on copies in the
scratchpad, each with a `VERSION` beside it so the script would run:

* a header that gains `# a line someone added to the header` after line 28
  prints 28 lines, the new one last, and no `set -euo pipefail`;
* a header that loses lines 25 to 28 prints 23 lines, ending at the last
  surviving comment, and no `set -euo pipefail`.

**Decisions.** No ADR. The change is one line inside a branch of the
dispatch and reverses for the cost of reading it.

**One note on the session.** The graphify MCP server failed to connect, so
the slice was read directly: `bin/focus-kit`, the two documents the page
names, and the grep the page prescribes. For a slice of two files named
by the page that is enough, and `graphify-out/` was not consulted.

**Docs.** `docs/04-Conventions.md` §1 now states the rule and names `awk`;
the paragraph that said the range was still a literal and pointed at this
slug in the queue is gone, because it is no longer true.
`docs/01-Architecture.md` §3 says the same in one sentence. Both keep the
`bin/focus-kit:371` citation and neither names a range.

**Environments.** Kit source at 0.4.1. Dogfood copy in sync, check 6 empty,
its stamp still reading 0.4.0 because no install ran: nothing under
`skills/`, `manuals/`, templates or `config/` was touched. The machine
follows the symlink and `focus-kit version` already prints 0.4.1. Target
repositories are untouched and move when their owner runs
`focus-kit update <path>`.
