-- [[ BUNBUN HUB - ROBLOX CLASSIC FLY ENGINE V8 (CLEAN RESTORE) ]] --

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local ContentContainer = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local BunIcon = Instance.new("ImageLabel")

-- Tabs & Frames
local PlayerTabBtn = Instance.new("TextButton")
local MiscTabBtn = Instance.new("TextButton")
local SettingsTabBtn = Instance.new("TextButton")
local PlayerFrame = Instance.new("Frame")
local MiscFrame = Instance.new("Frame")
local SettingsFrame = Instance.new("Frame")

-- Elementen in Player Tab
local FlyButton = Instance.new("TextButton")
local SpeedFrame = Instance.new("Frame")
local SpeedLabel = Instance.new("TextLabel")
local Mode1Btn = Instance.new("TextButton")
local Mode2Btn = Instance.new("TextButton")
local Mode3Btn = Instance.new("TextButton")

-- Fly Style Selectie
local StyleFrame = Instance.new("Frame")
local StyleLabel = Instance.new("TextLabel")
local NormalStyleBtn = Instance.new("TextButton")
local SupermanStyleBtn = Instance.new("TextButton")

-- Speed Slider
local SpeedSliderFrame = Instance.new("Frame")
local SpeedSliderLabel = Instance.new("TextLabel")
local SpeedSliderTrack = Instance.new("Frame")
local SpeedSliderFill = Instance.new("Frame")
local SpeedSliderKnob = Instance.new("TextButton")
local SpeedValueLabel = Instance.new("TextLabel")

-- Elementen in Left Panel (Keybind onderaan)
local KeybindBtn = Instance.new("TextButton")

-- UI Instellingen
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

--- ========================================== ---
-- [[ STYLING UTILITIES ]] --
--- ========================================== ---

local function addOutline(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 50, 50)
	stroke.Thickness = thickness or 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

local function addCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 4)
	corner.Parent = parent
end

local function styleOptionBtn(btn, parent, text, pos, size)
	btn.Parent = parent
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	btn.Position = pos
	btn.Size = size or UDim2.new(0.28, 0, 0, 35)
	btn.Font = Enum.Font.RobotoMono
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 12
	addOutline(btn, Color3.fromRGB(45, 45, 50), 1)
	addCorner(btn, 4)
end

--- ========================================== ---
-- [[ UI BOUWEN ]] --
--- ========================================== ---

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MainFrame.Position = UDim2.new(0.5, -225, 0.25, -175)
MainFrame.Size = UDim2.new(0, 450, 0, 390)
MainFrame.Active = true
addOutline(MainFrame, Color3.fromRGB(255, 40, 40), 1)
addCorner(MainFrame, 6)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then update(input) end
end)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
LeftPanel.Size = UDim2.new(0, 130, 1, 0)
addOutline(LeftPanel, Color3.fromRGB(35, 35, 40), 1)
addCorner(LeftPanel, 6)

-- Bugs Bunny icoon
BunIcon.Parent = LeftPanel
BunIcon.BackgroundTransparency = 1
BunIcon.Position = UDim2.new(0, 6, 0, 8)
BunIcon.Size = UDim2.new(0, 22, 0, 28)
BunIcon.Image = "rbxassetid://14578474740"
BunIcon.ScaleType = Enum.ScaleType.Fit

Title.Parent = LeftPanel
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 30, 0, 12)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Font = Enum.Font.RobotoMono
Title.Text = "> BUNBUN"
Title.TextColor3 = Color3.fromRGB(255, 40, 40)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.Size = UDim2.new(1, -20, 0, 150)

local function styleTabBtn(btn, text, pos)
	btn.Parent = TabContainer
	btn.BackgroundTransparency = 1
	btn.Position = pos
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Font = Enum.Font.RobotoMono
	btn.Text = "[ ] " .. text
	btn.TextColor3 = Color3.fromRGB(140, 140, 140)
	btn.TextSize = 13
	btn.TextXAlignment = Enum.TextXAlignment.Left
end
styleTabBtn(PlayerTabBtn, "PLAYER", UDim2.new(0, 0, 0, 0))
styleTabBtn(MiscTabBtn, "MISC", UDim2.new(0, 0, 0, 35))
styleTabBtn(SettingsTabBtn, "SETTINGS", UDim2.new(0, 0, 0, 70))

KeybindBtn.Parent = LeftPanel
KeybindBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeybindBtn.Position = UDim2.new(0, 10, 1, -40)
KeybindBtn.Size = UDim2.new(1, -20, 0, 30)
KeybindBtn.Font = Enum.Font.RobotoMono
KeybindBtn.Text = "BIND: LAlt"
KeybindBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
KeybindBtn.TextSize = 11
addOutline(KeybindBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(KeybindBtn, 4)

ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 140, 0, 15)
ContentContainer.Size = UDim2.new(1, -155, 1, -30)

local function createPage(name)
	local f = Instance.new("Frame")
	f.Name = name
	f.Parent = ContentContainer
	f.BackgroundTransparency = 1
	f.Size = UDim2.new(1, 0, 1, 0)
	f.Visible = false
	return f
end
PlayerFrame = createPage("PlayerFrame")
MiscFrame = createPage("MiscFrame")
SettingsFrame = createPage("SettingsFrame")
PlayerFrame.Visible = true

FlyButton.Parent = PlayerFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
FlyButton.Position = UDim2.new(0, 0, 0, 10)
FlyButton.Size = UDim2.new(1, 0, 0, 45)
FlyButton.Font = Enum.Font.RobotoMono
FlyButton.Text = "// TOGGLE FLY: OFF"
FlyButton.TextColor3 = Color3.fromRGB(255, 40, 40)
FlyButton.TextSize = 14
addOutline(FlyButton, Color3.fromRGB(40, 40, 45), 1)
addCorner(FlyButton, 4)

SpeedFrame.Parent = PlayerFrame
SpeedFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
SpeedFrame.Position = UDim2.new(0, 0, 0, 70)
SpeedFrame.Size = UDim2.new(1, 0, 0, 85)
addOutline(SpeedFrame, Color3.fromRGB(30, 30, 35), 1)
addCorner(SpeedFrame, 4)

SpeedLabel.Parent = SpeedFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 12, 0, 8)
SpeedLabel.Size = UDim2.new(1, -24, 0, 20)
SpeedLabel.Font = Enum.Font.RobotoMono
SpeedLabel.Text = "> SELECT FLY SPEED:"
SpeedLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

styleOptionBtn(Mode1Btn, SpeedFrame, "INIT_1", UDim2.new(0.04, 0, 0, 38))
styleOptionBtn(Mode2Btn, SpeedFrame, "HALF_2", UDim2.new(0.36, 0, 0, 38))
styleOptionBtn(Mode3Btn, SpeedFrame, "FULL_3", UDim2.new(0.68, 0, 0, 38))

StyleFrame.Parent = PlayerFrame
StyleFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
StyleFrame.Position = UDim2.new(0, 0, 0, 170)
StyleFrame.Size = UDim2.new(1, 0, 0, 85)
addOutline(StyleFrame, Color3.fromRGB(30, 30, 35), 1)
addCorner(StyleFrame, 4)

StyleLabel.Parent = StyleFrame
StyleLabel.BackgroundTransparency = 1
StyleLabel.Position = UDim2.new(0, 12, 0, 8)
StyleLabel.Size = UDim2.new(1, -24, 0, 20)
StyleLabel.Font = Enum.Font.RobotoMono
StyleLabel.Text = "> SELECT FLY STYLE:"
StyleLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
StyleLabel.TextSize = 12
StyleLabel.TextXAlignment = Enum.TextXAlignment.Left

styleOptionBtn(NormalStyleBtn, StyleFrame, "NORMAL", UDim2.new(0.04, 0, 0, 38), UDim2.new(0.44, 0, 0, 35))
styleOptionBtn(SupermanStyleBtn, StyleFrame, "SUPERMAN", UDim2.new(0.52, 0, 0, 38), UDim2.new(0.44, 0, 0, 35))

-- [[ SPEED SLIDER UI ]] --
local walkSpeedValue = 16

SpeedSliderFrame.Parent = PlayerFrame
SpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
SpeedSliderFrame.Position = UDim2.new(0, 0, 0, 270)
SpeedSliderFrame.Size = UDim2.new(1, 0, 0, 75)
addOutline(SpeedSliderFrame, Color3.fromRGB(30, 30, 35), 1)
addCorner(SpeedSliderFrame, 4)

SpeedSliderLabel.Parent = SpeedSliderFrame
SpeedSliderLabel.BackgroundTransparency = 1
SpeedSliderLabel.Position = UDim2.new(0, 12, 0, 8)
SpeedSliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
SpeedSliderLabel.Font = Enum.Font.RobotoMono
SpeedSliderLabel.Text = "> PLAYER SPEED:"
SpeedSliderLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
SpeedSliderLabel.TextSize = 12
SpeedSliderLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedValueLabel.Parent = SpeedSliderFrame
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.Position = UDim2.new(0.75, 0, 0, 8)
SpeedValueLabel.Size = UDim2.new(0.22, 0, 0, 20)
SpeedValueLabel.Font = Enum.Font.RobotoMono
SpeedValueLabel.Text = "16"
SpeedValueLabel.TextColor3 = Color3.fromRGB(255, 40, 40)
SpeedValueLabel.TextSize = 12
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Right

SpeedSliderTrack.Parent = SpeedSliderFrame
SpeedSliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedSliderTrack.Position = UDim2.new(0, 12, 0, 42)
SpeedSliderTrack.Size = UDim2.new(1, -24, 0, 6)
addCorner(SpeedSliderTrack, 3)

SpeedSliderFill.Parent = SpeedSliderTrack
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
SpeedSliderFill.Size = UDim2.new(0.1, 0, 1, 0)
addCorner(SpeedSliderFill, 3)

SpeedSliderKnob.Parent = SpeedSliderTrack
SpeedSliderKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
SpeedSliderKnob.Position = UDim2.new(0.1, -6, 0.5, -6)
SpeedSliderKnob.Size = UDim2.new(0, 12, 0, 12)
SpeedSliderKnob.Text = ""
addCorner(SpeedSliderKnob, 6)
addOutline(SpeedSliderKnob, Color3.fromRGB(255, 40, 40), 1)

-- [[ MISC FRAME ]] --
local MiscLabel = Instance.new("TextLabel")
MiscLabel.Parent = MiscFrame
MiscLabel.BackgroundTransparency = 1
MiscLabel.Position = UDim2.new(0, 0, 0, 10)
MiscLabel.Size = UDim2.new(1, 0, 0, 30)
MiscLabel.Font = Enum.Font.RobotoMono
MiscLabel.Text = "// MISCELLANEOUS UTILITIES"
MiscLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
MiscLabel.TextSize = 13
MiscLabel.TextXAlignment = Enum.TextXAlignment.Left

-- [[ SETTINGS FRAME ]] --
local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Parent = SettingsFrame
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0, 0, 0, 10)
SettingsLabel.Size = UDim2.new(1, 0, 0, 30)
SettingsLabel.Font = Enum.Font.RobotoMono
SettingsLabel.Text = "// SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
SettingsLabel.TextSize = 13
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left

local UnloadBtn = Instance.new("TextButton")
UnloadBtn.Parent = SettingsFrame
UnloadBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
UnloadBtn.Position = UDim2.new(0, 0, 0, 55)
UnloadBtn.Size = UDim2.new(1, 0, 0, 45)
UnloadBtn.Font = Enum.Font.RobotoMono
UnloadBtn.Text = "// UNLOAD SCRIPT"
UnloadBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
UnloadBtn.TextSize = 14
addOutline(UnloadBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(UnloadBtn, 4)

--- ========================================== ---
-- [[ LOGICA: TABS & KEYBIND ]] --
--- ========================================== ---

local allTabs = {
	{btn = PlayerTabBtn, frame = PlayerFrame, name = "PLAYER"},
	{btn = MiscTabBtn, frame = MiscFrame, name = "MISC"},
	{btn = SettingsTabBtn, frame = SettingsFrame, name = "SETTINGS"},
}

local function switchTab(activeBtn, activeFrame)
	for _, tab in ipairs(allTabs) do
		tab.frame.Visible = false
		tab.btn.TextColor3 = Color3.fromRGB(140, 140, 140)
		tab.btn.Text = "[ ] " .. tab.name
	end
	activeFrame.Visible = true
	activeBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
	activeBtn.Text = "[X] " .. string.match(activeBtn.Text, "%] (.+)$")
end
switchTab(PlayerTabBtn, PlayerFrame)

PlayerTabBtn.MouseButton1Click:Connect(function() switchTab(PlayerTabBtn, PlayerFrame) end)
MiscTabBtn.MouseButton1Click:Connect(function() switchTab(MiscTabBtn, MiscFrame) end)
SettingsTabBtn.MouseButton1Click:Connect(function() switchTab(SettingsTabBtn, SettingsFrame) end)

local currentKey = Enum.KeyCode.LeftAlt
local listening = false

KeybindBtn.MouseButton1Click:Connect(function()
	listening = true
	KeybindBtn.Text = "BIND: ..."
	KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if listening and input.UserInputType == Enum.UserInputType.Keyboard then
		currentKey = input.KeyCode
		listening = false
		KeybindBtn.Text = "BIND: " .. input.KeyCode.Name
		KeybindBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
		return
	end
	if gpe then return end
	if input.KeyCode == currentKey then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

--- ========================================== ---
-- [[ LOGICA: SPEED SLIDER ]] --
--- ========================================== ---

local minSpeed = 8
local maxSpeed = 150
local draggingSlider = false

local function updateSlider(xRatio)
	xRatio = math.clamp(xRatio, 0, 1)
	walkSpeedValue = math.floor(minSpeed + (maxSpeed - minSpeed) * xRatio)
	SpeedSliderFill.Size = UDim2.new(xRatio, 0, 1, 0)
	SpeedSliderKnob.Position = UDim2.new(xRatio, -6, 0.5, -6)
	SpeedValueLabel.Text = tostring(walkSpeedValue)

	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = walkSpeedValue end
	end
end

SpeedSliderKnob.MouseButton1Down:Connect(function()
	draggingSlider = true
end)

SpeedSliderTrack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = true
		local trackPos = SpeedSliderTrack.AbsolutePosition.X
		local trackSize = SpeedSliderTrack.AbsoluteSize.X
		local ratio = (input.Position.X - trackPos) / trackSize
		updateSlider(ratio)
	end
end)

RunService.RenderStepped:Connect(function()
	if draggingSlider then
		local mousePos = UserInputService:GetMouseLocation()
		local trackPos = SpeedSliderTrack.AbsolutePosition.X
		local trackSize = SpeedSliderTrack.AbsoluteSize.X
		local ratio = (mousePos.X - trackPos) / trackSize
		updateSlider(ratio)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = false
	end
end)

--- ========================================== ---
-- [[ LOGICA: CLASSIC FLY ENGINE ]] --
--- ========================================== ---

local flying = false
local flySpeed = 1.8
local flyStyle = "Normal"
local speeds = {Mode1 = 1.2, Mode2 = 2.8, Mode3 = 6.5}
local originalGravity = workspace.Gravity

local function updateSpeedVisuals(activeBtn)
	Mode1Btn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	Mode2Btn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	Mode3Btn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	activeBtn.UIStroke.Color = Color3.fromRGB(255, 40, 40)
end
local function updateStyleVisuals(activeBtn)
	NormalStyleBtn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	SupermanStyleBtn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	activeBtn.UIStroke.Color = Color3.fromRGB(255, 40, 40)
end

updateSpeedVisuals(Mode1Btn)
updateStyleVisuals(NormalStyleBtn)

Mode1Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode1 updateSpeedVisuals(Mode1Btn) end)
Mode2Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode2 updateSpeedVisuals(Mode2Btn) end)
Mode3Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode3 updateSpeedVisuals(Mode3Btn) end)

NormalStyleBtn.MouseButton1Click:Connect(function() flyStyle = "Normal" updateStyleVisuals(NormalStyleBtn) end)
SupermanStyleBtn.MouseButton1Click:Connect(function() flyStyle = "Superman" updateStyleVisuals(SupermanStyleBtn) end)

local currentMoveVector = Vector3.new(0, 0, 0)
local targetMoveVector = Vector3.new(0, 0, 0)
local connectionFly = nil
local flyAnimTrack = nil

local function playSafeSupermanAnim(hum)
	pcall(function()
		local animator = hum:FindFirstChildOfClass("Animator")
		if animator then
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://5444366538"
			flyAnimTrack = animator:LoadAnimation(anim)
			flyAnimTrack.Priority = Enum.AnimationPriority.Action4
			flyAnimTrack:Play()
		end
	end)
end

local function startClassicFly()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart", 5)
	local hum = char:WaitForChild("Humanoid", 5)
	if not root or not hum then return end

	local cam = workspace.CurrentCamera
	hum.PlatformStand = true

	originalGravity = workspace.Gravity
	workspace.Gravity = 0

	if flyStyle == "Superman" then
		playSafeSupermanAnim(hum)
	end

	connectionFly = RunService.RenderStepped:Connect(function()
		if not root or not hum then return end

		root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

		local inputVector = Vector3.new(0, 0, 0)
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVector = inputVector + cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVector = inputVector - cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVector = inputVector - cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVector = inputVector + cam.CFrame.RightVector end

		if inputVector.Magnitude > 0 then
			targetMoveVector = inputVector.Unit * flySpeed
		else
			targetMoveVector = Vector3.new(0, 0, 0)
		end

		currentMoveVector = currentMoveVector:Lerp(targetMoveVector, 0.2)

		if flyStyle == "Superman" then
			local targetCFrame
			if currentMoveVector.Magnitude > 0.05 then
				targetCFrame = CFrame.lookAt(root.Position, root.Position + currentMoveVector) * CFrame.Angles(math.rad(-90), 0, 0)
			else
				local _, y, _ = cam.CFrame:ToEulerAnglesYXZ()
				targetCFrame = CFrame.new(root.Position) * CFrame.Angles(0, y, 0) * CFrame.Angles(math.rad(-90), 0, 0)
			end
			root.CFrame = CFrame.new(root.Position + currentMoveVector) * targetCFrame.Rotation
		else
			local _, y, _ = cam.CFrame:ToEulerAnglesYXZ()
			root.CFrame = CFrame.new(root.Position + currentMoveVector) * CFrame.Angles(0, y, 0)
		end
	end)
end

local function stopClassicFly()
	flying = false
	FlyButton.Text = "// TOGGLE FLY: OFF"
	FlyButton.TextColor3 = Color3.fromRGB(255, 40, 40)
	FlyButton.UIStroke.Color = Color3.fromRGB(40, 40, 45)

	workspace.Gravity = originalGravity

	if connectionFly then connectionFly:Disconnect() connectionFly = nil end
	if flyAnimTrack then pcall(function() flyAnimTrack:Stop() flyAnimTrack:Destroy() end) flyAnimTrack = nil end

	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.PlatformStand = false end
	end
end

FlyButton.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		FlyButton.Text = "// TOGGLE FLY: ACTIVE"
		FlyButton.TextColor3 = Color3.fromRGB(50, 255, 50)
		FlyButton.UIStroke.Color = Color3.fromRGB(50, 255, 50)
		startClassicFly()
	else
		stopClassicFly()
	end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	stopClassicFly()
	local hum = char:WaitForChild("Humanoid")
	hum.WalkSpeed = walkSpeedValue
end)

--- ========================================== ---
-- [[ LOGICA: UNLOAD ]] --
--- ========================================== ---

UnloadBtn.MouseButton1Click:Connect(function()
	stopClassicFly()
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = 16
			hum.PlatformStand = false
		end
	end
	workspace.Gravity = originalGravity
	ScreenGui:Destroy()
end)
