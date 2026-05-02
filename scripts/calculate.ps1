# calculate.ps1 - Calculation, math, calendar conversions

$script:tzolkinNames = @('Imix','Ik','Akbal','Kan','Chicchan','Cimi','Manik','Lamat','Muluc','Oc','Chuen','Eb','Ben','Ix','Men','Cib','Caban','Etznab','Cauac','Ahau')
$script:dreamspellSeals = @('Dragon','Wind','Night','Seed','Serpent','World-Bridger','Hand','Star','Moon','Dog','Monkey','Human','Skywalker','Wizard','Eagle','Warrior','Earth','Mirror','Storm','Sun')
$script:chineseAnimals = @('Rat','Ox','Tiger','Rabbit','Dragon','Snake','Horse','Goat','Monkey','Rooster','Dog','Pig')
$script:chineseMonthAnimals = @('Tiger','Rabbit','Dragon','Snake','Horse','Goat','Monkey','Rooster','Dog','Pig','Rat','Ox')
$script:chineseNewYearDates = @{
    2024 = [datetime]'2024-02-10'
    2025 = [datetime]'2025-01-29'
    2026 = [datetime]'2026-02-17'
}

function Get-JulianDay {
    param([Parameter(Mandatory=$true)][datetime]$Date)
    $a = [math]::Floor((14 - $Date.Month) / 12)
    $y = $Date.Year + 4800 - $a
    $m = $Date.Month + 12 * $a - 3
    return $Date.Day + [math]::Floor((153 * $m + 2) / 5) + 365 * $y + [math]::Floor($y / 4) - [math]::Floor($y / 100) + [math]::Floor($y / 400) - 32045
}

function Get-DateFromJulianDay {
    param([Parameter(Mandatory=$true)][int]$JulianDay)
    $a = $JulianDay + 32044
    $b = [math]::Floor((4 * $a + 3) / 146097)
    $c = $a - [math]::Floor((146097 * $b) / 4)
    $d = [math]::Floor((4 * $c + 3) / 1461)
    $e = $c - [math]::Floor((1461 * $d) / 4)
    $m = [math]::Floor((5 * $e + 2) / 153)
    $day = $e - [math]::Floor((153 * $m + 2) / 5) + 1
    $month = $m + 3 - 12 * [math]::Floor($m / 10)
    $year = $b * 100 + $d - 4800 + [math]::Floor($m / 10)
    return [datetime]::new($year, $month, $day)
}

function Get-TzolkinInfo {
    param([Parameter(Mandatory=$true)][int]$JulianDay)
    $refJD = 584283
    $refNumber = 4
    $refDayIndex = 19
    $daysSinceRef = $JulianDay - $refJD

    $tzolkinNumber = (($daysSinceRef + $refNumber - 1) % 13) + 1
    $dayIndex = ($daysSinceRef + $refDayIndex) % 20

    return @{
        Number     = $tzolkinNumber
        Name       = $script:tzolkinNames[$dayIndex]
        DayIndex   = $dayIndex
        # Debug/Workings exposed for Role/Ability verification
        JD         = $JulianDay
        RefJD      = $refJD
        DaysDiff   = $daysSinceRef
        NumFormula = "(($daysSinceRef + $refNumber - 1) % 13) + 1 = $tzolkinNumber"
        DayFormula = "($daysSinceRef + $refDayIndex) % 20 = $dayIndex"
    }
}

function Get-DreamspellInfo {
    param([Parameter(Mandatory=$true)][int]$JulianDay)
    $date = Get-DateFromJulianDay $JulianDay
    $year = $date.Year; $month = $date.Month; $day = $date.Day
    $adjustedYear = if ($month -lt 7 -or ($month -eq 7 -and $day -lt 26)) { $year - 1 } else { $year }

    $diff = [Math]::Abs(1965 - $adjustedYear)
    $cycles = 1
    while ($diff % 4 -ne 0) { $cycles++; $diff++ }
    $yseal = 4 + 15 * ($cycles - 1)
    if ($yseal -eq 34) { $yseal = 14 }
    if ($yseal -eq 49) { $yseal = 9 }

    $diffYtone = $adjustedYear - 1967
    $ytone = (($diffYtone % 13 + 13) % 13) + 1

    $gmonth = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
    $daydist = 159; $loopstart = 1
    if ($month -gt 7) { $loopstart = 7; $daydist = 0 }
    elseif ($month -eq 7 -and $day -ge 26) { $loopstart = 7; $daydist = -25 }
    for ($i = $loopstart; $i -lt $month; $i++) { $daydist += $gmonth[$i] }
    $daydist += $day - 1

    $seal = $yseal; $tone = $ytone
    for ($i = 1; $i -le $daydist; $i++) { $seal = $seal % 20 + 1; $tone = $tone % 13 + 1 }
    return @{ Seal = $script:dreamspellSeals[$seal - 1]; Tone = $tone; SealIndex = $seal - 1 }
}

function Get-MonthAnimal {
    param([datetime]$Date)
    $year = $Date.Year
    $ranges = @(
        @{ Start = [datetime]"$year-01-01"; End = [datetime]"$year-01-05"; Animal = 'Rat' }
        @{ Start = [datetime]"$year-01-06"; End = [datetime]"$year-02-03"; Animal = 'Ox' }
        @{ Start = [datetime]"$year-02-04"; End = [datetime]"$year-03-05"; Animal = 'Tiger' }
        @{ Start = [datetime]"$year-03-06"; End = [datetime]"$year-04-04"; Animal = 'Rabbit' }
        @{ Start = [datetime]"$year-04-05"; End = [datetime]"$year-05-05"; Animal = 'Dragon' }
        @{ Start = [datetime]"$year-05-06"; End = [datetime]"$year-06-05"; Animal = 'Snake' }
        @{ Start = [datetime]"$year-06-06"; End = [datetime]"$year-07-06"; Animal = 'Horse' }
        @{ Start = [datetime]"$year-07-07"; End = [datetime]"$year-08-06"; Animal = 'Goat' }
        @{ Start = [datetime]"$year-08-07"; End = [datetime]"$year-09-07"; Animal = 'Monkey' }
        @{ Start = [datetime]"$year-09-08"; End = [datetime]"$year-10-07"; Animal = 'Rooster' }
        @{ Start = [datetime]"$year-10-08"; End = [datetime]"$year-11-06"; Animal = 'Dog' }
        @{ Start = [datetime]"$year-11-07"; End = [datetime]"$year-12-06"; Animal = 'Pig' }
        @{ Start = [datetime]"$year-12-07"; End = [datetime]"$year-12-31"; Animal = 'Rat' }
    )
    foreach ($r in $ranges) { if ($Date -ge $r.Start -and $Date -le $r.End) { return $r.Animal } }
    return 'Unknown'
}

function Get-ChineseInfo {
    param([Parameter(Mandatory=$true)][datetime]$Date, [Parameter(Mandatory=$true)][int]$Year)
    $chineseYear = $Year
    if ($script:chineseNewYearDates.ContainsKey($Year)) {
        if ($Date -lt $script:chineseNewYearDates[$Year]) { $chineseYear = $Year - 1 }
    }
    $animalIndex = ($chineseYear - 1924) % 12
    if ($animalIndex -lt 0) { $animalIndex += 12 }
    return @{ YearAnimal = $script:chineseAnimals[$animalIndex]; MonthAnimal = Get-MonthAnimal -Date $Date }
}