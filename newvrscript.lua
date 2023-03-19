
-- when you reset make sure to re-execute this or just make this execute in a loop
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,30,0)
		end)
	end
end


game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Notification";
	Text = "Netless Ran";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 16;


local sword = "LavanderHair"
local rightarm = "Pal Hair"
local Head = "Speakat"
local Torso = "SeeMonkey"
local SwordToolEnabled = true
local BossFightMode = false --makes your vr body look like a final boss requires 3 more hats
local Fling = false
local Extrahats = false
local PropHat = "FlopShoulderAccessory"


local InputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local Rig = game:GetObjects("rbxassetid://8318476657")[1]
Rig.Parent =  char
Rig["Left Leg"]:Destroy()
Rig["Left Arm"]:Destroy()
Rig["Right Arm"]:Destroy()
Rig["Right Leg"]:Destroy()
Rig.HumanoidRootPart:Destroy()
local TorsoHead = Rig["Head"]
TorsoHead.Anchored = true
Camera.CameraType = "Scriptable"
Camera.HeadScale = 5
local HatSword = char:FindFirstChild(sword)
local Hatrightarm = char:FindFirstChild(rightarm)
local HatHead = char:FindFirstChild(Head)
local HatTorso = char:FindFirstChild(Torso)
HatTorso.Handle:BreakJoints()
HatTorso.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
HatHead.Handle:BreakJoints()
HatHead.Handle.Transparency = 1
HatSword.Handle:BreakJoints()
Hatrightarm.Handle:BreakJoints()
Hatrightarm.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
HatSword.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
local Outline1 = Instance.new("SelectionBox")
Outline1.Parent = Hatrightarm.Handle
Outline1.Adornee = Hatrightarm.Handle
local outline2 = Instance.new("SelectionBox")
outline2.Parent = HatSword.Handle
outline2.Adornee = HatSword.Handle
local righthandrotoffset = Vector3.new(-180,0,0)
local HeadPosition = nil
local function Track(Type, Value)
	if Type == Enum.UserCFrame.RightHand then
		HatSword.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,0)
	end
	if Type == Enum.UserCFrame.LeftHand then
		Hatrightarm.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,math.pi)
	end
	if Type == Enum.UserCFrame.Head then
		HatHead.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value)
		TorsoHead.CFrame = HatHead.Handle.CFrame
	end
end

InputService.UserCFrameChanged:Connect(Track)
local attachmentorso = Instance.new("Attachment")
attachmentorso.Parent = HatTorso.Handle
attachmentorso.Orientation = Vector3.new(90,0,0)
local atttorsoorigin = Instance.new("Attachment")
atttorsoorigin.Parent = Rig.Torso
local alignpostorso = Instance.new("AlignPosition")
alignpostorso.Parent = HatTorso.Handle
alignpostorso.Attachment0 = attachmentorso
alignpostorso.Attachment1 = atttorsoorigin
alignpostorso.Responsiveness = 200
local alignoritorso = Instance.new("AlignOrientation")
alignoritorso.Parent = HatTorso.Handle
alignoritorso.Attachment0 = attachmentorso
alignoritorso.Attachment1 = atttorsoorigin
alignoritorso.Responsiveness = 200
if Fling == true then
	local root = char:FindFirstChild("Right Leg")
	root:BreakJoints()
	root.Anchored = false
	local rootattachment = Instance.new("Attachment")
	rootattachment.Parent = root
	local swordatt = Instance.new("Attachment")
	swordatt.Parent = HatSword.Handle
	local alignpos = Instance.new("AlignPosition")
	alignpos.Parent = root
	alignpos.Attachment0 = rootattachment
	alignpos.Attachment1 = char:FindFirstChild(PropHat).Handle:FindFirstChildOfClass("Attachment")
	alignpos.Responsiveness = 200
	local selectionbox = Instance.new("SelectionBox")
	selectionbox.Parent = root
	selectionbox.Adornee = root
	selectionbox.Color3 = Color3.new(1, 0, 0)
	selectionbox.LineThickness = 0.01

	local spinniny = Instance.new("BodyThrust")
	spinniny.Parent = root
	spinniny.Force = Vector3.new(1000,1000,9999)
	spinniny.Location = root.Position
	root.Transparency = 1
	root.CanCollide = true
end

local torsooutline = Instance.new("SelectionBox")
torsooutline.Parent = Rig:FindFirstChild("Torso")
torsooutline.Adornee = Rig:FindFirstChild("Torso")
torsooutline.LineThickness = 0.01
local R1down = false
InputService.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL1 then
		if key.Position.Z > 0.9 then
			R1down = true
		else
			R1down = false
		end
	end
end)

InputService.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL1 then
		R1down = true
	end
end)

InputService.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL1 then
		R1down = false
	end
end)


game:GetService("RunService").RenderStepped:connect(function()
	if R1down then
		Camera.CFrame = Camera.CFrame:Lerp(Camera.CoordinateFrame + (Hatrightarm.Handle.CFrame*CFrame.Angles(-math.rad(righthandrotoffset.X),-math.rad(righthandrotoffset.Y),math.rad(180-righthandrotoffset.X))).LookVector * Camera.HeadScale/2, 0.5)
	end
end)

local trailattleft = Instance.new("Attachment")
trailattleft.Parent = HatSword.Handle
local trail = Instance.new("Trail")
trail.Parent =  HatSword.Handle
trail.Attachment0 = trailattleft
trail.Attachment1 = HatSword.Handle:FindFirstChild("HairAttachment")
trail.Lifetime = 0.6
trail.Texture = "http://www.roblox.com/asset/?id=5699911427"
local trailattright = Instance.new("Attachment")
trailattright.Parent = Hatrightarm.Handle
local trail2 = Instance.new("Trail")
trail2.Parent = Hatrightarm.Handle
trail2.Attachment0 = trailattright
trail2.Attachment1 = Hatrightarm.Handle:FindFirstChild("HairAttachment")
trail2.Lifetime = 0.6
trail2.Texture = "http://www.roblox.com/asset/?id=5699911427"

Rig.Torso.Transparency = 1
char.HumanoidRootPart.Anchored = true
if SwordToolEnabled == true then
	local sword = char:FindFirstChild(PropHat)
	local Handle = sword.Handle

	local swordatt = Handle:FindFirstChildOfClass("Attachment")
	local SwordOrigin = Hatrightarm.Handle.HairAttachment
	SwordOrigin.Orientation = Handle:FindFirstChildOfClass("Attachment").Orientation
	local alignpossw = Instance.new("AlignPosition")
	alignpossw.Parent = Handle
	alignpossw.Attachment0 = swordatt
	alignpossw.Attachment1 = SwordOrigin
	alignpossw.Responsiveness = 200
	local alignorisw = Instance.new("AlignOrientation")
	alignorisw.Parent = Handle
	alignorisw.Attachment0 = swordatt
	alignorisw.Attachment1 = SwordOrigin
	alignorisw.Responsiveness = 200
	--alignpos.Attachment0 = SwordOrigin

	Handle:BreakJoints()
	local attachmenttrail  = Instance.new("Attachment")
	attachmenttrail.Parent = Handle
	local swordtrail = Instance.new("Trail")
	swordtrail.Parent = Handle
	swordtrail.Attachment0 = attachmenttrail
	swordtrail.Attachment1 = Handle:FindFirstChildOfClass("Attachment")
	swordtrail.Color = ColorSequence.new(BrickColor.new('Really red').Color)
	swordtrail.Texture = "http://www.roblox.com/asset/?id=4480871448"
	swordtrail.Lifetime = 0.1
end
char.Humanoid.CameraOffset = Vector3.new(0,-5,0)
