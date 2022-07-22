local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local InventoriesFolder = ReplicatedStorage:WaitForChild("PlayerInventories")
local ItemsFolder = game:GetService("ServerStorage"):WaitForChild("Items")

local inventoryStore = DataStoreService:GetDataStore("Inventories")

function setupInventories(player)
	
	local savedInventory
	
	local success, err = pcall(function()
		savedInventory = inventoryStore:GetAsync(player.UserId .. "-inventory") or {}
	end)
	if not success then
		warn(player.UserId .. " TRIGGERED: " .. err)
	end
	
	local PlayerInventory = Instance.new("Folder")
	PlayerInventory.Name = player.UserId
	PlayerInventory.Parent = InventoriesFolder
	
	if #savedInventory ~= 0 then
		for i, savedItem in pairs(savedInventory) do
			if ItemsFolder:FindFirstChild(savedItem) then
				ItemsFolder[savedItem]:Clone().Parent = InventoriesFolder:FindFirstChild(player.UserId)
			end
		end
	end
end

function cleanupInventories(player)
	local itemsOwned = {}

	for i, itemInFolder in pairs(InventoriesFolder:FindFirstChild(player.UserId):GetChildren()) do

		table.insert(itemsOwned, itemInFolder.Name)
	end

	local success, errormsg = pcall(function()

		inventoryStore:SetAsync(player.UserId .. "-inventory", itemsOwned)
	end)
	if errormsg then warn(errormsg) end


end

Players.PlayerAdded:Connect(setupInventories)
Players.PlayerRemoving:Connect(cleanupInventories)