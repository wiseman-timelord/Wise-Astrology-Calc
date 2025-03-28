# astrology.ps1 - Stores descriptions for DreamSpell, Tzolkin, and Chinese astrology components

# Descriptions for DreamSpell seals (order matches $dreamspellSeals in calculate.ps1)
$script:dreamspellSealDescriptions = @(
    "Dragon: Nurturing and birth, fosters new beginnings and creativity.",
    "Wind: Communication and spirit, inspires clear expression and ideas.",
    "Night: Abundance and intuition, explores dreams and the unconscious.",
    "Seed: Growth and awareness, targets potential and personal flowering.",
    "Serpent: Life force and instinct, drives transformation and passion.",
    "World-Bridger: Death and equality, connects worlds and balances life.",
    "Hand: Healing and knowledge, encourages mastery and accomplishment.",
    "Star: Beauty and art, promotes elegance and enlightenment.",
    "Moon: Purification and flow, enhances emotional and universal ties.",
    "Dog: Loyalty and love, fosters heart connections and faithfulness.",
    "Monkey: Play and magic, sparks creativity and joyful illusion.",
    "Human: Free will and wisdom, inspires influence and reflection.",
    "Skywalker: Exploration and space, awakens adventure and awareness.",
    "Wizard: Timelessness and magic, enchants with receptivity and guida.",
    "Eagle: Vision and creation, elevates mind and consciousness.",
    "Warrior: Fearlessness and intellect, strengthens courage and inquiry.",
    "Earth: Synchronicity and navigation, grounds evolution and stability.",
    "Mirror: Reflection and order, clarifies truth and endlessness.",
    "Storm: Energy and catalysis, transforms through renewal and power.",
    "Sun: Universal fire and life, enlightens with joy and illumination."
)

# Descriptions for Tzolkin days (order matches $tzolkinNames in calculate.ps1)
$script:tzolkinDayDescriptions = @(
    "Imix: Crocodile, birth, initiates creation and new beginnings.",
    "Ik: Wind, breath, enhances communication and spiritual flow.",
    "Akbal: Night, house, offers mystery and inner sanctuary.",
    "Kan: Seed, corn, nurtures abundance and growth potential.",
    "Chicchan: Serpent, ignites life force and transformative instinct.",
    "Cimi: Death, facilitates rebirth and letting go of the old.",
    "Manik: Deer, hand, heals and accomplishes through skill.",
    "Lamat: Star, rabbit, harmonizes beauty and elegance.",
    "Muluc: Water, jade, purifies emotions and fosters flow.",
    "Oc: Dog, guides with loyalty and heartfelt friendship.",
    "Chuen: Monkey, delights with play, creativity, and magic.",
    "Eb: Road, human, shapes destiny through journey and will.",
    "Ben: Reed, cornstalk, supports growth and stability.",
    "Ix: Jaguar, shaman, weaves magic and hidden wisdom.",
    "Men: Eagle, soars with vision and free perspective.",
    "Cib: Vulture, owl, links to ancestral wisdom and past.",
    "Caban: Earth, aligns navigation and synchronicity.",
    "Etznab: Flint, mirror, reflects truth and clarity.",
    "Cauac: Storm, renews through transformation and cleansing.",
    "Ahau: Sun, masters enlightenment and unconditional love."
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