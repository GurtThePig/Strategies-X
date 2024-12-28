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

local SpecialMaps = {
	"Pizza Party",
	"Badlands II",
	"Polluted Wastelands II",
	--Current Special Maps ^^^^^^
	"Failed Gateway",
	"The Nightmare Realm",
	"Containment",
	--Halloween 2024 Maps ^^^^^^
	"Pls Donate",
	--Pls Donate Collaboration Map
	"Outpost 32",
	--Frost Invasion 2024 Map
	"Classic Candy Cane Lane",
	"Classic Winter",
	"Classic Forest Camp",
	"Classic Island Chaos",
	"Classic Castle",
	--The Classic Roblox Event Special Maps ^^^^^^
	"Huevous Hunt",
	--The Hunt Roblox Event Special Maps ^^^^^^
}

local SpecialGameMode = {
    ["Pizza Party"] = {mode = "halloween", challenge = "PizzaParty"},
    ["Badlands II"] = {mode = "badlands", challenge = "Badlands"},
    ["Polluted Wasteland II"] = {mode = "polluted", challenge = "PollutedWasteland"},
    --Current Special Maps ^^^^^^
    ["Failed Gateway"] = {mode = "halloween2024", difficulty = "Act1", night = 1},
    ["The Nightmare Realm"] = {mode = "halloween2024", difficulty = "Act2", night = 2},
    ["Containment"] = {mode = "halloween2024", difficulty = "Act3", night = 3},
    ["Pls Donate"] = {mode = "plsDonate", difficulty = "PlsDonateHard"},
    ["Outpost 32"] = {mode = "frostInvasion", difficulty = "Hard" },
    --Temporary Special Maps ^^^^^^
    ["Classic Candy Cane Lane"] = {mode = "Event", part = "ClassicRobloxPart1"},
    ["Classic Winter"] = {mode = "Event", part = "ClassicRobloxPart2"},
    ["Classic Forest Camp"] = {mode = "Event", part = "ClassicRobloxPart3"},
    ["Classic Island Chaos"] = {mode = "Event", part = "ClassicRobloxPart4"},
    ["Classic Castle"] = {mode = "Event", part = "ClassicRobloxPart5"},
    --The Classic Event Maps ^^^^^^ [STILL EXIST IN GAME FILES]
    ["Huevous Hunt"] = {""},
    --The Hunt Event Maps [NO LONGER EXIST IN GAME FILES]
}

local WeeklyChallenge = {
    "BackToBasics",
    --[["JailedTowers",
    "Juggernaut",
    "Legion",
    "OopsAllSlimes",
    "Vanguard"]]
}

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
	local Remote, ErrorCheck
    if bool and CheckPlace() then
		print(GameTime)
		task.delay(MinutesToSeconds(GameTime), function()
			ErrorCheck = true
		end)
		if ErrorCheck then
			prints(`Game Timed Out! ({GameTime} Minutes)`)
			local Strat = StratXLibrary.Strat
			local MapInStrat = Strat.Map.Lists[#Strat.Map.Lists] and Strat.Map.Lists[#Strat.Map.Lists].Map
            if table.find(SpecialMaps, MapInStrat) then
               	local SpecialTable = SpecialGameMode[MapInStrat]
               	if SpecialTable.mode == "halloween2024" then
                   	Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
               			["difficulty"] = SpecialTable.difficulty,
               			["night"] = SpecialTable.night,
             			["count"] = 1,
               			["mode"] = SpecialTable.mode,
               		})
               		SafeTeleport(Remote)
               	elseif SpecialTable.mode == "plsDonate" then
               		Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
               			["difficulty"] = SpecialTable.difficulty,
               			["count"] = 1,
               			["mode"] = SpecialTable.mode,
               		})
             		SafeTeleport(Remote)
               	elseif SpecialTable.mode == "frostInvasion" then
               		Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
               			["difficulty"] = if getgenv().EventEasyMode then "Easy" else "Hard",
               			["mode"] = SpecialTable.mode,
               			["count"] = 1,
               		})
               		SafeTeleport(Remote)
               	elseif getgenv().WeeklyChallenge then
               		Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
               			["mode"] = "weeklyChallengeMap",
               			["count"] = 1,
               			["challenge"] = WeeklyChallenge,
               		})
               		SafeTeleport(Remote)
               	elseif SpecialTable.mode == "Event" then
               		Remote = RemoteFunction:InvokeServer("EventMissions","Start", SpecialTable.part)
               		SafeTeleport(Remote)
               	else
               		Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
                		["count"] = 1,
               			["mode"] = SpecialTable.mode,
               			["challenge"] = SpecialTable.challenge,
               		})
               		SafeTeleport(Remote)
               	end
            else
               	local DiffTable = {
               		["Easy"] = "Easy",
               		["Normal"] = "Molten",
               		["Intermediate"] = "Intermediate",
               		["Molten"] = "Molten",
               		["Fallen"] = "Fallen",
               	}
               	local DifficultyName = Strat.Mode.Lists[1] and DiffTable[Strat.Mode.Lists[1].Name]
               	Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
               		["count"] = 1,
               		["mode"] = string.lower(Strat.Map.Lists[1].Mode),
               		["difficulty"] = DifficultyName,
               	})
               	SafeTeleport(Remote)
            end
		end
    elseif bool and not CheckPlace() then
		print(LobbyTime)
		task.delay(MinutesToSeconds(LobbyTime), function()
			ErrorCheck = true
		end)
		if ErrorCheck then
			prints(`Lobby Timed Out! ({LobbyTime} Minutes)`)
            Remote = TeleportHandler(3260590327,2,7)
            SafeTeleport(Remote)
		end
	end
	prints(`{if bool then "Enabled" else "Disabled"} Rejoin After Time`)
end