# `.\scripts\calculate.ps1` - Functions for calculating astrology information

# Define constants
$script:tzolkinNames = @("Imix", "Ik", "Akbal", "Kan", "Chicchan", "Cimi", "Manik", "Lamat", "Muluc", "Oc", 
                         "Chuen", "Eb", "Ben", "Ix", "Men", "Cib", "Caban", "Etznab", "Cauac", "Ahau")
$script:dreamspellSeals = @("Dragon", "Wind", "Night", "Seed", "Serpent", "World-Bridger", "Hand", "Star", 
                            "Moon", "Dog", "Monkey", "Human", "Skywalker", "Wizard", "Eagle", "Warrior", 
                            "Earth", "Mirror", "Storm", "Sun")
$script:chineseAnimals = @("Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", 
                           "Rooster", "Dog", "Pig")
$script:chineseMonthAnimals = @("Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", 
                                "Dog", "Pig", "Rat", "Ox")
$script:chineseNewYearDates = @{
    2024 = [datetime]"2024-02-10"
    2025 = [datetime]"2025-01-29"
    2026 = [datetime]"2026-02-17"
}

# Calculate Julian Day Number
function Get-JulianDay {
    param (
        [Parameter(Mandatory = $true)][datetime]$Date
    )
    $a = [math]::Floor((14 - $Date.Month) / 12)
    $y = $Date.Year + 4800 - $a
    $m = $Date.Month + 12 * $a - 3
    $jd = $Date.Day + [math]::Floor((153 * $m + 2) / 5) + 365 * $y + [math]::Floor($y / 4) - 
          [math]::Floor($y / 100) + [math]::Floor($y / 400) - 32045
    return $jd
}

# Calculate Tzolkin info (adjusted reference JD)
function Get-TzolkinInfo {
    param (
        [Parameter(Mandatory = $true)][int]$JulianDay
    )
    # GMT Correlation: 4 Ahau = JD 584283 (August 11, 3114 BCE)
    $refJD = 584283
    $refNumber = 4  # Tzolkin number for reference date
    $refDayIndex = 19  # Ahau's position in the array (0-based)

    $daysSinceRef = $JulianDay - $refJD
    $tzolkinNumber = (($daysSinceRef + $refNumber - 1) % 13) + 1
    $dayIndex = ($daysSinceRef + $refDayIndex) % 20
    $tzolkinName = $script:tzolkinNames[$dayIndex]

    return @{
        Number = $tzolkinNumber
        Name   = $tzolkinName
    }
}

# Calculate Dreamspell info (adjusted reference JD)
function Get-DreamspellInfo {
    param (
        [Parameter(Mandatory = $true)][int]$JulianDay
    )
    # Reference Julian Day set to March 18, 1988, to align with AstroDreamAdvisor.Com
    $refJD = 2447240
    $daysSinceRef = $JulianDay - $refJD

    # Calculate kin, handling negative daysSinceRef
    $kin = $daysSinceRef % 260
    if ($kin -lt 0) { $kin += 260 }
    $kin += 1

    $tone = (($kin - 1) % 13) + 1
    $sealIndex = ($kin - 1) % 20
    $seal = $script:dreamspellSeals[$sealIndex]

    return @{
        Tone = $tone
        Seal = $seal
    }
}

# Calculate Chinese info (unchanged)
function Get-ChineseInfo {
    param (
        [Parameter(Mandatory = $true)][datetime]$Date,
        [Parameter(Mandatory = $true)][int]$Year
    )
    $monthAnimal = "Unknown"
    if ($chineseNewYearDates.ContainsKey($Year)) {
        $cnyDate = $chineseNewYearDates[$Year]
        $chineseYear = if ($Date -lt $cnyDate) { $Year - 1 } else { $Year }
    }
    else {
        $chineseYear = $Year
    }
    $animalIndex = ($chineseYear - 1924) % 12
    if ($animalIndex -lt 0) { $animalIndex += 12 }
    $yearAnimal = $chineseAnimals[$animalIndex]

    if ($chineseNewYearDates.ContainsKey($Year)) {
        $cnyDate = $chineseNewYearDates[$Year]
        $monthStart = $cnyDate
        $monthNumber = 1
        while ($monthStart.AddDays(29.5) -lt $Date) {
            $monthStart = $monthStart.AddDays(29.5)
            $monthNumber++
            if ($monthNumber -gt 13) { break }
        }
        $monthAnimal = $chineseMonthAnimals[($monthNumber - 1) % 12]
    }

    return @{
        YearAnimal  = $yearAnimal
        MonthAnimal = $monthAnimal
    }
}