local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("PurchaseItem")
local ItemsFolder = game:GetService("ServerStorage"):WaitForChild("Items")
local PlayerInventories = ReplicatedStorage:WaitForChild("PlayerInventories")

local cubePercentages = {
	Common = 45;
	Uncommon = 25;
	Rare = 15;
	Epic = 10;
	Legendary = 5
}

function purchaseItem(playerFired, itemType)
	if itemType == "Cube" then
		local leaderstats = playerFired.leaderstats
		local cashStat = leaderstats and leaderstats:FindFirstChild("Cash")

		if cashStat.Value >= 500 then
			local playerInventory = PlayerInventories:FindFirstChild(playerFired.UserId)

			local sum = 0
			for _, chance in pairs(cubePercentages) do
				sum = sum + chance
			end


			local index = math.random() * sum


			local choice
			for thing, chance in pairs(cubePercentages) do
				index = index - chance
				if index <= 0 then
					choice = thing
					break
				end
			end

			for _, item in pairs(ItemsFolder:GetChildren()) do
				if item:GetAttribute("ItemType") == itemType then
					if item:GetAttribute("Rarity") == choice then
						local newItem = item:Clone()
						newItem.Parent = playerInventory
					end
				end
			end
			
			cashStat.Value = cashStat.Value - 500

			return choice
		else
			return nil
		end
	end
end

PurchaseRemote.OnServerInvoke = purchaseItem