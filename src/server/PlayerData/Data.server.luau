local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Template = require(ReplicatedStorage.PlayerData.Template)
local Manager = require(ServerScriptService.PlayerData.Manager)
local ProfileService = require(ServerScriptService.Packages.ProfileService)

local ProfileStore = ProfileService.GetProfileStore('Test', Template) -- NOTE: Use 'Test' during development and remember to change it to 'Production' before publishing.

local KICK_MESSAGE = 'Data issus, try again shortly. If issus persists, contact us!'

local function CreateLeaderstats(player: Player)
    local profile = Manager.Profiles[player]
    if not profile then return end

    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local cash = Instance.new('IntValue', leaderstats)
    cash.Name = 'Cash'
    cash.Value = profile.Data.Cash

    local gems = Instance.new('IntValue', leaderstats)
    gems.Name = 'Gems'
    gems.Value = profile.Data.Gems
end

local function LoadProfile(player: Player)
    local profile = ProfileStore:LoadProfileAsync('Player_'..player.UserId)
    if not profile then
        player:Kick(KICK_MESSAGE)
        return
    end

    profile:AddUserId(player.UserId)
    profile:Reconcile()
    profile:ListenToRelease(function()
        Manager.Profiles[player] = nil
        player:Kick(KICK_MESSAGE)
    end)

    if player:IsDescendantOf(Players) == true then
        Manager.Profiles[player] = profile
        CreateLeaderstats(player)
    else
        profile:Release()
    end
end

for _, player in Players:GetPlayers() do
    task.spawn(LoadProfile, player)
end

Players.PlayerAdded:Connect(LoadProfile)

Players.PlayerRemoving:Connect(function(player)
    local profile = Manager.Profiles[player]
    if profile then
        profile:Release()
    end
end)