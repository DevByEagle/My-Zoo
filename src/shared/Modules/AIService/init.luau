--!strict

-- Roblox Services
local PathfindingService = game:GetService('PathfindingService')

local AIService = {}
AIService.__index = AIService

function AIService.new(character)
    local self = setmetatable({}, AIService)
	self.NPC = character
	self.Humanoid = character:FindFirstChildOfClass('Humanoid')
	self.RootPart = character:FindFirstChild('HumanoidRootPart')
	return self
end

function AIService:Destroy()
    if self.NPC then
		self.NPC:Destroy()
	end
	self.NPC = nil
	self.Humanoid = nil
	self.RootPart = nil
end

function AIService:WalkTo(location: Vector3)
	if not self.Humanoid or not self.RootPart then return end

	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
	})
	path:ComputeAsync(self.RootPart.Position, location)

	if path.Status == Enum.PathStatus.Success then
		for _, waypoint in ipairs(path:GetWaypoints()) do
			self.Humanoid:MoveTo(waypoint.Position)
			self.Humanoid.MoveToFinished:Wait()
		end
	end
end

function AIService:RunBehavior(behaviorFunc)
    task.spawn(function()
        behaviorFunc(self, function()
            self:Destroy()
        end)
    end)
end

-- TODO: Add GetAllNPCs()

return AIService
