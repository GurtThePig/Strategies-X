local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(self, p1)
    local tableinfo = p1
    local GameSetLoadoutName = tableinfo["GameSetLoadout"]
    if not CheckPlace() then
        return
    end
    task.spawn(function()
        local RemoteCheck
        repeat
            RemoteCheck = ReplicatedStorage.Network.PlayerManager.SelectLoadout:FireServer(GameSetLoadoutName)
            task.wait()
            print(RemoteCheck)
        until RemoteCheck
        ConsoleInfo("Choosen Loadout: "..GameSetLoadoutName)
    end)
end