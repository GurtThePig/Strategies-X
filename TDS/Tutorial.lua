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
    until LocalPlayer.PlayerGui.Tutorial.tutorial.Spotlight and LocalPlayer.PlayerGui.Tutorial.tutorial.Spotlight.Visible
    task.wait(.5)
end
local SelectedTower = {"Scout","Sniper","Demoman","Medic","Minigunner",}
for i,v in next, SelectedTower do
    StratXLibrary.TowerInfo[v] = {maintab:Section(v.." : 0"), 0, v}
end
TimeWaveWait(1,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 1)
TDS:Place("Scout", 8.179950714111328, 17.6803035736084, -25.541385650634766, 1, 0, 0, true, 0, 0, 0)

TimeWaveWait(2,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 2)
TDS:Place("Sniper", 13.253104209899902, 20.119537353515625, -1.7884986400604248, 2, 0, 0, true, 0, 0, 0)

TimeWaveWait(3,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 3)
TDS:Place("Demoman", 22.69474983215332, 18.100854873657227, -19.067611694335938, 3, 0, 0, true, 0, 0, 0)

TimeWaveWait(4,0,0,true)
task.wait(15)
WaitSpotLight()
TDS:Place('Scout', 25.7487850189209, 18.06426239013672, -19.04046630859375, 4, 0, 0, false, 0, 0, 0, false)
task.wait(.5)
TDS:Upgrade(4, 4, 0, 0, true)
TDS:Upgrade(4, 4, 0, 0, true)
task.wait(.5)
TDS:Upgrade(2, 4, 0, 0, true)
TDS:Upgrade(2, 4, 0, 0, true)

TimeWaveWait(5,0,0,true)
WaitSpotlight()
RemoteEvent:FireServer("Hotbar", "Click", 4)
TDS:Place("Scout", 23.797218322753906, 17.89316749572754, 16.803075790405273, 5, 0, 0, true, 0, 0, 0)

TimeWaveWait(6,0,0,true)
task.wait(15)
WaitSpotlight()
TDS:Sell(5, 6, 0, 0, true)
task.wait(.5)
TDS:Sell(2, 6, 0, 0, true)
task.wait(1.7)
RemoteEvent:FireServer("Hotbar", "Click", 5)
TDS:Place("Minigunner", 23.00552749633789, 17.939851760864258, 0.021044734865427017, 6, 0, 0, true, 0, 0, 0)
