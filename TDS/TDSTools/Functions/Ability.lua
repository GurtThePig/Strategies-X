local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local RemoteEvent = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteEvent") else SpoofEvent
--[[{
    ["TowerIndex"] = "",
    ["TypeIndex"] = "",
    ["Ability"] = "",
    ["Wave"] = number,
    ["Minute"] = number,
    ["Second"] = number,
}]]
return function(self, p1)
    local tableinfo = p1--ParametersPatch("Ability",...)
    local Tower = tableinfo["TowerIndex"]
    local Ability = tableinfo["Ability"]
    local Data = tableinfo["Data"]
    local Wave,Min,Sec,InWave = tableinfo["Wave"] or 0, tableinfo["Minute"] or 0, tableinfo["Second"] or 0, tableinfo["InBetween"] or false 
    if not CheckPlace() then
        return
    end
    local CurrentCount = StratXLibrary.CurrentCount
    SetActionInfo("Ability","Total")
    task.spawn(function()
        local TimerCheck = TimeWaveWait(Wave, Min, Sec, InWave, tableinfo["Debug"])
        if not TimerCheck then
            return
        end
<<<<<<< HEAD
        local AbilityCheck
        local TowerType = GetTypeIndex(tableinfo["TypeIndex"],Tower)
        task.spawn(function()
            task.wait(2)
            while not (type(AbilityCheck) == "boolean" and AbilityCheck) do
                ConsoleWarn(`Cannot Ability (Name: {Ability} On Tower Index: {Tower}, Type: \"{TowerType}\", (Wave {Wave}, Min: {Min}, Sec: {Sec}, InBetween: {InWave})`)
                task.wait(1)
            end
        end)
        repeat
            if not TowersCheckHandler(Tower) then
                return
            end
            if Ability == "Call Of Arms" and TowersContained[Tower].AutoChain then
                SetActionInfo("Ability")
                ConsoleInfo("Skipped Ability (AutoChain Enabled) On Tower Index: "..Tower..", Type: \""..TowerType.."\", (Wave "..Wave..", Min: "..Min..", Sec: "..Sec..", InBetween: "..tostring(InWave)..")")
                return
            end
            AbilityCheck = RemoteFunction:InvokeServer("Troops","Abilities","Activate",{
                ["Troop"] = TowersContained[Tower].Instance,
                ["Name"] = Ability,
                ["Data"] = Data,
            })
            task.wait()
        until type(AbilityCheck) == "boolean" and AbilityCheck
=======
        local CheckAbilityUsed, SkipCheck
        task.delay(50, function()
            SkipCheck = true
        end)
        repeat
            if not TowersCheckHandler(Tower) then
                prints("End Ability",Wave, Min, Sec, InWave)
                return
            end
            if Ability == "Call Of Arms" and TowersContained[Tower].AutoChain then
                local TowerType = GetTypeIndex(tableinfo["TypeIndex"],Tower)
                SetActionInfo("Ability")
                ConsoleInfo("Skipped Ability (AutoChain Enabled) On Tower Index: "..Tower..", Type: \""..TowerType.."\", (Wave "..Wave..", Min: "..Min..", Sec: "..Sec..", InBetween: "..tostring(InWave)..")")
                return
            end
            CheckAbilityUsed = RemoteFunction:InvokeServer("Troops","Abilities","Activate",{
                ["Troop"] = TowersContained[Tower].Instance,
                ["Name"] = Ability,
                ["Data"] = Data,
            })
        until CheckAbilityUsed or SkipCheck
        local TowerType = GetTypeIndex(tableinfo["TypeIndex"],Tower)
        if CurrentCount ~= StratXLibrary.RestartCount then
            return
        end
        if SkipCheck and not CheckAbilityUsed then
            ConsoleError("Failed To Use Ability On Tower Index: "..Tower..", Type: \""..TowerType.."\", (Wave "..Wave..", Min: "..Min..", Sec: "..Sec..", InBetween: "..tostring(InWave)..") CheckAbilityUsed: "..tostring(CheckAbilityUsed)..", SkipCheck: "..tostring(SkipCheck))
            return
        end
>>>>>>> 80f342aa480944fb830d384fec500674f0394296
        SetActionInfo("Ability")
        ConsoleInfo("Used Ability On Tower Index: "..Tower..", Type: \""..TowerType.."\", (Wave "..Wave..", Min: "..Min..", Sec: "..Sec..", InBetween: "..tostring(InWave)..") CheckAbilityUsed: "..tostring(CheckAbilityUsed)..", SkipCheck: "..tostring(SkipCheck))
    end)
end
