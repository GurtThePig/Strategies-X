local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local RemoteEvent = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteEvent") else SpoofEvent
local TDS = Strat.new()
TDS:Map("Tutorial", true, "Tutorial")
if not CheckPlace() then
    return
end
function WaitSpotlight()
    repeat
        task.wait()
    until LocalPlayer.PlayerGui.ReactGameTutorial.Frame.Spotlight and LocalPlayer.PlayerGui.ReactGameTutorial.Frame.Spotlight.Visible
    task.wait(.5)
end
local SelectedTower = {"Scout","Sniper","Demoman","Medic","Minigunner",}
for i,v in next, SelectedTower do
    StratXLibrary.TowerInfo[v] = {maintab:Section(v.." : 0"), 0, v}
end
TimeWaveWait(1,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 1)
TDS:Place("Scout", 7.008869647979736, 17.643810272216797, -27.57561683654785, 1, 0, 0, true, 0, 0, 0)

TimeWaveWait(2,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 2)
TDS:Place("Sniper", 13.30870246887207, 20.113380432128906, -2.0611188411712646, 2, 0, 0, true, 0, 0, 0)

TimeWaveWait(3,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 3)
TDS:Place("Demoman", 19.351028442382812, 18.132587432861328, -19.5122127532959, 3, 0, 0, true, 0, 0, 0)

TimeWaveWait(4,0,0,true)
task.wait(14)
TDS:Upgrade(1, 4, 0, 0, true)
TDS:Upgrade(1, 4, 0, 0, true)
task.wait(.5)
TDS:Upgrade(2, 4, 0, 0, true)
TDS:Upgrade(2, 4, 0, 0, true)

TimeWaveWait(5,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 4)
TDS:Place("Scout", 23.742952346801758, 17.891376495361328, 16.688644409179688, 5, 0, 0, true, 0, 0, 0)

TimeWaveWait(6,0,0,true)
task.wait(15)
--WaitSpotlight()
TDS:Sell(5, 6, 0, 0, true)
task.wait(.5)
TDS:Sell(3, 6, 0, 0, true)
task.wait(1.7)
RemoteEvent:FireServer("Hotbar", "Click", 5)
TDS:Place("Minigunner", 24.955, 17.919, 0.2, 6, 0, 0, true, 0, 0, 0)
