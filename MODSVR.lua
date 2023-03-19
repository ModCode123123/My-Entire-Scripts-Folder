--[[
                      _      __      _______                          
                     | |     \ \    / /  __ \                         
  _ __ ___   ___   __| |___   \ \  / /| |__) |                        
 | '_ ` _ \ / _ \ / _` / __|   \ \/ / |  _  /                         
 | | | | | | (_) | (_| \__ \    \  /  | | \ \                         
 |_| |_| |_|\___/ \__,_|___/     \/   |_|  \_\    _                 
 
 
 
 
 
 \ \    / /  __ \      /\                        | |                  
  \ \  / /| |__) |    /  \   _ __  _   ___      _| |__   ___ _ __ ___ 
   \ \/ / |  _  /    / /\ \ | '_ \| | | \ \ /\ / / '_ \ / _ \ '__/ _ \
    \  /  | | \ \   / ____ \| | | | |_| |\ V  V /| | | |  __/ | |  __/
     \/   |_|  \_\ /_/    \_\_| |_|\__, | \_/\_/ |_| |_|\___|_|  \___|
                                    __/ |                             
                                   |___/      
--]]

--this script is inspired By skeds vr (VR Anywhere)

--NOTE: if your on the quest 2 set the righthandrotoffset to (0,180,0) 
--and this goes for Rift S, Rift,Quest 1,Meta Quest Pro (and i have only used this on oculus)

--VRRHand = RightHandHat
--VRLHand = LeftHandHat
--VRHead = HeadHat 

local HeadHat = "Speakat" -- the hat used for your head
local RightHat = "LavanderHair" --the hat used for your right hand
local LeftHat = "Pal Hair" --the hat used for your left hand

local Headscale = 3 --how big you are in VR
local BubbleChatForce = true --Forces Bubblechat [CLIENT ONLY!!!]
local HeadscaleChangable = true --Use X to scale down Use Y to scale up WORKS ONLY ON HEADSETS WITH A,B,Y,X BUTTONS

local AnchorRoot = true --stops your character from wandering around while in VR

local righthandrotoffset = Vector3.new(0,180,0)--the flying hand offset for your controller
local lefthandrotoffset = Vector3.new(0,0,0)--the flying hand offset for your controller

local ViewportEnabled = true
local ViewportRange = 75





local char = game:GetService("Players").LocalPlayer.Character
local PlayerCam = game.Workspace.CurrentCamera
local InputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera
local VRService = game:GetService("VRService")




local VRLHand = char:FindFirstChild(LeftHat)
local VRRHand = char:FindFirstChild(RightHat)
local VRHead = char:FindFirstChild(HeadHat)



PlayerCam.HeadScale = Headscale

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(95,0,95)
			wait(0.5)
		end)
	end
end
VRLHand.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
VRRHand.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()

game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)	

Camera.CameraType = "Scriptable"
if AnchorRoot == true then
	char:FindFirstChild("HumanoidRootPart").Anchored = true
end

if HeadscaleChangable == true then
	InputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.ButtonX then
		Camera.HeadScale = Camera.HeadScale - 1
	end
end)
InputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.ButtonY then
		Camera.HeadScale = Camera.HeadScale + 1
	end
end)
end

local function Track(Type, Value)
	if Type == Enum.UserCFrame.RightHand then
		VRRHand.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,0)
	end
	if Type == Enum.UserCFrame.LeftHand then
		VRLHand.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value) * CFrame.Angles(0,math.pi,math.pi)
	end
	if Type == Enum.UserCFrame.Head then
		VRHead.Handle.CFrame = Camera.CoordinateFrame * (CFrame.new(Value.p*(Camera.HeadScale-1))*Value)
	end
end

InputService.UserCFrameChanged:Connect(Track)
VRLHand.Handle:BreakJoints()
VRHead.Handle:BreakJoints()
VRRHand.Handle:BreakJoints()

InputService.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		if key.Position.Z > 0.9 then
			R1down = true
		else
			R1down = false
		end
	end
end)

InputService.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = true
	end
end)


InputService.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = false
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if R1down then
		Camera.CFrame = Camera.CFrame:Lerp(Camera.CoordinateFrame + (VRRHand.Handle.CFrame*CFrame.Angles(-math.rad(righthandrotoffset.X),-math.rad(righthandrotoffset.Y),math.rad(180-righthandrotoffset.X))).LookVector * Camera.HeadScale/2, 0.5)
	end
end)
--[[
local lighting = game:GetService("Lighting")

lighting.TimeOfDay = "14:00:00"
lighting.Brightness = 3
lighting.GlobalShadows = false
lighting.Ambient = Color3.new(1, 1, 1)
lighting:FindFirstAncestorOfClass("Sky"):Destroy()]]
