# Creates NEW public portfolio repositories from the existing public lab.
# No changes to the original repo, no force pushes, no private repo access.
# Requires Git and GitHub CLI. Sign in with gh auth login first.
$ErrorActionPreference = 'Stop'
$owner = 'NeuraX-JB'
$source = 'https://github.com/NeuraX-JB/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter.git'
foreach ($command in @('git','gh')) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) { throw "Install $command first." }
}
function Run-Git {
    param([string[]]$ArgsList)
    & git @ArgsList
    if ($LASTEXITCODE -ne 0) { throw "git failed: $($ArgsList -join ' ')" }
}
$login = (& gh api user --jq .login)
if ($LASTEXITCODE -ne 0 -or "$login".Trim() -ine $owner) { throw "Sign in to GitHub CLI as $owner before continuing." }
$work = Join-Path ([System.IO.Path]::GetTempPath()) ('john-barreto-portfolio-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $work | Out-Null
$sourceDir = Join-Path $work 'source'
Run-Git @('clone','--depth','1',$source,$sourceDir)
$manifest = Get-Content -Raw (Join-Path $sourceDir 'portfolio/projects.json') | ConvertFrom-Json
$utf8 = New-Object System.Text.UTF8Encoding($false)
function Write-Utf8([string]$path,[string]$content) {
    [System.IO.File]::WriteAllText($path,$content,$utf8)
}
function Publish-New([string]$name,[string]$description,[string]$dir) {
    & gh repo view "$owner/$name" --json name 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Already exists; skipped without modifying: $owner/$name"
        return
    }
    Run-Git @('-C',$dir,'init','-b','main')
    Run-Git @('-C',$dir,'add','.')
    Run-Git @('-C',$dir,'commit','-m','Publish individual research portfolio project')
    & gh repo create "$owner/$name" --public --description $description --source $dir --remote origin --push
    if ($LASTEXITCODE -ne 0) { throw "Could not publish $owner/$name. Existing repositories are not overwritten. Working files: $dir" }
    Write-Host "Published: https://github.com/$owner/$name"
}
foreach ($p in $manifest.projects) {
    $dir = Join-Path $work $p.name
    New-Item -ItemType Directory -Path $dir | Out-Null
    foreach ($rel in $p.paths) {
        $from = Join-Path $sourceDir $rel
        $to = Join-Path $dir $rel
        if (-not (Test-Path -LiteralPath $from)) { throw "Missing source path: $rel" }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $to) | Out-Null
        Copy-Item -LiteralPath $from -Destination $to -Recurse
    }
    Copy-Item -LiteralPath (Join-Path $sourceDir "portfolio/templates/$($p.name).md") -Destination (Join-Path $dir 'README.md')
    $lab = Join-Path $dir 'lab'
    if (Test-Path -LiteralPath $lab) {
        Write-Utf8 (Join-Path $lab 'README.md') "# Research lab documentation`n[Canonical research lab](https://github.com/NeuraX-JB/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/tree/main/lab)`n"
        Write-Utf8 (Join-Path $lab 'index.html') '<!doctype html><html lang="en"><meta charset="utf-8"><title>Research lab</title><p><a href="https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/">Visit the live research lab</a></p></html>'
    }
    Publish-New $p.name $p.description $dir
}
$profileDir = Join-Path $work 'profile'
New-Item -ItemType Directory -Path $profileDir | Out-Null
Copy-Item -LiteralPath (Join-Path $sourceDir 'portfolio/profile-README.md') -Destination (Join-Path $profileDir 'README.md')
Publish-New $owner 'John Barreto | Independent Natural Gas Research Portfolio' $profileDir
Write-Host "Complete. Review https://github.com/$owner and pin the six projects manually."
Write-Host "Set your profile display name to John Barreto in https://github.com/settings/profile (the script does not alter account settings)."
Write-Host "Working copies retained at $work"
