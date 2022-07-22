local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer

local playerInventory = ReplicatedStorage:WaitForChild("PlayerInventories"):WaitForChild(player.UserId)
local itemFrame = ReplicatedStorage:WaitForChild("GuiElements"):FindFirstChild("ItemFrame")

local lastInventory = 0
local itemAnchor = script.Parent.ScrollingFrame

function createFrames()
	for _, item in pairs(playerInventory:GetChildren()) do
		local newFrame = itemFrame:Clone()
		
		newFrame.ItemName.Text = item.Name

		newFrame.RarityName.Text = item:GetAttribute("Rarity")
		newFrame.RarityName.TextColor3 = item.Color
		newFrame.Parent = itemAnchor
		task.wait()
	end
end

function removeFrames()
	for _, frame in pairs(itemAnchor:GetChildren()) do
		if frame:IsA("Frame") then
			frame:Destroy()
		end
		task.wait()
	end
end

while true do
	if lastInventory ~= #playerInventory:GetChildren() then
		removeFrames()
		task.wait()
		createFrames()
		lastInventory = #playerInventory:GetChildren()
	end
	task.wait()
end