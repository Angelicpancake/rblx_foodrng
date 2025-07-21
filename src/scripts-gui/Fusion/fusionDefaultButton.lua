local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OpenGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("openGui"))
local CloseGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("closeGui"))
local FusionRender = require(script.Parent.fusionRender)

local FusionGui = script.Parent.Parent.Parent.FusionGui
local close2 = script.Parent.Parent.Parent.FusionGui.Exit
local fuse = FusionGui.Fusion.PreviewFrame.FuseFrame.FuseButton

local function FusionDefaultButtonInit()
	close2.MouseButton1Click:Connect(function()
		CloseGui(FusionGui)
	end)

	fuse.MouseButton1Click:Connect(function()
		FusionRender.fusionRequest()
	end)
end

return FusionDefaultButtonInit
