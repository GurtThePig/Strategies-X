local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local RemoteEvent = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteEvent") else SpoofEvent

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

return function(self, p1)
    local tableinfo = p1--ParametersPatch("LeaveOn",...)
    local Map = tableinfo["Map"]
    local Mode = tableinfo["Mode"]
    local Difficulty = tableinfo["Difficulty"]
    local Wave,Min,Sec,InWave = tableinfo["Wave"] or 0, tableinfo["Minute"] or 0, tableinfo["Second"] or 0, tableinfo["InBetween"] or false
    if not CheckPlace() then
        return
    end
    SetActionInfo("LeaveOn", "Total")
    task.spawn(function()
        if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(LocalPlayer.UserId, 10518590) then
            getgenv().AutoRestart = true
            SaveUtilitiesConfig()
            return
        end
        if not TimeWaveWait(Wave, Min, Sec, InWave, tableinfo["Debug"]) then
            return
        end
        SetActionInfo("LeaveOn")
        ConsoleInfo(`Left On Wave: {Wave} (Min: {Min}, Sec: {Sec}, InBetween: {InWave})`)
        if table.find(SpecialMaps, Map) then
            local SpecialTable = SpecialGameMode[Map]
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
            local DifficultyConvert = DiffTable[Difficulty]
            Remote = RemoteFunction:InvokeServer("Multiplayer","v2:start",{
                ["count"] = 1,
                ["mode"] = string.lower(Mode),
                ["difficulty"] = DifficultyConvert,
            })
            SafeTeleport(Remote)
        end
    end)
end