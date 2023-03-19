for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,30,0)
		end)
	end
end
local Walking = false












local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local Tool1 = Instance.new("Tool",plr.Backpack)
Tool1.Name = "FlameBloxer_2000"
local GunHandle = char:FindFirstChild("Pal Hair")
local GunBase = char:FindFirstChild("LavanderHair")
local GunFlash = char:FindFirstChild("Left Arm") --DiwaliHat
local GunBullet = char:FindFirstChild("Hat1")
local GunMag = char:FindFirstChild("WolfTail")
local GunBarrel = char:FindFirstChild("Kate Hair")
local LeftArmReplacment = char:FindFirstChild("Pink Hair")
local Mouse = plr:GetMouse()
local function DestroyMesh(Object)
	local Handle = Object.Handle
	Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
end

local function CCreateSFX(soundid,looped,play,volume)
	local SFX = Instance.new("Sound",char:FindFirstChild("Torso"))
	SFX.Volume =  volume
	SFX.SoundId = soundid
	SFX.Looped = looped
	if play == true then
		SFX:Play()
	end
end
local function CCreatePart(size,color3,tranparency,shape,fadevfx,cframe,timeuntilfade)
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
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency - 0.1
			wait()
			part:Destroy()
			fadevfx = false
		end
	else
		while fadevfx == true do

			wait()
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency + 0.1
			wait(0.01)
			part.Transparency = part.Transparency - 0.1
			wait()
			part:Destroy()
			fadevfx = false
		end
	end


end
local function CCreateParticle(texture,color,lifetime,parent)
	local particle = Instance.new("ParticleEmitter",parent)
	particle.Texture = texture
	particle.Lifetime = lifetime
	particle.Color = color
end
local CurrentMode 
local Screen = Instance.new("Part",char)
Screen.Size = Vector3.new(6.5, 4, 0.1)
Screen.Color = Color3.new(1,1,1)
Screen.Transparency = 0.5
Screen.Material = Enum.Material.Glass
Screen.CanCollide = false
local ScreenGui = Instance.new("SurfaceGui",Screen)
ScreenGui.Adornee = Screen
ScreenGui.Face = "Back"
local ScreenFrame = Instance.new("Frame",ScreenGui)
ScreenFrame.Size = UDim2.new(1,0,1,0)
ScreenFrame.BackgroundTransparency = 0.8
ScreenFrame.BackgroundColor3 = Color3.new(0, 0, 0)
ScreenFrame.BorderSizePixel = 0
local ModeText = Instance.new("TextLabel",ScreenFrame)
ModeText.BorderSizePixel = 0
ModeText.BackgroundTransparency = 1
ModeText.TextColor3 = Color3.new(1, 0.666667, 0)
ModeText.Text = "nil"
ModeText.Size = UDim2.new(0,130,0,40)
ModeText.Position = UDim2.new(0,0,0.8,0)
ModeText.TextStrokeColor3 = Color3.new(1, 0.333333, 0)
ModeText.Font = Enum.Font.Code
ModeText.TextScaled = true
local FrameSpin1 = Instance.new("Frame",ScreenFrame)
FrameSpin1.BackgroundColor3 = Color3.new(1, 0.333333, 0)
FrameSpin1.BorderSizePixel = 0
--FrameSpin1.Position = UDim2.new(0.65,0,0.44,0)
local FrameSpin2 = Instance.new("Frame",ScreenFrame)
FrameSpin2.BackgroundColor3 = Color3.new(1, 0.666667, 0)
FrameSpin2.BorderSizePixel = 0
--FrameSpin2.Position = UDim2.new(0.65,0,0.44,0)

local weld = Instance.new("Weld",Screen)
weld.Part0 = Screen
weld.Part1 = char:FindFirstChild("Torso")
weld.C0 = CFrame.new(0,-3,9) *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0))
local FlameThrower = true
local VolcanoThrower = false
local Eruption =false
local Meltdown = false
local BossBillboard = Instance.new("BillboardGui",char:FindFirstChild("Head"))
BossBillboard.Size = UDim2.new(2,0,1,0)
local BossName = Instance.new("TextLabel",BossBillboard)
BossBillboard.StudsOffsetWorldSpace = Vector3.new(0,3,0)
BossName.Text = "nil"
BossName.TextScaled = true
BossName.BackgroundTransparency = 1
BossName.Size = UDim2.new(1,0,1,0)
BossName.TextStrokeTransparency = 0
BossName.TextColor3 = Color3.new(1, 0.666667, 0)
BossName.Font = Enum.Font.Code
--[[game:GetService("RunService").Heartbeat:Connect(function()
	wait()
		FrameSpin1.Rotation = FrameSpin1.Rotation + 1
		FrameSpin2.Rotation = FrameSpin1.Rotation - 1
end)]]

local function BossnameConfig(text,txtcolor,txtstrkecolor)
	BossName.Text = text
	BossName.TextColor3 = txtcolor
	BossName.TextStrokeColor3 = txtstrkecolor
	ModeText.Text = text
	ModeText.TextColor3 = txtcolor
	ModeText.TextStrokeColor3 = txtstrkecolor
	FrameSpin2.BackgroundColor3 = txtstrkecolor
	FrameSpin1.BackgroundColor3 = txtcolor
end





local Handle = Instance.new("Part",Tool1)
Handle.Size = Vector3.new(1,2,1)
Handle.CanCollide = false
Handle.Transparency = 1
Handle.Anchored = false
Handle.Name = "Handle"
local Base = Instance.new("Part",Tool1)
Base.Size = Vector3.new(1,1,2)
Base.CanCollide = false
Base.Transparency = 1
Base.Anchored = false
local Mag = Instance.new("Part",Tool1)
Mag.Size =Vector3.new(1,1,2)
Mag.Anchored = false
Mag.Transparency = 1
Mag.CanCollide = false
local Barrel = Instance.new("Part",Tool1)
Barrel.Size = Vector3.new(1,1,3)
Barrel.CanCollide = false
Barrel.Transparency = 1
Barrel.Anchored = false
local HandleWeld = Instance.new("Weld",Base)
HandleWeld.Part0 = Base
HandleWeld.Part1 = Handle
HandleWeld.C0 = CFrame.new(0,-0.5,1.5) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local MagWeld = Instance.new("Weld",Mag)
MagWeld.Part0 = Mag
MagWeld.Part1 = Handle
MagWeld.C0 = CFrame.new(0,-0.5,4) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local BarrelWeld = Instance.new("Weld",Barrel)
BarrelWeld.Part0 = Barrel
BarrelWeld.Part1 = Handle
BarrelWeld.C0 =CFrame.new(0,0,4) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local HandleAtt = Instance.new("Attachment",Handle)
local BaseAtt = Instance.new("Attachment",Base)
local HatHandleAtt = Instance.new("Attachment",GunHandle.Handle)
local BaseHatAtt  = Instance.new("Attachment",GunBase.Handle)
local BarrelAttachment = Instance.new("Attachment",GunBarrel.Handle)
local MagAttachment = Instance.new("Attachment",GunMag.Handle)
local BarrelOrigin = Instance.new("Attachment",Barrel)
local MagOrigin = Instance.new("Attachment",Mag)
HandleAtt.Orientation = Vector3.new(90,0,0)
BarrelOrigin.Orientation = Vector3.new(90,0,0)
local AlignHandle = Instance.new("AlignPosition",GunHandle.Handle)
AlignHandle.Attachment0 = HatHandleAtt
AlignHandle.Attachment1 = HandleAtt
AlignHandle.Responsiveness = 9e9
local AlignHandle2 = Instance.new("AlignOrientation",GunHandle.Handle)
AlignHandle2.Attachment0 = HatHandleAtt
AlignHandle2.Attachment1 = HandleAtt
AlignHandle2.Responsiveness = 9e9
local AlignBase = Instance.new("AlignPosition",GunBase.Handle)
AlignBase.Attachment0 =BaseHatAtt
AlignBase.Attachment1 = BaseAtt
AlignBase.Responsiveness = 9e9
local AlignBase2 = Instance.new("AlignOrientation",GunBase.Handle)
AlignBase2.Attachment0 = BaseHatAtt
AlignBase2.Attachment1 = BaseAtt
AlignBase2.Responsiveness = 9e9
local AlignMag1 = Instance.new("AlignPosition",GunMag.Handle)
AlignMag1.Attachment0 = MagAttachment
AlignMag1.Attachment1 = MagOrigin
AlignMag1.Responsiveness = 9e9
local AlignMag2 = Instance.new("AlignOrientation",GunMag.Handle)
AlignMag2.Attachment0 = MagAttachment
AlignMag2.Attachment1 = MagOrigin
AlignMag2.Responsiveness  = 9e9
local AlignBarrel = Instance.new("AlignPosition",GunBarrel.Handle)
AlignBarrel.Attachment0 = BarrelAttachment
AlignBarrel.Attachment1 = BarrelOrigin
AlignBarrel.Responsiveness = 9e9
local AlignBarrel2 = Instance.new("AlignOrientation",GunBarrel.Handle)
AlignBarrel2.Attachment0 = BarrelAttachment
AlignBarrel2.Attachment1 =BarrelOrigin
AlignBarrel2.Responsiveness = 9e9
GunHandle.Handle:BreakJoints()
GunBase.Handle:BreakJoints()

GunBullet.Handle:BreakJoints()
GunFlash:BreakJoints()
GunMag.Handle:BreakJoints()

GunBarrel.Handle:BreakJoints()

DestroyMesh(GunBase)
--DestroyMesh(GunFlash)
DestroyMesh(GunMag)
DestroyMesh(GunBarrel)
DestroyMesh(GunBullet)
DestroyMesh(GunHandle)
--GunFlash.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
local RN = game:GetService("RunService")
local MouseDown = false
local AttachmentBullet = Instance.new("Attachment",GunBullet.Handle)
local AttachmentLeftArm = Instance.new("Attachment",char["SeeMonkey"].Handle)
AttachmentLeftArm.CFrame = CFrame.new(0,0.5,1) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
AttachmentLeftArm.Orientation = Vector3.new(0,90,0)
local AlignBullet = Instance.new("AlignPosition",GunBullet.Handle)
AlignBullet.Attachment0 = AttachmentBullet
AlignBullet.Attachment1 = AttachmentLeftArm
AlignBullet.Responsiveness = 9e9
local AlignBullet2 = Instance.new("AlignOrientation",GunBullet.Handle)
AlignBullet2.Attachment0 = AttachmentBullet
AlignBullet2.Attachment1 = AttachmentLeftArm
AlignBullet2.Responsiveness = 9e9
local BossMusic = Instance.new("Sound",workspace)
BossMusic.Looped = true
BossMusic.SoundId = ""
BossMusic.Playing = true
local FlashAtt = Instance.new("Attachment",GunFlash)
local FlashOrigin = Instance.new("Attachment",GunBase.Handle)
FlashOrigin.CFrame = CFrame.new(0,0,-4.3) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local AlignFlash = Instance.new("AlignPosition",GunFlash)
AlignFlash.Attachment0 = FlashAtt
AlignFlash.Attachment1 = AttachmentLeftArm
AlignFlash.Responsiveness = 9e9
local fire = Instance.new("Fire",FlashOrigin)
FlashOrigin.Orientation = Vector3.new(-90,0,0)
fire.Enabled = false
fire.Size = 8
fire.Heat = 25
local Outline = Instance.new("SelectionBox", GunFlash)
Outline.Adornee = GunFlash
Outline.LineThickness = 0.1
Outline.Color3 = Color3.new(0, 0.0313725, 1)
GunFlash.Transparency = 1
local Sound = Instance.new("Sound")
Sound.Parent = char["Left Arm"]
Sound.Looped =true
Sound.Volume = 0.6
Sound.SoundId = "rbxassetid://260131485"
Mouse.Button1Down:Connect(function()
	MouseDown = true
	Sound:Play()
end)
Mouse.Button1Up:Connect(function()
	MouseDown = false
	Sound:Stop()
end)
local BodyThurst  =Instance.new("BodyThrust",GunFlash)
BodyThurst.Force = Vector3.new(999,999,999)
BodyThurst.Location = GunFlash.Position

RN.Heartbeat:Connect(function()
	if MouseDown then
		AlignFlash.Attachment1 = FlashOrigin
		fire.Enabled = true
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 5
		RN.Heartbeat:Wait()
		fire.Enabled = false
		AlignFlash.Attachment1 = AttachmentLeftArm
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
	end
end)
local Backpack = char:FindFirstChild("SeeMonkey")
local Bckatt = Instance.new("Attachment",Backpack.Handle)
local BckOrigin = Instance.new("Attachment",char["Torso"])
BckOrigin.CFrame =  CFrame.new(0,0,1) *CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
BckOrigin.Orientation = Vector3.new(90,0,0)
local AlignBack = Instance.new("AlignPosition",Backpack["Handle"])
AlignBack.Attachment0 = Bckatt
AlignBack.Attachment1 = BckOrigin
AlignBack.Responsiveness = 9e9
local AlignBack2 = Instance.new("AlignOrientation",Backpack["Handle"])
AlignBack2.Attachment0 = Bckatt
AlignBack2.Attachment1 = BckOrigin
AlignBack2.Responsiveness = 9e9
Backpack.Handle:BreakJoints()
DestroyMesh(Backpack)
local chararm = LeftArmReplacment
local ArmAttachment = Instance.new("Attachment",chararm.Handle)
ArmAttachment.Orientation = Vector3.new(-20,20,0)
local ArmOrigin = Instance.new("Part",char)
ArmOrigin.Size = Vector3.new(1,1,2)
ArmOrigin.Transparency = 1
ArmOrigin.CanCollide = false
local ArmOriAtt = Instance.new("Attachment",ArmOrigin)
chararm.Handle:BreakJoints()
DestroyMesh(chararm)
wait(0.1)
local weld = Instance.new("Weld",ArmOrigin)
weld.Part0 = ArmOrigin
weld.Part1 = char["HumanoidRootPart"]
weld.C0 = CFrame.new(-0.6,0.4,4.2) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local Alignarm = Instance.new("AlignPosition",chararm.Handle)
Alignarm.Attachment0 = ArmAttachment
Alignarm.Attachment1 = ArmOriAtt
Alignarm.Responsiveness = 9e9
local Alignarm2 = Instance.new("AlignOrientation",chararm.Handle)
Alignarm2.Attachment0 = ArmAttachment
Alignarm2.Attachment1 = ArmOriAtt
Alignarm2.Responsiveness = 9e9

local UserInput = game:GetService("UserInputService")

UserInput.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.Z
	then
		if FlameThrower == false then
			wait(0.2)
			CCreateSFX("rbxassetid://1336756135",false,true,5)
			wait(2.089)
			CCreateSFX("rbxassetid://2674547670",false,true,7)
			CCreatePart(Vector3.new(10,10,10),Color3.new(1, 0.666667, 0),0,"Ball",true)
			CCreatePart(Vector3.new(15,15,15),Color3.new(1, 1, 1),0,"Ball",true)
			CCreateSFX("rbxassetid://5801257793",false,true,7)
			BossnameConfig("Eruption",Color3.new(1, 0.333333, 0),Color3.new(1, 0.666667, 0))
			BossMusic.SoundId = "rbxassetid://1842544495"
			FlameThrower = true
			VolcanoThrower = false
			Eruption = false
			Meltdown = false
		else
			CCreateSFX("rbxassetid://3779045779",false,true,1)

		end
	end
end)
UserInput.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.C
	then
		if Eruption == false then
			wait(0.2)
			CCreateSFX("rbxassetid://1336756135",false,true,5)
			wait(2.089)
			CCreateSFX("rbxassetid://2674547670",false,true,7)
			CCreatePart(Vector3.new(10,10,10),Color3.new(1, 0.666667, 0),0,"Ball",true)
			CCreatePart(Vector3.new(15,15,15),Color3.new(1, 1, 1),0,"Ball",true)
			CCreateSFX("rbxassetid://5801257793",false,true,7)
			BossnameConfig("Eruption",Color3.new(0.454902, 0.152941, 0),Color3.new(1, 0.333333, 0))
			BossMusic.SoundId = "rbxassetid://1837727559"
			FlameThrower = false
			VolcanoThrower = false
			Eruption = true
			Meltdown = false
		else
			CCreateSFX("rbxassetid://3779045779",false,true,1) --rbxassetid://3779045779

		end
	end
end)
UserInput.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.X
	then
		if VolcanoThrower == false then
			wait(0.2)
			CCreateSFX("rbxassetid://1336756135",false,true,5)
			wait(2.089)
			CCreateSFX("rbxassetid://2674547670",false,true,7)
			CCreatePart(Vector3.new(15,15,15),Color3.new(1, 0, 0),0,"Ball",true)
			CCreatePart(Vector3.new(25,25,25),Color3.new(1, 1, 1),0,"Ball",true)
			CCreateSFX("rbxassetid://5801257793",false,true,10)
			BossnameConfig("Volcano Thrower",Color3.new(1, 0, 0),Color3.new(0.290196, 0, 0))
			BossMusic.SoundId = "rbxassetid://1842543723"
			FlameThrower = false
			VolcanoThrower = true
			Eruption = false
			Meltdown = false
		else
			CCreateSFX("rbxassetid://3779045779",false,true,1)

		end
	end
end)
UserInput.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.V
	then
		if Meltdown == false then
			wait(0.5)
			CCreateSFX("rbxassetid://1336756135",false,true,5)
			wait(2.089)
			CCreateSFX("rbxassetid://2674547670",false,true,7)
			CCreatePart(Vector3.new(15,15,15),Color3.new(1, 0, 0),0,"Ball",true)
			CCreatePart(Vector3.new(25,25,25),Color3.new(1, 1, 1),0,"Ball",true)
			CCreateSFX("rbxassetid://5801257793",false,true,10)
			wait(0.5)
			CCreateSFX("rbxassetid://1767358533",false,true,10)
			CCreateSFX("rbxassetid://1899274315",false,true,6)
			CCreatePart(Vector3.new(100,100,100),Color3.new(1, 0, 0),0,"Ball",true,CFrame.new(0,80,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),5)
			CCreateSFX("rbxassetid://4795879649",false,true,10)
			wait()
			CCreateSFX("rbxassetid://243702774",false,true,5)
			BossnameConfig("MELTDOWN",Color3.new(0.254902, 0, 0),Color3.new(1, 0, 0))
			BossMusic.SoundId = "rbxassetid://1837294017"
			FlameThrower = false
			VolcanoThrower = false
			Eruption = false
			Meltdown = true
		else
			CCreateSFX("rbxassetid://3779045779",false,true,1)

		end
	end
end)
local FlameAttleft = Instance.new("Attachment",Backpack.Handle)
local FlameAttRight = Instance.new("Attachment",Backpack.Handle)
local Fire = Instance.new("Fire",FlameAttleft)
local Fire2 = Instance.new("Fire",FlameAttRight)
FlameAttleft.CFrame = CFrame.new(1,0,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
FlameAttRight.CFrame = CFrame.new(-1,0,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
FlameAttleft.Orientation = Vector3.new(90,0,0)
FlameAttRight.Orientation = Vector3.new(90,0,0)
Fire.Enabled = false
Fire2.Enabled = false
Fire.Size = 5
Fire2.Size = 5
Fire2.Heat = 24
Fire.Heat = 24
local LeftLegJoint = char:FindFirstChild("Torso")["Left Hip"]
local RightLegJoint = char:FindFirstChild("Torso")["Right Hip"]
local VolcanoLeftLeg = Instance.new("Part",char)
VolcanoLeftLeg.Size = Vector3.new(1,2,1)
VolcanoLeftLeg.CanCollide = false
VolcanoLeftLeg.Transparency = 1
local VolcanoRightLeg = Instance.new("Part",char)
VolcanoRightLeg.Size = Vector3.new(1,2,1)
VolcanoRightLeg.CanCollide = false
VolcanoRightLeg.Transparency = 1
local LeftLegAttachment = Instance.new("Attachment",char:FindFirstChild("Left Leg"))
local RightLegAttachment = Instance.new("Attachment",char:FindFirstChild("Right Leg"))
local Leg1Origin = Instance.new("Attachment",VolcanoLeftLeg)
local Leg2Origin = Instance.new("Attachment",VolcanoRightLeg)
local Volcanoleftweld = Instance.new("Weld",VolcanoLeftLeg)
Volcanoleftweld.Part0 = VolcanoLeftLeg
Volcanoleftweld.Part1 = char:FindFirstChild("Torso")
Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local Volcanorightweld = Instance.new("Weld",VolcanoRightLeg)
Volcanorightweld.Part0 = VolcanoRightLeg
Volcanorightweld.Part1 = char:FindFirstChild("Torso")
Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local Alignleg1 = Instance.new("AlignPosition",char:FindFirstChild("Left Leg"))
Alignleg1.Attachment0 = LeftLegAttachment
Alignleg1.Attachment1 = Leg1Origin
Alignleg1.Enabled = false
Alignleg1.Responsiveness = 9e9
local  Alignleg2 = Instance.new("AlignOrientation",char:FindFirstChild("Left Leg"))
Alignleg2.Attachment0 = LeftLegAttachment
Alignleg2.Attachment1 = Leg1Origin
Alignleg2.Responsiveness = 9e9
Alignleg2.Enabled = false
local Alignleg3 = Instance.new("AlignPosition",char:FindFirstChild("Right Leg"))
Alignleg3.Attachment0 = RightLegAttachment
Alignleg3.Attachment1 = Leg2Origin
Alignleg3.Responsiveness = 9e9
Alignleg3.Enabled = false
local Alignleg4 = Instance.new("AlignOrientation",char:FindFirstChild("Right Leg"))
Alignleg4.Attachment0 = RightLegAttachment
Alignleg4.Attachment1 = Leg2Origin
Alignleg4.Responsiveness = 9e9
Alignleg4.Enabled = false
Alignleg1.Enabled = true
Alignleg2.Enabled = true
Alignleg3.Enabled = true
Alignleg4.Enabled = true
char:FindFirstChild("Left Leg"):BreakJoints()
char:FindFirstChild("Right Leg"):BreakJoints()
game:GetService("RunService").Heartbeat:Connect(function()
	if VolcanoThrower then
		CurrentMode = "VolcanoThrower"
		Fire.Enabled = true
		Fire2.Enabled = true
		char:FindFirstChild("Animate").Enabled = false
		char:FindFirstChildOfClass("Humanoid").HipHeight = 12
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 25
		Volcanoleftweld.C0 = CFrame.new(0.5,2.2,0.5) *CFrame.Angles(math.rad(30),math.rad(0),math.rad(0))
		Volcanorightweld.C0 = CFrame.new(-0.5,2.1,0.5) *CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))
		char:FindFirstChildOfClass("Humanoid").HipHeight = 12
		wait(0.1)
		char:FindFirstChildOfClass("Humanoid").HipHeight = 11.9
		RN.Heartbeat:Wait()
		Fire.Enabled = false
		Fire2.Enabled = false
		char:FindFirstChildOfClass("Humanoid").HipHeight = 0
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	end
	if FlameThrower then
		BossName.Text = "FlameThrower"
	end
end)
local humanoid = char:FindFirstChildOfClass("Humanoid")
RN.Heartbeat:Connect(function()
	if Walking and FlameThrower then
		Volcanorightweld.C0 = CFrame.new(-0.5,2,-0.2) *CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0.2) *CFrame.Angles(math.rad(-20),math.rad(0),math.rad(0))
		wait(1)
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0.2) *CFrame.Angles(math.rad(-20),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,-0.2) *CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))
		RN.Heartbeat:Wait()
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	end
	if Walking and VolcanoThrower then
		Volcanoleftweld.C0 = CFrame.new(0.5,2.2,-0.2) *CFrame.Angles(math.rad(30),math.rad(0),math.rad(0))
		Volcanorightweld.C0 = CFrame.new(-0.5,2.1,0.2) *CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))
		wait(1)
		Volcanoleftweld.C0 = CFrame.new(0.5,2.2,0.2) *CFrame.Angles(math.rad(30),math.rad(0),math.rad(0))
		Volcanorightweld.C0 = CFrame.new(-0.5,2.1,-0.2) *CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))
	end

end)
local function MovCheck(speed)
	if speed < 0 then
		Walking = true
	else
		Walking = false
	end
end
local BeamPart = Instance.new("Part",workspace)
BeamPart.CanCollide = false
BeamPart.Anchored = true
BeamPart.Color = Color3.new(1, 0.333333, 0)
BeamPart.Size = Vector3.new(1, 1, 1)
BeamPart.Material = Enum.Material.Neon
humanoid.Running:Connect(MovCheck)
RN.Heartbeat:Connect(function()
	if  VolcanoThrower then
		BossName.Rotation = 20
		wait(0.1)
		BossName.Rotation = 40
		wait(0.1)
		BossName.Rotation = 20
		wait(0.1)
		BossName.Rotation = 40
		CCreatePart(Vector3.new(1.5,1.5,1.5),Color3.new(1, 0, 0),0,"Ball",true)
		CCreatePart(Vector3.new(0.5,0.5,0.5),Color3.new(0.4, 0, 0),0,"Block",true)
		RN.Heartbeat:Wait()
		BossName.Rotation = 0
	end
end)
char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
	BossMusic:Destroy()
end)
local MouseDown = false
Mouse.Button1Down:Connect(function()
	MouseDown = true

end)
Mouse.Button1Up:Connect(function()
	MouseDown = false
end)
local BeamSFX = Instance.new("Sound",workspace)
BeamSFX.SoundId = "rbxassetid://319804747"
BeamSFX.Volume = 1
BeamSFX.PlaybackSpeed = 1
BeamSFX.Looped = true
local Beam = Instance.new("Beam",BarrelOrigin)
local beamatt1 = Instance.new("Attachment",Beam.Parent)
beamatt1.CFrame = CFrame.new(0,0,3) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local BeamOrigin = Instance.new("Attachment",char["Torso"])
Beam.Attachment0 = beamatt1
Beam.Attachment1 = beamatt1
Beam.Color = ColorSequence.new(Color3.new(1, 0, 0))
Beam.Transparency = NumberSequence.new(0.2)
Beam.Brightness = 9e9
BeamOrigin.Parent = BeamPart
RN.Heartbeat:Connect(function()
	if VolcanoThrower and MouseDown then
		BeamPart.Position = Mouse.hit.Position
		Beam.Attachment1 = BeamOrigin
		BeamSFX.Playing = true
		char.HumanoidRootPart.Anchored = true
		char.HumanoidRootPart.CFrame = CFrame.lookAt(char.HumanoidRootPart.Position, Mouse.Hit.Position)
		RN.Heartbeat:Wait()
		BeamPart:Destroy()
		Beam.Attachment1 = beamatt1
		BeamSFX.Playing = false
		char.HumanoidRootPart.Anchored = false

	end
end)
RN.Heartbeat:Connect(function()
	if Eruption then
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(15),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(-15),math.rad(0),math.rad(0))
		BossName.Text = "Eruption"
		CurrentMode = "Eruption"
		CCreatePart(Vector3.new(5,1,5),Color3.new(1, 0.333333, 0),0,"Block",true,CFrame.new(0,-3,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 8
	end
end)
RN.Heartbeat:Connect(function()
	if FlameThrower then
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		BossName.Text = "FlameThrower"
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
		CurrentMode = "FlameThrower"
	end
end)
RN.Heartbeat:Connect(function()
	if Meltdown then
		Volcanorightweld.C0 = CFrame.new(-0.5,2,0) *CFrame.Angles(math.rad(5),math.rad(30),math.rad(0))
		Volcanoleftweld.C0 = CFrame.new(0.5,2,0) *CFrame.Angles(math.rad(-5),math.rad(30),math.rad(0))


		char:FindFirstChildOfClass("Humanoid").WalkSpeed = 17
		char:FindFirstChildOfClass("Humanoid").HipHeight = 4
		CCreatePart(Vector3.new(15,1,15),Color3.new(1, 0, 0),0,"Block",true,CFrame.new(0,-7,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		wait(0.1)
		CCreatePart(Vector3.new(25,1,25),Color3.new(0.184314, 0, 0),0.5,"Block",true,CFrame.new(0,-7,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
		CurrentMode = "MELTDOWN"
		while Meltdown == true do
			BossName.Text = "MELTDOWN"
			BossName.Rotation = 20
			wait(0.3)
			BossName.Text = "?M7LET24DONW??"
			wait(0.3)
			BossName.Rotation = -10
		end
		RN.Heartbeat:Wait()
		wait(2)
		BossName.Rotation = 0
		BossName.Text = CurrentMode
	end
end)
