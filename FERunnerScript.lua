local VirutalBody = true --Makes a Second Character on the Client


-- when you reset make sure to re-execute this or just make this execute in a loop
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart"  then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(30,0,0)
		end)
	end
end
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

--//Varibles\\--
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("UserInputService")
local Sprinting = false
local Falling = false
local Sliding

local function CreateReanimatonLimb(limb)
	local newlimb = Instance.new("Part",workspace)
	newlimb.Size = limb.Size
	newlimb.CanCollide = false
	newlimb.Transparency = 1
	newlimb.Massless = true
	newlimb.Name = (limb.Name.."2")
	return newlimb
end
local function CreateAttachment(Part,CFrameV)
	local attachment = Instance.new("Attachment",Part)
	attachment.Name = Part.Name
	if CFrameV then
		attachment.CFrame = CFrameV
	end
	return attachment
end
local function DoMath(rotx,roty,rotz)
	local cframe = CFrame.Angles(math.rad(rotx),math.rad(roty),math.rad(rotz))
	return cframe
end
local function Align(part0,part1,breakjoints)
	local NewAttachment0 = Instance.new("Attachment",part0)
	local NewAttachment1 = Instance.new("Attachment",part1)
	local AlignPosition = Instance.new("AlignPosition",part0)
	local AlignOrientation = Instance.new("AlignOrientation",part0)
	AlignPosition.Attachment0 = NewAttachment0
	AlignPosition.Attachment1 = NewAttachment1
	AlignPosition.RigidityEnabled = false
	AlignPosition.ReactionForceEnabled = false
	AlignPosition.Responsiveness = math.huge
	AlignPosition.MaxVelocity = math.huge
	-----------------------------------------
	AlignOrientation.Attachment0 = NewAttachment0
	AlignOrientation.Attachment1 = NewAttachment1
	AlignOrientation.RigidityEnabled = false
	AlignOrientation.ReactionTorqueEnabled = false
	AlignOrientation.Responsiveness = math.huge
	AlignOrientation.MaxTorque = math.huge

	if part0:IsA("BasePart") and breakjoints == true then
		part0:BreakJoints()
		part0.Massless = true
	else
		part0:FindFirstChildOfClass("Motor6D"):Destroy()

	end
end
local function Weld(part0,part1,c0)
	local weld = Instance.new("Weld",part0)
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0
	weld.Name = (part0.Name.."2")
	return weld
end
local function CreatePart(size,parent,color,transparency)
	local part = Instance.new("Part",parent)
	part.Size = size
	part.Color = color
	part.Transparency = transparency
	part.CanCollide =false
	part.Material =Enum.Material.Neon
	return part
end

char:FindFirstChildOfClass("Humanoid").WalkSpeed = 70
char:FindFirstChildOfClass("Humanoid").JumpPower = 100
local leftleg 
local rightleg
local leftarm
local rightarm 
local head 
local Torso 
if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
	leftarm = char:FindFirstChild("LeftUpperArm")
	rightarm = char:FindFirstChild("RightUpperArm")
	rightleg = char:FindFirstChild("RightUpperLeg")
	leftleg = char:FindFirstChild("LeftUpperLeg")
	Torso = char:FindFirstChild("UpperTorso")
	head = char:FindFirstChild("Head")
end

if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
	leftleg = char:FindFirstChild("Left Leg")
	rightleg = char:FindFirstChild("Right Leg")
	leftarm = char:FindFirstChild("Left Arm")
	rightarm = char:FindFirstChild("Right Arm")
	head = char:FindFirstChild("Head")
	Torso = char:FindFirstChild("Torso")
end


local VirtLegLeft = CreateReanimatonLimb(leftleg)
local VirtLegRight = CreateReanimatonLimb(rightleg)
local VirtArmLeft = CreateReanimatonLimb(leftarm)
local VirtArmRight = CreateReanimatonLimb(rightarm)

local LeftLegWeld = Weld(VirtLegLeft,Torso,CFrame.new(0.5,2,0)*DoMath(0,0,0))
local RightLegWeld = Weld(VirtLegRight,Torso,CFrame.new(-0.5,2,0)*DoMath(0,0,0))
local LeftArmWeld = Weld(VirtArmLeft,Torso,CFrame.new(1.5,0,0)*DoMath(0,0,0))
local RightArmWeld = Weld(VirtArmRight,Torso,CFrame.new(-1.5,0,0)*DoMath(0,0,0))

local LeftBraclet = CreatePart(Vector3.new(0.1,1.1,1.1),VirtArmLeft,Color3.new(1, 0.666667, 0),0)
local RightBraclet =  CreatePart(Vector3.new(0.1,1.1,1.1),VirtArmRight,Color3.new(1, 0.666667, 0),0)
local BracletWeld0 = Weld(LeftBraclet,VirtArmLeft,CFrame.new(0.6,0,0)*DoMath(-90,180,90))
local BracletWeld1 = Weld(RightBraclet,VirtArmRight,CFrame.new(0.6,0,0)*DoMath(-90,180,90))
local TrailAtt0 = CreateAttachment(LeftBraclet,CFrame.new(0,-0.5,0)*DoMath(0,0,0))
local TrailAtt1 = CreateAttachment(LeftBraclet,CFrame.new(0,0.5,0)*DoMath(0,0,0))

local TrailAtt2 = CreateAttachment(RightBraclet,CFrame.new(0,-0.5,0)*DoMath(0,0,0))
local TrailAtt3 = CreateAttachment(RightBraclet,CFrame.new(0,0.5,0)*DoMath(0,0,0))
local Trail1 = Instance.new("Trail",LeftBraclet)
Trail1.Attachment0 = TrailAtt0
Trail1.Attachment1 = TrailAtt1
Trail1.Transparency = NumberSequence.new(0.2)
Trail1.Color = ColorSequence.new(Color3.new(1, 0.666667, 0))
Trail1.Lifetime = 0.1

local Trail2 = Instance.new("Trail",RightBraclet)
Trail2.Attachment0 = TrailAtt2
Trail2.Attachment1 = TrailAtt3
Trail2.Transparency = NumberSequence.new(0.2)
Trail2.Color = ColorSequence.new(Color3.new(1, 0.666667, 0))
Trail2.Lifetime = 0.1

if VirutalBody == true then

	local rig = game:GetObjects("rbxassetid://8318476657")[1]
	rig.Parent = workspace
	rig.HumanoidRootPart:Destroy()
	rig.Name = plr.Name
	local function CloneHats(hat)
		local clone = hat:Clone()
		clone.Parent = rig
	end
	local leftrigleg = rig:FindFirstChild("Left Leg")
	local RightRigLeg = rig:FindFirstChild("Right Leg")
	local LeftRigArm =rig:FindFirstChild("Left Arm")
	local RightRigArm = rig:FindFirstChild("Right Arm")
	local bodycolors = char:FindFirstChildOfClass("BodyColors"):Clone()
	local pants = char:FindFirstChildOfClass("Pants"):Clone()
	local Shirt = char:FindFirstChildOfClass("Shirt"):Clone()	
	for i,x in pairs(char:GetChildren()) do
		if x:IsA("Accessory") then
			CloneHats(x)
		end
	end
	bodycolors.Parent = rig
	pants.Parent = rig
	Shirt.Parent = rig
	LeftRigArm:BreakJoints()
	RightRigArm:BreakJoints()
	leftrigleg:BreakJoints()
	RightRigLeg:BreakJoints()
	Weld(leftrigleg,VirtLegLeft,CFrame.new(0,0,0)*DoMath(0,0,0))
	Weld(RightRigLeg,VirtLegRight,CFrame.new(0,0,0)*DoMath(0,0,0))
	Weld(LeftRigArm,VirtArmLeft,CFrame.new(0,0,0)*DoMath(0,0,0))
	Weld(RightRigArm,VirtArmRight,CFrame.new(0,0,0)*DoMath(0,0,0))
	Weld(rig:FindFirstChild("Torso"),Torso,CFrame.new(0,0,0)*DoMath(0,0,0))
	for i,x in pairs(char:GetChildren()) do
		if x:IsA("BasePart") then
			x.Transparency = 1
		end
		if x:IsA("Accessory") then
			x.Handle.Transparency = 1
		end
	end


end



UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.W then
		Sprinting = true
		while Sprinting == true do

			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-40,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(40,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-35,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(35,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-30,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(30,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-25,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(25,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-20,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(20,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-15,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(15,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-10,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(10,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,-0.3)*DoMath(-5,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0.3)*DoMath(5,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(0,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(0,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.2,-0.7)*DoMath(89,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.2,-0.7)*DoMath(89,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-40,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(40,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-35,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(35,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-30,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(30,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-25,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(25,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-20,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(20,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-15,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(15,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-10,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(10,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
			wait(0.00000001)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,-0.3)*DoMath(-5,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0.3)*DoMath(5,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(90,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(90,0,0)
		end
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.W then		
		Sprinting = false
		wait(.5)

		LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(0,0,0)
		RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(0,0,0)
		LeftArmWeld.C0 = CFrame.new(1.5,0,0)*DoMath(0,0,0)
		RightArmWeld.C0 = CFrame.new(-1.5,0,0)*DoMath(0,0,0)

	end
end)
UserInputService.InputBegan:Connect(function(code)
	if code.KeyCode == Enum.KeyCode.Q then
		Sliding = true
		Sprinting = false
		while Sliding == true do
			wait(0.6)
			LeftLegWeld.C0 = CFrame.new(0.5,2,1)*DoMath(40,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,-0.5)*DoMath(-40,0,0)
			LeftArmWeld.C0 = CFrame.new(1.5,1.3,-0.7)*DoMath(0,0,0)
			RightArmWeld.C0 = CFrame.new(-1.5,1.3,-0.7)*DoMath(0,0,0)
			local number = 0
			local BodyVelocity = Instance.new("BodyVelocity",char:FindFirstChild("HumanoidRootPart"))
			BodyVelocity.MaxForce = Vector3.new(3000,3000,3000)
			BodyVelocity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 100
			number = number + 1
			if number < 10 then
				BodyVelocity:Destroy()
				number = 0
				Sliding = false
				for i,x in pairs(char:FindFirstChild("HumanoidRootPart"):GetChildren()) do
					if x:IsA("BodyVelocity") then
						x:Destroy()
					end
				end
			end
		end
	end
end)
if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
	Align(leftleg,VirtLegLeft,false)
	Align(rightleg,VirtLegRight,false)
	Align(leftarm,VirtArmLeft,false)
	Align(rightarm,VirtArmRight,false)

end
if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
	Align(leftleg,VirtLegLeft,true)
	Align(rightleg,VirtLegRight,true)
	Align(leftarm,VirtArmLeft,true)
	Align(rightarm,VirtArmRight,true)
end




local LeftBraclet2 = CreatePart(Vector3.new(0.1,1.1,1.1),VirtLegLeft,Color3.new(1, 0.666667, 0),0)
local RightBraclet2 =  CreatePart(Vector3.new(0.1,1.1,1.1),VirtLegRight,Color3.new(1, 0.666667, 0),0)
local BracletWeld02 = Weld(LeftBraclet2,VirtLegLeft,CFrame.new(0.6,0,0)*DoMath(-90,180,90))
local BracletWeld12 = Weld(RightBraclet2,VirtLegRight,CFrame.new(0.6,0,0)*DoMath(-90,180,90))
local TrailAtt02= CreateAttachment(LeftBraclet2,CFrame.new(0,-0.5,0)*DoMath(0,0,0))
local TrailAtt12 = CreateAttachment(LeftBraclet2,CFrame.new(0,0.5,0)*DoMath(0,0,0))

local TrailAtt22 = CreateAttachment(RightBraclet,CFrame.new(0,-0.5,0)*DoMath(0,0,0))
local TrailAtt32 = CreateAttachment(RightBraclet,CFrame.new(0,0.5,0)*DoMath(0,0,0))
local Trail12 = Instance.new("Trail",LeftBraclet2)
Trail12.Attachment0 = TrailAtt02
Trail12.Attachment1 = TrailAtt12
Trail12.Transparency = NumberSequence.new(0.2)
Trail12.Color = ColorSequence.new(Color3.new(1, 0.666667, 0))
Trail12.Lifetime = 0.1

local Trail22 = Instance.new("Trail",RightBraclet2)
Trail22.Attachment0 = TrailAtt22
Trail22.Attachment1 = TrailAtt32
Trail22.Transparency = NumberSequence.new(0.2)
Trail22.Color = ColorSequence.new(Color3.new(1, 0.666667, 0))
Trail22.Lifetime = 0.1
x = 0
while true do
	RightBraclet.Color = Color3.fromHSV(x,1,1)
	LeftBraclet.Color = Color3.fromHSV(x,1,1)
	LeftBraclet2.Color = Color3.fromHSV(x,1,1)
	RightBraclet2.Color = Color3.fromHSV(x,1,1)
	Trail1.Color = ColorSequence.new(Color3.fromHSV(x,1,1))
	Trail2.Color = ColorSequence.new(Color3.fromHSV(x,1,1))
	Trail12.Color = ColorSequence.new(Color3.fromHSV(x,1,1))
	Trail22.Color = ColorSequence.new(Color3.fromHSV(x,1,1))
	x = x + 1/255
	if x >= 1 then
		x = 0
	end
	wait()
end
