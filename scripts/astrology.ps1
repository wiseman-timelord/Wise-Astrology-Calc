# astrology.ps1 - Stores descriptions for DreamSpell, Tzolkin, and Chinese astrology components

# Descriptions for DreamSpell seals (order matches $dreamspellSeals in calculate.ps1)
$script:dreamspellSealDescriptions = @(
    "Nurturing and birth, fosters new beginnings and creativity.",  # Dragon
    "Communication and spirit, inspires clear expression and ideas.",  # Wind
    "Abundance and intuition, explores dreams and the unconscious.",  # Night
    "Growth and awareness, targets potential and personal flowering.",  # Seed
    "Life force and instinct, drives transformation and passion.",  # Serpent
    "Death and equality, connects worlds and balances life.",  # World-Bridger
    "Healing and knowledge, encourages mastery and accomplishment.",  # Hand
    "Beauty and art, promotes elegance and enlightenment.",  # Star
    "Purification and flow, enhances emotional and universal ties.",  # Moon
    "Loyalty and love, fosters heart connections and faithfulness.",  # Dog
    "Play and magic, sparks creativity and joyful illusion.",  # Monkey
    "Free will and wisdom, inspires influence and reflection.",  # Human
    "Exploration and space, awakens adventure and awareness.",  # Skywalker
    "Timelessness and magic, enchants with receptivity and guidance.",  # Wizard
    "Vision and creation, elevates mind and consciousness.",  # Eagle
    "Fearlessness and intellect, strengthens courage and inquiry.",  # Warrior
    "Synchronicity and navigation, grounds evolution and stability.",  # Earth
    "Reflection and order, clarifies truth and endlessness.",  # Mirror
    "Energy and catalysis, transforms through renewal and power.",  # Storm
    "Universal fire and life, enlightens with joy and illumination."  # Sun
)

# Descriptions for Tzolkin days (order matches $tzolkinNames in calculate.ps1)
$script:tzolkinDayDescriptions = @(
    "Crocodile, birth, initiates creation and new beginnings.",  # Imix
    "Wind, breath, enhances communication and spiritual flow.",  # Ik
    "Night, house, offers mystery and inner sanctuary.",  # Akbal
    "Seed, corn, nurtures abundance and growth potential.",  # Kan
    "Serpent, ignites life force and transformative instinct.",  # Chicchan
    "Death, facilitates rebirth and letting go of the old.",  # Cimi
    "Deer, hand, heals and accomplishes through skill.",  # Manik
    "Star, rabbit, harmonizes beauty and elegance.",  # Lamat
    "Water, jade, purifies emotions and fosters flow.",  # Muluc
    "Dog, guides with loyalty and heartfelt friendship.",  # Oc
    "Monkey, delights with play, creativity, and magic.",  # Chuen
    "Road, human, shapes destiny through journey and will.",  # Eb
    "Reed, cornstalk, supports growth and stability.",  # Ben
    "Jaguar, shaman, weaves magic and hidden wisdom.",  # Ix
    "Eagle, soars with vision and free perspective.",  # Men
    "Vulture, owl, links to ancestral wisdom and past.",  # Cib
    "Earth, aligns navigation and synchronicity.",  # Caban
    "Flint, mirror, reflects truth and clarity.",  # Etznab
    "Storm, renews through transformation and cleansing.",  # Cauac
    "Sun, masters enlightenment and unconditional love."  # Ahau
)

# Personality descriptions for Chinese animals (used for month, "Persona/Head")
$script:chinesePersonalityDescriptions = @{
    "Rat" = "Smart, adaptable, witty, charming, yet sometimes opportunistic."
    "Ox" = "Hardworking, reliable, strong, stubborn at times."
    "Tiger" = "Bold, confident, competitive, charismatic, often impulsive."
    "Rabbit" = "Gentle, kind, elegant, artistic, but cautious."
    "Dragon" = "Vibrant, fearless, charming, ambitious, can be arrogant."
    "Snake" = "Wise, intuitive, graceful, secretive by nature."
    "Horse" = "Lively, independent, cheerful, restless adventurer."
    "Goat" = "Calm, creative, gentle, empathetic, may be indecisive."
    "Monkey" = "Clever, curious, playful, witty, sometimes tricky."
    "Rooster" = "Keen, diligent, brave, confident, can be boastful."
    "Dog" = "Loyal, honest, kind, cautious, occasionally anxious."
    "Pig" = "Warm, generous, sincere, diligent, can be naive."
}

# Physique descriptions for Chinese animals (used for year, "Physique/Body")
$script:chinesePhysiqueDescriptions = @{
    "Rat" = "Quick, agile, sharp-featured, with a keen presence."
    "Ox" = "Solid, sturdy, calm, exuding steady strength."
    "Tiger" = "Muscular, powerful, bold, commands attention."
    "Rabbit" = "Graceful, soft, delicate, with a gentle aura."
    "Dragon" = "Vivid, majestic, dynamic, full of energy."
    "Snake" = "Sleek, elegant, with a mysterious allure."
    "Horse" = "Athletic, strong, free-spirited, and lively."
    "Goat" = "Serene, gentle, with an artistic demeanor."
    "Monkey" = "Nimble, expressive, playful in movement."
    "Rooster" = "Proud, sharp, with a confident stance."
    "Dog" = "Firm, protective, friendly, and trustworthy."
    "Pig" = "Warm, robust, with a welcoming presence."
}