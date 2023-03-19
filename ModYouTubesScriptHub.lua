--RLH
local screengui = Instance.new("ScreenGui")
local playergui = game:GetService("Players").LocalPlayer.PlayerGui
local mainframe = Instance.new("Frame")
local Scrollingscripthub = Instance.new("ScrollingFrame")
local Script1Button = Instance.new("TextButton")
local Script2Button = Instance.new("TextButton")
local Script3Button = Instance.new("TextButton")
local Script4Button = Instance.new("TextButton")
local Script4TextBox = Instance.new("TextBox")
local Script5Button = Instance.new("TextButton")

local RespawnButton = Instance.new("TextButton")
local closekey = Enum.KeyCode.LeftControl
local uilist = Instance.new("UIListLayout")
local uis = game:GetService("UserInputService")
local logo = Instance.new("TextLabel")
local VRMode = true --turns your this gui into a part on your left hand
local Startergui = game:GetService("StarterGui")

screengui.Parent = playergui
screengui.ResetOnSpawn = false
mainframe.Parent = screengui
mainframe.Size = UDim2.new(0, 607,0 ,300)
mainframe.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
mainframe.Position = UDim2.new(0, 700 ,0, 500)
mainframe.BorderSizePixel = 0
logo.Parent = mainframe
logo.BackgroundTransparency= 1
logo.Font = Enum.Font.Sarpanch
logo.Text = "ModYouTube's Script Hub"
logo.Size = UDim2.new(0,200,0,30)
logo.TextScaled = true
logo.TextColor3 = Color3.new(1, 1, 1)
Scrollingscripthub.Parent = mainframe
Scrollingscripthub.Position = UDim2.new(0,100,0,50)
Scrollingscripthub.Size = UDim2.new(0,400,0,200)
Scrollingscripthub.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
Scrollingscripthub.BorderSizePixel = 0
uilist.Parent = Scrollingscripthub
Script1Button.Parent = Scrollingscripthub
Script1Button.Text = "AlgodooUser's Edited CLOVR (VR and Non-VR Supported)"
Script1Button.TextScaled = true
Script1Button.Size = UDim2.new(0, 300,0, 50)
Script1Button.MouseButton1Click:Connect(function(click)
	
	loadstring(game:HttpGet(("https://pastebin.com/raw/aAuN5Zry"), true))()
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)
Script1Button.BackgroundColor3 = Color3.new(1, 1, 1)
Script1Button.BorderSizePixel = 0
Script1Button.Font = Enum.Font.SciFi
Script1Button.BorderSizePixel = 0
Script2Button.Parent = Scrollingscripthub
Script2Button.Text = "Fly Script FE (G To Fly)"
Script2Button.TextScaled = true
Script2Button.Size = UDim2.new(0, 300,0, 50)
Script2Button.MouseButton1Click:Connect(function(click)
	Script2Button.BorderSizePixel = 0
	Script2Button.BackgroundColor3 = Color3.new(1,1,1)	
	loadstring(game:HttpGet(("https://pastebin.com/raw/8uzbykJb"), true))()
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)

Script3Button.Parent = Scrollingscripthub
Script3Button.Text = "Adrenaline VR (VR Only)"
Script3Button.TextScaled = true
Script3Button.Size = UDim2.new(0, 300,0, 50)
Script3Button.MouseButton1Click:Connect(function(click)
	loadstring(game:HttpGet(("https://pastebin.com/raw/P2Wgi3wJ"), true))()
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)
Script3Button.BackgroundColor3 = Color3.new(1, 1, 1)
Script3Button.BorderSizePixel = 0
Script3Button.Font = Enum.Font.SciFi

Script4Button.Parent = Scrollingscripthub
Script4Button.Text = "Roblox GOD (FE)"
Script4Button.TextScaled = true
Script4Button.Size = UDim2.new(0, 300,0, 50)
Script4Button.MouseButton1Click:Connect(function(click)
	local plr = game:GetService("Players").LocalPlayer
	local humamoid = plr.Character:FindFirstChildOfClass("Humanoid")
	humamoid.WalkSpeed = 100
	humamoid.JumpHeight = 100
	humamoid.MaxHealth = math.huge
	humamoid.Health = math.huge
	humamoid.BreakJointsOnDeath = false
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)
Script4Button.BackgroundColor3 = Color3.new(1, 1, 1)
Script4Button.BorderSizePixel = 0
Script4Button.Font = Enum.Font.SciFi

Script5Button.Parent = Scrollingscripthub
Script5Button.Text = "Fixed Skeds VR (Pal Hair, Lavander Updo, Medival Hood)"
Script5Button.TextScaled = true
Script5Button.Size = UDim2.new(0, 300,0, 50)
Script5Button.MouseButton1Click:Connect(function(click)
	loadstring(game:HttpGet(("https://pastebin.com/raw/ndyYGetz"), true))()
	
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)
Script5Button.BackgroundColor3 = Color3.new(1, 1, 1)
Script5Button.BorderSizePixel = 0
Script5Button.Font = Enum.Font.SciFi












RespawnButton.Parent = mainframe
RespawnButton.Size = UDim2.new(0,110,0,20)
RespawnButton.Position = UDim2.new(0,500,0,200)
RespawnButton.Text = "Respawn"
RespawnButton.MouseButton1Click:Connect(function(none)
	local plr = game:GetService("Players").LocalPlayer.Character
	local hum = plr:FindFirstChildOfClass("Humanoid")
	hum.Health = 0
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "ModYouTubes Script Hub";
		Text = "Executed";
		Icon = "nil"})
	Duration = 16;
end)
uis.InputBegan:Connect(function(key)
	if key.KeyCode == closekey then
		mainframe.Visible = not mainframe.Visible
	end
end)
if VRMode == true then
	local part = Instance.new("Part")
	local Surfacegui = Instance.new("SurfaceGui")
	local cam = workspace.CurrentCamera
	
	part.Parent = game.Workspace
	part.CanCollide = false
	part.Anchored = true
	part.Transparency = 1
	part.Size = Vector3.new(4,4,1)
	closekey = Enum.KeyCode.Thumbstick1
	Surfacegui.Parent = part
	Surfacegui.Face = "Back"
	Surfacegui.AlwaysOnTop = true
	Surfacegui.CanvasSize = Vector2.new(605,500)
	mainframe.Parent = Surfacegui
	mainframe.Position = UDim2.new(0,0,0,0)
	uis.UserCFrameChanged:Connect(function(part2,move)
		if part2 == Enum.UserCFrame.LeftHand then
			part.CFrame = cam.CFrame * move
		end
	end)
else
	local UserInputService = game:GetService("UserInputService")

local gui = mainframe

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0, true); -- drag speed
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
end


