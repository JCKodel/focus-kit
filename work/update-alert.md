# update-alert

**Goal.** Someone whose clone of the kit is behind the repository it was
cloned from is told so by the commands they already run, with both numbers
and the two commands that close the gap, instead of updating targets from a
kit that stopped moving months ago.

**Behaviour.**

* `focus-kit doctor`, run anywhere, says which version the clone holds and
  which one `origin` has. When `origin` has a newer one, one warn names both
  numbers, the pull and then `focus-kit update`, in that order: the pull is
  what puts the newer kit on the machine, and `update` is what carries it
  into a repository.
* `focus-kit install` and `focus-kit update` say the same line in the
  dependencies block, before anything is copied, because that is the run that
  would otherwise write the old kit into a target with nothing said. The
  install then goes on and writes the version the clone holds. It warns; it
  does not stop, and it does not pull.
* A clone that is current gets one green line, and so does a clone ahead of
  `origin`, which is what this repository is between a commit and a push.
* A machine with no network, an `origin` the derivation does not cover, a
  clone whose `origin` answers nothing readable, and an answer that is not a
  version each get one warn saying `origin` did not answer, carrying the
  number the clone holds. Nothing is inferred from a failure, and no answer
  is treated as a version because it arrived.
* The check is bounded. An `origin` that does not answer becomes that third
  line and never a command that hangs in front of an install.
* Nothing is written into the clone: no ref, no object, no cache, no file.
  The check reads one file over HTTPS and forgets it.
* The verify command makes no network call, and is green on a machine that
  has none.
* Nothing about a target changes. The `kit version <v>` line, the Drift pass
  and the Unbumped change say what they say today, about the same things.

**Contract.**

* `bin/focus-kit`: one function that reads, compares and prints, two callers,
  `doctor` and the `install|update` branch of the dispatch. One wording for
  one state, held in one place, the way `append_once` keeps one copy of its
  marker.
* In `doctor` the line sits in the machine block, with `uv`, `graphify` and
  the global skill, and above every line that speaks of the target. What it
  reports is the kit source (`docs/01-Architecture.md` §7), not the target,
  and the two are not confusable in the output. In `install` it sits after
  `ensure_graphify`, the last thing the dependencies block says.
* **What is compared.** The `VERSION` file at the default branch of the
  clone's own `origin`, read over HTTPS, against `KIT_VERSION`. The remote is
  derived from `origin` and never written into the script, so a fork checks
  the fork and this clone checks this one. A `VERSION` file and not a tag, a
  release or a registry: `docs/03-Domain.md`, The kit, Transitions, says the
  kit has no release artifact and no tag flow, and the number is that file.
* **What counts as an answer.** One line that reads as a version, digits and
  dots. An empty body, an error page and a rate limit answer are the third
  state, because a 404 page taken as a version is a warn that lies
  (`docs/04-Conventions.md` §1).
* **The reader is `curl`**, which the kit already requires of the machine
  (`bin/focus-kit`, the header, and `docs/01-Architecture.md` §2), so nothing
  is added to what a person has to have. It being a program on PATH is what
  lets the verify command prove all three lines with a fake `curl` in front of
  it, the way check 2 already proves the five global skill lines with a fake
  `graphify` and a fake home.
* **What the run settles.** How the URL is derived from `origin` and what
  bound the read is given, inside the constraints above: read-only on the
  clone, and an `origin` the derivation does not cover falling into the third
  state rather than into a guess.
* **The version ordering becomes one function**, and this is the second
  concrete occurrence of that shape: the first is inside
  `global_skill_state` (`bin/focus-kit:114`), which orders two dotted numbers
  field by field because a string compare puts `0.9.10` before `0.9.8`
  (`CLAUDE.md`, abstraction on the second occurrence). It is extracted, its
  two callers are `global_skill_state` and the new function, and the five
  states of the global skill line are unchanged by the move.
* The three lines, exact, `<clone>` being `KIT_DIR`:
  * `kit source <v>, origin has <v> (git -C <clone> pull, then focus-kit update)`
  * `kit source <v> (nothing newer on origin)`, the green one
  * `kit source <v>, origin did not answer (check by hand: git -C <clone> pull)`
  The green one says nothing newer rather than equal, because a clone ahead of
  `origin` is the normal state here and the line has to be true of it too.
  Each warn names its command (`docs/04-Conventions.md` §1); the third names
  a hand check, since being offline has no command that fixes it.
* The function never dies. It prints `warn` or `ok` and returns, whatever the
  network did, and `doctor` goes on reporting and `install` goes on installing
  (`docs/01-Architecture.md` §6).
* `docs/05-Process.md` §4, check 2: the new line joins what the check asserts,
  in all three shapes, through a fake reader on PATH beside the scratch and
  not in it, removed by the existing `trap`. Check 6 runs `doctor` here and
  must stay offline for the same reason. The ten warns of a scratch and every
  other assertion are untouched.
* `docs/00-Product.md`: the Audience sentence saying the kit sends nothing
  stops being true and says what it now sends, which is one HTTPS read of a
  public file and no data about the person; Installing gains the alert. The
  Non-goal "no auto-update" stays as it is, and the page says the alert is not
  one: it names the pull and runs it never.
* `docs/01-Architecture.md`: §5 gains a row for the read and its closing
  privacy paragraph stops saying `curl` appears once; §3's function table
  gains the two functions and the `doctor` row gains the line; §2's
  `Deps (host)` already names curl and does not change.
* `docs/03-Domain.md`: the **Upstream version** row, written by this
  `/propose`, the state the three lines name, sitting between Kit version and
  Installed version because it is the third staleness question and the only
  one about the clone. The extracted ordering is named inside it rather than
  given a row of its own, the way `without_cr()` is named inside Installed
  version.
* `docs/05-Process.md` §5, the Machine row: `doctor` now reports whether the
  clone is current with `origin`, beside what it already reports about the
  CLI and the global skill.
* `README.md`: the update step, which it does not have. It says how to clone
  and how to install, and never says that a newer kit reaches the machine
  through `git pull` in the clone. That is the sentence the warn points at.
* `VERSION` is bumped: the CLI's behaviour changes and a target's owner wants
  it, since they are the person the alert exists for.
* Independent of the two pages of milestone 4 still in this tree,
  `an-old-target-gets-the-fragment` and `update-survives-a-moved-section`.
  This line sits in the machine block, above the Leftover, Drift and citation
  passes they touch; each of the three adds a row to `docs/03-Domain.md` and
  turns its own mark, and they land in any order. Under strategy None a
  `git add -A` here stages their pages too, which `docs/05-Process.md` §7
  already records as the cost of this answer. The third,
  `skill-says-it-is-kit-owned`, shipped while this page was being written.

**Slice.** `bin/focus-kit`, plus this repository's own documents and
`README.md` (`docs/01-Architecture.md` §3, Structure, one file; §4). No View,
Orchestrator, Use case or Repository: §3 says none of the four exists here.
The graph named `bin/focus-kit` and nothing else for `doctor`, both ways, and
what the CLI copies does not change. Kit-owned: `bin/focus-kit`.
Project-owned: `README.md`, `docs/00`, `docs/01`, `docs/03`, `docs/05` and
`docs/06`. No skill, no manual, no template and no fragment is touched, so
nothing a target receives changes except the CLI it runs from the clone.

**States.**

* Clone behind `origin`: the first line, in `doctor` and in the dependencies
  block of `install` and `update`. The install completes.
* Clone current, or ahead of `origin`: the green line.
* No network, an `origin` the derivation does not cover, or an answer that is
  not a version: the third line.
* No reader on PATH: the third line. It is the same failure as a network that
  does not answer, and it gets no wording of its own.
* Target not a git repository, dependency missing, kit-owned file drifted: the
  defaults. Every existing line is where it was.

**Visual reference.** No UI. `focus-kit doctor` on a machine whose clone is
two versions behind, the new line only, in the `warn` and `ok` shapes of
`bin/focus-kit:46`:

```
  ! kit source 0.25.0, origin has 0.27.0 (git -C ~/Projects/focus-kit pull, then focus-kit update)
```

and on a current clone, and on one that cannot reach `origin`:

```
  ✓ kit source 0.27.0 (nothing newer on origin)
  ! kit source 0.27.0, origin did not answer (check by hand: git -C ~/Projects/focus-kit pull)
```

The clone is `~/Projects/focus-kit` here because that is where `README.md`
puts it; the line carries whatever `KIT_DIR` resolved to.

**Out of scope.**

* Pulling, or updating anything. `docs/00-Product.md` Non-goals says no
  auto-update, and the commit and the pull are the person's.
* A cache or a timestamp between runs: `docs/01-Architecture.md` §5 says there
  is no state between runs, and a cache file would be a fifth ownership
  category, which `docs/03-Domain.md` forbids.
* An environment variable, a flag or a file that silences the check: that is a
  configuration for the kit, out by decision (`docs/01-Architecture.md` §2).
* GitHub releases, tags and the GitHub API: the version is the `VERSION` file,
  and the kit has no tag flow to read.
* Telling a target's owner that their kit is behind: `doctor` already does
  that with `kit version <v> installed, <v> available`, and this line is about
  the clone that answer is measured against.
* `focus-kit version`: it prints the clone's number and stays one line, for
  the scripts and the eyes that read it that way.
* What `update` does when the kit is ever distributed as something other than
  a clone: open decision 3 of `docs/00-Product.md`, and the delivery that
  settles it owns this mechanism too.
* An ADR: what changes is one sentence in `docs/00-Product.md`, one row and
  one paragraph in `docs/01-Architecture.md` §5, all cheap to reverse.

**Done when.**

* `bin/focus-kit selftest` is green, six checks, and every `doctor` and
  `install` it runs sees the fake `curl` and never the real one, so the run
  makes no network call and all three lines are asserted.
* `focus-kit doctor` here prints one of the three lines in the machine block,
  and every line it printed before, unchanged.
* `focus-kit update` on a clone made stale by hand prints the first line and
  still installs, and the transcript goes into `work/done/update-alert.md`
  (`docs/05-Process.md` §6).
* `README.md`, `docs/00-Product.md`, `docs/01-Architecture.md`,
  `docs/03-Domain.md` and `docs/05-Process.md` carry what the Contract names,
  the **Upstream version** row included.
* `VERSION` bumped and `focus-kit install .` run here, so check 6 is green and
  the dogfood copy is at the same number (`docs/05-Process.md` §5).
