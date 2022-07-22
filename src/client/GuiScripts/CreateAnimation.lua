local bindableEvent = script.Parent.TriggerAnimation
local OpenAnimation = script.Parent
local TweenService = game:GetService("TweenService")

bindableEvent.Event:Connect(function(purchasedItem, color)
	OpenAnimation.CircleFrame.BackgroundColor3 = color
	OpenAnimation.ItemText.Text = purchasedItem
	OpenAnimation.ItemText.TextColor3 = color
	
	local startPos = OpenAnimation.CircleFrame.Position
	
	local xScale = OpenAnimation.CircleFrame.Position.X.Scale
	local goal = UDim2.new(xScale,0,1.5,0)
	
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine)
	
	local tween = TweenService:Create(OpenAnimation.CircleFrame, tweenInfo, {Position = goal})
	
	task.wait(0.5)
	
	tween:Play()
	
	tween.Completed:Wait()
	
	task.wait(1)
	OpenAnimation.Enabled = false
	OpenAnimation.CircleFrame.Position = startPos
	
end)