# Queue

One line per delivery, in order. The mark says where it stands:
`[ ]` not yet defined · `[>]` defined, `work/<slug>.md` exists, not yet
built · `[x]` done, in `work/done/`. The process is `docs/05-Process.md`.

---

## Milestone 1: the kit checks itself

When this milestone closes, a change to focus-kit can be made without fear,
because one command says whether a target repository would still receive a
working kit. Today that answer comes from installing into a scratch
directory by hand and looking, which is why the three defects below went
unnoticed until the documents were written.

```
[ ] kit-selftest              one command that parses, installs into a scratch repository, runs doctor,
                              repeats to prove idempotency, parses the three SKILL.md frontmatters,
                              greps for the em dash and diffs the dogfood copies
[ ] help-text-follows-header  focus-kit --help prints the whole header, however long it grows;
                              today sed -n '2,25p' cuts the last line mid-sentence
[ ] gitignore-no-duplicates   the fragment skips lines the target already ignores;
                              today .gitignore:2 and :6 are the same line
[ ] merge-json-by-argument    the settings baseline reaches python3 as data, not interpolated
                              into the source it execs; a quote in the JSON breaks the install
[ ] doctor-reports-drift      doctor says when a kit-owned file in a target was edited locally,
                              so the person knows update is about to overwrite their edit
```

Close of milestone 1: whole-branch review (`docs/05-Process.md` §9).

## Milestone 2: the kit used on something real

When this milestone closes, the kit has been through a full cycle on a
repository that is not itself: installed, initialized, one delivery proposed
and applied end to end, and every piece of friction found on the way brought
back here as a queue line. Until that happens, every claim the kit makes
about brownfield repositories is untested.

```
[ ] first-target-install      install into a real repository and record what doctor missed
[ ] first-target-initialize   run /initialize there and record every question it should have
                              asked, and every one it asked that the code could have answered
[ ] first-target-delivery     one delivery through /propose and /apply, start to finish
```

## Later, not scheduled

* Keep the dogfood copies out of the graph. The first build indexed
  `.claude/skills/` and `docs/manuals/` alongside their sources and produced
  mirrored communities, so half the graph describes the same files twice and
  42 nodes came back weakly connected (`graphify-out/GRAPH_REPORT.md`).
  Related to open decision 2, but fixable without settling it.
* A kit-owned banner on the three `SKILL.md` files. The manuals carry one on
  their first line; the skills cannot, because that line is YAML
  frontmatter. Someone editing a skill inside a target gets no warning that
  the next update erases it (`docs/adr/ADR-0002-file-ownership.md`).
* `focus-kit uninstall`: remove the kit-owned files and unmerge the two JSON
  keys, so a repository can stop using the kit without unpicking it by hand.
* Distribution beyond clone and symlink: a curl installer, or a package.
  Blocked on open decision 3.
* A kit-owned file in a target that changed shape between versions: today
  `update` overwrites and a target's documents may reference a section that
  moved. Blocked on open decision 5.
* Translated manuals, so a target documenting itself in another language
  does not receive three English manuals. Blocked on open decision 4.
* A second person working in this repository, which is what would make the
  trunk-only git policy in `docs/05-Process.md` §7 worth revisiting.

## Open decisions

These are the decisions from `docs/00-Product.md` that affect what order
things happen in. Each one is the stakeholder's call, taken in conversation,
never by an agent's assumption.

1. **Does the kit get a test suite beyond `doctor`?** `kit-selftest` is
   scoped as one script. If the answer is a real suite, that line grows into
   several and milestone 1 changes shape. Decides: the stakeholder.
2. **Do the dogfood copies stay versioned?** If they stop being versioned,
   check 6 of the verify command and the second row of the environments
   table both disappear. Decides: the stakeholder.
3. **How is the kit distributed?** Everything under "Later" about
   installers and packages waits on this. Decides: the stakeholder.
