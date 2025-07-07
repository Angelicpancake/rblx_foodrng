local Players = game:GetService("Players")
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local function withinArea(AreaRoot: BasePart)
	local distance = (AreaRoot.Position - root.Position).Magnitude

	if distance < 20 then
		return true
	end
end

return withinArea
