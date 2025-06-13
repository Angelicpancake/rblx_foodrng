local CollectionService = game:GetService("CollectionService")

local function openGui(targetGui: ScreenGui)

    for _, gui in ipairs(CollectionService:GetTagged("mainGui")) do
        gui.Enabled = false
    end

    targetGui.Enabled = true
end

return openGui