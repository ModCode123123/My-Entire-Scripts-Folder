





local ScriptEndButton = Enum.KeyCode.End
local ReanimateTransparency = 1  --The transparency of the hats Reanimated
local VirtualRigTransparency = 0
local UseLeftOvers = true --Uses leftover hats for the head
local MethodType = 1  --Method 0 = CFrames 1 = Align
local AnimateScript = true --Copys the Default Roblox animations over to the Reanimate Body
local AddTools = true --Copys the Tools Over the the Reanimate Body
local NetlessVelocity = Vector3.new(46.34,0,46.34)










local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		RunService.Heartbeat:connect(function()
			v.Velocity =  NetlessVelocity
		end)
	end
end
local ReanimationRig = game:GetObjects("rbxassetid://12705569930")[1]
ReanimationRig.Parent = game.Players.LocalPlayer.Character
if AnimateScript == true then
	char.Animate:Clone().Parent=  ReanimationRig
end
for i,x in pairs(ReanimationRig:GetChildren()) do
	if x:IsA("BasePart") then
		x.Transparency = VirtualRigTransparency
		x.CanCollide = false
		x.CanTouch = false
		x.CanQuery = false
		if x.Name == "Head" then
			x.Face.Name = "face"
			x.face.Transparency = 1
		end
	end
end


ReanimationRig.HumanoidRootPart.Anchored = false
ReanimationRig.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
ReanimationRig.HumanoidRootPart["Root Hip"].Name = "RootJoint"
local leftRean = char:FindFirstChild("Pal Hair")
local rightRean = char:FindFirstChild("LavanderHair")
local lefthipRean = char:FindFirstChild("Kate Hair")
local righthipRean = char:FindFirstChild("Hat1")
local torsoRean = char:FindFirstChild("SeeMonkey")
function DeMesh(hat)
	hat.Handle:BreakJoints()
	hat.Handle.Mesh:Destroy()
end
DeMesh(leftRean)
DeMesh(rightRean)
DeMesh(lefthipRean)
DeMesh(righthipRean)
DeMesh(torsoRean)
local function Align(Part1,Part0,CFrameOffset) 
	local AlignPos = Instance.new('AlignPosition', Part1);
	AlignPos.Parent.CanCollide = false;
	AlignPos.ApplyAtCenterOfMass = true;
	AlignPos.MaxForce = 67752;
	AlignPos.MaxVelocity = math.huge/9e110;
	AlignPos.ReactionForceEnabled = false;
	AlignPos.Responsiveness = 200;
	AlignPos.RigidityEnabled = false;
	local AlignOri = Instance.new('AlignOrientation', Part1);
	AlignOri.MaxAngularVelocity = math.huge/9e110;
	AlignOri.MaxTorque = 67752;
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
end
local function AlignAttachments(Att0,Att1,CFrameOffset) 
	local AlignPos = Instance.new('AlignPosition', Att0.Parent);
	AlignPos.Parent.CanCollide = false;
	AlignPos.ApplyAtCenterOfMass = true;
	AlignPos.MaxForce = 67752;
	AlignPos.MaxVelocity = math.huge/9e110;
	AlignPos.ReactionForceEnabled = false;
	AlignPos.Responsiveness = 200;
	AlignPos.RigidityEnabled = false;
	local AlignOri = Instance.new('AlignOrientation', Att0.Parent);
	AlignOri.MaxAngularVelocity = math.huge/9e110;
	AlignOri.MaxTorque = 67752;
	AlignOri.PrimaryAxisOnly = false;
	AlignOri.ReactionTorqueEnabled = false;
	AlignOri.Responsiveness = 200;
	AlignOri.RigidityEnabled = false;
	AlignPos.Attachment0 = Att0;
	AlignPos.Attachment1 = Att1;
	AlignOri.Attachment0 = Att0;
	AlignOri.Attachment1 = Att1;
	wait(0.12)
		Att0.CFrame = Att0.CFrame*CFrame.new(0,0.3,0)
end
local function CF(p0,p1,off)
	p0.CFrame = p1.CFrame*off
end
if MethodType == 0 then
	RunService.Heartbeat:Connect(function()
		CF(leftRean.Handle,ReanimationRig["Left Arm"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		CF(rightRean.Handle,ReanimationRig["Right Arm"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		CF(lefthipRean.Handle,ReanimationRig["Left Leg"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		CF(righthipRean.Handle,ReanimationRig["Right Leg"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		CF(torsoRean.Handle,ReanimationRig["Torso "],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
		for i,x in pairs(char:GetChildren()) do
			if x:IsA("Accessory") and x.Handle and UseLeftOvers == true then
				if x.Name == leftRean.Name or x.Name == rightRean.Name or x.Name == lefthipRean.Name or x.Name == righthipRean.Name or x.Name == torsoRean.Name then
					x.Handle.Transparency = ReanimateTransparency
				else
					x.Handle.Transparency = 1
					x.Handle:BreakJoints()
					x:Clone().Parent = ReanimationRig
					CF(x.Handle,ReanimationRig["Head"],x.AttachmentPoint)
				end
			end
		end
	end)
else
	Align(leftRean.Handle,ReanimationRig["Left Arm"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	Align(rightRean.Handle,ReanimationRig["Right Arm"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	Align(lefthipRean.Handle,ReanimationRig["Left Leg"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	Align(righthipRean.Handle,ReanimationRig["Right Leg"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	Align(torsoRean.Handle,ReanimationRig["Torso"],CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)))
	for i,x in pairs(char:GetChildren()) do
		if x:IsA("Accessory") and x.Handle and UseLeftOvers == true then
			if x.Name == leftRean.Name or x.Name == rightRean.Name or x.Name == lefthipRean.Name or x.Name == righthipRean.Name or x.Name == torsoRean.Name then
				x.Handle.Transparency = ReanimateTransparency
				x:Clone().Parent = ReanimationRig
			else
			x:Clone().Parent = ReanimationRig
				x.Handle:BreakJoints()
				x.Handle.Transparency = ReanimateTransparency
				if x.Handle:FindFirstChild("HatAttachment") then
					AlignAttachments(x.Handle.HatAttachment,ReanimationRig["Head"]:WaitForChild("HatAttachment"))
				end
				if x.Handle:FindFirstChild("HairAttachment") then
					AlignAttachments(x.Handle.HairAttachment,ReanimationRig["Head"]:WaitForChild("HairAttachment"))
				end
				if x.Handle:FindFirstChild("FaceFrontAttachment") then
					AlignAttachments(x.Handle.FaceFrontAttachment,ReanimationRig["Head"]:WaitForChild("FaceFrontAttachment"))
				end
				if x.Handle:FindFirstChild("FaceCenterAttachment") then
					AlignAttachments(x.Handle.FaceCenterAttachment,ReanimationRig["Head"]:WaitForChild("FaceCenterAttachment"))
				end
				if x.Handle:FindFirstChild("NeckAttachment") then
					AlignAttachments(x.Handle.NeckAttachment,ReanimationRig["Torso"]:WaitForChild("NeckAttachment"))
				end
				if x.Handle:FindFirstChild("BodyBackAttachment") then
					AlignAttachments(x.Handle.BodyBackAttachment,ReanimationRig["Torso"]:WaitForChild("BodyBackAttachment"))
				end
				if x.Handle:FindFirstChild("BodyFrontAttachment") then
					AlignAttachments(x.Handle.BodyFrontAttachment,ReanimationRig["Torso"].BodyFrontAttachment)
				end
				if x.Handle:FindFirstChild("WaistCenterAttachment") then
					AlignAttachments(x.Handle.WaistCenterAttachment,ReanimationRig["Torso"].WaistCenterAttachment)
				end
				if x.Handle:FindFirstChild("WaistFrontAttachment") then
					AlignAttachments(x.Handle.WaistFrontAttachment,ReanimationRig["Torso"].WaistFrontAttachment)
				end
				if x.Handle:FindFirstChild("LeftShoulderAttachment") then
					AlignAttachments(x.Handle.LeftShoulderAttachment,ReanimationRig["Left Arm"].LeftShoulderAttachment)
				end
				if x.Handle:FindFirstChild("RightShoulderAttachment") then
					AlignAttachments(x.Handle.RightShoulderAttachment,ReanimationRig["Right Arm"].RightShoulderAttachment)
				end
			end
		end
	end
end
--char["Right Arm"]:BreakJoints()
AddTools = AddTools and plr:FindFirstChildOfClass("Backpack")
if AddTools  then
	for i,x in pairs(plr.Backpack:GetChildren()) do
		if x:IsA("Tool") and x.Handle then
			local clone = x:Clone()
			clone.Parent = ReanimationRig
			wait(0.001)
			x.Parent = ReanimationRig

			Align(x.Handle,clone.Handle,CFrame.new(0,0,0))
			game:GetService("RunService").Heartbeat:Connect(function()
				if x.Handle then
					x.Handle.Velocity = Vector3.new(0, 35, 0)
				end
			end)
			--x.Parent = ReanimationRig
		end
	end 
end
workspace.CurrentCamera.CameraSubject = ReanimationRig.Humanoid
plr.Character = ReanimationRig


game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Sved's Reanimate";
	Text = "Reanimate Has Ran with Success";
	Icon = "http://www.roblox.com/asset/?id=214221061"})
Duration = 16;
local ping = plr:GetNetworkPing()
wait(0.5)
if ping < 0.1  then
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "Sved's Reanimate";
		Text = "Very Stable , Ping is less then 30";
		Icon = "http://www.roblox.com/asset/?id=214221061"})
	Duration = 16;
end
if ping > 0.12 then
	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = "Sved's Reanimate";
		Text = ("Breaking may Happen due to your ping:".. ping.."ms");
		Icon = "http://www.roblox.com/asset/?id=11782664145"})
	Duration = 16;
end
UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == ScriptEndButton then
		plr.Character = ReanimationRig.Parent
		workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChildOfClass("Humanoid")
		wait(0.2)
		plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
		ReanimationRig:Destroy()
		error("Script Ended By User to stop any more errors When Next Execution")
	end
end)