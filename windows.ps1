# Rising Tides Skills Pack — Windows Bootstrap
# This script installs gh CLI, authenticates, clones the private repo, and runs setup.
# Safe to run multiple times. Contains no product content — just bootstrap logic.
# Run in PowerShell as Administrator.

$ErrorActionPreference = "Stop"

$CloneDir = "$env:TEMP\rising-tides"
$Repo = "SunsetSystemsAI/rising-tides-starter-pack"

Write-Host ""
Write-Host "============================================" -ForegroundColor Blue
Write-Host "   Rising Tides — Windows Bootstrap         " -ForegroundColor Blue
Write-Host "============================================" -ForegroundColor Blue
Write-Host ""

# --- Check for Administrator ---
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "WARNING: Not running as Administrator." -ForegroundColor Yellow
    Write-Host "Some installations (like winget) may require admin privileges." -ForegroundColor Yellow
    Write-Host "If you hit errors, re-run PowerShell as Administrator." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/N)"
    if ($continue -ne "y" -and $continue -ne "Y") { exit 0 }
}

# --- Step 1: Check for winget ---
$hasWinget = $false
try {
    $null = Get-Command winget -ErrorAction Stop
    $hasWinget = $true
    Write-Host "[OK] winget available" -ForegroundColor Green
} catch {
    Write-Host "[!!] winget not found." -ForegroundColor Red
    Write-Host "     Windows 11 includes winget by default." -ForegroundColor Yellow
    Write-Host "     Windows 10: Install 'App Installer' from the Microsoft Store:" -ForegroundColor Yellow
    Write-Host "     https://apps.microsoft.com/detail/9nblggh4nns1" -ForegroundColor Yellow
    exit 1
}

# --- Step 2: Install GitHub CLI if missing ---
$hasGh = $false
try {
    $null = Get-Command gh -ErrorAction Stop
    $hasGh = $true
    Write-Host "[OK] GitHub CLI already installed" -ForegroundColor Green
} catch {
    Write-Host "Installing GitHub CLI..." -ForegroundColor Yellow
    winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    try {
        $null = Get-Command gh -ErrorAction Stop
        $hasGh = $true
        Write-Host "[OK] GitHub CLI installed" -ForegroundColor Green
    } catch {
        Write-Host "[!!] GitHub CLI installed but not in PATH. Close and reopen PowerShell, then re-run this script." -ForegroundColor Red
        exit 1
    }
}

# --- Step 3: Authenticate if needed ---
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "You need to authenticate with GitHub to access the private repo." -ForegroundColor Yellow
    Write-Host ""
    gh auth login
    Write-Host ""
    Write-Host "[OK] GitHub authenticated" -ForegroundColor Green
} else {
    Write-Host "[OK] GitHub already authenticated" -ForegroundColor Green
}

# --- Step 4: Clone the private repo ---
Write-Host ""
Write-Host "Cloning Rising Tides repo..." -ForegroundColor Yellow
if (Test-Path $CloneDir) { Remove-Item -Recurse -Force $CloneDir }
gh repo clone $Repo $CloneDir
Write-Host "[OK] Repo cloned to $CloneDir" -ForegroundColor Green

# --- Step 5: Run the real setup script ---
Write-Host ""
Write-Host "Launching setup..." -ForegroundColor Blue
Write-Host ""
& "$CloneDir\New user starter pack\scripts\setup-windows.ps1"

# --- Step 6: Clean up ---
Write-Host ""
Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
Remove-Item -Recurse -Force $CloneDir -ErrorAction SilentlyContinue
Write-Host "[OK] Cleanup complete" -ForegroundColor Green
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   All done! Start Claude Code and try:     " -ForegroundColor Green
Write-Host "   /recommend skills                        " -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
