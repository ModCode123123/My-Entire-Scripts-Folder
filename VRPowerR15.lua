for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,35,0)
			wait(0.5)
		end)
	end
end
local UIS = game:GetService("UserInputService")
local Plr = game:GetService("Players").LocalPlayer
local char = Plr.Character
local cam = game:GetService("Workspace").CurrentCamera
local hum = char:FindFirstChildOfClass("Humanoid")
local LeftHandR15 = char:FindFirstChild("LeftHand")
local RightHandR15 = char:FindFirstChild("RightHand")
local HeadR15 = char:FindFirstChild("Head")

local LeftHandOrigin = Instance.new("Part")
LeftHandOrigin.Parent = char
LeftHandOrigin.Size = Vector3.new(0.001,0.001,0.001)
LeftHandOrigin.Transparency = 1
LeftHandOrigin.CanCollide = false
LeftHandOrigin.Anchored = true
local RightHandOrigin = Instance.new("Part")
RightHandOrigin.Parent = char
RightHandOrigin.Size = Vector3.new(0.001,0.001,0.001)
RightHandOrigin.Transparency = 1
RightHandOrigin.CanCollide = false
RightHandOrigin.Anchored = true
RightHandR15.Parent = workspace
LeftHandR15.Parent = workspace
local AttachmentA = Instance.new("Attachment")
AttachmentA.Parent = LeftHandR15
local AttachmentB = Instance.new("Attachment")
AttachmentB.Parent = LeftHandOrigin
local AttachmentC = Instance.new("Attachment")
AttachmentC.Parent = RightHandR15
local AttachmentD = Instance.new("Attachment")
AttachmentB.Parent = RightHandOrigin

local AlignPositionLeft = Instance.new("AlignPosition")
AlignPositionLeft.Parent = LeftHandR15
AlignPositionLeft.Attachment0 = AttachmentA
AlignPositionLeft.Attachment1 = AttachmentB
AlignPositionLeft.Responsiveness = 50
local AlignOrientationLeft = Instance.new("AlignOrientation")
AlignOrientationLeft.Parent = LeftHandR15
AlignOrientationLeft.Attachment0 = AttachmentA
AlignOrientationLeft.Attachment1 = AttachmentB
AlignOrientationLeft.Responsiveness = 50
local AlignPositionRight = Instance.new("AlignPosition")
AlignPositionRight.Parent = RightHandR15
AlignPositionRight.Attachment0 = AttachmentC
AlignPositionRight.Attachment1 = AttachmentD
AlignPositionRight.Responsiveness = 50
local AlignOrientationRight = Instance.new("AlignOrientation")
AlignOrientationRight.Parent = RightHandR15
AlignOrientationRight.Attachment0 = AttachmentC
AlignOrientationRight.Attachment1 = AttachmentD
AlignOrientationRight.Responsiveness = 50
local Highlight = Instance.new("Highlight")
Highlight.Parent = LeftHandR15
Highlight.FillTransparency = 1
Highlight.OutlineColor = Color3.new(1, 1, 1)
local Highlight2 = Instance.new("Highlight")
Highlight2.Parent = RightHandR15
Highlight2.FillTransparency = 1
Highlight2.OutlineColor = Color3.new(1,1,1)
RightHandR15:BreakJoints()
LeftHandR15:BreakJoints()
local HeadOrigin = Instance.new("Part")
HeadOrigin.Parent = char
HeadOrigin.Size = Vector3.new(0.1,0.1,0.1)
HeadOrigin.Transparency = 1
HeadOrigin.CanCollide = false
HeadOrigin.Anchored = true
local AttachmentE = Instance.new("Attachment")
AttachmentE.Parent = HeadOrigin
UIS.UserCFrameChanged:Connect(function(part,move)
	if part == Enum.UserCFrame.LeftHand then
		LeftHandOrigin.CFrame = cam.CFrame * move else
		if part == Enum.UserCFrame.RightHand then
			RightHandOrigin.CFrame = cam.CFrame * move else
			if part == Enum.UserCFrame.Head then
				HeadOrigin.CFrame = cam.CFrame * move
			end
		end
	end
end)

local Viewport = game:GetObjects("rbxassetid://11474062379")[1]

local AlignViewPortOri = Viewport:FindFirstChild("AO")
local AlignViewPortPos = Viewport:FindFirstChild("AP")

AlignViewPortOri.Attachment1 = AttachmentE
AlignViewPortPos.Attachment1 = AttachmentE

UIS.UserCFrameChanged:Connect(function(part,move)
	if part == Enum.UserCFrame.Head then
	local health = Viewport:FindFirstChild("GUI").health
		local walkspeed = Viewport:FindFirstChild("GUI").walkspeed	
		
		health.Text = hum.Health
		walkspeed.Text = hum.WalkSpeed
	end
end)