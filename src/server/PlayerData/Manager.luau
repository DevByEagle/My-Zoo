local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Remotes = ReplicatedStorage.Remotes

local Manager = {}

Manager.Profiles = {}

function Manager.AdjustCash(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then return end
	profile.Data.Cash += amount
	player.leaderstats.Cash.Value = profile.Data.Cash
	Remotes.UpdateCash:FireClient(player, profile.Data.Cash)
end

local function GetData(player: Player, directory: string)
    local profile = Manager.Profiles[player]
    if not profile then return end
    return profile.Data[directory]
end

local function GetAllData(player: Player)
    local profile = Manager.Profiles[player]
    if not profile then return end
    return profile.Data
end

Remotes.GetData.OnServerInvoke = GetData
Remotes.GetAllData.OnServerInvoke = GetAllData

return Manager
