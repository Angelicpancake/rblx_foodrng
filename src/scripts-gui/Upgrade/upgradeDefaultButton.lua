local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeButton = script.Parent.Parent.Parent.DefaultGui.UpgradeButton

local Remotes = {}

Remotes.upgradeStar = ReplicatedStorage.Events.Upgrade.UpgradeStar

local function ButtonInit()
	UpgradeButton.MouseButton1Click:Connect(function()
		print("clicked")
		local success = Remotes.upgradeStar:InvokeServer()
		print(success)
	end)
end

return ButtonInit
