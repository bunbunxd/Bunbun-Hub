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
local EspTabBtn = Instance.new("TextButton")
local EmotesTabBtn = Instance.new("TextButton")
local PlayerScroll = Instance.new("ScrollingFrame")
local MiscFrame = Instance.new("Frame")
local SettingsFrame = Instance.new("Frame")
local EspFrame = Instance.new("Frame")
local EmotesFrame = Instance.new("Frame")

-- Elementen in Player Tab
local FlyButton = Instance.new("TextButton")
local SpeedFrame = Instance.new("Frame")
local SpeedLabel = Instance.new("TextLabel")
local Mode1Btn = Instance.new("TextButton")
local Mode2Btn = Instance.new("TextButton")
local Mode3Btn = Instance.new("TextButton")

-- Fly Style
local StyleFrame = Instance.new("Frame")
local StyleLabel = Instance.new("TextLabel")
local NormalStyleBtn = Instance.new("TextButton")
local SupermanStyleBtn = Instance.new("TextButton")

-- Tooltip
local TooltipLabel = Instance.new("TextLabel")

-- Speed Slider
local SpeedSliderFrame = Instance.new("Frame")
local SpeedSliderLabel = Instance.new("TextLabel")
local SpeedSliderTrack = Instance.new("Frame")
local SpeedSliderFill = Instance.new("Frame")
local SpeedSliderKnob = Instance.new("TextButton")
local SpeedValueLabel = Instance.new("TextLabel")

-- Jump Height Slider
local JumpSliderFrame = Instance.new("Frame")
local JumpSliderLabel = Instance.new("TextLabel")
local JumpSliderTrack = Instance.new("Frame")
local JumpSliderFill = Instance.new("Frame")
local JumpSliderKnob = Instance.new("TextButton")
local JumpValueLabel = Instance.new("TextLabel")

-- Infinite Jump
local InfiniteJumpButton = Instance.new("TextButton")

-- UI kleur state
local accentColor = Color3.fromRGB(255, 40, 40)
local bgDark = Color3.fromRGB(10, 10, 12)
local bgMid = Color3.fromRGB(14, 14, 18)
local bgPanel = Color3.fromRGB(15, 15, 18)

ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--- ========================================== ---
-- [[ STYLING UTILITIES ]] --
--- ========================================== ---

local function addOutline(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or accentColor
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
MainFrame.BackgroundColor3 = bgDark
MainFrame.Position = UDim2.new(0.5, -225, 0.25, -175)
MainFrame.Size = UDim2.new(0, 450, 0, 390)
MainFrame.Active = true
addOutline(MainFrame, accentColor, 1)
addCorner(MainFrame, 6)

-- Tooltip
TooltipLabel.Parent = ScreenGui
TooltipLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
TooltipLabel.AutomaticSize = Enum.AutomaticSize.X
TooltipLabel.Size = UDim2.new(0, 0, 0, 22)
TooltipLabel.Font = Enum.Font.RobotoMono
TooltipLabel.Text = "// become clark kent!"
TooltipLabel.TextColor3 = accentColor
TooltipLabel.TextSize = 9
TooltipLabel.ZIndex = 10
TooltipLabel.Visible = false
TooltipLabel.TextXAlignment = Enum.TextXAlignment.Left
addOutline(TooltipLabel, accentColor, 1)
addCorner(TooltipLabel, 4)
local TooltipPadding = Instance.new("UIPadding")
TooltipPadding.PaddingLeft = UDim.new(0, 8)
TooltipPadding.PaddingRight = UDim.new(0, 8)
TooltipPadding.Parent = TooltipLabel

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
LeftPanel.BackgroundColor3 = bgPanel
LeftPanel.Size = UDim2.new(0, 130, 1, 0)
addOutline(LeftPanel, Color3.fromRGB(35, 35, 40), 1)
addCorner(LeftPanel, 6)

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
Title.TextColor3 = accentColor
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.Size = UDim2.new(1, -20, 0, 210)

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
styleTabBtn(PlayerTabBtn,   "PLAYER",   UDim2.new(0, 0, 0, 0))
styleTabBtn(MiscTabBtn,     "MISC",     UDim2.new(0, 0, 0, 35))
styleTabBtn(SettingsTabBtn, "SETTINGS", UDim2.new(0, 0, 0, 70))
styleTabBtn(EspTabBtn,      "ESP",      UDim2.new(0, 0, 0, 105))
styleTabBtn(EmotesTabBtn,   "EMOTES",   UDim2.new(0, 0, 0, 140))

ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 140, 0, 15)
ContentContainer.Size = UDim2.new(1, -155, 1, -30)

PlayerScroll.Name = "PlayerScroll"
PlayerScroll.Parent = ContentContainer
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.Size = UDim2.new(1, 0, 1, 0)
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 530)
PlayerScroll.ScrollBarThickness = 3
PlayerScroll.ScrollBarImageColor3 = accentColor
PlayerScroll.Visible = true

local function createPage(name)
	local f = Instance.new("Frame")
	f.Name = name
	f.Parent = ContentContainer
	f.BackgroundTransparency = 1
	f.Size = UDim2.new(1, 0, 1, 0)
	f.Visible = false
	return f
end
MiscFrame     = createPage("MiscFrame")
SettingsFrame = createPage("SettingsFrame")
EspFrame      = createPage("EspFrame")
EmotesFrame   = createPage("EmotesFrame")

-- FlyButton
FlyButton.Parent = PlayerScroll
FlyButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
FlyButton.Position = UDim2.new(0, 0, 0, 10)
FlyButton.Size = UDim2.new(1, 0, 0, 45)
FlyButton.Font = Enum.Font.RobotoMono
FlyButton.Text = "// TOGGLE FLY: OFF"
FlyButton.TextColor3 = accentColor
FlyButton.TextSize = 14
addOutline(FlyButton, Color3.fromRGB(40, 40, 45), 1)
addCorner(FlyButton, 4)

-- SpeedFrame
SpeedFrame.Parent = PlayerScroll
SpeedFrame.BackgroundColor3 = bgMid
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

-- StyleFrame
StyleFrame.Parent = PlayerScroll
StyleFrame.BackgroundColor3 = bgMid
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

SupermanStyleBtn.Parent = StyleFrame
SupermanStyleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
SupermanStyleBtn.Position = UDim2.new(0.52, 0, 0, 38)
SupermanStyleBtn.Size = UDim2.new(0.44, 0, 0, 35)
SupermanStyleBtn.Font = Enum.Font.RobotoMono
SupermanStyleBtn.Text = "SUPERMAN ?"
SupermanStyleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
SupermanStyleBtn.TextSize = 12
addOutline(SupermanStyleBtn, Color3.fromRGB(45, 45, 50), 1)
addCorner(SupermanStyleBtn, 4)

SupermanStyleBtn.MouseEnter:Connect(function()
	local absPos = MainFrame.AbsolutePosition
	local absSize = MainFrame.AbsoluteSize
	local btnAbsPos = SupermanStyleBtn.AbsolutePosition
	TooltipLabel.Position = UDim2.new(0, absPos.X + absSize.X + 8, 0, btnAbsPos.Y)
	TooltipLabel.Visible = true
end)
SupermanStyleBtn.MouseLeave:Connect(function()
	TooltipLabel.Visible = false
end)

-- Speed Slider
local walkSpeedValue = 16

SpeedSliderFrame.Parent = PlayerScroll
SpeedSliderFrame.BackgroundColor3 = bgMid
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
SpeedValueLabel.TextColor3 = accentColor
SpeedValueLabel.TextSize = 12
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Right

SpeedSliderTrack.Parent = SpeedSliderFrame
SpeedSliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedSliderTrack.Position = UDim2.new(0, 12, 0, 42)
SpeedSliderTrack.Size = UDim2.new(1, -24, 0, 6)
addCorner(SpeedSliderTrack, 3)

SpeedSliderFill.Parent = SpeedSliderTrack
SpeedSliderFill.BackgroundColor3 = accentColor
SpeedSliderFill.Size = UDim2.new(0.1, 0, 1, 0)
addCorner(SpeedSliderFill, 3)

SpeedSliderKnob.Parent = SpeedSliderTrack
SpeedSliderKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
SpeedSliderKnob.Position = UDim2.new(0.1, -6, 0.5, -6)
SpeedSliderKnob.Size = UDim2.new(0, 12, 0, 12)
SpeedSliderKnob.Text = ""
addCorner(SpeedSliderKnob, 6)
addOutline(SpeedSliderKnob, accentColor, 1)

-- Jump Height Slider
local jumpHeightValue = 50

JumpSliderFrame.Parent = PlayerScroll
JumpSliderFrame.BackgroundColor3 = bgMid
JumpSliderFrame.Position = UDim2.new(0, 0, 0, 360)
JumpSliderFrame.Size = UDim2.new(1, 0, 0, 75)
addOutline(JumpSliderFrame, Color3.fromRGB(30, 30, 35), 1)
addCorner(JumpSliderFrame, 4)

JumpSliderLabel.Parent = JumpSliderFrame
JumpSliderLabel.BackgroundTransparency = 1
JumpSliderLabel.Position = UDim2.new(0, 12, 0, 8)
JumpSliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
JumpSliderLabel.Font = Enum.Font.RobotoMono
JumpSliderLabel.Text = "> PLAYER JUMPHEIGHT:"
JumpSliderLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
JumpSliderLabel.TextSize = 12
JumpSliderLabel.TextXAlignment = Enum.TextXAlignment.Left

JumpValueLabel.Parent = JumpSliderFrame
JumpValueLabel.BackgroundTransparency = 1
JumpValueLabel.Position = UDim2.new(0.75, 0, 0, 8)
JumpValueLabel.Size = UDim2.new(0.22, 0, 0, 20)
JumpValueLabel.Font = Enum.Font.RobotoMono
JumpValueLabel.Text = "50"
JumpValueLabel.TextColor3 = accentColor
JumpValueLabel.TextSize = 12
JumpValueLabel.TextXAlignment = Enum.TextXAlignment.Right

JumpSliderTrack.Parent = JumpSliderFrame
JumpSliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
JumpSliderTrack.Position = UDim2.new(0, 12, 0, 42)
JumpSliderTrack.Size = UDim2.new(1, -24, 0, 6)
addCorner(JumpSliderTrack, 3)

JumpSliderFill.Parent = JumpSliderTrack
JumpSliderFill.BackgroundColor3 = accentColor
JumpSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
addCorner(JumpSliderFill, 3)

JumpSliderKnob.Parent = JumpSliderTrack
JumpSliderKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
JumpSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6)
JumpSliderKnob.Size = UDim2.new(0, 12, 0, 12)
JumpSliderKnob.Text = ""
addCorner(JumpSliderKnob, 6)
addOutline(JumpSliderKnob, accentColor, 1)

-- Infinite Jump
InfiniteJumpButton.Parent = PlayerScroll
InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
InfiniteJumpButton.Position = UDim2.new(0, 0, 0, 450)
InfiniteJumpButton.Size = UDim2.new(1, 0, 0, 45)
InfiniteJumpButton.Font = Enum.Font.RobotoMono
InfiniteJumpButton.Text = "// INFINITE JUMP: OFF"
InfiniteJumpButton.TextColor3 = accentColor
InfiniteJumpButton.TextSize = 14
addOutline(InfiniteJumpButton, Color3.fromRGB(40, 40, 45), 1)
addCorner(InfiniteJumpButton, 4)

--- ========================================== ---
-- [[ MISC FRAME ]] --
--- ========================================== ---

local MiscScroll = Instance.new("ScrollingFrame")
MiscScroll.Parent = MiscFrame
MiscScroll.BackgroundTransparency = 1
MiscScroll.Size = UDim2.new(1, 0, 1, 0)
MiscScroll.CanvasSize = UDim2.new(0, 0, 0, 380)
MiscScroll.ScrollBarThickness = 3
MiscScroll.ScrollBarImageColor3 = accentColor

local MiscLabel = Instance.new("TextLabel")
MiscLabel.Parent = MiscScroll
MiscLabel.BackgroundTransparency = 1
MiscLabel.Position = UDim2.new(0, 0, 0, 10)
MiscLabel.Size = UDim2.new(1, 0, 0, 20)
MiscLabel.Font = Enum.Font.RobotoMono
MiscLabel.Text = "// MISCELLANEOUS UTILITIES"
MiscLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
MiscLabel.TextSize = 13
MiscLabel.TextXAlignment = Enum.TextXAlignment.Left

-- TP TO PLAYER knop
local TpBtn = Instance.new("TextButton")
TpBtn.Parent = MiscScroll
TpBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
TpBtn.Position = UDim2.new(0, 0, 0, 38)
TpBtn.Size = UDim2.new(1, 0, 0, 38)
TpBtn.Font = Enum.Font.RobotoMono
TpBtn.Text = "// TP TO PLAYER"
TpBtn.TextColor3 = accentColor
TpBtn.TextSize = 13
addOutline(TpBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(TpBtn, 4)

local TpListFrame = Instance.new("ScrollingFrame")
TpListFrame.Parent = MiscScroll
TpListFrame.BackgroundColor3 = bgMid
TpListFrame.Position = UDim2.new(0, 0, 0, 84)
TpListFrame.Size = UDim2.new(1, 0, 0, 0) -- start ingeklapt
TpListFrame.ScrollBarThickness = 4
TpListFrame.ScrollBarImageColor3 = accentColor
TpListFrame.Visible = false
TpListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
addOutline(TpListFrame, Color3.fromRGB(30, 30, 35), 1)
addCorner(TpListFrame, 4)

local TpListLayout = Instance.new("UIListLayout")
TpListLayout.Parent = TpListFrame
TpListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TpListLayout.Padding = UDim.new(0, 4)

local TpListPadding = Instance.new("UIPadding")
TpListPadding.Parent = TpListFrame
TpListPadding.PaddingTop = UDim.new(0, 6)
TpListPadding.PaddingLeft = UDim.new(0, 6)
TpListPadding.PaddingRight = UDim.new(0, 6)

-- Chat Spam knop — direct onder de TP knop (of lijst)
local ChatSpamBtn = Instance.new("TextButton")
ChatSpamBtn.Parent = MiscScroll
ChatSpamBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
ChatSpamBtn.Position = UDim2.new(0, 0, 0, 90) -- standaard positie als lijst dicht is
ChatSpamBtn.Size = UDim2.new(1, 0, 0, 45)
ChatSpamBtn.Font = Enum.Font.RobotoMono
ChatSpamBtn.Text = "// CHAT SPAM"
ChatSpamBtn.TextColor3 = accentColor
ChatSpamBtn.TextSize = 14
addOutline(ChatSpamBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(ChatSpamBtn, 4)

-- Herpositioneer ChatSpamBtn afhankelijk van of de lijst open/dicht is
local function updateMiscLayout(listOpen, listHeight)
	if listOpen then
		TpListFrame.Size = UDim2.new(1, 0, 0, listHeight)
		TpListFrame.Visible = true
		ChatSpamBtn.Position = UDim2.new(0, 0, 0, 84 + listHeight + 8)
		MiscScroll.CanvasSize = UDim2.new(0, 0, 0, 84 + listHeight + 8 + 45 + 10)
	else
		TpListFrame.Visible = false
		TpListFrame.Size = UDim2.new(1, 0, 0, 0)
		ChatSpamBtn.Position = UDim2.new(0, 0, 0, 90)
		MiscScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
	end
end

local function buildTpList()
	for _, c in ipairs(TpListFrame:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	local count = 0
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -8, 0, 34)
			btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
			btn.Font = Enum.Font.RobotoMono
			btn.Text = "> " .. plr.DisplayName .. " (" .. plr.Name .. ")"
			btn.TextColor3 = Color3.fromRGB(200, 200, 200)
			btn.TextSize = 11
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = TpListFrame
			addOutline(btn, Color3.fromRGB(45, 45, 50), 1)
			addCorner(btn, 4)
			count = count + 1
			btn.MouseButton1Click:Connect(function()
				local tc = plr.Character
				if not tc then return end
				local tr = tc:FindFirstChild("HumanoidRootPart")
				if not tr then return end
				local mc = LocalPlayer.Character
				if not mc then return end
				local mr = mc:FindFirstChild("HumanoidRootPart")
				if not mr then return end
				mr.CFrame = tr.CFrame * CFrame.new(0, 0, -2)
				TpBtn.Text = "// TP TO PLAYER"
				updateMiscLayout(false, 0)
			end)
		end
	end
	TpListLayout:ApplyLayout()
	local listH = math.min(count * 38 + 16, 180)
	TpListFrame.CanvasSize = UDim2.new(0, 0, 0, count * 38 + 16)
	return listH
end

TpBtn.MouseButton1Click:Connect(function()
	if TpListFrame.Visible then
		TpBtn.Text = "// TP TO PLAYER"
		updateMiscLayout(false, 0)
	else
		local h = buildTpList()
		TpBtn.Text = "// CLOSE LIST"
		updateMiscLayout(true, h)
	end
end)

updateMiscLayout(false, 0)

--- ========================================== ---
-- [[ CHAT SPAM — HEEL SNEL ]] --
--- ========================================== ---

local chatSpamming = false
local chatSpamThread = nil

local function stopChatSpam()
	chatSpamming = false
	if chatSpamThread then
		task.cancel(chatSpamThread)
		chatSpamThread = nil
	end
	ChatSpamBtn.Text = "// CHAT SPAM"
	ChatSpamBtn.TextColor3 = accentColor
	ChatSpamBtn.UIStroke.Color = Color3.fromRGB(40, 40, 45)
end

local function sendChatMessage(msg)
	pcall(function()
		local TextChatService = game:GetService("TextChatService")
		local channels = TextChatService:FindFirstChild("TextChannels")
		if channels then
			for _, ch in ipairs(channels:GetChildren()) do
				if ch:IsA("TextChannel") then
					ch:SendAsync(msg)
					return
				end
			end
		end
	end)
end

local function startChatSpam()
	chatSpamming = true
	ChatSpamBtn.Text = "// STOP SPAM"
	ChatSpamBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
	ChatSpamBtn.UIStroke.Color = Color3.fromRGB(50, 255, 50)
	chatSpamThread = task.spawn(function()
		while chatSpamming do
			sendChatMessage("BununXD is the goat")
			task.wait(0.7) -- zo snel mogelijk, 0.1s is Roblox minimum
		end
	end)
end

ChatSpamBtn.MouseButton1Click:Connect(function()
	if chatSpamming then stopChatSpam() else startChatSpam() end
end)

--- ========================================== ---
-- [[ EMOTES FRAME ]] --
--- ========================================== ---

local emotesList = {
	{name = "DANCE",      id = "rbxassetid://507771019"},
	{name = "WAVE",       id = "rbxassetid://507770239"},
	{name = "POINT",      id = "rbxassetid://507770453"},
	{name = "CHEER",      id = "rbxassetid://507770677"},
	{name = "LAUGH",      id = "rbxassetid://507770818"},
}

local EmotesScroll = Instance.new("ScrollingFrame")
EmotesScroll.Parent = EmotesFrame
EmotesScroll.BackgroundTransparency = 1
EmotesScroll.Size = UDim2.new(1, 0, 1, 0)
EmotesScroll.CanvasSize = UDim2.new(0, 0, 0, 430)
EmotesScroll.ScrollBarThickness = 3
EmotesScroll.ScrollBarImageColor3 = accentColor

local EmotesLabel = Instance.new("TextLabel")
EmotesLabel.Parent = EmotesScroll
EmotesLabel.BackgroundTransparency = 1
EmotesLabel.Position = UDim2.new(0, 0, 0, 10)
EmotesLabel.Size = UDim2.new(1, 0, 0, 20)
EmotesLabel.Font = Enum.Font.RobotoMono
EmotesLabel.Text = "// SELECT EMOTE:"
EmotesLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
EmotesLabel.TextSize = 13
EmotesLabel.TextXAlignment = Enum.TextXAlignment.Left

local selectedEmote = nil
local selectedEmoteBtn = nil
local currentEmoteTrack = nil
local emoteButtons = {}

for i, emote in ipairs(emotesList) do
	local btn = Instance.new("TextButton")
	btn.Parent = EmotesScroll
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	btn.Position = UDim2.new(0, 0, 0, 38 + (i - 1) * 48)
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.Font = Enum.Font.RobotoMono
	btn.Text = "[ ] " .. emote.name
	btn.TextColor3 = Color3.fromRGB(180, 180, 180)
	btn.TextSize = 13
	btn.TextXAlignment = Enum.TextXAlignment.Left
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 10)
	pad.Parent = btn
	addOutline(btn, Color3.fromRGB(45, 45, 50), 1)
	addCorner(btn, 4)
	emoteButtons[i] = {btn = btn, emote = emote}

	btn.MouseButton1Click:Connect(function()
		-- deselect alle andere knoppen
		for _, entry in ipairs(emoteButtons) do
			entry.btn.Text = "[ ] " .. entry.emote.name
			entry.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
			entry.btn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
		end
		-- selecteer deze
		selectedEmote = emote
		selectedEmoteBtn = btn
		btn.Text = "[X] " .. emote.name
		btn.TextColor3 = accentColor
		btn.UIStroke.Color = accentColor
	end)
end

-- Play / Stop emote knop
local PlayEmoteBtn = Instance.new("TextButton")
PlayEmoteBtn.Parent = EmotesScroll
PlayEmoteBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
PlayEmoteBtn.Position = UDim2.new(0, 0, 0, 38 + #emotesList * 48 + 12)
PlayEmoteBtn.Size = UDim2.new(1, 0, 0, 45)
PlayEmoteBtn.Font = Enum.Font.RobotoMono
PlayEmoteBtn.Text = "// PLAY EMOTE"
PlayEmoteBtn.TextColor3 = accentColor
PlayEmoteBtn.TextSize = 14
addOutline(PlayEmoteBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(PlayEmoteBtn, 4)

local emotePlaying = false

local function stopEmote()
	emotePlaying = false
	if currentEmoteTrack then
		pcall(function() currentEmoteTrack:Stop() end)
		currentEmoteTrack = nil
	end
	PlayEmoteBtn.Text = "// PLAY EMOTE"
	PlayEmoteBtn.TextColor3 = accentColor
	PlayEmoteBtn.UIStroke.Color = Color3.fromRGB(40, 40, 45)
end

local function playEmote()
	if not selectedEmote then return end
	local char = LocalPlayer.Character
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	if not hum then return end
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then return end
	pcall(function()
		if currentEmoteTrack then currentEmoteTrack:Stop() end
		local anim = Instance.new("Animation")
		anim.AnimationId = selectedEmote.id
		currentEmoteTrack = animator:LoadAnimation(anim)
		currentEmoteTrack.Priority = Enum.AnimationPriority.Action
		currentEmoteTrack:Play()
		emotePlaying = true
		PlayEmoteBtn.Text = "// STOP EMOTING"
		PlayEmoteBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
		PlayEmoteBtn.UIStroke.Color = Color3.fromRGB(50, 255, 50)
		-- automatisch resetten als animatie stopt
		currentEmoteTrack.Stopped:Connect(function()
			if emotePlaying then stopEmote() end
		end)
	end)
end

PlayEmoteBtn.MouseButton1Click:Connect(function()
	if emotePlaying then stopEmote() else playEmote() end
end)

--- ========================================== ---
-- [[ ESP FRAME ]] --
--- ========================================== ---

local EspLabel = Instance.new("TextLabel")
EspLabel.Parent = EspFrame
EspLabel.BackgroundTransparency = 1
EspLabel.Position = UDim2.new(0, 0, 0, 10)
EspLabel.Size = UDim2.new(1, 0, 0, 20)
EspLabel.Font = Enum.Font.RobotoMono
EspLabel.Text = "// ESP"
EspLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
EspLabel.TextSize = 13
EspLabel.TextXAlignment = Enum.TextXAlignment.Left

local EspButton = Instance.new("TextButton")
EspButton.Parent = EspFrame
EspButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
EspButton.Position = UDim2.new(0, 0, 0, 38)
EspButton.Size = UDim2.new(1, 0, 0, 45)
EspButton.Font = Enum.Font.RobotoMono
EspButton.Text = "// ESP: OFF"
EspButton.TextColor3 = accentColor
EspButton.TextSize = 14
addOutline(EspButton, Color3.fromRGB(40, 40, 45), 1)
addCorner(EspButton, 4)

--- ========================================== ---
-- [[ SETTINGS FRAME (incl. NOCLIP) ]] --
--- ========================================== ---

local SettingsScroll = Instance.new("ScrollingFrame")
SettingsScroll.Name = "SettingsScroll"
SettingsScroll.Parent = SettingsFrame
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.Size = UDim2.new(1, 0, 1, 0)
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 420)
SettingsScroll.ScrollBarThickness = 3
SettingsScroll.ScrollBarImageColor3 = accentColor

local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Parent = SettingsScroll
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0, 0, 0, 10)
SettingsLabel.Size = UDim2.new(1, 0, 0, 20)
SettingsLabel.Font = Enum.Font.RobotoMono
SettingsLabel.Text = "// SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
SettingsLabel.TextSize = 13
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left

local NoclipButton = Instance.new("TextButton")
NoclipButton.Parent = SettingsScroll
NoclipButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
NoclipButton.Position = UDim2.new(0, 0, 0, 38)
NoclipButton.Size = UDim2.new(1, 0, 0, 45)
NoclipButton.Font = Enum.Font.RobotoMono
NoclipButton.Text = "// TOGGLE NOCLIP: OFF"
NoclipButton.TextColor3 = accentColor
NoclipButton.TextSize = 14
addOutline(NoclipButton, Color3.fromRGB(40, 40, 45), 1)
addCorner(NoclipButton, 4)

local SettingsKeybindLabel = Instance.new("TextLabel")
SettingsKeybindLabel.Parent = SettingsScroll
SettingsKeybindLabel.BackgroundTransparency = 1
SettingsKeybindLabel.Position = UDim2.new(0, 0, 0, 98)
SettingsKeybindLabel.Size = UDim2.new(1, 0, 0, 16)
SettingsKeybindLabel.Font = Enum.Font.RobotoMono
SettingsKeybindLabel.Text = "> TOGGLE HOTKEY:"
SettingsKeybindLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
SettingsKeybindLabel.TextSize = 11
SettingsKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left

local SettingsKeybindBtn = Instance.new("TextButton")
SettingsKeybindBtn.Parent = SettingsScroll
SettingsKeybindBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
SettingsKeybindBtn.Position = UDim2.new(0, 0, 0, 118)
SettingsKeybindBtn.Size = UDim2.new(1, 0, 0, 34)
SettingsKeybindBtn.Font = Enum.Font.RobotoMono
SettingsKeybindBtn.Text = "BIND: LAlt"
SettingsKeybindBtn.TextColor3 = accentColor
SettingsKeybindBtn.TextSize = 12
addOutline(SettingsKeybindBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(SettingsKeybindBtn, 4)

local ColorLabel = Instance.new("TextLabel")
ColorLabel.Parent = SettingsScroll
ColorLabel.BackgroundTransparency = 1
ColorLabel.Position = UDim2.new(0, 0, 0, 164)
ColorLabel.Size = UDim2.new(1, 0, 0, 16)
ColorLabel.Font = Enum.Font.RobotoMono
ColorLabel.Text = "> UI ACCENT COLOR:"
ColorLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
ColorLabel.TextSize = 11
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left

local colorOptions = {
	{name = "RED",    color = Color3.fromRGB(255, 40, 40)},
	{name = "BLUE",   color = Color3.fromRGB(40, 120, 255)},
	{name = "GREEN",  color = Color3.fromRGB(50, 220, 80)},
	{name = "PURPLE", color = Color3.fromRGB(160, 60, 255)},
	{name = "CYAN",   color = Color3.fromRGB(40, 220, 220)},
	{name = "WHITE",  color = Color3.fromRGB(220, 220, 220)},
}

local colorBtns = {}
for i, opt in ipairs(colorOptions) do
	local col = math.floor((i - 1) % 3)
	local row = math.floor((i - 1) / 3)
	local cb = Instance.new("TextButton")
	cb.Parent = SettingsScroll
	cb.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	cb.Position = UDim2.new(0, col * 96, 0, 184 + row * 42)
	cb.Size = UDim2.new(0, 88, 0, 34)
	cb.Font = Enum.Font.RobotoMono
	cb.Text = opt.name
	cb.TextColor3 = opt.color
	cb.TextSize = 11
	addOutline(cb, opt.color, 1)
	addCorner(cb, 4)
	colorBtns[i] = {btn = cb, color = opt.color}
end

local UnloadBtn = Instance.new("TextButton")
UnloadBtn.Parent = SettingsScroll
UnloadBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
UnloadBtn.Position = UDim2.new(0, 0, 0, 275)
UnloadBtn.Size = UDim2.new(1, 0, 0, 45)
UnloadBtn.Font = Enum.Font.RobotoMono
UnloadBtn.Text = "// UNLOAD SCRIPT"
UnloadBtn.TextColor3 = accentColor
UnloadBtn.TextSize = 14
addOutline(UnloadBtn, Color3.fromRGB(40, 40, 45), 1)
addCorner(UnloadBtn, 4)

--- ========================================== ---
-- [[ KLEUR AANPASSEN ]] --
--- ========================================== ---

local espHighlights = {}

local function isNeutralColor(c)
	local r, g, b = c.R, c.G, c.B
	return math.abs(r - g) < 0.02 and math.abs(g - b) < 0.02 and r < 0.25
end

local function applyAccentColor(newColor)
	accentColor = newColor
	for _, desc in ipairs(ScreenGui:GetDescendants()) do
		if desc:IsA("UIStroke") and not isNeutralColor(desc.Color) then
			desc.Color = newColor
		end
	end
	Title.TextColor3 = newColor
	FlyButton.TextColor3 = newColor
	NoclipButton.TextColor3 = newColor
	InfiniteJumpButton.TextColor3 = newColor
	SpeedValueLabel.TextColor3 = newColor
	JumpValueLabel.TextColor3 = newColor
	SettingsKeybindBtn.TextColor3 = newColor
	TpBtn.TextColor3 = newColor
	EspButton.TextColor3 = newColor
	UnloadBtn.TextColor3 = newColor
	TooltipLabel.TextColor3 = newColor
	ChatSpamBtn.TextColor3 = newColor
	PlayEmoteBtn.TextColor3 = newColor
	PlayerScroll.ScrollBarImageColor3 = newColor
	MiscScroll.ScrollBarImageColor3 = newColor
	SettingsScroll.ScrollBarImageColor3 = newColor
	EmotesScroll.ScrollBarImageColor3 = newColor
	TpListFrame.ScrollBarImageColor3 = newColor
	SpeedSliderFill.BackgroundColor3 = newColor
	SpeedSliderKnob.UIStroke.Color = newColor
	JumpSliderFill.BackgroundColor3 = newColor
	JumpSliderKnob.UIStroke.Color = newColor
	MainFrame.UIStroke.Color = newColor
	for _, h in pairs(espHighlights) do
		if h and h.Parent then h.OutlineColor = newColor end
	end
	for _, tab in ipairs({
		{btn = PlayerTabBtn,   frame = PlayerScroll},
		{btn = MiscTabBtn,     frame = MiscFrame},
		{btn = SettingsTabBtn, frame = SettingsFrame},
		{btn = EspTabBtn,      frame = EspFrame},
		{btn = EmotesTabBtn,   frame = EmotesFrame},
	}) do
		if tab.frame.Visible then tab.btn.TextColor3 = newColor end
	end
end

for _, entry in ipairs(colorBtns) do
	entry.btn.MouseButton1Click:Connect(function() applyAccentColor(entry.color) end)
end

--- ========================================== ---
-- [[ LOGICA: TABS & KEYBIND ]] --
--- ========================================== ---

local allTabs = {
	{btn = PlayerTabBtn,   frame = PlayerScroll,  name = "PLAYER"},
	{btn = MiscTabBtn,     frame = MiscFrame,     name = "MISC"},
	{btn = SettingsTabBtn, frame = SettingsFrame, name = "SETTINGS"},
	{btn = EspTabBtn,      frame = EspFrame,      name = "ESP"},
	{btn = EmotesTabBtn,   frame = EmotesFrame,   name = "EMOTES"},
}

local function switchTab(activeBtn, activeFrame)
	for _, tab in ipairs(allTabs) do
		tab.frame.Visible = false
		tab.btn.TextColor3 = Color3.fromRGB(140, 140, 140)
		tab.btn.Text = "[ ] " .. tab.name
	end
	activeFrame.Visible = true
	activeBtn.TextColor3 = accentColor
	activeBtn.Text = "[X] " .. string.match(activeBtn.Text, "%] (.+)$")
end
switchTab(PlayerTabBtn, PlayerScroll)

PlayerTabBtn.MouseButton1Click:Connect(function()   switchTab(PlayerTabBtn,   PlayerScroll)  end)
MiscTabBtn.MouseButton1Click:Connect(function()     switchTab(MiscTabBtn,     MiscFrame)     end)
SettingsTabBtn.MouseButton1Click:Connect(function() switchTab(SettingsTabBtn, SettingsFrame) end)
EspTabBtn.MouseButton1Click:Connect(function()      switchTab(EspTabBtn,      EspFrame)      end)
EmotesTabBtn.MouseButton1Click:Connect(function()   switchTab(EmotesTabBtn,   EmotesFrame)   end)

local currentKey = Enum.KeyCode.LeftAlt
local listening = false

local function setListening(state)
	listening = state
	if state then
		SettingsKeybindBtn.Text = "BIND: ..."
		SettingsKeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end

SettingsKeybindBtn.MouseButton1Click:Connect(function() setListening(true) end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if listening and input.UserInputType == Enum.UserInputType.Keyboard then
		currentKey = input.KeyCode
		listening = false
		SettingsKeybindBtn.Text = "BIND: " .. input.KeyCode.Name
		SettingsKeybindBtn.TextColor3 = accentColor
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
local draggingSpeedSlider = false

local function updateSpeedSlider(xRatio)
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

SpeedSliderKnob.MouseButton1Down:Connect(function() draggingSpeedSlider = true end)
SpeedSliderTrack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSpeedSlider = true
		local ratio = (input.Position.X - SpeedSliderTrack.AbsolutePosition.X) / SpeedSliderTrack.AbsoluteSize.X
		updateSpeedSlider(ratio)
	end
end)

--- ========================================== ---
-- [[ LOGICA: JUMP SLIDER ]] --
--- ========================================== ---

local minJump = 7
local maxJump = 200
local draggingJumpSlider = false

local function updateJumpSlider(xRatio)
	xRatio = math.clamp(xRatio, 0, 1)
	jumpHeightValue = math.floor(minJump + (maxJump - minJump) * xRatio)
	JumpSliderFill.Size = UDim2.new(xRatio, 0, 1, 0)
	JumpSliderKnob.Position = UDim2.new(xRatio, -6, 0.5, -6)
	JumpValueLabel.Text = tostring(jumpHeightValue)
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.JumpPower = jumpHeightValue end
	end
end

JumpSliderKnob.MouseButton1Down:Connect(function() draggingJumpSlider = true end)
JumpSliderTrack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingJumpSlider = true
		local ratio = (input.Position.X - JumpSliderTrack.AbsolutePosition.X) / JumpSliderTrack.AbsoluteSize.X
		updateJumpSlider(ratio)
	end
end)

RunService.RenderStepped:Connect(function()
	if draggingSpeedSlider then
		local mousePos = UserInputService:GetMouseLocation()
		local ratio = (mousePos.X - SpeedSliderTrack.AbsolutePosition.X) / SpeedSliderTrack.AbsoluteSize.X
		updateSpeedSlider(ratio)
	end
	if draggingJumpSlider then
		local mousePos = UserInputService:GetMouseLocation()
		local ratio = (mousePos.X - JumpSliderTrack.AbsolutePosition.X) / JumpSliderTrack.AbsoluteSize.X
		updateJumpSlider(ratio)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSpeedSlider = false
		draggingJumpSlider = false
	end
end)

--- ========================================== ---
-- [[ LOGICA: NOCLIP ]] --
--- ========================================== ---

local noclipEnabled = false
local noclipConnection = nil

local function setNoclip(enabled)
	noclipEnabled = enabled
	if enabled then
		NoclipButton.Text = "// TOGGLE NOCLIP: ON"
		NoclipButton.TextColor3 = Color3.fromRGB(50, 255, 50)
		NoclipButton.UIStroke.Color = Color3.fromRGB(50, 255, 50)
		noclipConnection = RunService.Stepped:Connect(function()
			local char = LocalPlayer.Character
			if not char then return end
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end)
	else
		NoclipButton.Text = "// TOGGLE NOCLIP: OFF"
		NoclipButton.TextColor3 = accentColor
		NoclipButton.UIStroke.Color = Color3.fromRGB(40, 40, 45)
		if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
		local char = LocalPlayer.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = true end
			end
		end
	end
end

NoclipButton.MouseButton1Click:Connect(function() setNoclip(not noclipEnabled) end)

--- ========================================== ---
-- [[ LOGICA: INFINITE JUMP ]] --
--- ========================================== ---

local infiniteJumpEnabled = false
local jumpConnection = nil

local function setInfiniteJump(enabled)
	infiniteJumpEnabled = enabled
	if enabled then
		InfiniteJumpButton.Text = "// INFINITE JUMP: ON"
		InfiniteJumpButton.TextColor3 = Color3.fromRGB(50, 255, 50)
		InfiniteJumpButton.UIStroke.Color = Color3.fromRGB(50, 255, 50)
		jumpConnection = UserInputService.JumpRequest:Connect(function()
			local char = LocalPlayer.Character
			if not char then return end
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	else
		InfiniteJumpButton.Text = "// INFINITE JUMP: OFF"
		InfiniteJumpButton.TextColor3 = accentColor
		InfiniteJumpButton.UIStroke.Color = Color3.fromRGB(40, 40, 45)
		if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
	end
end

InfiniteJumpButton.MouseButton1Click:Connect(function() setInfiniteJump(not infiniteJumpEnabled) end)

--- ========================================== ---
-- [[ LOGICA: ESP ]] --
--- ========================================== ---

local espEnabled = false
local espConnections = {}

local function removeEsp()
	for _, conn in pairs(espConnections) do
		if conn then pcall(function() conn:Disconnect() end) end
	end
	espConnections = {}
	for _, h in pairs(espHighlights) do
		if h and h.Parent then pcall(function() h:Destroy() end) end
	end
	espHighlights = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			for _, obj in ipairs(plr.Character:GetChildren()) do
				if obj:IsA("Highlight") then pcall(function() obj:Destroy() end) end
			end
		end
	end
end

local function addHighlightToChar(char, plrName)
	for _, obj in ipairs(char:GetChildren()) do
		if obj:IsA("Highlight") then pcall(function() obj:Destroy() end) end
	end
	local h = Instance.new("Highlight")
	h.Parent = char
	h.FillTransparency = 1
	h.OutlineColor = accentColor
	h.OutlineTransparency = 0
	espHighlights[plrName] = h
end

local function addEsp()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			if plr.Character then addHighlightToChar(plr.Character, plr.Name) end
			local conn = plr.CharacterAdded:Connect(function(char)
				if not espEnabled then return end
				task.wait(0.5)
				addHighlightToChar(char, plr.Name)
			end)
			table.insert(espConnections, conn)
		end
	end
	local playerAddedConn = Players.PlayerAdded:Connect(function(plr)
		if not espEnabled then return end
		local conn = plr.CharacterAdded:Connect(function(char)
			if not espEnabled then return end
			task.wait(0.5)
			addHighlightToChar(char, plr.Name)
		end)
		table.insert(espConnections, conn)
	end)
	table.insert(espConnections, playerAddedConn)
end

local function setEsp(enabled)
	espEnabled = enabled
	if enabled then
		EspButton.Text = "// ESP: ON"
		EspButton.TextColor3 = Color3.fromRGB(50, 255, 50)
		EspButton.UIStroke.Color = Color3.fromRGB(50, 255, 50)
		addEsp()
	else
		EspButton.Text = "// ESP: OFF"
		EspButton.TextColor3 = accentColor
		EspButton.UIStroke.Color = Color3.fromRGB(40, 40, 45)
		removeEsp()
	end
end

EspButton.MouseButton1Click:Connect(function() setEsp(not espEnabled) end)

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
	activeBtn.UIStroke.Color = accentColor
end
local function updateStyleVisuals(activeBtn)
	NormalStyleBtn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	SupermanStyleBtn.UIStroke.Color = Color3.fromRGB(45, 45, 50)
	activeBtn.UIStroke.Color = accentColor
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
	if flyStyle == "Superman" then playSafeSupermanAnim(hum) end
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
	FlyButton.TextColor3 = accentColor
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
	stopEmote()
	if noclipEnabled then setNoclip(false) end
	local hum = char:WaitForChild("Humanoid")
	hum.WalkSpeed = walkSpeedValue
	hum.JumpPower = jumpHeightValue
end)

--- ========================================== ---
-- [[ LOGICA: UNLOAD ]] --
--- ========================================== ---

UnloadBtn.MouseButton1Click:Connect(function()
	stopClassicFly()
	setNoclip(false)
	setInfiniteJump(false)
	setEsp(false)
	stopChatSpam()
	stopEmote()
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = 16
			hum.JumpPower = 50
			hum.PlatformStand = false
		end
	end
	workspace.Gravity = originalGravity
	ScreenGui:Destroy()
end)
