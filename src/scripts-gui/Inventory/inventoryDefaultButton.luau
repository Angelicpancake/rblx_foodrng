local ReplicatedStorage = game:GetService("ReplicatedStorage")
local openGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("openGui"))
local closeGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("closeGui"))

local close2 = script.Parent.Parent.Parent.InventoryGui.Exit

local function InventoryDefaultButtonInit(invenButton, InvenGui)
	local invenOpen = false
	invenButton.MouseButton1Click:Connect(function()
		if not invenOpen then
			openGui(InvenGui)
		else
			closeGui(InvenGui)
		end
		invenOpen = not invenOpen
	end)

	close2.MouseButton1Click:Connect(function()
		closeGui(InvenGui)
	end)
end

return InventoryDefaultButtonInit
