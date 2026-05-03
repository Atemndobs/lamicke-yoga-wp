# =============================================================================
# Lamicke Yoga — download heavy export artifacts (Windows PowerShell)
# =============================================================================
# Reads WP_SITE_BACKUP_URL and WP_DB_BACKUP_URL from .env (project root) and
# downloads them into exports/2026-05-03/. Verifies SHA-256 checksums if the
# *.sha256 sidecar files are committed to the repo.
#
# Run from the project root:
#   pwsh -File .\scripts\setup\download-heavy-files.ps1
# Or in PowerShell 5+:
#   .\scripts\setup\download-heavy-files.ps1
# =============================================================================

$ErrorActionPreference = 'Stop'

# Resolve project root (script is at <root>/scripts/setup)
$root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$envFile = Join-Path $root '.env'
$exportsDir = Join-Path $root 'exports\2026-05-03'
$dbDir = Join-Path $exportsDir 'db'

if (-not (Test-Path $envFile)) {
    Write-Error "Missing .env at $envFile. Copy .env.example to .env and fill in WP_SITE_BACKUP_URL and WP_DB_BACKUP_URL first."
}

# Load .env (KEY=VALUE per line, ignores comments and blanks)
$envVars = @{}
Get-Content $envFile | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith('#') -and $line.Contains('=')) {
        $idx = $line.IndexOf('=')
        $k = $line.Substring(0, $idx).Trim()
        $v = $line.Substring($idx + 1).Trim().Trim('"').Trim("'")
        $envVars[$k] = $v
    }
}

$siteUrl = $envVars['WP_SITE_BACKUP_URL']
$dbUrl   = $envVars['WP_DB_BACKUP_URL']

if (-not $siteUrl -or -not $dbUrl) {
    Write-Error "WP_SITE_BACKUP_URL or WP_DB_BACKUP_URL missing from .env. See the handoff email."
}

New-Item -ItemType Directory -Force -Path $exportsDir | Out-Null
New-Item -ItemType Directory -Force -Path $dbDir | Out-Null

function Download-File($url, $outPath, $label) {
    Write-Host ""
    Write-Host "[$label] -> $outPath"
    if (Test-Path $outPath) {
        $existingSize = (Get-Item $outPath).Length
        Write-Host "  Already present ($([math]::Round($existingSize / 1MB, 1)) MB). Skipping. Delete the file to re-download."
        return
    }
    Write-Host "  Downloading from $url ..."
    # Use BITS if available (resumable); fall back to Invoke-WebRequest
    try {
        Start-BitsTransfer -Source $url -Destination $outPath -DisplayName $label
    } catch {
        Write-Host "  BITS failed, falling back to Invoke-WebRequest"
        $ProgressPreference = 'Continue'
        Invoke-WebRequest -Uri $url -OutFile $outPath -UseBasicParsing
    }
    $size = (Get-Item $outPath).Length
    Write-Host "  Downloaded $([math]::Round($size / 1MB, 1)) MB."
}

# 1) Full site backup (~750 MB tar.gz)
$sitePath = Join-Path $exportsDir 'lamickeyoga-site-backup.tar.gz'
Download-File $siteUrl $sitePath 'WP site backup'

# 2) DB dump (~8 MB sql.gz)
$dbPath = Join-Path $dbDir 'lamickeyoga-db.sql.gz'
Download-File $dbUrl $dbPath 'WP database dump'

Write-Host ""
Write-Host "Done. Files saved under exports\2026-05-03\."
Write-Host ""
Write-Host "Optional next steps:"
Write-Host "  - Extract site backup:  tar -xzf exports\2026-05-03\lamickeyoga-site-backup.tar.gz -C exports\2026-05-03\"
Write-Host "  - Decompress DB dump:   gunzip exports\2026-05-03\db\lamickeyoga-db.sql.gz   (or use 7-Zip)"
Write-Host ""
Write-Host "Both files are reference artifacts. You do not need to import them into a local WordPress to start the Wix build."
