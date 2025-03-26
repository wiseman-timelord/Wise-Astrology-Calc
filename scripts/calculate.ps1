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

# Calculate Julian Day Number (current formula works for recent dates, keep as is)
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

# Calculate Tzolkin info (adjusted for astrodreamadvisor.com)
function Get-TzolkinInfo {
    param (
        [Parameter(Mandatory = $true)][int]$JulianDay
    )
    # Reference: January 0, 1900, JD 2415020 = 4 Ahau (Number 4, Day Sign 20, index 19 for 0-based)
    $refJD = 2415020
    $refNumber = 4
    $refDayIndex = 19  # Ahau is day 20, 0-based index 19

    $daysSinceRef = $JulianDay - $refJD
    $tzolkinNumber = (($daysSinceRef + $refNumber - 1) % 13) + 1
    $dayIndex = (($daysSinceRef + $refDayIndex) % 20)
    $tzolkinName = $tzolkinNames[$dayIndex]

    return @{
        Number = $tzolkinNumber
        Name   = $tzolkinName
    }
}

# Calculate Dreamspell info (adjusted for astrodreamadvisor.com)
function Get-DreamspellInfo {
    param (
        [Parameter(Mandatory = $true)][int]$JulianDay
    )
    # Reference: July 26, 1987, JD 2446992 = Kin 1 (Magnetic Dragon)
    $refJD = 2446992
    $daysSinceRef = $JulianDay - $refJD
    $kin = ($daysSinceRef % 260) + 1
    $tone = (($kin - 1) % 13) + 1
    $sealIndex = (($kin - 1) % 20)
    $seal = $dreamspellSeals[$sealIndex]

    return @{
        Tone = $tone
        Seal = $seal
    }
}

# Calculate Chinese info (unchanged, already correct)
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