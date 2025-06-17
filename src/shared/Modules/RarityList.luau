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
	{ "Common", 0, Color3.fromRGB(222, 231, 222) },
	{ "Uncommon", 3, Color3.fromRGB(155, 234, 192) },
	{ "Rare", 25, Color3.fromRGB(0, 0, 255) },
	{ "Epic", 100, Color3.fromRGB(128, 0, 128) },
	{ "Legendary", 500, Color3.fromRGB(255, 215, 0) },
	{ "Mythical", 2000, Color3.fromRGB(230, 171, 230) },
}
