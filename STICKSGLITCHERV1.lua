-- when you reset make sure to re-execute this or just make this execute in a loop
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(45,0,0)
		end)
	end
end

local Options = {
	FE_VFX = true; --//makes the Ringblocks FE with hats
	FE_VFXHat1 = "Pal Hair"; --//the hat used for the 1st Ringblock
	FE_VFXHat2 = "LavanderHair"; --//the hat used for the 2nd Ringblock
	FE_VFXHat3 = "Kate Hair"; --//the hat used for the 3rd Ringblock

	ReanimationType = 1; --//1 = netless v3, 2 == net for every limb

}



local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

local backpack = plr.Backpack
local gui = plr.PlayerGui
local playerscripts = plr.PlayerScripts





-----Varibles-----


local Mode 
local MainModeColor 

local Netural = false
local Repowered = false
local OBFUSCATION = false
local Visual = false

local Runservice = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera
local Mouse = plr:GetMouse()

local leftleg = char:FindFirstChild("Left Leg")
local rightleg = char:FindFirstChild("Right Leg")
local leftarm = char:FindFirstChild("Left Arm")
local rightarm = char:FindFirstChild("Right Arm")
local head = char:FindFirstChild("Head")

local Moving = false
local Falling = false
MainModeColor = Color3.new(1, 0, 0)
------Local Functions------

local function Weld(part0,part1,c0,name) --//the WELD :L
	local weld = Instance.new("Weld",part0)
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0
	weld.Name = name
	return weld
end
local function AlignObjects(a0,a1,breakjoints) --//aligning to objects :P
	local alignpos = Instance.new("AlignPosition",a0.Parent)
	alignpos.Attachment0 = a0	
	alignpos.Attachment1 = a1
	alignpos.Responsiveness = 9e9
	local alignori = Instance.new("AlignOrientation",a0.Parent)
	alignori.Attachment0 = a0	
	alignori.Attachment1 =a1
	alignori.Responsiveness = 9e9
	a0.Parent.Massless = true
	if breakjoints then
		a0.Parent:BreakJoints()
	else
		--//uhhh maybe??
	end
end
local function CreateVFXPart(size,color3,tranparency,shape,fadevfx,cframe,timeuntilfade)
	local part = Instance.new("Part",workspace)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = tranparency
	part.Size = size
	part.Color = color3
	part.Shape = shape
	part.CFrame = char:FindFirstChild("Torso").CFrame
	part.Material = Enum.Material.Neon
	if cframe then
		part.CFrame = char:FindFirstChild("Torso").CFrame * cframe	
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
end
local function CreateSoundVFX(id,volume)
	local sound = Instance.new("Sound",workspace) --//also used alot
	sound.SoundId = id
	sound.Volume = volume
	sound:Play()
	sound.Played:Connect(function()
		sound:Destroy()
	end)
	if not id and volume then
		return
	end
end


local function CreateReanimationLimb(limb) --//makes things FE
	local reanimatelimb = Instance.new("Part",char)
	reanimatelimb.Size = limb.Size
	reanimatelimb.CanCollide = false
	reanimatelimb.Transparency = 1
	reanimatelimb.Anchored = false
	return reanimatelimb
end

local function DoMath(rotx,roty,rotz)
	local cframe = CFrame.Angles(math.rad(rotx),math.rad(roty),math.rad(rotz))
	return cframe
end

local function CreateMesh(id,parent)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.MeshId = id
end
local function DestroyMesh(object,breakjoints)
	if object:IsA("Accessory") then
		object:FindFirstChild("Handle"):FindFirstChildOfClass("SpecialMesh"):Destroy()
	end
	if object:IsA("Part") then
		object:FindFirstChildOfClass("SpecialMesh"):Destroy()
	end
	if object:IsA("Accessory") and breakjoints then
		object.FindFirstChild("Handle"):BreakJoints()
	end
end
local function CreateAttachment(object,cframe,name)
	local attachment = Instance.new("Attachment",object)
	attachment.CFrame =cframe
	attachment.Name =name
	return attachment
end
--The Script--
local Bossmusic = Instance.new("Sound",workspace)
Bossmusic.Volume = 2
Bossmusic.Playing = true
Bossmusic.Looped = true

MainModeColor = Color3.new(1, 1, 1)
local RingBlock1 = Instance.new("Part",workspace)
RingBlock1.Size = Vector3.new(1,2,1)
RingBlock1.CanCollide =false
RingBlock1.Material = Enum.Material.Neon
RingBlock1.Color = MainModeColor
local RingBlock2= Instance.new("Part",workspace)
RingBlock2.Size = Vector3.new(1,2,1)
RingBlock2.CanCollide =false
RingBlock2.Material = Enum.Material.Neon
RingBlock2.Color = MainModeColor
local RingBlock3 = Instance.new("Part",workspace)
RingBlock3.Size = Vector3.new(1,2,1)
RingBlock3.CanCollide =false
RingBlock3.Material = Enum.Material.Neon
RingBlock3.Color = MainModeColor

local function  Update()
	RingBlock1.Color = MainModeColor
	RingBlock2.Color = MainModeColor
	RingBlock3.Color = MainModeColor	
end

local ringweld1 = Weld(RingBlock1,head,CFrame.new(-2,0,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(20)),"RNG1") --//oh boy i sure do love welding x1
local ringweld2 = Weld(RingBlock2,head,CFrame.new(2,0,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(-20)),"RNG2") --//oh boy i sure do love welding  x2
local ringweld3 =Weld(RingBlock3,head,CFrame.new(0,1,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),"RNG3") --//oh boy i sure do love welding  x3

local OriginRingW1 =  CFrame.new(-2,0,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(20))
local OriginRingW2 = CFrame.new(2,0,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(-20))
local OriginRingW3 = CFrame.new(0,1,-3)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))

local VirtualRLeg = CreateReanimationLimb(rightleg)
local VirtualLLeg = CreateReanimationLimb(leftleg)
local VirutalLArm = CreateReanimationLimb(leftarm)
local VirtualRArm = CreateReanimationLimb(rightarm)

local leftlegWC0 =  CFrame.new(0.5,2,0) *DoMath(0,0,0)
local rightlegWC0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
local leftarmWC0 =  CFrame.new(1.5,0,0) *DoMath(0,0,0)
local rightarmWC0 =  CFrame.new(-1.5,0,0) *DoMath(0,0,0)


local LLegweld = Weld(VirtualLLeg,char:FindFirstChild("Torso"),leftlegWC0,"LL")
local RLegweld = Weld(VirtualRLeg,char:FindFirstChild("Torso"),rightlegWC0,"RL")
local LArmweld = Weld(VirutalLArm,char:FindFirstChild("Torso"),leftarmWC0,"LA")
local RArmweld = Weld(VirtualRArm,char:FindFirstChild("Torso"),rightarmWC0,"RA")


----The Switcher Handler----

UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Z then
		if Netural == false then
			CreateSoundVFX("rbxassetid://3545354407",2)
			CreateVFXPart(Vector3.new(5,5,5),Color3.new(1, 0, 0),0,Enum.PartType.Ball,true)
			--//rbxassetid://1767358533
			CreateSoundVFX("rbxassetid://365002938",10)
			CreateVFXPart(Vector3.new(7,7,7),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true)
			Netural = true
			MainModeColor = Color3.new(1, 0, 0)
			Repowered= false
			OBFUSCATION = false
			Bossmusic = "rbxassetid://7028856935"
			Visual = false
			Update()
		else
			--//you cant have the same mode twice >:3
		end
	end
	if key.KeyCode == Enum.KeyCode.X then
		if Repowered == false then
			CreateSoundVFX("rbxassetid://3545354407",2)
			CreateVFXPart(Vector3.new(5,5,5),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true)
			CreateSoundVFX("rbxassetid://365002938",10)
			CreateVFXPart(Vector3.new(7,7,7),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			Repowered = true
			MainModeColor = Color3.new(0, 0.666667, 1)
			Netural = false
			OBFUSCATION = false
			Bossmusic = "rbxassetid://9045397467"
			Visual = false
			Update()
		else
			--//you cant have the same mode twice >:3
		end
	end

	if key.KeyCode == Enum.KeyCode.C then
		if OBFUSCATION == false then
			CreateSoundVFX("rbxassetid://3545354407",2)
			CreateVFXPart(Vector3.new(5,5,5),Color3.new(0, 0, 0),0,Enum.PartType.Ball,true)
			char:FindFirstChildOfClass("Humanoid").HipHeight = 54
			char:FindFirstChild("HumanoidRootPart").Anchored = true
			CreateSoundVFX("rbxassetid://365002938",10)
			CreateVFXPart(Vector3.new(7,7,7),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateVFXPart(Vector3.new(50,50,50),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateSoundVFX("rbxassetid://7390331288",10)
			char:FindFirstChild("HumanoidRootPart").Anchored = false
			Bossmusic = "rbxassetid://1842801942"
			Repowered = false
			MainModeColor = Color3.new(0, 0, 0)
			Netural = false
			OBFUSCATION = true
			Visual = false
			Update()
		else
			--//you cant have the same mode twice >:3
		end
	end

	if key.KeyCode == Enum.KeyCode.V then
		if OBFUSCATION == false then
			CreateSoundVFX("rbxassetid://3545354407",2)
			CreateVFXPart(Vector3.new(5,5,5),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateSoundVFX("rbxassetid://365002938",10)
			CreateVFXPart(Vector3.new(7,7,7),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateVFXPart(Vector3.new(50,50,50),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateSoundVFX("rbxassetid://7390331288",10)
			Bossmusic = "rbxassetid://1842801942"
			Repowered = false
			MainModeColor = Color3.new(1, 1, 1)
			Netural = false
			OBFUSCATION = false
			Visual = true
			Update()
		else
			--//you cant have the same mode twice >:3
		end
	end

end)

----//Aligning Character\\----

local LeftArmAttachment = CreateAttachment(leftarm,CFrame.new(0,0,0)*DoMath(0,0,0),"LARMC")
local RightArmAttachment = CreateAttachment(rightarm,CFrame.new(0,0,0)*DoMath(0,0,0),"RARMC")
local LeftLegAttachment = CreateAttachment(leftleg,CFrame.new(0,0,0)*DoMath(0,0,0),"LLEGC")
local RightLegAttachment = CreateAttachment(rightleg,CFrame.new(0,0,0)*DoMath(0,0,0),"RLEGC")

local LeftArmAttachment2 = CreateAttachment(VirutalLArm,CFrame.new(0,0,0)*DoMath(0,0,0),"L2")
local RightArmAttachment2 = CreateAttachment(VirtualRArm,CFrame.new(0,0,0)*DoMath(0,0,0),"R2")
local LeftLegAttachment2 = CreateAttachment(VirtualLLeg,CFrame.new(0,0,0)*DoMath(0,0,0),"L3")
local RightLegAttachment2 = CreateAttachment(VirtualRLeg,CFrame.new(0,0,0)*DoMath(0,0,0),"R3")

AlignObjects(LeftLegAttachment,LeftLegAttachment2,true)
AlignObjects(RightLegAttachment,RightLegAttachment2,true)
AlignObjects(LeftArmAttachment,LeftArmAttachment2,true)
AlignObjects(RightArmAttachment,RightArmAttachment2,true)

----//Mode VFX and Attacks\\----


local Punch1 = false
local Punch2 = false
local Punch3 = false
local Special1 = false

local AnimationReady = true
local Running = false
local Idle = true
--[[Runservice.Heartbeat:Connect(function()
	UserInputService.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.D or key.KeyCode == Enum.KeyCode.A then
			Running = true
			Idle = false
		end
	end)
	UserInputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.D or key.KeyCode == Enum.KeyCode.A then
			Running = false
			Idle = true
		end
	end)

end)]]

Mouse.Button1Down:Connect(function()
	if Netural then
		Netural = false
		RArmweld.C0 = CFrame.new(-1.5,1.6,0) *DoMath(90,180,20)
		wait(0.3)
		RArmweld.C0 = CFrame.new(-1.5,1.6,0) *DoMath(20,180,20)
		wait(1)
		Netural = true
	end

end)





Runservice.Heartbeat:Connect(function()
	if Netural then
		wait(0.5)
		CreateVFXPart(Vector3.new(0.2,2,2),Color3.new(1, 0, 0),0,Enum.PartType.Cylinder,true,CFrame.new(0,3,0)*DoMath(0,90,90))
		if AnimationReady == true then
			LArmweld.C0 = CFrame.new(1.5,1,0.2) *DoMath(-160,0,20)
			RArmweld.C0 = CFrame.new(-1.5,0.3,-0.2) *DoMath(-10,0,-20)
			ringweld1.C0 = CFrame.new(-4,0,0) *DoMath(0,0,40)
			ringweld2.C0 = CFrame.new(4,0,0) *DoMath(0,0,-40)
			ringweld3.C0 = CFrame.new(0,-4,0) *DoMath(0,0,-70)
			local walkanim = false
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.W  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.W  then
					walkanim = false
					wait(0.6)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.S  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.S  then
					walkanim = false
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.A  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.A  then
					walkanim = false
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.D  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.D  then
					walkanim = false

				end
			end)
		end
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.F and Netural == true then
		Special1 = true
		AnimationReady = false
		LArmweld.C0 = CFrame.new(1.5,0.7,-3) *DoMath(-160,0,20)
		while Special1 ==  true do
			CreateSoundVFX("rbxassetid://1336756135",7)
			wait()
			CreateVFXPart(Vector3.new(2,2,2),Color3.new(1, 0, 0),0,Enum.PartType.Ball,true,CFrame.new(-1.5,3,-3)*DoMath(0,90,90))
			wait()
			CreateVFXPart(Vector3.new(4,4,4),Color3.new(1, 0, 0),0,Enum.PartType.Ball,true,CFrame.new(-1.5,3,-3)*DoMath(0,90,90))
			wait()
			CreateVFXPart(Vector3.new(8,8,8),Color3.new(1, 0, 0),0,Enum.PartType.Ball,true,CFrame.new(-1.5,3,-3)*DoMath(0,90,90))
			wait()
			CreateVFXPart(Vector3.new(1000,40,40),Color3.new(1, 0, 0),0,Enum.PartType.Cylinder,true,CFrame.new(0,3,0)*DoMath(0,90,90))
			CreateSoundVFX("rbxassetid://7157159568",5)
			wait()
			Special1 = false
			AnimationReady = true
		end
	end
end)
Runservice.Heartbeat:Connect(function()
	if Punch1 and Netural then

	end
end)
if Options.FE_VFX == true then
	local a1 = char:FindFirstChild(Options.FE_VFXHat1)
	local a2 = char:FindFirstChild(Options.FE_VFXHat2)
	local a3 = char:FindFirstChild(Options.FE_VFXHat3)
	a1.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	a2.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	a3.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	local a1at = CreateAttachment(a1.Handle,CFrame.new(0,0,0)*DoMath(0,0,0),"A1")
	local a2at = CreateAttachment(a2.Handle,CFrame.new(0,0,0)*DoMath(0,0,0),"A2")
	local a3at = CreateAttachment(a3.Handle,CFrame.new(0,0,0)*DoMath(0,0,0),"A3")
	a1at.Orientation = Vector3.new(90, 0, 0)
	a2at.Orientation = Vector3.new(90, 0, 0)
	a3at.Orientation = Vector3.new(90, 0, 0)
	local a1at2 = CreateAttachment(RingBlock1,CFrame.new(0,0,0)*DoMath(0,0,0),"A12")
	local a2at2 = CreateAttachment(RingBlock2,CFrame.new(0,0,0)*DoMath(0,0,0),"A22")
	local a3at2 = CreateAttachment(RingBlock3,CFrame.new(0,0,0)*DoMath(0,0,0),"A32")


	AlignObjects(a1at,a1at2,true)
	AlignObjects(a2at,a2at2,true)
	AlignObjects(a3at,a3at2,true)

	game:GetService("RunService").Heartbeat:Connect(function()
		if a1 and a2 and a3 then
			a1.Handle.Velocity = Vector3.new(27,0,0)
			a2.Handle.Velocity = Vector3.new(27,0,0)
			a3.Handle.Velocity = Vector3.new(27,0,0)
		end
	end)
end

Runservice.Heartbeat:Connect(function()

end)
if OBFUSCATION then
	CreateVFXPart(Vector3.new(1,1,1),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true,CFrame.new(3,1,0)*DoMath(0,0,0))
	CreateVFXPart(Vector3.new(1,1,1),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true,CFrame.new(-3,1,0)*DoMath(0,0,0))
	if AnimationReady  then
		LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(90,90,0)
		RArmweld.C0 = CFrame.new(-1.5,0,-0) *DoMath(-90,-90,0)
		LLegweld.C0 = CFrame.new(1.8,2,0) *DoMath(-20,0,0)
		RLegweld.C0 = CFrame.new(-1.8,2,0) *DoMath(20,0,0)
		ringweld1.C0 = CFrame.new(-3,0,0) *DoMath(0,0,0)
		ringweld2.C0 = CFrame.new(3,0,0) *DoMath(0,0,0)
		ringweld3.C0 = CFrame.new(0,0,-3) *DoMath(0,0,0)
		char:FindFirstChildOfClass("Humanoid").HipHeight = 4
	end
	local walkanim = false
	UserInputService.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.W  then
			walkanim = true
			AnimationReady = false
			while  walkanim == true do
				char:FindFirstChildOfClass("Humanoid").HipHeight = 0
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(-30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.W  then
			walkanim = false
			AnimationReady = true
			wait(0.6)
			LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
			RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
		end
	end)
	UserInputService.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.S  then
			walkanim = true
			while  walkanim == true do
				char:FindFirstChildOfClass("Humanoid").HipHeight = 0
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(-30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.S  then
			walkanim = false
			AnimationReady = true
		end
	end)
	UserInputService.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.A  then
			walkanim = true
			while  walkanim == true do
				char:FindFirstChildOfClass("Humanoid").HipHeight = 0
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(-30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.A  then
			walkanim = false
			AnimationReady = true
		end
	end)
	UserInputService.InputBegan:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.D  then
			walkanim = true
			while  walkanim == true do
				char:FindFirstChildOfClass("Humanoid").HipHeight = 0
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(-30,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(30,0,0)
				wait(0.1)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				LArmweld.C0 = CFrame.new(1.5,0,0) *DoMath(0,0,0)
				RArmweld.C0 =  CFrame.new(-0.5,2,0) *DoMath(0,0,0)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode.D  then
			walkanim = false
			AnimationReady = true
		end
	end)
end

Runservice.Heartbeat:Connect(function()
	if Repowered then
		CreateVFXPart(Vector3.new(1,1,1),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true,CFrame.new(3,1,0)*DoMath(0,0,0))
		CreateVFXPart(Vector3.new(1,1,1),Color3.new(0, 0.666667, 1),0,Enum.PartType.Ball,true,CFrame.new(-3,1,0)*DoMath(0,0,0))
		if AnimationReady == true then
			LArmweld.C0 = CFrame.new(0.8,0,-1) *DoMath(0,0,-30)
			RArmweld.C0 = CFrame.new(-0.8,0,-1) *DoMath(0,0,30)
			ringweld1.C0 = CFrame.new(-3,0,0) *DoMath(0,0,40)
			ringweld2.C0 = CFrame.new(3,0,0) *DoMath(0,0,-40)
			ringweld3.C0 = CFrame.new(0,-4,0) *DoMath(0,0,0)
			local walkanim = false
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.W  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.W  then
					walkanim = false
					wait(0.6)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.S  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.S  then
					walkanim = false
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.A  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.A  then
					walkanim = false
				end
			end)
			UserInputService.InputBegan:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.D  then
					walkanim = true
					while  walkanim == true do
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
						wait(0.1)
						LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
						RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
					end
				end
			end)
			UserInputService.InputEnded:Connect(function(key)
				if key.KeyCode == Enum.KeyCode.D  then
					walkanim = false

				end
			end)
		end
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.F and Repowered == true then
		AnimationReady = false
		LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
		RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
		wait(0.2)
		LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(10,0,0)
		RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(-30,0,0)
		wait(0.2)
		LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(20,0,0)
		RLegweld.C0 = CFrame.new(-0.5,2,0.7) *DoMath(-40,0,0)
		wait(0.2)
		LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
		RLegweld.C0 = CFrame.new(-0.5,2,1.4) *DoMath(0,0,0)
		CreateVFXPart(Vector3.new(1,30,30),Color3.new(0, 0.666667, 1),0,Enum.PartType.Cylinder,true,CFrame.new(0,-2,0)*DoMath(0,-90,-90))
		CreateSoundVFX("rbxassetid://6435892716",7)


		AnimationReady = true
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.F and OBFUSCATION == true then
		AnimationReady = false
		char:FindFirstChildOfClass("Humanoid").HipHeight = 50
		CreateSoundVFX("rbxassetid://9057811795",10)
		CreateVFXPart(Vector3.new(100,100,100),Color3.new(0, 0, 0),0,Enum.PartType.Ball,true)
		CreateVFXPart(Vector3.new(100,100,100),Color3.new(0, 0, 0),0,Enum.PartType.Ball,true)

		CreateVFXPart(Vector3.new(1000,100,100),Color3.new(0, 0, 0),0,Enum.PartType.Cylinder,true)
		AnimationReady = true
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Q and Repowered == true then
		local ready = false
		AnimationReady = false
		LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(-20,0,0)
		RLegweld.C0 = CFrame.new(-0.5,2,0)*DoMath(-20,0,0)
		LArmweld.C0 = CFrame.new(1.5,0,0)*DoMath(-20,0,0)
		RArmweld.C0 = CFrame.new(-1.5,0,0)*DoMath(-20,0,0)
		while ready == true do
			local number = 1
			char:FindFirstChild("HumanoidRootPart").CFrame = char:FindFirstChild("HumanoidRootPart").CFrame *CFrame.new(0,0,10) DoMath(0,0,0) 
			CreateVFXPart(Vector3.new(7,7,7),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			CreateSoundVFX("rbxassetid://6870001262",10)
			number = number + 1
			if number < 5 then
				ready = false
				number = 1
			end
		end

	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	if Visual then
		CreateVFXPart(Vector3.new(1,9,9),Color3.new(1, 1, 1),0,Enum.PartType.Cylinder,true,CFrame.new(0,-3,0)*DoMath(0,-90,-90))
		char:FindFirstChildOfClass("Humanoid").HipHeight = 4
		LLegweld.C0 = CFrame.new(0.8,2,0) *DoMath(0,5,-10)
		RLegweld.C0 = CFrame.new(-0.8,2,0)*DoMath(0,-5,10)
		LArmweld.C0 = CFrame.new(1,0,0)*DoMath(90,90,0)
		RArmweld.C0 = CFrame.new(-1,0.3,0)*DoMath(-90,-90,0)
		RingBlock1.CFrame = OriginRingW1
		RingBlock2.CFrame = OriginRingW2
		RingBlock1.CFrame = OriginRingW3
		local walkanim = false
		UserInputService.InputBegan:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.W  then
				walkanim = true
				while  walkanim == true do
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.W  then
				walkanim = false
				wait(0.6)
				LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(0,0,0)
				RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(0,0,0)
			end
		end)
		UserInputService.InputBegan:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.S  then
				walkanim = true
				while  walkanim == true do
					wait(0.1)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.S  then
				walkanim = false
			end
		end)
		UserInputService.InputBegan:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.A  then
				walkanim = true
				while  walkanim == true do
					wait(0.1)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.A  then
				walkanim = false
			end
		end)
		UserInputService.InputBegan:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.D  then
				walkanim = true
				while  walkanim == true do
					wait(0.1)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(30,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(30,0,0)
					wait(0.1)
					LLegweld.C0 = CFrame.new(0.5,2,0) *DoMath(27,0,0)
					RLegweld.C0 = CFrame.new(-0.5,2,0) *DoMath(27,0,0)
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(key)
			if key.KeyCode == Enum.KeyCode.D  then
				walkanim = false

			end
		end)
	end

end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.F and Visual then
		local ready = true
		while ready == true do
			CreateSoundVFX("rbxassetid://9119815960",10)
			CreateVFXPart(Vector3.new(20,20,20),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			wait()
			CreateVFXPart(Vector3.new(15,15,15),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			wait()
			CreateVFXPart(Vector3.new(10,10,10),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			wait()
			CreateVFXPart(Vector3.new(5,5,5),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			wait(1)
			CreateSoundVFX("rbxassetid://365003340",10)
			CreateVFXPart(Vector3.new(50,50,50),Color3.new(1, 1, 1),0,Enum.PartType.Ball,true)
			Camera.CFrame = Camera.CFrame * DoMath(-20,-20,0)
			wait(0.1)
			Camera.CFrame = Camera.CFrame *DoMath(-15,-15,0)
			wait(0.1)
			Camera.CFrame = Camera.CFrame * DoMath(-10,-10,0)
			wait(0.1)
			Camera.CFrame = Camera.CFrame *DoMath(-5,-5,0)
			wait(0.1)
			Camera.CFrame = Camera.CFrame*DoMath(0,0,0)
ready = false
		end
	end
end)


local function QuitTasks()
	RingBlock1:Destroy()
	RingBlock2:Destroy()
	RingBlock3:Destroy()
	Netural = false
	Repowered = false
	OBFUSCATION = false
	Visual = false
	Special1 = false
	Punch1 = false
	Punch2 = false
	Punch3 = false
	AnimationReady = false
	VirtualRArm:Destroy()
	VirtualLLeg:Destroy()
	VirtualRLeg:Destroy()
	VirtualRArm:Destroy()
	leftarm:Destroy()
	rightarm:Destroy()
	head:Destroy()
	leftleg:Destroy()
	rightleg:Destroy()

end
char:FindFirstChildOfClass("Humanoid").Died:Connect(QuitTasks)

