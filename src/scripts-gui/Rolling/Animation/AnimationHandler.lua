local RollingAnimation = require(script.Parent.RollingAnimation)

local function AnimationHandlerInit(RollResultEvent: RemoteEvent)
    RollingAnimation.RollingAnimationInit()

    RollResultEvent.OnClientEvent:Connect(function(RollResult, FastRollEnabled)
        --just set to true for now should add later
        local AboveRarityThreshold = true

        if not FastRollEnabled and AboveRarityThreshold then
            RollingAnimation.PlayRollingAnimation(RollResult)
        end
    end)
end

return AnimationHandlerInit