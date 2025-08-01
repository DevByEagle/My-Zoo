local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local StateManager = require(ReplicatedStorage.Client.State)
local Remotes = ReplicatedStorage.Remotes

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Gui = PlayerGui:WaitForChild('Currency')
local Frame = Gui.Frame

local Cash = Frame.Cash.Amount
local Gems = Frame.Gems.Amount

local function FormatNumber(n: number): string
	return tostring(n):reverse():gsub("%d%d%d", "%0,"):reverse():gsub("^,", "")
end

local function UpdateCurrency(currency: "Cash" | "Gems", amount: number)
    if currency == "Cash" then
        Cash.Text = FormatNumber(amount)
    elseif currency == "Gems" then
        Gems.Text = FormatNumber(amount)
    end
end

UpdateCurrency("Cash", StateManager.GetData().Cash)

Remotes.UpdateCash.OnClientEvent:Connect(function(amount)
    UpdateCurrency("Cash", amount)
end)