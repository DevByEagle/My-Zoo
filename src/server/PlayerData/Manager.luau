local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Remotes = ReplicatedStorage.Remotes

local Manager = {}

Manager.Profiles = {}

local function GetData(player: Player, directory: string)
    local profile = Manager.Profiles[player]
    if not profile then return end
    return profile.Data[directory]
end

Remotes.GetData.OnServerInvoke = GetData

return Manager
