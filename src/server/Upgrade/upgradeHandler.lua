local upgradeStars = require(script.Parent.upgradeStars)
local upgradeCost = require(script.Parent.upgradeCost)

local Upgrade = {}

Upgrade.init = function()
	upgradeStars()
	upgradeCost()
end

return Upgrade
