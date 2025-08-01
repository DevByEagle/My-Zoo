local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')

local Template = require(ServerScriptService.PlayerData.Template)
local Manager = require(ServerScriptService.PlayerData.Manager)
local ProfileService = require(ServerScriptService.Packages.ProfileService)

local ProfileStore = ProfileService.GetProfileStore('Production', Template) -- NOTE: Use 'Test' during development and remember to change it before publishing.

local KICK_MESSAGE = 'Data issus, try again shortly. If issus persists, contact us!'

local function CreateLeaderstats(player: Player)
    local profile = Manager.Profiles[player]
    if not profile then return end

    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local money = Instance.new('IntValue', leaderstats)
    money.Name = 'Money'
    money.Value = profile.Data.Money

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