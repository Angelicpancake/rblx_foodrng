local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RuntimeDataFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").playerDataMap)
local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local function RecalculateBonus(UserId: number)
    print("what")
    local PlayerData = RuntimeDataFuncs.RuntimeGetPlayerData(UserId)
    local Total = 0
    print(PlayerData.Upgrades.Bonuses)
    for _, Bonus in PlayerData.Upgrades.Bonuses do
        if (t.numberConstrained(0.00, 10.00))(Bonus.Luck) then
            Total += Bonus.Luck
        end
    end

    PlayerData.Upgrades.LuckBoost = Total
end

return RecalculateBonus