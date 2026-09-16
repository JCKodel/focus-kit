# Queue

One line per delivery, in order. The mark says where it stands:
`[ ]` not yet defined · `[>]` defined, `work/<slug>.md` exists, not yet
built · `[x]` done, in `work/done/`. The process is `docs/05-Process.md`.

---

## Milestone 1: the kit checks itself

When this milestone closes, a change to focus-kit can be made without fear,
because one command says whether a target repository would still receive a
working kit. That command now exists; most of the lines below are defects it
reports rather than fixes. Three are not: the license, the graph policy and
the queue's front door, which are friction the process itself produces and
no check would catch. Before it, the answer came from installing into a scratch
directory by hand and looking, which is why they went unnoticed until the
documents were written.

```
[x] kit-selftest              one command that parses, installs into a scratch repository, runs doctor,
                              repeats to prove idempotency, checks the three SKILL.md frontmatters,
                              greps for the em dash and diffs the dogfood copies
[x] graph-rebuilds-on-demand  graphify-out/ stops being versioned and /propose and /apply ensure the graph
                              instead, so the post-commit hook no longer leaves the worktree dirty after
                              every delivery
[x] open-source-license       AGPL-3.0-only verbatim so GitHub detects it, the notice line in every
                              kit-owned file and in the CLI's header, and README saying what a target
                              repository's own documents are and how to ask for other terms
[x] help-text-follows-header  focus-kit --help prints the whole header, however long it grows;
                              today sed -n '2,27p' is a literal the next header line makes wrong
[x] graphify-mcp-starts       install adds the mcp extra of graphifyy and doctor sees when it is
                              missing; today graphify-mcp dies with ImportError on every machine
[x] selftest-reads-the-merged-json
                              check 2 reads the two merged files and merge_json dies when no
                              python runs; today a die inside $(python_bin) leaves selftest green
                              over an .mcp.json that reads {}
[x] version-bump-ends-with-install
                              any delivery that bumps VERSION ends with focus-kit install ., and
                              check 6 compares the installed version with VERSION; today the
                              dogfood copy is one version behind and only doctor notices
[x] windows-git-bash          the kit runs from Git for Windows: LF through .gitattributes, a
                              python that is probed rather than found, UTF-8 and LF from the
                              merge, --no-project on the uv fallback, and the docs name WSL and
                              Git Bash; proven on the Windows host over SSH. MSYS did not rewrite
                              the expression argv, so merge-json-by-argument keeps only its own reason
[x] version-stamp-tolerates-cr
                              doctor and check 6 strip a trailing carriage return from
                              .focus-kit-version; a target cloned on Windows with core.autocrlf=true
                              gets a CRLF stamp and doctor warns that 0.5.0 is not 0.5.0. Found by
                              windows-git-bash, which fixes it here through .gitattributes and
                              cannot fix it in a target, because no .gitattributes is shipped
[x] merge-json-by-argument    the settings baseline reaches python3 as data, not interpolated
                              into the source it execs; a quote in the JSON breaks the install
[x] doctor-reports-drift      doctor says when a kit-owned file in a target was edited locally,
                              so the person knows update is about to overwrite their edit
[x] manifest-is-the-whole-list
                              two green lines printed without reading the manifest to the end:
                              doctor skips a manifest entry whose file is gone, so deleting one of
                              the ten templates leaves it green, and check 6 excludes the manifest
                              from its diff, so a stale dogfood manifest commits with selftest green
```

Close of milestone 1: the whole-branch review (`docs/05-Process.md` §9) ran
and produced the line above, which is the last one.

## Milestone 2: the kit used on something real

When this milestone closes, the kit has been through a full cycle on a
repository that is not itself: installed, initialized, one delivery proposed
and applied end to end, and every piece of friction found on the way brought
back here as a queue line. Until that happens, every claim the kit makes
about brownfield repositories is untested.

```
[x] first-target-install      install into a real repository and record what doctor missed
[x] doctor-sees-a-stale-skill install and doctor print the global /graphify skill green whatever version
                              it is; graphify says on every invocation that the skill is from 0.9.10 and
                              the package from 0.9.63, and ensure_graphify drops that stderr while doctor
                              asks only whether SKILL.md exists
[ ] doctor-checks-settings-json
                              doctor has no line for .claude/settings.json, the file install writes and
                              the one that carries enabledMcpjsonServers, without which the server in the
                              .mcp.json it does report is never enabled; check 2 reads both merged files
                              in the scratch and a real target's doctor asks neither question
[ ] every-warn-names-its-fix  the eight warns for docs/00 to 06 and CLAUDE.md end at "missing", while
                              every other warn doctor prints names its command in parentheses; after a
                              green install the person infers alone that eight of the ten are the normal
                              state of a target /initialize has not run in
[ ] first-target-initialize   run /initialize there and record every question it should have
                              asked, and every one it asked that the code could have answered
[ ] first-target-delivery     one delivery through /propose and /apply, start to finish
```

## Milestone 3: the kit explains itself

When this milestone closes, a person who has never heard of focus-kit reads
`README.md` and knows, before the first command, what problem it solves, what
they get for it and what it costs them. Today the README is a manual: it says
what gets installed and how the process runs, and it leaves the reader to
infer why. The README speaks about the kit and the problems it solves, and
names no company, no engagement and no reader in particular.

The case rests on four problems every engineering organization
recognizes, each answered by a mechanism the kit already has and a path where
it lives. **Onboarding costs effort**: living documentation, generated by the
work itself, in `docs/00` to `06` and `docs/adr/`; whoever arrives reads
seven files instead of scheduling seven conversations, and the queue shows
what comes next. **Tools are used unevenly** between people and squads: one
process versioned with the code, three commands that are the same in every
repository, and house rules that are not voted per project, in
`.claude/skills/` and `docs/manuals/`. **Task context is fragmented**: the
context lives in a file, `work/<slug>.md`, not in a conversation, so model,
tool or person can change mid-way without losing anything, and a scope that
does not fit one page is two deliveries. **Knowledge and decisions are
distributed**: `work/done/<slug>.md` records what was built, how and why,
what diverged and what was dropped, and what is expensive to reverse becomes
an ADR. Three more points carry the argument. The gain is larger on
brownfield, where `/initialize` reads before asking and writes what exists
and what is wanted as separate things. The slug ties the process to git with
no extra effort: one branch, one pull request whose description points at
the delivery page, one commit with the slug as scope, while the git policy
itself stays a slot in the target's `docs/05` §7. And the artifacts are plain
markdown, readable by any assistant: the commands run in Claude Code today,
and the port to GitHub Copilot is a line below, so the README may promise it
by pointing there. Everything the README says in the first screen is checked
against `docs/00-Product.md`, and one thing there has to change in the same
delivery: the Audience section says the kit is for one developer and
explicitly not for a lead rolling out a process, while the case above is the
organizational one. The developer who commits stays the primary reader; the
organization that wants one practice across teams becomes a declared
audience. Ninjobs stays as the proof, after purpose and benefits. The
selftest greps `README.md` for the em dash, so nothing arrives with one.
None of this bumps `VERSION`: the README and `docs/00` are this repository's
own documents.

```
[ ] discuss-adds-queue-line   /discuss takes a description and, by conversation, writes one line
                              where it belongs in the queue, and a term in docs/03 if the concept
                              is new; today an idea outside the queue is a page too early through
                              /propose or a hand edit with no placement. Fourth skill: selftest
                              check 4 and every "three" in the docs stop being literals
[ ] git-branches-are-queue    support automatic optional creation of branches in /propose                              
[ ] readme-makes-the-case     README opens with the problem (deciding and doing in one conversation,
                              scope grows, context and reasons vanish) and the answer (two sessions,
                              one page), then the four problems above as a table of problem, mechanism
                              and path, greenfield and brownfield, the slug in git, portable markdown
                              with Copilot pointing at copilot-port, then Ninjobs; docs/00 Audience
                              widened in the same delivery
[ ] readme-real-walkthrough   a four-step section, install, /initialize, /propose, /apply, every
                              transcript taken from a real run in a scratch repository on a fictional
                              domain, condensed only by cutting lines, never by inventing one; each
                              step ends with what it produced and why that matters (documentation
                              born from the code, no code yet, clean session, a person commits)
[ ] copilot-port              the three commands as GitHub Copilot repository instructions and
                              reusable prompts, installed by focus-kit install alongside the skills,
                              same ownership rules; docs/00 Positioning stops naming Claude Code as
                              the only host, and the README promise made in readme-makes-the-case
                              becomes true. Hooks are necessary and available on copilot?
[ ] codex-port                the three commands as Codex repository instructions and
                              reusable prompts, installed by focus-kit install alongside the skills,
                              same ownership rules; docs/00 Positioning stops naming Claude Code as
                              the only host, and the README promise made in readme-makes-the-case
                              becomes true. Hooks are necessary and available on codex?
[ ] update-alert              alert users when new versions are available on github so the user can
                              update (and run `focus-kit update`)
```

`readme-makes-the-case` depends on nothing here and can be pulled ahead of
milestone 2. `readme-real-walkthrough` is cheaper after milestone 2, because
every piece of friction found there would otherwise appear in the transcript
the README shows. `copilot-port` is a contract change for every target and
touches `install`, `doctor`, `selftest` and the ownership table; its
`/propose` settles how the prompts are versioned and whether `update`
overwrites them like the skills.

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
* The gitignore fragment in a target that installed an earlier version.
  It is appended once and guarded by its marker, so `update` deliberately
  leaves it alone and a target keeps whatever block it first received.
  `graph-rebuilds-on-demand` is the first time the block's content changed,
  and every target that predates it edits `.gitignore` by hand. Related to
  the line below, but a different mechanism: that one overwrites, this one
  refuses to.
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

1. **Does the kit get a test suite beyond `selftest`?** `kit-selftest`
   shipped as six checks inside `bin/focus-kit`. If the answer is a real
   suite, with a framework and cases per function, that is new lines in this
   queue, not a change to the ones already here. Decides: the stakeholder.
2. **Do the dogfood copies stay versioned?** If they stop being versioned,
   check 6 of the verify command and the second row of the environments
   table both disappear. Decides: the stakeholder.
3. **How is the kit distributed?** Everything under "Later" about
   installers and packages waits on this. Decides: the stakeholder.
