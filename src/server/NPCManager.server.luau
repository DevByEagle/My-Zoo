local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local AIService = require(ReplicatedStorage.Modules.AIService)
local Roam = require(ReplicatedStorage.Modules.AIService.Behaviors.Roam)

local NPCTemplatesFolder = ReplicatedStorage:WaitForChild('NPCs')
local ActiveNPCsFolder = workspace:WaitForChild("Base"):WaitForChild("NPCs")

local function GetRandomTemplate()
	local templates = NPCTemplatesFolder:GetChildren()
	return templates[math.random(1, #templates)]
end

local function SpawnNPC()
    local template = GetRandomTemplate()
    local npcClone = template:Clone()

    -- Parent to the active NPCs folder
    npcClone.Parent = ActiveNPCsFolder
    
    -- Create the NPC controller and start roaming
    local npc = AIService.new(npcClone)
    npc:RunBehavior(Roam)
end

for i = 1, 5 do
    SpawnNPC()
end