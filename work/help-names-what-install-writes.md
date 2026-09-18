# help-names-what-install-writes

**Goal.** A person who types `focus-kit --help` reads every path an install
writes into their repository, including the two the usage text does not name
today.

**Behaviour.**

* `focus-kit --help` names `.graphifyignore` and says it is a kit fragment
  appended once, beside the `.gitignore` line it already has.
* `focus-kit --help` names `.claude/skills/.focus-kit-version` and says which
  version is installed and that `doctor` reads it, in the words the manifest
  line beside it already uses.
* Every path `install_repo` writes into a target appears in the usage text,
  and each one says what it is and how it is written.
* `focus-kit help`, `focus-kit -h` and `focus-kit` with no argument print the
  same block, because they are one case of the dispatch.
* `docs/04-Conventions.md` §1 says the header names every path `install`
  writes, so the next delivery that makes `install` write something new knows
  the header line is part of it.
* `bin/focus-kit selftest` comes back green, unchanged: a comment changes no
  behaviour any of the six checks reads.

**Contract.** The header comment of `bin/focus-kit`, which is the usage text
(`docs/04-Conventions.md` §1: `--help` prints it through `awk`, by a rule and
not a range, so documentation and usage are the same bytes). Item 2 gains two
lines and loses none, each in the position `install_repo` writes it: the stamp
after the skills line it sits under, `.graphifyignore` after the `.gitignore`
line it is appended beside. Item 2 reads, in full, `#` and six spaces, then the
path in a field 44 characters wide, then the description, which is the
alignment the block already has and which neither new path widens, since
`docs/manuals/{process,focus,graphify}.md` stays the longest at 40:

```
#   2. in the target repository:
#      .claude/skills/<command>/                   copied, overwriting (kit-owned)
#      .claude/skills/.focus-kit-version           which version is installed, for doctor (kit-owned)
#      docs/manuals/{process,focus,graphify}.md    copied, overwriting (kit-owned)
#      .claude/skills/.focus-kit-manifest          what install wrote, for doctor (kit-owned)
#      .claude/settings.json                       baseline permissions merged in
#      .gitignore                                  kit fragment appended once
#      .graphifyignore                             kit fragment appended once
#      work/done/.gitkeep                          created if absent
```

*The rule that keeps it true.* One bullet in `docs/04-Conventions.md` §1,
beside the one that already says the help text is the script's own header: the
header names every path `install` writes into a target, so a delivery that
makes `install` write a new one writes that line in the same delivery. A rule
and not a seventh check, for two reasons that are facts and not preferences.
The only enumeration of what `install` writes outside `install_repo` itself is
its own `ok` lines, and the stamp has none: `bin/focus-kit:402` writes it
silently under the skills line, so a check comparing the `ok` output with the
header would have missed exactly the omission this delivery found. And a
seventh check turns "six" into an edit in `docs/05-Process.md` §4,
`docs/03-Domain.md` (Verify command), `docs/01-Architecture.md` §2 and §3,
`docs/00-Product.md` (open decision 1) and line 9 of the header itself, the
shape `discuss-adds-queue-line` already paid for "three". The rule is
pointable by a reviewer on screen, which is what `docs/00-Product.md` product
question 1 asks of a rule.

*The same omission in this repository's own prose.* Two sentences describe
what `install` writes and leave something out, and both are corrected here
because the delivery has them open and the defect is the same one. The
`install_repo` row of `docs/01-Architecture.md` §3, whose list runs "skills,
manuals, the manifest, `work/done/`, the one JSON merge, the two appended
fragments, the closing message", gains the Installed version. The "In the
repository" paragraph of `docs/00-Product.md`, Installing, gains the Installed
version and the Manifest, which it omits both. Those two additions and nothing
else in either sentence. The rule written above binds the header and not these
two: they are this repository's own prose, not the text a user of the CLI
reads.

*`VERSION`.* Bumped, in its patch component, because the CLI's behaviour is a
change a target repository would want (`docs/03-Domain.md`, The kit,
invariants) and `--help` is behaviour. The cost the rule accepts is named
rather than avoided: `bin/focus-kit` is never copied into a target, so no
kit-owned file there changes, every target reports stale by number and
`focus-kit update` rewrites identical bytes. The dogfood install follows the
bump (`CLAUDE.md`, How to work; `docs/05-Process.md` §5), or check 6 goes red.

**Slice.** `bin/focus-kit`, the whole CLI, one file
(`docs/01-Architecture.md` §3, Structure: neither slices nor layers). No View,
no Orchestrator, no Use case and no Repository: §3's second table says none of
the four exists here, so none is named. The graph named one file both ways:
`explain "install_repo"` returned 12 edges and `affected "install_repo"` four
callers, all in `bin/focus-kit`; the header comment has no node, because the
graph holds edges and a comment is text. Kit-owned: `bin/focus-kit`, in the
sense the row of `docs/03-Domain.md` ends on, edited in this repository and
nowhere else, which is what `work/copilot-port.md` already says of the same
file. It is never copied into a target, so nothing there changes; the two
paths it gains name a Kit-owned file and an Appended once file. Project-owned:
`docs/04-Conventions.md`, `docs/01-Architecture.md`, `docs/00-Product.md` and
`docs/06-Queue.md`.

**States.** The defaults. `--help` has no branch: one `awk` over the script's
own header, reached by `""`, `-h`, `--help` and `help` alike, and it neither
reads a target nor touches the network.

**Visual reference.** What `focus-kit --help` prints for item 2, the block
above with the `#` and one following space removed from each line, which is
the `awk` rule:

```
  2. in the target repository:
     .claude/skills/<command>/                   copied, overwriting (kit-owned)
     .claude/skills/.focus-kit-version           which version is installed, for doctor (kit-owned)
     docs/manuals/{process,focus,graphify}.md    copied, overwriting (kit-owned)
     .claude/skills/.focus-kit-manifest          what install wrote, for doctor (kit-owned)
     .claude/settings.json                       baseline permissions merged in
     .gitignore                                  kit fragment appended once
     .graphifyignore                             kit fragment appended once
     work/done/.gitkeep                          created if absent
```

**Out of scope.**

* Item 3 of the header, which says `install` prints the next step and names
  Claude Code while `install_repo` prints one of two messages. Both halves are
  claimed by `copilot-reads-the-project-rules`
  (`work/copilot-reads-the-project-rules.md:67`), which stops the header
  naming one host and is in flight.
* The Ported command line item 2 gains when `copilot-port` lands. That page
  owns what `install_repo` starts writing; the rule written here is what makes
  the header line part of it, and whichever of the two lands second writes it.
* A seventh check of `selftest`, for the two reasons in the Contract.
* `install_repo`'s own `ok` lines, and the stamp's silence among them. A
  different text with a different reader, and no line of this delivery depends
  on it.
* Any change to what `install` writes. The delivery corrects a description and
  adds a rule; the behaviour it describes is already what the script does.

**Done when.**

* `focus-kit --help` prints the block in Visual reference, the two new lines
  included, column-aligned with the six already there.
* `bin/focus-kit --help | grep -cF '.graphifyignore'` and `bin/focus-kit
  --help | grep -cF '.focus-kit-version'` each print `1`.
* `docs/04-Conventions.md` §1 carries the bullet naming the header's
  obligation.
* `docs/01-Architecture.md` §3's `install_repo` row names the Installed
  version, and `docs/00-Product.md`, Installing, names the Installed version
  and the Manifest.
* `bin/focus-kit selftest` is green.
* `VERSION` bumped in its patch component.
* `focus-kit install .` run here, so the dogfood copy carries the new version
  (`docs/05-Process.md` §5).
* `docs/06-Queue.md` line marked `[x]` and the page moved to `work/done/`.
