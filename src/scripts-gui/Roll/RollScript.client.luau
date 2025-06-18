local replicatedStorage = game:GetService("ReplicatedStorage")
local remotes = replicatedStorage:WaitForChild("Events")

local rollGui = script.Parent.Parent.Parent:WaitForChild("RollGui")
local rollButton = rollGui:WaitForChild("RollButton")

rollButton.MouseButton1Click:Connect(function()
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)
