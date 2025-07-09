local Players = game:GetService("Players")
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local function withinArea(AreaRoot: BasePart, MaxRange: number)
	local distance = (AreaRoot.Position - root.Position).Magnitude

	if distance < MaxRange then
		return true
	else
		return false
	end
end

return withinArea
