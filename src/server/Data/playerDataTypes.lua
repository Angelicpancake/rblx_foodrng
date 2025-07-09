local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage:WaitForChild("Packages").t)
local ServerScriptService = game:GetService("ServerScriptService")
local RarityList = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil").rarityList)
local ItemList = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil").itemList)

export type InventoryDataType = {
	Food: {[string]: {Quantity: number, Rarity: string}},
	Items: {string?}
}

export type ProfileDataType = {
	Level: number,
	XP: number,
	FoodDex: number
}

export type UpgradeDataType = {
	--LuckBoost is a decimal with 100 percent being 1.00
	LuckBoost: number 
}

export type PlayerDataType = { 
    _DATAVERSION: number,
	Inventory: InventoryDataType,
	Profile: ProfileDataType,
	Upgrades: UpgradeDataType
}

local Rarities = {}
for _, RarityObj in ipairs(RarityList) do
    table.insert(Rarities, t.literal(RarityObj.Rarity))
end

local ItemNames = {}
for _, ItemObj in ipairs(ItemList) do
    table.insert(ItemNames, t.literal(ItemObj.Name))
end

local PlayerDataTypeChecker = t.strictInterface({
    _DATAVERSION = t.number,
    Inventory = t.interface({
        Food = t.optional(
            t.map(t.string, t.interface({
                Quantity = t.numberConstrained(0, math.huge), -- Non-negative
                Rarity = t.union(table.unpack(Rarities))
            })) -- Specific values found in rarityList.lua
        ),
        Items = t.array(
            t.optional(t.union(table.unpack(ItemNames)))
        )
    }),
    Profile = t.interface({
        Level = t.integer, -- Integer, not float
        XP = t.numberConstrained(0, math.huge),
        FoodDex = t.integer
    }),
    Upgrades = t.interface({
        LuckBoost = t.numberConstrained(0, 10) -- Between 0 and 10
    })
})

return {PlayerDataTypeChecker = PlayerDataTypeChecker}