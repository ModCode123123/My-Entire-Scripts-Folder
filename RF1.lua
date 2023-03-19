
-- Instances:

local RemoteFinderOne = Instance.new("ScreenGui")
local MainGUI = Instance.new("Frame")
local GlobScan = Instance.new("TextButton")
local Workspace = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local OBJName = Instance.new("TextLabel")
local Fire = Instance.new("TextButton")
local Lua = Instance.new("TextBox")
local ScanGUI = Instance.new("Frame")
local Scan = Instance.new("TextButton")
local StringFind = Instance.new("TextBox")
local Object = Instance.new("TextButton")
local SelectedObject = Instance.new("ObjectValue")
--Properties:

RemoteFinderOne.Name = "RemoteFinderOne"
RemoteFinderOne.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
RemoteFinderOne.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SelectedObject.Parent = RemoteFinderOne
SelectedObject.Name = "SelectedObj"

MainGUI.Name = "MainGUI"
MainGUI.Parent = RemoteFinderOne
MainGUI.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainGUI.Position = UDim2.new(0.347540975, 0, 0.359259248, 0)
MainGUI.Size = UDim2.new(0, 372, 0, 254)
MainGUI.Style = Enum.FrameStyle.DropShadow

GlobScan.Name = "GlobScan"
GlobScan.Parent = MainGUI
GlobScan.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlobScan.Position = UDim2.new(0.0472308733, 0, 0.834025741, 0)
GlobScan.Size = UDim2.new(0, 116, 0, 24)
GlobScan.Style = Enum.ButtonStyle.RobloxButtonDefault
GlobScan.Font = Enum.Font.SourceSans
GlobScan.Text = "Global Scan  🌎"
GlobScan.TextColor3 = Color3.fromRGB(255, 255, 255)
GlobScan.TextSize = 14.000

Workspace.Name = "Workspace"
Workspace.Parent = MainGUI
Workspace.Active = true
Workspace.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Workspace.BackgroundTransparency = 0.500
Workspace.BorderColor3 = Color3.fromRGB(255, 0, 0)
Workspace.BorderSizePixel = 2
Workspace.Position = UDim2.new(0.500549138, 0, 0.0462520346, 0)
Workspace.Size = UDim2.new(0, 162, 0, 214)
Workspace.CanvasPosition = Vector2.new(0, 262)

UIListLayout.Parent = Workspace
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

OBJName.Name = "OBJName"
OBJName.Parent = MainGUI
OBJName.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OBJName.BorderColor3 = Color3.fromRGB(255, 0, 0)
OBJName.BorderSizePixel = 2
OBJName.Position = UDim2.new(0.0478875749, 0, 0.0445161313, 0)
OBJName.Size = UDim2.new(0, 152, 0, 33)
OBJName.Font = Enum.Font.SourceSans
OBJName.Text = "No Item Selected!"
OBJName.TextColor3 = Color3.fromRGB(255, 255, 255)
OBJName.TextSize = 14.000

Fire.Name = "Fire"
Fire.Parent = MainGUI
Fire.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fire.Position = UDim2.new(0.0472308733, 0, 0.389143825, 0)
Fire.Size = UDim2.new(0, 116, 0, 24)
Fire.Style = Enum.ButtonStyle.RobloxButtonDefault
Fire.Font = Enum.Font.SourceSans
Fire.Text = "Fire Server"
Fire.TextColor3 = Color3.fromRGB(255, 255, 255)
Fire.TextSize = 14.000

Lua.Name = "Lua"
Lua.Parent = MainGUI
Lua.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Lua.BorderColor3 = Color3.fromRGB(255, 0, 0)
Lua.BorderSizePixel = 2
Lua.Position = UDim2.new(0.0478875749, 0, 0.242101252, 0)
Lua.Size = UDim2.new(0, 148, 0, 20)
Lua.Font = Enum.Font.SourceSans
Lua.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
Lua.PlaceholderText = "Enter LUA String Here"
Lua.Text = ""
Lua.TextColor3 = Color3.fromRGB(255, 255, 255)
Lua.TextSize = 14.000

ScanGUI.Name = "ScanGUI"
ScanGUI.Parent = MainGUI
ScanGUI.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScanGUI.Position = UDim2.new(1.05694282, 0, 0.0152520612, 0)
ScanGUI.Size = UDim2.new(0, 160, 0, 231)
ScanGUI.Style = Enum.FrameStyle.DropShadow

Scan.Name = "Scan"
Scan.Parent = ScanGUI
Scan.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scan.Position = UDim2.new(0.0909808725, 0, 0.105576992, 0)
Scan.Size = UDim2.new(0, 116, 0, 24)
Scan.Style = Enum.ButtonStyle.RobloxButtonDefault
Scan.Font = Enum.Font.SourceSans
Scan.Text = "Scan  🔎"
Scan.TextColor3 = Color3.fromRGB(255, 255, 255)
Scan.TextSize = 14.000

StringFind.Name = "StringFind"
StringFind.Parent = ScanGUI
StringFind.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StringFind.BorderColor3 = Color3.fromRGB(255, 0, 0)
StringFind.BorderSizePixel = 2
StringFind.Position = UDim2.new(0.198476404, 0, 0.281394273, 0)
StringFind.Size = UDim2.new(0, 85, 0, 20)
StringFind.Font = Enum.Font.SourceSans
StringFind.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
StringFind.PlaceholderText = "workspace"
StringFind.Text = ""
StringFind.TextColor3 = Color3.fromRGB(255, 255, 255)
StringFind.TextSize = 14.000

Object.Name = "Object"
Object.Parent = RemoteFinderOne
Object.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Object.BorderColor3 = Color3.fromRGB(255, 0, 0)
Object.Size = UDim2.new(0, 147, 0, 23)
Object.Visible = false
Object.Font = Enum.Font.SourceSans
Object.Text = "Nil"
Object.TextColor3 = Color3.fromRGB(255, 255, 255)
Object.TextSize = 14.000
Object.TextWrapped = true

-- Scripts:

local function ZRTHWW_fake_script() -- RemoteFinderOne.MainButtonCode 
	local script = Instance.new('LocalScript', RemoteFinderOne)

	repeat wait() until game.Loaded
	
	function Scan(Model)
		local OBJ = nil
		if Model then
			for i,x in pairs(Model:GetChildren()) do
				if x:IsA("RemoteEvent") and x.Parent == Model then
					print(x)
					OBJ = x
				end
			end
		end
		return OBJ
	end
	function GlobalScan()
		function GetRemotes(Par)
			for i,x in pairs(Par:GetChildren()) do
				if x:IsA("RemoteEvent")  then
					print(x)
					return x
				end
			end
		end
		local ScanLoc =game.ReplicatedStorage
		for i,x in pairs(ScanLoc:GetChildren()) do  
			local ReturnRemotes = GetRemotes(x)
			repeat wait() until game.Loaded
			wait(1.5)
			return ReturnRemotes
		end
	end
	
	
	
	
	local MainGUI = script.Parent.MainGUI
	--local RF1Module = require(script.Parent.RF1Module)
	MainGUI.Fire.Visible = false
	MainGUI.Lua.Visible = false	
	local function MakeOBJ(Object,Name,ClassName,Parent)
		if Object == nil then
			return
		end
		local Text = script.Parent.Object:Clone()
		Text.Parent = MainGUI.Workspace
		Text.Text = (Object.Name.. Object.ClassName)
		Text.Visible = true
		Text.MouseButton1Click:Connect(function()
			script.Parent.SelectedObj.Value = Object
			MainGUI.OBJName.Text = (Object.Name.. "[".. Object.ClassName.. "]")
			MainGUI.OBJName.TextScaled = true
			if Object.ClassName== "RemoteEvent" then
				MainGUI.Fire.Visible = true
				MainGUI.Lua.Visible = true
				MainGUI.Fire.MouseButton1Click:Connect(function()
					if MainGUI.Visible == true then
						if Object:IsA("RemoteEvent") then
							if MainGUI.Lua.Text ==nil then
								Object:FireServer()
							else
								Object:FireServer(MainGUI.Lua.Text)
							end
							
						end
					end
				end)
			end
		end)
	end
	local function Clear()
		for i,x in pairs(MainGUI.Workspace:GetChildren()) do
			if x:IsA("TextButton") then
				x:Destroy()
			end
		end
	end
	
	
	MainGUI.GlobScan.MouseButton1Click:Connect(function()
		function GetRemotes(Par)
			for i,x in pairs(Par:GetChildren()) do
				if x:IsA("RemoteEvent")  then
						print(x)
					MakeOBJ(x)
				end
			end
		end
		local ScanLoc =game
		for i,x in pairs(ScanLoc:GetChildren()) do  
			if x.Parent == ScanLoc then
				GetRemotes(ScanLoc)
				GetRemotes(x)
			end
		end
	end)
	
	MainGUI.ScanGUI.Scan.MouseButton1Click:Connect(function()
		if MainGUI.ScanGUI.StringFind.Text == nil then
			
		else
			function Scan2(Model)
				if Model then
					for i,x in pairs(Model:GetChildren()) do
						if x:IsA("RemoteEvent") and x.Parent == Model then
							print(x)
							MakeOBJ(x)
						end
					end
				end
			end
			Clear()
			local scan = Scan2(game:WaitForChild(MainGUI.ScanGUI.StringFind.Text))
		end
	end)
	
end
coroutine.wrap(ZRTHWW_fake_script)()
local function CFPZ_fake_script() -- MainGUI.DragGui 
	local script = Instance.new('LocalScript', MainGUI)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0, true); -- drag speed
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(CFPZ_fake_script)()
