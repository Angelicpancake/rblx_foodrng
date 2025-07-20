local ReplicatedStorage = game:GetService("ReplicatedStorage")
local openGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("openGui"))
local closeGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("closeGui"))

local FusionGui = script.Parent.Parent.Parent.FusionGui
local close2 = script.Parent.Parent.Parent.FusionGui.Exit

local function FusionDefaultButtonInit()
	close2.MouseButton1Click:Connect(function()
		closeGui(FusionGui)
	end)
end

return FusionDefaultButtonInit
