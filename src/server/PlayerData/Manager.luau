local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Remotes = ReplicatedStorage.Remotes

local Manager = {}

Manager.Profiles = {}

function Manager.AdjustMoney(player: Player, amount: number)
	local profile = Manager.Profiles[player]
	if not profile then warn("NO PROFILE") end
	profile.Data.Money += amount
	player.leaderstats.Money.Value = profile.Data.Money
	Remotes.UpdateMoney:FireClient(player, profile.Data.Money)
end

return Manager
