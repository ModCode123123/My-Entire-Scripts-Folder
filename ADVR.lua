--[[
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░  ░░░░░░░░      ░░░░░        ░░░░░         ░    ░░░░░   ░░░░░░░  ░░░░░░░░   ░░░░░░░░   ░    ░░░░░   ░         ░░░░░░░   ░░░░░░░░░   ░        ░░░░
▒▒▒▒▒▒  ▒  ▒▒▒▒▒▒   ▒▒▒   ▒▒   ▒▒▒▒   ▒▒▒   ▒▒▒▒▒▒▒  ▒   ▒▒▒   ▒▒▒▒▒▒  ▒  ▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒  ▒   ▒▒▒   ▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒   ▒▒   ▒▒▒▒   ▒▒
▒▒▒▒▒  ▒▒   ▒▒▒▒▒   ▒▒▒▒   ▒   ▒▒▒▒   ▒▒▒   ▒▒▒▒▒▒▒   ▒   ▒▒   ▒▒▒▒▒  ▒▒   ▒▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒   ▒   ▒▒   ▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒   ▒▒▒▒   ▒▒
▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓▓▓   ▓  ▓   ▓▓▓▓▓▓▓       ▓▓▓   ▓▓   ▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓▓▓▓▓▓▓   ▓   ▓▓   ▓   ▓       ▓▓▓▓▓▓▓▓▓▓▓▓   ▓▓▓   ▓▓▓▓  ▓   ▓▓▓▓▓▓
▓▓▓       ▓   ▓▓▓   ▓▓▓▓   ▓   ▓▓   ▓▓▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓  ▓   ▓▓▓       ▓   ▓▓▓   ▓▓▓▓▓▓▓▓   ▓   ▓▓▓  ▓   ▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ▓   ▓▓▓▓▓   ▓▓   ▓▓▓▓
▓▓   ▓▓▓▓▓▓▓   ▓▓   ▓▓▓   ▓▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓▓  ▓  ▓▓   ▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓▓▓▓   ▓   ▓▓▓▓  ▓  ▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓     ▓▓▓▓▓▓   ▓▓▓▓   ▓▓
█   █████████   █      █████   ██████   █         █   ██████   █   █████████   █          █   █   ██████   █         █████████████   ███████   ██████   
████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

--]]

game["Run Service"].RenderStepped:connect(function()
	settings().Physics.AllowSleep = false
	setsimulationradius(math.huge*math.huge,math.huge*math.huge)
end)








--settings

local AnchorRoot = true --vr wont work with gunmode enabled with this
local ChatGUI = false
local ViewPort = false
local HatVR = false
local UsePlayerCharacter = true

local GunMode = false
local HeadScale = 1
local ForceBubbleChat = true

local HighLightedControllerModels = true
local HighLightedControllerColour = "Blue" --colours Orange,Blue.Purple,White

--if you have HATVR enabled Make sure you have these items

local LeftArm = "Pal Hair"
local RightArm = "LavanderHair"
local Head = "MediHood"
local Gun = "Meshes/CRL4Accessory"
--get the gun here https://www.roblox.com/catalog/7806887000/CR-L-4-Back	
--now the script
	
game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)	

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local cam = workspace.CurrentCamera


local uis = game:GetService("UserInputService")
local VRSV = game:GetService("VRService")
local plrleftarm = plr.Character:WaitForChild("Left Arm")
local plrrightarm =plr.Character:WaitForChild("Right Arm")
local plrhead = plr.Character:WaitForChild("Head")

wait(2)
plrleftarm.Anchored = true
plrrightarm.Anchored = true
local LeftControllerPart = Instance.new("Part")
LeftControllerPart.Parent = plr.Character.Parent
LeftControllerPart.Anchored = true
LeftControllerPart.CanCollide = false
LeftControllerPart.Size = Vector3.new(0.5,0.5,1)
LeftControllerPart.Transparency = 1
local RightControllerPart = Instance.new("Part")
RightControllerPart.Parent = plr.Character.Parent
RightControllerPart.Anchored = true
RightControllerPart.CanCollide = false
RightControllerPart.Size = Vector3.new(0.5,0.5,1)
RightControllerPart.Transparency = 1
local LeftHighLight = Instance.new("SelectionBox")
LeftHighLight.Parent = LeftControllerPart
LeftHighLight.Adornee = LeftControllerPart
LeftHighLight.LineThickness = 0.01
local RightHighLight = Instance.new("SelectionBox")
RightHighLight.Parent = RightControllerPart
RightHighLight.Adornee = RightControllerPart
RightHighLight.LineThickness = 0.01

	
	
	
char.Humanoid.AnimationPlayed:connect(function(anim)
	anim:Stop()
end)

for i,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
	v:AdjustSpeed(0)
end

plrleftarm.Parent = game.Workspace
plrrightarm.Parent = game.Workspace



plrleftarm.Anchored = true
plrrightarm.Anchored = true
plr.Character.Torso["Left Shoulder"]:Destroy()
plr.Character.Torso["Right Shoulder"]:Destroy()

uis.UserCFrameChanged:Connect(function(part,move)
	if part == Enum.UserCFrame.LeftHand then
		LeftControllerPart.CFrame = cam.CFrame * move else
		if part == Enum.UserCFrame.RightHand then
			RightControllerPart.CFrame = cam.CFrame * move
		end
	end
end)
plrleftarm.Size = Vector3.new(0.5,0.5,1)
plrrightarm.Size = Vector3.new(0.5,0.5,1)
wait(1)
local attachment = Instance.new("Attachment")
attachment.Parent = LeftControllerPart
attachment.WorldPosition = LeftControllerPart.Position

local attachemnt2 = Instance.new("Attachment")
attachemnt2.Parent = RightControllerPart
attachemnt2.WorldPosition = RightControllerPart.Position

local attachment3 = Instance.new("Attachment")
attachment3.Parent = plrleftarm
attachment3.WorldPosition = plrleftarm.Position

local attachemnt4 = Instance.new("Attachment")
attachemnt4.Parent = plrrightarm
attachemnt4.WorldPosition = plrrightarm.Position

local AliginPosition1 = Instance.new("AlignPosition")
AliginPosition1.Parent = plrleftarm
AliginPosition1.Attachment0 = attachment3
AliginPosition1.Attachment1 = attachment


local AliginPosition2 = Instance.new("AlignPosition")
AliginPosition2.Parent = plrrightarm
AliginPosition2.Attachment0 = attachemnt4
AliginPosition2.Attachment1 = attachemnt2

local AliginOrientation1 = Instance.new("AlignOrientation")
AliginOrientation1.Parent = plrleftarm
AliginOrientation1.Attachment0 = attachment3
AliginOrientation1.Attachment1 = attachment


local AliginOrientation2 = Instance.new("AlignOrientation")
AliginOrientation2.Parent = plrrightarm
AliginOrientation2.Attachment0 = attachemnt4
AliginOrientation2.Attachment1 = attachemnt2

AliginPosition1.Responsiveness = 50
AliginPosition2.Responsiveness = 50
AliginOrientation1.Responsiveness = 50
AliginOrientation2.Responsiveness = 50



plrleftarm.Anchored = false
plrrightarm.Anchored = false 

while true do
	wait(1)
    plrleftarm.Position = LeftControllerPart.Position
	plrrightarm.Position = RightControllerPart.Position
	wait()
	
end