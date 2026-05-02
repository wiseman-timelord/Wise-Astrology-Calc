# displays.ps1 - Menus, descriptions, formatting

$script:dreamspellSealDescriptions = @(
    'Nurturing and birth, fosters new beginnings and creativity.',
    'Communication and spirit, inspires clear expression and ideas.',
    'Abundance and intuition, explores dreams and the unconscious.',
    'Growth and awareness, targets potential and personal flowering.',
    'Life force and instinct, drives transformation and passion.',
    'Death and equality, connects worlds and balances life.',
    'Healing and knowledge, encourages mastery and accomplishment.',
    'Beauty and art, promotes elegance and enlightenment.',
    'Purification and flow, enhances emotional and universal ties.',
    'Loyalty and love, fosters heart connections and faithfulness.',
    'Play and magic, sparks creativity and joyful illusion.',
    'Free will and wisdom, inspires influence and reflection.',
    'Exploration and space, awakens adventure and awareness.',
    'Timelessness and magic, enchants with receptivity and guidance.',
    'Vision and creation, elevates mind and consciousness.',
    'Fearlessness and intellect, strengthens courage and inquiry.',
    'Synchronicity and navigation, grounds evolution and stability.',
    'Reflection and order, clarifies truth and endlessness.',
    'Energy and catalysis, transforms through renewal and power.',
    'Universal fire and life, enlightens with joy and illumination.'
)

$script:tzolkinDayDescriptions = @(
    'Crocodile, birth, initiates creation and new beginnings.',
    'Wind, breath, enhances communication and spiritual flow.',
    'Night, house, offers mystery and inner sanctuary.',
    'Seed, corn, nurtures abundance and growth potential.',
    'Serpent, ignites life force and transformative instinct.',
    'Death, facilitates rebirth and letting go of the old.',
    'Deer, hand, heals and accomplishes through skill.',
    'Star, rabbit, harmonizes beauty and elegance.',
    'Water, jade, purifies emotions and fosters flow.',
    'Dog, guides with loyalty and heartfelt friendship.',
    'Monkey, delights with play, creativity, and magic.',
    'Road, human, shapes destiny through journey and will.',
    'Reed, cornstalk, supports growth and stability.',
    'Jaguar, shaman, weaves magic and hidden wisdom.',
    'Eagle, soars with vision and free perspective.',
    'Vulture, owl, links to ancestral wisdom and past.',
    'Earth, aligns navigation and synchronicity.',
    'Flint, mirror, reflects truth and clarity.',
    'Storm, renews through transformation and cleansing.',
    'Sun, masters enlightenment and unconditional love.'
)

$script:chinesePersonalityDescriptions = @{
    'Rat'     = 'Smart, adaptable, witty, charming, yet sometimes opportunistic.'
    'Ox'      = 'Hardworking, reliable, strong, stubborn at times.'
    'Tiger'   = 'Bold, confident, competitive, charismatic, often impulsive.'
    'Rabbit'  = 'Gentle, kind, elegant, artistic, but cautious.'
    'Dragon'  = 'Vibrant, fearless, charming, ambitious, can be arrogant.'
    'Snake'   = 'Wise, intuitive, graceful, secretive by nature.'
    'Horse'   = 'Lively, independent, cheerful, restless adventurer.'
    'Goat'    = 'Calm, creative, gentle, empathetic, may be indecisive.'
    'Monkey'  = 'Clever, curious, playful, witty, sometimes tricky.'
    'Rooster' = 'Keen, diligent, brave, confident, can be boastful.'
    'Dog'     = 'Loyal, honest, kind, cautious, occasionally anxious.'
    'Pig'     = 'Warm, generous, sincere, diligent, can be naive.'
}

$script:chinesePhysiqueDescriptions = @{
    'Rat'     = 'Quick, agile, sharp-featured, with a keen presence.'
    'Ox'      = 'Solid, sturdy, calm, exuding steady strength.'
    'Tiger'   = 'Muscular, powerful, bold, commands attention.'
    'Rabbit'  = 'Graceful, soft, delicate, with a gentle aura.'
    'Dragon'  = 'Vivid, majestic, dynamic, full of energy.'
    'Snake'   = 'Sleek, elegant, with a mysterious allure.'
    'Horse'   = 'Athletic, strong, free-spirited, and lively.'
    'Goat'    = 'Serene, gentle, with an artistic demeanor.'
    'Monkey'  = 'Nimble, expressive, playful in movement.'
    'Rooster' = 'Proud, sharp, with a confident stance.'
    'Dog'     = 'Firm, protective, friendly, and trustworthy.'
    'Pig'     = 'Warm, robust, with a welcoming presence.'
}

function Format-AlternativeCalendar {
    param([Parameter(Mandatory=$true)][hashtable]$AltDate)
    $era = if ($AltDate.IsBeforeTransition) { 'B.T.' } else { 'A.T.' }
    $monthNames = @('First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth')
    $monthName = if ($AltDate.Month -ge 1 -and $AltDate.Month -le 12) { $monthNames[$AltDate.Month - 1] } else { 'Unknown' }
    return "$($AltDate.Day) $monthName $($AltDate.Year) $era"
}

function Show-UnifiedDisplay {
    param([DateTime]$DisplayDate)
    if ($Host.Name -eq 'ConsoleHost') { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size (80, 42) }

    $jd           = Get-JulianDay -Date $DisplayDate
    $tzolkin      = Get-TzolkinInfo -JulianDay $jd
    $dreamspell   = Get-DreamspellInfo -JulianDay $jd
    $chinese      = Get-ChineseInfo -Date $DisplayDate -Year $DisplayDate.Year
    $since3114    = Get-TimeSince3114BCE -CurrentDate $DisplayDate
    $altCal       = Get-AlternativeCalendarDate -CurrentDate $DisplayDate
    $altFormatted = Format-AlternativeCalendar -AltDate $altCal

    $dreamDesc   = $script:dreamspellSealDescriptions[$dreamspell.SealIndex]
    $tzolkinDesc = $script:tzolkinDayDescriptions[$tzolkin.DayIndex]
    $monthDesc   = $script:chinesePersonalityDescriptions[$chinese.MonthAnimal]
    $yearDesc    = $script:chinesePhysiqueDescriptions[$chinese.YearAnimal]

    Clear-Host
    $sep = '=' * 79
    Write-Host $sep
    Write-Host '    Wise-AstroDate-Calc – Unified Display' -ForegroundColor Cyan
    Write-Host $sep
    Write-Host ' '
    Write-Host "SYSTEM DATE    : $([DateTime]::Now.ToString('yyyy/MM/dd HH:mm:ss'))" -ForegroundColor Yellow
    Write-Host "CALCULATED DATE: $($DisplayDate.ToString('yyyy/MM/dd'))" -ForegroundColor Yellow
    Write-Host ' '
    Write-Host $sep
    Write-Host 'ASTROLOGY' -ForegroundColor Green
    Write-Host $sep
    Write-Host "Power/Energy : $($dreamspell.Seal) $($dreamspell.Tone)"
    Write-Host "Details      : $dreamDesc"
    Write-Host ' '
    Write-Host "Role/Ability : $($tzolkin.Name) $($tzolkin.Number)"
    Write-Host "Details      : $tzolkinDesc"
    Write-Host ' '
    Write-Host "Persona/Head : $($chinese.MonthAnimal)"
    Write-Host "Details      : $monthDesc"
    Write-Host ' '
    Write-Host "Physique/Body: $($chinese.YearAnimal)"
    Write-Host "Details      : $yearDesc"
    Write-Host ' '
    Write-Host $sep
    Write-Host 'DATE CALCULATIONS' -ForegroundColor Magenta
    Write-Host $sep
    Write-Host 'Time since August 11, 3114 BCE:'
    Write-Host "  Total Days  : $($since3114.TotalDays.ToString('N0'))"
    Write-Host "  Total Months: $($since3114.TotalMonths.ToString('N0'))"
    Write-Host "  Total Years : $($since3114.TotalYears.ToString('N0'))"
    Write-Host ' '
    Write-Host 'Alternative Calendar (2025-12-21 = Year 1 Month 1 Day 1):'
    Write-Host "  Date: $altFormatted   (B.T. = Before Transition, A.T. = After Transition)"
    Write-Host ' '
    Write-Host $sep
}