# focus-kit: can a skill script run on a Windows machine that has git and
# nothing else? Run with: pwsh -NoProfile -File windows.ps1 [-Claim <claim.sh>]
# Builds a throwaway repository under $env:TEMP, runs each case, prints
# ok/FAIL lines, removes the folder. Changes nothing outside it. With
# -Claim, the kit's claim.sh (extracted from SETUP.md §3.6) runs too,
# against a local bare remote.
param([string]$Claim)
$ErrorActionPreference = 'Continue'
$fails = 0
function Say($name, $ok, $detail) {
  if ($ok) { "ok   $name" } else { $script:fails++; "FAIL $name" }
  if ($detail) { ($detail | Out-String).TrimEnd() -split "`n" | ForEach-Object { "     $_" } }
}

"machine: $env:COMPUTERNAME, pwsh $($PSVersionTable.PSVersion), $(git --version)"
"PATH has sh: $([bool](Get-Command sh -ErrorAction SilentlyContinue)); bash: $([bool](Get-Command bash -ErrorAction SilentlyContinue))"
"effective core.autocrlf: $(git config --get core.autocrlf)"

$root = Join-Path $env:TEMP ("fk-alias-" + [guid]::NewGuid().ToString('N').Substring(0, 8))
New-Item -ItemType Directory -Path $root | Out-Null
Set-Location $root
git init -q -b main .
git config user.name test
git config user.email test@test
New-Item -ItemType Directory scripts | Out-Null

$sh = @'
#!/bin/sh
printf 'sh ok: arg=%s\n' "$1"
printf 'toplevel=%s\n' "$(git rev-parse --show-toplevel)"
printf 'uname=%s\n' "$(uname -s)"
awk 'BEGIN { print "awk ok" }'
'@
$sh = $sh.Replace("`r`n", "`n") + "`n"
[IO.File]::WriteAllText("$root\scripts\hello.sh", $sh)

# 1. From PowerShell, the one-line form the skill would carry.
$out = git -c "alias.fk=!sh scripts/hello.sh" fk slug-one 2>&1
Say "pwsh: git alias runs sh script" ($out -join "`n" -match 'sh ok: arg=slug-one') $out

# 2. From cmd.exe, through a batch file so the quoting is cmd's own.
[IO.File]::WriteAllText("$root\t2.cmd", "@git -c `"alias.fk=!sh scripts/hello.sh`" fk slug-two`r`n")
$out = cmd /c t2.cmd 2>&1
Say "cmd: git alias runs sh script" ($out -join "`n" -match 'sh ok: arg=slug-two') $out

# 3. CRLF: commit the script, check it out again under autocrlf, run it.
git add scripts/hello.sh | Out-Null
git commit -q -m "script" | Out-Null
Remove-Item scripts/hello.sh
git checkout -q -- scripts/hello.sh
$crlf = [IO.File]::ReadAllText("$root\scripts\hello.sh").Contains("`r")
"     after checkout, file has CR: $crlf"
$out = git -c "alias.fk=!sh scripts/hello.sh" fk slug-three 2>&1
Say "checkout without .gitattributes: script still runs" ($out -join "`n" -match 'sh ok: arg=slug-three') $out

# 4. The same with `*.sh text eol=lf` in .gitattributes.
[IO.File]::WriteAllText("$root\.gitattributes", "*.sh text eol=lf`n")
git add --renormalize . | Out-Null
git add .gitattributes | Out-Null
git commit -q -m "attributes" | Out-Null
Remove-Item scripts/hello.sh
git checkout -q -- scripts/hello.sh
$crlf = [IO.File]::ReadAllText("$root\scripts\hello.sh").Contains("`r")
"     after checkout, file has CR: $crlf"
$out = git -c "alias.fk=!sh scripts/hello.sh" fk slug-four 2>&1
Say "checkout with .gitattributes eol=lf: script runs" ($out -join "`n" -match 'sh ok: arg=slug-four') $out

# 5. In a worktree, the alias runs from the worktree's own top level.
git worktree add -q "$root\wt" -b wt 2>&1 | Out-Null
Push-Location "$root\wt"
$out = git -c "alias.fk=!sh scripts/hello.sh" fk slug-five 2>&1
Pop-Location
Say "worktree: toplevel is the worktree" ($out -join "`n" -match 'toplevel=.*[/\\]wt') $out

# 6. The PowerShell twin, under both PowerShell 7 and Windows PowerShell 5.1.
$ps = "param([string]`$Slug)`n`"ps ok: arg=`$Slug`"`n`"toplevel=`$(git rev-parse --show-toplevel)`"`n"
[IO.File]::WriteAllText("$root\scripts\hello.ps1", $ps)
$out = pwsh -NoProfile -File scripts/hello.ps1 slug-six 2>&1
Say "pwsh 7: .ps1 twin runs" ($out -join "`n" -match 'ps ok: arg=slug-six') $out
if (Get-Command powershell.exe -ErrorAction SilentlyContinue) {
  "     5.1 execution policy: $(powershell.exe -NoProfile -Command Get-ExecutionPolicy)"
  $out = powershell.exe -NoProfile -File scripts/hello.ps1 slug-seven 2>&1
  # A finding, not a failure: the kit ships no .ps1, and this is why.
  if (($out -join "`n") -match 'ps ok: arg=slug-seven') { "ok   Windows PowerShell 5.1: .ps1 twin runs" }
  else { "info Windows PowerShell 5.1 blocks a .ps1 under this policy (the kit ships none)" }
  $out = powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/hello.ps1 slug-eight 2>&1
  Say "Windows PowerShell 5.1 with -ExecutionPolicy Bypass: .ps1 twin runs" ($out -join "`n" -match 'ps ok: arg=slug-eight') $out
} else { "skip Windows PowerShell 5.1: not found" }

Set-Location $env:TEMP
git -C $root worktree remove --force "$root\wt" 2>&1 | Out-Null
Remove-Item -Recurse -Force $root
"removed $root"

# 7. The kit's claim.sh through the alias, against a local bare remote.
if ($Claim -and (Test-Path $Claim)) {
  $c = Join-Path $env:TEMP ("fk-claim-" + [guid]::NewGuid().ToString('N').Substring(0, 8))
  New-Item -ItemType Directory -Path $c | Out-Null
  git init -q --bare "$c\origin.git"
  git clone -q "$c\origin.git" "$c\main" 2>&1 | Out-Null
  Push-Location "$c\main"
  git config user.name test
  git config user.email test@test
  New-Item -ItemType Directory -Force ".agents\skills\propose\scripts" | Out-Null
  Copy-Item $Claim ".agents\skills\propose\scripts\claim.sh"
  git add -A | Out-Null
  git commit -q -m kit | Out-Null
  git branch -q -M main
  git push -q -u origin main 2>&1 | Out-Null
  $out = git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk farewell worktree .focus-kit focus-kit/ 2>&1
  Say "claim.sh: worktree, new line, from PowerShell" (($out -join "`n") -match 'claim: new') $out
  $wt = (($out | Where-Object { "$_" -like 'path:*' }) -join '') -replace '^path: ', ''
  Say "claim.sh: the printed path opens in PowerShell" ([bool]$wt -and (Test-Path $wt)) $wt
  Say "claim.sh: branch on origin" ([bool](git ls-remote --heads origin refs/heads/focus-kit/farewell)) ''
  $out = git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk farewell worktree .focus-kit focus-kit/ 2>&1
  Say "claim.sh: rerun reports existing" (($out -join "`n") -match 'claim: existing') $out
  if ($wt) {
    Push-Location $wt
    $out = git -c "alias.fk=!sh .agents/skills/propose/scripts/claim.sh" fk third worktree .focus-kit focus-kit/ 2>&1
    Pop-Location
    Say "claim.sh: refused inside a worktree" (($out -join "`n") -match 'error: run from main/') $out
  }
  [IO.File]::WriteAllText("$c\main\t7.cmd", "@git -c `"alias.fk=!sh .agents/skills/propose/scripts/claim.sh`" fk second branch`r`n")
  $out = cmd /c t7.cmd 2>&1
  Say "claim.sh: branch per delivery, from cmd" (($out -join "`n") -match 'claim: new') $out
  Say "claim.sh: checkout switched to the branch" ((git branch --show-current) -eq 'second') ''
  Pop-Location
  Set-Location $env:TEMP
  if ($wt) { git -C "$c\main" worktree remove --force $wt 2>&1 | Out-Null }
  Remove-Item -Recurse -Force $c
  "removed $c"
} else { "skip claim.sh: pass -Claim <path to claim.sh>" }
"failures: $fails"
exit $fails
