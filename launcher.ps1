# launcher.ps1 - Main script for Wise-Astrology-Calc

# Import calculation functions
. "$PSScriptRoot\scripts\calculate.ps1"

# Set initial date
$today = [datetime]"2025-03-26"
$currentDate = $today

# Main loop
while ($true) {
    # Calculate astrology information
    $jd = Get-JulianDay -Date $currentDate
    $tzolkinInfo = Get-TzolkinInfo -JulianDay $jd
    $dreamspellInfo = Get-DreamspellInfo -JulianDay $jd
    $year = $currentDate.Year
    $chineseInfo = Get-ChineseInfo -Date $currentDate -Year $year

    # Display astrology information with descriptions
    Clear-Host
    Write-Host "========================================================================================================================"
    Write-Host "    Wise-Astrology-Calc"
    Write-Host "========================================================================================================================"
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host ""	
    Write-Host "Calculated Date: $($currentDate.ToString('yyyy/MM/dd'))"
    Write-Host ""
    Write-Host "Power/Gift: $($dreamspellInfo.Seal) $($dreamspellInfo.Tone)"
    Write-Host "Details: $($dreamspellInfo.Description)"
    Write-Host ""
    Write-Host "Role/Ability: $($tzolkinInfo.Name) $($tzolkinInfo.Number)"
    Write-Host "Details: $($tzolkinInfo.Description)"
    Write-Host ""
    Write-Host "Persona/Head: $($chineseInfo.MonthAnimal)"
    Write-Host "Details: $($chineseInfo.MonthDescription)"
    Write-Host ""
    Write-Host "Physique/Body: $($chineseInfo.YearAnimal)"
    Write-Host "Details: $($chineseInfo.YearDescription)"
    Write-Host ""
	Write-Host ""
	Write-Host ""
	Write-Host ""
	Write-Host ""
    Write-Host "------------------------------------------------------------------------------------------------------------------------"

    # User input
    $input = Read-Host -Prompt "Selection; New Date = 0000/00/00, Today's Date = D, Exit Program = X"
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