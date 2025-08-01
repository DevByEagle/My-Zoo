--!strict

-- Roblox Services
local PathfindingService = game:GetService("PathfindingService")

local AIService = {}
AIService.__index = AIService

function AIService.new(npcModel)
    local self = setmetatable({}, AIService)
	self.Model = npcModel
	self.Humanoid = npcModel:FindFirstChildOfClass("Humanoid")
	self.RootPart = npcModel:FindFirstChild("HumanoidRootPart")
	self.CurrentTask = nil
	return self
end

function AIService:WalkTo(position)
    if not self.Humanoid or not self.RootPart then return end

    local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
	})
    path:ComputeAsync(self.RootPart.Position, position)

    if path.Status == Enum.PathStatus.Success then
		for _, waypoint in ipairs(path:GetWaypoints()) do
			self.Humanoid:MoveTo(waypoint.Position)
			self.Humanoid.MoveToFinished:Wait()
		end
	end
end

function AIService:RunBehavior(behaviorFunc)
    task.spawn(function()
        behaviorFunc(self)
    end)
end

return AIService
