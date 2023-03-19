local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

local function Setup(hat)
	local att0 = Instance.new("Attachment",hat.Handle)
	local att1 = Instance.new("Attachment",char:FindFirstChild("Head"))
	local alignpos = Instance.new("AlignPosition",hat.Handle)
	alignpos.Attachment0 = att0
	alignpos.Attachment1 = att1
	alignpos.Responsiveness = math.huge
	alignpos.MaxForce = math.huge
	alignpos.MaxVelocity = math.huge
	local bodythurst = Instance.new("BodyThrust",hat.Handle)
	bodythurst.Force = Vector3.new(1444,0,1444)
	bodythurst.Location = hat.Handle.Position
	hat.Handle:BreakJoints()
	hat.Handle.Size = Vector3.new(0.44,0.44,0.44)
	hat.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	att0.CFrame = CFrame.new(0,-3,0)*CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
	game:GetService("RunService").Heartbeat:Connect(function()
		if hat then
			hat.Handle.Velocity = Vector3.new(0,30,0)
		end
	end)
end
for _,x in pairs(char:GetChildren()) do
	if x:IsA("Accessory") and x :FindFirstChild("Handle") then
		Setup(x)
	end
end