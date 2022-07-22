local shopPart = game.Workspace.ShopCubeMachine
local player = game:GetService("Players").LocalPlayer

local shopGui = player:WaitForChild("PlayerGui"):WaitForChild("ShopGui")

local character = player.Character

if not character then
	player.CharacterAdded:Wait()
end
character = player.Character

local debounce = false

shopPart.Touched:Connect(function(Hit)
	if Hit.Parent == character and not debounce then
		debounce = true
		
		local machineGui = shopGui:FindFirstChild(shopPart:GetAttribute("shop"))
		
		machineGui.Visible = true
		
		task.wait(1)
		
		debounce = false
	end
end)