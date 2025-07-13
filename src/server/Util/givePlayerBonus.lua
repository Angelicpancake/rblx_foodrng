local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local RecalculateBonus = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Bonus").recalculateBonus)
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local PlayerDataTypes = require(Types.playerDataTypes)
local BonusDataTypes = require(Types.bonusDataTypes)

local RuntimeDataFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").playerDataMap)
local Util = ServerScriptService:WaitForChild("Server"):WaitForChild("Util")
local TimerFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("TimedEvents").timerFuncs)

local function GivePlayerBonus(GivenBonus: BonusDataTypes.BonusDataType, UserId: number)
    print(GivenBonus)
    local PlayerData = RuntimeDataFuncs.RuntimeGetPlayerData(UserId)
    local CurrentBonuses = PlayerData.Upgrades.Bonuses
    for _, CurrentBonus in CurrentBonuses do
        print("ni")
        --Player already has bonus and it is not stackable
        if CurrentBonus.Name == GivenBonus.Name and CurrentBonus.Stackable == false then
            return
        end
    end

    table.insert(CurrentBonuses, GivenBonus)
    RecalculateBonus(UserId)
    if GivenBonus.ExpiryEvent then
        TimerFuncs.AddEvent(GivenBonus.ExpiryEvent, tostring(UserId))
    end
end

return GivePlayerBonus