local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Remotes = ReplicatedStorage.Remotes
local Template = require(ReplicatedStorage.PlayerData.Template)

local IsDataLoaded = false

local PlayerData: Template.PlayerData

local function LoadData()
    if IsDataLoaded then return end

    while not PlayerData do
        PlayerData = Remotes.GetAllData:InvokeServer()
        task.wait(1)
    end

    IsDataLoaded = true
end

LoadData()

local State = {}

function State.GetData(): Template.PlayerData
    while not IsDataLoaded do
        task.wait(0.5)
    end

    return PlayerData
end

return State
