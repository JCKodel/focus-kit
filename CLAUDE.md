# focus-kit

The installable delivery process (propose/apply) plus the FOCUS
architecture reference, for repositories worked on with Claude Code. This
repository is the kit, not a project that uses it.

Everything here is in English. No em dash anywhere: the kit forbids it in
user-facing text, and the kit's own text sets the example.

## Layout
- `bin/focus-kit`: the CLI. bash 3.2 (macOS default); no associative
  arrays, no `mapfile`. JSON merging goes through python3.
- `skills/<name>/SKILL.md`: the three commands copied into target repos.
  Frontmatter `description` uses a `>-` block: a bare colon in the value
  breaks the YAML and the skill silently disappears.
- `skills/initialize/templates/`: what `/initialize` fills. Guidance to the
  command lives in `<!-- init: ... -->` comments, which it removes.
- `manuals/`: kit-owned files copied to `docs/manuals/` of every target.
- `config/`: settings baseline and `.gitignore` fragment, merged on install.

## Rules
- Kit-owned files are overwritten on `focus-kit update`; project-owned
  files (`docs/00` to `06`, `CLAUDE.md`, `docs/adr/`, `work/`) are never
  touched by the CLI. Keep that line sharp.
- The three skills are stack-agnostic. Anything project-specific (verify
  command, environments, publish policy, git policy, proof) is a slot in
  `docs/05-Process.md`, filled by `/initialize`, read by `/apply`.
- Bump `VERSION` on any change a target repo would want.
- Test a change by installing into a scratch repository and running
  `focus-kit doctor` there; there is no test suite beyond that yet.
- Stage with `git add`; suggest the commit message; never commit.
