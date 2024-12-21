local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteFunction") else SpoofEvent
local RemoteEvent = if not GameSpoof then ReplicatedStorage:WaitForChild("RemoteEvent") else SpoofEvent

return function(self, p1)
    local tableinfo = p1
    local GameSetLoadoutName = tableinfo["GameSetLoadout"]
    if not CheckPlace() then
        return
    end
    task.spawn(function()
        local RemoteCheck
        RemoteCheck = ReplicatedStorage.Network.PlayerManager.SelectLoadout:FireServer(GameSetLoadoutName)
        ConsoleInfo("Choosen Loadout: "..GameSetLoadoutName)
    end)
end