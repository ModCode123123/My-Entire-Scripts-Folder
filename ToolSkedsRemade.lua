for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(0,30,0)
		end)
	end
end
wait()


local FE_Enabled = true


local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local lefthand = char:FindFirstChild("Pal Hair")
local righthand = char:FindFirstChild("LavanderHair")
local head = char:FindFirstChild("MediHood")
char.PrimaryPart.Anchored = true
local function Maketool(hat,name)
	local Tool = Instance.new("Tool",char)
	local Handle
	if FE_Enabled == true then
		Handle = Instance.new("Part",Tool)
		Handle.Size = hat.Handle.Size
		Handle.Transparency = 1
		Handle.Anchored = false
		Handle.CanCollide = false
		Handle.Name = "Handle"
		hat.Handle:BreakJoints()
		head.Handle.Transparency= 1
	else
		Handle = hat.Handle
		Handle:BreakJoints()
		Handle.Parent = Tool
	end
	Tool.Name = name
	return Tool
end
local function Demesh(hat)
	hat.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
end
if lefthand and righthand then
	Demesh(lefthand) Demesh(righthand)
end
local Bob = Maketool(lefthand,"Bob")
local Bob2 = Maketool(righthand,"Bob2")
local Joe = Maketool(head,"Joe")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local cam = workspace.CurrentCamera

local L1Use = false
local R1Use= false
cam.HeadScale = 3
cam.CameraType = "Scriptable"
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL1 then
		L1Use = true
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode== Enum.KeyCode.ButtonL1 then
		L1Use = false
	end
end)
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1Use = true
	end
end)
UserInputService.InputEnded:Connect(function(key)
	if key.KeyCode== Enum.KeyCode.ButtonR1 then
		R1Use = false
	end
end)
--head.Handle.Transparency = 1
local options = {}
options.righthandrotoffset = Vector3.new(180,0,0)
local backpack = plr.Backpack
if FE_Enabled == true then

	UserInputService.UserCFrameChanged:connect(function(part,move)
		if part == Enum.UserCFrame.Head then
			--move(head,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move)):inverse()
			Joe.Parent = backpack
			Joe.Grip = cf
			Joe.Parent = char
			head.Handle.CFrame = Joe.Handle.CFrame
		elseif part == Enum.UserCFrame.LeftHand then
			--move(handL,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))):inverse()
			Bob.Parent = backpack
			Bob.Grip = cf
			Bob.Parent = char
			lefthand.Handle.CFrame = Bob.Handle.CFrame
		elseif part == Enum.UserCFrame.RightHand then
			--move(handR,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))):inverse()
			Bob2.Parent = backpack
			Bob2.Grip = cf
			Bob2.Parent = char
			righthand.Handle.CFrame = Bob2.Handle.CFrame
		end
	end)
else
	UserInputService.UserCFrameChanged:connect(function(part,move)
		if part == Enum.UserCFrame.Head then
			--move(head,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move)):inverse()
			Joe.Parent = backpack
			Joe.Grip = cf
			Joe.Parent = char
		elseif part == Enum.UserCFrame.LeftHand then
			--move(handL,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))):inverse()
			Bob.Parent = backpack
			Bob.Grip = cf
			Bob.Parent = char
		elseif part == Enum.UserCFrame.RightHand then
			--move(handR,cam.CFrame*move)
			local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightLowerArm")
			local armcframe = rArm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
			local cf = armcframe:toObjectSpace(cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))):inverse()
			Bob2.Parent = backpack
			Bob2.Grip = cf
			Bob2.Parent = char
		end
	end)
end


game:GetService("RunService").RenderStepped:connect(function()
	if R1Use then
		cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (Bob2.Handle.CFrame*CFrame.Angles(-math.rad(options.righthandrotoffset.X),-math.rad(options.righthandrotoffset.Y),math.rad(180-options.righthandrotoffset.X))).LookVector * cam.HeadScale/2, 0.5)
	end
end)
game:GetService("RunService").RenderStepped:connect(function()
	if L1Use then
		cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (Bob.Handle.CFrame*CFrame.Angles(-math.rad(options.righthandrotoffset.X),-math.rad(options.righthandrotoffset.Y),math.rad(180-options.righthandrotoffset.X))).LookVector * cam.HeadScale/2, 0.5)
	end
end)