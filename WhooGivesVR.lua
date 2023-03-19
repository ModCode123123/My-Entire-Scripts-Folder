-[[
 __          __  _                               _                        _          __      __  _____  
 \ \        / / | |                             (_)                      ( )         \ \    / / |  __ \  
  \ \  /\  / /  | |__     ___     ___     __ _   _  __   __   ___   ___  |/   ___     \ \  / /  | |__) |
   \ \/  \/ /   | '_ \   / _ \   / _ \   / _` | | | \ \ / /  / _ \ / __|     / __|     \ \/ /   |  _  / 
    \  /\  /    | | | | | (_) | | (_) | | (_| | | |  \ V /  |  __/ \__ \     \__ \      \  /    | | \ \ 
     \/  \/     |_| |_|  \___/   \___/   \__, | |_|   \_/    \___| |___/     |___/       \/     |_|  \_\
                                          __/ |                                                         
                                         |___/   
  !! Some parts are from Skeds VR !!    
  !! The V3rm post on how to use it: https://v3rmillion.net/showthread.php?tid=1114886
  
--]]

local options = {}

-- Options:
options.NetBypassOption = 1								-- [1] Stable, [2] Stable

options.VRChat = true                                   -- Set this to true if you want to chat in VR (Make sure the CoreGui is showing)
options.headscale = 3                                   -- How big you are in VR, This does not make your character any bigger (3 is recommended)
options.forcebubblechat = true                          -- Force bubblechat so you can see people chatting
options.BetterType = true								-- Makes you big when you open on chat gui

options.HandsRotationOffset = Vector3.new(90,0,0)       -- Rotation offset (90 is recommended) 
options.HandTransparency = 0.4                          -- Transparency for your VR hands, Dont worry this is client sided (0.4 is recommended)
options.HideAllHats = true                              -- Set this to true if you want your hats to not get in the way, (This is client sided)
options.BlockCharacter = true							-- Makes your character look like a roblox studio dummy (Fun)

options.BadCoputer = false								-- Set this to true if you have a bad/low-end computer
options.ShowVRControllerOutline = true					-- Shows a outline of where your VR controllers are
options.ConOutlineColor = Color3.fromRGB(13, 105, 172)  --Outline colour of where your VR controllers are
--

-- Main:
local cam = workspace.CurrentCamera
local R1down = false
local VR = game:GetService("VRService")
local runservice = game:service("RunService")
local input = game:GetService("UserInputService")
local keysPressed = input:GetKeysPressed()
local PlayerReset = false
local plr = game:GetService("Players").LocalPlayer
local character = plr["Character"]
local removeuseless = game:GetService("Debris")
local Blur = Instance.new("BlurEffect",game.Lighting)
Blur.Size = 0
-- Net:
local function AlignParts(Part1,Part0,CFrameOffset)
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

local hum = character.Humanoid 
local LeftArm=character["Left Arm"]
local LeftLeg=character["Left Leg"]
local RightArm=character["Right Arm"]
local RightLeg=character["Right Leg"]
local Root=character["HumanoidRootPart"]
local Head=character["Head"]
local Torso=character["Torso"]

local function LoadNet() -- You can remove the script belown and the options.NetBypassOption but keep the function

	if not game:IsLoaded() then game.Loaded:Wait() end -- Wait for game

	if options.NetBypassOption == 2 then
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
				game:GetService("RunService").Heartbeat:connect(function()
					v.Velocity = Vector3.new(-30,0,0)
				end)
			end
		end
		character["Torso"].Transparency = 0.8
		character["Head"].Transparency = 1
	end
	if options.NetBypassOption == 1 then
		character["Torso"].Transparency = 0.8
		character["Head"].Transparency = 1
		settings().Physics.AllowSleep = false
		settings().Physics.DisableCSGv2 = true
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		loadstring(game:HttpGet("https://raw.githubusercontent.com/OpenGamerTips/Roblox-Scripts/main/NetworkScripts/ownership.lua"))()
	end
end
--

-- Check status of script:
if not _G.DidVR == true then -- If the value is nil
	_G.DidVR = false
end
if _G.DidVR == true then -- If the script is running already
	game:GetService("Players").LocalPlayer.MaximumSimulationRadius = 9e9
end
--
local function swait(num)
	if num == 0 or num == nil then
		game:service("RunService").Stepped:wait(0)
	else
		for i = 0, num do
			game:service("RunService").Stepped:wait(0)
		end
	end
end
local function createpart(size, name) -- Part create function
	local Part = Instance.new("Part", workspace)
	Part.CFrame = character.HumanoidRootPart.CFrame
	Part.Size = size
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Anchored = true
	Part.Name = name
	return Part
end
local moveHandL = createpart(LeftArm.Size, "moveRH")
local moveHandR = createpart(RightArm.Size, "moveLH")
local moveHead = createpart(Torso.Size, "moveH")

input.UserCFrameChanged:connect(function(Input,Move) --If the user input has changed
	if Input == Enum.UserCFrame.Head then
		moveHead.CFrame = cam.CFrame*(CFrame.new(Move.p*(cam.HeadScale-1))*Move - Vector3.new(0,2,0))
	elseif Input == Enum.UserCFrame.LeftHand then
		moveHandL.CFrame = cam.CFrame*(CFrame.new(Move.p*(cam.HeadScale-1))*Move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
	elseif Input == Enum.UserCFrame.RightHand then
		moveHandR.CFrame = cam.CFrame*(CFrame.new(Move.p*(cam.HeadScale-1))*Move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
	end
end)

-- Chat Part:
local function LoadKeybord()
	if options.VRChat == true then
		local VRchat = Instance.new("ScreenGui")
		local Keyboard = Instance.new("Frame")
		local Q = Instance.new("TextButton")
		local W = Instance.new("TextButton")
		local E = Instance.new("TextButton")
		local R = Instance.new("TextButton")
		local T = Instance.new("TextButton")
		local Y = Instance.new("TextButton")
		local U = Instance.new("TextButton")
		local I = Instance.new("TextButton")
		local O = Instance.new("TextButton")
		local P = Instance.new("TextButton")
		local F = Instance.new("TextButton")
		local D = Instance.new("TextButton")
		local G = Instance.new("TextButton")
		local L = Instance.new("TextButton")
		local H = Instance.new("TextButton")
		local S = Instance.new("TextButton")
		local A = Instance.new("TextButton")
		local J = Instance.new("TextButton")
		local K = Instance.new("TextButton")
		local X = Instance.new("TextButton")
		local Z = Instance.new("TextButton")
		local M = Instance.new("TextButton")
		local N = Instance.new("TextButton")
		local B = Instance.new("TextButton")
		local V = Instance.new("TextButton")
		local C = Instance.new("TextButton")
		local TypeTextBox = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local WhoosVR = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")
		local ENTER = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local SpaceBar = Instance.new("TextButton")
		local UICorner_4 = Instance.new("UICorner")
		local Backspace = Instance.new("TextButton")
		local UICorner_5 = Instance.new("UICorner")
		local Wordlist = Instance.new("TextButton")
		local UICorner_6 = Instance.new("UICorner")
		local PredoneWords = Instance.new("Frame")
		local Hello = Instance.new("TextButton")
		local UICorner_7 = Instance.new("UICorner")
		local BackHome = Instance.new("TextButton")
		local UICorner_8 = Instance.new("UICorner")
		local Sup = Instance.new("TextButton")
		local UICorner_9 = Instance.new("UICorner")
		local Hi = Instance.new("TextButton")
		local UICorner_10 = Instance.new("UICorner")
		local Thanks = Instance.new("TextButton")
		local UICorner_11 = Instance.new("UICorner")
		local Omg = Instance.new("TextButton")
		local UICorner_12 = Instance.new("UICorner")
		local Lol = Instance.new("TextButton")
		local UICorner_13 = Instance.new("UICorner")
		local You = Instance.new("TextButton")
		local UICorner_14 = Instance.new("UICorner")
		local Him = Instance.new("TextButton")
		local UICorner_15 = Instance.new("UICorner")
		local Her = Instance.new("TextButton")
		local UICorner_16 = Instance.new("UICorner")
		local And = Instance.new("TextButton")
		local UICorner_17 = Instance.new("UICorner")
		local Yes = Instance.new("TextButton")
		local UICorner_18 = Instance.new("UICorner")
		local No = Instance.new("TextButton")
		local UICorner_19 = Instance.new("UICorner")
		local Stop = Instance.new("TextButton")
		local UICorner_20 = Instance.new("UICorner")
		local Start = Instance.new("TextButton")
		local UICorner_21 = Instance.new("UICorner")
		local What = Instance.new("TextButton")
		local UICorner_22 = Instance.new("UICorner")
		local Sad = Instance.new("TextButton")
		local UICorner_23 = Instance.new("UICorner")
		local Happy = Instance.new("TextButton")
		local UICorner_24 = Instance.new("UICorner")
		local Suprise = Instance.new("TextButton")
		local UICorner_25 = Instance.new("UICorner")
		local Wut = Instance.new("TextButton")
		local UICorner_26 = Instance.new("UICorner")
		local Its = Instance.new("TextButton")
		local UICorner_27 = Instance.new("UICorner")
		local Me = Instance.new("TextButton")
		local UICorner_28 = Instance.new("UICorner")

		--Properties:

		VRchat.Name = "VR chat"
		VRchat.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		VRchat.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		Keyboard.Name = "Keyboard"
		Keyboard.Parent = VRchat
		Keyboard.BackgroundColor3 = Color3.fromRGB(109, 109, 109)
		Keyboard.BackgroundTransparency = 0.300
		Keyboard.Position = UDim2.new(-0.00080871582, 0, -0.00193678541, 0)
		Keyboard.Size = UDim2.new(1, 0, 1, 0)

		Q.Name = "Q"
		Q.Parent = Keyboard
		Q.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Q.Position = UDim2.new(0.0117462156, 0, 0.252441317, 0)
		Q.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		Q.Font = Enum.Font.SourceSans
		Q.Text = "Q"
		Q.TextColor3 = Color3.fromRGB(0, 0, 0)
		Q.TextScaled = true
		Q.TextSize = 25.000
		Q.TextWrapped = true

		W.Name = "W"
		W.Parent = Keyboard
		W.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		W.Position = UDim2.new(0.111448169, 0, 0.252441317, 0)
		W.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		W.Font = Enum.Font.SourceSans
		W.Text = "W"
		W.TextColor3 = Color3.fromRGB(0, 0, 0)
		W.TextScaled = true
		W.TextSize = 25.000
		W.TextWrapped = true

		E.Name = "E"
		E.Parent = Keyboard
		E.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		E.Position = UDim2.new(0.212396309, 0, 0.252441317, 0)
		E.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		E.Font = Enum.Font.SourceSans
		E.Text = "E"
		E.TextColor3 = Color3.fromRGB(0, 0, 0)
		E.TextScaled = true
		E.TextSize = 25.000
		E.TextWrapped = true

		R.Name = "R"
		R.Parent = Keyboard
		R.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		R.Position = UDim2.new(0.307621926, 0, 0.252441317, 0)
		R.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		R.Font = Enum.Font.SourceSans
		R.Text = "R"
		R.TextColor3 = Color3.fromRGB(0, 0, 0)
		R.TextScaled = true
		R.TextSize = 25.000
		R.TextWrapped = true

		T.Name = "T"
		T.Parent = Keyboard
		T.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		T.Position = UDim2.new(0.408570051, 0, 0.252441317, 0)
		T.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		T.Font = Enum.Font.SourceSans
		T.Text = "T"
		T.TextColor3 = Color3.fromRGB(0, 0, 0)
		T.TextScaled = true
		T.TextSize = 25.000
		T.TextWrapped = true

		Y.Name = "Y"
		Y.Parent = Keyboard
		Y.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Y.Position = UDim2.new(0.508271873, 0, 0.252441317, 0)
		Y.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		Y.Font = Enum.Font.SourceSans
		Y.Text = "Y"
		Y.TextColor3 = Color3.fromRGB(0, 0, 0)
		Y.TextScaled = true
		Y.TextSize = 25.000
		Y.TextWrapped = true

		U.Name = "U"
		U.Parent = Keyboard
		U.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		U.Position = UDim2.new(0.607973874, 0, 0.252441317, 0)
		U.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		U.Font = Enum.Font.SourceSans
		U.Text = "U"
		U.TextColor3 = Color3.fromRGB(0, 0, 0)
		U.TextScaled = true
		U.TextSize = 25.000
		U.TextWrapped = true

		I.Name = "I"
		I.Parent = Keyboard
		I.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		I.Position = UDim2.new(0.706081927, 0, 0.252441317, 0)
		I.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		I.Font = Enum.Font.SourceSans
		I.Text = "I"
		I.TextColor3 = Color3.fromRGB(0, 0, 0)
		I.TextScaled = true
		I.TextSize = 25.000
		I.TextWrapped = true

		O.Name = "O"
		O.Parent = Keyboard
		O.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		O.Position = UDim2.new(0.803423941, 0, 0.252441317, 0)
		O.Size = UDim2.new(0.0859585702, 0, 0.158975735, 0)
		O.Font = Enum.Font.SourceSans
		O.Text = "O"
		O.TextColor3 = Color3.fromRGB(0, 0, 0)
		O.TextScaled = true
		O.TextSize = 25.000
		O.TextWrapped = true

		P.Name = "P"
		P.Parent = Keyboard
		P.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		P.Position = UDim2.new(0.898479164, 0, 0.252441317, 0)
		P.Size = UDim2.new(0.0880587846, 0, 0.158975735, 0)
		P.Font = Enum.Font.SourceSans
		P.Text = "P"
		P.TextColor3 = Color3.fromRGB(0, 0, 0)
		P.TextScaled = true
		P.TextSize = 25.000
		P.TextWrapped = true

		F.Name = "F"
		F.Parent = Keyboard
		F.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		F.Position = UDim2.new(0.300759614, 0, 0.436759293, 0)
		F.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		F.Font = Enum.Font.SourceSans
		F.Text = "F"
		F.TextColor3 = Color3.fromRGB(0, 0, 0)
		F.TextScaled = true
		F.TextSize = 25.000
		F.TextWrapped = true

		D.Name = "D"
		D.Parent = Keyboard
		D.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		D.Position = UDim2.new(0.206816316, 0, 0.436759293, 0)
		D.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		D.Font = Enum.Font.SourceSans
		D.Text = "D"
		D.TextColor3 = Color3.fromRGB(0, 0, 0)
		D.TextScaled = true
		D.TextSize = 25.000
		D.TextWrapped = true

		G.Name = "G"
		G.Parent = Keyboard
		G.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		G.Position = UDim2.new(0.400043011, 0, 0.436759293, 0)
		G.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		G.Font = Enum.Font.SourceSans
		G.Text = "G"
		G.TextColor3 = Color3.fromRGB(0, 0, 0)
		G.TextScaled = true
		G.TextSize = 25.000
		G.TextWrapped = true

		L.Name = "L"
		L.Parent = Keyboard
		L.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		L.Position = UDim2.new(0.788203597, 0, 0.436759293, 0)
		L.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		L.Font = Enum.Font.SourceSans
		L.Text = "L"
		L.TextColor3 = Color3.fromRGB(0, 0, 0)
		L.TextScaled = true
		L.TextSize = 25.000
		L.TextWrapped = true

		H.Name = "H"
		H.Parent = Keyboard
		H.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		H.Position = UDim2.new(0.498100758, 0, 0.436759293, 0)
		H.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		H.Font = Enum.Font.SourceSans
		H.Text = "H"
		H.TextColor3 = Color3.fromRGB(0, 0, 0)
		H.TextScaled = true
		H.TextSize = 25.000
		H.TextWrapped = true

		S.Name = "S"
		S.Parent = Keyboard
		S.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		S.Position = UDim2.new(0.107532814, 0, 0.436759293, 0)
		S.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		S.Font = Enum.Font.SourceSans
		S.Text = "S"
		S.TextColor3 = Color3.fromRGB(0, 0, 0)
		S.TextScaled = true
		S.TextSize = 25.000
		S.TextWrapped = true

		A.Name = "A"
		A.Parent = Keyboard
		A.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		A.Position = UDim2.new(0.00947504677, 0, 0.436759293, 0)
		A.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		A.Font = Enum.Font.SourceSans
		A.Text = "A"
		A.TextColor3 = Color3.fromRGB(0, 0, 0)
		A.TextScaled = true
		A.TextSize = 25.000
		A.TextWrapped = true

		J.Name = "J"
		J.Parent = Keyboard
		J.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		J.Position = UDim2.new(0.596158445, 0, 0.436759293, 0)
		J.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		J.Font = Enum.Font.SourceSans
		J.Text = "J"
		J.TextColor3 = Color3.fromRGB(0, 0, 0)
		J.TextScaled = true
		J.TextSize = 25.000
		J.TextWrapped = true

		K.Name = "K"
		K.Parent = Keyboard
		K.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		K.Position = UDim2.new(0.692648768, 0, 0.436759293, 0)
		K.Size = UDim2.new(0.0845410228, 0, 0.158975735, 0)
		K.Font = Enum.Font.SourceSans
		K.Text = "K"
		K.TextColor3 = Color3.fromRGB(0, 0, 0)
		K.TextScaled = true
		K.TextSize = 25.000
		K.TextWrapped = true

		X.Name = "X"
		X.Parent = Keyboard
		X.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		X.Position = UDim2.new(0.153487474, 0, 0.615810692, 0)
		X.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		X.Font = Enum.Font.SourceSans
		X.Text = "X"
		X.TextColor3 = Color3.fromRGB(0, 0, 0)
		X.TextScaled = true
		X.TextSize = 25.000
		X.TextWrapped = true

		Z.Name = "Z"
		Z.Parent = Keyboard
		Z.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Z.Position = UDim2.new(0.0333947465, 0, 0.615810692, 0)
		Z.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		Z.Font = Enum.Font.SourceSans
		Z.Text = "Z"
		Z.TextColor3 = Color3.fromRGB(0, 0, 0)
		Z.TextScaled = true
		Z.TextSize = 25.000
		Z.TextWrapped = true

		M.Name = "M"
		M.Parent = Keyboard
		M.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		M.Position = UDim2.new(0.765749037, 0, 0.615810692, 0)
		M.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		M.Font = Enum.Font.SourceSans
		M.Text = "M"
		M.TextColor3 = Color3.fromRGB(0, 0, 0)
		M.TextScaled = true
		M.TextSize = 25.000
		M.TextWrapped = true

		N.Name = "N"
		N.Parent = Keyboard
		N.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		N.Position = UDim2.new(0.642091811, 0, 0.615810692, 0)
		N.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		N.Font = Enum.Font.SourceSans
		N.Text = "N"
		N.TextColor3 = Color3.fromRGB(0, 0, 0)
		N.TextScaled = true
		N.TextSize = 25.000
		N.TextWrapped = true

		B.Name = "B"
		B.Parent = Keyboard
		B.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		B.Position = UDim2.new(0.520311058, 0, 0.615810692, 0)
		B.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		B.Font = Enum.Font.SourceSans
		B.Text = "B"
		B.TextColor3 = Color3.fromRGB(0, 0, 0)
		B.TextScaled = true
		B.TextSize = 25.000
		B.TextWrapped = true

		V.Name = "V"
		V.Parent = Keyboard
		V.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		V.Position = UDim2.new(0.398611486, 0, 0.615810692, 0)
		V.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		V.Font = Enum.Font.SourceSans
		V.Text = "V"
		V.TextColor3 = Color3.fromRGB(0, 0, 0)
		V.TextScaled = true
		V.TextSize = 25.000
		V.TextWrapped = true

		C.Name = "C"
		C.Parent = Keyboard
		C.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		C.Position = UDim2.new(0.282874316, 0, 0.615810692, 0)
		C.Size = UDim2.new(0.102191411, 0, 0.162968799, 0)
		C.Font = Enum.Font.SourceSans
		C.Text = "C"
		C.TextColor3 = Color3.fromRGB(0, 0, 0)
		C.TextScaled = true
		C.TextSize = 25.000
		C.TextWrapped = true

		TypeTextBox.Name = "TypeTextBox"
		TypeTextBox.Parent = Keyboard
		TypeTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TypeTextBox.Position = UDim2.new(0.0448157042, 0, 0.0517003872, 0)
		TypeTextBox.Size = UDim2.new(0.910251737, 0, 0.157194391, 0)
		TypeTextBox.Font = Enum.Font.SourceSans
		TypeTextBox.Text = ""
		TypeTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
		TypeTextBox.TextScaled = true
		TypeTextBox.TextSize = 14.000
		TypeTextBox.TextWrapped = true

		UICorner.Parent = TypeTextBox

		WhoosVR.Name = "WhoosVR"
		WhoosVR.Parent = Keyboard
		WhoosVR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		WhoosVR.Position = UDim2.new(0.520310998, 0, 0.912941813, 0)
		WhoosVR.Size = UDim2.new(0.339041591, 0, 0.0640936419, 0)
		WhoosVR.Font = Enum.Font.SourceSans
		WhoosVR.Text = "Whoogives's VR"
		WhoosVR.TextColor3 = Color3.fromRGB(0, 0, 0)
		WhoosVR.TextScaled = true
		WhoosVR.TextSize = 25.000
		WhoosVR.TextWrapped = true

		UICorner_2.Parent = WhoosVR

		ENTER.Name = "ENTER"
		ENTER.Parent = Keyboard
		ENTER.BackgroundColor3 = Color3.fromRGB(97, 255, 163)
		ENTER.Position = UDim2.new(0.887289643, 0, 0.683890104, 0)
		ENTER.Size = UDim2.new(0.108888887, 0, 0.211250007, 0)
		ENTER.Font = Enum.Font.SourceSans
		ENTER.Text = "ENTER"
		ENTER.TextColor3 = Color3.fromRGB(0, 0, 0)
		ENTER.TextScaled = true
		ENTER.TextSize = 14.000
		ENTER.TextWrapped = true

		UICorner_3.Parent = ENTER

		SpaceBar.Name = "SpaceBar"
		SpaceBar.Parent = Keyboard
		SpaceBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SpaceBar.Position = UDim2.new(0.057130333, 0, 0.793944001, 0)
		SpaceBar.Size = UDim2.new(0.802222252, 0, 0.10125, 0)
		SpaceBar.Font = Enum.Font.SourceSans
		SpaceBar.Text = "Space"
		SpaceBar.TextColor3 = Color3.fromRGB(0, 0, 0)
		SpaceBar.TextScaled = true
		SpaceBar.TextSize = 14.000
		SpaceBar.TextWrapped = true

		UICorner_4.Parent = SpaceBar

		Backspace.Name = "Backspace"
		Backspace.Parent = Keyboard
		Backspace.BackgroundColor3 = Color3.fromRGB(255, 160, 162)
		Backspace.Position = UDim2.new(0.890622973, 0, 0.427806616, 0)
		Backspace.Size = UDim2.new(0.109376945, 0, 0.236188814, 0)
		Backspace.Font = Enum.Font.SourceSans
		Backspace.Text = "<--"
		Backspace.TextColor3 = Color3.fromRGB(0, 0, 0)
		Backspace.TextScaled = true
		Backspace.TextSize = 25.000
		Backspace.TextWrapped = true

		UICorner_5.Parent = Backspace

		Wordlist.Name = "Wordlist"
		Wordlist.Parent = Keyboard
		Wordlist.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Wordlist.Position = UDim2.new(0.0571303293, 0, 0.912941813, 0)
		Wordlist.Size = UDim2.new(0.351439774, 0, 0.0640936419, 0)
		Wordlist.Font = Enum.Font.SourceSans
		Wordlist.Text = "Predone words"
		Wordlist.TextColor3 = Color3.fromRGB(0, 0, 0)
		Wordlist.TextScaled = true
		Wordlist.TextSize = 25.000
		Wordlist.TextWrapped = true

		UICorner_6.Parent = Wordlist

		PredoneWords.Name = "PredoneWords"
		PredoneWords.Parent = VRchat
		PredoneWords.BackgroundColor3 = Color3.fromRGB(109, 109, 109)
		PredoneWords.BackgroundTransparency = 0.300
		PredoneWords.Position = UDim2.new(-0.00080871582, 0, -0.00193678541, 0)
		PredoneWords.Size = UDim2.new(1, 0, 1, 0)
		PredoneWords.Visible = false

		Hello.Name = "Hello"
		Hello.Parent = PredoneWords
		Hello.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Hello.Position = UDim2.new(0.0423965231, 0, 0.0486875065, 0)
		Hello.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Hello.Font = Enum.Font.SourceSans
		Hello.Text = "Hello!"
		Hello.TextColor3 = Color3.fromRGB(0, 0, 0)
		Hello.TextScaled = true
		Hello.TextSize = 25.000
		Hello.TextWrapped = true

		UICorner_7.Parent = Hello

		BackHome.Name = "BackHome"
		BackHome.Parent = PredoneWords
		BackHome.BackgroundColor3 = Color3.fromRGB(255, 138, 140)
		BackHome.Position = UDim2.new(0.236331716, 0, 0.918789923, 0)
		BackHome.Size = UDim2.new(0.522150397, 0, 0.0720085353, 0)
		BackHome.Font = Enum.Font.SourceSans
		BackHome.Text = "Back"
		BackHome.TextColor3 = Color3.fromRGB(255, 255, 255)
		BackHome.TextScaled = true
		BackHome.TextSize = 25.000
		BackHome.TextWrapped = true

		UICorner_8.Parent = BackHome

		Sup.Name = "Sup"
		Sup.Parent = PredoneWords
		Sup.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Sup.Position = UDim2.new(0.359584004, 0, 0.0486875065, 0)
		Sup.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Sup.Font = Enum.Font.SourceSans
		Sup.Text = "Sup"
		Sup.TextColor3 = Color3.fromRGB(0, 0, 0)
		Sup.TextScaled = true
		Sup.TextSize = 25.000
		Sup.TextWrapped = true

		UICorner_9.Parent = Sup

		Hi.Name = "Hi"
		Hi.Parent = PredoneWords
		Hi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Hi.Position = UDim2.new(0.686146557, 0, 0.0468976386, 0)
		Hi.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Hi.Font = Enum.Font.SourceSans
		Hi.Text = "Hi"
		Hi.TextColor3 = Color3.fromRGB(0, 0, 0)
		Hi.TextScaled = true
		Hi.TextSize = 25.000
		Hi.TextWrapped = true

		UICorner_10.Parent = Hi

		Thanks.Name = "Thanks"
		Thanks.Parent = PredoneWords
		Thanks.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Thanks.Position = UDim2.new(0.0423965082, 0, 0.166818872, 0)
		Thanks.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Thanks.Font = Enum.Font.SourceSans
		Thanks.Text = "Thank you!"
		Thanks.TextColor3 = Color3.fromRGB(0, 0, 0)
		Thanks.TextScaled = true
		Thanks.TextSize = 25.000
		Thanks.TextWrapped = true

		UICorner_11.Parent = Thanks

		Omg.Name = "Omg"
		Omg.Parent = PredoneWords
		Omg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Omg.Position = UDim2.new(0.359584004, 0, 0.166818872, 0)
		Omg.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Omg.Font = Enum.Font.SourceSans
		Omg.Text = "Omg"
		Omg.TextColor3 = Color3.fromRGB(0, 0, 0)
		Omg.TextScaled = true
		Omg.TextSize = 25.000
		Omg.TextWrapped = true

		UICorner_12.Parent = Omg

		Lol.Name = "Lol"
		Lol.Parent = PredoneWords
		Lol.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Lol.Position = UDim2.new(0.686146557, 0, 0.166818872, 0)
		Lol.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Lol.Font = Enum.Font.SourceSans
		Lol.Text = "Lol"
		Lol.TextColor3 = Color3.fromRGB(0, 0, 0)
		Lol.TextScaled = true
		Lol.TextSize = 25.000
		Lol.TextWrapped = true

		UICorner_13.Parent = Lol

		You.Name = "You"
		You.Parent = PredoneWords
		You.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		You.Position = UDim2.new(0.0408340096, 0, 0.29031983, 0)
		You.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		You.Font = Enum.Font.SourceSans
		You.Text = "You"
		You.TextColor3 = Color3.fromRGB(0, 0, 0)
		You.TextScaled = true
		You.TextSize = 25.000
		You.TextWrapped = true

		UICorner_14.Parent = You

		Him.Name = "Him"
		Him.Parent = PredoneWords
		Him.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Him.Position = UDim2.new(0.359584004, 0, 0.29031983, 0)
		Him.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Him.Font = Enum.Font.SourceSans
		Him.Text = "Him"
		Him.TextColor3 = Color3.fromRGB(0, 0, 0)
		Him.TextScaled = true
		Him.TextSize = 25.000
		Him.TextWrapped = true

		UICorner_15.Parent = Him

		Her.Name = "Her"
		Her.Parent = PredoneWords
		Her.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Her.Position = UDim2.new(0.686146557, 0, 0.29031983, 0)
		Her.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Her.Font = Enum.Font.SourceSans
		Her.Text = "Her"
		Her.TextColor3 = Color3.fromRGB(0, 0, 0)
		Her.TextScaled = true
		Her.TextSize = 25.000
		Her.TextWrapped = true

		UICorner_16.Parent = Her

		And.Name = "And"
		And.Parent = PredoneWords
		And.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		And.Position = UDim2.new(0.0408340096, 0, 0.412030935, 0)
		And.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		And.Font = Enum.Font.SourceSans
		And.Text = "And"
		And.TextColor3 = Color3.fromRGB(0, 0, 0)
		And.TextScaled = true
		And.TextSize = 25.000
		And.TextWrapped = true

		UICorner_17.Parent = And

		Yes.Name = "Yes"
		Yes.Parent = PredoneWords
		Yes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Yes.Position = UDim2.new(0.358021468, 0, 0.800339937, 0)
		Yes.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Yes.Font = Enum.Font.SourceSans
		Yes.Text = "Yes"
		Yes.TextColor3 = Color3.fromRGB(0, 0, 0)
		Yes.TextScaled = true
		Yes.TextSize = 25.000
		Yes.TextWrapped = true

		UICorner_18.Parent = Yes

		No.Name = "No"
		No.Parent = PredoneWords
		No.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		No.Position = UDim2.new(0.684584081, 0, 0.800339937, 0)
		No.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		No.Font = Enum.Font.SourceSans
		No.Text = "No"
		No.TextColor3 = Color3.fromRGB(0, 0, 0)
		No.TextScaled = true
		No.TextSize = 25.000
		No.TextWrapped = true

		UICorner_19.Parent = No

		Stop.Name = "Stop"
		Stop.Parent = PredoneWords
		Stop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Stop.Position = UDim2.new(0.0408339724, 0, 0.544481277, 0)
		Stop.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Stop.Font = Enum.Font.SourceSans
		Stop.Text = "Stop"
		Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
		Stop.TextScaled = true
		Stop.TextSize = 25.000
		Stop.TextWrapped = true

		UICorner_20.Parent = Stop

		Start.Name = "Start"
		Start.Parent = PredoneWords
		Start.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Start.Position = UDim2.new(0.359584004, 0, 0.544481277, 0)
		Start.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Start.Font = Enum.Font.SourceSans
		Start.Text = "Start"
		Start.TextColor3 = Color3.fromRGB(0, 0, 0)
		Start.TextScaled = true
		Start.TextSize = 25.000
		Start.TextWrapped = true

		UICorner_21.Parent = Start

		What.Name = "What"
		What.Parent = PredoneWords
		What.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		What.Position = UDim2.new(0.686146557, 0, 0.544481277, 0)
		What.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		What.Font = Enum.Font.SourceSans
		What.Text = "What?"
		What.TextColor3 = Color3.fromRGB(0, 0, 0)
		What.TextScaled = true
		What.TextSize = 25.000
		What.TextWrapped = true

		UICorner_22.Parent = What

		Sad.Name = "Sad"
		Sad.Parent = PredoneWords
		Sad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Sad.Position = UDim2.new(0.0392714739, 0, 0.6769315, 0)
		Sad.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Sad.Font = Enum.Font.SourceSans
		Sad.Text = ":C"
		Sad.TextColor3 = Color3.fromRGB(0, 0, 0)
		Sad.TextScaled = true
		Sad.TextSize = 25.000
		Sad.TextWrapped = true

		UICorner_23.Parent = Sad

		Happy.Name = "Happy"
		Happy.Parent = PredoneWords
		Happy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Happy.Position = UDim2.new(0.359584004, 0, 0.6769315, 0)
		Happy.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Happy.Font = Enum.Font.SourceSans
		Happy.Text = ":D"
		Happy.TextColor3 = Color3.fromRGB(0, 0, 0)
		Happy.TextScaled = true
		Happy.TextSize = 25.000
		Happy.TextWrapped = true

		UICorner_24.Parent = Happy

		Suprise.Name = "Suprise"
		Suprise.Parent = PredoneWords
		Suprise.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Suprise.Position = UDim2.new(0.686146557, 0, 0.6769315, 0)
		Suprise.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Suprise.Font = Enum.Font.SourceSans
		Suprise.Text = ":O"
		Suprise.TextColor3 = Color3.fromRGB(0, 0, 0)
		Suprise.TextScaled = true
		Suprise.TextSize = 25.000
		Suprise.TextWrapped = true

		UICorner_25.Parent = Suprise

		Wut.Name = "Wut"
		Wut.Parent = PredoneWords
		Wut.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Wut.Position = UDim2.new(0.0377090573, 0, 0.80219245, 0)
		Wut.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Wut.Font = Enum.Font.SourceSans
		Wut.Text = "?"
		Wut.TextColor3 = Color3.fromRGB(0, 0, 0)
		Wut.TextScaled = true
		Wut.TextSize = 25.000
		Wut.TextWrapped = true

		UICorner_26.Parent = Wut

		Its.Name = "Its"
		Its.Parent = PredoneWords
		Its.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Its.Position = UDim2.new(0.686146557, 0, 0.411795795, 0)
		Its.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Its.Font = Enum.Font.SourceSans
		Its.Text = "It's"
		Its.TextColor3 = Color3.fromRGB(0, 0, 0)
		Its.TextScaled = true
		Its.TextSize = 25.000
		Its.TextWrapped = true

		UICorner_27.Parent = Its

		Me.Name = "Me"
		Me.Parent = PredoneWords
		Me.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Me.Position = UDim2.new(0.359584033, 0, 0.411795795, 0)
		Me.Size = UDim2.new(0.279525012, 0, 0.0947997048, 0)
		Me.Font = Enum.Font.SourceSans
		Me.Text = "Me"
		Me.TextColor3 = Color3.fromRGB(0, 0, 0)
		Me.TextScaled = true
		Me.TextSize = 25.000
		Me.TextWrapped = true

		UICorner_28.Parent = Me
		--
		local TypeText = ""       --Keep this
		local Gui = Keyboard      -- The Gui you want to use (Must be a frame)
		local Gui2 = PredoneWords -- Word list Gui

		Gui.Visible = false
		Gui2.Visible = false
		TypeTextBox.Text = TypeText

		-- Keyboard stuff:

		local function DoCam(CamSizer)
			if options.BetterType == true then
				if CamSizer == 1 then
					cam.HeadScale = options.headscale
					repeat
						cam.HeadScale = cam.HeadScale - 0.1
						wait()
					until cam.HeadScale < 1.1
					
					repeat
						Blur.Size = Blur.Size + 4.5
						wait()
					until Blur.Size > 50
					Blur.Size = 58
					cam.HeadScale = 1
					game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 1)
					game:GetService("StarterGui"):SetCore("VREnableControllerModels", true)
				end
				if CamSizer == 2 then
					repeat
						cam.HeadScale = cam.HeadScale + 0.1
						wait()
					until cam.HeadScale > options.headscale - 0.1
					repeat
						Blur.Size = Blur.Size - 4.5
						wait()
					until Blur.Size < 1
					Blur.Size = 0
					game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
					game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)
					cam.HeadScale = options.headscale
				end
			end
		end
		game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
			if inputObject.KeyCode == Enum.KeyCode.ButtonB or inputObject.KeyCode == Enum.KeyCode.ButtonL1 then
				if Gui.Visible == false and Gui2.Visible == false then
					Gui.Visible = true
					Gui2.Visible = false
					TypeText = ""
					TypeTextBox.Text = TypeText
					DoCam(1)
					wait(.2)
				elseif Gui.Visible == true or Gui2.Visible == true then
					Gui2.Visible = false
					Gui.Visible = false
					DoCam(2)
					wait(.2)
				end
			end 
		end)
		BackHome.Activated:Connect(function()
			Gui2.Visible = false
			Gui.Visible = true
		end)
		Wordlist.Activated:Connect(function()
			Gui2.Visible = true
			Gui.Visible = false
		end)
		ENTER.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(TypeText, "All")
			Gui.Visible = false
			DoCam(2)
		end)
		SpaceBar.Activated:Connect(function()
			TypeText = TypeText.." "
			TypeTextBox.Text = TypeText
		end)
		WhoosVR.Activated:Connect(function()
			TypeText = TypeText.."whoogives vr"
			TypeTextBox.Text = TypeText
		end)
		Backspace.Activated:Connect(function()
			TypeText = TypeText:sub(1, -2)
			TypeTextBox.Text = TypeText
		end)

		-- Letters:
		Q.Activated:Connect(function()
			TypeText = TypeText.."q"
			TypeTextBox.Text = TypeText
		end)
		W.Activated:Connect(function()
			TypeText = TypeText.."w"
			TypeTextBox.Text = TypeText
		end)
		E.Activated:Connect(function()
			TypeText = TypeText.."e"
			TypeTextBox.Text = TypeText
		end)
		R.Activated:Connect(function()
			TypeText = TypeText.."r"
			TypeTextBox.Text = TypeText
		end)
		T.Activated:Connect(function()
			TypeText = TypeText.."t"
			TypeTextBox.Text = TypeText
		end)
		Y.Activated:Connect(function()
			TypeText = TypeText.."y"
			TypeTextBox.Text = TypeText
		end)
		U.Activated:Connect(function()
			TypeText = TypeText.."u"
			TypeTextBox.Text = TypeText
		end)
		I.Activated:Connect(function()
			TypeText = TypeText.."i"
			TypeTextBox.Text = TypeText
		end)
		O.Activated:Connect(function()
			TypeText = TypeText.."o"
			TypeTextBox.Text = TypeText
		end)
		P.Activated:Connect(function()
			TypeText = TypeText.."p"
			TypeTextBox.Text = TypeText
		end)

		A.Activated:Connect(function()
			TypeText = TypeText.."a"
			TypeTextBox.Text = TypeText
		end)
		S.Activated:Connect(function()
			TypeText = TypeText.."s"
			TypeTextBox.Text = TypeText
		end)
		D.Activated:Connect(function()
			TypeText = TypeText.."d"
			TypeTextBox.Text = TypeText
		end)
		F.Activated:Connect(function()
			TypeText = TypeText.."f"
			TypeTextBox.Text = TypeText
		end)
		G.Activated:Connect(function()
			TypeText = TypeText.."g"
			TypeTextBox.Text = TypeText
		end)
		H.Activated:Connect(function()
			TypeText = TypeText.."h"
			TypeTextBox.Text = TypeText
		end)
		J.Activated:Connect(function()
			TypeText = TypeText.."j"
			TypeTextBox.Text = TypeText
		end)
		K.Activated:Connect(function()
			TypeText = TypeText.."k"
			TypeTextBox.Text = TypeText
		end)
		L.Activated:Connect(function()
			TypeText = TypeText.."l"
			TypeTextBox.Text = TypeText
		end)

		Z.Activated:Connect(function()
			TypeText = TypeText.."z"
			TypeTextBox.Text = TypeText
		end)
		X.Activated:Connect(function()
			TypeText = TypeText.."x"
			TypeTextBox.Text = TypeText
		end)
		C.Activated:Connect(function()
			TypeText = TypeText.."c"
			TypeTextBox.Text = TypeText
		end)
		V.Activated:Connect(function()
			TypeText = TypeText.."v"
			TypeTextBox.Text = TypeText
		end)
		B.Activated:Connect(function()
			TypeText = TypeText.."b"
			TypeTextBox.Text = TypeText
		end)
		N.Activated:Connect(function()
			TypeText = TypeText.."n"
			TypeTextBox.Text = TypeText
		end)
		M.Activated:Connect(function()
			TypeText = TypeText.."m"
			TypeTextBox.Text = TypeText
		end)
		-- Predone words:
		Hello.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hello!", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Sup.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sup", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Hi.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hi", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Thanks.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Thank you!", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Omg.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Omg", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Lol.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("lol", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		You.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Him.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Him", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Her.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Her", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		And.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("And", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Me.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Me", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Its.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("It's", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Stop.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Stop", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Start.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Start", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		What.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("What?", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Sad.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(":C", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Happy.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(":D", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Suprise.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(":O", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Wut.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("?", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		Yes.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Yes", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
		No.Activated:Connect(function()
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("No", "All")
			Gui2.Visible = false
			Gui.Visible = false
			DoCam(2)
		end)
	end
end

if _G.DidVR == false then --If the script has not been executed before hand
	_G.DidVR = true
	
	local moveHandLSBox = Instance.new("SelectionBox",moveHandL)
	moveHandLSBox.Adornee = moveHandL
	moveHandLSBox.LineThickness = 0.02
	moveHandLSBox.Color3 = options.ConOutlineColor
	local moveHandRSBox = Instance.new("SelectionBox",moveHandL)
	moveHandRSBox.Adornee = moveHandR
	moveHandRSBox.LineThickness = 0.02
	moveHandRSBox.Color3 = options.ConOutlineColor
	local moveHeadSBox = Instance.new("SelectionBox",moveHead)
	moveHeadSBox.Adornee = moveHead
	moveHeadSBox.LineThickness = 0.02
	moveHeadSBox.Color3 = options.ConOutlineColor
	moveHeadSBox.Transparency = 0.9
	
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
	local ArtificialHB = Instance.new("BindableEvent", script)
	ArtificialHB.Name = "Heartbeat"
	script:WaitForChild("Heartbeat")
	local frame = 1 / 60
	local tf = 0
	local allowframeloss = false
	local tossremainder = false
	local lastframe = tick()
	script.Heartbeat:Fire()

	game:GetService("RunService").Heartbeat:connect(function(s, p)
		if character.Humanoid.Sit then -- Anti-sit
			character.Humanoid.Sit = false
		end
		local plr = game:GetService("Players").LocalPlayer
		if R1down then
			cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (moveHandR.CFrame*CFrame.Angles(-math.rad(options.righthandrotoffset.X),-math.rad(options.righthandrotoffset.Y),math.rad(180-options.righthandrotoffset.X))).LookVector * cam.HeadScale/2, 0.5)
		end
		tf = tf + s
		if tf >= frame then
			if allowframeloss then
				script.Heartbeat:Fire()
				lastframe = tick()
			else
				for i = 1, math.floor(tf / frame) do
					script.Heartbeat:Fire()
				end
				lastframe = tick()
			end
			if tossremainder then
				tf = 0
			else
				tf = tf - frame * math.floor(tf / frame)
			end
		end
	end)

	local function bubble(plr,msg)
		game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
	end

	if options.forcebubblechat == true then
		game.Players.PlayerAdded:connect(function(plr)
			plr.Chatted:connect(function(msg)
				game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
			end)
		end)

		for i,v in pairs(game.Players:GetPlayers()) do
			v.Chatted:connect(function(msg)
				game:GetService("Chat"):Chat(v.Character.Head,msg,Enum.ChatColor.White)
			end)
		end
	end
	--
end

-- The main script:
local function MainScript()
	PlayerReset = false
	LoadNet() --Loads the neybypass
	LoadKeybord() --Loads the chat gui

	if options.BlockCharacter == true then
		for i,v in pairs(character:GetChildren()) do
			if v:IsA("Accessory") then
				v.Handle:BreakJoints()
			end
		end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("Clothing") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end
		character.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
	end
	wait()
	local plr = game:GetService("Players").LocalPlayer
	local cam = workspace.CurrentCamera
	local Root = character:FindFirstChild("HumanoidRootPart")
	if options.BadCoputer == true then
		local a = game
		local b = a.Workspace
		local c = a.Lighting
		local d = b.Terrain
		d.WaterWaveSize = 0
		d.WaterWaveSpeed = 0
		d.WaterReflectance = 0
		d.WaterTransparency = 0
		c.GlobalShadows = false
		c.FogEnd = 9e9
		c.Brightness = 1
		settings().Rendering.QualityLevel = "Level01"
		for e, f in pairs(a:GetDescendants()) do
			if f:IsA("Part") or f:IsA("BasePart") or f:IsA("UnionOperation") or f:IsA("CornerWedgePart") or f:IsA("TrussPart") then
				f.Material = "Plastic"
			elseif f:IsA("Decal") or f:IsA("Texture") then
				f:Destroy()
			elseif f:IsA("ParticleEmitter") or f:IsA("Trail") then
				f:Remove()
			elseif f:IsA("Explosion") then
				f:Remove()
			elseif f:IsA("Fire") or f:IsA("Smoke") or f:IsA("Sparkles") then
				f:Remove()
			elseif f:IsA("MeshPart") then
				f.Material = "Plastic"
				f.Reflectance = 0
				f.TextureID = 10385902758728957
			end
		end
		for e, g in pairs(c:GetChildren()) do
			if g:IsA("SunRaysEffect") or g:IsA("ColorCorrectionEffect") or g:IsA("BloomEffect") or g:IsA("DepthOfFieldEffect") then
				g:Remove()
			end
		end
		sethiddenproperty(game.Lighting, "Technology", "Compatibility")
	end
	repeat wait()
		local a = pcall(function()
			game:WaitForChild("Players").LocalPlayer:WaitForChild("PlayerScripts").ChildAdded:Connect(function(c)
				if c.Name == "PlayerScriptsLoader"then
					c.Disabled = true
				end
			end)
		end)
		if a == true then break end
	until true == false
	game:WaitForChild("Players").LocalPlayer:WaitForChild("PlayerScripts").ChildAdded:Connect(function(c)
		if c.Name == "PlayerScriptsLoader"then
			c.Disabled = true
		end
	end)
	options.righthandrotoffset = options.HandsRotationOffset
	options.lefthandrotoffset = options.HandsRotationOffset
	character.Humanoid.AnimationPlayed:connect(function(anime)
		anime:Stop()
	end)
	for i,v in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
		v:AdjustSpeed(0)
	end
	cam.CameraType = "Scriptable" -- Keep this
	cam.HeadScale = options.headscale
	game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
	game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)
	print("Whoogive's VR by Whoogivesashit#2751")
	workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position)

	-- Setup:

	character["Left Arm"].Transparency = options.HandTransparency
	character["Right Arm"].Transparency = options.HandTransparency
	
	character["Right Arm"].CanCollide = false
	character["Left Arm"].CanCollide = false
	character["Left Arm"]:BreakJoints()
	character["Right Arm"]:BreakJoints()

	character["Left Leg"]:BreakJoints()
	character["Right Leg"]:BreakJoints()
	--
	if options.HideAllHats == true then -- Hides hats
		for i,v in pairs(character:GetChildren()) do
			if v:IsA("Accessory") then
				v.Handle.Transparency = 1
			end
		end
	end
	wait() --Main Part:
	while runservice["Heartbeat"]:Wait() do
		character["Left Arm"].CFrame = moveHandL.CFrame -- Moves the parts to your VR controlls
		character["Right Arm"].CFrame = moveHandR.CFrame
		character["HumanoidRootPart"].CFrame = moveHead.CFrame

		settings().Physics.AllowSleep = false --This some what works:
		settings().Physics.DisableCSGv2 = true
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		swait()
	end
end
local function Resetstuff() -- Remove it if you want
	character.DescendantRemoving:Connect(function(Part) -- Respawns you if you lose your parts
		if options.NetBypassOption == 1 then
			if Part.Name == "Right Arm" or Part.Name == "Left Arm" or Part.Name == "HumanoidRootPart" or Part.Name == "Head" or Part.Name == "Torso" and PlayerReset == false then
				PlayerReset = true
				character:BreakJoints() -- Kill the player
				wait(1)
				
				local plr = game:GetService("Players").LocalPlayer
				plr.CharacterAdded:Wait():WaitForChild("Humanoid")

				game:GetService("RunService").Stepped:wait()
				game:GetService("RunService").Stepped:wait(3)

				PlayerReset = false

				-- Return the script:
				Resetstuff()
				MainScript()
				--
				wait()
				return
			end
		end
	end)
end
Resetstuff() -- Do not remove or else the script wont work
MainScript() -- Same here dont remove32Is39UC34rI34tE359y39m42L532sS33Qi35O3329632AZ31Y132kA33Q5318s36bQ32jx37gI31xA327a3591395x36o4381531y42RX33YN39HS22739jt397z32HV2uy2Si39n338yq2l62II33p335ZM38JL36v434m031y632Kg21j37qI3a6S323X31ZF32a931vn329W369b33yJ324M39TY34E233Sj31Yh33no373A33Fy31Tq34Bp34Ta35cn325l2T435df21J36a239N0332q39Hs22432v72Jz339L32z832Lb33LX2Y933Gn356N33CC324H39KN23D37zV3a74397d31yz33E833KZ21h22F2S636At34zm39a92202sr2p132jv323d366U21J39sd37Ep3aAT39cU340v355933lB39l838Ei3AAt39z322G2T422h383932Z834GP34UK37vN324c2SR32YC34Lp39UC31402L632YV32Rk36fU21h32FO3a4W32J939oH32u32L6389m35592Ri39Il21H22I31zu387T3aDi31Tq32al3aAT32i839OB22i39iQ38p8391k37xT323431Y131U134jV21H31xu393736z9323x2G638sI34LV39Iu39jO33ux39II33C62l62Zt2l623639uC22B32m0396g376f320239TP39ZS35Wd31yj39Z334ep3a5Z32G932XZ32XZ3A5o3a5G39iu35q43A4u34y337UJ2p034Bb395z21l39B623839773aEU39E836D939gE36O531UK3364323r325Q2UY2Q82eI327M39J736Bo2eZ2t632mm35s22SF38V133d939E237Bp2UY3A6V3a1536D935hc381G33d9320439Il340036D933jS378q2v7381s32HW33d93A2623B33412L339oH38Qt36nX39lB39tp22D34ex32322rs39C833d93334354I39Yd22F396g36E539dC39Tp23e31uu39hs2U92L6340S2l5339L395P342o33Kt3ADS39e7343Q35Yr39nV324p34sF34qe36d92cm35G63aDX31zu37Xq31UM331I2eI324L38392t239uC34qW368034n535R33adM39L832Wg375r39u42ei36aX31uK2RK21h23e39e735T836eW39uc35tY3AAt3AeE33Fy3AFz34X533L93Ag13A6536z92Cp2tT2S632vl36eW33M32EI2tT2TT33jo2tT3A6V37a83AAT327i32V33aDG31UJ21i34xa36d932043A1q2l535vW34GY322t32z7327P33073aDm2sg34DN2L52s636802LJ3A6V21X33Zy2UY36V834Kb35P033b93AKG35v831WM32ye372l37Y338gf34ip3A2o35I734sf328Y32nq39rT38Vv324U22u33A2368M21G2283201225395u38Ur326p32cM34Ik34ew328i2EP37aq378r37ht21W31Vl21Z38ds23d364H35cS33zO32kc364736e934wk31W039LT380z21i34ja22Q35ua2l533ql22433Zo23034Jh23A31y137QA23832Gr34X2336139FM33Bu34N522F34t2394s326P3akr32ko2lG38nf32u331V738OT23E355q343E384r340635XO32J338Bh313x38hD36e931xi36hp33Ra36ae2T333XL22133p2351134zK36Ec34ws398635c536G93AgK34wD2EO320l34eX23837ug3AJy2lg33LX36r22rh31Uf343o38xG31X935Zh37Ti369m323v37Ak34TZ38xG34iP380y36DN33QP36cB36kG2ev39X434rM34yg373O35PQ21f22F383k33rg2RK2sW358D325r34TD36XA31ti347k39Z22p12Q83714326c22x3272311236Dn35MM321336DN337y36e22233aOs369835YS34K9387934nW37X3362e32pg32qU321l31Xc2r338eP22u37sa327034dN33wD2sW22231u9399936dL39L92SG39Gj31y436Dc33FA345934Yg36g032I935dY37h737r03Ap539IW32i0397E22X33HN369h35r92cq352f36Ze32S639mO350y36A234ti2l7373o21K34Ws38yS34On38OU390937sA3aHo23037Xj32v52e238aX2mc36NG32i8382F380636G032QP33U4355n2ao3A4a369m348u39Dc2uy32eg36hF33n42CQ352W3806369m37b336Qo341936D737iI345Y33QJ2t437o738vg32PR3364367938W331zo31yZ227323X32i738qI33ma3AIy2SD328M33cc23731vL23738nf33AJ22b31UR36a02V731V322c345g21f21y36vq38Ss32P236HF39a123135Mm22r39k733k4229395Z39K52Sd2Li22A2oY3767324N36EO22U31ZC22c36Gp316Q2s123836GG33ah337Q355N21x31vv377F39Fs38Pn34X52SE32h82ri37Rw36qo2S62qr379039v835Gz39c52Cq35Rx36P43Au238d533sj2ev397j38V82RW37hk38Md34ih38jB2cq22P321p2Gk2E237Z43aUk31ya22538S233Ed370N2EV39c1356Y39hS38at38LJ3AJ839T733662P135hC2BG35og2s629G324N31x923631Ya375L35OG341C33SK34a122932JV33Zo34Mj2e222138uO31x922937Zf37N839ER368333vt3ARL37k236Eo22D36BQ322d39v831u123336GG38al386I369H3AKA32g331w439Oe21i2s0337q343x380639Ob38xD33tl37RF38UR324n34jA33K12CQ32883au831tQ35o336B634zj357a39GK34pb38M832Yb37Wp33p222s35HC23137tc37663AVK33rA23333RA39jz349636Zm35Hc380o31xk36eo221323x23a36t739J73AKa37FC32Vw31WH225323f396j31ub331G34yP36ST37Ya36Eo22H38Ia37d531xk2Uy37AQ22Y31zS36hf22636GG22232vW333u36Er355932dE22231zg2sE22h333C2lI22F39d722733fm39R23AXx3AlU36eO3alj33nV32Q6339D2u0375G35H635j4375g38p82u0366034pb38qh32B037Fx31yH37zT36W433XK31v3332439x5355n22Z34Zj383234Pr342J37oE34fR34BU3ApC34j339yx2sP36D033nu21f34Ns31Ti3ap021i37KK22H32An31zj332Y35Uj31uf23d32ek33h135Y62Sg23d3AjH21x39AG351L32S632OG39gP33lj22X325v345T325l31C42fa330537xi332Q36eo391C39Ix31u922I31Vn31zS34i338H0332u35GZ39Uq34yg36DL3AuO332u39k739uX2q32y735Uj36Uu34PB3AI12ew3B0r34oX21F3ASv31TP2l62Cl397Z372L2253AVT36Vq366E34PB231343l3aWV2sy36xO39rr226327M375A231362e225331r36bL22636qc39f836w632Wl34TE32ex36fF35l4343633rh236331p36LE3aa736Zm3AHb33sS32ky39uZ370s33u323536E935yT32323AOs2h136ZJ33lx3An02EP372N341934r721I320L323233h936yI34363317389g2e13B3c335m3b3c3AFz32db38s439Iq37JB3ape36z132v033rh38f536Pf37Ew366b23336dL2273b2k33h6356h36e222731zc332M2Cq35yD3b3I39wv39iy31y42sW37pm37EW32vM36Y235nS363U375g37XY36zM333u34Xe34KH32Ky36U922Q34Bt2q333UW3764383K22837Gw34D9375r37PR32ky35Hc3aeW39z63ABl3766333Z356h38c733dJ34Ba353833B539gP35j439yD3B1R33Ka375g3a6n335C33Rr3AEV32Sb2u036dc3aSN34W032AR376s3b1Y31V838n73b1n3393339836JQ31vG363C2es23c34Rd3ADH36C034t222G35rS32Gm35jV31xm360539sT34Fl393423639rh38zP3B6A3aGQ34h633p435G838XS36CK38vv35sn355Q3Apz2Ke35sl2S9382q2kE34DK31uv33eG31Vo35A72CQ22234jj35aF38oR34dk3amG2k034C536s63b6A357L348s35Qu338W34c82CQ32Mw3A9y34v134eX31X336Hh37x434Ja36xw38CM346b39Du38M93atN35OG34si36xA33tl3AMJ39tt2lG34Si23e36Y23AL537rm2cq223331P37TU35Hb31WB32XM392s37xX33P832DK3ANO33WX2fa341d36g037vF2eV22a31wH22u35mM23931vv35Ze33663AVw34iT22D356036CP32f231tY3a1G37P235Og36qq3ArZ36vQ33IS2oZ375g239368436793AMx31vf36bQ36Ak392q37kA334823933i2365A37DV378X2oy21x36o33A7s38yQ3B0634rg32a233U33Abh328w33lj32Oe38xw2vi21u3B4X35O036Dl3A8v38tF334p36NH37JI376221f359338Xg38D2222339B38Lv33P937sq34eK2e23a8b3bB431u333jc2u036Ae22e38ia33d836lr31X9347836Ez36u923A323s37Mr36d837WL2EV35SJ33ne34Ex37jk37dv3A1C33M621w34qM22D332h37OV229339q37ht23B348y37p12Cq21X340322b2sw388021f35S42CQ351G36yg372L22F33lJ3b0g37Nf34nK375G36Ux3aoE37N839TD2rV33M62Gn37Nf33r821X38cO385W3bCd3b1F227330535M72Cq31zP32OJ33H232Qu342J36U833gn369k357i2ev360037HL3ajF341G33Rd34c033jU2lG38bV36VS32SC331R21Y38e336rB399G34Jh371121c39HN380633L9349O23A3AKb375g35v533F631vQ36xa37Dm34d92NY340e33dT2oF3Bb438ge32jp348F2cQ23231u939Gq38en347k3Ba62CQ35OQ33Z2324U33z837Fp369l37DG332h37Qd393d37Sc38Rj37f32cq376V2e2361336X3347x35Dr395m2Y831wh3aH232z737SQ38Yq39V137G532dq3462322r31V83bfn22y348y36W933OW2s92213Bbz398q31U334Oz35Ys362e3bg0357z37uA33jS2ew39OB22h36EO363v3AJ42l621i325O36E937qu394Z36dl22I31W922d39aG3bge38wJ3b4G3bB136F836ng22i34ce36Ae23E36CB370Y31u5386U34J4348m33M622y3aVT35jh341W34n833J333rD33Ef393d34mx368522236Gz34J63202369H22w35o332bF21I3Am2339e3au239IQ2Fo2Cq231369K22038j52242cP38eg326C33t92cQ21u331r2313aGQ39BV3a2r33Zo21T34pw355f38Yq3305383k31wX2ty21v39iI36Uq32AU3aos2343b0R38FX32hH3aOH37LU2Ev37n439B33B9I34rJ3asV3894339B32oV38Uh34nP38xR38Wo39Cu334832AU39TP2l437t134Wd38E333V533za381V23433nI37nZ22Z2Sp227331P36y4357C33zO3B4w341S33QP37X13ax433za38kF2RK31Zt38t93Ay6392S34Zj38Na3BAU384a3aSo334w36vn38D2320R36dD355q3a7Q3bel3A8u329q33k93A8237Rm37XL35E538Nf21t31W939il333s37P237DM2e331VC3ao3325L2LI39Iy3aoe37n533zO3BeR31UP2SW367z2R42r23acu39Mx3BF633hR3aLU371N2n7341s336136CM34W537G532sz34kp3agh32D538d232XZ34so2r433q1386J2R438DS34js3ALU37aq3ATC343K33gF389z3ajF23836u433Jm36jq360R3Bbo38bV350K31u537Sc39PR34SX395731W6339B23534NS21J381S354I355O31vI37sa39P431Ti37rF390e310P33z234033B2z32Sa31C435Ek381V394832403bMt34Mz39dZ23638GS3b0132kY2SE3bGM37Rm36g023034D922w33Ay23831U122G2SZ38YY3436343l2363ajH320H39b42Cq36y221f22336DC22734C534nG369p3aj836UJ34O434ad23234aj23633Z13399336122b2R233QU3aOE38nF39hE2Sp35hB338w39h738gB39JD39l8328s397G36MQ368033r821w339S366e2oy384x32K531Zl33q13Aiy31VH333f39AU31Wj31vl3AZ131vh39w236eW31Wj39uC36M62FL3agQ38a6369P38ns3A72344k35LC3aDM34o433P223834n822a3a3x31Uh39z82F835J439gb39UC366B31vh33k938x3329M333u22D36Jq32dX36W633B522D32cj34cq33Qr3B9q2cQ2w43BdG33673AJq38bV3afn37M234yS22G39k7228373O22E33Zo36KJ2eV33U536Bu34Qm2Mx38XG3bhc3bPa359M37hl3a7j334k38My36Ga39Dw3Ai923833143ALu33M137vX369L33pw39OE37Nh2Cq33l632qu3BOE23C35MR3Ag1239386O3AOs2sC37Xy32Ct37tF350t2ev21Y38dd2S03bS537ug22Q34JP3Bd32Ev3bA02Ev36VX21g322l32sx35l531WM325v364c38ou38jL3akX38lj34qm21L39s03Al53BsI33613AQY36v2363s33Qr23B33P236ff3Bsi34IK23732i838D521u3391389K3bTc32Z62sv355Q23c32Og34V234Jp390R2Ev3bsd2cn334K31c33Bs531VC3bNG21G33r5366234GL38Ns359T35HB36yC37X139JE333U34ex34Dt361f36Hc381V22r31X931XC34yG375G38tQ2rk35k133dt3b2D389434t23bsR2Uv348Y36hU38dn33jk34U6382V3B8u35i733C32lg38Zv34Tx34ed36yI3Ai933dr36CN36dc39BI3b9138kh38Am23e341Z3AG1354s32sX385523937xj22s388D33nt399W34Fh32Q638E834qr3bsb2EV351S2lJ35s935lc3AwV37H733L12s622X38Gs31V13Btn33iG39W42EV35PL33982CQ22438Nf34Pn21I381M2p134xM32CQ356R33lp3aL037NZ37My2Kf34JP3bPp2kf35mA36dN38Wd33AH2Dc3B8234uv31ZU36II3bww362E21C33192kF33V232CE38En35ci2FD21c35Hc21V335b2jz34T221V3bWk32mW32er38bh22234KP2mJ35283b4x33GW32td32er326434yb350I3AoS37zW32YB38nF2353AgY22H34ys38Ek23c38j521Y34td39E538cP39kN21c34Kk21t38aM3ArD2Kf3al437x122439Rr36E221i316N33BU34Kb321k34wC38bH39Z0396Y34ke36md35jm36HP35q834wc39h422g3BvL36NG34t634aS32ck333Z32vJ36Ec34R239QR32C434w937zG36Gp32i7384336Bt392R34x038iA360k387i352Q36gP38Iu365V37SA38MF37xq34t23AK632a234iP36P734I538e83B0k36DD35UY33Ay325J38dN338S35uy34Si36kx34v134wU22I38J536Dl364X32qu332f23e393437E52LD38ep22x34xm3a8934nw332w2lg34yS22P34WW36bq38dc3BwW37p635iV34vs2kF31wH37Fk3Bsg32OG2kf38NF31Y13BWw34rD38ti36Mt2fC366U369m2cP35yw38d522y32QG37TF22y37n837C83BwW36e933I738G63bRn330Z2BH38G63Bwm2E12JZ37wc36792e437X134fw32ER3254383N33r338bz313T2F935q0330C2Jz2FD34s2393732cK34Ke38k222334BT2lH32Er34N834173856381S33sX356R3AoS21y34kb36r2334u335M36KG37Qa3aQ133vN34zE34iK343A2k5343736o3350i36BQ23834It3ase2ev35os3aU237SQ23D37q321z3BID38bh3am73BwW37X1220345G3BYo34mz38GM3BWW331b34v238Sc34i3355p38bs3b3K3Bud2CP34PF33j93bYo33lp388A2RI34d3336634i333023Bww38oT3AbW39b336Qc34rC33if37X632FB33if37TC22V35lC22q34Lv33VT2f9332h3BgU392q37tf3A1f38cp33Ig35cJ2cm34k921t3b1F37qR37Pw385522I3BSV31Zu33tz33if362732GM381V3b1721i34OS332O37N8380O38Gf34n93bXX31vO21V33y938Fh32EX3AMj32y2378i38Bh22534d93a0y3BW732ko38zv38GF37qA358T393A2EV3buk328Y38I2384a37my21g23534uk3auw2D532SB2cl33c32cl38J53b2A3a1L2dc387234BB331B2cL343721Y2Y72F937t621Y34s422t34Ip21W36dw23137n83728387V21G22737xJ36VV3C71323X354o34gq352833l334Tg3c7131u322r38hl37RF36PC33zA37xx34762dC39gY38ng33fo2cL34Kp37K33c853c2g3b7Y356F37RP38M632Kp38IA3732341C2cL33Zy2dD332w3AI33c8538iq3aOs23335DB38ep34G735yF36dn36ew32Sx2r2388034UH34S42IY38dN33Mw38bK2Es37Cm3Btn3BLE3C6638Eg39In373A358m39Du227338S2f932yO3Bi037tl2tt3c6v2dc3BV42Sk3bK033If34Cl3BtN33342S935R93c3638wJ37Xq34i622U33Nt36Ao35r931U122S38nS23434k935jE38EG328x22438K638dS3C0n31V439Sd3Bht35OG32bF36Kg324U363E3c3M37TF382j220328X3aQW3c713160332I3Aey3A1g33as327T36G13Cb238kF22h3CAQ21i3B0r35Z03au234RD35bJ359z33A23bGK2dC36gf2eV37jH2EV35P03CBl33072JZ33J92F93C9l39R0393Q37x13ByS32yB39SP39du22938Ot23533lE39FK31vq37vb2CQ335k37Hl3c0B233328M38Mw38bZ31VO375y324N3aOs3axi38Xg345o33rh35KE38b83B9134Y338Q934Xe37P222A3bXl34qM22638J5376F35R93AiH34Mz22234n522434Jj35GI392s3b3k22H34zG39Uv32bg3500340a35O433xr31vO23837T622r34tD22a33n121j353235UY37aq21J38sC2Fb2JZ33RA32h0392s352q3CC6369535dr35nn370t34ns33QI367C36qo35qk34rJ3BO335lH31vQ3bl839y935qY38bH38Qh2m936d634tx33Qn3AJQ3c9Z3asX35qu33A238Jr22b35mC39Du3C3d31X834ZJ23634pw23834Y3344h39b334kK2303BTC3BQ1337Q34Pu22H38GS3bsf324N33Ql32y42DC324521j34n539UK2EY3bN332g036EC3BQo3a5a2dc3bak33FP37wC21C3C9Z379k333d38DN380034W9391s2DC3bb032NQ34IT22934Ns37e231zO33Ju33Rg31yH34XL38PO320437A53Cg935G832eK3cG934Qm2Uc35qY34WW3cCk35IF3CcB3bXe3cEU33qJ35ix38JQ3c2j22Q34n833D42DC352c36o333663cDz33Aq35j436e939Lr36e334WU326O380631td32N12e234h8378I2sa31ty372l379Y35oG34372293cHc366u22e381s32X536Ez36DL36pP2DC21W32W1331i33RG332n31uV34QR375j35C034Wu2293bXE21W38z83c783C1E35Ts391234Jh229336732Km33JO334U3bXE38FD3CG9343723534SI22834pw39lC35R436bU343735nN36jE37Ya33Mw23432Q021I31xm392S2EP35J321j21X3B4536fi2dC2Ul2DC321O37M236U938X639MD33gX3c2g39zp324N34mx349836lR34pW3Awp35og35Jq3Bx422t2SW3B7s3366371N32203C9S38nF35jP3CI533jo36Kg3c6U38H33AWI3Cg934r22233c8p389535Pr33Z13Cdx34Ww3A1K32NQ3C9Z3b9R36D832Jw37wc3aSp36bu33A936NG21U339s32kM3CIq32DD36fq33143cjh34pU23933Lp32Km3C9N352932Ua3Ckq39133CDt34KK3byl39lB33NT3B1736kg34Mx354s2dc21X39sA37aF337Q3ChI3chQ390M3bwe31Td38BY21j327Y35hY34ww38p63cFX33fm36eo37RO33H636kg2Fd2c72dC22P325Q2kf31vO2373bX439NQ34IG33ov3cM534JH3Ank2dC378735k1339132aX3CiA324r2Dc21Z34Kk2393cmG3Cmy34dc35DV34U633WT37M23cDz21v34pf3c7822u34It22a3c2422u34Jp23934nS29C3cFx3c7833Nw3Ch83BPI3CMk39Ux31X83ci83axN32P23C2G22W36HF3c5E3cH833Nt236330p31u033Le32km3C2437Mm3bYO37pQ2203BH93c9l364K38ou2FD386Z38QX3341352534Si38ss2DC22U33173cM535Fm339d2Q434Bt3cM534Jj3BWB3cOS33qL2aY33H23coS33nA32HY355K39Fd31V73c6u22x3C8833583C9A3Ckq3aoX32a238nk37P636hW2e438D537Hm2EV34f035c03c8N34w02Fc34R237N12El3b7536CN2Vy33Jn392q37rp33Nl2Ev37qM392q32PB3Bux350K380636Nw3b4X38k7388A2s622432542263b4537y3380636jq3A6F35C0347K33E834A733Bg39YX38Ot324636P73bCF334K21U33IJ3B9634oy34uk33tq33FP39d434T2328e3A4t37Pw34Ik3A7s38mD39eK34r72Oy36FH3Cb23855349o34v238nF32yr38Xg36r631Tq38H72So32BZ37RP3648396Y384037E83bsG3CbU38ct33Uo389A355o3Bg63bG02YJ3cKF34Oe31v635g53Ag133x03c1i2f9381V36qC37so3ao837NZ328z3aUs3aQx37pQ22c3264376x2d531vC321f34NP3c9n33x633If38Nf2233C9L3AjQ3CbN33Cc38ia38bM3A4a37rp3BtI2eV3bnB3cTD39hZ21c3CKf38NP392Q34t333QL23a34NS23a34tX22E37Wb35ba339H3BYO384038JI3B4p33qf388X2392Sg33K937xj23937T632qp388s34RA38Ns23B3ci8383c38md37x12Zr33QJ33hn34v82L53aI32T633r822X331d3CU438ns3BAE38hf3B8K348p36dj3ab23c2G35oc322P38JL22H3b0R23C32hp322t34iA32Zs31W63c1i34x537P63CDN38t6362D31xU33JF3bsg38nS3av93a4a37Sa22a34mK38nf22s39Go33qo388H36Hp34Sf3A9W38cg39PW333f23b31tQ355n37XF37tC22g326421K398M32lk32Mx39H43A4t37HU32K337No2Mc323z3C9q35f03A4A389R37qA3anE32ux38R836eh2s923b39863bHT353938IA36Wx3aWd37k2388X23a2fd33w6338M38v838lu332y2Kf31uj34QU3COS3B4X22G334k3BMb3849330z34wt3bwW3cLA37xZ37pW334K350X2l6335b3cjC34Gp39Z33A4T338139fX39Vh3BIv39hl39JC21h38nh3A4A34D9336I3bSe320T22T3Ciq3bDk37Xf3AGO38Sk3Aus3cuK22637RP37us3biV37SA22b3CMk347i3bSg38e322g37tQ34e236eS37p23c3L38aV35zu38av37XJ365336Mi39b339Z337k1388a33hR387V3C9S34JP386A3byO366U21Z328X3CC43cQ736HP3bMa382V32s63b5d3B0E2eV21U39Q1323k21X38nS2ps38v83CIS35Oj2Sv38XY33H338e636d233P334rA320T3CDr2ev23A38eB31V136J833q5357C3cIA369P2k5379X3B0622r38kf22d3Ajh2v436g135o337qA22E38453A4D38gs23A38AM22e3cBj3AFZ22h33m136Si392F38Or37Ug2y538or2SP3Al338Xy356G32de3a0536Qo36fH37P223a34R931uK22B31wH2Bj3A4a39Hz37uJ38mQ32Gr3a4a3c2436vQ31Zo31Vo22032vw333R32gZ31TE31v732E132A1340338xD34r738bD3C523bhT37C2384R31Vo35ek2CN2Cm35kP366Z37PQ38B134Xe38DS32nr31Xd336T3cX73AL034LW36yd3cBV32Fi37iZ3D2t33h334cY35z637vo3AaT2SP36I835MB387S39m73AzX3aim33t3320236Cx34l82cq36233A3R3CI83bFt37Ro33BQ36IT324Z320U39sd3b9j31x834K922433mg37H431W63Crj352l2sw22c338W22r3cUg32V332s934xe34c534R721j3C3J3b1Q31Y533iG37Ak397V3D4034fP338g320234jP38B337M22lI33M0340E2vi3595330X2L233Q122w32d234Si23238J539sy32623D4H2dc237343x3D4734c535fw31wQ399S31vg39L22SI33y03Ch839kn3BR231W63chQ23733z933RG3C7832c2391B32Y531uo32y533H1330o3C243AVx37HH395I39v122Q3BHC382738bd375r330O3bG632ZN3AQa341w33QR2Wo39DC39e239qY365j36dd324u35oj33YM2dc3A9b393D36123CMR32ii329D3bhc2T237Zj32dI39LT2Eo327O33Y9237325239H435uL2DC37Xh398i3AEW3B4b3Coa35vM3B4b39dU34Ny334j39cW39HL34yl34C22Ml34oY33ql37T433pt39Dc37rk34T233ih2M9396i37so35MB39sA22131zc345B2DC2mR39kj325v39tk37GM346j35Yz3cBU35ww3b1Q325r39B02R339Cu397936Zz31tF3b3m3AE732YB3C8N34jM38dm31u5333639t332HU2CQ36qm33lt36742t43D5Y3bGd33oV3b3c343L34Ng33fN36F8345g21j23C33u32ZT32YE2cM21W31YA32yx33Up31y63atn3a2r36jq23738E33D7a34RI349O3bmB399r2dc34eb3bGS32S6333m2p1326K37Xc2u033Q139a332yb37xX36Yn36xC3Ahn398638bd35Qy352Q22635243caq32ta375432qE37aQ3BaV3bPk3A7m33AS32yj38np39OV21K33p23asp2Oz3cDZ31ZJ2cN362e3Bkl2Ez36BQ3CQj2L632sy33132Dc2an37l5320L32Q032CU31UF22P369H2343AMJ361q39u52zr2373B3f33l338cQ399G3agy37eX36dN39863afR3ag5391Y39jD34Lv32yC33M622i31w439NA391o32gT31VA3aED32S338pN2l339e7373L37hA398133FZ3b9732Z839aw37P633Fy399q34Vn36lr33Fo3A0k3CMK361b31Vo3an034S73caQ363e33ka33bU3cO8384H3ACS33HN3CRq323I37bU39Ob37TI2dc23A3b0k3AL037nF33V2227358E3CZ63A9b3BAU3C9n365B324032h533bT3Ag1354U39h33Dc234P23D1W384t33fM348p329d3c4G23B331G32qZ344K3cLe22d3B1F33nR37l5328m3BON21J3DDb3azP36uE33p93c9Q3cHz324I31TJ32c938KF36nu3DaY33mG37Ws31V7341Q3C3Z36mz3A8b31zh36ve3aYm36cn36QU397z39m329N3A4u37Ht23239tp38x93aCS32BL2L637b823237p23630343839b4397y2F039rr375c394z392O395Z37b02fN38e635vF2ew36Xd38093CWP35Ul2ez33i238XZ328f345G32dp33yV2F033N1320y3a4U32bF2r233J92r23D8B3395359O2MN39I43C2E2EY38d2371U33nv333u3C993BOI394z380936Zb2Fn33H938px36cX365u39783bON34zX3341326F384T33Ju2F0339134yS33Qo336735dL38t62R23DgY32c4344k3DGW343835aI33iE34Ri2SU2CP34M7396x2Ez2sa2R23d8w3dbI31fb31xg21f32yo39mP397p3Df2335m33FO335m369h3Bgb335M39sA22G395Z2T239NC341136GP23e33Vt39ri35eK36eQ3BqQ32tL326j39uc22535hc34D834jq2R0330Z21w31x03279343l391X34m134843394340321z33hR3dhV32iJ33P232DO38q72Cq37I332933b1f21g3d9A3a8n33r83AN633Gf39HS22E36ng23e39m735hz2UV3DiP39fX21F39mM233383B34h233mW2L43C2n399431vw2s33DE03alU330p329331U336hW2uV36Wq326c36Vf357S325Q357s33y933p83CM536Fy371G3dhP37D532I036D93aG138aP31Ue33H934Cc3B4u328i34M239Hw32cl39lX3D2f334k34a939yT2l63cNJ39o33cAq3bSZ22A39iu22039d733MW32Yj3AEg35jM39Cu32d92r331V13as539nv32j939Hl39N039x737xx37zJ33D9327o33613Ddv2Ei33463DAl3D8W37hr2rV3cvU32se39Jk3cxP2Zr32AL34nT33b8356F2R331Zu3Dfa394S34ZS2UY3b3k359i2Eh34d93a4E2uV3D0E2uY332i35kq35WD3aFz3DMB342033Ux3ble38U0387T313t2Da2e5366z34I437RO39SV3D5s33H32UV21j31Z934bT2eH31TH32rp328S32A13cW632C93dhP35V036f83cxq327j3bNf39I133ey374935Zl32xz39TP36bt38HF34sf23538DK33Zo3D9P337q2VI3BmB36co332H33Ey33Lv2L63aBW33Fa39YH3cmm32G931ZJ33WI32cm31x93b3G31Xn320h32rD2L6333I3D8122S3dIV369m32933bUd2UV3bme36n532403Div39ix3D9o33JS32e231uf339V37363a1V338W3Ddv21h3C4232K531U139zP34W039q122C3dIo3AhB34MX33k437UY226339B21c3dHP360031Xi332W2e039OB31vY2UV39sY32iJ321p37Wj3dpq39I13BNB39Fw37EL3DhI357c3dPQ2SL2I633Qo320l33CC39K73dP437Cz3DP336Ng33QN2f03a263c842Fl31UR3afk2Ns36Zi31v039Hw37i139Vn32nW33z12E032Cm39r33CIv32zE3b0622d39sa39p9329333C332933AJd32cB3c3l2M9331421K39sI3DOO31Zc38M03DjY33Ow32yC33TA3Bp032Na34PO32ko3dh439pO3bwp396i22w3dJx3DQ135ZM398632eQ32ee3bQh3A6F2S031yj32mm38R63DG331XP37rU362P38rQ3DJX3cs439er21H373i2eP32og32EE2Tt2Lp35LC3Clt2uN2E53Ce23drt37tl3Djx2UO3a133Av239YD3dpP2UN39862203DH132iC354538H536eS350x376T3Dhe3AHx3D6932eE3deQ3djh33na32Ee2EO33QR3dp222W39HS397f39r739hl346U2Eh31y1367Z32eQ3A7Y396g35CQ3aLu2cn3DG337ro2uV21v332N38b533LP38h532AQ3AeV333Z32wY3a6v3cnP35Tl39sd33Nz33B837CO398138b539Ob3cIv3DOr3dk139k73dtG33qo343x35rR3DHI34ca39R132Z632EQ39Zc39M722X323x38rQ2Cn33Le2e037N12uv353P39nV339D35rr32Tl2T13aLU3dur3a1t2uV3atN32k539rR22036Bt351n31u433y9326o3A1534kB36Qc3aeG3Dfu31Y033Za3bux3Bo038Z535tj2rX33953DME2F03809380331vM3AGi35su3cZx2da332y2eH33z92Da396G32kx2tY3dn13Bp032C235mS3a6S32i83DGt38a33a7c3C9u2da3b4534T036xH33QR36xH335C33Wr2Uv21c3b1f31Wv331732e233342dA36Bq229339s35rr39SA35F538OR39Uc38323a5i35k139m323b32D231Yj3DTZ348H3AIS3355396g35bC37u53CUG34622Sg35EG2cQ34ra2uv21K31U1350v3A4u38b433dJ32pB3DgT21L32k33A2W31Y53Dv635C732cX396g3bT336zM320t32qT3AHx22c38qB3dsG35u83a723dSe2WO32YB32q021K38if2cQ34ZM2UV34XS39rR35PE335C32Ev3679323433XY32dU2UV3C8b357z335b352F331I352F32643BNG3a7239Hw38v73dyT39HW22B38IC34mZ32nn31v433nS3dQi36eS21Y352T31YJ33Zy352F3BDN32Z63dYt332F3c0p33393a9i336136hF31X338ku2uv35z6365V3dSg347W2Uv36G03dYO2Uv2AG3E0e3dHE32993djH33M33DXz34ww2253DW92203DHU3aEe2sA3Dv6390C349o3diw3A7233PI36g03dIW31x33DQr37d8313y3di736A53Dkw3dzw3Bhx349O35zM3DfY33oU342039x53Dfy22w324u38803DxZ34Pb387v3dXZ33WX22833h631xr359932d5331B31xr3DSg3dl32UV3bFw3E2139mE3dX238ke3dFW2213div38FT3dyT33ef3DXz34WJ3DU53au13e073E213e0T2e53caX3e213C8P35ho3a4231x33dHp3Ais35R932ds34MK3aSn32dk34NT38Et36cY3Dvy2RX33qi36Ld3c2g23D3AJ838a022139H436UX32ie32CE31UY39yd33PP32Yn371p328f2yj31W92aN33BU31Z93AjY32iD32C93ad033Ie2S03aGg39Hw36Wz2l63E3b34Wd3CuK32mn39892Ew38et3akU329333bT343U324132Zo2L623d31w422132Ld39hz2Bo3Dbm38eT3A4q3cyT38kF23636O3365P348421K32c733763E4S336j3aR138eT31uh39l92l635GM36Be38ET344x32GM3dH13bXm375R31xt3DMs3aEh3awb36CQ32sb3E47391D38tz35EU39K739jO32Yb31y52T62sR338H36nt32dq331e31XT39kN3DkU35Z23djk35TS35cL31u1342B33Oh2oz326422136Cx3Civ2q33AHB33w43AIQ2EI31Xu396R31vD2t422Z39H432P8320539CU39Jo329d3dG33bEG36CO38lw36hP3duW2uv3cup34uc3ClE38I339uQ33AK36D9398635QX32e4341Z2Y732E43Div32C5320u33Jo32E43E0n35em328F3Dwb3e622Ew3bOE21C325V333K34f4327j331D37ko31XT3dHP22232aR31Zg33qL37VH32e43DTB35JJ3e6v3dpm22531v336co2UV2313dRl223327m32wq3c4E38CT2UV32AJ31UP3e8f32BZ39J733I7375F39V72eI39Ty3e6K38NK3dtZ3aC93Dk1380938Qr332U38b63e5f35zj34yL3dU121Z3E2536Ry320C3Dsg39z23DMQ3CW02l63b9C2uV3DYC32B03Dx436GV32cx33462FB3DYt3dgW34Cn2uv23233K939yL371U3CHQ3A7u3e0938092263dGY387H352F31wp3CoO35FW32TX3aaI3D2u3bB534w033H1352F3e772323DZW370G352f3DjX356b3e7B2Uv33Di3dZ73EA938Vd3dz73dGt2b537EL3DX235L03Dyx3dSG36zS3dOO39S023b39cc32on23037Ul3DQr3DD83e87380921Y3dGY22x33053dkL347a32AW3DIv35My3cQ733q82R33CrJ3dHe2223C4e36Vr3e8738YS37M136Fb36ES35F236fB3E9K32bw35yr3cW733Ac3dMS35Go32Sg341131xT38YS3b5K32E43Dhi23031wm33H93e9r390z3DN13dRL38GG2uv39YS31XT3DZw37f639fX2MN3du139UV33dX36o72L5331934a73DmS364p33b22t12243EcU3CHw2lj3dU52353dHe2283DZw22533073E4s3e7c36cb3bLA3e6V3dL532V3335M35wn39J73E362UV31th2uv2243dX23cgD3dVd3DWB34Q7327339Jr31x53DqR32p72uv2253du53ebX33iE3dGW22Y329n37za33D83ED43dza368b2Uv38Mq34a7380936513DU537QG3EED3dsg35P63Edm330c33b232Gm332n347A3DZa35M535YS3djX2353B5u3ebo34a73DHp3EDD3cC63aag36gG3B9J34A73EDI3b6P3Eed2t23dPm3a533Eed31tq3E4033iH33vn3DU13czf33vn3DIV39g22uv37Qr33ft2UV2353e7C37Hk34Hf3dOv3e4o3EfR3E7737f62cN377C380933sX31wL2R32cM2lF3E4C31ZX330p32Ic3DOV3ARV38si3DUN3e7l355i3D2038z021I21Y333f3cBc34zq33P93DiV21Y3djx22B3DGW39aM3dZ73dfy338D33k4327N3ap035vM3E7732o72UV38Id3DD23dmS38a6360639Ov3Ag537Jx3A4e31wQ3d9c31c4325Y3DHP22031xm3drl33OK35io36eZ3dHE3C4j3bj333BU35633brI38qx31yx32QU2l53Dx835wH368G38UZ3alA3dpP393739rB3cW734NP3E1t32rm3a4U34nw2UY36Qc323V3E8H38Rq3AOW32dE33uC32Il34By39n536hw31uJ3dM03A4a2S638NG2r339M73AEp2AX3dwO326132Bt329W31vy32LK32l032Eg326O2e5327m2UV3bqK39692l5327O31Ub34lb38d23BVe39b33Btm2fl3ABP31yj38ia22731uH39hH2Uv3Ar731vD3dhe37wJ356X36hW3Du534cP3aiS327H31vE3eiu321l39qr3aDs3dSe22d3EeR32SA3eJT3Dl533463EER33HV32my3CUT2EI3Du5348N34rK371b35593DYP38Co35p4376231x3327O395Z3dJM36ep3DGT3d1121h348E31x3329N3du137Mm32e231Td21t35ph39sA38xS3e9D32V7342y37ky32GF2lj338S352f33O932yC2EP221325422x321l31uO38LI35y63DYm395p36FD39k52eI366u368k3E3y3aJ533LZ39Ag23d328X37O43B4S3e3Y39IU23b3dZW37163E4C3A6v36kA3bdG38cO3bpP34HH39Z335dr3dZA22B3dV639A739Vo397v2232s93ego32Sy33tl3dsg3bsf21k22b3E5K3eB73e772303dhU348P36063dRl36a0329d3dMs35qF3daM349o35E432Yb31wp3cAQ36K83e3Y39hl36UX31Xk3e1T33GW36063aB531zg3b9k34A7333u3Ebc321P37He3CUK3E3j31u234nw35sf329g37mr31yH34uF2cN2E537Ok394M38B73E3C2l531VN36Ey323v32dj2mc33Tn3DE4330m36BD34Jv2zs2uV23d328m3d7w38NG34U22sP3aDx3eJt33Ma3DE43E3I2rr2V6338h31tf3ELJ3491373U2l53dX23dW0323F3D7l2l531wm31tH338H32dE337n37ME32II33lJ35DW3eJm3451397f37T632k13e4R3ahM33Uc2ri36Z0384l2uv33563EQ13eCu388H324731v32Lg3D2e3aAT3DR23C093edE33UC3afi37g33Eq1324532643A9436D937o3326c388a2cN3edi2233Dx422F34ZX3eDi3ayV36HW33412vK313T39k0332u31zN333z37wG360B32043DOy320G3dMs32ii21I21w3e5f33P3320G34Ys3EiH33I83Ebn32Bz32Yc3e9K358j3DpY320G3eA934Sr2uV37HM38Xv345n34u838b334gR320G327223631ZC3a7W2UV23a3Dhu23234hb34WU21Y36PY31uF3B7s2vj37oP32eS3dR823A347K38ss3364320G3dSE34eB3a6r2vK3djx23C33oV32e232LB32e5328X3C992k0321l3cuj3B8G32sg3Dr83CFW3ESR3E9d344X37zV33k73Dsg34vQ2l534bt33Zf31X83cBu39a732SG31YE39LH39w236Bo2Ri340334FO21y31zJ35O3324H33lE2Vk327m39D739kK33J23eOS325o33Mg3BHO32SG38yS23734zg38792q536EY326m36VR36bD36At388r3a5M34U83Be42e431YV36Bq3dF136Bd34xA34kE3Ecs3ech3A7y32Lj35Og323j39RR2ZS36xn33lS33ji36752uV21X2Li3eis34pw3E8L2Q434K83eJB32md371G31VG32C2329w32cM3DFu22i32in33H62kh332y2E139I43E40386s31VU3A3H31XM3BNC37YR31UO3Djo3aBp33Hr2KH345G2Q52e12KH3cB136fg2oZ36Z02KH2sC33ef2kH3dhE3Cvt35233b1q37w933Js3EVP33qo33912E134iz38t833Ei365c32Pp36hp21C36kf31y539J739qV32Pz33SR3DsE3Eqt2L5324l33B03eq1332g39482mj3evj39kN3eU033ux31wE2Ri39e533UC3E0N23E32an3elj39la34YQ36bt34Nv2K0320h31Vo3ctR36c032523Aw9332w2Q533qR3CSv338s2vk32GT3dnB2oZ3DV03Ahj32BN36vT3eQ133342q539pM3e1T35uE2rR2sG388c35yF36PY386W31U9365H32s637oU330C2Q52s93Esl31V83ad635B32Rh37jU32J33Eh636da32k433X5393435Vx2DC23233h12F83e9K23733n135ZX3dU537in36hI3eh031ub3ea923832se2Su3eZ933g334j03dE43er038722F839m73ETo38722fl3DGW388v3aAH32583an035ZX32AN3DzW3E282Rh3AbR35Je32Tl31Yj3Ewd359134362Tt2MJ373o3euD34U6360d3aB22p1329l33QI31Ub37qL32Cx33nA2E13bHC332Q2S13eh73ae0388S36z934Y337M72Yj323F2Mc37OD32C2323Z2yJ340V32z8335m2d9328K31zX3dv63C4j2Ss3CDT2L63caD3EhP35mb37pP34g234YQ31yz23738T935x43ePf3EVT320c3dzc33lr2lf32TL32fo33zo3a5X32Y03ehI3bBb34842D92Y72d9331I2D93eyC323135zd2MA3E9K3eQ535DH2rX31vt32Ar339S2MA3DZA34202d934Jp3AFj33zY32Fd2R3329l321w328x3e6I38Oo3CMr3BpV2RH379d3EYD2Uv22f36843eVo35kb2e1330p3600330736002v63E2c35e43f363EXY346q2KH3EQY38CP36FG3DzA39lL2KH375g3EiH33Z12KH39hZ33x6335Q338g36fG332g334k363w3f3H356h39wW33cd3euT2iY3A8X2Kh3ewk39Wv3D4M2KH31X938IL32pR34u83Cot38vG2OY37Rf31w03C853F2P396r3f3Z36ez31Ve3eYr362D3EYx397s3Evm31uz32E538mS2F8324l37H632Hj2jz33JO397S3emq3Ezd355f3eaA32SV38OO329W31tJ3DFY3etD3ebO38Fd3eQy3Bxh3d6I3Er037hV36h02SU39k73etO3F5U31Zm2Cp2kH36q033up35KQ397s34u834KT33qi3Exy3f5U2e132L936b439n0344G3F0g3c0Z333u32TL38gE34mZ37vh39KF3eI431tH34w93CzD34Vu2Rl366031TJ36JQ3Bhz3A6s32CX329L38WD2Eo349o36eE2RK3ew932613252336439FO3F1d328z320U3C2G3bSI35D433lP2mA33142KH326j322q39kN36IY3dhI37ZE33E62RH35zR2Rh22s39YU3aT433283adK37rm35Y134843ABo36MR3f2D36IS3f7v31th332G34ID3ev0351x33JU351x32sb351x3eHi34Fy31XD2rY33XG3F363f6121W3di73EKC34J434tX32My333934J4324U36Co3DJ0360031yh39TO31Wf321P336636fU36003F6138av3eKY3DiI34J42Q82d93eY232Qk2rH21Y31zs3e5F37es3F9H3EVm3auH2RH34j432YB3dOV387p2Zs35MM2R339fx2Ma37dx3AZb32CE33J92D93F8g31Wo39Nb3f9P332G34wt3f6t35Mb35cp31Y5331b2mA3Dtb32f232TF3f9p35l831w93cJ639F03A5Y31Vd334T36jZ33fb3F863ewD21l36gk32Tl32q02Ma3F8E34nA374B3edi33sb32aP327A3A2x381g3c7839h234IN374b35Wh39K53ENc3Anq33Z9374b3f5X3Er021z36RS39eR2D931Wp34LY324h31C42mA3co835y33eSQ22V3ew3382F3240355k35a93F6334p23Ak43bQ92M034GY3B3F32Gm329g39S034gh2uv368M351x3bxe235344X367922Y34lP31Zp31ZX32i631TF31zc39Qt2lJ33gR31tj31yL34Rn2L5355U3f0t39GC36i73AAH3F9x316O2uv21T32BF39n0369M356D36n432lB3F9D2203BmD3f2p3ebA3f0A34T02Ma2MC32NG3f0F3dap3729325N32jv3F9D33HX2ya328I35EU33qI331p365l2r332i62fb21l3e1k39oy39UC3cNj3ADk34MV34wC34sE39e93aeH3BKs3Egh3aJZ3eW1362A32023483338m2l52zR3dho3F7t36es31C036iY3EKv32nY34mV33Uc33cC3F0G3BxJ35Q139uC3e402Lj31VR33dK3Eg535452Lf33zL38sA3F253FbH38p83EW42RH22Y35Gq32Xw31U12393Fbh22y3EW13aYB2Dc22C32Ld2mc32LB3eeO2343f3Y3F372222e53f8r34ud39OF36Zg32hQ3aJZ36Py3eZd3dZT349O33ow39mo34Wv3F9p3EyR33FJ2Rh3C962m03E1T3ex332i32YJ31Z132lB3f0g3cAz21l3cAi372921l35r832xw3Dms3b9721l3Elo31Xi3EWd37za32Xw375E39Wv3f5035Q1323z3fF23ER037aa2Rh33Os39Bs3d2U33wJ38T639T731y53c2g32c234g132Y531UR394x3f3r36Gc34373a8D3Dn13EYR2233ER022p2t633ov36gC3fE33EMU3DZ73f9d22z3f9d22y34I334n53Dt02363D4O33cU32aZ3ElS3b2i35Py3ApE34Kf36iz397s321U3EWn32dO3EY9349o33qf31Y132mM32QO31U132eo2Rr3Bri3a6i34u234ly31U937Qr388A36Cn21X399533FM224339B33Tc32S335DX3BQA34Lp3FE32OK3AAh386A3fgs36Bl31u934RA34Re3Ffq37XX3FgS34sw31tt34Jv3c5S3aHP2RH32pI2T6328M2so2r33ewN364F34hR2F032Q83EwN3cBx3dPk333934IG2e531Ts32793160339D351x3DQr37Ry38z531Xp332n3FKL3f5S2RH3CEK31xP31yL3C2g32II31XP3dZa37v432E2323f31yR3eR0395S35tS355g3C0B3Dxx21I3cq82mN3b0R3bs831XN34Ad3e5D3dtU37M13B5D36fd21x3C9q36vO358231v73cbU3CYv366j3bHr2Dc3Ee136E33b5d35TL2e2361N353635283Ckq3eG835vM37HT34TL3c5S332n38063BI038K72Cn34IT22h36G938uf33Rh3Cft35vx3929325m37Eh39Fo36o03CUK35p235TS3BX434lS36YI38r63840384s35252SI21V38kF3CM537Pq33953DlA33L22Dc32v5321q3bQO35E63c6u3aqy3bDO321q33U332Z6369p323x35l238Ma369K36I52sY36dc35pQ32hH2cq21J36QC32h4321Q38iA36RF33gN369H36Nk2cr35hb3DSG323x3fNv39pC22h36CP34S22El3ew5369o396w3BTV365T38Au3BHc22i375G369x3dK13Aqe2S036jq33IW35nz3AqE3bzs3BU3358M3Asn34N933Al2RH23633WI32043Aqs2KH37pq21v31W4361k39Gp34d936jA36VP2RH3Def2u02Sp2233AK636dW35Kb324d2RW32cL3aqe34zU366U3en62DC2213B0R23D3Cx737Nk31w834KB38XI34wC38d235kq388a34pB2203c363b342el39F7330C388A328x38ir39v82li31zp39U9388a3Amj35wd3e8N22Q37t6398V33F23dCi39Hb36O733Fo36hk3aSN3adx33QJ3ai937yr378R33n1354s36jq22w33eN34h2382238U836P13aWE21V32DQ3Cd9337q3AJh3fI83c9s3Ayy3fav32Jw37IF2sZ22C3ayY33xj3aUK313T381p3coA34Gp3D4A369k381p369k34Ja388A36G021W3CJb22P36bt21Y33jk3c2s36f433663cC737ks2dC35L03cO03ATz2CQ350x3ByO3cT836G0329532a23cC721v326C34B032Xe34s23Crv3Fm13c0B3911326p3Fa2333y32iO3E3L37n821C36Qc39gL320U3CmK36zN2sD3fMB29c34xe3AW13b0636I838yq324u3cdN38QI33073aWB3D0L3cDS36WX3BSE34rD3b4m3539383k31X332hI3djj22P33iV36D838lD3bRQ31Uk3FjU232371n35e935GG33qJ341Z3C4G359E36Nh3B1f22p3bIJ3B3K378b21F36I334XE3AfZ350e36q63baQ38U83bhK3bLe3AE02Eo2sG3cCf31zq3bi4339s34UF3Ajf3DsQ34X831ya2u636mr2Sp3Fj63bkD3eCs2CQ3cgn3683333X3fMb22A31Z1352634u63Ai1377q325L396g341V3BCd2ty23238wF34i63EMP3avk3e0N36n539l9369H3d7U3AvK3c3Z238362e3Cnb3AlU32HP32Vw369M222396I3fdi37ZX3d0Q32V434mX23831u33ayh3b4b36Hf22Y328m36g92u02rW3bLb3c7Y2cQ32kQ332o334832C7378W3eQ133Yt3b1f21X36d83Ajy318S321p3a9J32c431W93cbA2rh3cWS2fc35mm3ay039X5324U32LI34S2388a36dC32s736bu3AYy3FcD324d3BHn34AU37R03fMB380137R039I123336Hf2233Ew138LX36803CP821j366B390533z2367937FR356B2SP22h2t436bT2K03ag13aVL36zm34n523c3B0r21V375a3EcA3A96324i2rW36vx3egl32643cbA32V03Ey238eI32b036vN36EZ3CCC21l3bY332yB34QR322P36x339hS32J43EY82RH3aVT355b32qU36O33EEu2Lf332I3Dpp3A153b3K3cM122X3Bp035V52Ss23e37P43EzD38LX339434zG3fzC2q339gE22t33ZO34l33399375a370y33943DiV3au731722rH32wb3D8p31v139G93b1n37UO323s3B3k22v31Xm3FAE367N21i3Cn332Ij332i21z33w032c334tI34V43Ev636Eo21L369b35M932ky39dP35m132323DpM3Ffl2CQ3FQ92Rh22I33AY32qu2rH23E3bTC39oT3B3C2su3E6j37hT348E2EP3b3M35C136Zr31v334Ti35xE32Ij3eyr34Ml318S3Axm3F2B3c5536803361359I21l22i35dr36b435sj39CU38S336pt34W532Qf3Egb39TO2CQ35xF3DhI370h31VN2VK3c0w37B5389A31wb23C3961334135sJ362e3c9k332u32YO3G2933oV389A3fMB3F9L3dHj2R03CoO22g36yH31x939PN35z33DO23A5239AG367U34w0335m389A3cjB31UF3Dj1369M35P23g1f3dgy3fgv373h36G02282t62jz39e7231332n33X22l635By38CG31vg3272331l2Co3DY63FI236p7326m32c036432Mc3BTe32Y539Ek3bd534zs3DoG3f7i23B32dq3Db83AeT2lI22033zY327o39iI22V3ESu37bg3A1531Ve34q639Tp3BgZ3Cth373H341938AV31tn388s3A2r31X432ev2rw331L32PZ343x327O39M722532iy3504331b35Sj349o3CJD35TW31v137Ee32cF34aj22Q31vY35Gz235362e3cb332a2341C23733rA33ih3A15369H237377336eo39FD39u534033DOT3A153ai93FCl2e23D5m39gf3Dww3B7T36aE34BG2vp332I37W13Chn31Tq3E8a3g6K32Ko2T432De35st36bQ3bge31wh34Ed35Pj2l234K923C33l3381z3bNp3B7t35lC3cPS2ke3334389k3CC73Ee63B6a3B0633Y43B8K3b5d22235GU331R3f092kE33O93B0634hx2Ua3Frv2N333vz2cQ32vp2l233J92Uj2ty34q738vh38oR31VQ23c34I33cxD325R3b3m3d4q389K38oy3cjb39nO2Rh349832H233As352I352f3G82337337hT33yV3bho3C2j37h7332U36cx36i535v53B3K3au931Uv3cC73cBc36ez38dd3a0S3Fuj3chq39Pk3fIr31xN3c8n3DdN3B7V2vj369h22c3Cc73FyB3Esf3B6938RQ36eO367H31vF33FM3Bnr38oU2s63Cw734B63f8G22D3afz36PN2Dc391H37JE322H33Eg32I83btc2363aGQ37jb36mR341Z3btj33Nh33f234D939gl3fLW3C0w225383k33LN2UA33m33cM534T23AUo2cQ3e842rH33hq32iO36a233md328F33pW3A0734Su37Ii3C7839Tw34t03BwE343L22p37P2368839jC38Rq3C783e3937M1333U39iy2jZ353G33I222r33HN21V36bt22E3dI737I32Q436y23Chz341W39ru36GP3Dpi3FO2333U31ur36eR35v53C4E354B36F833u33cs131tg33Js2Q43Cc73554391b33613Ax236Lu33FM3bC635VX31vC3FWY37RO37xJ35o93BCd33Y939r63bCD37Ej3CXq3eaw32yj2CQ36nb3bD6328X3FaI3AOE33zy33u73C0B35K23gBz36O43AcS37NF3bUX38X336S63bgL31uF37B5329d38ns2313b4523333n33b0635kk3GdD321L21U332f22E3C2s3CJd321333h13Bbp2fC3c9z23E373O23c33953ei637Cw33P637HL3BUx37C638xg33PI341733U732q634iK361n2CO339B343G35v533y922S3ELJ34gM3doQ3fbX37DV332F23336AE23331C4364f3AmJ3GEz37s138NF36lE394S36T335HC3dON22H331722p34Gk325N33NA33U733y932u133Nv33Pw3g503b8n2y833873B062Qp37G531v3397g34JF3BO03b0B23a348Y37S03AFn3BTc35N02kE36G93Cv236eZ369B23039hS3cHM3680369b3Cbk357Z366b3ai135ek386u37db3APM35eK39933fn43Bgg38OT34tI32933AFz3ciD3G2237GN3DhO37B2369m22i33R822w37Ht3G1g3ejB33483g2a33q93cxQ39Us32ic347k22e3b3i3a0K2t33dxZ3cG93G6v332F33re36Es33M135vw35913cx233R821V3B0639I234V237XJ3DwZ2dC35Dw2eL3CdZ37Tk328I34lV2S031vY2T43fnb32OJ33zP327M36d823431wD3B3I3DY73a1G39yd337634wD3aFZ35Ql36GL34rD3aE3359d33rZ326P3bW333JU356z37Sa385031wg3cIs2283CqX3C6d3BQW2Cq3c0e2EO3g3l387t32p23c2J23534ZJ22b3Cou2253C0w36o337pW3bn322531z937x134H032Lc384038S938w534v23c8p21z3Ajf22B39iq3aTg352838jL36Ew33U537X13Ci131Tg33As22d38T93683391B386u3bN1379g328f37qa2G433nV33hn36nI31UM34WU32m0340e2SI37N7359g2Cq2383C2s3g2v3gd231V8362l33x6385533Ih393D349o22F36cx36Q73gKT3GfS38I73BG63b2q36C432303AY13b3I22S384a3g9137Ly3Ekc36dX325437EP389336dx37X13c7l341s3b0B34vw341S38Ns32e8320r39Go36V43bm43gKm340e33HR3Bic345s3bHN32Ye36e33brW33Cn33QR23538co36A22Dc32o437P036hP37R633J1341D320438bC357Z37wu36gA339b3bL53cIg37mE330734Xp330z36g032D53aJ83A9B323032de23c37SC3DVa2lf33w03b4S325l3b3M36sA2Cq32hJ36vc31Ti3cjb3eUK394B34rm33993319338v38Ym3b1F396236o421x33r8375r36mV3bqO38wG39g736o438753BNy33FO36Mv35pk37Dx3Ai9367n34pr355q23736WO3Bhn22S39dp3e0l3Fz83b0b36Gn31vd35gZ3AZp35tL3b3k22f34ik38u83GNf3cBG33V23DwE3FH0345q2vI3g6q33DP33LJ3EkA3G0G322T34622L733w03ftn32p23b1F3dxB31WJ3Er435Jc3bDg3Agz3B4x32MB33Jc39ho2q8320r340338v7391p34cQ3aOS3FHG3AEu32HY3dDI36g23AI9331E35uy37QA39u13avk324x33ZA3fr523C348y2393akb34rR3bbO336122d3ejA36w634QR3cFt31ti33M33Cmj31yA3cY532E233AS22V33HR3cMj334C339d36D73Dpt33vT22p21w331i3cmj375a21g3C2j37CH3BBo3BUX234330c2nn3Eje3CKo35zu2nN2e13Gc532V93G5o3DUL38uY37X33aI93edL32A2369B3Akm29J3flw386U22Q3aG13FOb2Dc34283cZN3b3M3AD639OY3ciq33C92Cq22h326S3BHn23D33vT36hK328X22V3fAe35Oy2dC3emu3bSK2Dc21T3E1t39rO2Ld36nG3b8N35UY381V21V37X13FR322B3C1b3c2736432CL34Pw3B482Cq368P34uv34d03bDx3Cjb3Eq235wj3gt2333F22H3BP035QX33T435HB38j539hu3A2937XQ38t934jO3FpG3B3I23E39L8380T39ZY22238Gn336737J238bh3fS33fP72EY3ag1332R37M137P634jF37pw3B4x3boz3Ga43C3639TD32lc34u6386h3Abr33iG3Bf936YI3gce35p438b23cZ621C384037ot37M13cI821c33dJ3EYC3fFW38B235XY37tf3A243f9p35Hb37x139Jz3bs53319356B38cO33XQ37H7381S3bcL31U8392G342j37h73C9Q3dD533S336O43F3L393q33363c883f3R2DD34tK3Aos3BY13Cg933Ef3FD734Si34Zs2jZ3d5j39p4353932Yo36hM357D2y722p3az13GW638Jl369B2lg3D5R3b5k37h73c9z356x36kg3CIA367933rK3D5333Rq38M52SA33RK3c3835px36hp3Fyh3c3m3cAN381V35be2DC23137T639Y53C5s33ra3b7P32Qj34E738Cp34Ad2Q33BWW3C2J22934r2350X39X335c02fd3c2A2El390y39h43dWZ2SS36NH38CM320933VT2kt38IA36LT36kG37Xx330033if38E337T12Cm3ezd22I3G4V38Kp3BtN31C42CP390W3c9Q34nw386x2tt3gW63bX439Fx2q437nz38qH34UH373O3Al532km3cPu3cIa3GK9384T35HR39R5381s350z38e83d53391C39qR34mX22q3D923a352UJ37UG21w3Coa2lg3bVS351736cG366C392G3Gvk22H3Fm83Fe335ov34gL3GQX341r2Ya3CIQ3aGH38MD31yA35VV36gh369o33143gBC3B5U34EH365v37wb22R37Nz34O13c6J313t29Z350039kK38De3ElR34Zr38bh37CJ2KF3C9Z36OG36062eV2Zw3C9S33C33gw633js3Gw634T23F0e356F3GwO359o31w03g6y32Gd38bz332N39SI34BT3gw634I3385s3c9S2fB33X83bxe34LD2F9384a369b3bkQ34kb34T933rK37UG3c8H2Jz330p33rK3Gr03FHY2t322734Y33BDt2t33FVV37m13cx739Vu356r3BTj32h436es32bf36kr3c1b2RJ36kr3gar3B7m323V2dc228384035iT34Wc2fd22739iW39fx22p3eCh37W73BVs3cx72y8359z3bI038w33fLW332Y36Kr32EC3C5236QZ34vc3Ga437Ug3gY532Pl3Au83C363cy231z438Ep359o2CN3H213CAQ3F0z34X02T339L336O43GUe32Z633vb325v3f5U386x357l21C3cI83GIi33X83cOU3GLs321q32kO3el93Gfe2253CLE3cjH3C853beN3cUk31u02T336LT321335Rj38M3381v3GPf2Dd37mj3cKq3BMo2k537Q322v3GPy3C8834U13an938gf3C6U3BMQ22P3chw2T337Ez3Gwn34873c6j37wC34So32SX3gy73dW33CAb3C853cBU32ZE38M538Co376L34KG33VL38hL36hh373g36KG339S21T23434Ke3A6b2t33cId33Gn34Si37A134Oe3go433Hg35283H1W2Tt34is363d313t34Oe3h5R3Gsf34Oe3BZV31Uu36A736Dn36eo2dd3B3m23b31YH32Xp37M13c243aO72Cp3B4X3aCM3dyv3c6U34RP35yF31u33F9O2Q433mW21Y31zu34oe36hr37x13EaQ336i34pF36e921i38DD31Y33528372L3d0e2Q431YA34Ye21t35mm399l3a1g3gWO37qz38hh33h738jl3C9b2Q438GE37fg3cTd3CoU3b7S3Bho3CLe2uj37hz2eV22833A222G36BT3a1K36Fk350036bq36hK3gfE3E5D35363Chq3fk73C2736DP2T339WB365N2T339g933te39HW3d9l3bV635Vx34n63C6p3ag13Gzx34X038BH3Ed536EC3Go4328U2K533v235e72K537WB23233MW3bWv32d5332F33D738583C7438Cj3f4M385831ZC3cI121T22B3c243f8P3Bdg3ew32293AYY3gyq3d473C1B3DqY39jP22x2S9341c31W0381V32M832c433053brD3H9O3cFx33na352534I6362A336432c43adv33873bza3frt39H93g5o389P31Wj3d9238dF337Q34rj3fM331U034ZG39uf35HY3H5u22x37Wc37WA3cG939tV352Q37KN3ArJ3CnD2S934jA31uv3c1b33l8332Q34kK3D4831Ty3gCE3aCn31uv38bV373N2Dc21y2l3367Q3CFM3bxe39OT3fY9367922P3cds37BN328F3g3l3AEE324n3c2g38AX328F3Agy3etJ35Og2fD3ArA31u83CoO32d73fPV3CX73g1e21t3bqb3G773CFx3D5J37J735hy3GPm339R3cH8332Y3Fs832723cY53cm53gzu22133lE3fuj3GYd22d3CZ633iE32ip34Zj23833eF32Km35hL3GVu32jc2t33D0K3CI534TD36h43fpv34td3bT836O43FhV39kj2Dc3G6j31u834y33cP22rh3CLa3c4s2YA3COu22U3C523B3d3Ba235Qu3cOx390c3cI53CC93Cuk373b22P3FO832AX3COx3A1W2K02E1338o2Q8356z3c2j3b8A3C3y36O43aM43cJL3cGH387h32S62e23fUj34u62363C6u385D33x63cjU3gd83bBb35Qu37wC37MS2cM3h9w3dZT3CMV31zu3akp32LC3gqu38dO3HD736953Cl533q83hds3C78382S3CDS39313AOH33Rg3haa34RD3avx3cFM3COX22u3C9l36G03C5E3cdz36AE352534rj33DG3BVS2fD3f3l35253c6D22S325Q3H9838MP34n53Ezl2t334V23Cn22cm37HD33663gQR3A8t36o434W23cG93b3k35eY3Gmh3cOi3C6d372L3HB136o43APp36o437oc36953CGH3gC9355Y38RE36O43AdR22p22E350036Qc21T3de032jW3Grf3AD439Lb3h043aiV31X83cl52yB3Hb7332w34bD34rj33nJ2dc3cR73Ab23C6w2j33cH83c9q355B3A1G3Cbu38by3be13Ch83cbu33KF3AJq3cis3C7O35UY3GD834I03fPv33672kT333Z21t23C33343hDS3gXR36oR3h7o39L33g3l3a9535253cO822634r23C3L32Ax36eO3BvT3AS536F434xm392x36o4389M32Ax31u922w3CoA3ga73CdX3C6W22X3c243fIA36O43B093Hb733H136F433073HBG3c9Q33jC3HdS3hE03e3x3FS83Col3Gfe3GDL3a9l2T323d3cOx3H6e33RG2fB3C5e3db521Z3DCi2273D5j38Cn3hCw33c3378u3Hhg3h1422E38AM3bXb3aqz3g8535W23gmH336722p32FO35lh3h0423a3Gr023e3Hcb3CS13hK434rd3cP23gkg36O43ai1333k331436f43H1z3D6N3BK33fi03CnK339b391k36o43e9A36H8345136w63CBu2v5320u3c8P3d6x3d513coZ3ECa32G337WB38oS2DC32Hn34YZ2dC2293CgH37Q63ez73GCE3h483h7e35gt3FLW3CHq36eY2cP38Gs3CI63GWy39343hgI3849381v34PB21t32hV36nH3dB5395S338o2L321Y38bv3gS6320237TC3AXk2dC35OH3d063COO3gqy34NG3aO834rd3H8832u63gNO3gR83hmA31zs37tF22e3Cmy23736Jq3bb3381g3bI03HL238aV3cay38gE3GCh31W83COo3C1U3bS83a4a3cbu31WB3Au833HN3c6Q39B33C243Frk3DIp3cq737Wc39X02T323b31zS3c2g35iH36vC3dn237683Hl933a739DU35J33fuN3Er423231uR2313C9L37QO357C3CC73BpS39bI33A23GjM3Bse35903C9Q3bSd31Wg3c9Q389X391X39343fpq33F738J33CDS35R13A4t2sO34Uz3cOO3fPu2so3ciA3eS236O433gS3hlc34ja324f3H27324O32zS32kP3Cds22B33MG34eU326P332i3cTe33gN3HE034D8396Y31Zu39o421T33853Ajq33QR34ps34x233G33CP83Gwm36gL3bhc38463d3d3BsE330p325V37uG23e32ko32ma3BIv3CHQ38W5338r34N53baV33G3320H3c3u3cBU39Y521g3EFx325V331936HM375g31Xt3Fsh327o37nZ3c0u355y33jO36BQ37M137tQ3cBK3ajq3AOS3HNN3eiG22g34KE3BQu3Gwy3C1b392j3cTU3B5K33vl37tC21Z3aGY38g534wD3aUn3Cla31C23gA43CUy3GiW3fm031w835683GYx34Y33AOF2rh36PR31V43H9W33U73e323hKT3c74354O381P3Bza37jP3C5s37JP3Heq31w839553AGQ39ht2dc38rG3di032ua3D5J22z3cy733QL358W3h6W3hS434IP22e330c35B433mG22I3CoU3G7k3FSl3HRL3GHV3c4421u36e93Gof3H273Cia3aY934E7384936y42L338q939PW32kJ3G342333CiQ3Ft82DC3FjC3H423C9l3D0m31zk37q3354V39PW34bT35b43D003aoS3GOq32NY39Gv3Cq732KN38ds33Hi34NQ33Qf3Du12v33gwy3EWN3cN5326p36D83FrF35Vx37D5384937Eh34K93h8535363aGY36u82dc22734aJ2sC3BmO32bf35B437Wc3B4832zS3h2C3f2d3cad3hub3C9z2og3hl038QA31ZO33lP3EL93d5336dC389i38j53cq8336634xm3bjt37pw39Ek3bYN382v36FK3F8E38wg34mV3hpf3HJj35R13c3m3HRH36o43fDi32FK35a63272335E3a0O2Rh357k33gX39q134l32EL3clA3fhD36gL3cx736Gg33Dk3H0432kk377r357L3bIc3CJS3Hpf335m2g431vg3HQd321136o439fz33te3cx73h7q38hd3ci836rf2Dc33cS34VN338r39go34NQ2yJ34Mx23b31vn39OH3EZQ3gSf36Nh3BXe366T3hMA3g7E3c9Z22a3gFe3B3Y2uA3cT2357b334J31wH3EX93GPf36CS33ov323034Y339A53g5a2rJ2F939l83H8v38FJ399X2T336lC34bU33Ju39sI32dw3adg39tP31Wp3DWY3DK632x731v43BhC23339iq2p136X239M33d3d3CI836Nb34HM3a4w33H337az3D532hI36cQ3cDZ3HiK37x03aeV3CAQ35GE3d47330n38bh34Tl21J3Dnj35V03fiT331422Q2KS35Qy34Zg35Cf371p37mE3C3637LJ3D5032cf3c243Aw43A9I3C88239339523532tQ3d5t37P239Gc330O331g3cOr35v03hHy3hBE3hbm3dyX39M332Cj347A37wc34L63Hd7347K39dm3CQl35qy334133Rt33pi3489381431xM332n320Z3c9l3GNe21j38nD329d3eTF21l39r336d7395Y36O43fp73FvQ3E093cla3d1G31w038xl32jP3eNg31X9362039xQ3cme3D0W35vX3Ds43dE438Ns2293g8535KB3dE43c9n354V32cu3Chq36em31UM37GU37WC32kx318S3EHI36Sg3g1d3FQe39QF3FnA3C8823b34rQ3CaQ36c73Fm1331g39vT3c5033rD3cou3b7G346J31x93Dlk346j3D5r3H6635K0346J3Co832WT38T63cr23cKq36Tg335c3cuK34M33D9o3CHQ34qR38Ha3d9o3c9Q3B6B31w022R325o3D5322G323D3c883g8C2Dc3GE838cG3i0b32RS37543cDz3e3X36zR341c32aN32Ij34aj365y22q3aWP32i4347k35Md3i0b3cIQ3hhU34tC37QA3aod3BWd37ZA32113cDz36Gz32113Hpt3bB835nX3I243EDL35n63C243em63bVs3cUk23D3C4E22V3E5f3Azg39co32e23db53hUA340x36uA34HW3D5322h33ji33Hi36C03di1366u3aUT32CU34Mz3CJg3D9y352z35N637l23DwY3C9n3aD134tc2Ep3532365R39L822q32Bf3C50369m3aSc31w0310p31Xi380N356y2dc399F367A39iu35qx34bB33193I383ckQ3aMP37Qs3I583C1B362632uu2VK3bX43GY32dC3EvK39jR33rv32pB3fMb39Er334l32p134yn32E23dmS37gl37s23dWY3e9k33p833v03a1e35853DI73e8e32mH31XI3eDa21C3cSt3hXe3fp739lr32AT39RR2EL3doo3DGY36XE350R33W03gqQ3a1336g03cS13i0233Gf39iq36HV38sd39yp36Bo32403GY73Byy2Q83GE23hBE3Azx3div3bz8323r332Y3BAk3Dt5332h3f1T39X736G03E6234rG3Dpm377O35nE329H3c2G3A892RX31ya3HFd38Qf3dJA32qf3Dh134Zs3Dqh33P93EDi34T02f033hN38mc3dEf3DgX3BKM397Z3fKq388v381039Jd39sd381d2r23DSG3Dtw37Dy36ES37af36DP3E9k36DD2q333Pw39DX22q3G0x341134Kb35J32fL3AFz360M328F33Ju37DY33H3331937Dy34Df3i7D3hbx39z33drF380P35Vx3fNn2CN3DK636Y33dfW22V3dr834na21U38cL2F03Dx436LR345634113dHE3Gmq3HW7341133fo21u33q83G0F321936nl35dj37dy33lJ365y37DY3e5f3BtV36Q031W03Egw32e23I8I338s37DY38553cfo2r0330c3fQq39dP33io3dhS3Bkv335M345t3dU533ih37tU33R83c5E34vn321933Na32973DOv39Ar34zY32193Dov34X835vx3DUl329337tC3i0F36N433fY32Jv37bQ3eSU3EMk36fA39pw330m329p3DKd34C53DIl35vX33PD3dJh3f8E37T4357S3f7k22H33Bd380939qt3dGe36o438eK38EV2kS333F3B3G35pr3DJh337y32793dsG3dj53EkC36K33B9o3DoO38NK32V339hs389P3I4y3i073AlH32Sx32qW33P236G038k73Icg31z03E713AcS33z932pM3i0735i437SN33lj3dOJ3cBp3dg3394H3e7Y36DC32c33dmf3E9K34rM397839oh3c6B3cR239uc33av3hHa3E7738H33aEv377c3Du53G0T3A233DgW39b22EH3Dv03h0036dd3dHp3Coe313Y3brI21c3gY723A3dW93B8d31vO3Ca82Da3eCw34KA3e9K37so2da3DSg31TO22a3BC9333Z36Dt335m2Aj339D358l3C2j2va31w03fPU2uy3AjH34yn32ex3iEb34Ns39yh33d939IU229330735yy3dSe3C72377y35vx3HLX3DN13HPt3Am035vX39xT3Dn13dWB39OW31w03Fir2lr31W03e0I2lp39w23bcE2Lp39UC3F323Dw234wu3CeN23738DS2283Dk638M036Co39z33bqG350Y3dx8357E329m3EDI326G2L635LG2Lp3duN3H0g2lP38NS39Lf365R3dxY3elp33zY33Rq33Z132193dx43D1Q35VX3b7E33L933hr3572373O35N03hxF2T336B4371U3dR837TU3euU3Hea2e0339d2T43DX239bS3g292Si39Fx3dQs37u5330p33U73I0736l935Vx22u339D3Ch5331421U3CYg3eai327o3di73G292L6369h21l367n32ZE334833L837gM3I9M3dgY379D3i8032zE39Xd331b3i9m3e5F3bNR31WQ3Dw921T33Y93HqA32kY3Dfu338o361538Ji3Dr93Dv03aB633B53AgK32IE3dQR34Oi35k02Da339s32jM31v4347K37hU3fD63cI8386336UY38093gIR33Zr33q532WY34U63FWY32EE3DHE33Ax377a21U3bOb3buO339S33A83fi2346L3bUo326422431vy32MM32Rk3dg13FQ3350R37n821V3A9E3DTb3eJS32Ze33193ag034zE345G36By323X384x32ee3EW53d8r32EE3Ihl2v539X5320t2263bP03dPP381R3dFu36nz3iAa36Fz33Ju2G53iCx3gSf38H52q83g5x3eA934pn32pM3dGT35dJ381r3E1X22r3e8z39M32203e7X33h135ay3B2t3e1T3fN932wY3dOV356H3eiP2V93Djh3eI03IF639Sb31W03h5o33IO331i37KS2t1328s2353fYG32Pb3IGk3CL03aQO33P53HUg3e0F3DUL2lF3hPT348p36fz36eS3CSO3aqO3dg121w32og21U2W7349O22Q3BDv3dv535Vx36Rd3ImJ39E2351V35Vx3efU3Cka37Ed2Uv39BD22h39oV3bc1378I3e5F21x398i3d5232Qf369k32l23eV43c543hH63fP73ifM351R3eWu3Gy73fNg2P034yl39eK3GOc39yk3DMS3CJc2uV3H1n3agi3brq33dJ3ecu3ATl3eV43dg13c7D3e09372L339B335b3I9m39oh3AmX2uy3aWE35ev325336DW3Bs838b5384a3BDh352F39m33CmN3Ev43dTb31zg34S439er352F33LJ3BE134bB3H8P3DZ73dyp32DE34Zx3IMD3E183e5F358F3iGx36fb34iT34Ja313Y2Ry3e5C3eCi3DFY3Gef39mf3dzs3eeR37Gq3E9s3E8N34t932cL3dJx34AW3fsj32032E537Wq3e213I7d3IfL35J93EAj36zY33Q83e9b2Sa3BsB3dw9390x33h733053D9p313y392G3Ioa21z33zO35b731X32SA320z2fb2pD3EWF33Mr3a6V35uv34mt39oB3IqD3a2231Xr3IeK36hM2uV22X333436Hd3Dw937v7360b3dtB34ON3gZ13iKp3dPa2uV23433Rh38Ev32193dSe36UV35vX3dj93gZ13Dh13gec3GZ133n136NZ33L33iBo398L3e21399s3DwV3alw3fB33IKP39Da22Q3fYJ3ibo31Ue38093iR33Irp35vX3HzC31W02383iaZ3aFP31vo3b8L3E2133VT3iRm33eF38gR3iEi3CU52uV37IL31W03dYk32YJ335M3H5u34173Is52e33ii83cQ838nG3dx23Dba3GH738eT3E9k34V03E4S3EDi38g73e8F3aK123d3Dwb3h3v375r3I382E522z3diV3bv732gl36es33N6347a3eLJ3CkD33vN3Hxz3dZc3APM3aDm32Q036kT3E9k3bud3hQg2uv3Az135Mj31xT3EqQ3EeO32r53E513dfY23439d73eDL39gL32Ar333Z22q22e3EmO3e1t2353Fp43iTl3Dfu22a3DHu37w83iTL3IQn3AwP3Iu03eSU3535355K33iE3dAm3dsg35iQ35mb313t21u3Ifl3FQS35Wn3EmB3DK63A0m32Ex3eDI2303DQr35os32CC3En539du3IOA230341933tc38za37PY3EDi3fRH37xc35Wn3DZC2373e7c3H8P34YQ3DQr3FH13BZg338H3cUg2Y73bI53DSG35LW21k2253dG339BV31xt332Y3iU0371g3Dx83c193BTB38092253DV03efu22539H43DJE3E873dgw2253dgY3EQR35Vx333R31vT3HOf33h13bi53hUg37J93e9o3Dhe316N3e9O3e7M33HR3Img335b3IMg3DQR2au3DhS2263EMO3E7c39Xr3eg93aLR3edA22632YO3bSB3e7C3GRR346J3EoB2Ep39Il3BSb327m3I5v3DHe3EsB370H2s938Md31uM37hc3DgW37IH364f3eeR2263dZW3A0b3Ip03i0p3h6c3I3Z3ECi3DZc3iX53A133C4437LH3cW73Dhe29P3dZ73HPT3BY33InL3II822H3dZw35B135vX316k35vX35WZ2Uv32hv36fb3IqN33k93fAY22G3Ivw3c66321k3DgT34ma33YV38Xi3dtZ3EkH32I832rp3e5F3c3v326G3er4386a3dXZ3iaf3iJ33e4s2tt3GDw3dN42343dIv3Hwg33m9332N33m93C8N33YC35VX33OZ3iWe3dSG22b3Dhe35n83iyK3E7h38Ge3fep3En13dHU3i9J2uv3It235vx2243HTh3gu232gl3E9k34Ou2uV3iu83edM332y3gss330z22B332W316O37o03h1P316o3IzB23033Js3GSs3edi2293DuN3D3r3I9C33b235mA3DSE391H3E3Y2cP3gss36eS22A32q0316O31Uu3Du53GkL3GsS3DIV2313E7c3A2f3EeD3dk63cnp316O3DG333ZG3eFr3FM121C3dH134e038lK3DgW3B2u316O358M3367316O3e0n3cO73efr33ma3bq1316O3341316O33ef316o37w2338K31U33AHT37o82uv3c0e331O3dx43h0V32gL3F6c3376316o3ecu34Y13aIB3eED33073bi53di7236335b316O3dtB3aVb3cHm34a73f8G37Xs3efo381S3dCe3e3d3eNl36Z93dMS3b923e8739LE2L539OV35Q43A5y3606332I38J4363138wj331o3Dyp330P31TQ3eEL33Fo3gfj3Eh63dn43eh733Rt3Div36963aP039XQ3E1X36nb3ap034wT3fkM33LE22q21y3DHe22c3ELj3iy138gr3e9K3c213a03355G3Du53a6T3eH638553i123ejT330536BG36hw386W3eSu3EN037fM3Ejb3eeO353E3d713EJb334132112e533m03b553eX339ZP320G2sl3h1P33e43es53E2c3Dqy34C23EJt3Dfu3IZl3j343BC735XS31We3Dx836Y23Dxz3dSg36SA3Dw73BrX35VX21v3DQR3es63fcE33y93Aoe34U23E9K3Bb52Ri3J5l3Bux3e20333D3F3h3d4z39pn333D3ea937WN36Hw3EA933Ee3fce3dfY368m320g3g7H3g973FNC2Uv3b033Dh736EP32V73du53GOq3f392f03dw937YX36eP36d83gr33F3939q137EC3iHU3ePy3J6t31tf3i7d3htY21k23b3iF23b2o36W432hj3B0H39E736bO3j7733JU33FO33M13Hik2fB3EDA35DQ32JW3dsg3aH2365R330Z369A3iiU3Adr3I8T36NG3fPu33uA2e522F3ivN378m365r39ob3edL3Acg3dhu3bY63hM73e4c34f834Kp36hA34dP2uV3cTc3BQ637me33ju3H002Q8369S3ELJ2303C2g22g39R33cyS32E431Xu33I031wU22x3aF333tA32qE3aJf369o38Iz39bA34y531XI3IeI3DDT38z035wN2mC3dzA3Cpg38NF34cq313T321Y3Dtb3FWE37Ro36FK39b336Yo31We3eVm367934A739Xa32sV33UQ3J8g3dWb3HH92Ei3Ahb375W3HZ2321y3j1339B23J9i3Ads2tT33TW3EA93dkL377F36I7338s33tW340335jl321Y32Hj321P21X37t6380e37hU35vo31Tq3DYs35NN31uj335M31uJ32d232e52f031xC331B31tQ33Y932an3cVe3G1435yr377f33BN332w3iOw22h33c3325Q323f33z13AWr31wE2sa35EB39Kn3hZZ35eb3j8M36bo2UO3fe32S1358L38z033zP3f643DIv3j2Q3bgC2VK3DHt35zE325q3DGW38vw37xX38aB37RO3eG83a9G36DD320g36U938bM3eI438J523e2Sg393D3fmf3Iqx3dtB3ae73j5P3eW5365Y3h00321033bd34Jh23D3f9D38CJ3aaf2Vk3DZW37EE32203Dlz34Ls31Zs31UH39fp33943dtW3bHC3j6U35ZX3exy37gv3i833g3735uE3eYy37o02My3F083f8E2UA356R339l31uF3ArN3EPq33tL34J0389g3frV341z336432Ra31Vl3B2u328y33Wx34ld32ra33rM3D3I3DR83eq532K43jD531x937Ju35593EqB34QM37BN2q53EQF33K73D3i34lp3jEB3afz344F36yl39hD31yz3b7M3Jed38zA326c21w33lp325q3DWB36y2365F3esU3ejA3Hvm3IRS3i5N37ro350K3et733jl36Es3Gdy3FCE3jbC35F933jl3ET532xZ31vt329n3F3N32X432B6329m34lD3H003aya37lg2e522E32og3hYX3FI238502e139q13E9a3ETP31We34TD34ns37M135vm328x35Qv32S633B53A5X3ifx345q3C0932sC2Q831uJ3fAy385032eB39E732H035sv34iG34zs377F327H3g7031Vi2Jz33lp34Zf3G323iw33EsQ32p22T33hbe2e13eER3c093jbG2MJ3EwD3a7234zs3J3w37HU3j5q2uv3EpE3i292RH3774320g36b137LG324h3F3H3aCf3dwv35zx3J9H3E4S3eYY36es3C093iSK37hu3C5M3Jc93eVo3CaO385u33d5325W38Li3fOe36Fg3Cdw3EWd3DA53J4x36Fg2y732512Oz3C4M36nH31V32BU39FW36yl3f8E22A3Exy37xy3d7F36O738TQ397F325Q2MA330c325Q3GTV3I8k2Kh3eZ921v32v33Iz53F5C334u356x3Cr23gSa3bbS39N039fG339L31uj3EF93dqh2sh3fZ432rA3CK632yo32263f3y3bDT3b3T32XM33M332xm3f5C22334NP31Z93CgH3gn63D8H3F3S35283fe337V439WQ34Ng32263FP52oY370C370t334831zm34g13FBH3fK7364T3cVq3Eq13F8E384639dJ3JhV3DPm3bGx39bw3Eyy3j0Z350K3251335b3f3834yq2zr3eYw32qh3FE33B0U38Ka33Ls2S639sU324d3d3i2fb29y395J37Ro3I8t3f4A31ZC3eYW2pD3f0D3f3Y3Jdm3HzA3f083F5C3b7M35ZX34jj3aIs3eTE2L233rH3gsk3hz333nv331432513goV325j32kO3251339133ag37I537rO37yR322A36vL33ef3a0734Rj33752JZ33Ov3bxh2e121v379k37xz364f3EqY38u3232324L3jmb3Hp039Ax333Z3GHU3HXL33H622r36QP3ewL3JJ93F363du5363V359I32ex2ry324h3eTF31Zm3f0833NA3Alw3ewD3bA232203fD8385637Ro3c4y385833J922R3Gnu3F6j2L53jIV3ALW2DC3ciy38S9391p32jw32A239S022H3f2d34283JK03It03F9P33js32Xm31Vt3F2922W334M356R3cdz22731vn3I1G3chq36483FEK32MC32mY3Ab02y732993ddZ3f7K3CM62M03e1X3HBX2MA33C32Ma3J4w3JhE2M036eZ3cxA2e43EvO3b4333OT3eyR3j703jnN2se38eE37Hu33PV3j2H22W37Wv32613Ja822W2sw394837A83dhP3f8J2jz32V32ry36eZ3F373ID33J6j2Ma34It3AFJ33Jo354q3jpK32GR3EZ93cgQ3JnN3DdH3A7y3hdc3F6132A73JKI3F3V37rO34zX37hV3FA222p320c3ik52393EWD3bS83j8L37ro22s3f2D3AGk2kH3jiP336732CQ3f7i39RA3fj93f42368332023JB032l432SX32hj330p359t32EV3eVm3f503iuO3ewd21v33173f6F3E513FQX3f6B3574391B2P13F6J3b0R2vy361K31V033143c61348y33tC36IZ22R3h5g33Ag2rh3e0L3bxh32Tl33VT3a0733Le38HO2S921V332F3JFa3j5Q3jMx3Goh3b8Q3J3o3bH23F9P3J2R334p3g143Evm3goX3I0v37hU36IP3F9E35VX3jDj37Tu3eVm32gr331R3IJx3F643gV53J5Q34iN3gp73f9h333Z3jnG3f9P3fa23G9Y3C6P3jnm3GKo3a9G3F6e35hk33P33djK323z329g3ez93ar42SD2Rh34ne32ZS3Iku35ye39Sy335B3FN331tJ32y53f7339Vp33uX3izb33bb320533Wj3byO3G9I3eq83Euz391P3jpr3aRY37ro3fsq33mD32bu22232xU3IS83f0g22T32642323jDI32e532Az3JP134w9374B39S636ez37c732Eg38qB3J1t2FL348438Lv3JM43GAD329131Zx3jLY36y439HP3fi73H8P3jU132Ce3eTf3fK739yS360X3f7T357L3AFj345g35e73A7y32J93g3235Dw3faF3eX43Epg3f8n3JRz31Yh37EE2MA36aV33ZY21V3bET31VD3BTj3f9I3i0J3er022u3JvI350K3BxD3DhE33lR2Ma3gSA33F737HU3CL02mA3FkK338833F93a65354q3jqU3GrY21V3A2432cq33CU3gtv37Ia2pd3Fi239o93jTM39cu3bCE374b3FBH3c3S35dv2p135z13AWe39GY2vJ325Q33wE3FaE3eat36Co32lB355q3dYw31tq3jKV3geW3iHG3fkT3fa23Ci431uj3f3H2333EtW3F7w3I7I37RO3B4m2Ke3IjJ388631XP3fAy3fz83dWy3fbQ346134jt3jmI31X537hu2h93FHE37X13J4I3G143bJ932tL344X3Alb31yz3ctp3EI435eu37N12EY322T39P43fE43F2B38C33d8832A83cRJ3AeH3Jmu3GsF3Acs329l31vy3AMJ32Iw36Ld332g39gc3jry3fGV343x369833Z1325q331B3jS62e336WS34R73fGV32gm3Aos3FEP3284343x3C5039AB323j39L833122MA3JYb31X732nc3foC32452fB358438GU35yF32Rk33qi3F8g36x43C9F371k3Fe43EZd3C1s3JcN3fZH330C354q31tj3F3h3hNy2Rh22533k0332G38i334jV34Mv32t83a4i37VZ31vR34JW2R332Q035e73Jav3Er43g413FZh32ug32og38Fd3Eyc3fRK35q133913J433Ijj3228327b31zS3F2D33V838Oa34r12Rh226334I37gQ2s53jvI3F073djk3Ja83gSo3f8j3jau3C3D33bb3F1d3AzJ32HQ31Xg3C7L34uL3JVr35Q133Xl3FwY36Gf34xM37UJ35ZE3fGS31Wp3FP53EQy32FH32nW2L33HqA2R33f5C3bdH322033Hr35843evm22v34JE32eG32Cx2jz3dO8363U32wq332W34JO3jmg34s932Sx39OH3hd3358436DU3j2123532813jmB36Nf3CWd32KX2ey32723hs332t8331I354g35O33j0G22a3K1338c3321131xU37wQ3eio31c429m31VG39cU227324L32Hj31yL328X39rA36JQ3GBp325238403gMQ35Q43jTS3jf834VS328q32h8399s3E4032EO37Ro37qD32h032gt3hy733uw32eV3a4I32Ea328932613f3Y39073De43JL934sR3eTE391Q37c23H0b31w432W932712Cq38O938p23A9i35TN3F2w356l2rh3728332q3bYT33P336GL3Cdz3d5m325L33wI3f1D3GaW3JRZ34Gr3GbR3b0R3aUz34nv3K2a3F2M2Rh369H3jKB37HU3dBF2eY326c37b034rg3hP439Qn32rK32Ag32BU369M3Fjn3FIM397Q31V13bv421L3iNM36o431Zp3Ezd3GH43JLx2Oz32hp3h5U3H3x34Rp3FE33Cn83cw13HVO3F7K22t39OH3hXm36lv321L3juK31W03k6E3k6T31w037Ds32kY323s2jZ3G3239v93eoR37Pq328m3iDV38Ou3E1d3J9r35nW31v1384X35B43BQO3DVA3dy73Iq634Zs2sv3fQU32pb36e23Dk02T33Iwi38VN36yi3jow234323X34iY392q3IAF3BcD34gL33V82r233IE2Cp3f2D2283bxe32k92Dc37V732nq3Ag13FHy31V434JA3gem33r03A652cq32oG3HHZ3D8w38rq3gg937PQ3Bzi3Hh623836ED33483ce2356h3FtP35Uv32er36Hc3HkK3ceY31Um3EXy349i35283dDQ37Aq3gF12rk3EwN3cip320235As3CC73D7a34173dY73hln3F3y3CjD380h3FP236793jna35UY36av3exP36DN3AQy3Fav355N34TV324D3F0t36eK2e43DH122639OV3K6v2t336X236gl37x1328S3IG82dD34RJ3DPG3B7D3AJd362833LS32j23HEb2E33d7y32v4366U3Iqk31wE36HH3b3k3BnU35gg36Es36CP3iT533U53iRA365D328i3gV53B9q31V438Ep3G4M3Cfd3fDF345Q33y939503i9y3heB3Jm43B6G3cjN33XZ381s3Bu738G6321Q38bV36e23GFf32XL3f1d235366u320z3JpS33GN366d39cU36Eu37A1359D3CUK38863Jj335MM3CQU39483Jj3375a3AE036O436Cb3F4S3CmJ325F33N13FyR2E33f3A3679366b2UJ37rO22h344l377s32ye383K34xp33lS34373cZM327T3k2M35ho3HEb3gIw23936d838en37rO392e33vb3G7034jA38eg32Kp3Hcr3I8k3btV3BXE334U3aO133bg355n32z636g33fr53A223CDP3Bg63fFZ3hvh3hZk36Cx322l2T33BoH36hc3h0k22f3IoZ34U634XF3J6Q3Js83ajf3Im638cj3AJf36py3cJc3GAA3jB93gsV3HEb32Hv34LV34u822S33N13C7Y3b4X392v3K8Q34kr3K8Y3BXE313Y320237JP33r53At33c0W33t337HU37T432AL34i6373O326j37p232263GyG3Dsq356F343X3358384A3Ijm3bDo2k538d22ie2sd32Cb3i8k326J32OG31uo33z931uo332W2sE313t31UO3g5i3E8t2E4342j3JH13il33cLE3eOZ3HGq351735hX3AbR3iZi36Ff33f736Eo3aW436hm31v83CcR34V83awe3i2N2Rh35R62oZ35Hc39V634iN2AG2Sl3BI33hvz36Ig39Uc3cg12RH3HG63aWB36cP3HBX388a3FbS3H9t22u3f0g3DPA36k33kgz369M3jNO36o73Gtv34y838U83eWn3CFw3JHI3fr13KGZ331B38cj3F3H34og38QI332I322n31W038B536o435Tl35yR381p36pj3aKb3aLC33Ax35hY3fSf2vi33w62RH2383b0r3Bo53GOh3FO838yq3iqn37K131vl34xm3fnn363e342j3fP92Rh32Ru356t3f0G38P232x52sE37183H8932c23F9d22B31U93735388a3JRE35qR36J03kiN31wH22836CL3FAy3g6A3HT83Exy2bI3AuG3ewN22c3Hry3ewK38N53h863ExT33z93Cjc36FF35Z932nZ3ez63buX36jv38Md34cE3fV33jRJ31YD33cA3bI42sL3EN22rh3h9j36IS36bt37yD3Aug33u3366b36O72Ty36Mv31vz3EW53atn3bho36e939bz32NQ37sA3Ea738QR3Kgz3hFS3jHq38Oq354S369m3jPj3awO2s934Q33kFn34ys38wY39hw21v3c6U3fs83c5u33Nv3cJb3EdN31Up3KJM329b3avk3Jow3hrK32HY3asN36b032ye3ayy22S33P22363Ez93I1Q339M3j1y369M22y33O33egg32tb39E73jEg37523dBq2q336gP3Fxj36Mv3Cc732kk375R35y62oY3FVg3e4T32m03bN33DlO21X380z39Rk36dD325V3i2b3cl433lp322y33nI3AvT32Z63Gfq36O4385S332U37QT33RA37NB325g32bF2NH2zr22X3ci83GLV325g32DE3gfx2233AzB33M33aFN3g2U32tQ36bt3aZj37Sn36vQ32g4344k37nz3E5d322y3JoW34553eEC3Bo036GZ3ifD2U03c4G36Gv36n53EGL31Uj23D3C0b22U3fv336RR3fz12sd36S6359i3aZX38qi35uv33Aq3btc384s3e0V36x33bLe31th332u2Ty38zE350r35G82323Jow22H3Bg63g973JJ33hW73I0h22i3aJH366G36H437t031tx3Bdn3cZD3FnV33ig35UO34fM381V36FF350z39z33b8Q2FN373O3H3V34113dfY2283F5c36Wh31UP3F0G3GE63d8P3BGY3BO42tT33RQ3Er423e36qC3Bwf339433zo3B3B3fn532dX3d8W3kL8331e3Fz83b54343X3FZ8339b3f8v3e4d2T338rJ38Vz3IHB36hp22036hf2h835CN3b3C329q2e1351j33I23b3G351J36yK33nA33ZE37aq387Y387i38aM382Q34GU3C443gXx34W03G7H2202sU31VA3BDn3G2k369s3Cxq33q8360b3e7738f133a3332O3KQl37aQ356h2tt33Fl36Jq3bR02sA3imC3GDB356h31yV3awe22X3C4G32Z633ze2S93BKY33Lv33qM32ij34c52H83Doz3J5P3G8538CG33fO345g31Vg352q3agh33U3387336pz36g9375N3a6F33h6330c37x13hna37663iEK3B6836M6375B3h0Z33IF35NN3a1531V3331L32wo3cOz3cbE32cf322T366U376636E93b2O33GN33Dj36y232IN390P376e3DIV3h5237663cC73ELO37c236Pj2sA365h37Jp32Rf36NH3hC13IG93cmY3kE033Fl34PB33qn32Y7366v33js3237349o3Cb3321I34Rj22U33j921w3cB6330c323x3EQ23dR836O43ij038NP3i513BqO33qA37Yf373o22B3334330c3C4g39r237yf36DL3C3v331437ht39Zs330C33le330C3gD832i434yG3Ehi35Ee39aH3JH2345Y32bN34r23eOT396y36Gp367933583dgz34rJ3Ahm335832Lb33z93il33c6u3KEj385Z3KvB332P36KF357l3Jcu32eX33Fa33Mw3GM1397f34zG3imU3Gxo31XC3FmW38OO320434hU327n3Btj32nr36nH3DF83IEK3ctJ37pW3G2x2273C78367A32my360g32ip3gQr21c31Zu35bo3AAi36NH34gu36EZ321t383K3411315X35632E336842AG3iH63Hbl3fR83h0h3c2G34oX3hLx360h369M21C38da38Bc3Kml2P031Vh34s4375y37BE37X337Ky38d53HpF3aol3GMr3CI532sc3b7l36Gz3kmP3Al539QQ33Kn37pq3f673F0G37nW35vx3j0z3di0369g3CBp36I733ov3A9l33AS3j703GOf3AVT36qb35Vx3AoQ36H4332i39U934Xp37Tc3b5235d63K5U3gY734hx36gL34WW233339132723ewn38lM392q2sP3CEc2Uj343723A3gm523332jD33pW34uf36O43DQ13bn22L23bUx32Vn2t338gf2L233eF32H234mX34sc3ky036A23Hox32Qu33JS3G86388S388a3g4v3bkV38Ti2e322w31uf373I38Ti336134eD2Uj33lP32h23B3K3bO13Kzd313t347S3G4V32V739BP2uj3He036eH3b7T3GQu3Dd52k03BoN31vL3DB238F536Fk32aw33r8397S3KHw325q3jxk38cm3Go13grF3H4i3G8L3fuj34YS3Kc033oE36593bX23HJ039HT36tc34TX22Y35K437NZ32TZ341d3CLe36Vc35RT3gar3EVA2233ck0354j3d3N3f8E39H934j138Dn34rJ38CE3kHw38KF3g4U33FP36Ng22C33jo3H983c4e39XQ36o4353b3Bwe3ag13JwD36fk3GQu3dp33bhu3ajH38yl31W03Kze3dUy36gh3IZi3BV436Hm369M22d344L3BM72Sd3C6P3GaV33AS3FQQ3L243b3M37sm3DVA3Hu237o035Tw36NH3fs633qj324p3K8r3iNk33583H2Q39YY2cq3EDn3gw63GQK39Tt34O42Lj3cjb37i73A5n37DV3GaR3879379D33H73hW73k6V3FNZ350y36793a9532403fmb3gqB2y831Vc3j703GfF3bn33fLu31V0335B364F33y5351f37nD355K3F0E31WL3Fe33dEs350r33jo33u733L322y34jH3bfD23b3BhN35JR3GDD3h1I3avz31Wq3bRi37mK2CQ3JP533H83G6y37Fz34dK34302223c8n32sN39fy3HW73jsg22F36vQ3CCc3KfY38Zr3gHI3IWT21X3e6732yo393D33Hn36oC35cb3DFR36g022G32DE3h8531xk36ff35Sm39573FS636CP3gKw3GEq3L3b3BE33KUl2203iQ83g7k32ap3gkK37sq3FN533H83EjE380332303aJ837wZ380l2r4347k3Fnn3bIC369B2Nl3H3B33JO3BvJ33jE37jP23d31U33aH531W03kLm37s136223c1m22s3AMJ38ZL36c034c5380l3bOx33Pb36W434hg36cX375a3230324U3GkR34h63In3397i39HF33f732V936GG3DI62sd3ebS3dhO37Ht34V031Yf39JF2cp3I4Y36ff3bvB3l6V38DS35Uo3DhO33lE350Z332N33ze33jO365H36gg3k7021u37ee31u53Ag13l6333q93G2X3h2g2T33CN13c0z3HHY3Dt137mw3CO836Z031wq33h13Doj32sB3C0Z34mZ22D369h3g4r346738j535ET2cQ370m32iO3h0k3iDv36833COA3EQk2S53hxE39Hb32aU3Hw73eU5315X332i22h3Imc34yS35Vm3jKV37NB3Bwe31Z13iKu3fep33G3390436hH3KE0326238GE2343gCE2273HxS334D33TE3D533Atu33Vl34rj2373c4e3H1X320x37Sc3h223i0Q34yB21T3bAK33CK3L8a2T33CZo3iN23EPB3Hsu3B9X36nh39a93e843hkW2f1345G37A53BX435kb34V2352Q38BY3aJ5325q3kS921z3HJ23A0k33GJ3l773CmJ33Ji3fqH34v235dr36mq3FZ4375438553GkI3G4M31up3Akb3KC73Cq632Ew3ccb3B0b33mD38qU31Uk2383I1333053BL522V3aG12gf36o42T238of341u3g343Fn53gqY3H0Z33jF3gll3230325V3cRQ2r4366B35R82r433lj36HF2y833rh3iZE38U03bic34Ix3b5d36cp3BCD3Ik23hC232i433M63gfl3F7w358W3ag132WD33Z23f3w3gPm3Hip37ME38fG36Gp35k032yB33m334lg32WN2sg3Bnz35K03Iie3gVN3HH63hoX32dk3akb3hd538dF33DP38Dd3kao3H6w351735r336Mv33m332jP3kML3IaI337436cB2OI334q37me3kul3HEQ31y43F6X331g3boD332o3hqd22U37X13FJ72FA38AM3CLt33tZ2Q822s37OQ33Q23Lem397737oY323R33LE3Klk2vi3c9v3c1M39f036dn2Tt322d2yJ39I13I9m37BO3HTh38EV32K5341937i137S134Rw22t3Gd83cNh344k2Rw39hR365v3GOp3h5C3bsR3A0k334133v02SW3E4F3b1Q3Hi121z32og3igx3i7936Nh39xt32S63J3N3lbZ397V3IrW2t33gJW33Bg3Hw73cM63ktp345Q33v22In2t338AP3a0k32YO355D37X63CNp2fl3lFv3I6S32Al37N83GII38983H0m22E342J3l6C21Z37vj38Co3hD031vd3gQA38Co359E39Fk3HcB38U63BbO3J9F332y3GLh375a36pv3cI62Sa31vG31c43BMY36C03DDi31V33G8E35163AG13cQ32Q838nS3h7536nh3kYk34Lg3iHF3JL736IB331422s3C3l3C7f2Cp38h02Ty384d3B5V3GS532292T339v936KR3Gws33BQ3Hfs3d11365a33IJ35pg3GsG37ka2Ty22H3kb93h0435QA38XW336734c8329y39oB36Vc320x3c9q36MF3czn3hJJ39oT34bT3Hug3dnp221320435x73Cz43Cv231XI36gg3BsW39Zp3ai738c13gsj32Sb33rK3Gr93aX636Cs34ke3G9L3FNv36U938u0371433h62NH3D8w2f032PZ37aQ334833U73KQR3C7K376C3bIK3fv33gTp2T336D03Har3hgf3Aos36Z037xQ3h1I3AH93Fs834SF2233KJm3Gh92cN3cla3GuN2SD316Q3hT83HXE2hS3l2f3eZd38RD31z43gm532jg36ig3C263Hcr3Hx33LKn37X1346u2F93GO43ihi2EY3C1o3cO83Iai31Z634yT3FfQ3GyD2263HCB22C31c433x8355K34nQ2KF3L8T3hNw36O435j532er37TQ3lGD386x3G343fpk2T333AF3H7p2tY3iua39Si3kQr2393L4h35VW36Z92e13Fs632q038953HxS36Zq3IZN3gW637P622y38fZ3hxE3c8U3c823h1m3G3L36lt352Z2SD3ie336o437Nn387i330P37OT33aS3aFg393Q330p34Rg3c243cOe33RT3bP0392L35vx350K36Cs3db539482s03C0I3j3n3KRM3jnN3hwk330C31zF3c9Z3J9m3fmF3Ei02sD34rw3hFA36Pn3Go4230330p3CaB3G6y34vF38DE33673A9L38ys3hdN2d536jQ38cy38G6384022U39SA36dD3h2g332H3Fwn22P37s9373A3gZU39j6382Z2cP3G6Y3EEm3fL736Nh3HIk355p38jl3EhL2SD3Hcl3gzj36o422y32bF22S3bR53CM5334i36Lt355p3d5322A3G853cJK3h1x38BS3lF0383222p37it38943Cx7344f36Gt3Lel3gmL2KF3d5r31ZK38Zd3lhg35W037M23IqN3fav2sD3h4833xP2Sd3ghF2T33LnU2k5351734Gk37US3db5364633x438BH3CH72HH3j3936M42t33c813gQZ3Gyf34Uk22v3H5u32Kx3cii36hp3bCv36Kg2Fb3jpA32eR38D522533je3kFx37713jMF2t33Ixp3avj3H753kRj3C6o35j03LQM2sD3hS63el93AGY3CjK36kg3Ajd3lGq33VY33A83kaD38Yu3Lfo3bS4355p3H2q3GaW38bD38JL35DM3at334y33L8H37pW3GcE34YN322P38BH3J0m3AmH3Ga43G852nt36g133nt3gX931YJ3K8r341o3awB3G5O356o33if34X43H1Z38w53hlX394w3ClA3clT3591335M34c833z133hC3lJh3id02yj34y33d7w2fx33Mw3Hki3B9j21T35PN38bZ3CX73jQH36cQ3C8N3DD521W2a536O43ak638gf3L0t3g602t33hwg33RK3cl53DyT3H0h3IhF376H3c713cW23cUk3c273C2e32CS32q034iS3kZg373i2cl34JJ33iC36o733p83keO33Ig3hB834hr3l5m3c6J39HL335u36Iz34iS3kEW34mf3GnO2293ks92293h9w3DAM34hR37Yd332i3hXC3h8m33Wh3C8538oT3735333q3L0T3AES2Jz3C8n3DR93C853HHW22933N137Yd33173aX23EpG21C34R235O934rG3G4V3a2x3ev53H1Z3fP334U23HJ23cD331xK37N83eAK3BbW3D923BDh3jQh3cmK3BH238563hcr3g1436o423638iA3LS332233hh639FM3loU3H4X339D352u37rf39zH3g8r33bU3cUk36gl3lvU32YO333q32bF3Fs63hhy3kUK32Cx3gQX3C3l38xW3Kf434jP36O337xQ39343IX93hMl3ABR38gs3364340h3kqr33v83AB23J8m3C09322B39e233643gZ6331I336K31zc2Ub392Q34x23Cdz3bmB21W366B35cb33Tn3bUk3Ax23G3L2233CIa35pq385N38Ys37mM3BVY36o43l2p37TI3h0x3a6K3dOq3aiy2P73cjL35hc3A8B329h3AJF3d5i3db13d9236hd336436Z9339d3A9L33xL3DbV3LC2335B326j37x13GI43lv035ZI33sT33N1347s392G36xJ2sD22h37tQ23737HT3LBj32Fx35Zg331B21w3I1A3g443L2q3frv3jBx356Z39CU3CAO3Iw3326P3HK33CyS35393ASn369M21T3g6Q32Pr3d5j3f9o3lJv3H0h2y7353k33vT3EV537FA3C363KUc32s838Ma3G423Gku3Cfx2Cp32Yi36O73Gyb3JDQ3lUe36w63cKq3laj35v035ip33Mg3LFU38MS2sd34yn3h9U333s3C8835zh32IS3Bg63At535qY3kZO37Ly3HG532FO3b453G753hiW3341386r2vK33r83CGq2cp3c6w3cJK3eK73l2F3341385434Nw33dM33Jq32vQ3Etw3E7u324V31v133Bm32LE2Rw3LIy39v3329p38e33a603Fwe359I2yA3hCR39y336Ig33o9380Z3BOz3k3132S63hNC3loz3gl53gcO326434YE3f0E3D063b3i35NG35jm3gYd2283coU3J1a35OG347K3ek72f82S033bd3aMJ3bF536Df313t37AK32OL334I37Lb3AqY34IG33Js3aLF2Sz3chm38493B4x3AUW21G23D36qH321a35k12q83fLN31uR37LE32aJ3b9i3HH636nx38I63BwW38Qi3cDp34xe35W93DB731UJ3A8F2zL36mR36Hc38U831VZ31xj3F3F231350w338k32lb3h6O3m0W394333g33C363cgK34Bt3BWk23d37TC3l6m338r3iKu34i63kJ739jc33TW39343D472OZ325q38CJ3aSW39II34ST37YZ338r31c432Fc2Sd33C03kZd34KE355h3gC9360r39cu3GJ73B4p333d37tF35qF32aU3DTZ336u38dS38u335In3A3O31WP31ZG326131X232e533hn3a293Dho3h2131U73jEl3Cq72SR32dQ2Th32Xz3e6Y3hsh39fX3hQC356Y3CIS22g34aj3jRd3k1y2SZ37Kh32SX39IQ363037523ara38W33C9q33Y439jC2YA39GE3E8e2el3CoU3AEh38CG3KM8324N3c2s33CP33sj394g39HW3kiG3fnB37af32ZE3C6w3fie39Xp325232M0322q31UF21x3Ek03inY353p3hQA321P3dO038t53AYj32tl31VT33E43dAP368334rJ37YF2Ew31YH34F93G1434Gt2vk3FAE3H933jl72s02E12Lz3c6d3K8f36mX3c1m351W3aN731XM2fD38oU3j7O3D0631xM331732Pd332P352834n5338V3a9y3ko635F93m2F328I321231yR34Kb3kps349Q37HU3DdT3h9O31Uh22B33NT329r3biL36NL3BMq2Lg32qe3aoS3M30326P34Kp22f331G3H6E32iS321L3cg831wX38YR355o32jv33cu2T43c1X3b1N34y335ww33893j8G32Zd331r3CBe37y73l3236793Aj3347e34rj3Edl390r3cmC31w93DaM3kAD31wK39M737EP32k432I52Sd34bG3EO13cGN328Q345G32al3C9n3Fci327b328e3lCK31vO3B4p318S39ty36k233743ahN2cm343c336633Xl3L2P2Kf33Fm38xl3Jdm31V732AZ3fHA3bwW335B33Bh37WB34xZ3LQz38gS3fdi381g37rF3g3b36Vc3Fb838uh39B63fm3389i3hj038dV3B913C9l3b253flw328S332Y38SP34e13c6u3cya3GaY391x36kS35eS31X43IRz3h9N2Ry331738a331Vg32Q832q836W6328F3c8N33v033TL37Xj3M303eO13jrj31Wx3c8p3ch736gL32EG38Bh32Wg2oz31Y5328X3HaQ318S36zZ31xu3Fcl3CK235c033C32Nm341u32WQ3I01387v328X3Bi2324H39dp3A6N36BD3avO3ctD33s537Nz37Qr322B2SG3Czr356y32943Aeh31U13CZr2Oz33Js35t6331d33M134Xm38ws35bs36o722t3co83gaD322p3C2G33BT3dO03Bpg38Qj32P233R831um356X3KAC36iG31v839xW2oz3e1l3Hlm3eTf3Es42eL3lWc3BMq327Q335b3Fln33m1350X34iG31Uj37At36LU38212oY3mAI3cw73DSG3Bc83dfW3KD52LZ31Z93kQr3B10355G331932643kHN3jnA3Dj532Hp3hLV35UN38oT33Mm36NL328U2jZ2sZ22f34N832W0332O2UY35GZ3ivE33zP33Z13k6v31V33Cai3m8x36o738H03gil22d37wc37eX39433BgE3517382a2UN39dP3Kd83cv921Y39Iw366x3fIM2uy31UR3c553Cr2343x340p34kE3EFx391x37X13cNn34lR3F6T39jZ328u3Ety3ez6331422T3k27323f3lEL3dH637hU369K3KIM3aSo3DfU3dl738eG31Zj32m037RF399O3Jtf32Se2F133SO34833h273C5233mJ3HLX34XQ3dg336cE3FGH3jVi349K3F013jfV3bxo38cj3b6f33K936jY3dj03FLN31va3F31328M321Y368339803H022UN32AR3FI23M0O32KQ33Wx3hVP3536333z33IU33SY338S38N936BD324N3366313T32F433M534f23A7L36DN2Nu32jW38Da3CLA22g331B38I13d0p3eie3366339539jW2s03bQo22333Zy2lZ3F8G33Fa33Dd33663Gdv321u2t422u39q1373N31V4332W39w433Zy34C8323z3cOU3bD535b438nf2gO3MII36o7382Q2fL3egb3e5D35b433z934RG3KPP34Tl3lT73C2G2273f5334bt33kT34Ip3fz7353e36893M7b36eh32Bt32jv321U333R2V63F3h347e3BC73jh43FD7368339ux39Jz3Kx038343kVM38493BI038173eyj3Fln34gd3CSZ3C6w32Pg356T34Xi32az3334321Y3b3M36RB31xi2Tt34rC3KZ033dT3aEs3kme3An132893IHL3m0131zY33H33jDP31uH3a1k325V34193k1o35Jj392P39W433H63Ijx32Uy31yE33Hr3fln31V33Atx328I38EP37yk36O7348u32Sv36O73e982CP35xz31xJ3MCs356o3e8H3m2K36833Il63hLc33hn3jmY33F232EC39l833OM32NQ335M34dC3cTB38Bv22B32c238Nf3E8T36o73m8v3CUk2oJ34XE3epG340L3bcY39ut2CN2Sr381S2Ni33Kw36o73hRP3CGN38Md3MIE3EN632zS327m33dz344M3H272SG3C8h3e3K35VX36et3b0G3iAf3a7h3jnw33c32se381S31TM36Om3b9j32kq3Mcs3IDV3GI5336639rR38li3b0g3F2W36rZ2SD39w33HuR365d3C4133053Mht33Qj3AAt3J0z39O43hNO355G3igK3h522l533H136rr3gF235na3fLW3iEk38r83FLn339D2hu325q35xz398Y3AO83mK634pW34Lz31WM31Zg332y342H39zO38sg39HL3eZL357u341M2FB38I13lWE3mpA3mPM3GAn35TR349o328033LU36Pv3Dsg39y333Sj32J932013AK632AU32PB31Xm33073FJ9332n3MGS3E0F35rW2E1328X3C9Q3h8M325V33b53Ejn31Zp31uO35Bn37lG31Y33bi032hJ384t332F33kv32Mp3a4237g837Sq38iD32ex38d534US32lc3BIV33912uL32Vq3a2634Fh38CP31U93lX93F503bSE3l5I3AT73i0F34le3HiL3mIJ3axB225320C31zg3lyn384Q32h23fv33A6C386E34wc34bt2Uj33PW3fnW36hH3HkK39vc34VF3MCT38R831U02Rw35U735RY379033jz2Lj3mGR32Jv34ld371432fo34m43MCP38N7359134i622034ns3cog359Z338S2Nm333U35RC36jS36o734mA33sj31C438773mRu3hjO36nh3AmR322b33a236vr35T322T3lAS3H4c3Iku3m6L36O73Ayp3ATy32Au3eVO3FTg32Ra332p31XM3fbs3kjJ31Zm3IHN35d533TL3KN933mj3lnH3KFn33a733rh36D832z72rI3CKM33642j33H6c34tO328X33O93g6z3JWR35Og3cC736Kz351e2oZ31yl33As3dMx336u362I3LM92VB31X83EGb3Im637Ro33n12lZ3Mr33BMQ32kq31UD2tT33J837tf3E1s39S63d2E3MV035JE332n34n53Hl82r334Xm3j6c36Px32jW36qt3cXC2VK3CMr3k59384938bh3A9b35vm365g339S3Awc35i73er432453iWB34r0377a36Eh32fZ33lx36A022t34pP368331xp32V937yA35dx38Bh3cyL355G34lV3mLb37b03G7y32UU33L33jFO32M032aN39c42li3aK63ACS32KO22t3B4334Nq3iQ5323K36lo3Jej36SV3Ht037T622b3Cla3aT53cwY365D3c742d638nx36O73liI2El331B2px348p351s2eo37Wc35Re3hu2386i3AlF3m9l3683379d347E34ik3M8W3BF83Lkn3aLC31ZC23634Bt35293byc32SM335b32jm3aVS2rW3fGt36dD32v03mkm327M33072NM331i2Nm33k93k272v63KuG3lWC34o3320x33M334C83l863cyG349O3GLH37sA3aFX38VS3JIg36Cq3D323cz3313T33J53GYd3k703kL233tT2SE3e9N2UL3MLB371n333u3AuK33le3JAL393437lw328i31v3387c37J731uJ3K9C38cJ34kK3a7E3kHU3hsF3iQ6381D3cFo3Ikp353b31Wg3C6D3iua322B327O3ik53HF63Joe3HUb3MFn3Kne322p3lIU3BX43b4m3bsu33Um325Q322b347k3BxH336634pQ32Q034pI34qR3LA836O732p73Cv83mwP321L3bEd3Ds03hl932jh38ys3hk53Ixl34AB38Qe33EG33FO36mX394h3gSg339n320C3Mb23lHE39YS3dn23AHb21c3BTj350K3mj53jIu36833d993H8f3k1f35872r03iGm2y836R8371x34dc33LE2ds31Uf32je33Bu32L03m7P3aEe393Z33XL3Iu1367938Gs3HtN37A53MIj3cDb33ao34PJ31Xu3ej531z1323z34AD3A1F33AO31Ur32xe37Re37Ro3hk5339s3jO63aOQ39NM37l031Zg355k3D0z3674342j2233CqX37jG36ae3CtY3hcq34j02So36dN224333z33XP37JG3hQm36zR38v831V135jw36833LaS3Cg83axn2SD3J6C2Oy3Lf036Ae33bU345g21X33Oz324N34ys32vn32KH35Ey32sa33q13be13mlx32zS392g23B37Tf3G4p39WQ3cfd3GoC321Q34K92233dGw2343MLb33W835k133jS22T2243Mq822433lp39f52si3m7531vt3Miu35pB3dr9343L3gAk38Rk3jQ733R5335M3C7d3KN93K5c38AJ31Y533lp39W43ey63JRr3Koo398d32P232D832tD3e4B3gnU3IC532dE3a6t3kbb329P332n2U53f2D3Flb344k321L3D073n0G3mRI3mei324u3dNJ2kE33Nt367S3Gi03N4t36Dl37pW3C242203CIA3ku633bu31V132j9332o21x3G4p32El3eZD362D31xi32y5393432wG368334d13a3i3N2y389K3M7p3IzE368332SE324f3jgh38EV3N2k3591392g3jfu3hLc3MzT36O735G831ts36Pd34z82K033rh3h993adk32Oe3cTx23d33613i2e2ld321u3eW932A134LS31uJ3IYD3DmQ3jN4321l3fM32f038VR3F9432Bq3alg34kk22E33l33hdN33sw37Li3l2t3C883gjh33eg31w922v39Il33Qj3ihl33Q5328I3c9Q3M3s31w039tT2Ua37q33BNg21x3m15389K3euR3Dp6321u34jb3311322Q3BU236O722S39L52y739x03KrC36Gp377y3dw43A6b3epG379Y3LT736ff357e3mk236LU33TN37Y93Cbc32qe3Max3dq13GNU37hT3cJI31xf33z93bCY3n4z35T834wo3MwL37kE37lG3CX73k7032V036D137Mh368334dE3mul3Jtl336136X43GWX37d33M5936833d8638Md2sA3L5G3cxq35KP3kVS32K42sz34zF32AU381433c321X3KlK3d4F33D233ig324a35Eu33343bTM3khe38q73HW9367437sC38u336Ae33J932AT331P34xM3k7V32Nk36o73gHH36Yi33s532EK32ld33413877331b347s33Z1336k3cKP3E6438vy33Tl3f2d3a8T3k3136o723e3InY35Zm38or3bFm33I232V821X3c9n3EvK36953MUP3BE133jf3BlA3BXe35li2AO36jQ3Iq238hd3Akb36py3Mzf363s3E0Y375a36EW33Ic34SI3cWS326638B231ub3M7P35JL21x373B21x3k8136O723B31wK33na3MGS2lI33cz31V43NA53L4k34e739jZ3d3Z31Y532r43MMt3hJQ31Zk2fd372s3H2732bf3MT733Ju38013B5i3hlC3iS233TL32JW33d833S338WJ324f3LTS22433y93Jrw3MII36lb320u2r237613dYq3Cr72vw37hU37ho340p2EP3hEE3hvQ3mxH2cp3NbT3bzB32f93M7p397j33bU31uF32ji35mS3n5D31Z4343X37g8332y33sk33vT38Ha334K3hnA2Ya343X38753Izi3gzO3mCH34na3exR32Bg3212355k353Z3MjR3DhD36O734WR3815367A32i131Zv35Dv2Sa38Mw3fKQ39ax34S53eiW3FFq32kL335b2hz3b0b34Ff321F35sF38r6326433o636e03DUZ2Lj3L0834t037Td349938662l52Y73lI337pj371I2L632UQ3GUf387234tc32Xz3e1t3BYn3dlA33Qf2eY374Q3HyW23c39uJ32Fo31wD31W43AQs2E03dzC3lY9327Y34m039Ti39sD344131u9394S2cn3DX835sM3AAz36Y23ES63e4r33lA34m034203lsm321m32lZ3f39381Y3Ea936tT320U2t437F13jUY2U03aaz34Ns34XW33TW31Y32sI39He382v32EB3FHq3izB22X3jM43b7M3Esn356X2m93M2L37XY35YR37c838gq33BD3C8n328U39nm2l5321p3dYi3DUn3aHJ34WX34Wa320U35uX327M396G33qo33i032Dj344V3A7Y33VT382Y3hJw368338sM3AK832052293IEi21Y34h53ey23HQn22i3E6H3jUF3EW635yR331O3JZz3Dil3Jgp3FJp31W437zj3Nii3dIj3815345I3BkJ3F9h3C783f0y3g6Q2Ma33w03FnB332O3eDI37Ro3lOT22R37E02L539773cAx3E7b349o34J432Eq2SN32wN3eoU39bg36ox331n3EY23bBW34m035Uv3iMG3JA839wi378w381538u82cn328G325j31yl3E9k23D3214325J321232X23kwO33Bg3j9O2J3328U3nHQ2E521W321a2V63aSi328s345T3jPa325J32lB3lM932Ec331O3I2m31Y53NhQ32543b3C32Yn38Cg36GC2t239RR38CQ321m3FfG31vA31U9359537tI397034zo3J5P32pD2L532KO320C3nHq3E7738aL3Nk1396i36UX32283iYn327O326133m137LT3aCG37Ro3gaN34M035VO391k2S636LV395y34KC3jzK31u531X933nl2EY3fhQ3DA432RV3mNA34XN2sd37cM2r33IGK22z32X633mA3lLr32373M833GNU2eY39b13265327V3epG34Z834W03iHN3lz122833D83aee3AuK3Lzl320T3J6x391K35y23fP53HXA313t3dzT32z639HS37An35Wd32Ek3nls3Jyo3dZc35aB3AAz38E3236331b3dZT3dI738TW2Ey362c324u39ph3dzT3DU53ht534X536g53BMO2L52RW3GF82FO3nh7377C34bT377F39tH2SG3FQo3nLd2Vk3NMC2cM34CP34153D2F39K722u34h533JO32SY3h3H339D32SY31uf3ajB34D133lP34153bux3gM9341531v339892SC3415395o2Ey3k2g2sL39ph34153BOn3doB2cM39hB35YV2EP3egl3Eg13nJg2iU3e9k32e835yV37Ox34C523b36xi398i3kvR38py33zY35yv3jkv37iA3gCR2Rl2Rw3cUG33kj33wE3jBf3d0u3AO035YV3nIk3K0U3m2Z3aSo22P3g32367H34ri3F2w33yL2323Gtv382A38Lv3e5f3k812l5338s3Ko033j921y2AJ35Vx39563Ko033H632nD31u33eH532sY32SB32nd326O38NK3Ck633343NRB31w43jww377p3EjS21Y321K34m03glS34s73DHe3l2r32XW31uo39Hz3559348438bk3kvE339134153Mlb3lUx22R38lM2cN2SZ3fJ721y3jMy32v032k339oh3GiI38Bk31X031wm383933tA31W439zp39wa32Rv3efR333Z32QZ33OV39WA35v13K0E32oB3D3M3DMX36dc35uV3ADM3nEl3Fy9371X366e338s3i8T3dx2354o3gEs3N3f3dAP34Ex3kac3Itf33P43C3634oZ2cN397Q33na3cOt320139Ow2ey375A23539TH34Sf3F9L32hw36Uw3ez93jE8334837373Nh73CIS3K5C34bB33aR3dLb39R73diV3AdW3Lqm366e3C4G39nb3NHq32IT3nqD36o8376t31tc3Af23asO35wn329H32ct31vV3C4m3dZt35G822g33Z934153nsa3iT53A943lol3j7735Og33Z93Nrk3J9L33zY31Ve33Ov377f3dk622E3Jg53Fgy321c34bZ3f9W34x53HzI3ni932V833TA3Jpb3mjd2sC32453Nv336Gf3eps33d93ntu3bSU3eBJ2L5343X3egM3Dg33h6Y38j431u138gG2EY39I435xU3aSO3CS63Ew23fNa3Jfz3FUJ348m33H632SY34iH3gEs381539803gZ835YV39oV398V2Ey31WH353b3MjD325J31U73iUN374D2iU31Ub32Qe34PU33kf35yV31Th3nHq320T36fd39HB37Fw3EdI3BMb34153nRL3d7W36hw3jFZ356b3asO3gRu37Rm330P37FW3NlS3K3E33n137Fw32EK2sI3DLk329z34843Nrb31Zs339733TL324u3NUZ36bY3f9W34Bz3ASO3k2P35TS37jT37jT3nxW33Qu32ND3254377439yH3DP63np63n8k3MMp3ASo343j36gf3I8h3mqD321H32yo3NSJ3Cmk363T33bB36uB39zE3dsB3AE23Nr837M532cw3ab23dU53A9b35mB2cM3NLi37xQ3d3a3aSO3c3Y3E3137fo36Gv2t6383931wh36bo37c831VG3nGX33bn3Ect3CjH2Sm3Lkk3aso351j3lKk2sm2Sd2342Ty37GV34X53hiu2R3322t396R2Q32SC3839313t3kU43n8n3D8p3391351J324U34y33ko73J442SW33942cN3Nv33LJV3bFk325q3COT3nM13ECi33JU22u37n72cN34Gy3NNL328X38563FEN34x53AXb364633dR33Ju3c7b31uo3eRM31w03AUw3H003AIb3gU03K2133tW31XY2sN3dR2389g3NOI2t6323x3CMh3ef734X53B8Q32Qz32kO33N43nx637m72Ey33m333fO355Q3f9T380635tJ3ASO3BAY3JAO32Lb3ECt32n12CN396g3gXc36yw341534x23g3O3ECT3k7232ra33913l8A330133JO3251398W36Eh2r3335B33tu332h37lW3NwG33643FCR37K23I7U3jrW37Yr31Ya3B8x3dty334135hG39M53eog3aSO35nQ3ngT3Jd52q83Hdh3jZN39tw34X535hx36zr33Z9354Q39sD23E34h236LC3ny2327Y2ra2eY333Z32QK31vE3Ihb355n37k132Qk3ECu37Ix36803o3j34C83nry359e33eF33c2326c3C9f35Qx37fw323J3ngX31VV3BvE3NlD3nRB32043FJy3jD721y36Lz3nxZ34wC32og39AK32HJ3nHQ39H03NYR332G3l1A31Vq2l53nPe34fW3ngT3DHI3b1R32Qz339S2i031Uf3iBz2EH33Ac3nZ633H6350Z33JO38bK3nIR35ze3B943AEz34sX3o083aso3LPf2vj3nXs3nsE3aga38IF3C6U33zJ343838lk3Fe137L533Le39F034i62323b0k377f35YR327G37P03Ak635O32Y732o23Cxq3J3d32IT339d3apj3BOi2E53Jy935rt355Q3ahx3bNd325n34PW3dot2vH31Wm31ZS32md376G33143C7B363j3GFE330z32q03Apj39d73FTT39Sb3K4w3ez6376t2tt368i345G3LO932Hp34sF36pT33GF2OY3AxR35Vx3KxG3E9x3A5v3D9C3dGY32083F433Dr931y13nXz39mp3hPt3CgX3maF33gN32K33hQm3C9b38nP34We32z635O33o3b34gp2KD32Hj37O03EDZ388432BN3AJD3gCH3Jhh364f2sw3CcC3Lo933eF33aq3g3L33I934LD39213Nwg3O743cmJ3dd2320l32v735Vw39HW322b3NrY3Ek633953kyC386S3C8p3kiO32Ap35Dr3liM3dDl334I3n2o3aEj3Bgd3C6W342F3NJy3Nob34hy3a133d923o9o36k239b33bho3h363AsO22D39hs3dTy38I93I7s32yb3NP93hHZ32SA33B132q831UR33Z83K5Z2EY2Sg3Goq2r333Lu37W2386i3FFz34lW33TU33Yv3dSb33y934r735Hg3ETF32VT32Zs3fQE3A78369L3nBc3b8l33Zn3k3D3K3D37fc369b22138d53iA936iY3ahb3m3F33YY31XD32Vw31yA3i5h327G36ww39hl3ecs33jc33h03hAD32cm32YC3F3F34ip32Gu33tN34L33Egm3l7z37gb398I2i739js3Oah34Z234x52GQ3fce32uY3Bon349o31c03gkt3Kn934bD2r0326131x733Ta3DZW34913IFh31u335Tl34uA3bgd3d2432IT323X3E863DHo3etF3fu232qf31V338c031V03hSh3Ld63jrZ3bdG332y3bs63o6i3nCr38t63k5z3Dk13Btc34E0322l369M389V3Lfy33Tn33pa3Akx3Dys354I2ey359E3nRQ3Nq83dJH3caQ33sh33Fa3G293JLY3IS7333G3aso356j36nh3CL437493nlz3CPq3a153E3733fO323736Y23muY3h9l3kUC3NNt3lxy3b9833Ie3lJX3E0i2Ez3cBs32Xc3a4s3e1t3AL13A2y354A39kn3LC13Ca63iCX37qz2uy3HN72Sn3Nrl3cRY35Vf392p2d939GE3j8h38NA35ay39dP3A5L337N3dZp3D9c32fo33FY32z832RK39Q13Aiy2dA3j8m3JPF3ASo3alJ39N522u3MFh2EZ331I2LZ31ub3317355B398622y3Odm2rh32bA31vZ3b9739vW327O36ku345g3nJ02sa3Nj036DN3oDR3e033a9F3bM7366M35OG34193obu36393DxY3O7h3Izq3AEt3ofU3I4C31w03FRk323e32C62Oy3eEu31Uj33913Ih73IHj3e9K37Cj3A9437Y33OFL2cP345l2e13Np43Ei03AP43DMF3Nw634Q13a2d334k2Rs3jiq3JIO3I3X2VP33Vt3NSj39I432V13lan31Uy32KY3C8838193CHn39I13ebS38XI3ea93FG23fu233c3368I3IYy332Y36Uj39mE32yo3iMd396I330L3IU034ws3OH53GE633UQ3c9U3j5e3AKX3o6I3d523A96327Q38XD3IS832Yo3oI53I5q3J423A8f3AIS3Cbg3dmS3d6D22q3dJv34Ls38Xi38093ENR3n3K37HU3kZ63adm2Cm36X73jBu36bD34mV32AU32eC32Xz32og32EB39CU33o43A5z32Se349832h531YR330p355b31VV3KHV35WN3JMi32rK3nB832sg3hgu3O9Q2fb33C336uJ31Vy3LSM33XL33ge2vH3AJT36ZZ335M3AKx3c2S33LJ335M3bDT3b3m3HcH3Gks2q33kzO37U836yi37Gz357z33H13eTs33MG33LV3aTa348p3i5237663A7Y324u33993DPQ32RB3e3J38s4345g31Uf325M3hQd334835YY3Nv33CPQ36xh3b3M34e03DSb39Oh3ce53a6F31W93oEa36XH2Yj339S3iHk39q12233C4G38wm3OIe31Vj34633Mn53fjQ3fJq36ss3aFk23133Q43Div3iQK3dp33g7E3DiE3A0R34m239tP22X31V83A7Z34SF3Ef933xJ37o03d1p35743D7g3aK239o334lP32H53dhz396I35Zj3lBZ313t35X738g632SB22q22939IQ36Tb36U935tl33fM38B034sr313t3Lqj34We33NA33Lp33343lg239Po32bf3LBz3iM73dTZ23639hN3Is93Cwg327q3Aq438H53DP034X53I2L39Ow3One35ZE3nVc33LA3dw93dN0339s33La2jz37yR3jl932Cw33lA32MD39D73LiI34J63dHi3LTy35tL39Go3II038na33la3ivn3GJ52uN39rR3HAK3Nig3bTV3dTX33193lbZ39j733AV34xn2CN3dIV3jhE34J63Drl35113JPR33h135Z631ul33IE33413LBz31YJ3kum3L2b35z6333z33la39L839Q7327q394835Z63Dfu3h8S39oW338S33lA32Q035Z631X039B636U03k52354i32EC329G3IKp23539UZ3aAQ2Sg3Jni36By3nLs3NWY36es3Occ36bY325Q3gjW36HP391P32ec35V538QX3bN4331B348U36BT373G3el134sf2213j4w3jUe39PO33MG375r322l3dV63ink35wd3i953Gl739hh2Q83Gjw39Iq221383m32p839S02202Sp3BZe38x13ajQ2cn3eSu3ChD33lP33Vt33lp33lE332y39yd36wN327q366Z33YV327c39J737g433IQ3dOb32i638093Chd33ZE3OgX34YN36By33FO3fZJ31w03Cd936dX33jS33IU39k722f3as43nnN3DJX23439e73ekx37z43Ei13m2L35Vj32h03o6738fQ32203Dx83g8e2ei32e53K2G39pC369a3M893DLC39MP3BPi33st37ko369s39W23dJm3nZW3JEC23D3eeo22H39q13oGJ34J63Fv337N13F9I31uK3BHt3AIs33c3321y3dTZ3hdN2Q43Bua39KN3Bz42r331v8393q3aDS3ok137H439Z23C3Z3H2L327Y3btC38253AJb39z23AHB3i5H33TW3ebN2cP327Y33n13lBz3fr53gX9375F3dXw2E52mR34S2327y33oV327Y329L32723bwe3eq93eb83ELj3ijH35E9338s35DM3Dhz32HP2se36Z92Cn3oOp35252rK39613O1b35f7375333TW3eCT3B7c39z23DJX36842lp3DN422g38B6332H37O234jt333U3NR137HU387l35Mb3Dtb3AZC3Fmu38za39k73DO33CSv39Q1230325v3b8x3ekK39X7362C31TD3ixl3ADM33Q4335b3ard38qX3L5t36Q7372934yL346S3oW734ED3a723OHl34K435vX3hqB358r3J4G34X53Cpq31x531VM3aiQ37tP3is2341o320838N435hC39y5348u32hZ3eDa3AuT3dr9330735rA2cp31Uj32EK3OOP3Bjt34Hh336735rA334121y362a38qX38w93MtY3G2l32Ko348u3JR6388e3gJW34xM3nP435vx33ln3EXV3DN038Gr3DHp3DQk33SJ345T34ZG36IK341w33Ks3ihU395u3n4237Uc3J77329n32mM3E5s3eDi3c3v2ke395P32KX34aU332n3Ot03oqe3ORF3k8u3aIJ359Y348U2sL3a953mBz3FWx2TT33LP331g354g34kl38b533M634MO3nMW38Np3eKT32Vt3ahu38QX37V439Ob39h0346633Rd339S3oqh330Q397438Qx3FQ32fn340i3amd320l3DV03C3V34w032613K3E3jCH36Sy33qi33193hjM33QR3h6w39VO33kz3c3s2S93Cp535aB2E13c3S366B3EL23Cy53n823F1h3Dsg3fv93E933eMz35xE2Fb3e933p0736hk327Q366b388S3n822E135Z93orF3l2b21u3eDr39yE348u3oK13K8M39pR3AcG31C43EtS335m327y3Oh73c3N2zu3p073AQO3b3T33Ua32aG35cu2q53d323on63OWq2mN3OCm348u2sA3Hr53OOp34RU2Wm335B34J634BT34aW33vt3aTa33m3327y3Dk63KKI37Co3eLU35A63p0R3czx369s33Ra34Ng33La33173p163BU93J9L335m38cN33073H003cJB3AwH34Tz33HR39Z23AY73Flj33fc39I63B3A32Q038Qy3dhU38tW38qx3c7B3jf733lp39z23OP533jC35ab3OuJ3cKo3hr52Fb35rA36G03b43324N3e1T3ARI3c003lq03bST34kb3hA03Kps377R3o7j22E32D432Xj330P36vQ3oJ53eCt3iV635e93O703NzY3Ou734173aJf3AAt3c2S3e5y32Hy2CN339d3ova36ew3Djb3oRH2c7331239bZ32523dRL3eMH35Dm3p1N35Aq35Al325v35j3371U320l3p1S3g1i33UA3AkB3Djk3ehX331I3OVa375R3O0Z33j938cN38Ia39gC35mb3di7337t3Mr12AA3eA93jbx2ew3dms32FR3e0937MJ32lK34623941332H3FY2327q36hI359j3IVR32q834nP31uU332w3KvA3jA3327Q3NWf31XT32bf36gn37hu3EJY3D153Dam326c34493P5W2r335633dh13aV63nOk33F9323v3ltY377F34s439W338qx3dSx375r33Lh3oX73B3C3j093P2T3F6i36nM3ER739b622b3edA35G331xx3GYb34X53kh735vx35gK39lW35093b4x369X3Eb8332G36G932EB38092303G2736DL34Y13220398I35zj3A153Eer3gnE3En12Q82Ny329C3O403f9432Rz3j6K3P7M3fN934ct35aL33le38CN332N348u3p7x36X22NY3oP13OmB38qX3g6J21Z38mB323232OG3OQ9327Q3aCN3mM83OpF3OX53m1B3db2359m3OYW35r83GQq3P0R22131Wp2R23lh63dIU399S3Or23p8D339D3GQQ36cb34pN3gQq3P1S3NHw3P8634f13Nur39p43GQQ39Ge3dpP37873dHE3Cx13J093OU73bx02ku33hr32eo36Yy396I37wW3diu3A2637mS37872Sa22v374i3diU2cP38CQ3P7m39Ro3Gqq3OMT3i9031X535eV21z34Hx359m3P3836w332pB3P153CD736zi37Z432i339oH389M3jC92tt36H632nq32Hj31wt378o31U5327i337y3F5c3jTn3hbX355B35633CZ63H8p39ak33J922u33Gw2f82sP3ElS32pb32eQ32Z82e332B53F7e34B63fiW33b93jwe330635VX3d6d2mJ36bN3e6E3p9v3gah3gJw32J9343u2uY337Y33dj323d37lO38QX336433p63GEr2SU33lU2y7347w31UD3p1S38Ps3aSO3bu732Nx3MI03P1n2243ON931423Npo36833OUr35GC3mMA3n4b3e4D3D8H33GN3OyW3AEL3Fp53e6e3314372g3OPL3BhO31yM31y33Exy3BKQ3eVB32Eo3F7i3jtL2MJ32FO3p5R21T3F7K38lF3GQe3Jrk31uK32pr327222s35wM2S939V63B4s32g633u338fd39n53Lb53fjT34x2344N351R323Z3F7K3CGq365k3muZ3Fc639Gc36NM3DI735Kg39pi3nPY31Ya3jU334H033ms3alB320t3fir397S33W03cVQ3fdp34NV372G33FO347W33lP33mS3o2X3NdP38Qx2253oNe31413a4O327Q2303AjD3N1637rO380w34I534Gr32623gR93nC535HK3Ol42313P4Z2313Bx432OZ39nv3cFr38QX3lIy21Z36jL38Qx2273oqg3n302Ey3ORh3J7035hK3nvE39RF3jiw327q33Yv34153h3h31wB2m13kQA3jR634Zf34By39ho34Kl38ey31vi331D32Ec3fE339GC2Ny3dFy22A3OW73jPj3Ed33p5u3k0W3Mr13E4S3MNW330p35E93On633gv37RO3DVs34Hf3NLS32IT380934aM37ro3LpI2Ny3OjP3J4F38cQ3dW93ED03ASO3Owp3j012l333FO3gsS32sB324l3fWU3e9k32Ka31u138Lf37b03IhD32eB2y72M23DZa36cb39Nq2Lj3p5R320838qX3Lmu32E433h135bE3OI43nY03ecE3d7g32H73AAp34sF36W6331435E933h6327c338k33JO2KU398i33f939053EG53FM33lB5373y3Ok137ix347W3p0J3c8U38TQ324039TC34wc3O56370G35hk332n35hK3nel39a53EyY3p0r3kZ335k035TE31vN33z13aLh3pcr3m3S33FA3NBT33z938KA3OUT3gZB3a07323J332W3ihK3p2f2313p30380E348422v3dL1328I32yO3g0p331B33P633K232i3325q33x033i237u634103kuM22433913ALH33jo38qr3p2F36qZ3GWY3p9r3j1w3G0p3391372g33na33R53oK137v4347w3EkE37V12mJ32dQ3hBX37i13OX7350e37I12vk3Nxz353l32bF35tE3oU93Mdn3pJ22S13Ax63G4Y3eDV3Mt5378R327Q22B3Pai34HU3AlH33JS34gA3ox53Ive38Qx3Oik3G4Y3dG33c0936aK32ko38eY32DE3chm36AK3jkv3aSo38QX3kEJ3eim3pLG32De3Fr03IM63fBX3P382273Feo3p5R22A3p9i2373EnZ3fo833ef3fbX324h3P5R377c35z63m423kPd3FBX3peJ3ftn3alh33z937i13PIU3IdL34GA34aD3IEY36ak383939fo3if234Xm3M263BFp3Nvo36LV3G0J3oH7366b359m31YE3NXZ3EOy3nEL3M6z36hP3Jqu35l93GD23JaO33j933fc3axu3egI36ss3HC232hL3M8y3p1Y36Ja3p6J3bvh38qX2213Pi638xL32203FGy3gFk3NIR35vf33Jl33VT3p983EJT3j4W3lXL37hU3H52341K343X21Z3H5E3J1j3P8D33LX2393ON6223339D35Eb3JS3396w38D03PGo3G1b3Ex43CQu3467360u3pGO38Am3c0H3p5k3K6I3E773i5P345L339s32ra39kN332O365F3J9H360o365F3c0v34i73iXl32912TT32Ra3EfF31zU3CBh3F7j3nYr32ry3JRe35SO3F7k3aZX32023E7C3Ahm32KQ381V3eZ6323q3EYB3jhF3mJj3pO62D93dSG3bBW356y3e9K3aHo376132v83Pp53Au332133jeX36Is3NRY39M735DH3D3i3jjm394l33I93fEo39q533ju39Q532sb38kA32OG29Y39Mp3f2d369F3GBI33Uc33zy3lBz3JIe36AE3dvf3Jhy3bw33enu2R33fAe35Dw33FC3nTW397q3a9Y38VJ3iur327q3N353PA43fQX377A3h4F3jZD2hH36vM3P8c3JF6392z36EZ3Gm92E5327q3i993Brd37Xy32I23fcE3E83330734ZF3jAU3kC035zX3gd53KVI393z31W03Jrj39Q72RW3NsJ3pBv3Jfx31xu39bv32Eo331938LD3JZp37hu358l3pCM3P5k3JIX381R3Dk133h132G63jO63FrT33p63ja83a0331V736O33DLH32qh31C4392z3nLZ3GAH36tm3ETF3p023f9l2E134bT2G5339S32Sy3ozF39q734K73FBB34PR3Jwe322T3g1C3CYY3nwR3eG7338S21Y233343X3b943BNf3fA236Dc34yQ3pQY3Ptb3aoA3Hsd3O2J3pNB3NVp36EY3hSD39Q533h133fC33ig3Hvp34zF38Jl34tl3LEE33aS39LL34rC3OH53ihw34x5369B378e3F6131uL32Cq3F5B38qx3aU934Yq3P0J342O3Ft12u833193Jm3327Q22i3PjS3G4P3EyY3P303fes3PK52oQ327Q3JQK34X53ImZ38qx34o339NW33Fo3cn3332n38uP3p4v22i3k243OU73aNS31v73F613E7l3PC938pm35Sh34px32Le35wv32pt2Uy3gtV3LOg34qU2R23dOY2k033C335a93P9v36d433yy3bN3353E3Fst3jgH34mQ22f2fB38Lo325j33jO3iyX3jhF330p34QU32UY324H3p2f3iHi38Cq3F2p34rM3k2P3JLY3G3u34yQ33js3PAd3D3i33hn38bA2L53OqG3AYN35283261329g332Y39Jz2L33P4435Uv2M03N693o4E3CdE37hu39l1313Z3D243a9Y3iP634X03Lir32I738S9365c335b31uD321n34ls3f5W3nfU39B233903og839Y93HZ22mY3PMa3PwK3Aso223321A3fAE32V7341I3PPE35iQ32993m4n3FXQ3g143Dpm22S3ewK36iv3HjD3F6o36pZ36ZB35uy348Y393G35cU2iU3p073EmC34x522333m3320L31Td3LkB3Cid31U1313T341Z3Ee035sF31UB3Oky31tD3g9737tU31wm3pGk3Dq13C6134rd3f8U33z1320l363m2cn3evo32pi32an3JD5328m32hy3Jvr34yq3p9R3Mit3D3I3eTW37n133H63kN934Ys3PwX3eq131C436TM3er7331732CQ329N3op13joU380334QP34Qm3fQS38ka38r631Vt36CX22d3NSZ3N163eV039F53p3836gz3JdY3OyQ35U833gc3jmx3I6S36tM3EtP3JNm35TE35jE33Ju3i9J3f7k3G4r39Dj35LF34nW330c3Lee38ep34TL33bg39v53dQI33nT3jcu36ez32wz329H3OXd3MjQ3ap02d9335m38lo3OLn37Su3gKt34X53D593Q222Mj3F453O5533qI3Abp3f9d3o2V38jD3f6T365d332w38LO34Ir3Q2G3IBZ3P5S32O93Jk1325l3jBF38ba3PXO31V333wc32O532Bt3mA634vF2kH3JBC3b6837613f023fQx3H983P863f2d3BS8386e3jly3GQz36fg3O793BON331B33u33E2x3gxo3dtY3ew53diU34IG3E32349q3EVt36dN3a4R3Fpq3d513iql3OG83I3W31XP3OU723C3NXS3C5E324C3H0o33H939HR39eR3lg73CQ732QS31zX3EYC21y39M33clV3Da234gE3A7C3jXu33h132983ASo390M35o93FJF34d13FE322V3DJX33Q83pwp3k6e3jts33YV38Hf3f8G37cJ37A8396133V83DQI3jRr3dYW3exV37Ro36wL327q37cT327Q23b3q4I3kZu32D735OT38V032D73nPj3q2g3iNK347a33ov3N8f36E234M03hOG3kqF3oNM3keP2213PMR32LK3Q5k3dOB2F034A632W132K732Cb323k34R732O73f2B365D327Q23C3MLw3C1e2kh33OV3Fq93JrH3P4622Y3Jqq33jo33H63ab53jmU37HT38fD3P303ptb3aDW332o32Xm33z13lEe370832Ce32KO3f2q378R3czX34fm33M33NC538Qi338s390c32ds3oJg3a1F2K033nA390C326c39e53j5Q3F8E3G9y22v3hyy3G143Jb03Cbo32p23f943mE736Ez3pK8353D33OH378R36Ys3Iv63o3f34x83nBo37Xf3nLz3bkd39nw3ofu37oK36Hp3O7j3c483Q25356s3FBo32KY38nk33Wi3f9d3LpU351x371j2Su31wk3NR838dQ390c3F2d36Ae3Pwb3F9h3eWk3Cm936Ib3jz93Llr3fkV32v42fB3D4t3iek32S735tS35Av33y939aZ3f023eWN3ATa39iZ3eZ93Mg638qX22E3jrR36643EX034x5343u32o73ehi33Qi34G231Xp3DFy3cG13EI437O33iWR37Ht37es3agy34463lOL3F5U35hk334135e73pK53gkW3Ko03L843Oh332iV323z32Lb3PPa32BZ34NG32I733Cu32Gm3FCj2dc23D3EiL3pJg3Mk43A5F32Au3MVa378R2qz3nrB3f1D3MWl3Ofz323z32Xz34Ls36lU38l12203d7W3of63OfZ3ElJ3pYq38Pq3J133c7H3Jzf3eJE386037ro2303lGP38Ek3AsO34yb31v133qW338s3Cax36Ky31w436z037eZ2E13qB4339S38CC3p4Z377M31zY362g3Jzc3eON3qb43ON63pzN3K0i3jk533ef37eZ39Th32343Q9233iw3MBe324032yC35O333Vt32o73EzD3ip63pRk37hU3c0s3q3t34x839IL374b323m39iZ3Kq53Fgs378R3Jht3fe43GV538gd39K52nY3F0G22V3pMM3Gkw39JE3JOW3FQ93jQZ3k2M3ISM32O731WH35g6391S3P5R36gz37a833ov32d93G322333Ewd3lA034x834zr32KO357P3Ew33bVj38qX3PD63k5u3j133oC43q7Q3JQ734R333Wd33p23jni3AsX343X391s353O32lb3Ph722E345G33T53FkK22733J93L633o0E3hds3F7v369H3Hsd3nrB3Byn3GTv2Ds3F76329H35O33Al433ZY32d732vw2Ep3ctP3aB032oG2Gg2E134Qu3qbu3fj93PRf36lu23a2RW3K70325L3nIr32s92S13oea32pO3IQn3Q2x38I137Ro22X3Q7e3Duy326K34lS3fL5325O36e234Y134rP3Nzr38qX39TG37HU32rX3hVo3oH5343U357837F835Y137RO3Bi73bgd33Dj329g33oV327e2ZR36Ld39V839L33Q9K3FGS33173oFO34bT3K3438qX3H7s38PQ36rS34X52F93E7G32Ca3p9v2383QcJ38843joJ2RJ39O932V7343x37ez32Bf32D7338h2Su3P5R35ra34x8345p3Ko031vi3jPh35tS321239CT3mci37hU3mmx2rh3PE135723FDS35ts3dg322s3mjJ32863L0V3MM93Aaw39hF3Iik3KJT3nFf348a37g134X832ra35tS31Yr3Qf73lQj3Aso33Gq35k03L1d378R3BhI3IG8347A31z133dj32z63BoN331I391S3f2b3EDP3oNM3JIE377c3e8M34203QH63fJW33M339Py3o1b3HgQ3205385z32v73qCk3F7V33Z1313Z3FAe3JuI378r3d7W3kqF3Kvi3e8839u5326422a32sB33003qBu21u3F0t3kBF38t03Ja83PFF38u63jR63IwB3a233Q6Y3eo133Yv3Qb42Tt357833v73GTV3gh63juz34X833UC3qGD2dc37Fm32jW3oL438803fH031Y13pqU3OXD3F6I3FH03M2l37wn35Z23bug3cxu32I03GR53JrQ378R3dVE3aSr34Zs32Nd3Qf73IXL3fgV3PIu38xl39T73F1d34173Q2O37RO3Bjj3Q9Q33gM37G43aCm3JiV3iSf34vF3JZm3Qg336e938YB3F643O4034YB3k2P3eYR35IQ3Fgv33673PON3fH03F8G36x739T73fd83In42v73nlh326435y634x83Jw53NKd3D2f3pts3Imw3KQf39oH3flq3f02329l2T439n335Ev3il639tp3QGt36063DX238K52r33aS433673Qb433hR3q8q2RH22233jU33Fj3O0u37my3nYT3pU63nYY3pU63Oyz2Rh3Qgc32QF32rK321U3dqI35EL3Fm13mFV39y2324l3EW334X03q9Q39Rf35Dm3Nu6325Q3PX03mGx3faE3K0b3Os133Bb339b3fIA32f33k4g34kK3C7M3q3M38tf35JW3E8m3eRs3bhX39iw3nwW32yj345L32Ds3dx836tT3C9v2k02Sr3og832iC39NB2sK3eLh33Wj2p032pS34k033053jIF350R3O9Q2m134BT36hJ3auK31U33ODe3G0x36jF3nP93IYA3nt238Uh3Jy336V934S23MSL3imc3q953aks359y391s34P533633e313HmR3Nhb3QJF3Q9l38bh3DpK36DD3hiP3qhA33T534x83EeU3joA32dQ344J3JOa2y732PS3qiR3HLK3Ivr39u83k40350j3qj236943a153P2f37v43JoA3N6y343u3Qbw3dzO39pq3Q9222032D4323z325V39XQ3NN934X83gWm32pS3F0g397A3qLT3QGs3JZD2363ey236pV33om3exy34fO39N53Joa3F6c3dpx3Aov3QpS3jaV3QDM3PeM3jOA35Zj3EqP3EQP34X83liY3Qq83pbG34Lv325q3HIP3GV53kDw34oc332037m634h03BbG3cPo3aO8316032E531uf3ADM3pfB33oM345338QX3lpu2ms2cp378s2ri32g93p6T38Pn3gSd3qk43973313Z33Ju3MSL3NW6351D39Su323221w34qA3Bkr36Xl3P3Q37od3CTJ32D93AHB3nqt335m3pXz2253p9I3bcc351j34g23M6Z3p152ks32F33F2m3K5c3CJS3BVf3M8I31xr3inC3Cgh3EZc3q7w32s63473323F32MD395P3E6b3AU73MSl38R631v8373936a531Yl39zc3Ajp331938kE3Jiv34jz2RH3pOI3k5x2TT3Co23bZ63NHQ3QM433173QIs3GLl3opm3JQ734933Bh137XJ3cyq327Q38qD34JO3f5c3p7B33oT3F3Y3J033Czx3fGs32723qLe3Edr39T73PaZ377v39T73P1U35723cWd3Dht229330c36Sx3EVM3CJK34ay3q703CnB38rb331B3kU43okE35t63Cim33bU33i8373X3nxp3OnT39v83HJQ3gBP3pJq21z331937J43ayy34e03bhx32yo2M12sa38ke3JMI35r637RO3ezc37gz3GBP3FBH3PE134aY3K3J3QIj31xm32FO32rp3P153G0P3fjv34Rd3bXm39o532kY32RK3Dv63FIe398d337632H0375g2mm34LD3co23gK532j938GS3Gl52CN3NhQ3M9T37nZ3H1X360939rR3gbc370h3NSm3asO3Cr73bll29J32543J6q331o3eyR3miT36c031uL3B5D3C5935sM32qf31Ve3qjN37Mm31wq3PtS3bqd325L33wx3oHI2mj3Dm53n3s3afI32Md31c433oU3Q1Y2NG3LG532oG2203gjF378R3PM73QX73nRl344j3c772LI3DaR3feP3imD323x3q6B37Pq39z3368P3PhO378r37Qk36743db532s93I4v376V32SA3h5U376C3Qy63lgh3l7j3fz43aV3349o3qY63qBU22b325v3kEO3Aat3Os022p33z933Pv334122w34me34x836JV3C3Y362k34pb3hRK3qy632DE369m31wL3QHa3Bnn378R3LeE38tR2Lj33LP3Qy63qPY3F353oJd378r3b903c3y3QvW3ASN2bg3nOD3QF73d393aME34X83PoG3E1h329b322T3Dar39Ws35ul2bg36842SA3qZF2q83qy63QEa3Q6x323s33K239e239B33ean2Mc34Bt3aKx32h831wt320432ba3pFr32te3B8w3guo32xz3bfn32Sx33IV3O2u31Yz3chg2ey3nw63nit39ax34iH3kNH38ld3bef34Ik37DK3G2b350H32GT31UU31uf378Y38TZ31Uo3f0G3fLN3r0c3PtF36R73hi0387D34x83cTR31WU33If3HTy35Zm33h622w3CYi3LFX3Q7l31uR33Og3C7D33B53oSt23C3Ng23bHP352p365k3pkW3m9m3PC537iq33b53BOq3PH62sD32ln3Go0385S3Lcx3nrl377V38Do3CBs3LwA3bNl38XM2L538GE3694329d34ZV349C31w03kht329O21Z3ql537Ze36V934Ex34nQ31YH3JNC38h038S43PQp374W33wC3M7G3Aso3l553ggZ3OfL3oh933pI33X03DMF32XZ328s3gC536gP3D7739xq33z13pAu3dkY3aSO3kX23E0A2Ey330p2203BYy37kS31YR337L329C33LP3OL93pbG3g4233k63MZH38843Np93Etj3adx31zP326F38NS348L36Fz36E733hL39h43C6B3JPj33k93ExE39a52mC33Fo388431wP39NK31W93Nli31TM3l5u37oI31TQ22432Fo324533h33QK4340J34x83gtC3pBg3He034e03d93328S32Dq39Bz335C31VV23033673c6D3DPQ3Pej3D9339PO3nR83OGm36fz3QTV23d3E2C3D2h31UE3Nnt23d3pTV22H3aSn3a1635d53lqj397722x338s33jn32fo38f43R4h33Hr3r4H3nPg333439To3Dsg3IL33oim3ABP2yj3C9Q3jaN33f73IlP3b2A37uW32G934bT3jPf3m423n5L329o2ez334k3AX6399k39l93F9437Eh39v83AmP3DA23lqJ3Ol43r6739AM3IIW3BO03BDg395U3j8p3D893FM03EbA369m3oVF34x82Id2Oz35cS3Qha2393OZF33Yv3F9i3OpL3N5l33Ux3R6Z39943OIm3b5u3F953PB036o732H03DcM340V31Wc3Otf22g33lE321b39dp3Cv43oiM3dMs31ZJ3j6K325v3dAZ3E9k32YE3opl35U8360I34D9333K34x522b3Nr832F43Eli3R60329h329g3hN72T122r3Ai63Fcm3qzW32qF36LY33cC32yo2213Lv634by363b3Hp031ZS347K3C322s33oLv32sb385P36cX3BZ43dK13qea22F33h632h737x135Uo3OKF3NIm3ODx3OCz3ONX3lN122131Yh33Wc357z3OKA36rU37sn36Qo3CYs3g2933Ef3qJT3g1a38Qx3dot3B3l38Zh36HH36B43PJh3DPq3iK23gm933a833B333zo320h3A2336123c1M34PX376T3o3b3by632V83l0834Is333A3fCY3h263DG23QKa39TP3k1039Cj3onM395p39733I803dp33avT3I1k346j3f7o355N35Lw3P2a3F1L3L113p9r36PZ344J3CY132PH3EbJ378r3mc83Fl733IO3aEe349833LE3R4h331i3j2r3OnM2sA3meg38G633913P1S39NZ3ptd3gAd33LA3IwT36Bz3p4m3a3039tO348y39P4375B31wC3m0D3c3a335B3if033C332Q039I12283opB3Dq1335B34SI3gOs39xq3nr83EsT3opF39R33d1c31U9331B335B39pC32P7391P2UK35F93b0k3pt5380T33IH335B31th3p0R33If3rd838De386s3E4432q039hz3Ay9339m3bsi39Y232bF3hak39Z136dW35lW3OW83Mbk3reD36ZL3gJW3k323DhE3CK539nz3385337Y3O142y732xY31z93O143o4g34BT3haK33H13295398i228332W32952tt37PO3p2F36VC329539m337oa3A65355A33343HAK325q3bs6334o39Cu3F35321i3P0J3nSK34yn3A6F39M333yG365y3Hr53DRl2nH3OQE333z3avL39Cu3Q1937gm33Lh3IQN3b4m3ozg33Ox3paI39bd3iyh3g5s3igQ395z39YS37gM3Kjp39R73On63b1r3DR932Q038EE2Q83Avl36DC3dKL35Z93pi93PL63D473dHE3FZV31U13O0L33NA3rGB2rh3ELC2mC33343qdN3glP32Wy313t3avL33cu39s03olq32eX3jOf3ORl3iK52343PI435vJ3Bwk386s2co38T63os136bY338e2li38B038dv31uF3lb736Ff3eBa3dzc3lBv34x53R5s360I3p2F3H5231Vn3oNz36713a4O3EOE23d34983niP3RdX392O31YH39Gp2EY2Cp3JPF3C9z3ma23bVn347U2UV3af83QnM327q3L5g3IYk3oYw35XF3KRB38Qx3ieG3P2x3OZX384X3QVo3bW3338k3d2f343X335B3oTT3oCK3phE33j93jPj3rcM3Q0l3h0G37fy3P1535BQ339M34GK354k38qX39la3h003e1t3odY36AO3PQp3cYi2wm34Y33ClT38Cn3rfa3Fpq34aw3PMR32P83H3h3i1z3Jd52CP31zs3jAu39pr3BfW2T13P713obj3bFw3LF23nkl3ouZ339m34yE34hH3rjH3oU73cJi386S35Kb37fy3q0D3Q3Y3RjN33j933aH3b1f36xp3mS93e5d33ah32so3cfR3r4F3RKs31Y333193bFW39hW3ElC37Fy3rF43Ds436ao3p3q3hb8339M3hJY35aY3j8m3be1347a3R4934a43Qrq32HX2t43qxk34153ECI2Mc3NhQ3N3F3r0m23c39b63bEW3EBa3C2c3OCQ3AI62sA2O02e133pP339S3c0s3c4e3IUX386S355d3qRD3ClT33pP31tf33H633PP3nKZ39R73aCZ3P2e339M3LSz339m337438Z033pp3eo83Mqd3RlA22P339d36A8346234NW33h636A833jS3bFW33oV3FzT2FB38IF3Pi13qm536A833ef3C0S3jA83L0F22034JF3j7739m73BEW3Qd43jf73PtC3oVX3F393RcM35aQ327Y345G33eC3rJN3DGT3AdR38gD36QO3kd538up328X37RB38Gd3Pma32nV3oNe3G373EPl3q2232eB3p2F3Iru345n3oW734j838QX3fZT32Ij3DX236Vi3EvS33q93B3V36Ep3pC13k593Q7L3JFz22f39773R5S31zT356g32bz3DX438XX31xn35403bL03LI23DUL335q3e3Y3jBF3EoZ3q7L34vE39B636VX39yh3l0b3DcR3K0o35tk34bt31VN344L3CUg38Nw3GHh3rcl3Rhp3p2F3Cqq3avl320l3rkA3CTJ2M93317327C39l83J773OZJ3dhE3H023RAF3e9S327Q2293P5x3LtI31xr3E77366g35A93bOe34Lq3N4F339m3klk3eCi32yo2Ni3eDa3EgS386s35Ug37k633672213pMp3N5i323e3e5f3eon3Opm31w03HIY3Q56371U39Ge3oyi3Re7360I34Ag3pqP379y39S137hU3IBz35uj3pkW354q31uM32013IWl3oqM3HED3dHP3D113avL3O563BWE38qX3bU03OYr33Q93MXR35kg36n5327C3pj43iJx2uv3fSG3r48327Q39il358N3PKD3cN835ab3pMa37a1388s33tE32zX3Mdh33QP313Y3Qu733Uc32CC3B0639k53CzD37QT39uR33h139Q02se3jRd38qx3lTY3oyU3Dc43K74342j3HsD371U3Anh3NGZ2Cn3rn93ko03ozI33LA330P31123AHP3qiA3CHm2g4335M37FU3Du13CzO339m3hHH34Tc3Dv63D693pQZ339m372l3dGb36O43b7S3Hr531Wc3GrR37fU3RGr338D3PRF3p8B3mLg2un3A2N3rAb34nL369s3o0e3CPq3h9L3P5r21x32oG36uv2sA366434lO386S3m4e33WJ37Y332Is32963RHC35Uo33pv33iv36Jq33qN3613331933JL31Zj33Lp3krt3e1T3D8636133K2m39i2361333C33h9l3rQZ34R73c7b3p2b35qT3oqM3rNB3cVh3RG6386A3ruH38373F393Rn339EH3iyd3nmS34x53l2N339M3g0p3kNV3C3D34Wt336737gA3dX822F33M322x39r63a0k2ri3cYN3kRt33le3RAL331I3Q5v3bf83dc62cn3j3n350X36FB32hj31Y137UG3bwe32mN3csS35Yf3IbD328y3DKt2SL3B8Q2c732n33FxF3nO93phj36793B0n323J3oQG3cA839Z23p0R3oEN33AH3Q1B3dc63A9I33Z93EHL3rwe330l2C7343x3P2C39BZ33An3oNe38bE35xU3du13ADR2d534403245396G3B903FZT3rw73qCX33gq3DzW3j813PRU2e13krT3FJT3DQi325Q3hiu396i3p6b3oPl3e6834Tv355931863doq392P37Wq31wh35qV34TA386S3GBr3D9736eW39W23hmr327q3HJm327Q3oWZ2wM34x53PoG36d93p1N343535DM3PI6313Z3p5u396i3E3632PZ3FqE37n13P9s3P383P3z38up3OxV2rJ22V22z3OFu34YB378S345g3CpE3OK13Hpf3n433E9D3di73R852vJ31uH34T931u53p1U3mkn365R32De3AjB3e1k3pEJ3Kcz3F1o339M3qAX31Ve31WC3hR5327q3K8U35eb330C34593rDb3AZ1337W3p2T3hDn36TR33j93E4f3Ncj327Q3aMX38rb339d3E2833le3E1k32ko3E1K3rDR34Ft353x3c9U337W3oU932x7386S38Ec36Bp386s3iS0337W31Yz32ii3E4F31XC3p9v3L3A3Ecy37543pi636b2386S3ifd3H7735aT3rJa3CGQ33pd34DK39vT37WW3D7u31va3P0722z3Opn3g3u3d7U3rMb3782365r33RH365y3A1533412AB3oPl362Y339m3bJM3s1d3p383QG23AN62Y73h9L32At3P2F3K83345N32i32E53onI3oEP3efo31Vv23a3Qgi3doB3qPy3iS7379Y3aso3CdE33Qp31wq3P7M3gWz3PC63OXd3ibW330835k038aV3K0E349b39Td3dz73icU3C2U3O563J39386S39NW38d13ogQ3fKq3eHZ398934w522x3Bhv33P33PFE34NW3CJ9336431x23Q9234JF3fBl324l3p1Y3R6d3JgG38QX3cfG37ro3kc032Eo3peH3hjF386S3jGZ39iL2u83o563bg0378e3O7H3K1034yq3P7X36wV3PUv392G3OC43rA1339m3c813I413Rim3jYM3KAc38gD3JKV34V635JE368Y3Pi934qG3aSO3l233rNm3J1T3fn33PVh3rOz3pK335QZ391P3cI13bVF327Q2oR2E431TQ36R236uV3g7s3PK33df53jgE3S5O3Jv83Eiv3agk3HcH2Sg3l933S3x331b3hcH3P2M3378339m23132bt3p1n381K339m3Ee134R03fHI3Rmb37sy3aE33hCH3aS43cRj313t3QfQ31WP33lE2at31603pph393I339m37YM38EY3miJ39Xe3eG63h2636Am3pCR3CyS2aT33fO2At3dy632H83AHP22H3s2n2323p2T3BTR3LJ5330p3HCH3RW73beT22x3fd53r6Q3c6w3H8P3iR3378R3700339M3h1r378E33z92AT3JON3E9h3r6q3rfJ3IY134qu37sD32EQ34Qu2TT3lJ53OQz38802213lMl22V2IE3d5G32XA3308386S340F33gn386r37RF37bY3s5O3p2T39Zs33bG3ONz3FU93DO232V73J4s31W734lS31u1357s32s63DZw3Noa3ICC37H92AT3K0E3El13E4c37643rab358T2213H433i3433903P0J3AQW3NPo3Ngg339M233323j33Na3LJ533jS372g3rn73QDP3NVP332Y36b033Jo36am32OG37GF329W3oQ031C43kh73Ph93HcH31Xw34R03fCs3O0c3C9B32b33piZ3o7J3b8n36Am3Orf3ePE3LJ5329w338S2iy3s892V632iW36jQ38B33PN23r143ejt3OrF35qt36TM3oU734O134f23L2R3A2m31Ya3g2k3KrB3S9l3dlK360g3PI43N8238qX3CG438rB3AMj37n12ql36EW3k2x3QM5341K3s9Z3j90334x32043Rlw35Al3FMb3P4T3C4Y3oU93H6h2Mn3Rtm3eIc337w3Bhn3P4t3rAf3aio3gM32A73pO235AQ3AjI37gz3Hjm3PlC38T339Vq3jaO3RUm3aeu33hm3pJA3j7R39bA2NI3saN377c3e283sBw3B3I3jYM35ze2hM3GV534lS35rn3qGG348e37g43qG13jgH38H5357U323r328x3scm3B2Z3I9b3OFO3Jnq34mV3eRy38Li33Ms31UR36FD382v22X3a2x3sDK3oH73kx232B3325q3lj53S2N3m2B3moM3AxI3eoG2KQ32i93Eq922x3C9B3ouU32sg2SP3F9l3p14386s3gwz35yr3lGw33JU3DUw3RfA3ed73S9n3s0x38323hCH3Rni36jj3mV031UL3axi3p7Z3h0g3bW13N4Z3Izz35Z6339s3aXI33HR3Bw13sA13EFx37Gf3Ewn3pls33LA33n13s9F38b633463SdQ3A103EGi3Dlu3aqa3Hon339m3fqQ2cn3mQG3P1e34633j9m3S3x37rl3fEm3nPZ3BFj357S3OXi3OYn333433LP340335573qYo3m7D31kt31QC1z22z2192X431Qj31Fh29P312k31gc31h021531h221P21P2KE2CL2le33yv31PR2JX31dX31so2ee31F321932e231UT21c2K236BO2rx2E721938062Le2Vk313131Sa2J331QM312221p3a9y35Zx2F92RD31h631T322R3Sgm3SgN31GA3eWB2Q431Ga3dMH3nPy2k22RA2Es2XI2mN39692L83sH12hY3SGC21p2MJ2tY39Z42Lt3sHb2wz3shD3SHD3sHf2192k0320f2L82192F82D621J2183EQz2ev3shp37Rj2Vs3sHT3sh3312R3SGD2MA2u03B3m2Le3sGj2O231g63si43shD310734CF36ff3Sgw3bdg3Q1x2183R7I32iT31f43Sh23shv3bUY32932vH2fB3SiS3SGL2ee3siw2182eI320f2cS31ga316y3PXH31ga3m5N2e03SJL2Kf374L3Sik312K31hd31rh2UF31d32cI2EE32Hs3ISD363b2p332w02392c02393hNY2N42G92gK2H734un1w22q2g72343j2Q2Hp2Pj31182C033YY2pX36a839Ji23E2pX21r3SkV2n038OF3Omb2A82iL1W2Wm2hP2Ac3g412jX3skd2NE38Lv2NM2b63I1N2p63AM42H63sL22dS3Bw12A82AT3SKN3irM2Ab2We22V2j72wh2ov2Tm3sk034wD3cWG2EZ357s2mf31fp2CI2KP2kR2kT2KV2R62M73sK021431862kf376821g2P334GC3C3Q2PF3G4129p2aD2w13jqh2cy2Hs2AU2Kz2A83HnJ2GF2ug3Mvx2c33KLM32Qv2gl2Mv2h535Qv31oj2OR2hv21m2ft3SlS31Ke2Od32uO378U3d1g22I33zR2ov2fI3Sm932UY34Ik36kg2rN2aY2rq3J96393a2rV320532022s13B752S434gY31Zw2s22SB3EPB2Sj361h32AX3QOK3qOi3FK43PAO31uy372q2SX32tQ3iuI3qI333dp2T729t2t92AE2nh2382Td310R2MI2f934i6393a2p32g92aM3SOK2A82J522T3Son2KY2F63Sm92tx3arJ31Vl2P32mR2G72Gt2Mw2Wa2Gi33IS2ap3SlD2hY2qr3sLg2BU2ai2aK2b42B631oc3slg3sKJ2nu2mx2gl3SLD33Bb2nM2aN2C52DL3sLR2o92uF31QK2a931qN2ky29R2f631PD31P32xA31t02dU31rc3SHd29R31F331rI2CH21131qi2f63Shd310X3Sqi2xe2323SQl31PX3sqd31hE31g631hp2162xP217317Q31P12ea3Sq431aY31r62Xp31ds2xP312j31QG2xu21B22s22m312r21931GF2152113sRf2eE22T3sri31gA3SRH31Gf21731Gf3SQW31T3311I312R310W3sJ62Ig31Qg3srM311I3sRU3SjE23321131G8317Q21Q2cH31i231Hp2e72WS22x31hM3sR32Cx3sq422x3SQ631Ry31162143sQa311f2zc2Xd2x52XE310V31QI31NZ31t03Ss531G63sr23sJX2ky3SQ431i329V3sq721831O5310S3SQ92143Sqb310Y21722v31Qy3sqG3Ssu3sQJ3ssX31113Ssp31o53SQQ21p22X3SqT2oc3sHD310s3stR22s3Sqt3Sqn31PE3STr3SQS3ssy31PY31Ji3Sgl23221623721521731T62162393suC21422x3SQZ3sUc3sT331Hd2UF2Cz2YW2l62Cb3sq33Sg62jX2392WW31FK31G623f2dl2XH21823D21421t3sga3sSj2a03Sq422g3SUX3sT82eA3sjZ2d12d3398i2tV21739782Fl3b5v2u12oV3sM83SVg2xg2173SlW2F13Sly21H3SQ22kY2lW3slV3Bq1369i37GV2mf2EC3sm92D32DY2lD36KG2R12vx3sVY2ea2Cg2ci21322637eA21y36nF35BJ2Ue2KY2kN3sp32MJ38U333Fp2p327t3aM423632W02oR3SkO2aS3s8f3sL029C312a2OR2hk2302fW2fY2ae35822as2AN2G83JxQ2pJ3SQ0312k3brh31bq358j22h1w32582Ym3Sn92KY2r83sm932sR39z4332o2P32h02H22g02282g22pd2G52w829P2gb2px2N43SPA2gi3e4o2gP2go2GM2GR3spA2GV39w42gy3Sy03sXB2h52h72h92j52Gz3bvH2he3SPM2hH2Hj2HL2Io2Hp3siT2Hs2AN2Hv2I32hY2I03sx52I32iY29P2J02I92o12ic2iE2Bj2Ad2ii310x2ND2Im3sZ02iR2hW2A92IV3SZq3Szb2I62i8312k2j42Px3sq12mf2l03Sm2341g3l1a3HCh2oH32Ov2ur315N2Vf37x12F1387v2mF2lb3sm23hFd3GRU376t21U3T092KY31gi3SK03a7Y2Rb3ifM2Mf2UT3Sw72eG2Mm21n3Nob3svj3sk23lO42Yj3swe2Cx3SM12D12f83B8X31ZV21L2P33gdQ1w3k0K2Hk3rF7377m2372gY2GF2hH3sl02n02iN37Vb2Ad38lv2zW3SML2W22AD310P3sZ12Hi2mX2h33G41311829c2T82wC2PE3t1f2Aw2NT31Sa2hl2h62312Gm3O6A2g72J32NY2Gl2Nl35cb2Ah3P7B1W3t262W32HI2342Dl3sP02Ea3sP22Cj3SNK33p421C2mf2Jc3Sm93dG43NZd2E421J3SXZ3sxa2H3327M21e21a21i2P62A838F12Nc2O32NM2HY2PM2g03D0i2h72wm2ap2g435qv3Sx93SZ42g72ph22z3Skm2PR2a63SMQ3irM2Gl3T1x2p72gs2mT2W73T2P2hH29C29p1X3T2V317U2tn2ez2EN313t2eN2mn2JH34wd2jN3suu3svc317k1w2Vh21k3Sj3397831NI2Dw2dy357s32I034OX2FE2Mf2qx3SK034RM329Y37gH2tL2vf3m7B2MN2jz2Re2Od2KQ2Ks2Ku2vd2Tn31N42Jr31N62Jw2dL3T4z2eh21D3sJ3388A3sj32Le3SJh2mN2KA3H772yY3sVo2UF2vn3swh37PO2N3365N3elO22823D3Swo2EA2Cz315S2lZ2M12282Ov2MH3t0v2D921h21N3sGq21N33p33SVj3Sib33IG2Q63t142a02wj3swh3czd38av35Ek35yY3t6f2cx314t3Sk037902q53svl2V03Suu31bq3sVC3Src31OA2uf2a231nB31bP31kf3t7J2kY2vu31QM3SQi3SPp3122310x31I33SgO31sh31Oi22Z31ou31qP2dw311D3Spp2V13T7W2XU31Ga3T7z31Rw2uF318P3ssm3SQI31Ds318P31jH3SiS31Qo3T8f2x8316531J22xu31153sru2HU3ShU31Qm3t8i31O3312j31Rr313p3BNB2xp3T8C312c21p3t7x31Q63t953T892OV2oc31R12Ky2Z92143Sr62gx22F21521621422V22M21t2E721731242x921p3Sr622831Pg3t972eE31r922m3SR63T9O31pi31qm2XS21p31gF312J31DS2Z93Ta63t8K3t8o21P31hG312v3sRu2J0386X31S92IG2Xs31qi2oc311u31rH3t8T3sIl3TA522N3tac31662WK3TAA31GF2ze312v2xo311L3sSF31ay3t9k2323Tb32x53tAI22Z3Sv82GM21P22h31E031OG2273t9j31t63SUd22r21b3t9L22M22d31E431N121p3Ss72TM3ta63sZM2UG3T892o12Mt3TBa311D3TaR3T8h3sgD31Q53T8y2a62ac3t903B9Q2153T932eA2XE3t962cC3TAd31Q33stF31t023331R93Squ311B31ow29c3TAJ3TAQ3SJ73t8V3SGd21y3SiS3t8z2QP3tcc3Tce2ob3T983T8G31qm2Oc3tAB3SRb3tAD2142132133tb93TCS3tbb31rh31DS22s21Q31Qx3srB3sp13StA2Wk3tdD31QC3TCk3sSS31Pl31r92X52XS3SqV3T7u31qH2181Z31O53T1W312B3SSo3sHD31Pd31Q331O531QU2E73Stl3ssW21123921N2f623229t31ot31S83sjX3TaD3TAp3Sh231RX2CX2gx31l53tdr31O93SSR3SqC3TDv2xp31nH3TdY31pL31Ob2o131qT2H42Jx21V3sSe3tD32a031223STK3STr310v3tEh31093Tel31ou31Kd3tAd31qi31rH3Tc23TCU3ss13TEP2ab3SJv312O3St42ea2xS3tCH3tE0310x31Og3t8B2Mt2373T823t7m3T852O12uh3tg2313F310831OI3T9s3t8M31S12zB3t8r3SiS3TDY313F3svp2xb310t21822421822W31O63tA6218310x3TGy3TgX3tgx31ef2yp2XA2gX2343Ta33Ste3sgd23B3Sis3TC431qm2tF3td931IF2G831p53T892X5313O3t7S2xQ2m73SUI3thJ21N31A63ThM3SIK31Ds3the2213siS3T9e3t963tHk3THi31gd21n3tHO3t8m2x53THS3Thq315b3Tg83Te02gX3tgu3te52gZ3tG723f22j23231j23t8m21831rO31J23tHm31nh3tFR3sIL3THe3tH631S521P3Tg631T63thJ2cU3thl3thq3ti53Thq3Ti83Ti33THC3th831iN3tHY3Tix2CJ3ti02cu3Tj43Ti33tj63Ss03tIT3sGD3SRA3Thg3Thz3Tj32Wk3TI63THr3Ti23ssI31DS3Th321821u3tjX2153tjL3sIS318P2CI2382CU3tdI31qM3Tjw23D3Sv33tk031QH3Sis313C3TG63t963tk63TER3tkf22j23131R03Tk631sJ3TK82ZB313j313J3tkC3tJm2nC310U22J22R3tKo312o3Tjv3TkR313I3Tha3Tk1312j31352ci22W3TL03TGI3TjW21W21831393tL63Thg3tiA31OA3TIC3sta2DW3tge31Rw2243T823st73Tc33sUN3sQ73tjC315h3TcI3ifj21k21A2DD2l73sVM2Eh2eW31J23TeH3SM2320h356O35my38cT31nT31JT2ci22g31J222w3tcI2133QY52m431kC3swH36tg22832972302M331j22243tCi21922B31J22383tlT312O3t8L3t9931dx3Tii21923A31j222E21n2xw33WE3gHU23e31nT2373TnC21931gT3TbT3tNc2133aYB37ch376H388m2293tMn311u2XW335I35q636F1359331nt3Tbb2xW390Z390331NT31P03TIr31Hd31dx31Qq2jt31Ed3sG52wU3sg722q31eQ22u31ND3sga2z82ko3tNE378E3t0m2ea31352eJ31qo3Sm23TO431A23t9a2D02193F9D2Ei21c2R63t162133tNX39uf3c5e21V3t772fh3toZ3CXM32FK2cu31dX31qK3T7h3SVz21p2133tMq3TmS2m33Slt3tPL3tMA39vu345B22q2132xR2a33QY53suS31Ok21P2Xg2OV31222142Q532933eyD2EP31bp3tq53tD1313G3sJy3tq223H2oV2RF3Tlz3tm13T523tm43SBy2oV2f63tp031862Li31Ef3Sv029T3tqh3snA22r22J3tLA314b31e221D31bp31cG3SV43SV62Jt3SI631BP2z9392Q36lE2oV3TLj31Nh3tE03Sgs2312K231oI31h23ssB2du3T8Y31op311J31j223C31op21721D3tKI2Ig2xV31OQ31k33tRV3TrX3TN231eF231311j3trW310c3TC9310F3Tqd3TcD3TE62cx31223Tni3sOo31AT2Cu2oO2cI31rp3TGi22S21O21P2M93sIS3tdJ3TSr2e43TSU3tD73TSR318s3TsY31t63tsr2l83TA83TSZ3SH63tt23TsQ21P3T31312J3tJ83TD83TR4312J3TS03tIj31k23tti31SL31B72CI3Tkz2kK2D03tSO3TSj3ttj314b3Ttl314931rI31jl3TRW3TMI3ttY2y121p22w31OP3Tky3TTx31223tSN2cu3tti3tik3TiP3tU63TtM31RC3tUa3ttY2ci3TUD3tbT3TUf31mQ3TtO3Tu83ttr3TuB3Tu63tul3tTw3tTN3tu73ttQ3TuI3TuC31k22363tun3TuY3tIo3tuj3tTJ31or3tv33tu63TTp3tuH3Tv53TV031Oz22J31SL3TVC3tSo3Tve2d03Tvh3tU93TvD3Tut31K22Ci3tVm3TUr3TOy3tUk3TUs3tu32Xv2y1313P31e031pm3T5v3TVr2Zz3Tf531od3t953TRW3StA31OI3ts031j23BEm31P03sjX3tvT3TVK3tUv2163TtI3TvB3TVn3tvJ3TvP3tUe3tW43tV43TWO3tVV3TwQ3tVg3TUq3TUz3tWP3TuM3Twr22J3TWL31493TWs3tus3twu3TX03Tww3tuw3twM3TWH3twZ3TWJ3Tx33tX53tV63tuL22U3tV33Tvi3TX63Tv721P3TXJ3tWr3txL3txH3Ttk3tv93txF3TXG3tWi3tv93tUP3txg3tTT3TIK31QJ3Tx83TUG3Tvy3Tu03TxO3tu23tWv3tXb3TUi3tY13tVw3TV83tVZ3TY63TRX2x53te03tw23twa31RW3TwC3tA62aB31Kd3txc3tX73txe3TvA3TwX3TVO3tx73Tw43tXr3tYd3Ty93TUM3tvz31nA31073TYl3TW42xQ3TYK3TW92QM3tYn3T823tWe3tyr3twY3tWU3Tv33tx83tYB3Tv53tWN3TRy3SIL3TTA21E3SIs3TVK3tOh22v3tV32Xj3tWE2Xi310j3tC33TCV3Tt321P2Cs3tT631T63Sgd21F3T8K2KY3Slu3TTu3toM3tuP3tqP31qh2172EQ31R22xf2XV31Rp2yQ22T3Tu02xD3ttJ31NG3TYJ2o131223t5v31173tzD2323SR131J222t3tFL3tfX3TeT31QH22J3Ts43sR93tZs3Ttj31Qh21n3TsM3tww3U013T8u3U033u053ThG3Tzn3Txs31J23TV23Txq3u1m3TZ12Uf31353tuV3TU23ty73tmj3TVy3TMi3TYv3Txw3twz3tyZ3U1r2ky2Oc3tvV3TZ23u1z3TW03Tz63Tw93TZ83u0u3TW73tyl3TZC2mT3Tyo3tZf3twg3Tyc3u262d03ty23u1t3Ty43TtX3tYh3TU13U1Z3tu43u213tXr3TVK3u243TYs3TxN312R3Tww31153t313Tz03U2O3u283u2A3tz531Q93u2d3tWW3tZ93u0V3tw83t5V3U2I2Gm3tZe3TYQ3U2m3TyX3tXN3TXP3Tx93u383Sr43u2P2R62OC3U1v2xV22u3tY7312o3u3Z31j231Rn3TXZ3U3T2cX3TKX3TY22XV3tkZ2YQ22r3TU03u2F2n031163TYM3u2J3U3m3tWF3sUn3U323TUL3u3431SL3U3631Qy3tUi3U1p3TX93tX83TuD3u2Z3Twz3u4V3tUG3u1R3tVT3Tis3tDj3sgD3SvX3Tth3U233u1g3u252ea3U273ttu3u2w3u3B3TW13U3e31SL3u3g3u2g3tZB3tWB3u4l3TZG3tzm3U393u0D3t943U3Y3tTz3TRX31NU3u2W31D53u463U5C2f53U3V3tty3tIk2YQ3U103tYI3tw63U4h310x3u3k3u2K3U3n3U4n3tYC3U543u023ttA3tt53tHg3U303u5B3Tvt3tz13u5g31jL22L3u2b3U3D3tw33U3f3u4g31223u2h3u5O3tS13u2L3u6g3u5r3U5d3U643T9S3u5V3TW231J231243u5z3u2Y3U622a03t2X3U4a3TTJ3U673U4F3u6a3T7v3U4j3U3l3u723u6F3tN33U6p3u543sjW3u6J3Tt03tTc3ThG3TSV21P2e63U063td82Fe3U593TZI3Twr3TzK3ttX3TTE3tsr3U823U1l3U0B3u643u0m3Tv83u0n3u3c3U0P3u6W3u5k3u6Y3U0H3u3J3U713tWd3U7R3u1h3tZp3Sin3U1b3tYT3tXY3TUX3u4z3U8y3TX13u613U6P3u5S3u2q3st53u2s3TVW3Ty722U3tZ23U3R3tzL3twT3TXn3U1v3u7f3ThH3U3A3tU73tUm3U4c3U3c3u4e3U8m3TW53TE03U9Q3u7O3U6E3U4m3U7s3Tzh3U9H3TxK3u533tui3u8b3sGE3U7y2Nc3U0K3U283t9S23F3u8h3U0O3u7l3TQx3SP12D03tkz3TQ43TTb3u6A31093TGX3tGF31Qz21D3tTY31rp31233u1431hd3tG13U5n3TZd3u7Q3u9X3u8U3u803tqa3u8321Q2mC3U8x3ua03u933U903u1m3tXX3uB93U9F2r62V13Ua93U2o3U5v3u403u5x3u423tAD3U453uba3U4O3tXT3u1Q3u952Ea3U493tUS3tKz3u9N3U6t3U9p3U5J3u9s3u3H3u9u3U6D3U5P3U3o3U9G3Tuu3Ua13u7T3uA33U7w3ub33u6m3Twz1z3U1V3U553td73UB53u09312J3Te03Tvv31DP3TwW3Uay3T8p3Tzy3Ub13TSz3Tt1312j31rW31DX3TVe3tOD3ucj3u033sgv3u833Tt03u853U7z3tt72vH3Tt23tVE31153TUP3sIs3u1f3TVH3Ud33TTF3U6l31pS3u5a3tVs3u2N3u763U9L3tVX3u6s3u6u3Tz73U6x3u7M3u3i3u9V3Uc63U743Uc83UBr3tX93U7e3Ubt3ssk3u773Ubi3txk3U3Z3u413tTy3Taw3ubo3ube2oV3UbV3TtY3u4C3U4b3u7L3U9T3uDZ3uaZ3U5q3Ue23U1o3UcA3u6H3uCc3U1I3Tta2kE3u0a3SSo3u283uCz31Eu2GS31e029R22W3UD23U7V3uEw3TT03sI03UD931T63ub53U8d3UA73TLV3u283tl821723c3si63UAL3tTB21823c3U713TKn31jh3tV531Rh3te022W3uAx3u4K3uep3UdJ21o2Vj3UB73tUl31dZ3tZ83U913UB83U3S3uBB3tXD3UeT3U3P3uc93ubS3U9z3uGG3Ugb3uCB3UFV3Uf93u8v3Sh63ua62Jx3tVE3T843uA43UD53Ucf3u923uE43u943UGi3Ue33TtM3Ue53UDp3td43ubh3U3U3U793u9B3u9D3Uh33UGF3uH13TyW3tTs3T9d3U8g3U9M3u4b3UbZ31e03u9U3u2E3UDx3uC43u8R3tYP3Ub03uGC3uGX3U523Ugl3tSo3UG23Sh63u583uFd3TzQ3uCM3UI13sGd2oz3ug53TvQ3u6O3UH42A03U5E3U7I3UDs3tz43U5i3U9R3U5L3U4H3U703Ucs3uHr3Ueq2r62363UE83u763U5V2363uEC2xv2363u443UHb3ueR3TVl3u223tX73u4Q22L3U4s3u473uIb3UhH3UiF3U2C3UIH3u8O3Uik3uG03U8s3uhS3UBq3twV3uhV3uia2C03Uiq2Cx2xS3UH83U5X3u7c3U6S3uAt3UGZ3u753U633U9L3U662xV3u68314a3Tg13uEO3uJf3uiN3Txr3uGU3UI33UDm3tx73U3R3tUg3udJ21q2Tk3Tdn3u3U3Uh63TD43uBj3UiU3uBN3uIY3tXM3tul3U313UJK3Uic3tYe3tz33UhK3UJA3Ucq3u8n3UDx3uJD3u7p3UK43uc73UKo3UhD3TxA3UHE3Ul43TVF3UDO3uHC3Ul93tY03uAG3uJx3UkV3tGX3uc13Uii3T7V3ufz3uL13Uim3uL33uk63u7W2Ey3t8k3ujH3t9t3uGE3uIZ3tW421b3u0f3UHT3tV73tZj3TXf3uG93tUl3u513UL73u1N3TxO3uLV3Ul83UJ03um43ui83UlA3uhF3udQ3u5F3UDt3U3C3uDV3uKY3tZa3U8Q3uil3U733U9y3uLb3ULu3UGh3Ums3UKq3uMv3ui93ujv3uJ73UDr3ulg3uml3UC23U5M3umO3uJE3ULn3uE13uMB3UkB3uM73Tvk3um63uj13UM13u883Um33Um03UM53Uma3tvu3UMI3Uie3U6t3u4t3UMS3tUv3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UZ23uZJ3V3B3UmC3UzG3UtV3V0H3U6R3Uj93u6v3ukx3UN43uIj3V3s3usm3V4O3V4H3UgJ3Uz73uwQ3V3L3v3K3v0V3V5B3v3j3uZ93uno3uua3v503ULJ3UdY3UtR3v3t3utT3tVe3V153uzk3tx73v4p3UzN3uZ33uX73V5a3uU53V593V5c3v5F3ut63V0z3uuB3v113V5L3V543UYH3v5p3V4S3v5S3utd3UBf3uS93uoG3tY83u2w3U9e3V4S3v5A3v603v0y3v0k3v3Q3UN53v123uk53V3v3v383U9j3upE3tPx3U5v3UK03U5y3u1c3uoJ3us63u6i3UFa3uvs3UQe3TeS2a03U0c3Ute3u483v293V203U0G3U8H31PN3UAR3v2r3tA93V2E3tT22323Tsr3v2V3v1d3TyZ3v303v2r3UD33V2h3V7B3V2k3ThG3V2M3UaR2Kb3v7r3SjW3V1g3Tt734wd3uVr2uv3Tt93u083uQm2H43T7s3TWP3v7O3u1g3uhy3V863U863TXN3TYZ3uDJ3u083uVg3Uqn3U3q3V563uoB3V493uyI3V3A3UT33uYO2R62oo3utG3tiX3tz23Tg63V8r3uM93v3D3V6r3uy23V8Q3V4F3V373V963V3C3UYX3v5T3v4r3uZ03v8P3V8S3V6S3V0q3v9E3UV13urA3V4x3U6T3uYR3v643UHQ3V0p3uxI3tv33V3X3v5Q3uWI3V9G3Ux83v983Uy83UJj3uZI3v583uUi3v9Y3V3f3UZp3uZs3v9T3v5u3usF3v9M3uzA3v003UZC3UYS3V653V9s3UmS3V6A3v953v923uzm3v3e3VA93VA33v8t3v393v9I3uKr3Uj83UT63v9P3v3r3uXX3uTs3V553v943Uo03v9K3UYv3VAo3vam3va03V973V9w3V573vAS3ur93Uus2O22183UzY3USI3V9o3Uzc3V023tDv3up03U983Upr3U2G3V0931Rw3V0B3Ts93tYO3TV23V0f3UvD3v4w3VaE3v4Y3TYl3uF73v0m3V9r3Uzf3V9j3TTM3V9V3v6I3V5z3Vc03V5g3V623v5i3UZD3VAI3vc73V4d3Uw23V163v723uQk3u043uVW3VB63V9g3TZj3Ulz3UUO3V9Y3vb73vB43VA43V673v4E3V713ua33V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3w1T3vzK3Vzu3voO3Vw63VKC3vDl3VT53vR53VLp3vDB3V413Vn83vqN3td838063vgg3VY13ttb3tHu3Tt73vU53uKG3U163uwx2xS3uab3tiO3U6u3vqI3Vx93upM3vTO3V4k3TlV3vBq3VwT3UaN3t8c3uaP3v7g3UJt3TLb3UVA3vrS3UHY2kF3Vu43vqc3uqc2cO3vx23vfp3vbk3vX73UK13U3h29R3vqm3uA42U03vnD3vTE3VOp3U983v8y3U9c3V6g3vqY3W0b3w1W3Vz73Vll3Vy63VXp3W133VZB3VUb3W1K3VxS3U633V8Y311u3u2w2323w2P3Vg93U6j21Q388A3VHG3Vhl3vR93uW53VZX3w1j3W2e3vzt3W233vff3W253vcM3UEv3UQk3W3o3w303vfo3U9L3vFQ31ou2yQ3w3W3U8o3Vxb3w403VO821p2Cm3vLe3t5g3vq13Uwr3vvB3U8b3W5N3vq13VO43uAi3UKd2Cp3w4w3vqR3V9y3vqs3UkH3vSS3UkK3vTK3W1S3W0A3vt03w2i3vLK3VkD3vch3w2m3Vm93VEE3VzF3VuO3W6a3w323w2A3uJr3TU33V703w4k3ujN3vbf3tOJ2oC3Uzz3uoT3uos3U4F3uox3t9q3v053U2o3w3d31223up431oi3Up73vbv3T823tXj3UpB3VBz3TFy3vuE3W343uOt3U3C3vWq3w383v283ULz3uag3w733123310T31oI3tEJ3W783tS131rn3TY23Ufw3UQ23W203w143v173ufA3vU33VPo3v8E3w5l2F03uvR2Cl3w873v453V8N3Uo33uvj3upo3W2R21q37pw3VGG3W193W173vJs3w643w1n3vvp3VKv3W683W2f3vS33uEi3UhJ3UBy3u6U3uHm3vV03UHP3vv23vR63V373vEL3W583Tsv3w883w5Q3W633uE73Vvo3W663VRK3UKm3vTM3Vxk3Vs43vXM3Vz83W6E3w903W2n3VYT3Uv13v6U3VOq3VkT3v6X3ujR3uV43W6P3vhs3w2q3ua43SHI3Ub42Dd3W8I3W023U0F3w5t3v8m3u4H3vHh3vuL3w053VZe3VuN3v5w3VUu3VuS3W4B3w9g3w1X3vUz3W4f3vkF3uxY3Vd03VRA3vb23VZq3Va13w6Q3vux3V06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G63WSr3wVs3v733WZr3W5B3Wa63vj4310X2TM3uZz3vx53tS03w6y21N31353U0p311i3W0m3u163w7n3UF631Oi311A3WvI3U723vG93wy833p33vgg31dz3nPO3W2X3tT33wqA3x073W9o3vwm3UoF3v6X31QI3uPH3u173u463UHY2S13uVR31723X1c2mm3wzS2Fo3Vlh3V782R631QT3w0F3UAC3U8K3wOu3X0g31qz3SrO3X0K3vFO3w3d3uaM3W123Tu93W783uas3w4Q3VWW3wIL3U032TI3WiF3VPm3wIi3v7w3V1e3v813X233ttF2d63vlh2oC3tzV3u1q2KY3vLV21W2r62tm3tQ33t9S22731nB21823F22N22N2AT2bu2Tf3TpI317h3sVd3tsG3x183TpG3St23wzM3tu63v24314A312n2183x2U2or3Hnj2dT38753tXO3t4r31qT3SsU3wz83tfl2cI3trX3X373TtK311D3tRh3Tf63sGE3WtT3TRL3Wz2312231S33ty231H222J3tp33sGD3uVw3u132323si63T8P3uAb3uCQ3TRx3tIr3tER3x463x482Xf3tOj3X3n22L3tO8312o3TLq3wYP3tY73tFo3WNJ3tx73toH310s2Xa3U003WZQ2r13wxG3wPR3wS73Wn53Wr23Wpe3WdE3w073VvN3WJr3VtI3VkU3W673WjW3wxt3Vh33WXV3WJ63Wk23WxY3WQU3Wy03wjA3x052Vl3uB42fN3WA53V4m3TwP3wyG3x5n3vP63W313VSS3U243t942EL3t9K3TUp3TRA3v7D3USf31223W3D2Z93vqI2aP31rw3W4q3vmR3TY73v1z31so31R93tUy3Ts93WZo3TtE3Ub53ub63Wy43TTM3WsX3U8B3x1B3VQq3WXz3WXN3Vsc3w2a3Vsg3u2X3WO73wtF3wn43wpT3wTi3wr33u9j3VRG3wSg3Vj63W9C3vJ93X703ULT3W2V3u373X713wh63whL3wWd3WTK3V933WH43w8M3wr83vkT3VVQ3uBm3VTl3wWz3U9k3uMI3WJZ3WXw3WX53wn73UYV3x7E3vO03vQ73V4n3wss3wx83Vo73x2c3tT02K03x1c3UCX3Ui43sGe2sA3wzu3wuW3WM03VRw3w9a3X793vvr3wkr3x5c3wV03X7G3x513X733WN63WSa3W9L3wpm3WEu3x023WPx3wd13WZw3WUh3VRF3Wfm3x8L3ubM3x7b3x7t3vt13VIW3wk13vRr3x5I3wzv3x6V3vJ43vSd3x593vSf3vIT3X7C3vJc3WHj3WTh3X8t3WtJ3WIV3x8J3x583W1P3vUG3X963w8q3wEh3Ut53X9a3uSK3X9d3X8h3WkE3w1M3x7O3X593vsU3w9C3wFP3X9L3vaC3Wur3wjj3WWr3x7j3x8v3x923x903X8Y3WrI3WSD3x713ww03vSe3uH93w493Xab3vGs3v6U3x173Wby3VTs3WGK3Ta63Wws3wWG3Uq831D03SIs3VN12JW3WZP3W4T320E3w3t3w5d3UnX3Ulg3VxB3Vx93uCO3WvQ3wn73x6r3x8A3X6O3VW23u2Y3x1a2UZ3Vd731463X8G3Vec3WF83wS03wzz3X913wuG3woI3wRz3x033vyO3wPG3CWG3Vlh3X123VP73V6d3x153U653u123vvJ3tXz3WgQ3WNu3fDM3XBs3VG33wpk3X013WuO3wlr3x8P3x9Y3WTG3wai3Xaf3wlx3WRS3WMe3W9v3vP33x052lD3WWJ3whD3Wad3WTD3wUp3X503wfc3xaY3WKJ3w213Xc03x8Z3vAk3V9y3WQ03WX13u4d3X7X3XCS3xa33UW73T843WwG3X2b31nI31T22jw3sKG2143Svb2xI2XG2182xN2e73SvC3T4Z2JT21n]==]);local function e()local o,c,d,e=s(d,u,u+((#{317;824;854;132;}-(1))));o=t(o,a);c=t(c,a);d=t(d,a);e=t(e,a);u=u+((#{164;(function(...)return 954,(504),201;end)()}+0));return((e*((((#{575;817;625;835;(function(...)return 558,9;end)()}+16777271))-#("guys someone play Among Us with memcorrupt he is so lonely :("))))+(d*(((65614)-#("luraph is now down until further notice for an emergency major security update"))))+(c*((((323-#("concat was here")))-#("why does psu.dev attract so many ddosing retards wtf"))))+o);end;local function c()local e=t(s(d,u,u),a);u=(u+((((#{169;719;751;}+58))-#("woooow u hooked an opcode, congratulations~ now suck my cock"))));return(e);end;local function c()local e,o=s(d,u,u+(2));e=t(e,a);o=t(o,a);u=u+(((#{620;}+1)));return((o*(256))+e);end;local function t(t,e,u)if(u)then local e=(t/(2)^(e-((1))))%((#{((789-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")));343;118;}-1))^((u-(1))-(e-((1)))+(((94)-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))));return(e-(e%((#{}+((94-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!")))))));else local e=(2)^(e-(1));return(((t%(e+e)>=e)and(((#{675;((147-#("luraph is now down until further notice for an emergency major security update")));}-1))))or((((#{588;(function(...)return 558,969;end)()}-3)))));end;end;local e=({[((#{345;(((#{733;806;578;960;}+185)));((#{((937-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!")));173;(function(...)return 780,(349),539,...;end)((605))}+((#{859;(function(...)return 886,836,543,281;end)()}+553))));}+((#{954;(function(...)return 473,977,933;end)()}+(261880538)))))]=("\99");[((#{(648);((((897-#("IIiIIiillIiiIIIiiii :troll:")))-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")));410;119;(function(...)return 699,(((73)-#("woooow u hooked an opcode, congratulations~ now suck my cock"))),(696),(((460)-#("please suck my cock :pleading:"))),...;end)(((#{((#{389;79;(function(...)return 517,755,910,825,...;end)()}+895));581;(67);((124-#("@everyone designs are done. luraph website coming.... eta JULY 2020")));}+726)),515,(333),((#{325;696;((867-#("why the fuck would we sell a deobfuscator for a product we created.....")));}+933)))}+401185873))]=((((((420-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)"))))-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait"))));["x2SfOoss"]=("\114");["IqtZOkX"]=((41081779));[(((919591128)))]=(((((110)-#("@everyone designs are done. luraph website coming.... eta JULY 2020")))));[((((((348926051-#("this isn't krnl support you bonehead moron")))-#("who the fuck looked at synapse xen and said 'yeah this is good enough for release'")))-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait")))]=(((((166484539)-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!")))));["A4eJ8BD7"]=((((1753080)-#("concat was here"))));['i5keHkIZPy']=((21));[(195882252)]=((((31))));[(((#{868;(function(...)return(836),((#{24;33;190;}+369));end)()}+((538194734-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building."))))))]=(((#{}+59734993)));[((181531910))]=(((#{((#{((#{}+813));84;}+((#{416;(function(...)return 561,595,582,646;end)()}+121))));211;(function(...)return;end)()}+(163))));[(673428081)]=(((#{(function(...)return 756,((127)),494,((#{((#{995;}+29));653;}+425));end)()}+411598)));[(((497330930)-#("please suck my cock :pleading:")))]=((((((165-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!")))-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!")))));[(500496108)]=("\116");[(((((333190726)-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait")))-#("i am not wally stop asking me for wally hub support please fuck off")))]=((((#{919;(function(...)return 488,...;end)(((#{308;438;742;}+799)),((342-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)"))),(791))}+(48)))));[((#{820;617;}+((((166484736-#("Luraph: Probably considered the worst out of the three, Luraph is another Lua Obfuscator. It isnt remotely as secure as Ironbrew or Synapse Xen, and it isn't as fast as Ironbrew either.")))-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")))))]=("\102");[(116707133)]=((((((#{540;794;923;49;}+65603))-#("why the fuck would we sell a deobfuscator for a product we created.....")))));[(((#{((315-#("IIiIIiillIiiIIIiiii :troll:")));((#{526;639;(function(...)return 98,3,70,393;end)()}+246));((376-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot")));(function(...)return(637);end)()}+((871067525-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait"))))))]=(((733177152)));["RXAAGJ"]=((3));[((#{(((180-#("psu == femboy hangout"))));((316));(((498)-#("why does psu.dev attract so many ddosing retards wtf")));}+856027840))]=((((#{(737);789;501;(function(...)return 131,((562-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))),(14);end)()}+(1017)))));["E9HGP"]=(((#{((410));}+(31))));[((((#{15;((#{297;}+304));((745-#("woooow u hooked an opcode, congratulations~ now suck my cock")));(function(...)return 799,(651),(746),...;end)((841))}+103418815))-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))]=(((8)));[(((#{((187-#("woooow u hooked an opcode, congratulations~ now suck my cock")));((989-#("luraph is now down until further notice for an emergency major security update")));(function(...)return...;end)()}+80247594)))]=("\109");['O5jDImtZLx']=(((#{915;(((458)-#("concat was here")));126;}+49)));[((((#{536;724;530;(function(...)return 921,...;end)(495,478,114,752)}+52263162))))]=((0));["nBZRc0dmWD"]=("\97");[((#{((((#{251;}+556))-#("why the fuck would we sell a deobfuscator for a product we created.....")));675;((((845-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")))-#("please suck my cock :pleading:")));(((603)-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!")));}+204667023))]=(((#{(function(...)return(((725)-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))),(261);end)()}+73)));vyAzvkZw6=((((16777311)-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot"))));[(((226644886)))]=(((((#{((#{323;(function(...)return;end)()}+946));((#{100;649;91;}+207));603;(function(...)return;end)()}+54))-#("I hate this codebase so fucking bad! - notnoobmaster"))));[(970234050)]=(((((((#{269;85;829;(function(...)return 22,215,911,571,...;end)(448,300)}+5171))-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")))-#("guys someone play Among Us with memcorrupt he is so lonely :("))));[(((((207509133-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!"))))-#("psu premium chads winning (only joe biden supporters use the free version)")))]=(((((((439742-#("please suck my cock :pleading:")))-#("I hate this codebase so fucking bad! - notnoobmaster")))-#("woooow u hooked an opcode, congratulations~ now suck my cock"))));[(55496869)]=((6));[(392735293)]=(((#{(987);924;934;(function(...)return(((745)-#("I hate this codebase so fucking bad! - notnoobmaster"))),((((#{713;336;910;(function(...)return 169;end)()}+1086))-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))),(259),144,...;end)()}+(261880538))));[((#{(734);((((#{}+593))-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")));(function(...)return((#{835;240;(272);(function(...)return(41);end)()}+860)),12,((#{110;(685);781;((#{(function(...)return 314;end)()}+723));(function(...)return(47),946,49,714,...;end)((490))}+271)),(((940)-#("please suck my cock :pleading:")));end)()}+840806897))]=("\107");[((#{((#{}+((812-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot")))));(((90)-#("still waiting for luci to fix the API :|")));(function(...)return;end)()}+(628830551)))]=(((#{(273);283;(((901)-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")));(function(...)return((((642-#("why the fuck would we sell a deobfuscator for a product we created.....")))-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")));end)()}+0)));[(((316252356)))]=(((#{853;((((878-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait")))-#("why the fuck would we sell a deobfuscator for a product we created.....")));((#{((137-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")));637;787;(function(...)return(980),((572-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait"))),157;end)()}+218));(function(...)return 698,456,629;end)()}+190142221)));[(733177152)]=("\108");[(820726204)]=(((20)));['v8gxLLod0']=("\115");[((958230564))]=(((((#{}+51))-#("concat was here"))));[(703108244)]=((47));[((#{862;((#{((#{346;604;451;292;}+639));}+84));((950));(function(...)return 424,(300);end)()}+((((288888544-#("why the fuck would we sell a deobfuscator for a product we created.....")))-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))))]=(((#{}+903452682)));[(708556134)]=("\101");VZLQyy3a=("\117");[(903452682)]=("\120");[((#{729;(((876-#("psu premium chads winning (only joe biden supporters use the free version)"))));((#{}+408));}+840568549))]=("\112");[((#{138;((#{703;((#{898;}+517));}+359));(function(...)return 748,(((442-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot")))),...;end)(154,((((#{889;436;794;875;(function(...)return 817,713;end)()}+727))-#("IIiIIiillIiiIIIiiii :troll:"))),622,269)}+41081771))]=("\98");[(((#{((614-#("guys someone play Among Us with memcorrupt he is so lonely :(")));638;(function(...)return 863;end)()}+((420980917-#("please suck my cock :pleading:"))))))]=((((90))));['sIiV3Y7JF']=("\105");[(((#{}+51499923)))]=("\110");["ETX2GZ7MP7"]=(((((#{390;(986);(function(...)return 813,...;end)(730,((#{413;515;782;956;}+877)),(889))}+(840568620)))-#("psu premium chads winning (only joe biden supporters use the free version)"))));[(((((#{92;234;240;57;(function(...)return 846,...;end)(141)}+190142316))-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot"))))]=("\118");[(59734993)]=("\111");[(((((122536563)-#("still waiting for luci to fix the API :|")))-#("I hate this codebase so fucking bad! - notnoobmaster")))]=(((#{}+1)));[((((377173493)-#("still waiting for luci to fix the API :|"))))]=("\104");znedG=(((((377173575))-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop..."))));Gb4S6QbL=((((((764704)-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")))-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!"))));[((((497105750-#("psu 34567890fps, luraph 1fps, xen 0fps")))))]=((((500496190)-#("who the fuck looked at synapse xen and said 'yeah this is good enough for release'"))));NuTFQr4L=((((350493))));[((((#{}+599411256))))]=(((51499923)));[((((335989857))-#("i am not wally stop asking me for wally hub support please fuck off")))]=(((#{(((#{340;255;694;611;(function(...)return;end)()}+559)));744;((#{((#{446;}+454));344;969;(function(...)return 974,...;end)()}+157));(((419-#("IIiIIiillIiiIIIiiii :troll:"))));}+80247592)));[((((((#{}+310171060))-#("psu 34567890fps, luraph 1fps, xen 0fps")))-#("psu premium chads winning (only joe biden supporters use the free version)")))]=((840806903));[((((#{(function(...)return;end)()}+479047123))-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")))]=((236));[(((((#{286;732;372;}+772673701))-#("please suck my cock :pleading:"))))]=(((#{10;(((125)-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")));39;(((1094-#("Luraph: Probably considered the worst out of the three, Luraph is another Lua Obfuscator. It isnt remotely as secure as Ironbrew or Synapse Xen, and it isn't as fast as Ironbrew either."))));}+244)));[((974532737))]=(((#{119;((#{((#{}+67));984;526;}+(343)));628;(function(...)return((#{458;702;}+239)),...;end)(360,((((#{363;191;223;56;(function(...)return 211,846,231;end)()}+350))-#("why does psu.dev attract so many ddosing retards wtf"))),13)}-5)));["McJP1zcssZ"]=(((#{(function(...)return 585,523,834,431,...;end)(((853)),((((1036-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")))-#("guys someone play Among Us with memcorrupt he is so lonely :("))),632,(302))}+708556126)));[(((((#{232;236;363;(function(...)return...;end)(26,597,425)}+893333002)))-#("i am not wally stop asking me for wally hub support please fuck off")))]=(((#{548;633;775;(867);(function(...)return((#{838;}+979)),760,((#{(110);(function(...)return...;end)()}+104));end)()}+564706325)));['fpb45iB']=((((((#{225;640;(function(...)return 325,633,...;end)(374,942,557)}+2055)))-#("concat was here"))));[(30631062)]=(((((#{877;(86);}+((#{}+144))))-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop..."))));[(((1753160)-#("uh oh everyone watch out pain exist coming in with the backspace method one dot two dot man dot")))]=("\121");[((#{(((488)-#("still waiting for luci to fix the API :|")));380;}+(((#{346;82;927;(function(...)return 968,153;end)()}+564706325)))))]=("\100");[((((#{45;328;}+261880610))-#("@everyone designs are done. luraph website coming.... eta JULY 2020")))]=("\99");[(((401186004)-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")))]=(((256)));["x2SfOoss"]=("\114");['IqtZOkX']=(((#{}+41081779)));[(919591128)]=(e());[(((348925881)-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))]=(((((#{887;750;}+166484465))-#("psu == femboy hangout"))));["A4eJ8BD7"]=(e());["i5keHkIZPy"]=(((#{860;((#{317;789;494;301;}+351));171;}+18)));[(195882252)]=(e());[(((538194685)-#("@everyone designs are done. luraph website coming.... eta JULY 2020")))]=(e());[((#{317;((#{924;468;779;}+315));}+181531908))]=(e());[(673428081)]=(e());[(497330900)]=((((192)-#("Luraph: Probably considered the worst out of the three, Luraph is another Lua Obfuscator. It isnt remotely as secure as Ironbrew or Synapse Xen, and it isn't as fast as Ironbrew either."))));[((((#{237;168;218;179;(function(...)return 341,255;end)()}+500496169))-#("i am not wally stop asking me for wally hub support please fuck off")))]=("\116");[((#{961;232;}+333190552))]=(e());[(((#{309;990;907;623;(function(...)return;end)()}+166484442)))]=("\102");[(116707133)]=(e());[((((#{809;(function(...)return 150,755,223;end)()}+871067527))-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")))]=(e());RXAAGJ=(e());[((((#{212;944;328;}+856027959))-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")))]=((((1145-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")))));['E9HGP']=(e());[((103418763))]=(e());[((#{423;((888-#("why does psu.dev attract so many ddosing retards wtf")));(634);(function(...)return 295,184,((#{969;830;13;113;(function(...)return;end)()}+935));end)()}+(80247590)))]=("\109");["O5jDImtZLx"]=(e());[((((#{326;892;981;(function(...)return 710,...;end)(4,958,944)}+52263184))-#("psu == femboy hangout")))]=(e());["nBZRc0dmWD"]=("\97");[((((204667138-#("why does psu.dev attract so many ddosing retards wtf")))-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))]=(e());['vyAzvkZw6']=(e());[(((226644907)-#("psu == femboy hangout")))]=(((((172-#("woooow u hooked an opcode, congratulations~ now suck my cock")))-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)"))));[(970234050)]=(e());[(207508980)]=((439600));[((55496869))]=(e());[(((392735375)-#("who the fuck looked at synapse xen and said 'yeah this is good enough for release'")))]=(e());[((((#{768;910;}+840806941))-#("still waiting for luci to fix the API :|")))]=("\107");[((#{540;}+(628830552)))]=(((#{186;(585);239;((#{893;625;}+262));(function(...)return(373),((#{425;620;21;42;}+763)),52;end)()}-(3))));[((316252356))]=(((((190142379-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))));[(((733177204-#("why does psu.dev attract so many ddosing retards wtf"))))]=("\108");[(((820726282)-#("luraph is now down until further notice for an emergency major security update")))]=(((#{447;426;107;}+(17))));v8gxLLod0=("\115");[((((#{942;}+958230685))-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")))]=(e());[(((703108296-#("why does psu.dev attract so many ddosing retards wtf"))))]=((((118)-#("why the fuck would we sell a deobfuscator for a product we created....."))));[(((288888479)-#("woooow u hooked an opcode, congratulations~ now suck my cock")))]=(((#{(746);(665);(function(...)return 710,7,245;end)()}+903452677)));[((((708556295-#("you dumped constants by printing the deserializer??? ladies and gentlemen stand clear we have a genius in the building.")))-#("this isn't krnl support you bonehead moron")))]=("\101");["VZLQyy3a"]=("\117");[((#{259;833;((432-#("I hate this codebase so fucking bad! - notnoobmaster")));(function(...)return 611,...;end)()}+903452678))]=("\120");[((840568552))]=("\112");[(((#{474;124;147;}+41081776)))]=("\98");[(((420981012-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop..."))))]=((((161-#("why the fuck would we sell a deobfuscator for a product we created.....")))));["sIiV3Y7JF"]=("\105");[(51499923)]=("\110");['ETX2GZ7MP7']=((((840568611)-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)"))));[(((#{(function(...)return;end)()}+190142227)))]=("\118");[(((#{394;56;939;458;}+59734989)))]=("\111");[(((122536530)-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)")))]=(e());[(((377173524)-#("why the fuck would we sell a deobfuscator for a product we created.....")))]=("\104");znedG=(e());["Gb4S6QbL"]=(e());[(((#{779;766;34;235;}+497105708)))]=(e());NuTFQr4L=(((#{808;(322);(464);(292);}+350489)));[((((599411452-#("oh Mr. Pools, thats a little close please dont touch me there... please Mr. Pools I am only eight years old please stop...")))-#("psu premium chads winning (only joe biden supporters use the free version)")))]=(((#{(236);}+51499922)));[(((335989883)-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!")))]=((80247596));[(((310171030)-#("who the fuck looked at synapse xen and said 'yeah this is good enough for release'")))]=((840806903));[((#{}+((#{385;}+479047015))))]=(e());[((772673674))]=(((248)));[((#{(450);((#{988;576;693;389;(function(...)return 137;end)()}+787));((#{}+528));}+974532734))]=(e());['McJP1zcssZ']=(e());[((#{80;(function(...)return((375-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")));end)()}+893332939))]=(((#{(69);969;659;252;}+564706328)));fpb45iB=(e());[((30631062))]=(e());[(((1753143-#("luraph is now down until further notice for an emergency major security update"))))]=("\121");[((#{271;(992);}+564706330))]=("\100");});return v(o(d,u))(e or(function(...)end),...);