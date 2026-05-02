# launcher.ps1 - Startup, shutdown, mainLoop, globals
if ($Host.Name -eq 'ConsoleHost') {
    $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size (80, 42)
}

$rootPath    = Split-Path -Parent $MyInvocation.MyCommand.Definition
$scriptPath  = Join-Path $rootPath 'scripts'
$calcFile    = Join-Path $scriptPath 'calculate.ps1'
$displayFile = Join-Path $scriptPath 'displays.ps1'

foreach ($f in @($calcFile, $displayFile)) {
    if (-not (Test-Path -LiteralPath $f)) { throw "Missing required file: $f" }
}

try {
    . $calcFile
    . $displayFile
} catch {
    throw "Failed to load scripts: $_"
}

if (-not (Get-Command Show-UnifiedDisplay -ErrorAction SilentlyContinue)) {
    throw "Function 'Show-UnifiedDisplay' not found in displays.ps1"
}

try   { $global:currentDate = [DateTime]::Today }
catch { $global:currentDate = [DateTime]'2026-01-15' }

while ($true) {
    Show-UnifiedDisplay -DisplayDate $global:currentDate
    $in = Read-Host "Selection; Refresh Display, Exit Program = x"
    switch ($in.Trim().ToUpper()) {
        'X'    { exit }
        ''     { continue }
        default {
            try { $global:currentDate = [DateTime]::ParseExact($in, 'yyyy/MM/dd', $null) }
            catch { <# Invalid date -> silently refresh #> }
        }
    }
}