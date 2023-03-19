--[[
  _____  ________      ________ _      ____  _____  ______ _____    _____  ______ ____  _    _  _____ 
 |  __ \|  ____\ \    / /  ____| |    / __ \|  __ \|  ____|  __ \  |  __ \|  ____|  _ \| |  | |/ ____|
 | |  | | |__   \ \  / /| |__  | |   | |  | | |__) | |__  | |__) | | |  | | |__  | |_) | |  | | |  __ 
 | |  | |  __|   \ \/ / |  __| | |   | |  | |  ___/|  __| |  _  /  | |  | |  __| |  _ <| |  | | | |_ |
 | |__| | |____   \  /  | |____| |___| |__| | |    | |____| | \ \  | |__| | |____| |_) | |__| | |__| |
 |_____/|______|   \/   |______|______\____/|_|    |______|_|  \_\ |_____/|______|____/ \____/ \_____|
                                                                                                     
🚧DEVELOPER DEBUG VER🚧
]]

local Options = {}


Options.LeftHandHat = "Pal Hair"
Options.RightHandHat = "LavanderHair"
Options.TorsoHat = "SeeMonkey"
Options.HeadHat = "MeshPartAccessory"

Options.HammerHat1 = "Kate Hair"
Options.HammerHat2 = "Hat1"
Options.HammerHat3 = "Robloxclassicred"
Options.HammerHitPart = "WolfTail"



Options.Headscale = 2
Options.NetlessVelocity = Vector3.new(0,30,0)

Options.righthandrotoffset = Vector3.new(-180,0,0)
Options.lefthandrotoffset = Vector3.new(0,0,0)

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Options.NetlessVelocity
		end)
	end
end
wait(2)


local input = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

local function Error()
	local sound = Instance.new("Sound",workspace)
	sound.SoundId = "rbxassetid://2323663829"
	sound.Volume = 5
end
local function RemoveMesh(hat)
	hat.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	hat.Handle:BreakJoints()
end
local function DoMath(rotx,roty,rotz)
	local cframe = CFrame.Angles(math.rad(rotx),math.rad(roty),math.rad(rotz))
	return cframe
end


local lefthand = char:FindFirstChild(Options.LeftHandHat)
local righthand = char:FindFirstChild(Options.RightHandHat)
local torso = char:FindFirstChild(Options.TorsoHat)
local head = char:FindFirstChild(Options.HeadHat)
local HammerHandle1 = char:FindFirstChild(Options.HammerHat1).Handle
local HammerHandle2 = char:FindFirstChild(Options.HammerHat2).Handle
local HammerHandle3 = char:FindFirstChild(Options.HammerHat3).Handle
local HammerHitPart = char:FindFirstChild(Options.HammerHitPart).Handle

RemoveMesh(HammerHandle1.Parent)
RemoveMesh(HammerHandle2.Parent)
RemoveMesh(HammerHandle3.Parent)
RemoveMesh(HammerHitPart.Parent)



if lefthand then
	RemoveMesh(lefthand)
else
	Error()
	Error("LeftHand Missing!")	
end
if righthand then
	RemoveMesh(righthand)
else
	Error()
	error("RightHand Missing!")
end
if torso then
	RemoveMesh(torso)
else
	Error()
	error("Torso Missing!")
end
if head then
	RemoveMesh(head)
else
	Error()
	error("Head Missing!")
end
char:FindFirstChildOfClass("Humanoid").RootPart.Anchored = true
local function Track(Type, Value)
	if Type == Enum.UserCFrame.RightHand then
		righthand.Handle.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
		HammerHandle1.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) *CFrame.new(0,-1.6,-1)
		HammerHandle2.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) *CFrame.new(0,-1.6,-2)
		HammerHandle3.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) *CFrame.new(0,-1.6,-3)
		HammerHitPart.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *CFrame.new(0,4,-1.6)
	end
	if Type == Enum.UserCFrame.LeftHand then
		lefthand.Handle.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,math.pi)
	end
	if Type == Enum.UserCFrame.Head then
		head.Handle.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) --*CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
		torso.Handle.CFrame = camera.CoordinateFrame * (CFrame.new(Value.p*(camera.HeadScale-1))*Value) *CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) * CFrame.new(0,0,-2.5)
	end
end
input.UserCFrameChanged:Connect(Track)
camera.CameraType = "Scriptable"
camera.HeadScale = Options.Headscale
camera.CFrame = char.HumanoidRootPart.CFrame
local R1down =false
input.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		if key.Position.Z > 0.9 then
			R1down = true
		else
			R1down = false
		end
	end
end)

input.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = true
	end
end)

input.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = false
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if R1down then
		camera.CFrame = camera.CFrame:Lerp(camera.CoordinateFrame + (lefthand.Handle.CFrame*CFrame.Angles(-math.rad(Options.righthandrotoffset.X),-math.rad(Options.righthandrotoffset.Y),math.rad(180-Options.righthandrotoffset.X))).LookVector * camera.HeadScale/2, 0.5)
	end
end)
game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)

local rightleg = char:FindFirstChild("Right Leg")
local att0leg = Instance.new("Attachment",rightleg)
local att1hammer = Instance.new("Attachment",HammerHitPart)

att0leg.CFrame = CFrame.new(0,0,1)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
local bodythrust = Instance.new("BodyThrust",rightleg)
bodythrust.Force = Vector3.new(999,0,999)
bodythrust.Location = rightleg.Position
local alignpos = Instance.new("AlignPosition",rightleg)
alignpos.Attachment0 = att0leg
alignpos.Attachment1 = att1hammer
alignpos.Responsiveness = math.huge
alignpos.MaxVelocity = math.huge
alignpos.MaxForce = math.huge
rightleg:BreakJoints()
local highlight = Instance.new("Highlight",rightleg)
highlight.Adornee = rightleg
highlight.FillTransparency = 0.5
highlight.OutlineColor= Color3.new(1,1,1)


x = 0

while true do

	highlight.FillColor = Color3.fromHSV(x,1,1)
	x = x + 1/255
	if x >= 1 then
		x = 0
	end
	wait()
end
