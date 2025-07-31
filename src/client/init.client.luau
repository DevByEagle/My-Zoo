-- Roblox services
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Variables
local Player = Players.LocalPlayer
local Base = ReplicatedStorage:WaitForChild('Base') -- NOTE: Find only the player’s base, not every base in the workspac
local PlotsFolder = workspace:WaitForChild('Plots')

-- Functions
function LoadPlayerBase()
    local clone = Base:Clone()
    clone.Name = Player.Name
    clone.Parent = PlotsFolder
end

LoadPlayerBase()