local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Observers = require(ReplicatedStorage:WaitForChild("Packages").Observers)

local FusionGui = { PlayerGui:WaitForChild("FusionGui") }

--fuseItem is the button icon
local stopFuseObserving = Observers.observeTag("fusionItem", function (fuseItem: ImageButton)

    local connection = fuseItem.MouseButton1Click:Connect(function()
        print(fuseItem.Name, "clicked!");
    end)

    return function ()
        connection:Disconnect()
        print("connection disconnected")
    end
end, FusionGui)

return stopFuseObserving