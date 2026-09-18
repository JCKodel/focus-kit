# ADR-0008: The manuals follow the target's language, with the headings left in English

**Status:** accepted
**Date:** 2026-09-18

---

## Context

A target repository picks its documentation language when `/initialize` runs
there, and everything the command writes afterwards follows it: `docs/00` to
`06`, the ADRs, `CLAUDE.md`, the delivery pages and the commit messages. Three
files in that same repository did not follow it, and they are the three
manuals of `docs/manuals/`: `process.md`, `focus.md` and `graphify.md`,
copied out of the kit in English and left there.

They are not the kit's terminal output and they are not a string in a program.
They are documents of that repository, read by the people working there and by
every command that names a section of one, and the process manual is the one a
person opens to learn how the process works at all. A manual nobody reads
teaches nothing, and `docs/00-Product.md` names the second audience as the
agent itself, which reads the manual too.

That left open decision 4 of `docs/00-Product.md` standing since the kit
documented itself: whether `/initialize` should support a non-English kit, and
whether a translated manual is ever shipped. The two halves of the question
have different answers, which is what took so long to see.

Three constraints hold whatever is decided:

* A Command names the section of a manual it reads, `§Ensuring the graph` and
  `§The git strategy` among them, and reads that section alone
  (`docs/03-Domain.md`, Named section). A translated heading is a section the
  command cannot find.
* `focus-kit doctor` checks a Manual citation from a target's own documents
  against the manual the kit ships at `KIT_DIR`, by heading
  (`ADR-0002`, the `update-survives-a-moved-section` amendment). A translated
  heading fails that match in every citation of that manual.
* `bin/focus-kit` is bash and python3 (`ADR-0001`). It has no model, and a
  translation is not something a shell script can perform.

## Decision

**The manuals follow the target's documentation language, `/initialize`
translates them, and every section heading stays in English.**

In four parts:

1. **`/initialize` translates.** After the documents are written and before it
   closes, the command rewrites the three manuals in the target's language,
   the body translated and each file left in place. On a review run it asks
   the question of each manual on its own: one that is still the English file
   is translated now, one that is already in the language is left alone.
2. **Every heading stays in English, byte for byte**, and so does a `§`
   citation inside a manual's own body, which is a heading's text. The
   Kit-owned banner and the License notice on the first two lines are carried
   over as written, being the kit's own terms, a path and a URL.
3. **Nothing is shipped translated.** The kit holds one manual per file, in
   English, and `install` and `update` write it over whatever a target has.
   A target holds whichever version its own `/initialize` wrote. `doctor`
   names each manual that has come back English and points at the command
   that translates it again.
4. **The language is recorded in the target**, in
   `.claude/skills/.focus-kit-language`, one line holding an IETF BCP 47 tag,
   written by `/initialize` at the step where it asks the language and read by
   `doctor` and by nothing else. Absent means `en`, which is every target
   installed before this version.

Ownership does not move. The manuals stay kit-owned, the record is
project-owned by the test that decides every other one, which is who writes
it, and there is no fifth category (`ADR-0002`, amended). What gives way is
one pass of `doctor`: where the recorded language is not `en`, the three
manuals are not fingerprinted against the manifest, because the manifest holds
the English file `install` wrote and the disk holds the translation.

## Consequences

Easier: a repository that documents itself in Portuguese reads its whole
`docs/` tree in Portuguese, the manuals included, and the person who most
needs the process manual is the one least likely to read English comfortably.
Nothing about the CLI grows: no model, no translation table, no per-language
file under `manuals/`, and one number in `VERSION` for everybody.

Harder: a translation is lost on every `update` and comes back only when a
person runs `/initialize` again, which on a target that has `docs/00-Product.md`
is a review run of every document. That is the price of not making the kit
ship a manual per language, and `doctor` is what keeps it from being silent.
The three manuals also stop being covered by the Drift pass in a translated
target, so a hand edit to one there goes unreported; `update` overwrites it
regardless, which is what Drift existed to warn about.

Also harder, and named because it is the largest single cost: `focus.md`
quotes the book verbatim, and a quotation translated is no longer a
quotation. `docs/00-Product.md` (Audience) says why the words are quoted,
which is that a model given the rule verbatim argues with it less than one
given a paraphrase. A translated `focus.md` gives up some of that. The three
are translated together anyway, because a target reading two manuals in its
own language and one in English is the state that teaches nobody anything.

Forbidden: a translated heading; a manual translated in this repository; a
translation performed by `bin/focus-kit`; a second language in one target.

Revisit when: a target wants a manual kept translated across updates. The
answer is not a fifth ownership category but a translation the target itself
holds, and the delivery that wants it says where.

## Alternatives considered

* **Ship a manual per language under `manuals/`, `process.pt-BR.md` beside
  `process.md`.** Lost: every delivery that edits a manual would then edit it
  once per language or leave the others behind, and the kit has one person
  writing it. It also makes the kit's own verify command grow a check per
  language.
* **Translate in the CLI.** Lost against `ADR-0001`: bash and python3 with no
  model, and adding one would add a dependency, an API key and a network call
  to a command that today copies files.
* **Translate the headings too, and teach the commands to find a section by
  position.** Lost: the heading is what every command hangs on and what
  `doctor` matches a citation against, and position is exactly the address
  `update-survives-a-moved-section` proved cannot be trusted.
* **Leave the manuals in English and say so.** Lost, and it is the state this
  decision replaces: it was never decided, only inherited, and the person who
  needs the process manual most is the one it was failing.
* **Re-translate on `update`.** Lost: `update` has no model, and a command
  that silently rewrote a target's manuals would be doing the one thing
  `ADR-0002` promises it never does to what a person wrote.
