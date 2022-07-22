local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("PurchaseItem")
local button = script.Parent

local player = game:GetService("Players").LocalPlayer

local openEvent =  player:WaitForChild("PlayerGui"):WaitForChild("OpenAnimation").TriggerAnimation
local OpenAnimation = player:WaitForChild("PlayerGui"):WaitForChild("OpenAnimation")

local cubeColors = {
	Common = Color3.fromRGB(163, 162, 165);
	Uncommon = Color3.fromRGB(75, 151, 75);
	Rare = Color3.fromRGB(9, 137, 207);
	Epic = Color3.fromRGB(123, 0, 123);
	Legendary = Color3.fromRGB(245, 205, 48)
}


button.Activated:Connect(function()
	local leaderstats = player.leaderstats
	local cashStat = leaderstats and leaderstats:FindFirstChild("Cash")
	
	if cashStat.Value >= 500 then
		local purchasedItem = PurchaseRemote:InvokeServer("Cube")
		
		local color = cubeColors[purchasedItem]

		OpenAnimation.Enabled = true

		openEvent:Fire(purchasedItem .. " Cube", color)
	end
	
end)