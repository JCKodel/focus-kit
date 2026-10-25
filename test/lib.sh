# Shared helpers for test/run.sh. Sourced, not executed.
# bash 3.2 compatible: no associative arrays, no mapfile.

KIT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SETUP="$KIT_ROOT/SETUP.md"
FIXTURE="$KIT_ROOT/test/fixture"

PASS=0
FAIL=0
WARN=0

ok()   { PASS=$((PASS + 1)); printf '  ok    %s\n' "$1"; }
fail() { FAIL=$((FAIL + 1)); printf '  FAIL  %s\n' "$1"; }
warn() { WARN=$((WARN + 1)); printf '  warn  %s\n' "$1"; }
say()  { printf '\n%s\n' "$1"; }

# assert_true <description> <command...>
assert_true() {
  local desc=$1; shift
  if "$@" >/dev/null 2>&1; then ok "$desc"; else fail "$desc"; fi
}

# assert_false <description> <command...>
assert_false() {
  local desc=$1; shift
  if "$@" >/dev/null 2>&1; then fail "$desc"; else ok "$desc"; fi
}

summary() {
  printf '\n%d ok, %d failed, %d warnings\n' "$PASS" "$FAIL" "$WARN"
  [ "$FAIL" -eq 0 ]
}

kit_version() {
  sed -n 's/^Version: //p' "$SETUP" | head -1
}

# kit_script <claim|queue> prints the script of §3.6 or §3.7.
kit_script() {
  awk -v h="propose/scripts/$1.sh" 'index($0, "### 3.") == 1 && index($0, h) {f=1} f&&/^````sh$/{p=1;next} p&&/^````$/{exit} p' "$SETUP"
}

# section_3 prints SETUP.md from "## 3. The files" to before "## 4. Check".
section_3() {
  awk '/^## 3\. The files/{p=1} /^## 4\. Check/{p=0} p' "$SETUP"
}

# skill_body <name> prints the prose of a skill after its frontmatter.
skill_body() {
  awk -v h="### 3.[0-9]* \`$1/SKILL.md\`" '
    $0 ~ h {p=1; next}
    p && /^### 3\./ {p=0}
    p' "$SETUP" | awk '/^---$/{c++; next} c>=2'
}

# docs05_template prints the docs/05 template, §1 to §8, without the
# closing fence of the documents.md block it lives in.
docs05_template() {
  awk '/^## 1\. The rule/{p=1} /^## AGENTS\.md/{p=0} p' "$SETUP" | grep -v '^```$'
}

# docs05_range <from heading regex> <to heading regex> prints a part of it.
docs05_range() {
  docs05_template | awk -v a="$1" -v b="$2" '$0 ~ a {p=1} $0 ~ b {p=0} p'
}

# longest_sentence prints "<words> <first 60 chars>" of the longest sentence
# on stdin. A sentence ends at ". ", "? " or "! ", and a heading, a list
# item, a table row or a fence starts a new one. A semicolon does not end
# it: CLAUDE.md forbids a rule in a chain of semicolons, so the chain is
# measured whole (on 2026-10-25 an 85-word sentence of docs/05 §8 passed
# as pieces of fifty).
longest_sentence() {
  awk '/^#/ { print ". "; print; print ". "; next }
       /^[ \t]*(\* |- |\||```|[0-9]+\. )/ { print ". " } { print }' \
    | tr '\n' ' ' | sed 's/  */ /g' | awk '
    BEGIN { RS = "[.?!] " }
    { n = split($0, w, " "); if (n > max) { max = n; s = substr($0, 1, 60) } }
    END { printf "%d %s\n", max, s }'
}

# ---------- hosts ----------

have_host() { command -v "$1" >/dev/null 2>&1; }

# run_host <host> <workdir> <container> <prompt>
# Runs one non-interactive session in <workdir>. The project is a throwaway
# fixture in a temp folder, so permissions are bypassed on purpose. The
# container holds origin.git and the worktrees, both outside main/, so the
# host's sandbox must be let write there or every push and worktree fails.
run_host() {
  local host=$1 dir=$2 extra=$3 prompt=$4
  case $host in
    claude)
      (cd "$dir" && claude -p "$prompt" \
        --dangerously-skip-permissions \
        --add-dir "$extra" \
        --output-format text)
      ;;
    codex)
      # workspace-write keeps .agents/ read-only, so the kit cannot be
      # planted under it; the sandbox is bypassed in the throwaway folder.
      (cd "$dir" && codex exec \
        --dangerously-bypass-approvals-and-sandbox \
        --add-dir "$extra" \
        -C "$dir" \
        "$prompt")
      ;;
    copilot)
      # One -p prompt is one premium request on any Copilot plan, Free
      # included; the CLI loads skills from .agents/skills/ and
      # .claude/skills/. It invokes one as /<name>, with the words after
      # it reaching the skill, in -p mode too (tested 2026-10-20 with a
      # skill carrying disable-model-invocation); the harness asks by
      # name, which the agent also follows, so one prompt serves all hosts.
      (cd "$dir" && copilot -p "$prompt" -s \
        --allow-all-tools \
        --allow-all-paths \
        --add-dir "$extra")
      ;;
    *) echo "unknown host: $host" >&2; return 2 ;;
  esac
}

# command_for <host> <name> <args> prints how that host invokes a kit command.
command_for() {
  case $1 in
    claude)  printf '/%s %s' "$2" "$3" ;;
    codex)   printf '$%s %s' "$2" "$3" ;;
    copilot) printf 'Run the %s skill (.agents/skills/%s/SKILL.md), which I am invoking, for these slugs: %s' "$2" "$2" "$3" ;;
  esac
}

# ---------- fixture ----------

# build_fixture <container dir> creates <container>/origin.git (bare) and
# <container>/main (the checkout), with the fake project committed and pushed.
build_fixture() {
  local c=$1 main=$1/main
  mkdir -p "$c"
  git init -q --bare "$c/origin.git"
  git clone -q "$c/origin.git" "$main" 2>/dev/null
  cp -R "$FIXTURE/project/." "$main/"
  mkdir -p "$main/.focus-kit" "$c/.focus-kit/worktrees"
  (cd "$main" && git add -A && git -c user.name=test -c user.email=test@test \
     commit -q -m "feat: skeleton" && git push -q -u origin HEAD:main 2>/dev/null \
     && git branch -q -M main && git branch -q --set-upstream-to=origin/main main)
}

# seed_docs <main dir> writes the project documents the kit's commands read,
# with docs/05 generated from the kit's own template and the fixture's slots.
seed_docs() {
  local main=$1
  cp -R "$FIXTURE/docs/." "$main/docs/"
  cp "$FIXTURE/AGENTS.md" "$main/AGENTS.md"
  printf '@AGENTS.md\n' > "$main/CLAUDE.md"
  mkdir -p "$main/.claude"
  printf '{\n  "permissions": {\n    "additionalDirectories": ["../.focus-kit/worktrees"]\n  }\n}\n' \
    > "$main/.claude/settings.json"
  {
    printf '# Process\n\n'
    docs05_range '^## 1\. The rule' '^## 5\. This project'
    docs05_range '^## 5\. This project' '^\* \*\*Documentation language'
    cat "$FIXTURE/05-slots.md"
    printf '\n'
    docs05_range '^## 6\. Commit' '^## 99\.'
  } > "$main/docs/05-Process.md"
  (cd "$main" && git add -A && git -c user.name=test -c user.email=test@test \
     commit -q -m "docs: project documents and queue" && git push -q origin main 2>/dev/null)
}
