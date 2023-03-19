--ENDER VR 

--this vr script allows you to have a fullbody at any game!!!!

--controls 

--[L2 to run]
--[A to jump]
--[B for laser]



local options = {}

options.leftarmhat = "Pal Hair"
options.rightarmhat = "LavanderHair"
options.leftleghat = "Hat1"
options.rightleghat = "Kate Hair"
options.torsohat = "SeeMonkey"
options.headhat = "Robloxclassicred"

options.Smoothness = 200 --Percentage of smoothness 1% to 200%
options.HeadScale = 1

local righthandrotoffset = Vector3.new(0,180,0)
local lefthandrotoffset = Vector3.new(0,0,0)





local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local camera = workspace.CurrentCamera
local InputService = game:GetService("UserInputService")

camera.HeadScale = options.HeadScale
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,35,0)
			wait(0.5)
		end)
	end
end


local originleft = Instance.new("Part")
originleft.Parent = workspace
originleft.Name = "ORILEFT"
originleft.Anchored = true
originleft.CanCollide = false
originleft.Size = Vector3.new(0.1,0.1,0.1)
originleft.Transparency = 0
originleft.Material = Enum.Material.ForceField

local originright = Instance.new("Part")
originright.Parent = workspace
originright.Name = "ORILEFT"
originright.Anchored = true
originright.CanCollide = false
originright.Size = Vector3.new(0.1,0.1,0.1)
originright.Transparency = 0
originright.Material = Enum.Material.ForceField

local originHead = Instance.new("Part")
originHead.Parent = workspace
originHead.Name = "ORIHEAD"
originHead.Anchored = true
originHead.CanCollide = false
originHead.Size = Vector3.new(0.1,0.1,0.1)
originHead.Transparency = 0
originHead.Material = Enum.Material.ForceField


local leftarm = char:FindFirstChild(options.leftarmhat)
local rightarm = char:FindFirstChild(options.rightarmhat)
local torso = char:FindFirstChild(options.torsohat)
local rightleg = char:FindFirstChild(options.rightleghat)
local leftleg = char:FindFirstChild(options.leftleghat)
local head = char:FindFirstChild(options.headhat)
head.Handle.Transparency = 1
leftarm.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
rightarm.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
--torso.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
--leftleg.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
--rightleg.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()

local leftarmattachment = Instance.new("Attachment")
leftarmattachment.Parent = leftarm.Handle
local rightarmattachment = Instance.new("Attachment")
rightarmattachment.Parent = rightarm.Handle
--local torsoattachment = Instance.new("Attachment")
--torsoattachment.Parent = torso.Handle
--local leftlegattachment = Instance.new("Attachment")
--leftlegattachment.Parent = leftleg.Handle
--local rightlegattachment = Instance.new("Attachment")
--rightlegattachment.Parent = rightleg.Handle
--local torsoattachment = Instance.new("Attachment")
--torsoattachment.Parent = torso.Handle


local HeadAttachment = Instance.new("Attachment")
HeadAttachment.Parent = head.Handle

local originleftattachemnt = Instance.new("Attachment")
originleftattachemnt.Parent = originleft
local originrightattachment = Instance.new("Attachment")
originrightattachment.Parent = originright
local originheadattachment = Instance.new("Attachment")
originheadattachment.Parent = originHead
--local origintorsoattachment = Instance.new("Attachment")
--origintorsoattachment.Parent = originHead

wait(1)


head.Handle:FindFirstChildOfClass("Weld"):Destroy()
rightarm.Handle:FindFirstChildOfClass("Weld"):Destroy()
leftarm.Handle:FindFirstChildOfClass("Weld"):Destroy()
--torso.Handle:FindFirstChildOfClass("Weld"):Destroy()

local Alignorileftarm = Instance.new("AlignOrientation")
Alignorileftarm.Parent = leftarm.Handle
Alignorileftarm.Attachment0 = leftarmattachment
Alignorileftarm.Attachment1 = originleftattachemnt
Alignorileftarm.Responsiveness = options.Smoothness
local Alignposleftarm = Instance.new("AlignPosition")
Alignposleftarm.Parent = leftarm.Handle
Alignposleftarm.Attachment0 = leftarmattachment
Alignposleftarm.Attachment1 = originleftattachemnt
Alignposleftarm.Responsiveness = options.Smoothness

local alignposrightarm = Instance.new("AlignPosition")
alignposrightarm.Parent = rightarm.Handle
alignposrightarm.Attachment0 = rightarmattachment
alignposrightarm.Attachment1 = originrightattachment
alignposrightarm.Responsiveness = options.Smoothness
local alignorirightarm = Instance.new("AlignOrientation")
alignorirightarm.Parent = rightarm.Handle
alignorirightarm.Attachment0 = rightarmattachment
alignorirightarm.Attachment1 = originrightattachment
alignorirightarm.Responsiveness = options.Smoothness

local AlignposHead = Instance.new("AlignPosition")
AlignposHead.Parent = head.Handle
AlignposHead.Attachment0 = HeadAttachment
AlignposHead.Attachment1 = originheadattachment
AlignposHead.Responsiveness = options.Smoothness
local AlignoriHead = Instance.new("AlignOrientation")
AlignoriHead.Parent = head.Handle
AlignoriHead.Attachment0 = HeadAttachment
AlignoriHead.Attachment1 = originheadattachment
Alignorileftarm.Responsiveness = options.Smoothness

--local alignpostorso = Instance.new("AlignPosition")
--alignpostorso.Parent = torso.Handle
--alignpostorso.Attachment0 = torsoattachment
--alignpostorso.Attachment1 = origintorsoattachment
--alignpostorso.Responsiveness = options.Smoothness
--local alignoritorso = Instance.new("AlignOrientation")
--alignoritorso.Parent = torso.Handle
--alignoritorso.Attachment0 = torsoattachment
--alignoritorso.Attachment1 = origintorsoattachment
--alignoritorso.Responsiveness = options.Smoothness
--alignoritorso.PrimaryAxisOnly = true
--alignoritorso.AlignType = "Perpendicular"

local function Track(Type, Value)
	if Type == Enum.UserCFrame.RightHand then
		originright.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,0)
	end
	if Type == Enum.UserCFrame.LeftHand then
		originleft.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,math.pi)
	end
	if Type == Enum.UserCFrame.Head then
		originHead.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value)
	end
end

InputService.UserCFrameChanged:Connect(Track)


local vrmover = Instance.new("Model")
vrmover.Parent = game.Workspace

local humanoidcreate = Instance.new("Humanoid")
humanoidcreate.Parent = vrmover
humanoidcreate.HipHeight = 2
humanoidcreate.WalkSpeed = 8
local humanoidrootpart = Instance.new("Part")
humanoidrootpart.Parent = vrmover
humanoidrootpart.Transparency = 1
humanoidrootpart.CanCollide = false
humanoidrootpart.Size = Vector3.new(1,2,2)
humanoidrootpart.Name = "HumanoidRootPart"
vrmover.PrimaryPart = humanoidrootpart
camera.CameraSubject = humanoidcreate
vrmover.PrimaryPart.CFrame = plr.Character:FindFirstChild("HumanoidRootPart").CFrame
plr.Character = vrmover  

local running = false

InputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR2 then
		running = true
		while running == true do
			wait()
			humanoidcreate.WalkSpeed = 16
			wait(1)
		end




	end
end)
InputService.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR2 then
		running = false
		humanoidcreate.WalkSpeed = 8

	end
end)

local crouching = false

InputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL2 then
		crouching = true
		while crouching == true do
			wait()
			humanoidcreate.HipHeight = 0.7
			wait(1)
		end




	end
end)
InputService.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL2 then
		crouching = false
		humanoidcreate.HipHeight = 2
	end
end)

local chatHUD = game:GetObjects("rbxassetid://11592659660")[1]
local part = chatHUD.MainPart
local GlobalFrame = chatHUD.GlobalFrame
local text = GlobalFrame.Template
local username = GlobalFrame.User



local function OnMessage(Player,Message)
	local TextClone = text:Clone()
	TextClone.Parent = GlobalFrame
	TextClone.Text = Message
end

for i, v in pairs(game.Players:GetChildren()) do
	if v:IsA("Player") then
		v.Chatted:Connect(OnMessage)
	end
end