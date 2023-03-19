local Hat = "Starmans Voyage"--Starmans Voyage-FlopShoulderAccessory
local text = false --Client Only
local Label = (game.Players.LocalPlayer.Name)
local DestroyMesh = false
local AutoSize = true
local speed = 0.5
local HatRotationOffset = Vector3.new(0, 0, 0)
local LockCameraToHat = true

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,-115.7,0)
			wait(0.5)
		end)
	end
end





local plr = game:GetService("Players").LocalPlayer
local inputservice = game:GetService("UserInputService")
local char = plr.Character
local Handle = char:FindFirstChild(Hat).Handle
plr.Character.HumanoidRootPart.Anchored = false
if DestroyMesh == true then
	Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
end

--Handle.Mesh:Destroy()
local part = Instance.new("Part")
local outline = Instance.new("SelectionBox")
part.Parent = game.Workspace
part.Size = Vector3.new(1,1,2)
part.CanCollide = true
part.Anchored = true
part.CFrame = char.PrimaryPart.CFrame
part.Transparency = 1
if AutoSize == true then
	part.Size = Handle.Size
end
outline.Parent = part
outline.Adornee = part
outline.LineThickness = 0.01
Handle:BreakJoints()
wait()
local Attachment1 = Instance.new("Attachment")
Attachment1.Parent = Handle
--Attachment1.WorldOrientation = HatRotationOffset
local Attachment2 = Instance.new("Attachment")
Attachment2.Parent = part
local AlignPos = Instance.new("AlignPosition")
AlignPos.Parent = Handle
AlignPos.Attachment0 = Attachment1
AlignPos.Attachment1 = Attachment2
AlignPos.Responsiveness = 200
local AlignOri = Instance.new("AlignOrientation")
AlignOri.Parent = Handle
AlignOri.Attachment0 = Attachment1
AlignOri.Attachment1 = Attachment2
AlignOri.Responsiveness = 200

local W = false
local ToggleUp = false
local ToggleDown = false
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.S then
		W  = true
		while W	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0,speed)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.S then
		W = false
	end
end)


local S = false

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.W then
		S  = true
		while S	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0,-speed)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.W then
		S = false
	end
end)


local A = false

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.E then
		A  = true
		while A	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.fromEulerAnglesXYZ(-0.1,0,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.E then
		A = false
	end
end)


local D = false

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Q then
		D  = true
		while D	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.fromEulerAnglesXYZ(0.1,0,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Q then
		D = false
	end
end)


local E = false

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.A then
		E  = true
		while E	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.fromEulerAnglesXYZ(0,0.3,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.A then
		E = false
	end
end)

local Q = false

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.D then
		Q  = true
		while Q	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.fromEulerAnglesXYZ(0,-0.3,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.D then
		Q = false
	end
end)
local camera = workspace.CurrentCamera

local F = false
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.G then
		F  = true
		while F	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0,3.5)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.G then
		F = false
	end
end)



local Shift = false
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift then
		Shift  = true
		while Shift	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0.5,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift then
		Shift = false
	end
end)
local CTRL = false
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftControl then
		CTRL  = true
		while CTRL	 == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,-0.5,0)
		end
	end
end)
inputservice.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftControl then
		CTRL = false
	end
end)
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Z then
		part.Orientation = Vector3.new(0,0,0)

	end
end)

inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.X then
		part.Position = char.PrimaryPart.Position

	end
end)
local humanoid = char:FindFirstChildOfClass("Humanoid")







if text == true then
	local surfacegui = Instance.new("BillboardGui")
	local text =Instance.new("TextLabel")

	surfacegui.Parent = part
	surfacegui.Size = UDim2.new(0,100,0,100)
	surfacegui.StudsOffsetWorldSpace = Vector3.new(0,1,0)
	text.Parent = surfacegui
	text.Text = Label
	text.TextColor3 = Color3.new(1, 1, 1)
	text.BackgroundTransparency = 1
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.new(0.647059, 0.647059, 0.647059)

	text.Size =  UDim2.new(0,100,0,100)
	--outline.Parent = part
	--outline.LineThickness = 0.01
end
if LockCameraToHat == true then
camera.CameraSubject = part
char.PrimaryPart.Anchored = true
end


local function Respawn()
	part:Destroy()
	char:FindFirstChild(Hat):Destroy()
	camera.CameraSubject = char:FindFirstChildOfClass("Humanoid")

end

humanoid.Died:Connect(Respawn)
local playergui = plr.PlayerGui
local SettingsGUI = game:GetObjects("rbxassetid://11618751859")[1]
SettingsGUI.Parent = playergui
local MainFrame = SettingsGUI.main
local SettingsFrame = MainFrame.settingsframe
local VisibleButton1 = MainFrame.button2
local SpeedButton1 = SettingsFrame.up
local SpeedButton2 = SettingsFrame.down
local SpeedText = SettingsFrame.speedtext


VisibleButton1.MouseButton1Click:Connect(function(uhhh)
	MainFrame.Visible = not MainFrame.Visible
end)

SpeedButton1.MouseButton1Click:Connect(function(oreoMcFlurry)
	speed = speed + 0.1
	SpeedText.Text = speed
end)
SpeedButton2.MouseButton1Click:Connect(function(factoryDefense)
	speed = speed - 0.1
	SpeedText.Text = speed
end)
print("Flying Hat by ModYouTube,","Thanks ",plr.Name)



inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.R then
		ToggleUp = not ToggleUp
		while ToggleUp == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0.05,0)
		end
	end
end)
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.F then
		ToggleDown = not ToggleDown
		while ToggleDown == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,-0.05,0)
		end
	end
end)
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.H then
		part.Anchored = false
	end
end)
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.J then
		part.Anchored = true
	end
end)
local toggleAI = false
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.B then
		toggleAI = not toggleAI
		while toggleAI == true do
			wait()
			part.CFrame = part.CFrame * CFrame.new(0,0,-speed)
		end
	end
end)
inputservice.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.E then
	local sound = Instance.new("Sound", parent)
	sound.Parent = handle
	sound.PlayOnRemove = true
	sound.SoundId = "rbxassetid://587945238"
	sound:Destroy()
	
	end
end)