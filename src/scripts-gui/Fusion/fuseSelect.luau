--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Observers = require(ReplicatedStorage:WaitForChild("Packages").Observers)
local t = require(ReplicatedStorage:WaitForChild("Packages").t)
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)

local FusionGui = PlayerGui:WaitForChild("FusionGui")
local FusionGuiChildren = { FusionGui }
local FuseButton: ImageButton = FusionGui:WaitForChild("MainFrame"):WaitForChild("FuseButton")

local FuseButtonCallback: RemoteFunction = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Fusion"):WaitForChild("FuseClickedFunc")

local function FusionSelectionInit()

    local FuseSelectTrove = Trove.new()
    local SelectedFoods: { string } = {}

    FuseSelectTrove:Add(function()
        table.clear(SelectedFoods)
    end)

    --observers.observeTag returns a function that cleanups observing when called
    local StopFuseObserving = Observers.observeTag("fusionItem", function (foodItem: ImageButton)
        
        local connection = foodItem.MouseButton1Click:Connect(function()

            assert(t.string(foodItem.Name), "invalid foodname type")

            print(SelectedFoods)

            local foodIndex = table.find(SelectedFoods, foodItem.Name)

            if foodIndex then
                print("food already selected, removing food")
                table.remove(SelectedFoods, foodIndex)
                return
            elseif #SelectedFoods >= 2 then 
                print("already max foods")
                return
            end
            
            table.insert(SelectedFoods, foodItem.Name)
        end)

        return function ()
            connection:Disconnect()
            print("connection disconnected")
        end

    end, FusionGuiChildren)
    FuseSelectTrove:Add(StopFuseObserving)

    local FuseButtonConnection = FuseButton.MouseButton1Click:Connect(function()
        local result = FuseButtonCallback:InvokeServer(SelectedFoods)
        print(SelectedFoods, "=>", result)
    end)
    FuseSelectTrove:Add(FuseButtonConnection)

    return FuseSelectTrove
end

return FusionSelectionInit