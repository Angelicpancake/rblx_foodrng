--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")
local FusionEvents = Events:WaitForChild("Fusion")

local OnFuseSubmissionInit = require(script.Parent.onFuseSubmission)
local RecipePlayerJoinInit = require(script.Parent.RecipePlayerJoinInit)
local fusion = {}

local GetRecipeListFunction = FusionEvents:WaitForChild("GetRecipeList")

function fusion.Start()
    OnFuseSubmissionInit()
    RecipePlayerJoinInit(GetRecipeListFunction)
end

return fusion