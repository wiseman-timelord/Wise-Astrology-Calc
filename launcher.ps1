# `.\launcher.ps1` - Main script for the Wise-Astrology-Calc

# Import calculation functions
. "$PSScriptRoot\scripts\calculate.ps1"

# Set initial date to March 26, 2025
$today = [datetime]"2025-03-26"
$currentDate = $today

# Main loop for user interaction
while ($true) {
    # Calculate astrology information
    $jd = Get-JulianDay -Date $currentDate
    $tzolkinInfo = Get-TzolkinInfo -JulianDay $jd
    $dreamspellInfo = Get-DreamspellInfo -JulianDay $jd
    $year = $currentDate.Year
    $chineseInfo = Get-ChineseInfo -Date $currentDate -Year $year

    # Display the astrology information
    Clear-Host
    Write-Host "========================================================================================================================"
    Write-Host "    Wise-Astrology-Calc"
    Write-Host "========================================================================================================================"
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "Date: $($currentDate.ToString('yyyy/MM/dd'))"
    Write-Host ""
    Write-Host "    Power: $($dreamspellInfo.Seal) $($dreamspellInfo.Tone)"
    Write-Host ""
    Write-Host "    Ability: $($tzolkinInfo.Name) $($tzolkinInfo.Number)"
    Write-Host ""
    Write-Host "    Personality: $($chineseInfo.MonthAnimal)"
    Write-Host ""
    Write-Host "    Species: $($chineseInfo.YearAnimal)"
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "------------------------------------------------------------------------------------------------------------------------"

    # Handle user input on the same line
    $input = Read-Host -Prompt "Selection; New Date = 0000/00/00, Todays Date = D, Exit Program = X"
    switch ($input) {
        "X" { exit }
        "D" { $currentDate = $today }
        default {
            try {
                $newDate = [datetime]::ParseExact($input, "yyyy/MM/dd", $null)
                $currentDate = $newDate
            }
            catch {
                Write-Host "Invalid date format. Please use YYYY/MM/DD."
                Start-Sleep -Seconds 2
            }
        }
    }
}