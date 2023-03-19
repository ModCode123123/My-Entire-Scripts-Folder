--[[

     ____            ___        ____     _______          __       _   _____                    
    / __/  _____ ___/ ( )___   / __/_ __/ / / _ )___  ___/ /_ __  | | / / _ \                   
   _\ \| |/ / -_) _  /|/(_-<  / _// // / / / _  / _ \/ _  / // /  | |/ / , _/                   
  /___/|___/\__/\_,_/_ /___/ /_/_ \_,_/_/_/____/\___/\_,_/\_, /  _|___/_/|_| __
  ___              
 | | /| / /__  ____/ /__ ___   (_)__    ___ _  _____ ____/___/  / _ \/ __/  / ___/__ ___ _  ___ 
 | |/ |/ / _ \/ __/  '_/(_-<  / / _ \  / -_) |/ / -_) __/ // / / , _/ _ \  / (_ / _ `/  ' \/ -_)
 |__/|__/\___/_/ /_/\_\/___/ /_/_//_/  \__/|___/\__/_/  \_, / /_/|_|\___/  \___/\_,_/_/_/_/\__/ ..Almost
                                                       /___/              


The Reason why it looks like clovr is because there are no other ways to make an original 
full body VR Script now so i had to just make one with the knowledge i have

anyways heres the controls

CONTROLS:

LTHUMBSTICK = Move
RTHUMBSTICK = Turn Camera
A = Jump
ButtonY = Open/Close ChatGUI if Enabled

and thats all for now
you can change the hats and settings below Feel free to change any setting
]]
local RestrictedTorsoMovement = false --Restricts the X rotation of the Torso (RagdollEnabled false)
local RestrictedTorsoHeight = false --Restricts the Torso height to your VRMover's Y Position
local ConnectedBody = false --Uses ball in socket To connect Your VR Body Together
local RagdollEnabled = false --Uses your character instead of hats
local SmoothLegMovement = true --Makes the Leg movement Smooth
local CustomNetless = false --Uses a custom Netless else Netless v3
local ShowControllerModels = false --Shows the roblox VR Controller Models
local ShowVRLaserCursor = 0 --Shows the roblox VR Pointer 0 = False 2 = true
local VRBodyTransparecy = 0.65 --The Transparency of your vr body
local ChatGUI = true --a GUI that follows your head position containing a custom chat
local ClockHUD = true --A clock on your left hand displaying your IRL time
local KillOnBreak =  true --if the script breaks it will respawn your character and you will have to Re-run the script
local VRBodyHeightOffset = 0 --The height in studs of the offset of your vrbody
local AccessorySettings = {
	LeftArm = "Pal Hair";
	RightArm = "LavanderHair";
	LeftLeg = "Kate Hair";
	RightLeg = "Hat1";
	Torso = "SeeMonkey";
	Head = "Robloxclassicred";	

	AutoHead = true; --Uses the leftover hats for you head
}




local plr = game:GetService("Players").LocalPlayer
local char = plr.Character																																										
local leftarm 
local rightarm
local rightleg
local torso
local head
local LegUpdateTime = 0.1
local HeadHats = {}
if RagdollEnabled == true then
	leftarm = char["Left Arm"]
	rightarm = char["Right Arm"]
	torso = char["Torso"]
	leftleg = char["Left Leg"]
	rightleg =char["Right Leg"]
	head = char["Head"]
else

	leftarm = char:FindFirstChild(AccessorySettings.LeftArm).Handle
	rightarm = char:FindFirstChild(AccessorySettings.RightArm).Handle
	leftleg = char:FindFirstChild(AccessorySettings.LeftLeg).Handle
	rightleg = char:FindFirstChild(AccessorySettings.RightLeg).Handle
	torso = char:FindFirstChild(AccessorySettings.Torso).Handle
	head = char:FindFirstChild(AccessorySettings.Head).Handle
end
if CustomNetless == true then
	game:GetService("RunService").Heartbeat:Connect(function()
		leftarm.Handle.Velocity = Vector3.new(35,0,0)
		rightarm.Handle.Velocity = Vector3.new(35,0,0)
		leftleg.Handle.Velocity = Vector3.new(35,0,0)
		rightleg.Handle.Velocity = Vector3.new(35,0,0)
		torso.Handle.Velocity = Vector3.new(35,0,0)
		head.Handle.Velocity = Vector3.new(35,0,0)
	end)
else
	for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
		if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
			game:GetService("RunService").Heartbeat:connect(function()
				v.Velocity = Vector3.new(0,45,0)
			end)
		end
	end
end
local MoverModel = Instance.new("Model",char)
MoverModel.Name = "Mover"
local HumanoidRootPart = Instance.new("Part",MoverModel)
HumanoidRootPart.Size = Vector3.new(2,2,1)
HumanoidRootPart.Name = "HumanoidRootPart"
HumanoidRootPart.CanCollide = false
HumanoidRootPart.CFrame = char.PrimaryPart.CFrame
HumanoidRootPart.Transparency = 1
local Humanoid = Instance.new("Humanoid",MoverModel)
Humanoid.WalkSpeed = 8
Humanoid.JumpPower = 40
Humanoid.HipHeight = 2.5
Humanoid.CameraOffset = Vector3.new(0, VRBodyHeightOffset, 0)
local VR_Ready = false
local VRService = game:GetService("VRService")
if VRService.VREnabled == true then
	VR_Ready = true
else
	VR_Ready= false
end
local function HatFixer(hat)
	hat:BreakJoints()
	hat:FindFirstChildOfClass("SpecialMesh"):Destroy()
end
local function Align(part0,part1,cframe)
	local Att0 = Instance.new("Attachment",part0)
	local Att1 = Instance.new("Attachment",part1)
	local AlignPosition = Instance.new("AlignPosition",part0)
	local AlignOrientation = Instance.new("AlignOrientation",part0)
	AlignPosition.Attachment0 =Att0
	AlignPosition.Attachment1 = Att1
	AlignPosition.Responsiveness = math.huge
	AlignPosition.MaxForce = math.huge
	AlignPosition.MaxVelocity = math.huge
	AlignOrientation.Attachment0 = Att0
	AlignOrientation.Attachment1 = Att1
	AlignOrientation.Responsiveness = math.huge
	AlignOrientation.MaxTorque = math.huge
	AlignOrientation.MaxAngularVelocity = math.huge
	if SmoothLegMovement == true then
		AlignPosition.Responsiveness = 85
	else
		AlignPosition.Responsiveness = math.huge
	end
	if cframe then
		Att0.CFrame = cframe
	else
		--//uhh
	end
	part0.Massless = true
	part1.Massless = true
end
local function CreateLimb(size,name)
	local part = Instance.new("Part",char)
	part.Size = size
	part.Name = name
	part.CanCollide = false
	part.Anchored = true
	part.Transparency = 1
	return part
end
-- CreateLimb(Vector3.new(1,1,2),"LF")
-- CreateLimb(Vector3.new(1,1,2),"RH")
local LeftFoot 
local RightFoot
if RagdollEnabled == true then
	LeftFoot =  CreateLimb(Vector3.new(1,2,1),"LF")
	RightFoot = CreateLimb(Vector3.new(1,2,1),"RH")
else
	LeftFoot = CreateLimb(Vector3.new(1,1,2),"LH")
	RightFoot = CreateLimb(Vector3.new(1,1,2),"RH")
end 
warn("50%")
Align(leftleg ,LeftFoot,CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
Align(rightleg ,RightFoot,CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
local UserInputService = game:GetService("UserInputService")
local Backpack = plr.Backpack
local Camera = workspace.CurrentCamera
local function UpdateFooting()
	if RagdollEnabled == false then
		wait(LegUpdateTime)
		LeftFoot.CFrame = torso .CFrame * CFrame.new(0.5,0,2)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		LeftFoot.Orientation = Vector3.new(0, -Camera.CFrame.Y, 0)
		wait(LegUpdateTime)
		RightFoot.CFrame = torso .CFrame * CFrame.new(-0.5,0,2)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		RightFoot.Orientation = Vector3.new(0, Camera.CFrame.Y, 0)
	else
		wait(LegUpdateTime)
		LeftFoot.CFrame = torso .CFrame * CFrame.new(0.5,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		LeftFoot.Orientation = Vector3.new(90, 0, 0)
		wait(LegUpdateTime)
		RightFoot.CFrame = torso .CFrame * CFrame.new(-0.5,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		RightFoot.Orientation = Vector3.new(90, 0, 0)
	end
end
if VR_Ready then
	UserInputService.UserCFrameChanged:Connect(function(typec,move)
		if typec == Enum.UserCFrame.LeftHand then
			if RagdollEnabled == false then
				leftarm .CFrame = Camera.CFrame * move*CFrame.new(0,0,0.5)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			else
				leftarm .CFrame = Camera.CFrame * move*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			end
		end
		if typec == Enum.UserCFrame.RightHand then
			if RagdollEnabled == false then
				rightarm.CFrame = Camera.CFrame * move*CFrame.new(0,0,0.5)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			else
				rightarm .CFrame = Camera.CFrame * move*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			end
			for i,x in pairs(char:GetChildren()) do
				if x:IsA("Tool") and x:FindFirstChild("Handle") then
					x.Grip.C0 =  Camera.CFrame * move*CFrame.new(0,0,0.5)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				end
			end
		end
		if typec == Enum.UserCFrame.Head then
			if RagdollEnabled == false then
				head .CFrame = Camera.CFrame * move*CFrame.new(0,0.2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				if RestrictedTorsoMovement == false then
					torso .CFrame = Camera.CFrame * move*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
				else
					if RestrictedTorsoHeight == true then
						torso.Position = Vector3.new(Camera.CFrame.Z,HumanoidRootPart.Position.Y,Camera.CFrame.Z)
					end
					torso .CFrame = Camera.CFrame * move*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
					torso.Orientation = Vector3.new(90,Camera.CFrame.Y,Camera.CFrame.Z)
				end
			else
				head .CFrame = Camera.CFrame * move*CFrame.new(0,0.2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				torso .CFrame = Camera.CFrame * move*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
			end

		end
	end)
else
local CamPart = Instance.new("Part",char)
CamPart.Size = Vector3.new(1, 1, 1)
CamPart.CanCollide = false
CamPart.Anchored = true
CamPart.Transparency = 1
	local usingleft = false
	local usingright = false	
	local mouse = plr:GetMouse()
	Align(leftarm,torso,CFrame.new(1.5,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
	Align(rightarm,torso,CFrame.new(-1.5,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
	Align(head,CamPart,CFrame.new(0,0,0))
	Align(torso,CamPart,CFrame.new(0,0,-2)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)))
	local Att0 = Instance.new("Attachment",leftarm)
	local Att1 = Instance.new("Attachment",rightarm)
	local Att2 = Instance.new("Attachment",torso)
	local Att3 = Instance.new("Attachment",torso)
	local Ballin = Instance.new("BallSocketConstraint",leftarm)
	Ballin.Attachment0 = Att0
	--Ballin.Attachment1 = Att2
	local Ballin2 = Instance.new("BallSocketConstraint",rightleg)
	Ballin2.Attachment0 = Att1
	--Ballin2.Attachment1 = Att3
	game:GetService("RunService").Heartbeat:Connect(function()
		if torso and head then
			CamPart.CFrame = Camera.CFrame
		end
	end)
	Att2.CFrame = torso.CFrame * CFrame.new(1,-1,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	Att3.CFrame = torso.CFrame * CFrame.new(-1,-1,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	mouse.Button1Down:Connect(function()
		usingleft = true
		Att2.CFrame = torso.CFrame * CFrame.new(1,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	end)
	mouse.Button1Up:Connect(function()
		usingleft = false
		Att2.CFrame = torso.CFrame * CFrame.new(1,-1,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	end)
	mouse.Button2Down:Connect(function()
		usingright = true
		Att3.CFrame = torso.CFrame * CFrame.new(-1,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	end)
	mouse.Button2Up:Connect(function()
		usingright = false
		Att3.CFrame = torso.CFrame * CFrame.new(-1,-1,0)*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
	end)
	--plr.CameraMode = Enum.CameraMode.LockFirstPerson
end
for i,x in pairs(char:GetChildren()) do
	if x:IsA("Accessory") then
		x.Handle.Transparency = VRBodyTransparecy
	end
	if x:IsA("BasePart") then
		x.Transparency = VRBodyTransparecy
		char:FindFirstChildOfClass("Humanoid").RootPart.Transparency = 1
		x.CanCollide =false
	end
end
if RagdollEnabled == true then
	leftarm:BreakJoints()
	rightarm:BreakJoints()
	leftleg:BreakJoints()
	rightleg:BreakJoints()
else
	HatFixer(leftarm)
	HatFixer(rightarm)
	HatFixer(leftleg)
	HatFixer(rightleg)
	HatFixer(torso)
	head:BreakJoints()
end
--plr.Character.HumanoidRootPart.Anchored = true
if RagdollEnabled == true then
	plr.Character.HumanoidRootPart.RootJoint:Destroy()
	plr.Character:FindFirstChildOfClass("Humanoid").RootPart:Destroy()
end
plr.Character = MoverModel
Camera.CameraSubject = Humanoid
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR2 then
		Humanoid.WalkSpeed = 19
		LegUpdateTime = 0.13
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode ==Enum.KeyCode.ButtonR2 then
		Humanoid.WalkSpeed = 8
		LegUpdateTime = 0.25
	end
end)
Humanoid.Died:Connect(function()
	Camera.CameraSubject = game:WaitForChild(plr.Name):FindFirstChildOfClass("Humanoid")
	plr.Character = game:WaitForChild(plr.Name)
	wait(0.1)	
	plr.Character:BreakJoints()
end)
if ClockHUD == true then
	local clock = game:GetObjects("rbxassetid://12270042599")[1]
	clock.Parent = workspace
	clock.Anchored = true
	UserInputService.UserCFrameChanged:Connect(function(a,b)
		if a == Enum.UserCFrame.LeftHand then
			clock.CFrame = Camera.CFrame * b * CFrame.new(0.5,0,0)
		end
	end)
end
if ChatGUI == true then
	local chat = game:GetObjects("rbxassetid://12375597548")[1]
	chat.Parent = workspace
	chat.GUI.Enabled = false
	chat.CanQuery = true
	chat.CanTouch = true
	local function MakeChat(color,msg,player,normalname)
		local chattext = chat.GUI.ChatGUI.TextLabel:Clone()
		chattext.Parent = chat.GUI.ChatGUI.Frame
		chattext.Text = ("["..player.."@"..normalname.."]"..": "..msg)
		chattext.TextColor = color
		wait(20)
		chattext:Destroy()
	end
	UserInputService.InputBegan:Connect(function(k)
		if k.KeyCode == Enum.KeyCode.ButtonY then
			chat.GUI.Enabled = not chat.GUI.Enabled
		end
	end)
	UserInputService.UserCFrameChanged:Connect(function(a,b)
		if a == Enum.UserCFrame.Head then
			chat.CFrame = Camera.CFrame * CFrame.new(0,0,-5) *CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))
		end
	end)
	for i,x in pairs(game.Players:GetChildren()) do
		if x:IsA("Player") then
			x.Chatted:Connect(function(msg)
				MakeChat(BrickColor.random(),msg,x.DisplayName,x.Name)
			end)
		end
	end
	game.Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(msg)
			MakeChat(BrickColor.random(),msg,player.DisplayName,player.Name)
		end)
	end)
end
head.Transparency = 1
if ShowVRLaserCursor == 0 then
	game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
else
	game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 2)
end
game:GetService("StarterGui"):SetCore("VREnableControllerModels", ShowControllerModels)
LeftFoot.Transparency = 1
RightFoot.Transparency = 1
if ConnectedBody == true then
	local A0 = Instance.new("Attachment",leftleg)
	local A1	 = Instance.new("Attachment",rightleg)
	local B0 = Instance.new("Attachment",torso)
	local B1  = Instance.new("Attachment",torso)
	local A2 = Instance.new("Attachment",leftarm)
	local A3 = Instance.new("Attachment",rightarm)
	local B2 = Instance.new("Attachment",torso)
	local B3 = Instance.new("Attachment",torso)
	local BallInSocket0 = Instance.new("BallSocketConstraint",leftleg)
	BallInSocket0.Attachment0 = A0
	BallInSocket0.Attachment1 = B0
	local BallInSocket1 = Instance.new("BallSocketConstraint",rightleg)
	BallInSocket1.Attachment0 = A1
	BallInSocket1.Attachment1 = B1
	local BallInSocket2 = Instance.new("BallSocketConstraint",leftarm)
	BallInSocket2.Attachment0 = A2
	BallInSocket2.Attachment1 = B2
	local BallInSocket3 = Instance.new("BallSocketConstraint",rightleg)
	BallInSocket3.Attachment0 = A3
	BallInSocket3.Attachment1 = B3
	if RagdollEnabled == false then
		A0.CFrame = CFrame.new(0,0,2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		A1.CFrame = CFrame.new(0,0,2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		A2.CFrame = CFrame.new(0,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		A3.CFrame = CFrame.new(0,0,-2)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B0.CFrame = CFrame.new(0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B1.CFrame = CFrame.new(-0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B2.CFrame = CFrame.new(0.5,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B3.CFrame = CFrame.new(-0.5,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	else
		A0.CFrame = CFrame.new(0,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		A1.CFrame = CFrame.new(0,-1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B0.CFrame = CFrame.new(0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		B1.CFrame = CFrame.new(-0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	end
end
while true do
	wait()
	UpdateFooting()
end
