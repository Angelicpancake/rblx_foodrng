local ReplicatedStorage = game:GetService("ReplicatedStorage")

local rollEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("rng"):WaitForChild("rollEvent")

rollEvent.OnServerEvent:Connect(function()
    print("rolled")
end)