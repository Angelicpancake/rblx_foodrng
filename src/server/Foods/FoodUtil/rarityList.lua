--[[
    return all rng chances of given rarities:
    Common: (if all else fails pick common)
    Uncommon: 1 in 3
    Rare: 1 in 25
    Epic: 1 in 100
    Legendary: 1 in 500
    Mythical: 1 in 2000

    regular table with rarity arrays as values
    {Rarity, Chance, Color}
]]
return {
	{ Rarity = "Common", Weight = 0, Color = Color3.fromRGB(222, 231, 222) },
	{ Rarity = "Uncommon", Weight = 3, Color = Color3.fromRGB(155, 234, 192) },
	{ Rarity = "Rare", Weight = 25, Color = Color3.fromRGB(0, 0, 255) },
	{ Rarity = "Epic", Weight = 100, Color = Color3.fromRGB(128, 0, 128) },
	{ Rarity = "Legendary", Weight = 500, Color = Color3.fromRGB(255, 215, 0) },
	{ Rarity = "Mythical", Weight = 2000, Color = Color3.fromRGB(230, 171, 230) },
}
