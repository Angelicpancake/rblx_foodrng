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
	{ Rarity = "Common", Weight = 0, Color = Color3.fromRGB(78, 132, 95) },
	{ Rarity = "Uncommon", Weight = 3, Color = Color3.fromRGB(78, 132, 95) },
	{ Rarity = "Rare", Weight = 25, Color = Color3.fromRGB(40, 70, 105) },
	{ Rarity = "Epic", Weight = 100, Color = Color3.fromRGB(71, 57, 87) },
	{ Rarity = "Legendary", Weight = 500, Color = Color3.fromRGB(198, 139, 44) },
	{ Rarity = "Mythical", Weight = 2000, Color = Color3.fromRGB(137, 54, 71) },
}
