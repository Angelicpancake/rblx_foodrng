local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rollEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("rng"):WaitForChild("rollEvent")
local Players = game:GetService("Players")
local locPlayer = Players.LocalPlayer

local rngGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")
local rollButton = rngGui:WaitForChild("RollButton")

rollButton.MouseButton1Click:Connect(function()
    rollEvent:FireServer()
end)