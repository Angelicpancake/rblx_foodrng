--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage:WaitForChild("Packages").t)
local ServerScriptService = game:GetService("ServerScriptService")

local FoodScripts = ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil")
local RarityList = require(FoodScripts.rarityList)
local ItemList = require(FoodScripts.itemList)

local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local BonusDataTypes = require(Types.bonusDataTypes)
local TimeEventDataTypes = require(Types.timedEventDataTypes)

export type InventoryDataType = {
	Food: { [string]: { Quantity: number, Rarity: string, Stars: number } },
	Items: { string? },
}

export type ProfileDataTemplateType = {
	Level: number,
	XP: number,
	FoodDex: number,
	LastLogin: () -> number,
	CalendarProgress: number
}

export type ProfileDataType = {
	Level: number,
	XP: number,
	FoodDex: number,
	LastLogin: number,
	CalendarProgress: number
}

export type UpgradeDataType = {
	--LuckBoost is a decimal with 100 percent being 1.00
	LuckBoost: number,
	Bonuses: {BonusDataTypes.BonusDataType}
}

export type SettingsDataType = {
	FastRoll: boolean
}

export type PlayerDataType = {
	_DATAVERSION: number,
	Inventory: InventoryDataType,
	Profile: ProfileDataType,
	Upgrades: UpgradeDataType,
	Timers: {TimeEventDataTypes.TimeEventDataType},
	Settings: SettingsDataType
}

export type PlayerDataTemplateType = {
	_DATAVERSION: number,
	Inventory: InventoryDataType,
	Profile: ProfileDataTemplateType,
	Upgrades: UpgradeDataType,
	Timers: {TimeEventDataTypes.TimeEventDataType},
	Settings: SettingsDataType
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
			t.map(
				t.string,
				t.interface({
					Quantity = t.numberConstrained(0, math.huge), -- Non-negative
					Rarity = t.union(table.unpack(Rarities)),
					Stars = t.numberConstrained(0, 2)
				})
			) -- Specific values found in rarityList.lua
		),
		Items = t.array(t.optional(t.union(table.unpack(ItemNames)))),
	}),
	Profile = t.interface({
		Level = t.integer, -- Integer, not float
		XP = t.numberConstrained(0, math.huge),
		FoodDex = t.integer,
		LastLogin = t.number,
		CalendarProgress = t.number
	}),
	Upgrades = t.interface({
		LuckBoost = t.numberConstrained(0, 10), -- Between 0 and 10
		Bonuses = t.array(t.optional(t.interface({
			Name = t.string,
			Luck = t.number,
			Stackable = t.optional(t.boolean),
			Expiry = t.optional(t.number)
		})))
	}),
	Timers = t.array(
		t.strictInterface({
			Type = t.union(t.literal("Bonus")),
			Name = t.string,
			Time = t.number,
			Callback = t.optional(t.callback)
		})
	),
	Settings = t.interface({
		FastRoll = t.boolean
	})
})

return { PlayerDataTypeChecker = PlayerDataTypeChecker }