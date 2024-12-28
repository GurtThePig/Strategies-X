local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local UtilitiesConfig = StratXLibrary.UtilitiesConfig
local GameTime = UtilitiesConfig.RejoinSetting.GameTime or 25
local LobbyTime = UtilitiesConfig.RejoinSetting.LobbyTime or 5

function MinutesToSeconds(Minutes)
	return Minutes*60
end

function SafeTeleport(Remote)
    local attemptIndex = 0
    local success, result
    local ATTEMPT_LIMIT = 25
    local RETRY_DELAY = 5
    repeat
        success, result = pcall(function()
            return Remote
        end)
        attemptIndex += 1
        if not success then
            task.wait(RETRY_DELAY)
        end
    until success or attemptIndex == ATTEMPT_LIMIT
end

StratXLibrary.RejoinAfterTime = function(bool)
	local ErrorCheck
	if bool and CheckPlace() then
		task.delay(MinutesToSeconds(GameTime), function()
			ErrorCheck = true
		end)
		if ErrorCheck then
		    prints(`Game Timed Out! ({GameTime} Minutes)`)
		end
	elseif bool and not CheckPlace() then
		task.delay(MinutesToSeconds(GameTime), function()
			ErrorCheck = true
		end)
		if ErrorCheck then
		    prints(`Lobby Timed Out! ({LobbyTime} Minutes)`)
		end
    end
end