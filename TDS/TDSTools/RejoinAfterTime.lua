local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UtilitiesConfig = StratXLibrary.UtilitiesConfig
local LobbyTime = UtilitiesConfig.RejoinAfterTime.LobbyTime or 5
local GameTime = UtilitiesConfig.RejoinAfterTime.GameTime or 25

function MinutesToSeconds(minutes)
    return minutes*60
end

function GoBackToLobby()
    local attemptIndex = 0
    local success, result
    local ATTEMPT_LIMIT = 25
    local RETRY_DELAY = 3
    repeat
        success, result = pcall(function()
            return TeleportHandler(3260590327,2,7)
        end)
        attemptIndex += 1
        if not success then
            task.wait(RETRY_DELAY)
        end
    until success or attemptIndex == ATTEMPT_LIMIT
end


StratXLibrary.RejoinAfterTime = function(bool)
    if bool then
        if CheckPlace() then
            task.wait(MinutesToSeconds(GameTime))
            GoBackToLobby()
        elseif not CheckPlace() then
            task.wait(MinutesToSeconds(LobbyTime))
            GoBackToLobby()
        end
    end
    prints(`{if bool then "Enabled" else "Disabled"} Rejoin After Time`)
end
