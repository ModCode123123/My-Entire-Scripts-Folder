local controllermodels = game:GetObjects("rbxassetid://12197690222")[1]
controllermodels.Parent = workspace
wait(1)
game:GetService("UserInputService").UserCFrameChanged:Connect(function(part,move)
	if part == Enum.UserCFrame.LeftHand then
		controllermodels.leftcontroller.Body.CFrame = workspace.CurrentCamera.CFrame * move
	end
	if part == Enum.UserCFrame.RightHand then
		controllermodels.rightcontroller.Body.CFrame = workspace.CurrentCamera.CFrame * move
	end
end)
game:GetService("UserInputService").InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Thumbstick1 then
		controllermodels.leftcontroller.thumbstick.Position = key.Position.Y
	end
end)
game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)
