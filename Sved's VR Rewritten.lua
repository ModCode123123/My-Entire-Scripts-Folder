 local OldLegMovement = false

local Smoothness = 0.6
local Transparency = 0.5
local NetlessVelocity = Vector3.new(0,27,0)
local AccessorySettings = {
	
	LeftLeg = "Kate Hair";
	RightLeg = "Hat1";
	LeftArm = "Pal Hair";
	RightArm = "LavanderHair";
	Torso = "SeeMonkey";
	
	Head = true; --Use any leftover hats for the head
	
}


--DONT EDIT BELOW UNLESS YOU KNOW WHAT YOUR DOING!



local ReanimationRig = game:GetObjects("rbxassetid://8246626421")[1]
ReanimationRig.Parent = game.Players.LocalPlayer.Character
ReanimationRig.HumanoidRootPart.Anchored = false
ReanimationRig.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
ReanimationRig.HumanoidRootPart["Root Hip"].Name = "RootJoint"
for i,x in pairs(ReanimationRig:GetChildren()) do
	if x:IsA("BasePart") then
		x.Transparency = 1
	end
end

local LocalPlayer = game.Players.LocalPlayer
local Humanoid = LocalPlayer.Character.Humanoid
local char = LocalPlayer.Character
char.Animate:Clone().Parent = ReanimationRig
local LeftReani = char[AccessorySettings.LeftArm]
local RightReani = char[AccessorySettings.RightArm]
local LeftHipReani = char[AccessorySettings.LeftLeg]
local RightHipReani = char[AccessorySettings.RightLeg]
local TorsoReani = char[AccessorySettings.Torso]


ReanimationRig.Head["Face"].Name ="face"
game:GetService("RunService").Heartbeat:Connect(function()
	if Humanoid then
		Humanoid.MaxHealth = math.huge
		Humanoid.Health = math.huge
	end
end)
function  ReaniMesh(Hat)
	Hat.Handle:BreakJoints()
	Hat.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
end
ReaniMesh(LeftReani)
ReaniMesh(RightReani)
ReaniMesh(LeftHipReani)
ReaniMesh(RightHipReani)
ReaniMesh(TorsoReani)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0, 30, 0)
		end)
	end
end

local function Align(Part1,Part0,CFrameOffset) -- i dont know who made this function but 64will64 sent it to me so credit to whoever made it
	local AlignPos = Instance.new('AlignPosition', Part1);
	AlignPos.Parent.CanCollide = false;
	AlignPos.ApplyAtCenterOfMass = true;
	AlignPos.MaxForce = 9e9;
	AlignPos.MaxVelocity = 9e9;
	AlignPos.ReactionForceEnabled = false;
	AlignPos.Responsiveness = 200;
	AlignPos.RigidityEnabled = false;
	local AlignOri = Instance.new('AlignOrientation', Part1);
	AlignOri.MaxAngularVelocity = 9e9;
	AlignOri.MaxTorque = 9e9;
	AlignOri.PrimaryAxisOnly = false;
	AlignOri.ReactionTorqueEnabled = false;
	AlignOri.Responsiveness = 200;
	AlignOri.RigidityEnabled = false;
	local AttachmentA=Instance.new('Attachment',Part1);
	local AttachmentB=Instance.new('Attachment',Part0);
	AttachmentB.CFrame = AttachmentB.CFrame * CFrameOffset
	AlignPos.Attachment0 = AttachmentA;
	AlignPos.Attachment1 = AttachmentB;
	AlignOri.Attachment0 = AttachmentA;
	AlignOri.Attachment1 = AttachmentB;
	Part1.Massless = false
	Part1.Transparency = Transparency 
end

--[[
for i,x in pairs(char:GetChildren()) do
	if x:IsA("Accessory") then
		if x.Name == AccessorySettings.LeftArm or x.Name == AccessorySettings.RightArm or x.Name == AccessorySettings.LeftLeg or x.Name == AccessorySettings.RightLeg or x.Name == AccessorySettings.Torso then

		else
			x.Handle:BreakJoints()
Align(x.Handle,ReanimationRig.Head,CFrame.new(0,0,0))
		end
		x.Handle.Transparency = Transparency
	end
end

]]
--Align(LeftReani.Handle,ReanimationRig["Left Arm"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90), math.rad(0), math.rad(0)))
--Align(RightReani.Handle,ReanimationRig["Right Arm"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90), math.rad(0), math.rad(0)))
--Align(TorsoReani.Handle,ReanimationRig["Torso"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90), math.rad(0), math.rad(0)))
Align(LeftHipReani.Handle,ReanimationRig["Left Leg"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90), math.rad(0), math.rad(0)))
Align(RightHipReani.Handle,ReanimationRig["Right Leg"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90), math.rad(0), math.rad(0)))
wait()
local ReturnAttachment = Instance.new("Attachment", ReanimationRig["Torso"])
ReturnAttachment.CFrame = CFrame.new(0,-10,0)*CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
LocalPlayer.Character = ReanimationRig
--HeadReani.Handle.Size = Vector3.new(0.01, 0.01, 0.01)
workspace.CurrentCamera.CameraSubject = ReanimationRig["Humanoid"]


--//=======================================\\--

---SVED'S / STICK'S / ALGODOOUSER'S FULL BODY VR SCRIPT

--//=======================================\\--

local plr = LocalPlayer
local char = plr.Character
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Humanoid = char:FindFirstChildOfClass('Humanoid')

local v3 = Vector3.new()
local cf = CFrame.new()
local rad = math.rad
local rand = math.random()

local leftleg = char["Left Leg"]
local rightleg = char["Right Leg"]
local leftarm = char["Left Arm"]
local rightarm = char["Right Arm"]
local torso = char["Torso"]
local head = char["Head"]


local HeadPosition = Instance.new("Part", char)
HeadPosition.Anchored = true
HeadPosition.CanCollide = false
HeadPosition.Size = Vector3.new(0.01, 0.01, 0.01)
function ArcTan(x, y)
	local r = math.atan(y / x)
	if x < 0 then
		r = r + math.pi
	end
	return r
end
Torso = TorsoReani.Handle
L_Hip = Torso["Left Hip"]
R_Hip = Torso["Right Hip"]
			

		local lastR0 = R_Hip.C0
		local lastL0 = L_Hip.C0
		local lastR1 = R_Hip.C1
		local lastL1 = L_Hip.C1
		local updatespeed = 0.5/2

		local vel = Vector3.new()
		local r
		local m
		local v
		local L_a
		local R_a

		function ArcTan(x, y)
			r = math.atan(y / x)
			if x < 0 then
				r = r + math.pi
			end
			return r
		end

		local rs = game:GetService('RunService')

		rs.RenderStepped:Connect(function(dt)
			local velVector = Vector3.new(TorsoReani.Handle.Velocity.X,0,Torso.Velocity.Z);
			if velVector.magnitude > 0 then
				m = (vel - Torso.Velocity).magnitude / Humanoid.WalkSpeed
				vel = (Torso.Velocity * m + vel * 2) / (m + 2)
				v = Torso.CFrame:pointToObjectSpace(vel + Torso.Position)
				L_a = ArcTan(v.x, -v.z)
				R_a = 3.1416 - ArcTan(v.x, v.z)
				L_Hip.C1 = L_Hip.C1:lerp(CFrame.new(0, 1, 0)*CFrame.Angles(0, L_a+math.pi, 0), updatespeed)
				R_Hip.C1 = R_Hip.C1:lerp(CFrame.new(0, 1, 0)*CFrame.Angles(0, R_a+math.pi, 0), updatespeed)
				L_Hip.C0 = L_Hip.C0:lerp(CFrame.new(-0.5, -1, 0)*CFrame.Angles(0, L_a-math.pi, 0), updatespeed)
				R_Hip.C0 = R_Hip.C0:lerp(CFrame.new(0.5, -1, 0)*CFrame.Angles(0, R_a-math.pi, 0), updatespeed)
				L_Hip.MaxVelocity = Torso.Velocity.Magnitude / 100
				R_Hip.MaxVelocity = Torso.Velocity.Magnitude / 100
			else
				L_Hip.C1 = CFrame.new(0, 1, 0)*CFrame.Angles(0, -1.57, 0)
				R_Hip.C1 = CFrame.new(0, 1, 0)*CFrame.Angles(0, 1.57, 0)
				L_Hip.C0 = CFrame.new(-0.5, -1, 0)*CFrame.Angles(0, -1.57, 0)
				R_Hip.C0 = CFrame.new(0.5, -1, 0)*CFrame.Angles(0, 1.57, 0)
			end
			lastR0 = R_Hip.C0
			lastL0 = L_Hip.C0
			lastR1 = R_Hip.C1
			lastL1 = L_Hip.C1
		end)
		
	leftarm:BreakJoints()
	rightarm:BreakJoints()
UserInputService.UserCFrameChanged:Connect(function(CFrameType,Positioning)
		if CFrameType == Enum.UserCFrame.LeftHand then
		LeftReani.Handle.CFrame = Camera.CFrame*Positioning*CFrame.Angles(rad(0),rad(0),rad(0))
	end
	if CFrameType == Enum.UserCFrame.RightHand then
		RightReani.Handle.CFrame = Camera.CFrame*Positioning*CFrame.Angles(rad(0),rad(0),rad(0))
	end
	if CFrameType == Enum.UserCFrame.Head then
		HeadPosition.CFrame =  Camera.CFrame*Positioning
		
		TorsoReani.Handle.CFrame = Camera.CFrame*Positioning*CFrame.Angles(rad(90),rad(0),rad(0))*CFrame.new(0,0,2)--*cf(0,1,0)
		--torso.Position =TorsoReani.Handle.Position
		
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode ==Enum.KeyCode.ButtonL2 then
		Humanoid.WalkSpeed = 16
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode ==Enum.KeyCode.ButtonL2 then
		Humanoid.WalkSpeed = 6
	end
end)