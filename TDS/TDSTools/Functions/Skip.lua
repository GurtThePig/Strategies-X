local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local RemoteEvent = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteEvent") else SpoofEvent
--[[{
    ["Wave"] = number,
    ["Minute"] = number,
    ["Second"] = number,
}]]
return function(self, p1)
    local tableinfo = p1--ParametersPatch("Skip",...)
    local Wave,Min,Sec,InWave = tableinfo["Wave"] or 0, tableinfo["Minute"] or 0, tableinfo["Second"] or 0, tableinfo["InBetween"] or false
    if not CheckPlace() then
        return
    end
    local GameWave = LocalPlayer.PlayerGui:WaitForChild("ReactGameTopGameDisplay"):WaitForChild("Frame"):WaitForChild("wave"):WaitForChild("container"):WaitForChild("value") -- Current wave you are on
    local VoteGUI = LocalPlayer.PlayerGui:WaitForChild("ReactOverridesVote"):WaitForChild("Frame"):WaitForChild("votes"):WaitForChild("vote") -- it is what it is
    SetActionInfo("Skip","Total")
    task.spawn(function()
        if not TimeWaveWait(Wave, Min, Sec, InWave, tableinfo["Debug"]) then
            return
        end
        local SkipState = false
        local SkipCheck
        if VoteGUI:WaitForChild("count").Text ~= `0/{#Players:GetChildren()} Required` or VoteGUI.Position ~= UDim2.new(0.5, 0, 0.5, 0) then
            repeat
                task.wait()
            until VoteGUI:WaitForChild("count").Text == `0/{#Players:GetChildren()} Required` or VoteGUI.Position == UDim2.new(0.5, 0, 0.5, 0)
        end
        if VoteGUI:WaitForChild("prompt").Text ~= "Skip Wave?" or tonumber(GameWave.Text) == 0 then
            return
        end
        repeat
            SkipCheck = RemoteFunction:InvokeServer("Voting", "Skip")
            SkipState = true
            task.wait()
        until SkipCheck or SkipState == true or VoteGUI:WaitForChild("count").Text ~= `0/{#Players:GetChildren()} Required`
        SetActionInfo("Skip")
        ConsoleInfo(`Skipped Wave {Wave} (Min: {Min}, Sec: {Sec}, InBetween: {InWave})`)
    end)
end