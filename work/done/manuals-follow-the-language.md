# manuals-follow-the-language

**Goal.** A target that documents itself in a language other than English
reads the three manuals in that language.

**Behaviour.**

* `/initialize` in a target whose Documentation language is not English
  writes `docs/manuals/process.md`, `focus.md` and `graphify.md` in that
  language, and records the language in the target.
* Every section heading of a translated manual is still the English heading,
  so a Command asking for `§Ensuring the graph` finds it and `doctor`'s
  Manual citation pass still matches what `KIT_DIR` holds.
* `focus-kit doctor` in a target whose recorded language is not English and
  whose three manuals are still English says so in one line and names
  `/initialize`.
* `focus-kit update` writes the English manuals back over the translated
  ones, as it does over every kit-owned file, and the next `doctor` says so.
  `/initialize` run again translates them.
* `focus-kit doctor` in a translated target reports no Drift over the three
  manuals and nothing behind the kit source over them.
* A target whose Documentation language is English behaves exactly as it does
  today, and so does one that has no language record at all.

**Contract.**

* **The Manual language** (`docs/03-Domain.md`). One file in the target, one
  line, LF, holding an IETF BCP 47 language tag, which is an Identifier and
  so stays English whatever the Documentation language is. `en` for English.
  Written by `/initialize` at the step where it asks the Documentation
  language, and by nothing else; read by `doctor` and by nothing else.
  **Absent means `en`**, which is every target installed before this version,
  and is what keeps the delivery from changing any of them.
  **Project-owned**: `/initialize` writes it and the CLI only reads it, which
  is the category `docs/03` already defines, so the four categories stay
  four. Its path sits beside the Installed version and the Manifest, under
  `.claude/skills/`, which `copy_tree` never wipes because it overwrites
  `.claude/skills/<name>/` and not their parent.
* **The manuals stay Kit-owned**, with no change to what that means:
  `install` and `update` write English over them, and what translates them
  again is `/initialize`. There is no fifth ownership category.
* **The Manifest is untouched.** It goes on holding the fingerprint of the
  English file `install` wrote, so `write_manifest`, `install` and `update`
  need no edit and the Unbumped change pass keeps comparing the manifest with
  the kit source and agreeing with it.
* **`doctor`, Drift pass.** Where the recorded language is not `en`, the
  three `docs/manuals/*.md` entries are skipped by the fingerprint
  comparison, because the manifest holds the English file and the disk holds
  the translation. Everything else the manifest names is compared as today,
  and a manual the target does not have is still the missing shape, which the
  presence lines already print.
* **`doctor`, one new pass**, run only where the Manual language is not `en`,
  after the three manual presence lines: **one `warn` per manual** that is
  still the English file, and one `ok` when none is. One per manual and never
  a count, the way the Fragment gap and Manual citation passes already print
  one line per thing to fix, so a target with two translated manuals and one
  English still names the one. Each `warn` names `/initialize`, the way every
  other warn names its fix (`docs/04-Conventions.md` §1). Still English means
  **equal by `fingerprint` to the source at `KIT_DIR`**, which reuses the
  function and with it the `without_cr` tolerance, because a Windows target
  with `core.autocrlf=true` holds the untranslated English manual as CRLF
  against the kit's LF and a byte comparison would call it translated
  (`version-stamp-tolerates-cr`). Against `KIT_DIR` and not against the
  manifest, because the manifest answers whether a file was edited and this
  pass asks whether a translation ever happened.
* **`/initialize`.** One step, after the documents are written and before it
  closes: it writes the language record, and where the tag is not `en` it
  rewrites the three manuals in `docs/manuals/` in that language, the body
  translated and every heading left in English. A review run does the same
  for a manual that is still English and leaves a translated one alone. The
  Kit-owned banner and the License notice on a manual's first lines are
  carried over as written: they are the kit's own terms, a path and a URL,
  which is the closed list As written already holds, and one wording for the
  rule is what `docs/03` requires of the banner. The instruction is written
  once, in `skills/initialize/SKILL.md`.
* **Documents this delivery changes, in this delivery**: `docs/00-Product.md`
  (open decision 4 closed, and Initializing says the manuals follow the
  language), `docs/03-Domain.md` (Language of the interface, which says today
  that the kit's own strings are not translated; Project-owned; Drift;
  Translated manual), `docs/04-Conventions.md` §1, which says today that the
  kit's own text is never translated and that there is no translation
  mechanism, `docs/01-Architecture.md` §3, whose `doctor` row describes every
  pass, and `docs/adr/ADR-0002-file-ownership.md`, whose Project-owned bullet
  lists the paths and gains this one. ADR-0002 is amended and not superseded:
  no category is added, and the Drift bullet gains the exception.
* **One ADR**, at the next free number: the manuals follow the target's
  Documentation language; the headings stay English because a Command hangs
  on them and `doctor` matches a Manual citation against `KIT_DIR`; the
  translation is `/initialize`'s because the CLI is bash and python3 with no
  model; ownership is unchanged and the Drift pass is what gives way. It
  closes open decision 4 of `docs/00-Product.md`.

**Slice.** `docs/01-Architecture.md` §3 answers Structure with "neither
slices nor layers: one file", and its second table says the four FOCUS pieces
do not exist here, so none is named. What the delivery touches:
`bin/focus-kit`, in `doctor` alone; the Command `skills/initialize/SKILL.md`;
this repository's own `docs/`; and one new file under `docs/adr/`. Kit-owned:
the skill. Project-owned: the language record, the documents and the ADR.
Nothing merged and nothing appended once. The graph puts `install_repo`, the
dispatch, `check_install`, `check_idempotent`, `selftest` and `check_dogfood`
behind `copy_tree`, `write_manifest` and `fingerprint`; this delivery leaves
all three of those functions alone, which is why none of those callers
changes.

**States.** The four shapes, no new one (`docs/03-Domain.md`, Language of the
interface). Where the record is absent or `en`, `doctor` prints what it
prints today and the new line does not appear. Where the record names a tag
and a manual is missing, the presence line already says so and the new line
still asks its own question of the three that are there. Where the record
holds something that is not a tag, it is not `en`, so the manuals are
expected to be translated and the line asks the same question: no state reads
the tag for anything but the comparison with `en` and the text it prints.

**Visual reference.** No UI (`docs/05-Process.md` §3). The two lines
`doctor` gains, a `warn` and an `ok`, with the tag as the target recorded it:

```
docs/manuals/focus.md in English, not pt-BR (run /initialize to translate it)
docs/manuals (pt-BR)
```

**Out of scope.**

* The skills, the templates and every string `bin/focus-kit` prints: they
  stay English, and only the manuals change.
* The Ported commands of `copilot-port` and `codex-port`: they are generated
  from the English skills and stay English.
* Any translation by the CLI: `install` and `update` have no model.
* More than one language in one target: one record, one set of manuals.
* Catching a hand edit to a translated manual: Drift stops covering the three
  there, and `update` overwrites them anyway.
* Translating a heading: it is what every Command hangs on.
* Re-translating on `update`: `update` writes English, `doctor` says so, and
  what translates again is a full `/initialize`, which on a target that has
  `docs/00-Product.md` is a review run of every document. There is no
  translation-only entry into the command, and a lighter one is another line.

**Done when.**

* [x] `bin/focus-kit selftest` comes back green, six checks.
* [x] A real run (`docs/05-Process.md` §6): `/initialize` in a scratch repository,
  answering a Documentation language that is not English, leaves the three
  manuals in `docs/manuals/` in that language with every heading in English,
  and the language record holding that tag.
* [x] `focus-kit doctor` on that scratch prints the new `ok` line, no Drift over
  the three manuals and nothing behind the kit source over them.
* [x] `focus-kit doctor` on a scratch whose language is English prints what it
  prints today, line for line.
* [x] `VERSION` bumped and `focus-kit install .` run here, with check 6 of the
  verify command coming back empty (`docs/05-Process.md` §5).
* [x] Every document named in the Contract updated, and the ADR written.
* [x] `docs/06-Queue.md` line at `[x]` and this page in `work/done/`.

---

## What happened

**The page contradicted itself, and the answer is Step 0.** Contract bullet 1
said the record is written "at the step where it asks the Documentation
language", which is Step 0 and what `docs/03-Domain.md` already said; the
`/initialize` bullet said the late step "writes the language record, and where
the tag is not `en` it rewrites the three manuals". Asked
(`CLAUDE.md`, ambiguity goes to the person): **Step 0 writes the record,
beside the three prose declarations, and the late step only translates.** That
is where the tag is known and where a review run reads the declared language
of a target that predates the record. The `/initialize` bullet is what was
wrong, and this record is the correction.

**What the run settled**, inside the Contract's constraints:

* The record's path is `.claude/skills/.focus-kit-language`, beside
  `.focus-kit-version` and `.focus-kit-manifest`, one line ending in a
  newline. The name follows the two files it sits with, which is the only
  naming the page constrained.
* It is read through `without_cr()`, its seventh caller. The page argued the
  CR tolerance for `fingerprint` in the new pass and said nothing about the
  record; it is a one-line file of the target's, exactly the shape of the
  stamp, and the tag is quoted back in every warn.
* The ADR is **0008** and not the next number on disk. `0007` is reserved in
  writing by `work/copilot-port.md` and already cited by `docs/03-Domain.md`,
  and `docs/04-Conventions.md` §2 says an ADR is never renumbered. The gap is
  noted in `docs/adr/README.md` so the number is not read as a loss.
* Step 4 gained one rule the page did not name, written after the scratch run
  and because of it: a manual claiming to quote a source verbatim says, in the
  translation, that the quotes are translated. `focus.md` is the only one that
  claims it, and the translated file carries the clause in the line that
  already made the claim.
* The new pass enumerates `manuals/*.md` from `KIT_DIR` rather than repeating
  the presence loop's three names, so a fourth manual is a file and no edit.
  The visible consequence is the order: the warns come out in glob order
  (`focus`, `graphify`, `process`), not the presence loop's.

**One defect the page did not foresee, fixed here.** `.focus-kit-language`
lands under `.claude/skills/`, and check 6 of the verify command diffs that
folder against `skills/` while excluding only the stamp and the manifest. This
repository has no record today, so the check was green; the first
`/initialize` review run here would have written `en` and turned the kit's own
verify red over a file the kit asked that command to write. Asked, and the
answer was to fix it in this delivery: check 6 excludes the third data file by
name, the way it excludes the other two, and `docs/05-Process.md` §4 item 6
says why.

**What was dropped.** No probe was added to check 2 for the new pass, although
every other pass of `doctor` has one. The page's Done when names a real run
and two `doctor` observations as the proof and no probe, and adding one
rewrites check 2's paragraph in `docs/05-Process.md` §4. The gap is real: the
`warn` and the `ok` this delivery adds are exercised by no automated check,
and a later line can close it.

**What the proof found.** Nothing the page did not expect.

* An English scratch: `doctor` before and after the change, diffed, identical
  line for line. The pass does not run where the record is absent.
* A `pt-BR` scratch, the record written and the three manuals translated by
  hand in this session, which is the step as written: `docs/manuals (pt-BR)`
  green, no Drift over the three, nothing behind the kit source, every
  `grep '^#'` of a translated manual identical to the English source's, and
  no `U+2014` anywhere in the three.
* `focus-kit update` on that same scratch, then `doctor` again: three warns,
  `docs/manuals/<name>.md in English, not pt-BR (run /initialize to translate
  it)`, which is Behaviour bullet 4 on the same scratch.
* Before the translation, the same three warns on the untranslated target,
  which is the review run's own starting state.

**One cost measured rather than argued.** Translating `focus.md` means
translating the book's quotes, and a quotation translated is no longer a
quotation. `docs/00-Product.md` (Audience) says the words are quoted because a
model given the rule verbatim argues with it less. The three are translated
together anyway, and `docs/adr/ADR-0008` records the trade rather than hiding
it. The manual's own note now says the quotes are the book's words,
translated.

**Also in this delivery, because the CLI grew 60 lines.** Six
`bin/focus-kit:<line>` citations in `docs/00`, `docs/01`, `docs/03`, `docs/04`
and `ADR-0002` moved, plus the Line column of the function table of
`docs/01-Architecture.md` §3 and the six check functions below it. Each one
was resolved against what the cited line now holds, the way
`help-names-what-install-writes` did.

**Environments.**

| Environment | State |
|---|---|
| Kit source | 0.29.0, the delivery's version |
| Dogfood copy | 0.29.0, `focus-kit install .` run here, check 6 green |
| Machine | untouched: the CLI is a symlink and follows the source |
| First target (`~/Downloads/vaulted`) | not on this machine: the directory does not exist. Nothing to update, and nothing was written there. The row of `docs/05-Process.md` §5 is left as it is, since it leaves with milestone 2 and this delivery is not that one |
| Target repositories (anyone else's) | untouched; they move when their owner runs `focus-kit update` |
