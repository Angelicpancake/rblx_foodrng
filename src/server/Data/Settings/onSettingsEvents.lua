local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RuntimeDataFuncs = require(script.Parent.Parent.playerDataMap)
local t = require(ReplicatedStorage:WaitForChild("Packages").t)

function OnSettingsEvent(player : Player, Setting : string)
    local PlayerData = RuntimeDataFuncs.RuntimeGetPlayerData(player.UserId)
    local PlayerSettings = PlayerData.Settings
    if t.boolean(PlayerSettings[Setting]) then
        PlayerSettings[Setting] = not PlayerSettings[Setting]
    end
    RuntimeDataFuncs.RuntimeSetPlayerData(player.UserId, PlayerData)
end

return OnSettingsEvent