
--[[NetlessV3]]
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(45,0,0)
		end)
	end
end

local FECannonModel = false

--[[Varibles]]--

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
char:FindFirstChildOfClass("Humanoid").WalkSpeed = 12 
local rn = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local leftleg 
local rightleg
local leftarm
local rightarm 
local head 
local Torso 
local CannonModel
local Idle = false
local Moving = false
local Firing = false
local mouse = plr:GetMouse()
--[[NetlessV3]]

--[[Local Functions]]--
local function CreateVFXPart(size,color3,tranparency,shape,fadevfx,position,timeuntilfade)
	local part = Instance.new("Part",workspace)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = tranparency
	part.Size = size
	part.Color = color3
	part.Shape = shape
	part.CFrame = char:FindFirstChild("Torso").CFrame
	part.Material = Enum.Material.Neon
	part.CanTouch = false
	part.CanQuery = false
	if position then
		part.Position =  position
	end
	if fadevfx and timeuntilfade then
		wait(timeuntilfade)
		while fadevfx == true do

			wait()
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait()
			part:Destroy()
			fadevfx = false
		end
	else
		while fadevfx == true do

			wait()
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.0001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait(0.001)
			part.Transparency = part.Transparency + 0.1
			wait()
			part:Destroy()
			fadevfx = false
		end
	end
	return part
end
local function DoMath(rotx,roty,rotz)
	local cframe = CFrame.Angles(math.rad(rotx),math.rad(roty),math.rad(rotz))
	return cframe
end
local function Align(part0,part1,breakjoints,cframe)
	local NewAttachment0 = Instance.new("Attachment",part0)
	local NewAttachment1 = Instance.new("Attachment",part1)
	local AlignPosition = Instance.new("AlignPosition",part0)
	local AlignOrientation = Instance.new("AlignOrientation",part0)
	AlignPosition.Attachment0 = NewAttachment0
	AlignPosition.Attachment1 = NewAttachment1
	AlignPosition.RigidityEnabled = false
	AlignPosition.ReactionForceEnabled = false
	AlignPosition.Responsiveness = 9e9
	-----------------------------------------
	AlignOrientation.Attachment0 = NewAttachment0
	AlignOrientation.Attachment1 = NewAttachment1
	AlignOrientation.RigidityEnabled = false
	AlignOrientation.ReactionTorqueEnabled = false
	AlignOrientation.Responsiveness = 9e9

	if part0:IsA("BasePart") and breakjoints == true then
		part0:BreakJoints()
	end
	if cframe then
		NewAttachment0.CFrame =cframe
	end
	return AlignPosition 
end
local function Weld(part0,part1,c0)
	local weld = Instance.new("Weld",part0)
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0
	weld.Name = (part0.Name.."2")
	return weld
end
local FlingLimb
--Aligning Character
if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
	leftarm = char:FindFirstChild("LeftUpperArm")
	rightarm = char:FindFirstChild("RightUpperArm")
	rightleg = char:FindFirstChild("RightUpperLeg")
	leftleg = char:FindFirstChild("LeftUpperLeg")
	Torso = char:FindFirstChild("UpperTorso")
	head = char:FindFirstChild("Head")
	FlingLimb = rightleg
end

if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
	leftleg = char:FindFirstChild("Left Leg")
	rightleg = char:FindFirstChild("Right Leg")
	leftarm = char:FindFirstChild("Left Arm")
	rightarm = char:FindFirstChild("Right Arm")
	head = char:FindFirstChild("Head")
	Torso = char:FindFirstChild("Torso")
	FlingLimb= rightleg
end
local FlingAlign
local function CreateReanimatonLimb(limb)
	local newlimb = Instance.new("Part",workspace)
	newlimb.Size = limb.Size
	newlimb.CanCollide = false
	newlimb.Transparency = 1
	newlimb.Massless = true
	newlimb.Name = (limb.Name.."2")
	return newlimb
end
local function CreateSound(id,vol)
	local sound = Instance.new("Sound",char.Torso)
	sound.SoundId = id
	sound.Volume = vol
	sound:Play()
	sound.Played:Connect(function()
		sound:Destroy()
	end)
end


local VirtLegLeft = CreateReanimatonLimb(leftleg)
local VirtLegRight = CreateReanimatonLimb(rightleg)
local VirtArmLeft = CreateReanimatonLimb(leftarm)
local VirtArmRight = CreateReanimatonLimb(rightarm)

local LeftLegWeld = Weld(VirtLegLeft,Torso,CFrame.new(0.5,2,0)*DoMath(0,0,0))
local RightLegWeld = Weld(VirtLegRight,Torso,CFrame.new(-0.5,2,0)*DoMath(0,0,0))
local LeftArmWeld = Weld(VirtArmLeft,Torso,CFrame.new(1.5,0.6,0.2)*DoMath(-180,0,0))
local RightArmWeld = Weld(VirtArmRight,Torso,CFrame.new(-1.5,-0.6,0)*DoMath(0,30,30))

if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
	Align(leftleg,VirtLegLeft,false)
	FlingAlign =  Align(rightleg,VirtLegRight,false)
	Align(leftarm,VirtArmLeft,false)
	Align(rightarm,VirtArmRight,false)

end
if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
	Align(leftleg,VirtLegLeft,true)
	FlingAlign=	Align(rightleg,VirtLegRight,true)
	Align(leftarm,VirtArmLeft,true)
	Align(rightarm,VirtArmRight,true)
end

CannonModel = game:GetObjects("rbxassetid://12162843995")[1]
CannonModel.Parent = workspace

local Grip = CannonModel:FindFirstChild("Grip")
local gripweld = Weld(Grip,VirtArmLeft,CFrame.new(0,-0.6,1.2)*DoMath(90,0,0))
local ReturnAttachment = Instance.new("Attachment",VirtLegRight)

mouse.Button1Down:Connect(function()
	Firing = true

	--LeftArmWeld.C0 = CFrame.lookAt(char.HumanoidRootPart.Position,mouse.Hit.p) 
	LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-90,0,0)
	gripweld.C0 = CFrame.new(0,0,1)*DoMath(90,0,0) 
	while Firing == true do
		local beam = Instance.new("Beam",Grip)
		local beamatt1 = Instance.new("Attachment",Grip)
		beam.Attachment0 = beamatt1
		--beam.Segments = 200
		beam.Color = ColorSequence.new(Color3.new(0, 0.666667, 1))
		local part = Instance.new("Part",workspace)
		part.Size = Vector3.new(1,1,1)
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Transparency = 1
		part.Position = mouse.Hit.Position
		local beamatt2 = Instance.new("Attachment",part)
		beam.Attachment1 = beamatt2
		FlingAlign.Attachment1 = beamatt2
		local vfx = CreateVFXPart(Vector3.new(5,5,5),Color3.new(0, 0.666667, 1),0.2,Enum.PartType.Ball,true,part.Position)
		local vfx = CreateVFXPart(Vector3.new(5,5,5),Color3.new(1,1, 1),0.2,Enum.PartType.Ball,true,part.Position)

		LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-130,0,0)--341301373
		wait(0.01)
		LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-120,0,0)
		wait(0.01)
		LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-110,0,0)
		wait(0.01)
		LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-100,0,0)
		wait(0.01)
		LeftArmWeld.C0 = CFrame.new(1.2,1,0.2)*DoMath(-90,0,0)
		CreateSound("rbxassetid://341301373",3)



		beam:Destroy()
		part:Destroy()
		beamatt1:Destroy()
		FlingAlign.Attachment1 = ReturnAttachment
		
	end
end)
mouse.Button1Up:Connect(function()

	Firing = false


	wait(0.9)

	char.HumanoidRootPart.Anchored = false
	while Firing == false do
		wait()
		gripweld.C0 = CFrame.new(0,-0.6,1.2)*DoMath(90,0,0)
		LeftArmWeld.C0 = CFrame.new(1.5,0.6,0.2)*DoMath(-180,0,0)
	end

end)
UserInputService.InputBegan:Connect(function(k)
	if k.KeyCode == Enum.KeyCode.W then
		Moving = true
		while Moving == true do
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(20,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(-20,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(15,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(-15,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(10,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(-10,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(5,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(-5,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(0,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(0,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-5,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(5,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-10,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(10,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-15,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(15,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-20,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(20,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-15,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(15,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-10,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(10,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(-5,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(5,0,0)
			wait(0.1)
			LeftLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(0,0,0)
			RightLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(0,0,0)
		end
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode==Enum.KeyCode.W then
		Moving = false
		while Moving == false do
			wait(0.01)
			LeftLegWeld.C0 = CFrame.new(-0.5,2,0)*DoMath(0,0,0)
			RightLegWeld.C0 = CFrame.new(0.5,2,0)*DoMath(0,0,0)
		end
	end
end)
local FEHat = char:FindFirstChild("Pal Hair")
local FEHat2 = char:FindFirstChild("International Fedora")
local FEHat3 = char:FindFirstChild("InternationalFedora")
Align(FEHat.Handle,Grip,true)
Align(FEHat2.Handle,Grip,true,CFrame.new(0,0,3)*DoMath(0,0,0))
Align(FEHat3.Handle,Grip,true,CFrame.new(0,0.6,1)*DoMath(0,0,0))
FEHat.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
FEHat2.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
FEHat3.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
