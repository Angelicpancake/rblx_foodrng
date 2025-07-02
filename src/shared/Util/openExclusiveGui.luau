local CollectionService = game:GetService("CollectionService")

local function openExclusiveGui(targetGui: ScreenGui)

    for _, gui in ipairs(CollectionService:GetTagged("mainGui")) do
        gui.Enabled = false
    end

    targetGui.Enabled = true
end

return openExclusiveGui