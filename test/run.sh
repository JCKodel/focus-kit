#!/usr/bin/env bash
# focus-kit test harness. See test/README.md.
#
#   test/run.sh check                      static checks on the kit, no host, no tokens
#   test/run.sh plant    [--host H]        plant the kit in a throwaway project, check §4
#   test/run.sh parallel [--host H]        plant, seed docs, run /propose with three slugs
#   test/run.sh apply    [--host H]        parallel, then /apply the two defined pages
#   test/run.sh overlap  [--host H]        apply, then a page sharing a file with a built, unmerged one
#   test/run.sh all      [--host H]        check + overlap
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

  check_queue_script
  check_claim_script
  check_mark_script

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

tgit() { git -c user.name=test -c user.email=test@test "$@"; }

# queue.sh on test/fixture/queue: trunk; then with delivery branches on a
# local bare remote (card at [*] with a card-fix line, login unchanged,
# export blocked, colors built and unmerged, search with a new after);
# then from a stale worktree after colors is merged; then with CRLF.
check_queue_script() {
  say "check: queue.sh on test/fixture/queue"
  local t script; t=$(mktemp -d); script="$t/queue.sh"
  kit_script queue > "$script"
  git init -q --bare "$t/remote.git"
  git clone -q "$t/remote.git" "$t/main" 2>/dev/null
  (
    cd "$t/main" && git switch -q -c main && mkdir docs
    cp "$FIXTURE/queue/06-Queue.md" docs/
    tgit add docs && tgit commit -q -m queue && git push -q -u origin main && git remote set-head origin -a >/dev/null 2>&1
  )
  (cd "$t/main" && sh "$script" trunk) > "$t/trunk.txt" 2>&1 || true
  assert_true "trunk output matches expected-trunk.txt" diff -u "$FIXTURE/queue/expected-trunk.txt" "$t/trunk.txt"
  edit_branch() { # edit_branch <slug> <awk program>: the slug's branch from main, its queue edited, pushed
    (
      cd "$t/main" && git switch -q -c "focus-kit/$1" main
      awk "$2" docs/06-Queue.md > docs/q && mv docs/q docs/06-Queue.md
      tgit commit -q --allow-empty -am "$1" && git push -q origin "focus-kit/$1" 2>/dev/null && git switch -q main
    )
  }
  edit_branch card '{ if ($0 ~ /^\[ \] card  /) { sub(/^\[ \]/, "[*]"); print; print "[ ] card-fix    a fix found while building card"; next } print }'
  edit_branch login '{ print }'
  edit_branch export '{ if ($0 ~ /^\[>\] export/) $0 = "[?] export      export the board · resume: apply · blocked: which format, asked"; print }'
  edit_branch colors '{ if ($0 ~ /^\[>\] colors/) sub(/^\[>\]/, "[x]"); print }'
  edit_branch search '{ if ($0 ~ /^\[ \] search/) $0 = $0 ", login"; print }'
  (cd "$t/main" && sh "$script" worktree .focus-kit focus-kit/) > "$t/worktree.txt" 2>&1 || true
  assert_true "worktree output matches expected-worktree.txt" diff -u "$FIXTURE/queue/expected-worktree.txt" "$t/worktree.txt"
  (
    cd "$t/main" && tgit merge -q --no-ff -m "merge colors" focus-kit/colors && git push -q origin main
    mkdir -p "$t/.focus-kit/worktrees" && git worktree add -q "$t/.focus-kit/worktrees/card" focus-kit/card
  )
  (cd "$t/.focus-kit/worktrees/card" && sh "$script" worktree .focus-kit focus-kit/) > "$t/stale.txt" 2>&1 || true
  assert_true "a stale worktree copy matches expected-stale.txt" diff -u "$FIXTURE/queue/expected-stale.txt" "$t/stale.txt"
  mkdir -p "$t/crlf/docs" && (cd "$t/crlf" && git init -q)
  awk '{ printf "%s\r\n", $0 }' "$FIXTURE/queue/06-Queue.md" > "$t/crlf/docs/06-Queue.md"
  (cd "$t/crlf" && sh "$script" trunk) > "$t/crlf.txt" 2>&1 || true
  assert_true "CRLF endings match expected-trunk.txt" diff -u "$FIXTURE/queue/expected-trunk.txt" "$t/crlf.txt"
  rm -rf "$t"
}

# claim.sh against a local bare remote, two clones: new, taken, resumed,
# existing, here, refused from another slug's worktree, the create-only
# push losing a race, and a worktree cut from origin's main when local
# main is behind.
check_claim_script() {
  say "check: claim.sh on two clones of a local bare remote"
  local t script out; t=$(mktemp -d); script="$t/claim.sh"
  kit_script claim > "$script"
  git init -q --bare "$t/origin.git"
  git clone -q "$t/origin.git" "$t/a/main" 2>/dev/null
  (
    cd "$t/a/main" && git switch -q -c main && mkdir docs && printf '# Queue\n\n## M1\n\n[ ] alpha one\n[ ] beta two · after alpha\n' > docs/06-Queue.md
    tgit add . && tgit commit -q -m base && git push -q -u origin main && git remote set-head origin -a >/dev/null 2>&1
  )
  git clone -q "$t/origin.git" "$t/b/main" 2>/dev/null && (cd "$t/b/main" && git remote set-head origin -a >/dev/null 2>&1)
  claim() { (cd "$1" && sh "$script" "${@:2}" 2>&1); }
  out=$(claim "$t/a/main" alpha worktree .focus-kit focus-kit/) && grep -q '^claim: new$' <<< "$out" && ok "clone a claims alpha: new" || fail "clone a claiming alpha: $out"
  assert_true "alpha's branch on origin" git -C "$t/a/main" ls-remote --exit-code --heads origin refs/heads/focus-kit/alpha
  out=$(claim "$t/b/main" alpha worktree .focus-kit focus-kit/) && fail "clone b claimed alpha: $out" || { grep -q '^claim: taken$' <<< "$out" && ok "clone b is refused alpha: taken" || fail "clone b refused with: $out"; }
  out=$(claim "$t/b/main" alpha worktree .focus-kit focus-kit/ resume) && grep -q '^claim: resumed$' <<< "$out" && ok "clone b resumes alpha on its word" || fail "clone b resuming alpha: $out"
  out=$(claim "$t/a/main" alpha worktree .focus-kit focus-kit/) && grep -q '^claim: existing$' <<< "$out" && ok "clone a reruns alpha: existing" || fail "clone a rerunning alpha: $out"
  out=$(claim "$t/a/.focus-kit/worktrees/alpha" alpha worktree .focus-kit focus-kit/) && grep -q '^claim: here$' <<< "$out" && ok "alpha from its worktree: here" || fail "alpha from its worktree: $out"
  out=$(claim "$t/a/.focus-kit/worktrees/alpha" beta worktree .focus-kit focus-kit/) && fail "beta claimed from alpha's worktree" || { grep -q '^error: run from main/' <<< "$out" && ok "beta from alpha's worktree: refused" || fail "beta from alpha's worktree: $out"; }
  (cd "$t/b/main" && git switch -q -c focus-kit/beta && tgit commit -q --allow-empty -m beta && git push -q -u origin focus-kit/beta 2>/dev/null && git switch -q main)
  out=$(cd "$t/a/main" && git worktree add -q --no-track -b focus-kit/beta ../.focus-kit/worktrees/beta refs/remotes/origin/main \
        && git -C ../.focus-kit/worktrees/beta push -q -u origin focus-kit/beta --force-with-lease=refs/heads/focus-kit/beta: 2>&1) \
    && fail "the create-only push overwrote a branch another clone pushed" || ok "the create-only push refuses a branch that appeared meanwhile"
  (cd "$t/b/main" && git fetch -q && git reset -q --hard origin/main && printf 'x\n' > new.txt && tgit add new.txt && tgit commit -q -m new && git push -q origin main)
  out=$(claim "$t/a/main" gamma worktree .focus-kit focus-kit/) && grep -q 'behind origin by 1' <<< "$out" && ok "a stale main is reported" || fail "stale main: $out"
  assert_true "gamma's worktree starts from origin's main" test -f "$t/a/.focus-kit/worktrees/gamma/new.txt"
  out=$(claim "$t/b/main" delta branch) && grep -q '^claim: new$' <<< "$out" && ok "branch per delivery: new" || fail "branch per delivery: $out"
  out=$(claim "$t/b/main" delta branch) && grep -q '^claim: here$' <<< "$out" && ok "branch per delivery, on the branch: here" || fail "on the branch: $out"
  rm -rf "$t"
}

# mark.sh on trunk with two sessions: another session's staged line kept,
# a slug that prefixes another's, a missing and a doubled slug refused with
# the file untouched, a line not yet in the index, CRLF endings. The error
# of 2026-10-18 and 2026-10-26: a script that wrote docs/06 whole left it empty.
# A second [*] or [~] on one line refused: two /apply of one slug, 2026-10-26.
check_mark_script() {
  say "check: mark.sh on a trunk queue with two sessions"
  local t script out; t=$(mktemp -d); script="$t/mark.sh"
  kit_script mark > "$script"
  mkdir -p "$t/r/docs" && cd "$t/r" && git init -q
  printf '# Queue\n\n## M1\n\n[>] card  the card\n[ ] card-fix  a fix\n[>] login  log in, a line\n  that wraps · after card\n' > docs/06-Queue.md
  tgit add . && tgit commit -q -m queue
  m() { (cd "$t/r/${2:-.}" && sh "$script" "${@:3}" 2>&1); }
  sed 's/^\[>\] login/[*] login/' docs/06-Queue.md > q && cat q > docs/06-Queue.md && rm q && git add docs/06-Queue.md
  out=$(m x . card '[*]') && grep -q '^marked: \[\*\] card' <<< "$out" && ok "card [*] in the tree" || fail "card [*]: $out"
  assert_true "the index still has card [>]" bash -c "git show :docs/06-Queue.md | grep -q '^\[>\] card '"
  cp docs/06-Queue.md "$t/before"
  out=$(m x . card '[*]') && fail "a second [*] on card was marked" || { grep -q 'card is \[\*\], not \[>\]' <<< "$out" && cmp -s "$t/before" docs/06-Queue.md && ok "a second session's [*] on card is refused, the file untouched" || fail "second [*]: $out"; }
  out=$(m x . card-fix '[*]') && fail "[*] on a [ ] line was marked" || ok "[*] on a line not yet [>] is refused"
  out=$(m x . login '[~]') && fail "[~] on a [>] line was marked" || ok "[~] on a line already past [ ] is refused"
  mkdir -p sub
  out=$(m x sub card '[x]' stage) && grep -q '^staged:' <<< "$out" && ok "card [x] staged, from a subfolder" || fail "card [x] stage: $out"
  out=$(git diff --cached | grep '^[-+]\[' | tr '\n' '|')
  [ "$out" = '-[>] card  the card|+[x] card  the card|-[>] login  log in, a line|+[*] login  log in, a line|' ] \
    && ok "staged: card [x] and the other session's login [*], nothing else" || fail "staged: $out"
  assert_true "nothing unstaged" git diff --quiet
  assert_true "card-fix untouched" grep -q '^\[ \] card-fix' docs/06-Queue.md
  cp docs/06-Queue.md "$t/before"
  out=$(m x . nope '[x]') && fail "a missing slug was marked" || ok "a missing slug is refused"
  printf '[ ] card  twice\n' >> docs/06-Queue.md; cp docs/06-Queue.md "$t/before"
  out=$(m x . card '[*]') && fail "a doubled slug was marked" || assert_true "a doubled slug is refused, the file untouched" cmp -s "$t/before" docs/06-Queue.md
  out=$(m x . card x) && fail "mark x accepted" || ok "an unknown mark is refused"
  printf '[ ] extra  new\n' >> docs/06-Queue.md
  out=$(m x . extra '[~]' stage) && fail "a line not in the index was staged" || { grep -q 'not in the index yet' <<< "$out" && ok "a line not in the index: marked, then refused to stage" || fail "extra: $out"; }
  awk '{ printf "%s\r\n", $0 }' docs/06-Queue.md > q && cat q > docs/06-Queue.md && rm q
  out=$(m x . login '[?]') && [ "$(grep -c $'\r$' docs/06-Queue.md)" -eq "$(wc -l < docs/06-Queue.md)" ] && ok "CRLF kept" || fail "CRLF: $out"
  assert_true "no temporary file left" bash -c "[ \$(ls docs | wc -l) -eq 1 ]"
  cd "$KIT_ROOT"; rm -rf "$t"
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
  local script name
  for name in claim queue mark; do
    script=$(mktemp); kit_script "$name" > "$script"
    for d in .claude/skills .agents/skills; do
      f="$main/$d/propose/scripts/$name.sh"
      assert_true "$d/propose/scripts/$name.sh byte for byte" diff -q "$script" "$f"
      assert_false "$d/propose/scripts/$name.sh has LF endings" grep -q $'\r' "$f"
    done
    rm -f "$script"
  done
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
  say "parallel ($host): /propose farewell banner shout"
  seed_docs "$main"
  assert_true "docs/05 generated with its eight sections" bash -c "[ \$(grep -c '^## [1-8]\. ' '$main/docs/05-Process.md') -eq 8 ]"
  local cmd; cmd=$(command_for "$host" propose "farewell banner shout")
  local prompt="$cmd
Decide alone: answer every question with your own recommendation and write it on the page as your answer. Never stop to ask me anything; a question a subagent reports, answer the same way and resume it. Build nothing."
  if [ "$DRY" -eq 1 ]; then echo "  would run in $main: $host <<< '$prompt'"; return; fi
  run_host "$host" "$main" "$c" "$prompt" > "$c/parallel-$host.log" 2>&1 || true

  for s in farewell banner; do
    assert_true "worktree for $s" test -d "$wt/$s"
    assert_true "branch focus-kit/$s pushed" branch_has "$main" "$s"
    assert_true "page work/$s.md in its worktree" test -f "$wt/$s/work/$s.md"
    if grep -q "^\[>\] $s" "$wt/$s/docs/06-Queue.md" 2>/dev/null; then ok "$s is [>] on its branch"
    elif grep -q "^\[~\] $s" "$wt/$s/docs/06-Queue.md" 2>/dev/null; then warn "$s left [~]: definition incomplete"
    else fail "$s not marked on its branch"; fi
    assert_true "$s page records the answers as the agent's" grep -qiE "agent|decid|your call|recommendation" "$wt/$s/work/$s.md"
  done
  assert_false "shout (after farewell) has no worktree" test -d "$wt/shout"
  assert_false "shout has no branch" branch_has "$main" shout
  assert_true "shout line untouched on main" grep -q '^\[ \] shout' "$main/docs/06-Queue.md"
  assert_true "main's queue unchanged" bash -c "cd '$main' && git diff --quiet HEAD -- docs/06-Queue.md"
  assert_true "main's tree clean" bash -c "cd '$main' && [ -z \"\$(git status --porcelain)\" ]"
}

stage_apply() { # stage_apply <host> <container>
  local host=$1 c=$2 main=$2/main wt=$2/.focus-kit/worktrees
  say "apply ($host): /apply farewell banner from main/, subagents sent to the worktrees"
  local cmd; cmd=$(command_for "$host" apply "farewell banner")
  local prompt="$cmd
Decide alone: never stop to ask me anything; a question a subagent reports, answer with your recommendation and resume it. Do not commit."
  if [ "$DRY" -eq 1 ]; then echo "  would run in $main: $host <<< '$prompt'"; return; fi
  run_host "$host" "$main" "$c" "$prompt" > "$c/apply-$host.log" 2>&1 || true

  for s in farewell banner; do
    assert_true "$s: page moved to work/done/" test -f "$wt/$s/work/done/$s.md"
    assert_true "$s: verify green in its worktree" make -C "$wt/$s" verify
    assert_true "$s: line [x] in the staged queue" bash -c "cd '$wt/$s' && git diff --cached -- docs/06-Queue.md | grep -q '^+\[x\] $s'"
    assert_true "$s: changes staged, none committed" bash -c "cd '$wt/$s' && ! git diff --cached --quiet && [ \$(git rev-list --count origin/main..HEAD) -eq 0 ]"
    assert_true "$s: commit block on the page" grep -q '^```commit' "$wt/$s/work/done/$s.md"
  done
  assert_true "main's tree clean" bash -c "cd '$main' && [ -z \"\$(git status --porcelain)\" ]"
}

# portuguese changes src/greet.sh, which farewell changed in a worktree that
# is built and not merged: /apply must stop before its first edit (docs/05
# §4). The harness error of 2026-10-25: two pages sharing a file in the
# parallel fixture, and the apply stage requiring both built.
stage_overlap() { # stage_overlap <host> <container>
  local host=$1 c=$2 main=$2/main wt=$2/.focus-kit/worktrees
  say "overlap ($host): /propose portuguese, then /apply portuguese against farewell's unmerged build"
  local cmd; cmd=$(command_for "$host" propose "portuguese")
  local prompt="$cmd
Decide alone: answer every question with your own recommendation and write it on the page as your answer. Never stop to ask me anything. Build nothing."
  if [ "$DRY" -eq 1 ]; then echo "  would run in $main: $host <<< '$prompt'"; return; fi
  run_host "$host" "$main" "$c" "$prompt" > "$c/overlap-propose-$host.log" 2>&1 || true
  assert_true "portuguese is [>] on its branch" grep -q '^\[>\] portuguese' "$wt/portuguese/docs/06-Queue.md"
  cmd=$(command_for "$host" apply "portuguese")
  prompt="$cmd
Decide alone: never stop to ask me anything. Do not commit."
  run_host "$host" "$main" "$c" "$prompt" > "$c/overlap-apply-$host.log" 2>&1 || true
  assert_false "portuguese not taken to [*]: farewell's unmerged build touches its file" grep -q '^\[\*\] portuguese' "$wt/portuguese/docs/06-Queue.md"
  assert_true "src/greet.sh unchanged in portuguese's worktree" git -C "$wt/portuguese" diff --quiet HEAD -- src/greet.sh
  assert_true "no page in work/done/ for portuguese" test ! -f "$wt/portuguese/work/done/portuguese.md"
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
      parallel|apply|overlap|all) stage_parallel "$host" "$C" ;;
    esac
    case $STAGE in
      apply|overlap|all) stage_apply "$host" "$C" ;;
    esac
    case $STAGE in
      overlap|all) stage_overlap "$host" "$C" ;;
    esac
    if [ "$KEEP" -eq 1 ] || [ "$FAIL" -gt 0 ]; then echo "  kept: $C (logs: $C/*.log)"; else rm -rf "$C"; fi
  done
fi

summary
