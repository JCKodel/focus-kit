#!/usr/bin/env bash
# focus-kit test harness. See test/README.md.
#
#   test/run.sh check                      static checks on the kit, no host, no tokens
#   test/run.sh plant    [--host H]        plant the kit in a throwaway project, check §4
#   test/run.sh parallel [--host H]        plant, seed docs, run /propose with three slugs
#   test/run.sh apply    [--host H]        parallel, then /apply the two defined pages
#   test/run.sh all      [--host H]        check + apply
#
#   --host claude|codex|copilot|all   default: every host installed
#   --dry-run                 build the fixture, print the host commands, run no host
#   --keep                    keep the temp folder and print its path
#   --strict                  line budgets fail instead of warn
set -euo pipefail
. "$(dirname "$0")/lib.sh"

STAGE=${1:-check}; shift || true
HOSTS=""; DRY=0; KEEP=0; STRICT=0; MAXW=50
while [ $# -gt 0 ]; do
  case $1 in
    --host) HOSTS=$2; shift 2 ;;
    --dry-run) DRY=1; shift ;;
    --keep) KEEP=1; shift ;;
    --strict) STRICT=1; shift ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
done

budget() { # budget <what> <actual> <ceiling>
  if [ "$2" -le "$3" ]; then ok "$1: $2 lines (ceiling $3)"
  elif [ "$STRICT" -eq 1 ]; then fail "$1: $2 lines, ceiling $3"
  else warn "$1: $2 lines, ceiling $3"; fi
}

# ---------- check ----------

stage_check() {
  local v; v=$(kit_version)
  say "check: kit $v"

  assert_true "no em dash in any .md" \
    bash -c "! grep -rl \$'—' --include='*.md' '$KIT_ROOT' | grep -v '/test/fixture/' | grep ."
  local fences; fences=$(section_3 | grep -c '^````' || true)
  [ $((fences % 2)) -eq 0 ] && ok "§3 fences balanced ($fences)" || fail "§3 fences unbalanced ($fences)"
  local n; n=$(grep -c "version: \"$v\"" "$SETUP" || true)
  [ "$n" -eq 4 ] && ok "four SKILL.md carry metadata.version $v" || fail "metadata.version $v found $n times, expected 4"
  n=$(section_3 | grep -c '^disable-model-invocation: true' || true)
  [ "$n" -eq 4 ] && ok "four skills disable model invocation" || fail "disable-model-invocation found $n times, expected 4"
  skill_body propose | grep -q '\$ARGUMENTS' && ok "propose reads \$ARGUMENTS" || fail "propose lost \$ARGUMENTS"
  skill_body apply | grep -q '\$ARGUMENTS' && ok "apply reads \$ARGUMENTS" || fail "apply lost \$ARGUMENTS"
  grep -q "allow_implicit_invocation: false" "$SETUP" && ok "Codex policy disables implicit invocation" || fail "Codex policy missing"
  grep -q '^trigger: always_on' "$SETUP" && ok "Antigravity pointer is always_on" || fail "Antigravity trigger missing"

  for f in CHANGELOG.md CHANGELOG.pt.md; do
    local top; top=$(grep -m1 '^## ' "$KIT_ROOT/$f" | sed 's/^## //')
    [ "$top" = "$v" ] && ok "$f leads with $v" || fail "$f leads with '$top', kit is $v"
  done
  local en pt
  en=$(grep -c '^## ' "$KIT_ROOT/README.md"); pt=$(grep -c '^## ' "$KIT_ROOT/README.pt.md")
  [ "$en" -eq "$pt" ] && ok "README and README.pt have the same sections ($en)" || fail "README has $en sections, README.pt $pt"
  en=$(grep -c '^## ' "$KIT_ROOT/CHANGELOG.md"); pt=$(grep -c '^## ' "$KIT_ROOT/CHANGELOG.pt.md")
  [ "$en" -eq "$pt" ] && ok "CHANGELOG and CHANGELOG.pt have the same entries ($en)" || fail "CHANGELOG has $en entries, CHANGELOG.pt $pt"

  local book="$KIT_ROOT/../focus-kit-book/docs/06-Queue.md"
  if [ -f "$book" ]; then
    grep -q "focus-kit $v\$" "$book" && ok "book queue has a milestone for $v" || fail "book queue has no milestone for $v"
  else warn "book repository not found next to the kit; milestone line not checked"; fi

  say "check: line alarms (CLAUDE.md)"
  budget "/propose body" "$(skill_body propose | grep -c .)" 40
  budget "/apply body" "$(skill_body apply | grep -c .)" 60
  budget "SETUP.md §1" "$(awk '/^## 1\. What to do/{p=1} /^## 2\. What the kit is/{p=0} p' "$SETUP" | wc -l | tr -d ' ')" 200
  budget "docs/05 template (non-blank)" "$(docs05_template | grep -c .)" 320
  budget "documents.md" "$(awk '/^### 3\.5 /{p=1} /^### 3\.6 /{p=0} p' "$SETUP" | wc -l | tr -d ' ')" 600

  say "check: sentences (CLAUDE.md: none over $MAXW words)"
  for s in brainstorm analyze propose apply; do
    local r; r=$(skill_body "$s" | longest_sentence)
    local w=${r%% *}
    [ "$w" -le "$MAXW" ] && ok "$s: longest sentence $w words" || warn "$s: longest sentence $w words: ${r#* }..."
  done
  local r; r=$(docs05_template | longest_sentence); local w=${r%% *}
  [ "$w" -le "$MAXW" ] && ok "docs/05: longest sentence $w words" || warn "docs/05: longest sentence $w words: ${r#* }..."
  r=$(awk '/^## 1\. What to do/{p=1} /^## 2\. What the kit is/{p=0} p' "$SETUP" | longest_sentence); w=${r%% *}
  [ "$w" -le "$MAXW" ] && ok "§1: longest sentence $w words" || warn "§1: longest sentence $w words: ${r#* }..."
}

# ---------- fixture stages ----------

KIT_PATHS='^(\.claude/skills/|\.agents/skills/|\.agents/rules/focus-kit\.md|\.github/prompts/|\.cursor/commands/|\.gemini/commands/|GEMINI\.md)'

stage_plant() { # stage_plant <host> <container>
  local host=$1 c=$2 main=$2/main
  say "plant ($host): $main"
  # The host reads a copy downloaded next to the repository, as the README
  # offers, so a host that writes beside SETUP.md writes into a folder
  # the harness watches, never into the kit's own checkout (2026-10-20).
  local dl="$c/download"; mkdir -p "$dl"; cp "$SETUP" "$dl/SETUP.md"
  local prompt="Read $dl/SETUP.md and do what it says. This is a fresh project with no custom files: ask nothing, write the files, run the check of its section 4 and report the list."
  if [ "$DRY" -eq 1 ]; then echo "  would run: $host <<< '$prompt'"; return; fi
  local kit_before; kit_before=$(git -C "$KIT_ROOT" status --porcelain --untracked-files=all)
  run_host "$host" "$main" "$c" "$prompt" > "$c/plant-$host.log" 2>&1 || true
  assert_true "nothing written beside the downloaded SETUP.md" bash -c "[ \$(ls -A '$dl' | wc -l) -eq 1 ]"
  [ "$(git -C "$KIT_ROOT" status --porcelain --untracked-files=all)" = "$kit_before" ] \
    && ok "the kit's own checkout untouched" || fail "the host wrote into the kit's checkout: $(git -C "$KIT_ROOT" status --porcelain --untracked-files=all | tr '\n' ' ')"

  local f
  for n in brainstorm analyze propose apply; do
    for d in .claude/skills .agents/skills; do
      assert_true "$d/$n/SKILL.md" test -f "$main/$d/$n/SKILL.md"
    done
    assert_true ".agents/skills/$n/agents/openai.yaml" test -f "$main/.agents/skills/$n/agents/openai.yaml"
    assert_true ".github/prompts/$n.prompt.md" test -f "$main/.github/prompts/$n.prompt.md"
    assert_true ".cursor/commands/$n.md" test -f "$main/.cursor/commands/$n.md"
    assert_true ".gemini/commands/$n.toml" test -f "$main/.gemini/commands/$n.toml"
  done
  for d in .claude/skills .agents/skills; do
    for n in brainstorm analyze; do
      assert_true "$d/$n/references/documents.md" test -f "$main/$d/$n/references/documents.md"
    done
  done
  local script; script=$(mktemp)
  awk '/^### 3\.6 `propose\/scripts\/claim\.sh`/{f=1} f&&/^````sh$/{p=1;next} p&&/^````$/{exit} p' "$SETUP" > "$script"
  for d in .claude/skills .agents/skills; do
    f="$main/$d/propose/scripts/claim.sh"
    assert_true "$d/propose/scripts/claim.sh byte for byte" diff -q "$script" "$f"
    assert_false "$d/propose/scripts/claim.sh has LF endings" grep -q $'\r' "$f"
  done
  rm -f "$script"
  assert_true ".agents/rules/focus-kit.md" test -f "$main/.agents/rules/focus-kit.md"
  assert_true "GEMINI.md" test -f "$main/GEMINI.md"
  assert_false "no .windsurf/skills left" test -d "$main/.windsurf/skills"
  local v; v=$(kit_version)
  for n in brainstorm analyze propose apply; do
    f="$main/.claude/skills/$n/SKILL.md"
    [ -f "$f" ] && grep -q "version: \"$v\"" "$f" && ok "$n installed at $v" || fail "$n not at $v"
  done
  for n in propose apply; do
    f="$main/.claude/skills/$n/SKILL.md"
    [ -f "$f" ] && grep -q '\$ARGUMENTS' "$f" && ok "$n keeps \$ARGUMENTS" || fail "$n lost \$ARGUMENTS"
  done
  for n in brainstorm analyze; do
    f="$main/.github/prompts/$n.prompt.md"
    [ -f "$f" ] && ! grep -q 'input:slug' "$f" && ok "$n prompt takes no slug" || fail "$n prompt declares a slug"
  done
  assert_true "exactly one pointer line in GEMINI.md" bash -c "[ \$(grep -c . '$main/GEMINI.md') -eq 1 ]"
  local other; other=$(cd "$main" && git status --porcelain --untracked-files=all | awk '{print $2}' | grep -Ev "$KIT_PATHS" || true)
  [ -z "$other" ] && ok "no other file changed" || fail "other files changed: $(echo "$other" | tr '\n' ' ')"
  assert_true "nothing staged, nothing committed" bash -c "cd '$main' && git diff --cached --quiet && [ \$(git rev-list --count origin/main..HEAD) -eq 0 ]"
  (cd "$main" && git add -A && git -c user.name=test -c user.email=test@test commit -q -m "chore: focus-kit $v" && git push -q origin main 2>/dev/null)
}

branch_has() { git -C "$1" ls-remote --exit-code --heads origin "focus-kit/$2" >/dev/null 2>&1; }

stage_parallel() { # stage_parallel <host> <container>
  local host=$1 c=$2 main=$2/main wt=$2/.focus-kit/worktrees
  say "parallel ($host): /propose farewell portuguese shout"
  seed_docs "$main"
  assert_true "docs/05 generated with its eight sections" bash -c "[ \$(grep -c '^## [1-8]\. ' '$main/docs/05-Process.md') -eq 8 ]"
  local cmd; cmd=$(command_for "$host" propose "farewell portuguese shout")
  local prompt="$cmd
Decide alone: answer every question with your own recommendation and write it on the page as your answer. Never stop to ask me anything; a question a subagent reports, answer the same way and resume it. Build nothing."
  if [ "$DRY" -eq 1 ]; then echo "  would run in $main: $host <<< '$prompt'"; return; fi
  run_host "$host" "$main" "$c" "$prompt" > "$c/parallel-$host.log" 2>&1 || true

  for s in farewell portuguese; do
    assert_true "worktree for $s" test -d "$wt/$s"
    assert_true "branch focus-kit/$s pushed" branch_has "$main" "$s"
    assert_true "page work/$s.md in its worktree" test -f "$wt/$s/work/$s.md"
    if grep -q "^\[>\] $s" "$wt/$s/docs/06-Queue.md" 2>/dev/null; then ok "$s is [>] on its branch"
    elif grep -q "^\[~\] $s" "$wt/$s/docs/06-Queue.md" 2>/dev/null; then warn "$s left [~]: definition incomplete"
    else fail "$s not marked on its branch"; fi
    assert_true "$s page records the answers as the agent's" grep -qiE "agent|decid|your call|recommendation" "$wt/$s/work/$s.md"
  done
  # Both pages change src/greet.sh, so portuguese's A should become `-`
  # once /propose reads the pages (docs/05 §4: /propose corrects a token).
  if grep -q "^\[.\] portuguese *(.A)" "$wt/portuguese/docs/06-Queue.md" 2>/dev/null; then
    warn "portuguese keeps its A token although farewell changes the same file"
  else ok "portuguese's token re-judged from the pages"; fi
  assert_false "shout (after farewell) has no worktree" test -d "$wt/shout"
  assert_false "shout has no branch" branch_has "$main" shout
  assert_true "shout line untouched on main" grep -q '^\[ \] shout' "$main/docs/06-Queue.md"
  assert_true "main's queue unchanged" bash -c "cd '$main' && git diff --quiet HEAD -- docs/06-Queue.md"
  assert_true "main's tree clean" bash -c "cd '$main' && [ -z \"\$(git status --porcelain)\" ]"
}

stage_apply() { # stage_apply <host> <container>
  local host=$1 c=$2 main=$2/main wt=$2/.focus-kit/worktrees
  say "apply ($host): /apply farewell portuguese from main/, subagents sent to the worktrees"
  local cmd; cmd=$(command_for "$host" apply "farewell portuguese")
  local prompt="$cmd
Decide alone: never stop to ask me anything; a question a subagent reports, answer with your recommendation and resume it. Do not commit."
  if [ "$DRY" -eq 1 ]; then echo "  would run in $main: $host <<< '$prompt'"; return; fi
  run_host "$host" "$main" "$c" "$prompt" > "$c/apply-$host.log" 2>&1 || true

  for s in farewell portuguese; do
    assert_true "$s: page moved to work/done/" test -f "$wt/$s/work/done/$s.md"
    assert_true "$s: verify green in its worktree" make -C "$wt/$s" verify
    assert_true "$s: line [x] in the staged queue" bash -c "cd '$wt/$s' && git diff --cached -- docs/06-Queue.md | grep -q '^+\[x\] $s'"
    assert_true "$s: changes staged, none committed" bash -c "cd '$wt/$s' && ! git diff --cached --quiet && [ \$(git rev-list --count origin/main..HEAD) -eq 0 ]"
    assert_true "$s: commit block on the page" grep -q '^```commit' "$wt/$s/work/done/$s.md"
  done
  assert_true "main's tree clean" bash -c "cd '$main' && [ -z \"\$(git status --porcelain)\" ]"
}

# ---------- main ----------

[ "$STAGE" = check ] || [ "$STAGE" = all ] && stage_check

if [ "$STAGE" != check ]; then
  if [ -z "$HOSTS" ] || [ "$HOSTS" = all ]; then
    HOSTS=""; for h in claude codex copilot; do have_host "$h" && HOSTS="$HOSTS $h"; done
    [ -n "$HOSTS" ] || { fail "no host installed (claude, codex, copilot)"; summary; exit 1; }
  fi
  for host in $HOSTS; do
    have_host "$host" || { fail "$host is not installed"; continue; }
    C=$(mktemp -d "${TMPDIR:-/tmp}/focus-kit-test-$host.XXXXXX")
    build_fixture "$C"
    assert_true "fixture verify green" make -C "$C/main" verify
    stage_plant "$host" "$C"
    case $STAGE in
      parallel|apply|all) stage_parallel "$host" "$C" ;;
    esac
    case $STAGE in
      apply|all) stage_apply "$host" "$C" ;;
    esac
    if [ "$KEEP" -eq 1 ] || [ "$FAIL" -gt 0 ]; then echo "  kept: $C (logs: $C/*.log)"; else rm -rf "$C"; fi
  done
fi

summary
