# calculate.ps1 - Functions for calculating astrology information

# Load descriptions from astrology.ps1
. "$PSScriptRoot\astrology.ps1"

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

# Calculate Tzolkin info
function Get-TzolkinInfo {
    param (
        [Parameter(Mandatory = $true)][int]$JulianDay
    )
    $refJD = 584283  # 4 Ahau, August 11, 3114 BCE
    $refNumber = 4   # Tzolkin number on reference date
    $refDayIndex = 19  # Ahau's index

    $daysSinceRef = $JulianDay - $refJD
    $tzolkinNumber = (($daysSinceRef + $refNumber - 1) % 13) + 1
    $dayIndex = ($daysSinceRef + $refDayIndex) % 20
    $tzolkinName = $script:tzolkinNames[$dayIndex]

    # Add description
    $description = $script:tzolkinDayDescriptions[$dayIndex]

    return @{
        Number = $tzolkinNumber
        Name   = $tzolkinName
        Description = $description
    }
}

# Calculate Dreamspell info
function Get-DreamspellInfo {
    param (
 
   
    [Parameter(Mandatory = $true)][int]$JulianDay
    )
    $refJD = 2447240  # March 18, 1988, for alignment
    $daysSinceRef = $JulianDay - $refJD
    $kin = $daysSinceRef % 260
    if ($kin -lt 0) { $kin += 260 }
    $kin += 1

    $tone = (($kin - 1) % 13) + 1
    $sealIndex = ($kin - 1) % 20
    $seal = $script:dreamspellSeals[$sealIndex]

    # Add description
    $description = $script:dreamspellSealDescriptions[$sealIndex]

    return @{
        Tone = $tone
        Seal = $seal
        Description = $description
    }
}

# Helper function to get month animal based on approximate solar term date ranges
function Get-MonthAnimal {
    param (
        [datetime]$Date
    )
    $year = $Date.Year
    $ranges = @(
        @{ Start = [datetime]"$year-01-01"; End = [datetime]"$year-01-05"; Animal = "Rat" },  # 11th month (approx.)
        @{ Start = [datetime]"$year-01-06"; End = [datetime]"$year-02-03"; Animal = "Ox" },   # 12th month
        @{ Start = [datetime]"$year-02-04"; End = [datetime]"$year-03-05"; Animal = "Tiger" }, # 1st month
        @{ Start = [datetime]"$year-03-06"; End = [datetime]"$year-04-04"; Animal = "Rabbit" },# 2nd month
        @{ Start = [datetime]"$year-04-05"; End = [datetime]"$year-05-05"; Animal = "Dragon" },# 3rd month
        @{ Start = [datetime]"$year-05-06"; End = [datetime]"$year-06-05"; Animal = "Snake" }, # 4th month
        @{ Start = [datetime]"$year-06-06"; End = [datetime]"$year-07-06"; Animal = "Horse" }, # 5th month
        @{ Start = [datetime]"$year-07-07"; End = [datetime]"$year-08-06"; Animal = "Goat" },  # 6th month
        @{ Start = [datetime]"$year-08-07"; End = [datetime]"$year-09-07"; Animal = "Monkey" },# 7th month
        @{ Start = [datetime]"$year-09-08"; End = [datetime]"$year-10-07"; Animal = "Rooster" },# 8th month
        @{ Start = [datetime]"$year-10-08"; End = [datetime]"$year-11-06"; Animal = "Dog" },   # 9th month
        @{ Start = [datetime]"$year-11-07"; End = [datetime]"$year-12-06"; Animal = "Pig" },   # 10th month
        @{ Start = [datetime]"$year-12-07"; End = [datetime]"$year-12-31"; Animal = "Rat" }    # 11th month
    )
    foreach ($range in $ranges) {
        if ($Date -ge $range.Start -and $Date -le $range.End) {
            return $range.Animal
        }
    }
    return "Unknown"
}

# Calculate Chinese info
function Get-ChineseInfo {
    param (
        [Parameter(Mandatory = $true)][datetime]$Date,
        [Parameter(Mandatory = $true)][int]$Year
    )
    # Determine Chinese year
    if ($chineseNewYearDates.ContainsKey($Year)) {
        $cnyDate = $chineseNewYearDates[$Year]
        $chineseYear = if ($Date -lt $cnyDate) { $Year - 1 } else { $Year }
    }
    else {
        $chineseYear = $Year
    }
    $animalIndex = ($chineseYear - 1924) % 12
    if ($animalIndex -lt 0) { $animalIndex += 12 }
    $yearAnimal = $script:chineseAnimals[$animalIndex]

    # Determine month animal using approximate ranges
    $monthAnimal = Get-MonthAnimal -Date $Date

    # Add descriptions
    $monthDescription = $script:chinesePersonalityDescriptions[$monthAnimal]
    $yearDescription = $script:chinesePhysiqueDescriptions[$yearAnimal]

    return @{
        YearAnimal = $yearAnimal
        MonthAnimal = $monthAnimal
        MonthDescription = $monthDescription
        YearDescription = $yearDescription
    }
}