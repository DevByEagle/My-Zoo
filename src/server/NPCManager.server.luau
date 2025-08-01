local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')

local AIService = require(ReplicatedStorage.Modules.AIService)
local Roam = require(ReplicatedStorage.Modules.AIService.Behaviors.Roam)

local NPCTemplatesFolder = ReplicatedStorage:WaitForChild('NPCs')
local ActiveNPCsFolder = Workspace:WaitForChild('Base'):WaitForChild('NPCs')

local MaxNPC = 1

local function CanSpawn()
	return #ActiveNPCsFolder:GetChildren() < MaxNPC
end

local function GetRandomTemplate()
	local templates = NPCTemplatesFolder:GetChildren()
	if #templates == 0 then return nil end
	return templates[math.random(1, #templates)]
end

local function SpawnNPC()
	if not CanSpawn() then return end

	local template = GetRandomTemplate()
	if not template then return end

	local npcClone = template:Clone()
	npcClone.Parent = ActiveNPCsFolder

	local npc = AIService.new(npcClone)
	npc:RunBehavior(Roam)
end

-- Auto-spawn loop
while true do
	if CanSpawn() then
		SpawnNPC()
	end
	task.wait(2)
end
