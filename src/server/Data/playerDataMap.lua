--!strict
local PlayerDataTypes = require(script.Parent.playerDataTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerDataMap: { [number]: PlayerDataTypes.PlayerDataType } = {}

local function RuntimeGetPlayerData(UserId: number): PlayerDataTypes.PlayerDataType
	return PlayerDataMap[UserId]
end

local function RuntimeSetPlayerData(UserId: number, DataObj: PlayerDataTypes.PlayerDataType): nil
	PlayerDataMap[UserId] = DataObj
	return nil
end

return {
	RuntimeGetPlayerData = RuntimeGetPlayerData,
	RuntimeSetPlayerData = RuntimeSetPlayerData,
}
