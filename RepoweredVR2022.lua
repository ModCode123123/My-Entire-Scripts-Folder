
--[[
 ______     ______     ______   ______     __     __     ______     ______     ______     _____       
/\  == \   /\  ___\   /\  == \ /\  __ \   /\ \  _ \ \   /\  ___\   /\  == \   /\  ___\   /\  __-.     
\ \  __<   \ \  __\   \ \  _-/ \ \ \/\ \  \ \ \/ ".\ \  \ \  __\   \ \  __<   \ \  __\   \ \ \/\ \    
 \ \_\ \_\  \ \_____\  \ \_\    \ \_____\  \ \__/".~\_\  \ \_____\  \ \_\ \_\  \ \_____\  \ \____-    
  \/_/ /_/   \/_____/   \/_/     \/_____/   \/_/   \/_/   \/_____/   \/_/ /_/   \/_____/   \/____/    
                                                                                                      
 __   __   ______                                                                                     
/\ \ / /  /\  == \                                                                                    
\ \ \'/   \ \  __<                                                                                    
 \ \__|    \ \_\ \_\                                                                                  
  \/_/      \/_/ /_/                                                                                  
                            
                            
THE RIFT S IS BETTER THAN THE QUEST 2
CANT WAIT TO GET A NEW RIFT S!!!!
     
     
     
     
     
----------[Controls]--------------   

Right Grab/R1 to Fly Forwards

B/ButtonB to grab the Prop in the settings below
     
     
                            ]]


local setting = {}


setting.ArmTransparency = 0.4
setting.LeftHand = "Left Arm"
setting.RightHand = "Right Arm"
setting.Head = "Head"
setting.Prop = "Meshes/1911RightAccessory"
setting.PropType = "Gun" --Gun Or   Misc
setting.HeadScale = 3
setting.NetlessVelo = Vector3.new(0,30,-25.42)
setting.NetlessOption = 1 --1 = Reset if Limb Falls --2 Normal Netless V3	
setting.WearFaceHat = false
setting.FaceHat = "Speakat"
setting.Reanimate = false



-- when you reset make sure to re-execute this or just make this execute in a loop
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,70.412,35.131)
		end)
	end
end



local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

local Camera = workspace.CurrentCamera
local leftarm = char:FindFirstChild(setting.LeftHand)
local rightarm = char:FindFirstChild(setting.RightHand)
local head = char:FindFirstChild(setting.Head)
local Prop = char:FindFirstChild(setting.Prop)

local ori1 = Instance.new("Part")
ori1.Parent = workspace
ori1.CanCollide = false
ori1.Size = Vector3.new(1,1,2)
ori1.Anchored = true
ori1.Transparency = 1
local ori2 = Instance.new("Part")
ori2.Parent = workspace
ori2.CanCollide = false
ori2.Size = Vector3.new(1,1,2)
ori2.Anchored = true
ori2.Transparency = 1
local ori3 = Instance.new("Part")
ori3.Parent = workspace
ori3.Anchored = true
ori3.Transparency = 1
ori3.Size = Vector3.new(1,1,1)
ori3.CanCollide = false

local o1att = Instance.new("Attachment")
o1att.Parent = ori1
local o2att = Instance.new("Attachment")
o2att.Parent = ori2
local o3att = Instance.new("Attachment")
o3att.Parent = ori3
local function RemoveVRCore()
	pcall(function()
		Camera:WaitForChild("VRCorePanelParts", 3):WaitForChild("BottomBar_Part", 3):Destroy()
	end)
end

local function Align(Part01,Part02,Part03)


	local AlignAttachment = Instance.new("Attachment")
	AlignAttachment.Parent = Part01
	local AlignAttachment2 = Instance.new("Attachment")
	AlignAttachment2.Parent = Part02
	local AlignAttachment3 = Instance.new("Attachment")
	AlignAttachment3.Parent = Part03

	local Alignpos1 = Instance.new("AlignPosition")
	Alignpos1.Parent = Part01
	Alignpos1.Attachment0 = AlignAttachment
	Alignpos1.Attachment1 = o1att
	Alignpos1.Responsiveness = 9e9
	Alignpos1.RigidityEnabled = true
	Alignpos1.ReactionForceEnabled = true
	local Alignori1 = Instance.new("AlignOrientation")
	Alignori1.Parent = Part01
	Alignori1.Attachment0 = AlignAttachment
	Alignori1.Attachment1 = o1att
	Alignori1.Responsiveness = 9e9 
	Alignori1.RigidityEnabled = true
	Alignori1.ReactionTorqueEnabled = true
	local Alignpos2 = Instance.new("AlignPosition")
	Alignpos2.Parent = Part02
	Alignpos2.Attachment0 = AlignAttachment2
	Alignpos2.Attachment1 = o2att
	Alignpos2.Responsiveness = 9e9
	Alignpos2.ReactionForceEnabled = true
	Alignpos2.RigidityEnabled = true
	local Alignori2 = Instance.new("AlignOrientation")
	Alignori2.Parent = Part02
	Alignori2.Attachment0 = AlignAttachment2
	Alignori2.Attachment1 = o2att
	Alignori2.Responsiveness = 9e9
	Alignori2.ReactionTorqueEnabled = true
	Alignori2.RigidityEnabled = true
	local Alignpos3 = Instance.new("AlignPosition")
	Alignpos3.Parent = Part03
	Alignpos3.Attachment0 = AlignAttachment3
	Alignpos3.Attachment1 = o3att
	Alignpos3.Responsiveness = 9e9
	Alignpos3.ReactionForceEnabled = true
	Alignpos3.RigidityEnabled = true
	local Alignori3 = Instance.new("AlignOrientation")
	Alignori3.Parent = Part03
	Alignori3.Attachment0 = AlignAttachment3
	Alignori3.Attachment1 = o3att
	Alignori3.Responsiveness = 9e9
	Alignori3.ReactionTorqueEnabled = true
	Alignori3.RigidityEnabled = true
	AlignAttachment.Orientation = Vector3.new(90,0,0)
	AlignAttachment2.Orientation = Vector3.new(90,0,-180)

end
Align(leftarm,rightarm,head)
wait()
Camera.HeadScale = setting.HeadScale
Camera.CameraType = "Scriptable"
char.HumanoidRootPart.CFrame = Camera.CFrame
char.HumanoidRootPart.Anchored = true
 
local function Reanimation()
	--Character
	local player = game.Players.LocalPlayer
	local character = player.Character

	--Fake Character
	local model = Instance.new("Model",character)
	model.Name = "Fake Character"
	local torsoreanimate = Instance.new("Part",model)
	torsoreanimate.Name = "Torso"
	torsoreanimate.Position = character.HumanoidRootPart.Position
	local headreanimate = Instance.new("Part",model)
	headreanimate.Name = "Head"
	headreanimate.Position = character.HumanoidRootPart.Position
	local hum = Instance.new("Humanoid",model)

	--Bypass
	player.Character = model
	wait(3)
	player.Character = character
	wait(3)

	player.Character.Humanoid.Health = 0
end

if game:GetService("VRService").VREnabled == true then


else
	plr:Kick("You Need To Use VR For This Script!")
end
local InputServ = game:GetService("UserInputService")
local R1down = false
local righthandrotoffset = Vector3.new(-180,0,0)
InputServ.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		if key.Position.Z > 0.9 then
			R1down = true
		else
			R1down = false
		end
	end
end)

InputServ.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = true
	end
end)

InputServ.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = false
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if R1down then
		Camera.CFrame = Camera.CFrame:Lerp(Camera.CoordinateFrame + (ori2.CFrame*CFrame.Angles(-math.rad(righthandrotoffset.X),-math.rad(righthandrotoffset.Y),math.rad(180-righthandrotoffset.X))).LookVector * Camera.HeadScale/2, 0.5)
	end
end)
if setting.WearFaceHat == true then
	local FaceHat = char:FindFirstChild(setting.FaceHat)
	FaceHat.Handle:BreakJoints()
	FaceHat.Handle.Transparency = 1
	local atthat = Instance.new("Attachment")
	atthat.Parent = FaceHat.Handle
	atthat.CFrame = CFrame.new(0,0,0.6) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	local alignhat = Instance.new("AlignPosition")
	alignhat.Parent = FaceHat.Handle
	alignhat.Attachment0 = atthat
	alignhat.Attachment1 	= o3att
	alignhat.Responsiveness = 9e9
	alignhat.RigidityEnabled = true
	alignhat.ReactionForceEnabled = true
	local Alignhat2 = Instance.new("AlignOrientation")
	Alignhat2.Parent = FaceHat.Handle
	Alignhat2.Attachment0 = atthat
	Alignhat2.Attachment1 = o3att
	Alignhat2.Responsiveness = 9e9
	Alignhat2.RigidityEnabled = true
	Alignhat2.ReactionTorqueEnabled = true
end



-----------------Prop-------------------

---------------------------------------
head.Anchored = false
local Equiped = false
local Handle = Prop.Handle
local PropAttachment = Instance.new("Attachment")
PropAttachment.Parent = Handle
local OriginAttachment = Instance.new("Attachment")
OriginAttachment.Parent = ori2
local UnequipAttachment = Instance.new("Attachment")
UnequipAttachment.Parent = ori2
UnequipAttachment.CFrame = CFrame.new(0,-50,-0.1) *CFrame.Angles(math.rad(-270),math.rad(0),math.rad(0))
local Alignpos = Instance.new("AlignPosition")
Alignpos.Parent = Handle
Alignpos.Attachment0 = PropAttachment
Alignpos.Attachment1 = UnequipAttachment
Alignpos.Responsiveness = 9e9
local Alignori = Instance.new("AlignOrientation")
Alignori.Parent = Handle
Alignori.Attachment0 = PropAttachment
Alignori.Attachment1 = UnequipAttachment
Alignori.Responsiveness = 9e9
if setting.PropType == "Gun" then
	PropAttachment.CFrame = CFrame.new(0,1.5,-0.4) *CFrame.Angles(math.rad(-270),math.rad(0),math.rad(0))
end
if setting.PropType == "Misc" then
	PropAttachment.CFrame = CFrame.new(0,1.5,-0.4) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
end
Handle:BreakJoints()
char["Left Arm"].Transparency = setting.ArmTransparency
char["Right Arm"].Transparency = setting.ArmTransparency
char["Head"].Transparency = 1


InputServ.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonB then
		Equiped = not Equiped

		while Equiped == true do
			wait()
			Alignpos.Attachment1 = OriginAttachment
			Alignori.Attachment1 = OriginAttachment
		end
		while Equiped == false do
			wait()
			Alignpos.Attachment1 = UnequipAttachment
			Alignori.Attachment1 = UnequipAttachment

		end
	end
end)






local function Track(Type, Value)
	if Type == Enum.UserCFrame.RightHand then
		ori2.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,0)
	end
	if Type == Enum.UserCFrame.LeftHand then
		ori1.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,math.pi)
	end
	if Type == Enum.UserCFrame.Head then
		ori3.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value)
	end
end

InputServ.UserCFrameChanged:Connect(Track)

RemoveVRCore()
if setting.Reanimate == true then
	Reanimation()

end
if setting.Reanimate == false then
	char["Left Arm"]:BreakJoints()
	char["Right Arm"]:BreakJoints()
	Prop.Handle:BreakJoints()
	char["Left Leg"]:Destroy()
	char["Right Leg"]:Destroy()
	char["HumanoidRootPart"]:Destroy()
	char[setting.FaceHat].Handle:BreakJoints()
	char["Torso"].Anchored = false
	char["Head"].Anchored = false
for i,v in pairs(char:GetChildren()) do
		if v:IsA("Tool") then
			v:Destroy()
		end
	end
	
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.Anchored = false
		end
	end
end



