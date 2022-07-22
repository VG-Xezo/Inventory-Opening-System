local Players = game:GetService("Players")

function playerAdded(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local Cash = Instance.new("IntValue")
	Cash.Name = "Cash"
	Cash.Value = 100000
	Cash.Parent = leaderstats
end

Players.PlayerAdded:Connect(playerAdded)