local Players = game:GetService("Players")
local character = Players.LocalPlayer.Character
local root = character:WaitForChild("HumanoidRootPart")

local function withinArea(part: BasePart)
    local distance = (part.Position - root.Position).Magnitude

    if distance < 20 then
        return true
    end
end

return withinArea