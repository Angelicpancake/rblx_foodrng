local RollingAnimation = require(script.Parent.RollingAnimation)

local function AnimationHandlerInit(RollResultEvent: RemoteEvent)
    RollingAnimation.RollingAnimationInit()

    RollResultEvent.OnClientEvent:Connect(function(RollResult)
        local AboveRarityThreshold = true

        if AboveRarityThreshold then
            RollingAnimation.PlayRollingAnimation()
        end
    end)
end

return AnimationHandlerInit