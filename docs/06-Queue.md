# Queue

One line per delivery, in order. The mark says where it stands:
`[ ]` not yet defined · `[>]` defined, `work/<slug>.md` exists, not yet
built · `[x]` done, in `work/done/`. The process is `docs/05-Process.md`.

The order starts at the first milestone. A `[ ]` line under "Later, not
scheduled" sits outside it: a delivery that is wanted and not ordered,
which `/discuss` moves into a milestone when a paragraph admits it.

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
[x] doctor-checks-settings-json
                              doctor has no line for .claude/settings.json, the file install writes and
                              the one that carries enabledMcpjsonServers, without which the server in the
                              .mcp.json it does report is never enabled; check 2 reads both merged files
                              in the scratch and a real target's doctor asks neither question
[x] every-warn-names-its-fix  the eight warns for docs/00 to 06 and CLAUDE.md end at "missing", while
                              every other warn doctor prints names its command in parentheses; after a
                              green install the person infers alone that eight of the ten are the normal
                              state of a target /initialize has not run in
[x] first-target-initialize   run /initialize there and record every question it should have
                              asked, and every one it asked that the code could have answered
[x] graph-cost-is-confirmed   the graph procedure's first branch spends the session's tokens with no
                              number shown and no question asked; docs/manuals/graphify.md says the cost
                              is declined in /graphify, which measured 44,185 words, applied a threshold
                              of its own and extracted 433,524 input tokens without asking
[x] graph-staleness-without-a-stamp
                              a graph built through that first branch writes a GRAPH_REPORT.md with no
                              Built from commit line, so the third branch of the same procedure can never
                              be evaluated in exactly the repositories that took the first, and every
                              /propose and /apply there decides alone whether the graph is stale
[x] graph-ignores-the-kit     install leaves a .graphifyignore in the target, appended once, that keeps
                              the six kit-owned files out of the graph; measured before, 214 of
                              the first target's 498 nodes and 139 of this repository's 487 came from the
                              kit's own files, and a query for a rule came back as manual headings
[x] mcp-leaves-the-baseline   the graphify MCP server is declared in .mcp.json, spawned every session and
                              named by nothing the kit ships: the three skills call the CLI, and 38
                              sessions here plus 347 in two targets made zero MCP calls; the server, its
                              baseline, the enabledMcpjsonServers entry, the mcp extra and the doctor and
                              check 2 lines that read them back leave, twelve places
[x] graph-answers-structure   the skills ask the graph "what this delivery touches" and expect slices,
                              entities and rules; measured, that question comes back as every function of
                              the one code file plus headings, while `graphify path` answers a call in one
                              hop, and 18 of 21 consulting sessions grepped first anyway; /initialize brown
                              reads god nodes and communities once, /apply asks structure, /propose stops
                              promising rules
[x] initialize-asks-for-the-proof-tool
                              the brownfield path fills docs/05 §6 with viewports, themes and references
                              read off the repository and leaves out the tool, the one part of that slot
                              no file can answer; round 4 of the skill's list and the template's own
                              comment both name it, and /apply reaches "screenshot the changed screen"
                              with nothing that takes one
[x] every-term-enters-03-first
                              nothing in /initialize checks the queue it writes against the terms table
                              it wrote first, so docs/06 named VaultRepository, LoadResult and SaveResult
                              while docs/03 said of itself that no delivery may name in code a concept
                              that is not in the table
[x] first-target-delivery     one delivery through /propose and /apply, start to finish
[x] propose-asks-only-what-no-file-answers
                              /propose asked which test libraries to install when the queue line it was
                              expanding named one package and docs/04 §5 said when each of the others
                              arrives; it had read both files and quoted the rule from one of them inside
                              the option text, and still put a decided matter in front of a person
[x] propose-ends-by-naming-the-next-session
                              /propose ends at "/apply <slug> implements" and skills/propose/SKILL.md has
                              no closing section at all, so the person types /apply in the same session;
                              the kit asks for a clean session in three places and says it in none of
                              them at the moment the person decides where to type, and the graph is the
                              first casualty: /apply reused a freshness check another command had run in
                              that session and never asked the graph at all
[x] propose-does-not-fix-what-it-cannot-run
                              /propose pins in the Contract tooling detail only a run can verify, so npm
                              resolved vitest@5.0.1 against the project's @types/node@^20 and /apply had
                              to ask; the page had pre-answered the conflict in the wrong direction and
                              contradicted its own "one devDependency and nothing else", and the same
                              pattern turned vitest.config.ts into .mts
[x] propose-holds-no-fact-the-run-rechecks
                              the Contract stopped holding versions, config file names and guesses, and
                              still holds a fact measured while the page was written: the first target's
                              testing-setup page dated the runner's engines range "checked 2026-09-17"
                              and moved a Node pin on it, which /apply rechecks and which is stale the
                              day the runner publishes; the same run took the read-only probe the rule
                              before this one left out of scope, one occurrence, recorded and not counted
[x] commands-read-sections-not-manuals
                              measured over 194 sessions, the kit costs no more per session than the
                              hand-written original it came from: the first turn is 42k to 49k tokens in
                              ninjobs, here and in the first target alike, and a kit /apply runs 105
                              turns to a 240k peak against 280 turns and 530k there; what every session
                              pays for nothing is a manual read whole for one section, graphify.md
                              (2,626 words) for §Ensuring the graph in all three commands and focus.md
                              (5,152) in every /apply, while skills/propose grew from 67 words to 932;
                              the skills name the section they need, the page records the before and
                              after per command, and docs/00 gets the number, so the next comparison
                              with OpenSpec or SpecKit is measured and not feared
[x] focus-is-asked-not-imposed
                              FOCUS is a house rule (docs/manuals/process.md §7, the CLAUDE.md template,
                              /apply Build) and /initialize never asks: the first target's docs/01 wrote
                              a features/ target layout and a migration line per slice into a repository
                              that never chose it, and the project the kit came from removed the four
                              pieces on purpose (ninjobs CLAUDE.md, Não reconstruir, ADR-0022); the
                              person may never have heard of FOCUS, so /initialize asks one question per
                              practice, brownfield and greenfield, each explained in a line with FOCUS's
                              answer first and, on brownfield, what the code does today as an option:
                              vertical slices or layers, rules in pure use cases behind an orchestrator
                              or wherever they sit today, errors as values or exceptions as flow, a test
                              per piece or the project's own test policy; the answers become a table in
                              docs/01 §3 that /propose and /apply read for which pieces a slice has and
                              what they may assume, FOCUS is the name for saying yes to all of them, and
                              it leaves the house rules for the manual that teaches it
[x] language-question-says-what-it-governs
                              /initialize Step 0 offers English and Portuguese and says in the option
                              text only that identifiers stay in English; nothing tells the person that
                              the answer governs documents, delivery pages and commit messages and
                              nothing else, and that the conversation may run in another language, the
                              German developer on a project that requires English; the question says so
                              in its own text, and any language typed under Other is taken as written
[x] practice-questions-all-yes
                              two clauses of focus-is-asked-not-imposed shipped without a run behind
                              them: the CLAUDE.md template's FOCUS line, which replaces the four
                              practice lines when all four answers are the manual's, and the
                              two-patterns disclaimer, the line /initialize says on a brownfield
                              repository before the person answers. Three runs on 2026-09-17 answered
                              no to at least one practice each, so the first branch was never taken,
                              and the disclaimer was not in what any of them captured. One scratch
                              answering yes four times closes both
[x] doctor-sees-an-unbumped-change
                              a target can hold a kit-owned file that differs from the kit source while
                              doctor reports everything green, because the version compare is by number
                              and the drift compare is against the manifest that install itself wrote:
                              both agree with each other and neither is asked about the source. Measured
                              on 2026-09-17 during focus-is-asked-not-imposed: focus-kit update ran on
                              ~/Downloads/vaulted, skills/initialize/SKILL.md then changed without a
                              VERSION bump, and the review run there asked four questions in a shape the
                              kit no longer had, with doctor saying kit-owned files as install wrote
                              them and the version equal. It is reachable by anyone who updates a target
                              mid-delivery, and the fix is doctor's alone: the kit source is on the
                              machine when doctor runs in this repository, and never is when it runs in
                              someone else's, so the line says which of the two it can answer
[x] review-run-finds-a-translated-practice-table
                              /initialize detects a docs/01 §3 that already answered the four practices
                              by the literal header row Practice | Answer | Here it is, and the Language
                              section tells the same run to translate table columns as it fills the
                              templates. On the greenfield proof of language-question-says-what-it-governs,
                              2026-09-17, a run in German wrote Praktik | Antwort | Hier ist sie, so a
                              later review run in that repository will not recognize the table and will
                              ask the four Practice questions again. The two rules contradict each other
                              and one of them gives way: a marker that survives translation, or a header
                              the translation rule excepts
[x] asked-as-written-says-which-language
                              /initialize says of the Language question, the four Practice questions
                              and the Proof tool question that each is written once and asked as
                              written, and gives the two-patterns disclaimer and the no screen line
                              as fixed text; of none of the five does it say whether the wording
                              survives a conversation in another language. Measured on 2026-09-17 in
                              the scratch of practice-questions-all-yes, one session did both: the Language
                              question came out in its full English wording and the four Practice
                              questions, the two-patterns disclaimer and the no screen line came out
                              translated. Neither is wrong against the file, so two runs of the same
                              command differ and a record quoting one cannot be compared with the
                              other; the rule says which, or it stops saying as written
[x] initialize-trusts-the-argument
                              Step 0 contradicts itself on the argument: line 66 says that if
                              $ARGUMENTS says green or brown, trust it, and line 89 says of the kind
                              of project, inside the one AskUserQuestion that also carries the
                              language, to say which was detected and let them confirm. Measured on
                              2026-09-17 in the scratch of review-run-finds-a-translated-practice-table:
                              the run was started with /initialize green, asked the question anyway,
                              and the description of the option it recommended cited the argument it
                              was reconfirming. The run obeyed the text. One of the two lines gives
                              way: the argument answers the question and the AskUserQuestion carries
                              the language alone, or the argument is a detection like any other and
                              line 66 stops saying trust it
[x] as-written-covers-a-literal
                              a text the source sets off as a literal is reproduced byte for byte
                              instead of being said in the conversation's language, and the two
                              rules that should forbid it say nothing about the case. Measured on
                              2026-09-17 in the scratch of asked-as-written-says-which-language, one
                              Portuguese session, the kit at 0.22.2 with the Language section's new
                              paragraph in place: the no screen line, written in backticks in
                              skills/initialize/SKILL.md, came out in English inside a Portuguese
                              sentence, while the two-patterns disclaimer beside it, written as
                              prose, came out translated; and the Graph confirmation of
                              manuals/graphify.md asked its question in Portuguese with its three
                              option labels, written in bold, still reading Build now, Code only and
                              Not now. Same shape twice, in the two files, so one of two things
                              gives way: the two rules say what a backtick and a bold mean in a text
                              that is asked as written, or the five texts and the confirmation stop
                              being written with marks that read as bytes to reproduce
[x] run-ignores-a-stray-word  a word typed after /initialize is explained back to the person, although
                              nothing in the skill names an argument any more. Measured on 2026-09-17
                              in the second scratch of initialize-trusts-the-argument, the kit at
                              0.22.3: /initialize green produced the same count line and the same kind
                              question as the bare run, and one paragraph more, naming the word that
                              was typed and saying it was not taken as an early confirmation. Removing
                              the rule left the word unexplained by the file and not unmentioned by the
                              run, which is what initialize-trusts-the-argument assumed would follow.
                              So the skill says what a word after the command is worth, or it says
                              nothing and the run is left to invent this paragraph again
```

## Milestone 3: the queue and git place the work

When this milestone closes, an idea reaches the queue as one line in the
milestone it serves, written in conversation and not as a page opened too
early or a hand edit with no placement, and the repository says which git
strategy a delivery works by, so `/propose` and `/apply` stop inventing the
branch, the worktree or the absence of both. Neither is a defect a check
reports: both are friction the process itself produces, the first found when
the queue grew past what one paragraph admitted, the second when two
deliveries shared one working tree on 2026-09-18 and `git add -A` of one
staged the other's page.

```
[x] discuss-adds-queue-line   /discuss takes a description and, by conversation, writes one line
                              where it belongs in the queue, and a term in docs/03 if the concept
                              is new; today an idea outside the queue is a page too early through
                              /propose or a hand edit with no placement. Fourth skill: selftest
                              check 4 and every "three" in the docs stop being literals
[x] queue-line-finds-its-place
                              every milestone is named and carries a paragraph saying what closes it, so
                              a line that arrives later never looks like it belongs: milestone 1's
                              paragraph was widened by hand to admit three lines, milestone 2's carries
                              a clause for every friction found, and the three lines that closed
                              milestone 2 on 2026-09-17 were placed in conversation; Later, not
                              scheduled becomes a block of [ ] lines, in the template and here, and
                              /discuss places a line in the milestone whose paragraph it serves, amends
                              the paragraph when the line serves it and it does not say so, or leaves
                              the line in Later, and proposes a milestone when three Later lines share
                              a purpose; docs/manuals/process.md §8 says so. After discuss-adds-queue-line
[ ] ~~git-branches-are-queue~~
                              superseded by git-strategy-is-asked, which covers the branch, the
                              worktree and none, and is asked by /initialize rather than assumed
[x] git-strategy-is-asked     /initialize asks which of three git strategies the repository works
                              by, a worktree per delivery, a branch per slug, or none, and writes
                              the answer into docs/05 §7 for /propose and /apply to act on: the
                              worktree or the branch made when the delivery starts, and on none the
                              staged tree, the suggested message and the merge command named, since
                              the agent never commits whatever the policy says (docs/00, Building
                              it). The git slot is prose today, so every /initialize invents the
                              question, and the worktree is the one of the three the kit cannot do
                              at all. Supersedes git-branches-are-queue, which covers the branch
                              alone and is struck through with that reason when this one is
                              proposed. Measured here on 2026-09-18: /apply discuss-adds-queue-line
                              ran while a /propose of another line changed docs/03 and docs/06
                              under it, and both delivery pages sat uncommitted in one tree, so
                              git add -A of one staged the other's page
```

`queue-line-finds-its-place` needs the fourth skill `discuss-adds-queue-line`
ships, and is the first thing that skill does once it exists.
`git-strategy-is-asked` depends on neither: it is a question `/initialize`
asks and a slot the two other commands read.

## Milestone 4: the kit reaches the targets it left behind

When this milestone closes, `focus-kit update` in a repository installed
several versions ago lands without costing that repository anything it did
not choose: it does not erase an edit the person made without warning them
first, it does not leave a fragment that a later version rewrote, and it
does not leave a document pointing at a section that has moved. Today all
three are true of any target that is more than a few versions behind, and
the only reason nobody has paid for it is that the kit has one target that
is not itself. Proposed out of three lines that sat under Later and shared
that purpose (`queue-line-finds-its-place`, the `/discuss` run that proved
it).

```
[>] skill-says-it-is-kit-owned
                              a kit-owned banner on each SKILL.md. The manuals carry one on
                              their first line; a skill cannot, because that line is YAML
                              frontmatter. Someone editing a skill inside a target gets no
                              warning that the next update erases it
                              (docs/adr/ADR-0002-file-ownership.md)
[>] an-old-target-gets-the-fragment
                              the gitignore fragment in a target that installed an earlier
                              version. It is appended once and guarded by its marker, so update
                              deliberately leaves it alone and a target keeps whatever block it
                              first received. graph-rebuilds-on-demand is the first time the
                              block's content changed, and every target that predates it edits
                              .gitignore by hand. Related to update-survives-a-moved-section,
                              but a different mechanism: that one overwrites, this one refuses to
[>] update-survives-a-moved-section
                              a kit-owned file in a target that changed shape between versions:
                              today update overwrites and a target's documents may reference a
                              section that moved. Blocked on open decision 5
```

## Milestone 5: the kit is 1.0

When this milestone closes, the kit is presented and ported once, over a kit
that has stopped moving underneath it: a person who has never heard of
focus-kit reads `README.md` and knows, before the first command, what problem
it solves, what they get for it and what it costs them; the same commands run
under GitHub Copilot and under Codex, installed and owned the way the skills
are; and a target installed several versions ago learns that a new one exists
instead of waiting for someone to check. Four of the five describe or
replicate the whole kit, so any change to a skill, a manual or the CLI
rewrites part of each; the fifth, the alert, is worth shipping once the
versions it announces stop arriving with every delivery. That is why they are
last: everything the queue plans is built first, these five are done once,
and that is what makes the version 1.0.

The README's case rests on four problems every engineering organization
recognizes, each answered by a mechanism the kit already has and a path where
it lives. **Onboarding costs effort**: living documentation, generated by the
work itself, in `docs/00` to `06` and `docs/adr/`; whoever arrives reads
seven files instead of scheduling seven conversations, and the queue shows
what comes next. **Tools are used unevenly** between people and squads: one
process versioned with the code, the same commands in every
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
itself stays a slot in the target's `docs/05` §7, filled by the question
`git-strategy-is-asked` adds. And the artifacts are plain markdown, readable
by any assistant: the commands run in Claude Code today, and the two ports
are lines below, so the README may promise them by pointing there. Today the
README is a manual: it says what gets installed and how the process runs, and
it leaves the reader to infer why. It speaks about the kit and the problems
it solves, and names no company, no engagement and no reader in particular.
Everything it says in the first screen is checked against
`docs/00-Product.md`, and one thing there has to change in the same delivery:
the Audience section says the kit is for one developer and explicitly not for
a lead rolling out a process, while the case above is the organizational one.
The developer who commits stays the primary reader; the organization that
wants one practice across teams becomes a declared audience. Ninjobs stays as
the proof, after purpose and benefits. The selftest greps `README.md` for the
em dash, so nothing arrives with one. The README and `docs/00` are this
repository's own documents and bump no `VERSION` on their own; the two ports
and the alert do, because a target receives files and behaviour it did not
have.

```
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
[ ] copilot-port              the kit's commands as GitHub Copilot repository instructions and
                              reusable prompts, installed by focus-kit install alongside the skills,
                              same ownership rules; docs/00 Positioning stops naming Claude Code as
                              the only host, and the README promise made in readme-makes-the-case
                              becomes true. Hooks are necessary and available on copilot?
[ ] codex-port                the kit's commands as Codex repository instructions and
                              reusable prompts, installed by focus-kit install alongside the skills,
                              same ownership rules; docs/00 Positioning stops naming Claude Code as
                              the only host, and the README promise made in readme-makes-the-case
                              becomes true. Hooks are necessary and available on codex?
[ ] update-alert              alert users when new versions are available on github so the user can
                              update (and run `focus-kit update`)
```

`readme-real-walkthrough` follows `readme-makes-the-case`, because the
transcript it shows is of a kit the case has already described, and every
piece of friction found before this milestone would otherwise appear in it.
`copilot-port` is a contract change for every target and touches `install`,
`doctor`, `selftest` and the ownership table; its `/propose` settles how the
prompts are versioned and whether `update` overwrites them like the skills,
and `codex-port` follows whatever it decides.

## Later, not scheduled

```
[ ] ~~dogfood-copies-out-of-the-graph~~
                              done by graph-ignores-the-kit: .graphifyignore and
                              config/graphifyignore.fragment hold the kit-owned paths, so the
                              first build's mirrored communities and its 42 weakly connected
                              nodes cannot come back
[ ] uninstall-removes-the-kit remove the kit-owned files and unmerge the one JSON key the
                              settings baseline adds, so a repository can stop using the kit
                              without unpicking it by hand. mcp-leaves-the-baseline is the
                              first time the question was real and the answer was a warn and
                              not a mechanism: a second entry the kit stops shipping is what
                              earns this line its delivery
[ ] help-names-what-install-writes
                              the script's header comment does not name .graphifyignore among
                              what install writes, although graph-ignores-the-kit made it one
                              of the seven, and --help prints that header verbatim, so the
                              usage text is one line short of the truth. Found by
                              mcp-leaves-the-baseline, which edited the same block and left it
                              alone rather than widen its scope
[ ] distribution-beyond-clone distribution beyond clone and symlink: a curl installer, or a
                              package. Blocked on open decision 3
[ ] manuals-follow-the-language
                              translated manuals, so a target documenting itself in another
                              language does not receive three English manuals. Blocked on open
                              decision 4
[ ] git-policy-for-a-second-person
                              a second person working in this repository, which is what would
                              make the trunk-only git policy in docs/05-Process.md §7 worth
                              revisiting
[ ] every-paragraph-admits-its-lines
                              every milestone paragraph is rewritten until it says what actually
                              closes that milestone and admits the lines already under it, so the
                              placement rule queue-line-finds-its-place shipped decides the queue
                              as it stands and not only what arrives next. No line moves and the
                              order is untouched: what is wrong today is the paragraphs, not the
                              placements. Measured here on 2026-09-18: milestone 1's was widened by
                              hand to admit three lines and milestone 2's grew a clause for every
                              friction found. The third measurement of that day, milestone 3's
                              paragraph carrying git-strategy-is-asked, copilot-port, codex-port and
                              update-alert without naming them, was resolved the same day by the move
                              that opened milestone 5 and rewrote milestone 3 around what stayed
```

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
