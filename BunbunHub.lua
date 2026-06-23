-- [[ BUNBUN HUB - ALLEEN TP (zonder Fling) ]] --
-- CLICK TELEPORT met dynamische lijst, geen Fling.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

accentColor = Color3.fromRGB(220, 220, 220)
bgDark = Color3.fromRGB(10, 10, 12)
bgMid = Color3.fromRGB(14, 14, 18)
bgPanel = Color3.fromRGB(15, 15, 18)

function addOutline(obj, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color or accentColor
	s.Thickness = thickness or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = obj
	return s
end
function addCorner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 6)
	c.Parent = obj
end
function setStrokeColor(obj, color)
	local s = obj:FindFirstChildOfClass("UIStroke")
	if s then s.Color = color end
end

-- ========== LAAD SCHERM ==========
LoadingGui = Instance.new("ScreenGui")
LoadingGui.Parent = ScreenGui.Parent
LoadingGui.ResetOnSpawn = false

LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = LoadingGui
LoadingFrame.BackgroundColor3 = bgDark
LoadingFrame.Position = UDim2.new(0.5, -280, 0.25, -205)
LoadingFrame.Size = UDim2.new(0, 560, 0, 410)
addOutline(LoadingFrame, accentColor, 1)
addCorner(LoadingFrame, 8)

loadDrag = false; loadDragInput = nil; loadDragStart = nil; loadStartPos = nil
function loadUpdate(input)
	local delta = input.Position - loadDragStart
	LoadingFrame.Position = UDim2.new(loadStartPos.X.Scale, loadStartPos.X.Offset + delta.X, loadStartPos.Y.Scale, loadStartPos.Y.Offset + delta.Y)
end
LoadingFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		loadDrag = true
		loadDragStart = input.Position
		loadStartPos = LoadingFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then loadDrag = false end
		end)
	end
end)
LoadingFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		loadDragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == loadDragInput and loadDrag then loadUpdate(input) end
end)

ascii = Instance.new("TextLabel")
ascii.Parent = LoadingFrame
ascii.BackgroundTransparency = 1
ascii.Position = UDim2.new(0, 0, 0, 30)
ascii.Size = UDim2.new(1, 0, 0, 120)
ascii.Font = Enum.Font.RobotoMono
ascii.Text = " _                 _\n| |__  _   _ _ __ | |__  _   _ _ __\n| '_ \\| | | | '_ \\| '_ \\| | | | '_ \\\n| |_) | |_| | | | | |_) | |_| | | | |\n|_.__/ \\__,_|_| |_|_.__/ \\__,_|_| |_|"
ascii.TextColor3 = accentColor
ascii.TextSize = 11
ascii.TextXAlignment = Enum.TextXAlignment.Center
ascii.TextYAlignment = Enum.TextYAlignment.Top
ascii.RichText = false

author = Instance.new("TextLabel")
author.Parent = LoadingFrame
author.BackgroundTransparency = 1
author.Position = UDim2.new(0, 0, 0, 155)
author.Size = UDim2.new(1, 0, 0, 20)
author.Font = Enum.Font.RobotoMono
author.Text = "made by BununXD"
author.TextColor3 = Color3.fromRGB(160,160,160)
author.TextSize = 11
author.TextXAlignment = Enum.TextXAlignment.Center
author.RichText = false

loadText = Instance.new("TextLabel")
loadText.Parent = LoadingFrame
loadText.BackgroundTransparency = 1
loadText.Position = UDim2.new(0, 20, 0, 220)
loadText.Size = UDim2.new(1, -40, 0, 20)
loadText.Font = Enum.Font.RobotoMono
loadText.Text = "loading bunbun hub"
loadText.TextColor3 = Color3.fromRGB(160,160,160)
loadText.TextSize = 12
loadText.TextXAlignment = Enum.TextXAlignment.Center
loadText.RichText = false

barBg = Instance.new("Frame")
barBg.Parent = LoadingFrame
barBg.BackgroundColor3 = Color3.fromRGB(30,30,35)
barBg.Position = UDim2.new(0, 40, 0, 260)
barBg.Size = UDim2.new(1, -80, 0, 8)
addCorner(barBg, 4)
addOutline(barBg, Color3.fromRGB(45,45,50), 1)

bar = Instance.new("Frame")
bar.Parent = barBg
bar.BackgroundColor3 = accentColor
bar.Size = UDim2.new(0, 0, 1, 0)
addCorner(bar, 4)

for i = 0, 100 do
	bar.Size = UDim2.new(i/100, 0, 1, 0)
	wait(0.03)
end
wait(0.5)
LoadingGui:Destroy()

-- ========== HOOFD GUI ==========
MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = bgDark
MainFrame.Position = UDim2.new(0.5, -280, 0.25, -205)
MainFrame.Size = UDim2.new(0, 560, 0, 410)
MainFrame.Active = true
addOutline(MainFrame, accentColor, 1)
addCorner(MainFrame, 8)

dragging = false; dragInput = nil; dragStart = nil; startPos = nil
function update(input)
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

TooltipLabel = Instance.new("TextLabel")
TooltipLabel.Parent = ScreenGui
TooltipLabel.BackgroundColor3 = Color3.fromRGB(18,18,22)
TooltipLabel.AutomaticSize = Enum.AutomaticSize.X
TooltipLabel.Size = UDim2.new(0, 0, 0, 22)
TooltipLabel.Font = Enum.Font.RobotoMono
TooltipLabel.Text = "// become clark kent!"
TooltipLabel.TextColor3 = accentColor
TooltipLabel.TextSize = 9
TooltipLabel.ZIndex = 10
TooltipLabel.Visible = false
TooltipLabel.TextXAlignment = Enum.TextXAlignment.Left
TooltipLabel.RichText = false
addOutline(TooltipLabel, accentColor, 1)
addCorner(TooltipLabel, 4)
pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0,8)
pad.PaddingRight = UDim.new(0,8)
pad.Parent = TooltipLabel

LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = bgPanel
LeftPanel.Size = UDim2.new(0, 145, 1, 0)
addOutline(LeftPanel, Color3.fromRGB(35,35,40), 1)
addCorner(LeftPanel, 8)

BunIcon = Instance.new("ImageLabel")
BunIcon.Parent = LeftPanel
BunIcon.BackgroundTransparency = 1
BunIcon.Position = UDim2.new(0, 8, 0, 10)
BunIcon.Size = UDim2.new(0, 22, 0, 28)
BunIcon.Image = "rbxassetid://14578474740"
BunIcon.ScaleType = Enum.ScaleType.Fit

Title = Instance.new("TextLabel")
Title.Parent = LeftPanel
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 34, 0, 13)
Title.Size = UDim2.new(1, -38, 0, 28)
Title.Font = Enum.Font.RobotoMono
Title.Text = "> BUNBUN"
Title.TextColor3 = accentColor
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.RichText = false

TabContainer = Instance.new("Frame")
TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 58)
TabContainer.Size = UDim2.new(1, -20, 0, 290)

HomeTabBtn = Instance.new("TextButton")
PlayerTabBtn = Instance.new("TextButton")
MiscTabBtn = Instance.new("TextButton")
SettingsTabBtn = Instance.new("TextButton")
EspTabBtn = Instance.new("TextButton")
AimTabBtn = Instance.new("TextButton")

function styleTabBtn(btn, text, pos)
	btn.Parent = TabContainer
	btn.BackgroundTransparency = 1
	btn.Position = pos
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Font = Enum.Font.RobotoMono
	btn.Text = "[ ] " .. text
	btn.TextColor3 = Color3.fromRGB(140,140,140)
	btn.TextSize = 13
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.RichText = false
end
styleTabBtn(HomeTabBtn,     "HOME",     UDim2.new(0,0,0,0))
styleTabBtn(PlayerTabBtn,   "PLAYER",   UDim2.new(0,0,0,35))
styleTabBtn(MiscTabBtn,     "MISC",     UDim2.new(0,0,0,70))
styleTabBtn(EspTabBtn,      "ESP",      UDim2.new(0,0,0,105))
styleTabBtn(AimTabBtn,      "AIM",      UDim2.new(0,0,0,140))
styleTabBtn(SettingsTabBtn, "SETTINGS", UDim2.new(0,0,0,175))

ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 157, 0, 14)
ContentContainer.Size = UDim2.new(1, -171, 1, -28)

-- ========== HOME ==========
HomeFrame = Instance.new("Frame")
HomeFrame.Name = "HomeFrame"
HomeFrame.Parent = ContentContainer
HomeFrame.BackgroundTransparency = 1
HomeFrame.Size = UDim2.new(1,0,1,0)
HomeFrame.Visible = true

HomeScroll = Instance.new("ScrollingFrame")
HomeScroll.Parent = HomeFrame
HomeScroll.BackgroundTransparency = 1
HomeScroll.Size = UDim2.new(1,0,1,0)
HomeScroll.CanvasSize = UDim2.new(0,0,0,500)
HomeScroll.ScrollBarThickness = 3
HomeScroll.ScrollBarImageColor3 = accentColor

homeAscii = Instance.new("TextLabel")
homeAscii.Parent = HomeScroll
homeAscii.BackgroundTransparency = 1
homeAscii.Position = UDim2.new(0,0,0,10)
homeAscii.Size = UDim2.new(1,0,0,120)
homeAscii.Font = Enum.Font.RobotoMono
homeAscii.Text = " _                 _\n| |__  _   _ _ __ | |__  _   _ _ __\n| '_ \\| | | | '_ \\| '_ \\| | | | '_ \\\n| |_) | |_| | | | | |_) | |_| | | | |\n|_.__/ \\__,_|_| |_|_.__/ \\__,_|_| |_|"
homeAscii.TextColor3 = accentColor
homeAscii.TextSize = 11
homeAscii.TextXAlignment = Enum.TextXAlignment.Center
homeAscii.TextYAlignment = Enum.TextYAlignment.Top
homeAscii.RichText = false

homeAuthor = Instance.new("TextLabel")
homeAuthor.Parent = HomeScroll
homeAuthor.BackgroundTransparency = 1
homeAuthor.Position = UDim2.new(0,0,0,135)
homeAuthor.Size = UDim2.new(1,0,0,20)
homeAuthor.Font = Enum.Font.RobotoMono
homeAuthor.Text = "made by BununXD"
homeAuthor.TextColor3 = Color3.fromRGB(160,160,160)
homeAuthor.TextSize = 11
homeAuthor.TextXAlignment = Enum.TextXAlignment.Center
homeAuthor.RichText = false

divider = Instance.new("Frame")
divider.Parent = HomeScroll
divider.BackgroundColor3 = Color3.fromRGB(40,40,45)
divider.Position = UDim2.new(0,15,0,165)
divider.Size = UDim2.new(1,-30,0,1)

infoLabel = Instance.new("TextLabel")
infoLabel.Parent = HomeScroll
infoLabel.BackgroundTransparency = 1
infoLabel.Position = UDim2.new(0,0,0,180)
infoLabel.Size = UDim2.new(1,0,0,20)
infoLabel.Font = Enum.Font.RobotoMono
infoLabel.Text = "// PLAYER INFO"
infoLabel.TextColor3 = Color3.fromRGB(120,120,120)
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.RichText = false

AvatarFrame = Instance.new("Frame")
AvatarFrame.Parent = HomeScroll
AvatarFrame.BackgroundColor3 = bgMid
AvatarFrame.Position = UDim2.new(0,10,0,210)
AvatarFrame.Size = UDim2.new(1,-20,0,120)
addOutline(AvatarFrame, Color3.fromRGB(30,30,35), 1)
addCorner(AvatarFrame, 6)

AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = AvatarFrame
AvatarImage.BackgroundColor3 = Color3.fromRGB(30,30,35)
AvatarImage.Position = UDim2.new(0,10,0,10)
AvatarImage.Size = UDim2.new(0,100,0,100)
AvatarImage.ScaleType = Enum.ScaleType.Fit
addCorner(AvatarImage, 6)

function loadAvatar()
	local success, thumb = pcall(function()
		return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if success and thumb then
		AvatarImage.Image = thumb
	else
		AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&width=420&height=420"
	end
end
loadAvatar()

displayLabel = Instance.new("TextLabel")
displayLabel.Parent = AvatarFrame
displayLabel.BackgroundTransparency = 1
displayLabel.Position = UDim2.new(0,120,0,10)
displayLabel.Size = UDim2.new(1,-130,0,30)
displayLabel.Font = Enum.Font.RobotoMono
displayLabel.Text = "Display: " .. LocalPlayer.DisplayName
displayLabel.TextColor3 = accentColor
displayLabel.TextSize = 12
displayLabel.TextXAlignment = Enum.TextXAlignment.Left
displayLabel.TextWrapped = true
displayLabel.RichText = false

userLabel = Instance.new("TextLabel")
userLabel.Parent = AvatarFrame
userLabel.BackgroundTransparency = 1
userLabel.Position = UDim2.new(0,120,0,45)
userLabel.Size = UDim2.new(1,-130,0,30)
userLabel.Font = Enum.Font.RobotoMono
userLabel.Text = "Username: @" .. LocalPlayer.Name
userLabel.TextColor3 = Color3.fromRGB(200,200,200)
userLabel.TextSize = 12
userLabel.TextXAlignment = Enum.TextXAlignment.Left
userLabel.TextWrapped = true
userLabel.RichText = false

idLabel = Instance.new("TextLabel")
idLabel.Parent = AvatarFrame
idLabel.BackgroundTransparency = 1
idLabel.Position = UDim2.new(0,120,0,80)
idLabel.Size = UDim2.new(1,-130,0,30)
idLabel.Font = Enum.Font.RobotoMono
idLabel.Text = "ID: " .. LocalPlayer.UserId
idLabel.TextColor3 = Color3.fromRGB(200,200,200)
idLabel.TextSize = 12
idLabel.TextXAlignment = Enum.TextXAlignment.Left
idLabel.TextWrapped = true
idLabel.RichText = false

-- ========== PLAYER ==========
PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Name = "PlayerScroll"
PlayerScroll.Parent = ContentContainer
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.Size = UDim2.new(1,0,1,0)
PlayerScroll.CanvasSize = UDim2.new(0,0,0,620)
PlayerScroll.ScrollBarThickness = 3
PlayerScroll.ScrollBarImageColor3 = accentColor
PlayerScroll.Visible = false

function createPage(name)
	local f = Instance.new("Frame")
	f.Name = name
	f.Parent = ContentContainer
	f.BackgroundTransparency = 1
	f.Size = UDim2.new(1,0,1,0)
	f.Visible = false
	return f
end
MiscFrame = createPage("MiscFrame")
SettingsFrame = createPage("SettingsFrame")
EspFrame = createPage("EspFrame")
AimFrame = createPage("AimFrame")

-- FLY BUTTON
FlyButton = Instance.new("TextButton")
FlyButton.Parent = PlayerScroll
FlyButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
FlyButton.Position = UDim2.new(0,0,0,10)
FlyButton.Size = UDim2.new(1,0,0,45)
FlyButton.Font = Enum.Font.RobotoMono
FlyButton.Text = "// TOGGLE FLY: OFF"
FlyButton.TextColor3 = accentColor
FlyButton.TextSize = 14
FlyButton.RichText = false
addOutline(FlyButton, Color3.fromRGB(40,40,45), 1)
addCorner(FlyButton, 6)

-- Speed selector
SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = PlayerScroll
SpeedFrame.BackgroundColor3 = bgMid
SpeedFrame.Position = UDim2.new(0,0,0,70)
SpeedFrame.Size = UDim2.new(1,0,0,85)
addOutline(SpeedFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SpeedFrame, 6)

SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0,12,0,8)
SpeedLabel.Size = UDim2.new(1,-24,0,20)
SpeedLabel.Font = Enum.Font.RobotoMono
SpeedLabel.Text = "> SELECT FLY SPEED:"
SpeedLabel.TextColor3 = Color3.fromRGB(160,160,160)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.RichText = false

Mode1Btn = Instance.new("TextButton")
Mode2Btn = Instance.new("TextButton")
Mode3Btn = Instance.new("TextButton")

function styleOptionBtn(btn, parent, text, pos, size)
	btn.Parent = parent
	btn.BackgroundColor3 = Color3.fromRGB(22,22,28)
	btn.Position = pos
	btn.Size = size or UDim2.new(0.28,0,0,35)
	btn.Font = Enum.Font.RobotoMono
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(200,200,200)
	btn.TextSize = 12
	addOutline(btn, Color3.fromRGB(45,45,50), 1)
	addCorner(btn, 6)
end
styleOptionBtn(Mode1Btn, SpeedFrame, "INIT_1", UDim2.new(0.04,0,0,38))
styleOptionBtn(Mode2Btn, SpeedFrame, "HALF_2", UDim2.new(0.36,0,0,38))
styleOptionBtn(Mode3Btn, SpeedFrame, "FULL_3", UDim2.new(0.68,0,0,38))

-- Style selector
StyleFrame = Instance.new("Frame")
StyleFrame.Parent = PlayerScroll
StyleFrame.BackgroundColor3 = bgMid
StyleFrame.Position = UDim2.new(0,0,0,170)
StyleFrame.Size = UDim2.new(1,0,0,85)
addOutline(StyleFrame, Color3.fromRGB(30,30,35), 1)
addCorner(StyleFrame, 6)

StyleLabel = Instance.new("TextLabel")
StyleLabel.Parent = StyleFrame
StyleLabel.BackgroundTransparency = 1
StyleLabel.Position = UDim2.new(0,12,0,8)
StyleLabel.Size = UDim2.new(1,-24,0,20)
StyleLabel.Font = Enum.Font.RobotoMono
StyleLabel.Text = "> SELECT FLY STYLE:"
StyleLabel.TextColor3 = Color3.fromRGB(160,160,160)
StyleLabel.TextSize = 12
StyleLabel.TextXAlignment = Enum.TextXAlignment.Left
StyleLabel.RichText = false

NormalStyleBtn = Instance.new("TextButton")
styleOptionBtn(NormalStyleBtn, StyleFrame, "NORMAL", UDim2.new(0.04,0,0,38), UDim2.new(0.44,0,0,35))

SupermanStyleBtn = Instance.new("TextButton")
SupermanStyleBtn.Parent = StyleFrame
SupermanStyleBtn.BackgroundColor3 = Color3.fromRGB(22,22,28)
SupermanStyleBtn.Position = UDim2.new(0.52,0,0,38)
SupermanStyleBtn.Size = UDim2.new(0.44,0,0,35)
SupermanStyleBtn.Font = Enum.Font.RobotoMono
SupermanStyleBtn.Text = "SUPERMAN ?"
SupermanStyleBtn.TextColor3 = Color3.fromRGB(200,200,200)
SupermanStyleBtn.TextSize = 12
SupermanStyleBtn.RichText = false
addOutline(SupermanStyleBtn, Color3.fromRGB(45,45,50), 1)
addCorner(SupermanStyleBtn, 6)

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

-- Speed slider
SpeedSliderFrame = Instance.new("Frame")
SpeedSliderFrame.Parent = PlayerScroll
SpeedSliderFrame.BackgroundColor3 = bgMid
SpeedSliderFrame.Position = UDim2.new(0,0,0,270)
SpeedSliderFrame.Size = UDim2.new(1,0,0,75)
addOutline(SpeedSliderFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SpeedSliderFrame, 6)

SpeedSliderLabel = Instance.new("TextLabel")
SpeedSliderLabel.Parent = SpeedSliderFrame
SpeedSliderLabel.BackgroundTransparency = 1
SpeedSliderLabel.Position = UDim2.new(0,12,0,8)
SpeedSliderLabel.Size = UDim2.new(0.7,0,0,20)
SpeedSliderLabel.Font = Enum.Font.RobotoMono
SpeedSliderLabel.Text = "> PLAYER SPEED:"
SpeedSliderLabel.TextColor3 = Color3.fromRGB(160,160,160)
SpeedSliderLabel.TextSize = 12
SpeedSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedSliderLabel.RichText = false

SpeedValueLabel = Instance.new("TextLabel")
SpeedValueLabel.Parent = SpeedSliderFrame
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.Position = UDim2.new(0.75,0,0,8)
SpeedValueLabel.Size = UDim2.new(0.22,0,0,20)
SpeedValueLabel.Font = Enum.Font.RobotoMono
SpeedValueLabel.Text = "16"
SpeedValueLabel.TextColor3 = accentColor
SpeedValueLabel.TextSize = 12
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Right
SpeedValueLabel.RichText = false

SpeedSliderTrack = Instance.new("Frame")
SpeedSliderTrack.Parent = SpeedSliderFrame
SpeedSliderTrack.BackgroundColor3 = Color3.fromRGB(30,30,35)
SpeedSliderTrack.Position = UDim2.new(0,12,0,44)
SpeedSliderTrack.Size = UDim2.new(1,-24,0,6)
addCorner(SpeedSliderTrack, 3)

SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Parent = SpeedSliderTrack
SpeedSliderFill.BackgroundColor3 = accentColor
SpeedSliderFill.Size = UDim2.new(0.1,0,1,0)
addCorner(SpeedSliderFill, 3)

SpeedSliderKnob = Instance.new("TextButton")
SpeedSliderKnob.Parent = SpeedSliderTrack
SpeedSliderKnob.BackgroundColor3 = Color3.fromRGB(220,220,220)
SpeedSliderKnob.Position = UDim2.new(0.1, -6, 0.5, -6)
SpeedSliderKnob.Size = UDim2.new(0,12,0,12)
SpeedSliderKnob.Text = ""
SpeedSliderKnob.RichText = false
addCorner(SpeedSliderKnob, 6)
addOutline(SpeedSliderKnob, accentColor, 1)

-- Jump slider
JumpSliderFrame = Instance.new("Frame")
JumpSliderFrame.Parent = PlayerScroll
JumpSliderFrame.BackgroundColor3 = bgMid
JumpSliderFrame.Position = UDim2.new(0,0,0,360)
JumpSliderFrame.Size = UDim2.new(1,0,0,75)
addOutline(JumpSliderFrame, Color3.fromRGB(30,30,35), 1)
addCorner(JumpSliderFrame, 6)

JumpSliderLabel = Instance.new("TextLabel")
JumpSliderLabel.Parent = JumpSliderFrame
JumpSliderLabel.BackgroundTransparency = 1
JumpSliderLabel.Position = UDim2.new(0,12,0,8)
JumpSliderLabel.Size = UDim2.new(0.7,0,0,20)
JumpSliderLabel.Font = Enum.Font.RobotoMono
JumpSliderLabel.Text = "> PLAYER JUMPHEIGHT:"
JumpSliderLabel.TextColor3 = Color3.fromRGB(160,160,160)
JumpSliderLabel.TextSize = 12
JumpSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpSliderLabel.RichText = false

JumpValueLabel = Instance.new("TextLabel")
JumpValueLabel.Parent = JumpSliderFrame
JumpValueLabel.BackgroundTransparency = 1
JumpValueLabel.Position = UDim2.new(0.75,0,0,8)
JumpValueLabel.Size = UDim2.new(0.22,0,0,20)
JumpValueLabel.Font = Enum.Font.RobotoMono
JumpValueLabel.Text = "50"
JumpValueLabel.TextColor3 = accentColor
JumpValueLabel.TextSize = 12
JumpValueLabel.TextXAlignment = Enum.TextXAlignment.Right
JumpValueLabel.RichText = false

JumpSliderTrack = Instance.new("Frame")
JumpSliderTrack.Parent = JumpSliderFrame
JumpSliderTrack.BackgroundColor3 = Color3.fromRGB(30,30,35)
JumpSliderTrack.Position = UDim2.new(0,12,0,44)
JumpSliderTrack.Size = UDim2.new(1,-24,0,6)
addCorner(JumpSliderTrack, 3)

JumpSliderFill = Instance.new("Frame")
JumpSliderFill.Parent = JumpSliderTrack
JumpSliderFill.BackgroundColor3 = accentColor
JumpSliderFill.Size = UDim2.new(0.5,0,1,0)
addCorner(JumpSliderFill, 3)

JumpSliderKnob = Instance.new("TextButton")
JumpSliderKnob.Parent = JumpSliderTrack
JumpSliderKnob.BackgroundColor3 = Color3.fromRGB(220,220,220)
JumpSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6)
JumpSliderKnob.Size = UDim2.new(0,12,0,12)
JumpSliderKnob.Text = ""
JumpSliderKnob.RichText = false
addCorner(JumpSliderKnob, 6)
addOutline(JumpSliderKnob, accentColor, 1)

-- Infinite jump
InfiniteJumpButton = Instance.new("TextButton")
InfiniteJumpButton.Parent = PlayerScroll
InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
InfiniteJumpButton.Position = UDim2.new(0,0,0,450)
InfiniteJumpButton.Size = UDim2.new(1,0,0,45)
InfiniteJumpButton.Font = Enum.Font.RobotoMono
InfiniteJumpButton.Text = "// INFINITE JUMP: OFF"
InfiniteJumpButton.TextColor3 = accentColor
InfiniteJumpButton.TextSize = 14
InfiniteJumpButton.RichText = false
addOutline(InfiniteJumpButton, Color3.fromRGB(40,40,45), 1)
addCorner(InfiniteJumpButton, 6)

-- Noclip
NoclipButton = Instance.new("TextButton")
NoclipButton.Parent = PlayerScroll
NoclipButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
NoclipButton.Position = UDim2.new(0,0,0,510)
NoclipButton.Size = UDim2.new(1,0,0,45)
NoclipButton.Font = Enum.Font.RobotoMono
NoclipButton.Text = "// TOGGLE NOCLIP: OFF"
NoclipButton.TextColor3 = accentColor
NoclipButton.TextSize = 14
NoclipButton.RichText = false
addOutline(NoclipButton, Color3.fromRGB(40,40,45), 1)
addCorner(NoclipButton, 6)

-- ========== MISC (alleen TP, geen Fling) ==========
MiscScroll = Instance.new("ScrollingFrame")
MiscScroll.Parent = MiscFrame
MiscScroll.BackgroundTransparency = 1
MiscScroll.Size = UDim2.new(1,0,1,0)
MiscScroll.CanvasSize = UDim2.new(0,0,0,500) -- voldoende hoogte
MiscScroll.ScrollBarThickness = 3
MiscScroll.ScrollBarImageColor3 = accentColor

MiscLabel = Instance.new("TextLabel")
MiscLabel.Parent = MiscScroll
MiscLabel.BackgroundTransparency = 1
MiscLabel.Position = UDim2.new(0,0,0,10)
MiscLabel.Size = UDim2.new(1,0,0,20)
MiscLabel.Font = Enum.Font.RobotoMono
MiscLabel.Text = "// MISCELLANEOUS UTILITIES"
MiscLabel.TextColor3 = Color3.fromRGB(120,120,120)
MiscLabel.TextSize = 13
MiscLabel.TextXAlignment = Enum.TextXAlignment.Left
MiscLabel.RichText = false

-- CLICK TELEPORT
TpBtn = Instance.new("TextButton")
TpBtn.Parent = MiscScroll
TpBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
TpBtn.Position = UDim2.new(0,0,0,38)
TpBtn.Size = UDim2.new(1,0,0,38)
TpBtn.Font = Enum.Font.RobotoMono
TpBtn.Text = "// CLICK TELEPORT"
TpBtn.TextColor3 = accentColor
TpBtn.TextSize = 13
TpBtn.RichText = false
addOutline(TpBtn, Color3.fromRGB(40,40,45), 1)
addCorner(TpBtn, 6)

TpListFrame = Instance.new("ScrollingFrame")
TpListFrame.Parent = MiscScroll
TpListFrame.BackgroundColor3 = bgMid
TpListFrame.Position = UDim2.new(0,0,0,84)
TpListFrame.Size = UDim2.new(1,0,0,0)
TpListFrame.ScrollBarThickness = 4
TpListFrame.ScrollBarImageColor3 = accentColor
TpListFrame.Visible = false
TpListFrame.CanvasSize = UDim2.new(0,0,0,0)
addOutline(TpListFrame, Color3.fromRGB(30,30,35), 1)
addCorner(TpListFrame, 6)

TpListLayout = Instance.new("UIListLayout")
TpListLayout.Parent = TpListFrame
TpListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TpListLayout.Padding = UDim.new(0,4)

TpListPadding = Instance.new("UIPadding")
TpListPadding.Parent = TpListFrame
TpListPadding.PaddingTop = UDim.new(0,6)
TpListPadding.PaddingLeft = UDim.new(0,6)
TpListPadding.PaddingRight = UDim.new(0,6)

-- CHAT (wordt dynamisch verplaatst)
SendChatLabel = Instance.new("TextLabel")
SendChatLabel.Parent = MiscScroll
SendChatLabel.BackgroundTransparency = 1
SendChatLabel.Position = UDim2.new(0,0,0,0) -- dynamisch
SendChatLabel.Size = UDim2.new(1,0,0,16)
SendChatLabel.Font = Enum.Font.RobotoMono
SendChatLabel.Text = "> SEND CUSTOM CHAT:"
SendChatLabel.TextColor3 = Color3.fromRGB(160,160,160)
SendChatLabel.TextSize = 11
SendChatLabel.TextXAlignment = Enum.TextXAlignment.Left
SendChatLabel.RichText = false

ChatInputFrame = Instance.new("Frame")
ChatInputFrame.Parent = MiscScroll
ChatInputFrame.BackgroundColor3 = bgMid
ChatInputFrame.Position = UDim2.new(0,0,0,0) -- dynamisch
ChatInputFrame.Size = UDim2.new(1,0,0,45)
addOutline(ChatInputFrame, Color3.fromRGB(30,30,35), 1)
addCorner(ChatInputFrame, 6)

ChatTextBox = Instance.new("TextBox")
ChatTextBox.Parent = ChatInputFrame
ChatTextBox.BackgroundTransparency = 1
ChatTextBox.Position = UDim2.new(0,8,0,8)
ChatTextBox.Size = UDim2.new(1,-16,1,-16)
ChatTextBox.Font = Enum.Font.RobotoMono
ChatTextBox.Text = ""
ChatTextBox.PlaceholderText = "enter message..."
ChatTextBox.TextColor3 = Color3.fromRGB(200,200,200)
ChatTextBox.PlaceholderColor3 = Color3.fromRGB(100,100,100)
ChatTextBox.TextSize = 11
ChatTextBox.ClearTextOnFocus = false
ChatTextBox.RichText = false

SendChatBtn = Instance.new("TextButton")
SendChatBtn.Parent = MiscScroll
SendChatBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
SendChatBtn.Position = UDim2.new(0,0,0,0) -- dynamisch
SendChatBtn.Size = UDim2.new(1,0,0,38)
SendChatBtn.Font = Enum.Font.RobotoMono
SendChatBtn.Text = "// SEND CHAT"
SendChatBtn.TextColor3 = accentColor
SendChatBtn.TextSize = 13
SendChatBtn.RichText = false
addOutline(SendChatBtn, Color3.fromRGB(40,40,45), 1)
addCorner(SendChatBtn, 6)

-- ===== LAYOUT UPDATE FUNCTIE (alleen TP) =====
function updateMiscLayout()
	local tpOpen = TpListFrame.Visible
	local tpHeight = tpOpen and 150 or 0

	-- TpListFrame hoogte
	TpListFrame.Size = UDim2.new(1,0,0,tpHeight)
	TpListFrame.CanvasSize = UDim2.new(0,0,0,tpHeight)

	-- SendChatLabel
	local chatY = 38 + tpHeight + 10 + 20 -- 38 = TpBtn hoogte, 10 marge, 20 extra marge
	SendChatLabel.Position = UDim2.new(0,0,0, chatY)

	-- ChatInputFrame
	ChatInputFrame.Position = UDim2.new(0,0,0, chatY + 24)

	-- SendChatBtn
	SendChatBtn.Position = UDim2.new(0,0,0, chatY + 24 + 55)

	-- CanvasSize van MiscScroll
	MiscScroll.CanvasSize = UDim2.new(0,0,0, chatY + 24 + 55 + 50)
end

-- ===== TP LIST BUILDER =====
function buildTpList()
	for _, c in ipairs(TpListFrame:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	local count = 0
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1,-8,0,34)
			btn.BackgroundColor3 = Color3.fromRGB(22,22,28)
			btn.Font = Enum.Font.RobotoMono
			btn.Text = "> " .. plr.DisplayName .. " (" .. plr.Name .. ")"
			btn.TextColor3 = Color3.fromRGB(200,200,200)
			btn.TextSize = 11
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = TpListFrame
			btn.RichText = false
			addOutline(btn, Color3.fromRGB(45,45,50), 1)
			addCorner(btn, 6)
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
				mr.CFrame = tr.CFrame * CFrame.new(0,0,-2)
				TpBtn.Text = "// CLICK TELEPORT"
				TpListFrame.Visible = false
				updateMiscLayout()
			end)
		end
	end
	TpListLayout:ApplyLayout()
	local h = math.min(count*38+16, 150)
	TpListFrame.CanvasSize = UDim2.new(0,0,0,h)
end

TpBtn.MouseButton1Click:Connect(function()
	if TpListFrame.Visible then
		TpListFrame.Visible = false
		TpBtn.Text = "// CLICK TELEPORT"
	else
		buildTpList()
		TpListFrame.Visible = true
		TpBtn.Text = "// CLOSE LIST"
	end
	updateMiscLayout()
end)

SendChatBtn.MouseButton1Click:Connect(function()
	local msg = ChatTextBox.Text
	if msg == "" or msg == nil then return end
	local success = pcall(function()
		game:GetService("Players").LocalPlayer:Chat(msg)
	end)
	if not success then
		pcall(function()
			local TextChatService = game:GetService("TextChatService")
			local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
			if channel then channel:SendAsync(msg) end
		end)
	end
end)

-- Initialiseer layout (lijst is standaard gesloten)
updateMiscLayout()

-- ========== ESP ==========
EspScroll = Instance.new("ScrollingFrame")
EspScroll.Parent = EspFrame
EspScroll.BackgroundTransparency = 1
EspScroll.Size = UDim2.new(1,0,1,0)
EspScroll.CanvasSize = UDim2.new(0,0,0,300)
EspScroll.ScrollBarThickness = 3
EspScroll.ScrollBarImageColor3 = accentColor

EspLabel = Instance.new("TextLabel")
EspLabel.Parent = EspScroll
EspLabel.BackgroundTransparency = 1
EspLabel.Position = UDim2.new(0,0,0,10)
EspLabel.Size = UDim2.new(1,0,0,20)
EspLabel.Font = Enum.Font.RobotoMono
EspLabel.Text = "// ESP"
EspLabel.TextColor3 = Color3.fromRGB(120,120,120)
EspLabel.TextSize = 13
EspLabel.TextXAlignment = Enum.TextXAlignment.Left
EspLabel.RichText = false

EspButton = Instance.new("TextButton")
EspButton.Parent = EspScroll
EspButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
EspButton.Position = UDim2.new(0,0,0,38)
EspButton.Size = UDim2.new(1,0,0,45)
EspButton.Font = Enum.Font.RobotoMono
EspButton.Text = "// ESP: OFF"
EspButton.TextColor3 = accentColor
EspButton.TextSize = 14
EspButton.RichText = false
addOutline(EspButton, Color3.fromRGB(40,40,45), 1)
addCorner(EspButton, 6)

EspBoxButton = Instance.new("TextButton")
EspBoxButton.Parent = EspScroll
EspBoxButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
EspBoxButton.Position = UDim2.new(0,0,0,98)
EspBoxButton.Size = UDim2.new(0.48,-4,0,34)
EspBoxButton.Font = Enum.Font.RobotoMono
EspBoxButton.Text = "BOX: OFF"
EspBoxButton.TextColor3 = Color3.fromRGB(200,200,200)
EspBoxButton.TextSize = 12
EspBoxButton.RichText = false
addOutline(EspBoxButton, Color3.fromRGB(40,40,45), 1)
addCorner(EspBoxButton, 6)

EspNameButton = Instance.new("TextButton")
EspNameButton.Parent = EspScroll
EspNameButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
EspNameButton.Position = UDim2.new(0.52,0,0,98)
EspNameButton.Size = UDim2.new(0.48,0,0,34)
EspNameButton.Font = Enum.Font.RobotoMono
EspNameButton.Text = "NAME: OFF"
EspNameButton.TextColor3 = Color3.fromRGB(200,200,200)
EspNameButton.TextSize = 12
EspNameButton.RichText = false
addOutline(EspNameButton, Color3.fromRGB(40,40,45), 1)
addCorner(EspNameButton, 6)

EspDistButton = Instance.new("TextButton")
EspDistButton.Parent = EspScroll
EspDistButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
EspDistButton.Position = UDim2.new(0,0,0,148)
EspDistButton.Size = UDim2.new(1,0,0,34)
EspDistButton.Font = Enum.Font.RobotoMono
EspDistButton.Text = "DISTANCE: OFF"
EspDistButton.TextColor3 = Color3.fromRGB(200,200,200)
EspDistButton.TextSize = 12
EspDistButton.RichText = false
addOutline(EspDistButton, Color3.fromRGB(40,40,45), 1)
addCorner(EspDistButton, 6)

EspHealthButton = Instance.new("TextButton")
EspHealthButton.Parent = EspScroll
EspHealthButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
EspHealthButton.Position = UDim2.new(0,0,0,198)
EspHealthButton.Size = UDim2.new(1,0,0,34)
EspHealthButton.Font = Enum.Font.RobotoMono
EspHealthButton.Text = "HEALTH: OFF"
EspHealthButton.TextColor3 = Color3.fromRGB(200,200,200)
EspHealthButton.TextSize = 12
EspHealthButton.RichText = false
addOutline(EspHealthButton, Color3.fromRGB(40,40,45), 1)
addCorner(EspHealthButton, 6)

-- ========== AIM ==========
AimScroll = Instance.new("ScrollingFrame")
AimScroll.Parent = AimFrame
AimScroll.BackgroundTransparency = 1
AimScroll.Size = UDim2.new(1,0,1,0)
AimScroll.CanvasSize = UDim2.new(0,0,0,500)
AimScroll.ScrollBarThickness = 3
AimScroll.ScrollBarImageColor3 = accentColor

AimLabel = Instance.new("TextLabel")
AimLabel.Parent = AimScroll
AimLabel.BackgroundTransparency = 1
AimLabel.Position = UDim2.new(0,0,0,10)
AimLabel.Size = UDim2.new(1,0,0,20)
AimLabel.Font = Enum.Font.RobotoMono
AimLabel.Text = "// AIM"
AimLabel.TextColor3 = Color3.fromRGB(120,120,120)
AimLabel.TextSize = 13
AimLabel.TextXAlignment = Enum.TextXAlignment.Left
AimLabel.RichText = false

CrosshairButton = Instance.new("TextButton")
CrosshairButton.Parent = AimScroll
CrosshairButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
CrosshairButton.Position = UDim2.new(0,0,0,38)
CrosshairButton.Size = UDim2.new(1,0,0,45)
CrosshairButton.Font = Enum.Font.RobotoMono
CrosshairButton.Text = "// CROSSHAIR: OFF"
CrosshairButton.TextColor3 = accentColor
CrosshairButton.TextSize = 14
CrosshairButton.RichText = false
addOutline(CrosshairButton, Color3.fromRGB(40,40,45), 1)
addCorner(CrosshairButton, 6)

CrosshairConfigFrame = Instance.new("Frame")
CrosshairConfigFrame.Parent = AimScroll
CrosshairConfigFrame.BackgroundTransparency = 1
CrosshairConfigFrame.Position = UDim2.new(0,0,0,98)
CrosshairConfigFrame.Size = UDim2.new(1,0,0,350)
CrosshairConfigFrame.Visible = false

-- Style
StyleLabel2 = Instance.new("TextLabel")
StyleLabel2.Parent = CrosshairConfigFrame
StyleLabel2.BackgroundTransparency = 1
StyleLabel2.Position = UDim2.new(0,0,0,0)
StyleLabel2.Size = UDim2.new(1,0,0,20)
StyleLabel2.Font = Enum.Font.RobotoMono
StyleLabel2.Text = "> STYLE:"
StyleLabel2.TextColor3 = Color3.fromRGB(160,160,160)
StyleLabel2.TextSize = 12
StyleLabel2.TextXAlignment = Enum.TextXAlignment.Left
StyleLabel2.RichText = false

StyleCrossBtn = Instance.new("TextButton")
StyleCrossBtn.Parent = CrosshairConfigFrame
StyleCrossBtn.BackgroundColor3 = Color3.fromRGB(22,22,28)
StyleCrossBtn.Position = UDim2.new(0,0,0,30)
StyleCrossBtn.Size = UDim2.new(0.3,-4,0,35)
StyleCrossBtn.Font = Enum.Font.RobotoMono
StyleCrossBtn.Text = "CROSS"
StyleCrossBtn.TextColor3 = Color3.fromRGB(200,200,200)
StyleCrossBtn.TextSize = 11
StyleCrossBtn.RichText = false
addOutline(StyleCrossBtn, accentColor, 1)
addCorner(StyleCrossBtn, 6)

StyleDotBtn = Instance.new("TextButton")
StyleDotBtn.Parent = CrosshairConfigFrame
StyleDotBtn.BackgroundColor3 = Color3.fromRGB(22,22,28)
StyleDotBtn.Position = UDim2.new(0.35,0,0,30)
StyleDotBtn.Size = UDim2.new(0.3,-4,0,35)
StyleDotBtn.Font = Enum.Font.RobotoMono
StyleDotBtn.Text = "DOT"
StyleDotBtn.TextColor3 = Color3.fromRGB(200,200,200)
StyleDotBtn.TextSize = 11
StyleDotBtn.RichText = false
addOutline(StyleDotBtn, Color3.fromRGB(45,45,50), 1)
addCorner(StyleDotBtn, 6)

StyleCircleBtn = Instance.new("TextButton")
StyleCircleBtn.Parent = CrosshairConfigFrame
StyleCircleBtn.BackgroundColor3 = Color3.fromRGB(22,22,28)
StyleCircleBtn.Position = UDim2.new(0.7,0,0,30)
StyleCircleBtn.Size = UDim2.new(0.3,0,0,35)
StyleCircleBtn.Font = Enum.Font.RobotoMono
StyleCircleBtn.Text = "CIRCLE"
StyleCircleBtn.TextColor3 = Color3.fromRGB(200,200,200)
StyleCircleBtn.TextSize = 11
StyleCircleBtn.RichText = false
addOutline(StyleCircleBtn, Color3.fromRGB(45,45,50), 1)
addCorner(StyleCircleBtn, 6)

-- Size
SizeFrame = Instance.new("Frame")
SizeFrame.Parent = CrosshairConfigFrame
SizeFrame.BackgroundColor3 = bgMid
SizeFrame.Position = UDim2.new(0,0,0,80)
SizeFrame.Size = UDim2.new(1,0,0,40)
addOutline(SizeFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SizeFrame, 6)

SizeLabel = Instance.new("TextLabel")
SizeLabel.Parent = SizeFrame
SizeLabel.BackgroundTransparency = 1
SizeLabel.Position = UDim2.new(0,12,0,10)
SizeLabel.Size = UDim2.new(0.4,0,0,20)
SizeLabel.Font = Enum.Font.RobotoMono
SizeLabel.Text = "SIZE:"
SizeLabel.TextColor3 = Color3.fromRGB(160,160,160)
SizeLabel.TextSize = 12
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.RichText = false

SizeBox = Instance.new("TextBox")
SizeBox.Parent = SizeFrame
SizeBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
SizeBox.Position = UDim2.new(0.45,0,0,6)
SizeBox.Size = UDim2.new(0.25,0,0,28)
SizeBox.Font = Enum.Font.RobotoMono
SizeBox.Text = "20"
SizeBox.TextColor3 = accentColor
SizeBox.TextSize = 12
SizeBox.TextXAlignment = Enum.TextXAlignment.Center
SizeBox.RichText = false
addOutline(SizeBox, Color3.fromRGB(45,45,50), 1)
addCorner(SizeBox, 4)

-- Thickness
ThickFrame = Instance.new("Frame")
ThickFrame.Parent = CrosshairConfigFrame
ThickFrame.BackgroundColor3 = bgMid
ThickFrame.Position = UDim2.new(0,0,0,135)
ThickFrame.Size = UDim2.new(1,0,0,40)
addOutline(ThickFrame, Color3.fromRGB(30,30,35), 1)
addCorner(ThickFrame, 6)

ThickLabel = Instance.new("TextLabel")
ThickLabel.Parent = ThickFrame
ThickLabel.BackgroundTransparency = 1
ThickLabel.Position = UDim2.new(0,12,0,10)
ThickLabel.Size = UDim2.new(0.4,0,0,20)
ThickLabel.Font = Enum.Font.RobotoMono
ThickLabel.Text = "THICKNESS:"
ThickLabel.TextColor3 = Color3.fromRGB(160,160,160)
ThickLabel.TextSize = 12
ThickLabel.TextXAlignment = Enum.TextXAlignment.Left
ThickLabel.RichText = false

ThickBox = Instance.new("TextBox")
ThickBox.Parent = ThickFrame
ThickBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
ThickBox.Position = UDim2.new(0.45,0,0,6)
ThickBox.Size = UDim2.new(0.25,0,0,28)
ThickBox.Font = Enum.Font.RobotoMono
ThickBox.Text = "2"
ThickBox.TextColor3 = accentColor
ThickBox.TextSize = 12
ThickBox.TextXAlignment = Enum.TextXAlignment.Center
ThickBox.RichText = false
addOutline(ThickBox, Color3.fromRGB(45,45,50), 1)
addCorner(ThickBox, 4)

-- Gap
GapFrame = Instance.new("Frame")
GapFrame.Parent = CrosshairConfigFrame
GapFrame.BackgroundColor3 = bgMid
GapFrame.Position = UDim2.new(0,0,0,190)
GapFrame.Size = UDim2.new(1,0,0,40)
addOutline(GapFrame, Color3.fromRGB(30,30,35), 1)
addCorner(GapFrame, 6)

GapLabel = Instance.new("TextLabel")
GapLabel.Parent = GapFrame
GapLabel.BackgroundTransparency = 1
GapLabel.Position = UDim2.new(0,12,0,10)
GapLabel.Size = UDim2.new(0.4,0,0,20)
GapLabel.Font = Enum.Font.RobotoMono
GapLabel.Text = "GAP:"
GapLabel.TextColor3 = Color3.fromRGB(160,160,160)
GapLabel.TextSize = 12
GapLabel.TextXAlignment = Enum.TextXAlignment.Left
GapLabel.RichText = false

GapBox = Instance.new("TextBox")
GapBox.Parent = GapFrame
GapBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
GapBox.Position = UDim2.new(0.45,0,0,6)
GapBox.Size = UDim2.new(0.25,0,0,28)
GapBox.Font = Enum.Font.RobotoMono
GapBox.Text = "6"
GapBox.TextColor3 = accentColor
GapBox.TextSize = 12
GapBox.TextXAlignment = Enum.TextXAlignment.Center
GapBox.RichText = false
addOutline(GapBox, Color3.fromRGB(45,45,50), 1)
addCorner(GapBox, 4)

-- ========== SETTINGS ==========
SettingsScroll = Instance.new("ScrollingFrame")
SettingsScroll.Name = "SettingsScroll"
SettingsScroll.Parent = SettingsFrame
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.Size = UDim2.new(1,0,1,0)
SettingsScroll.CanvasSize = UDim2.new(0,0,0,520)
SettingsScroll.ScrollBarThickness = 3
SettingsScroll.ScrollBarImageColor3 = accentColor

SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Parent = SettingsScroll
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0,0,0,10)
SettingsLabel.Size = UDim2.new(1,0,0,20)
SettingsLabel.Font = Enum.Font.RobotoMono
SettingsLabel.Text = "// SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(120,120,120)
SettingsLabel.TextSize = 13
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsLabel.RichText = false

SettingsKeybindLabel = Instance.new("TextLabel")
SettingsKeybindLabel.Parent = SettingsScroll
SettingsKeybindLabel.BackgroundTransparency = 1
SettingsKeybindLabel.Position = UDim2.new(0,0,0,48)
SettingsKeybindLabel.Size = UDim2.new(1,0,0,16)
SettingsKeybindLabel.Font = Enum.Font.RobotoMono
SettingsKeybindLabel.Text = "> TOGGLE HOTKEY:"
SettingsKeybindLabel.TextColor3 = Color3.fromRGB(160,160,160)
SettingsKeybindLabel.TextSize = 11
SettingsKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsKeybindLabel.RichText = false

SettingsKeybindBtn = Instance.new("TextButton")
SettingsKeybindBtn.Parent = SettingsScroll
SettingsKeybindBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
SettingsKeybindBtn.Position = UDim2.new(0,0,0,68)
SettingsKeybindBtn.Size = UDim2.new(1,0,0,34)
SettingsKeybindBtn.Font = Enum.Font.RobotoMono
SettingsKeybindBtn.Text = "BIND: LAlt"
SettingsKeybindBtn.TextColor3 = accentColor
SettingsKeybindBtn.TextSize = 12
SettingsKeybindBtn.RichText = false
addOutline(SettingsKeybindBtn, Color3.fromRGB(40,40,45), 1)
addCorner(SettingsKeybindBtn, 6)

ColorLabel = Instance.new("TextLabel")
ColorLabel.Parent = SettingsScroll
ColorLabel.BackgroundTransparency = 1
ColorLabel.Position = UDim2.new(0,0,0,114)
ColorLabel.Size = UDim2.new(1,0,0,16)
ColorLabel.Font = Enum.Font.RobotoMono
ColorLabel.Text = "> UI ACCENT COLOR:"
ColorLabel.TextColor3 = Color3.fromRGB(160,160,160)
ColorLabel.TextSize = 11
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.RichText = false

colorOptions = {
	{name = "RED",    color = Color3.fromRGB(255,40,40)},
	{name = "BLUE",   color = Color3.fromRGB(40,120,255)},
	{name = "GREEN",  color = Color3.fromRGB(50,220,80)},
	{name = "PURPLE", color = Color3.fromRGB(160,60,255)},
	{name = "CYAN",   color = Color3.fromRGB(40,220,220)},
	{name = "WHITE",  color = Color3.fromRGB(220,220,220)},
}

colorBtns = {}
for i, opt in ipairs(colorOptions) do
	local col = math.floor((i-1)%3)
	local row = math.floor((i-1)/3)
	local cb = Instance.new("TextButton")
	cb.Parent = SettingsScroll
	cb.BackgroundColor3 = Color3.fromRGB(22,22,28)
	cb.Position = UDim2.new(0, col*120, 0, 134+row*42)
	cb.Size = UDim2.new(0,112,0,34)
	cb.Font = Enum.Font.RobotoMono
	cb.Text = opt.name
	cb.TextColor3 = opt.color
	cb.TextSize = 11
	cb.RichText = false
	addOutline(cb, opt.color, 1)
	addCorner(cb, 6)
	colorBtns[i] = {btn = cb, color = opt.color}
end

-- Anti-AFK
AntiAfkLabel = Instance.new("TextLabel")
AntiAfkLabel.Parent = SettingsScroll
AntiAfkLabel.BackgroundTransparency = 1
AntiAfkLabel.Position = UDim2.new(0,0,0,225)
AntiAfkLabel.Size = UDim2.new(1,0,0,16)
AntiAfkLabel.Font = Enum.Font.RobotoMono
AntiAfkLabel.Text = "> ANTI-AFK:"
AntiAfkLabel.TextColor3 = Color3.fromRGB(160,160,160)
AntiAfkLabel.TextSize = 11
AntiAfkLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAfkLabel.RichText = false

AntiAfkBtn = Instance.new("TextButton")
AntiAfkBtn.Parent = SettingsScroll
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
AntiAfkBtn.Position = UDim2.new(0,0,0,245)
AntiAfkBtn.Size = UDim2.new(1,0,0,34)
AntiAfkBtn.Font = Enum.Font.RobotoMono
AntiAfkBtn.Text = "OFF"
AntiAfkBtn.TextColor3 = Color3.fromRGB(200,200,200)
AntiAfkBtn.TextSize = 12
AntiAfkBtn.RichText = false
addOutline(AntiAfkBtn, Color3.fromRGB(40,40,45), 1)
addCorner(AntiAfkBtn, 6)

-- Server Hop
ServerHopLabel = Instance.new("TextLabel")
ServerHopLabel.Parent = SettingsScroll
ServerHopLabel.BackgroundTransparency = 1
ServerHopLabel.Position = UDim2.new(0,0,0,295)
ServerHopLabel.Size = UDim2.new(1,0,0,16)
ServerHopLabel.Font = Enum.Font.RobotoMono
ServerHopLabel.Text = "> SERVER HOP:"
ServerHopLabel.TextColor3 = Color3.fromRGB(160,160,160)
ServerHopLabel.TextSize = 11
ServerHopLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerHopLabel.RichText = false

ServerHopBtn = Instance.new("TextButton")
ServerHopBtn.Parent = SettingsScroll
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
ServerHopBtn.Position = UDim2.new(0,0,0,315)
ServerHopBtn.Size = UDim2.new(1,0,0,34)
ServerHopBtn.Font = Enum.Font.RobotoMono
ServerHopBtn.Text = "HOP SERVER"
ServerHopBtn.TextColor3 = accentColor
ServerHopBtn.TextSize = 12
ServerHopBtn.RichText = false
addOutline(ServerHopBtn, Color3.fromRGB(40,40,45), 1)
addCorner(ServerHopBtn, 6)

-- Anti-Fling (verwijderd, maar we laten de knop niet zien)
-- We hebben de anti-fling functionaliteit ook verwijderd uit de code.

UnloadBtn = Instance.new("TextButton")
UnloadBtn.Parent = SettingsScroll
UnloadBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
UnloadBtn.Position = UDim2.new(0,0,0,365) -- aangepast omdat anti-fling weg is
UnloadBtn.Size = UDim2.new(1,0,0,45)
UnloadBtn.Font = Enum.Font.RobotoMono
UnloadBtn.Text = "// UNLOAD SCRIPT"
UnloadBtn.TextColor3 = accentColor
UnloadBtn.TextSize = 14
UnloadBtn.RichText = false
addOutline(UnloadBtn, Color3.fromRGB(40,40,45), 1)
addCorner(UnloadBtn, 6)

-- Pas canvasSize aan omdat anti-fling weg is
SettingsScroll.CanvasSize = UDim2.new(0,0,0,420)

-- ===========================================================
-- ========== ALLE FUNCTIONALITEIT ===========================
-- ===========================================================

walkSpeedValue = 16
jumpHeightValue = 50
noclipEnabled = false
noclipConnection = nil
infiniteJumpEnabled = false
jumpConnection = nil

-- Anti-AFK
antiAfkEnabled = false
antiAfkConnection = nil
antiAfkTimer = 0

-- Fly
flying = false
flySpeed = 1.8
flyStyle = "Normal"
speeds = {Mode1 = 1.2, Mode2 = 2.8, Mode3 = 6.5}
originalGravity = workspace.Gravity
connectionFly = nil
flyAnimTrack = nil
currentMoveVector = Vector3.new(0,0,0)
targetMoveVector = Vector3.new(0,0,0)

-- ESP
espEnabled = false
espBoxEnabled = false
espNameEnabled = false
espDistEnabled = false
espHealthEnabled = false
espObjects = {}
espConnections = {}
espUpdateConnection = nil

-- Crosshair
crosshairEnabled = false
crosshairStyle = "Cross"
crosshairSize = 20
crosshairThickness = 2
crosshairGap = 6
crosshairGui = nil
crosshairElements = {}

-- ===== SLIDERS =====
function setupSlider(knob, track, fill, label, minVal, maxVal, default, callback)
	local draggingSlider = false
	local function update(xRatio)
		xRatio = math.clamp(xRatio, 0, 1)
		local val = math.floor(minVal + (maxVal - minVal) * xRatio)
		label.Text = tostring(val)
		fill.Size = UDim2.new(xRatio, 0, 1, 0)
		knob.Position = UDim2.new(xRatio, -6, 0.5, -6)
		callback(val)
	end
	update((default - minVal) / (maxVal - minVal))
	knob.MouseButton1Down:Connect(function() draggingSlider = true end)
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSlider = true
			local ratio = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
			update(ratio)
		end
	end)
	RunService.RenderStepped:Connect(function()
		if draggingSlider then
			local mousePos = UserInputService:GetMouseLocation()
			local ratio = (mousePos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
			update(ratio)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSlider = false
		end
	end)
end

setupSlider(SpeedSliderKnob, SpeedSliderTrack, SpeedSliderFill, SpeedValueLabel, 8, 150, 16, function(val)
	walkSpeedValue = val
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = val end
	end
end)

setupSlider(JumpSliderKnob, JumpSliderTrack, JumpSliderFill, JumpValueLabel, 7, 200, 50, function(val)
	jumpHeightValue = val
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.JumpPower = val end
	end
end)

-- ===== CROSSHAIR =====
function createCrosshair()
	local gui = Instance.new("ScreenGui")
	gui.Parent = ScreenGui.Parent
	gui.ResetOnSpawn = false
	gui.Name = "CrosshairGui"
	gui.IgnoreGuiInset = true
	local elements = {}
	
	if crosshairStyle == "Cross" then
		local size = crosshairSize
		local thick = crosshairThickness
		local gap = crosshairGap
		local armLen = size/2 - gap/2
		if armLen < 1 then armLen = 1 end
		if gap >= size then gap = size - 1 end
		local top = Instance.new("Frame")
		top.Parent = gui
		top.BackgroundColor3 = accentColor
		top.BorderSizePixel = 0
		top.Size = UDim2.new(0, thick, 0, armLen)
		top.AnchorPoint = Vector2.new(0.5, 0)
		top.Position = UDim2.new(0.5, 0, 0.5, -gap/2 - armLen)
		table.insert(elements, top)
		local bot = Instance.new("Frame")
		bot.Parent = gui
		bot.BackgroundColor3 = accentColor
		bot.BorderSizePixel = 0
		bot.Size = UDim2.new(0, thick, 0, armLen)
		bot.AnchorPoint = Vector2.new(0.5, 1)
		bot.Position = UDim2.new(0.5, 0, 0.5, gap/2 + armLen)
		table.insert(elements, bot)
		local left = Instance.new("Frame")
		left.Parent = gui
		left.BackgroundColor3 = accentColor
		left.BorderSizePixel = 0
		left.Size = UDim2.new(0, armLen, 0, thick)
		left.AnchorPoint = Vector2.new(0, 0.5)
		left.Position = UDim2.new(0.5, -gap/2 - armLen, 0.5, 0)
		table.insert(elements, left)
		local right = Instance.new("Frame")
		right.Parent = gui
		right.BackgroundColor3 = accentColor
		right.BorderSizePixel = 0
		right.Size = UDim2.new(0, armLen, 0, thick)
		right.AnchorPoint = Vector2.new(1, 0.5)
		right.Position = UDim2.new(0.5, gap/2 + armLen, 0.5, 0)
		table.insert(elements, right)
		
	elseif crosshairStyle == "Dot" then
		local size = crosshairSize
		local dot = Instance.new("Frame")
		dot.Parent = gui
		dot.BackgroundColor3 = accentColor
		dot.BorderSizePixel = 0
		dot.Size = UDim2.new(0, size, 0, size)
		dot.AnchorPoint = Vector2.new(0.5, 0.5)
		dot.Position = UDim2.new(0.5, 0, 0.5, 0)
		addCorner(dot, size/2)
		table.insert(elements, dot)
		
	elseif crosshairStyle == "Circle" then
		local size = crosshairSize
		local thick = crosshairThickness
		local circle = Instance.new("Frame")
		circle.Parent = gui
		circle.BackgroundTransparency = 1
		circle.BorderSizePixel = 0
		circle.Size = UDim2.new(0, size, 0, size)
		circle.AnchorPoint = Vector2.new(0.5, 0.5)
		circle.Position = UDim2.new(0.5, 0, 0.5, 0)
		local stroke = Instance.new("UIStroke")
		stroke.Color = accentColor
		stroke.Thickness = thick
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = circle
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1,0)
		corner.Parent = circle
		table.insert(elements, circle)
	end
	
	return gui, elements
end

function rebuildCrosshair()
	if crosshairGui then
		crosshairGui:Destroy()
		crosshairGui = nil
		crosshairElements = {}
	end
	if crosshairEnabled then
		crosshairGui, crosshairElements = createCrosshair()
	end
end

function updateCrosshairFromBoxes()
	local s = tonumber(SizeBox.Text)
	local t = tonumber(ThickBox.Text)
	local g = tonumber(GapBox.Text)
	if s and s > 0 then crosshairSize = s end
	if t and t > 0 then crosshairThickness = t end
	if g and g >= 0 then crosshairGap = g end
	if crosshairEnabled then rebuildCrosshair() end
end

SizeBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then updateCrosshairFromBoxes() end
end)
ThickBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then updateCrosshairFromBoxes() end
end)
GapBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then updateCrosshairFromBoxes() end
end)

function updateStyleVisuals()
	setStrokeColor(StyleCrossBtn, Color3.fromRGB(45,45,50))
	setStrokeColor(StyleDotBtn, Color3.fromRGB(45,45,50))
	setStrokeColor(StyleCircleBtn, Color3.fromRGB(45,45,50))
	if crosshairStyle == "Cross" then setStrokeColor(StyleCrossBtn, accentColor)
	elseif crosshairStyle == "Dot" then setStrokeColor(StyleDotBtn, accentColor)
	elseif crosshairStyle == "Circle" then setStrokeColor(StyleCircleBtn, accentColor) end
end

StyleCrossBtn.MouseButton1Click:Connect(function()
	crosshairStyle = "Cross"
	updateStyleVisuals()
	if crosshairEnabled then rebuildCrosshair() end
end)
StyleDotBtn.MouseButton1Click:Connect(function()
	crosshairStyle = "Dot"
	updateStyleVisuals()
	if crosshairEnabled then rebuildCrosshair() end
end)
StyleCircleBtn.MouseButton1Click:Connect(function()
	crosshairStyle = "Circle"
	updateStyleVisuals()
	if crosshairEnabled then rebuildCrosshair() end
end)

function setCrosshair(enabled)
	crosshairEnabled = enabled
	if enabled then
		CrosshairButton.Text = "// CROSSHAIR: ON"
		CrosshairButton.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(CrosshairButton, Color3.fromRGB(50,255,50))
		CrosshairConfigFrame.Visible = true
		rebuildCrosshair()
	else
		CrosshairButton.Text = "// CROSSHAIR: OFF"
		CrosshairButton.TextColor3 = accentColor
		setStrokeColor(CrosshairButton, Color3.fromRGB(40,40,45))
		CrosshairConfigFrame.Visible = false
		if crosshairGui then
			crosshairGui:Destroy()
			crosshairGui = nil
			crosshairElements = {}
		end
	end
end

CrosshairButton.MouseButton1Click:Connect(function()
	setCrosshair(not crosshairEnabled)
end)
updateStyleVisuals()

-- ===== ESP =====
function removeEspForPlayer(plrName)
	local data = espObjects[plrName]
	if data then
		if data.highlight then pcall(function() data.highlight:Destroy() end) end
		if data.box then pcall(function() data.box:Destroy() end) end
		if data.bill then pcall(function() data.bill:Destroy() end) end
		espObjects[plrName] = nil
	end
end

function clearAllEsp()
	for plrName, data in pairs(espObjects) do
		removeEspForPlayer(plrName)
	end
	espObjects = {}
end

function updateEspForPlayer(plr)
	if plr == LocalPlayer then return end
	local char = plr.Character
	if not char then return end
	removeEspForPlayer(plr.Name)
	if not espEnabled then return end
	
	local data = {}
	local head = char:FindFirstChild("Head")
	local hum = char:FindFirstChild("Humanoid")
	
	-- Highlight
	local h = Instance.new("Highlight")
	h.Parent = char
	h.FillTransparency = 1
	h.OutlineColor = accentColor
	h.OutlineTransparency = 0
	data.highlight = h
	
	-- Box
	if espBoxEnabled then
		local box = Instance.new("SelectionBox")
		box.Parent = char
		box.Color3 = accentColor
		box.Transparency = 0.1
		box.LineThickness = 0.2
		data.box = box
	end
	
	-- Billboard
	if espNameEnabled or espDistEnabled or espHealthEnabled then
		local bill = Instance.new("BillboardGui")
		bill.Parent = head or char
		bill.Adornee = head or char
		bill.Size = UDim2.new(0, 180, 0, 70)
		bill.StudsOffset = Vector3.new(0, 2, 0)
		bill.AlwaysOnTop = true
		
		local mainFrame = Instance.new("Frame")
		mainFrame.Parent = bill
		mainFrame.Size = UDim2.new(1,0,1,0)
		mainFrame.BackgroundTransparency = 1
		
		local layout = Instance.new("UIListLayout")
		layout.Parent = mainFrame
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0,1)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.VerticalAlignment = Enum.VerticalAlignment.Top
		
		-- Naam
		local nameLabel = nil
		if espNameEnabled then
			nameLabel = Instance.new("TextLabel")
			nameLabel.Parent = mainFrame
			nameLabel.Size = UDim2.new(1,0,0,20)
			nameLabel.BackgroundTransparency = 1
			nameLabel.Font = Enum.Font.RobotoMono
			nameLabel.Text = plr.DisplayName
			nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
			nameLabel.TextSize = 16
			nameLabel.TextStrokeTransparency = 0.3
			nameLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
			nameLabel.TextScaled = true
		end
		
		-- Afstand
		local distLabel = nil
		if espDistEnabled then
			distLabel = Instance.new("TextLabel")
			distLabel.Parent = mainFrame
			distLabel.Size = UDim2.new(1,0,0,16)
			distLabel.BackgroundTransparency = 1
			distLabel.Font = Enum.Font.RobotoMono
			distLabel.TextColor3 = Color3.fromRGB(200,200,255)
			distLabel.TextSize = 14
			distLabel.TextStrokeTransparency = 0.3
			distLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
			distLabel.TextScaled = true
			distLabel.Text = "0m"
		end
		
		-- Gezondheidsbalk
		local healthFill = nil
		if espHealthEnabled and hum then
			local healthFrame = Instance.new("Frame")
			healthFrame.Parent = mainFrame
			healthFrame.Size = UDim2.new(0.4, 0, 0, 4)
			healthFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
			healthFrame.BorderSizePixel = 0
			healthFill = Instance.new("Frame")
			healthFill.Parent = healthFrame
			healthFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
			healthFill.BorderSizePixel = 0
			healthFill.Size = UDim2.new(hum.Health/hum.MaxHealth,0,1,0)
		end
		
		data.bill = bill
		data.distLabel = distLabel
		data.healthFill = healthFill
	end
	
	espObjects[plr.Name] = data
end

function updateEspDynamic()
	for plrName, data in pairs(espObjects) do
		local distLabel = data.distLabel
		local healthFill = data.healthFill
		
		if distLabel then
			local plr = Players:FindFirstChild(plrName)
			if not plr then continue end
			local char = plr.Character
			if not char then continue end
			local root = char:FindFirstChild("HumanoidRootPart")
			local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if root and myRoot then
				local dist = math.floor((root.Position - myRoot.Position).Magnitude)
				distLabel.Text = dist .. "m"
			else
				distLabel.Text = "?m"
			end
		end
		
		if healthFill then
			local plr = Players:FindFirstChild(plrName)
			if not plr then continue end
			local char = plr.Character
			if not char then continue end
			local hum = char:FindFirstChild("Humanoid")
			if hum then
				local ratio = math.clamp(hum.Health/hum.MaxHealth, 0, 1)
				healthFill.Size = UDim2.new(ratio,0,1,0)
				healthFill.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
			end
		end
	end
end

function refreshAllEsp()
	clearAllEsp()
	if espEnabled then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				updateEspForPlayer(plr)
				local conn = plr.CharacterAdded:Connect(function()
					wait(0.5)
					if espEnabled then updateEspForPlayer(plr) end
				end)
				table.insert(espConnections, conn)
			end
		end
		if not espUpdateConnection then
			espUpdateConnection = RunService.RenderStepped:Connect(updateEspDynamic)
		end
	else
		if espUpdateConnection then
			espUpdateConnection:Disconnect()
			espUpdateConnection = nil
		end
		for _, conn in ipairs(espConnections) do
			pcall(function() conn:Disconnect() end)
		end
		espConnections = {}
	end
end

function setEsp(enabled)
	espEnabled = enabled
	if enabled then
		EspButton.Text = "// ESP: ON"
		EspButton.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(EspButton, Color3.fromRGB(50,255,50))
		refreshAllEsp()
	else
		EspButton.Text = "// ESP: OFF"
		EspButton.TextColor3 = accentColor
		setStrokeColor(EspButton, Color3.fromRGB(40,40,45))
		refreshAllEsp()
	end
end

function updateEspOptionButton(btn, label, value)
	btn.Text = label .. ": " .. (value and "ON" or "OFF")
	btn.TextColor3 = value and Color3.fromRGB(50,255,50) or Color3.fromRGB(200,200,200)
	setStrokeColor(btn, value and Color3.fromRGB(50,255,50) or Color3.fromRGB(40,40,45))
end

EspBoxButton.MouseButton1Click:Connect(function()
	espBoxEnabled = not espBoxEnabled
	updateEspOptionButton(EspBoxButton, "BOX", espBoxEnabled)
	if espEnabled then refreshAllEsp() end
end)

EspNameButton.MouseButton1Click:Connect(function()
	espNameEnabled = not espNameEnabled
	updateEspOptionButton(EspNameButton, "NAME", espNameEnabled)
	if espEnabled then refreshAllEsp() end
end)

EspDistButton.MouseButton1Click:Connect(function()
	espDistEnabled = not espDistEnabled
	updateEspOptionButton(EspDistButton, "DISTANCE", espDistEnabled)
	if espEnabled then refreshAllEsp() end
end)

EspHealthButton.MouseButton1Click:Connect(function()
	espHealthEnabled = not espHealthEnabled
	updateEspOptionButton(EspHealthButton, "HEALTH", espHealthEnabled)
	if espEnabled then refreshAllEsp() end
end)

EspButton.MouseButton1Click:Connect(function()
	setEsp(not espEnabled)
end)

-- ===== ANTI-AFK =====
function toggleAntiAfk()
	antiAfkEnabled = not antiAfkEnabled
	if antiAfkEnabled then
		AntiAfkBtn.Text = "ON"
		AntiAfkBtn.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(AntiAfkBtn, Color3.fromRGB(50,255,50))
		antiAfkConnection = RunService.RenderStepped:Connect(function(delta)
			antiAfkTimer = antiAfkTimer + delta
			if antiAfkTimer >= 10 then
				antiAfkTimer = 0
				pcall(function()
					local cam = workspace.CurrentCamera
					if cam then
						cam.CFrame = cam.CFrame * CFrame.Angles(0, 0.001, 0)
					end
				end)
			end
		end)
	else
		AntiAfkBtn.Text = "OFF"
		AntiAfkBtn.TextColor3 = Color3.fromRGB(200,200,200)
		setStrokeColor(AntiAfkBtn, Color3.fromRGB(40,40,45))
		if antiAfkConnection then
			antiAfkConnection:Disconnect()
			antiAfkConnection = nil
		end
		antiAfkTimer = 0
	end
end

AntiAfkBtn.MouseButton1Click:Connect(toggleAntiAfk)

-- ===== SERVER HOP =====
function hopServer()
	pcall(function()
		if TeleportService then
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		end
	end)
end

ServerHopBtn.MouseButton1Click:Connect(hopServer)

-- ===== FLY =====
function playSafeSupermanAnim(hum)
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

function startClassicFly()
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
		root.AssemblyLinearVelocity = Vector3.new(0,0,0)
		root.AssemblyAngularVelocity = Vector3.new(0,0,0)
		local inputVector = Vector3.new(0,0,0)
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVector = inputVector + cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVector = inputVector - cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVector = inputVector - cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVector = inputVector + cam.CFrame.RightVector end
		if inputVector.Magnitude > 0 then
			targetMoveVector = inputVector.Unit * flySpeed
		else
			targetMoveVector = Vector3.new(0,0,0)
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

function stopClassicFly()
	flying = false
	FlyButton.Text = "// TOGGLE FLY: OFF"
	FlyButton.TextColor3 = accentColor
	setStrokeColor(FlyButton, Color3.fromRGB(40,40,45))
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
		FlyButton.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(FlyButton, Color3.fromRGB(50,255,50))
		startClassicFly()
	else
		stopClassicFly()
	end
end)

function updateSpeedVisuals(activeBtn)
	setStrokeColor(Mode1Btn, Color3.fromRGB(45,45,50))
	setStrokeColor(Mode2Btn, Color3.fromRGB(45,45,50))
	setStrokeColor(Mode3Btn, Color3.fromRGB(45,45,50))
	setStrokeColor(activeBtn, accentColor)
end
function updateStyleVisualsFly(activeBtn)
	setStrokeColor(NormalStyleBtn, Color3.fromRGB(45,45,50))
	setStrokeColor(SupermanStyleBtn, Color3.fromRGB(45,45,50))
	setStrokeColor(activeBtn, accentColor)
end
updateSpeedVisuals(Mode1Btn)
updateStyleVisualsFly(NormalStyleBtn)

Mode1Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode1; updateSpeedVisuals(Mode1Btn) end)
Mode2Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode2; updateSpeedVisuals(Mode2Btn) end)
Mode3Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode3; updateSpeedVisuals(Mode3Btn) end)
NormalStyleBtn.MouseButton1Click:Connect(function() flyStyle = "Normal"; updateStyleVisualsFly(NormalStyleBtn) end)
SupermanStyleBtn.MouseButton1Click:Connect(function() flyStyle = "Superman"; updateStyleVisualsFly(SupermanStyleBtn) end)

-- ===== NOCLIP =====
function setNoclip(enabled)
	noclipEnabled = enabled
	if enabled then
		NoclipButton.Text = "// TOGGLE NOCLIP: ON"
		NoclipButton.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(NoclipButton, Color3.fromRGB(50,255,50))
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
		setStrokeColor(NoclipButton, Color3.fromRGB(40,40,45))
		if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
		local char = LocalPlayer.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = true end
			end
		end
	end
end

NoclipButton.MouseButton1Click:Connect(function()
	setNoclip(not noclipEnabled)
end)

-- ===== INFINITE JUMP =====
function setInfiniteJump(enabled)
	infiniteJumpEnabled = enabled
	if enabled then
		InfiniteJumpButton.Text = "// INFINITE JUMP: ON"
		InfiniteJumpButton.TextColor3 = Color3.fromRGB(50,255,50)
		setStrokeColor(InfiniteJumpButton, Color3.fromRGB(50,255,50))
		jumpConnection = UserInputService.JumpRequest:Connect(function()
			local char = LocalPlayer.Character
			if not char then return end
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	else
		InfiniteJumpButton.Text = "// INFINITE JUMP: OFF"
		InfiniteJumpButton.TextColor3 = accentColor
		setStrokeColor(InfiniteJumpButton, Color3.fromRGB(40,40,45))
		if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
	end
end

InfiniteJumpButton.MouseButton1Click:Connect(function()
	setInfiniteJump(not infiniteJumpEnabled)
end)

-- ===== ACCENT COLOR =====
function isNeutralColor(c)
	local r,g,b = c.R,c.G,c.B
	return math.abs(r-g) < 0.02 and math.abs(g-b) < 0.02 and r < 0.25
end

function applyAccentColor(newColor)
	accentColor = newColor
	for _, desc in ipairs(ScreenGui:GetDescendants()) do
		if desc:IsA("UIStroke") and not isNeutralColor(desc.Color) then
			desc.Color = newColor
		end
	end
	Title.TextColor3 = newColor
	homeAscii.TextColor3 = newColor
	FlyButton.TextColor3 = newColor
	NoclipButton.TextColor3 = newColor
	InfiniteJumpButton.TextColor3 = newColor
	SpeedValueLabel.TextColor3 = newColor
	JumpValueLabel.TextColor3 = newColor
	SettingsKeybindBtn.TextColor3 = newColor
	TpBtn.TextColor3 = newColor
	SendChatBtn.TextColor3 = newColor
	EspButton.TextColor3 = newColor
	CrosshairButton.TextColor3 = newColor
	UnloadBtn.TextColor3 = newColor
	TooltipLabel.TextColor3 = newColor
	ServerHopBtn.TextColor3 = newColor
	PlayerScroll.ScrollBarImageColor3 = newColor
	MiscScroll.ScrollBarImageColor3 = newColor
	SettingsScroll.ScrollBarImageColor3 = newColor
	AimScroll.ScrollBarImageColor3 = newColor
	HomeScroll.ScrollBarImageColor3 = newColor
	TpListFrame.ScrollBarImageColor3 = newColor
	EspScroll.ScrollBarImageColor3 = newColor
	SpeedSliderFill.BackgroundColor3 = newColor
	setStrokeColor(SpeedSliderKnob, newColor)
	JumpSliderFill.BackgroundColor3 = newColor
	setStrokeColor(JumpSliderKnob, newColor)
	setStrokeColor(MainFrame, newColor)
	updateStyleVisuals()
	if crosshairEnabled then rebuildCrosshair() end
	if espEnabled then refreshAllEsp() end
	for _, tab in ipairs({
		{btn=HomeTabBtn, frame=HomeFrame},
		{btn=PlayerTabBtn, frame=PlayerScroll},
		{btn=MiscTabBtn, frame=MiscFrame},
		{btn=SettingsTabBtn, frame=SettingsFrame},
		{btn=EspTabBtn, frame=EspFrame},
		{btn=AimTabBtn, frame=AimFrame},
	}) do
		if tab.frame.Visible then tab.btn.TextColor3 = newColor end
	end
end

for _, entry in ipairs(colorBtns) do
	entry.btn.MouseButton1Click:Connect(function()
		applyAccentColor(entry.color)
	end)
end

-- ===== TABS =====
allTabs = {
	{btn=HomeTabBtn, frame=HomeFrame, name="HOME"},
	{btn=PlayerTabBtn, frame=PlayerScroll, name="PLAYER"},
	{btn=MiscTabBtn, frame=MiscFrame, name="MISC"},
	{btn=EspTabBtn, frame=EspFrame, name="ESP"},
	{btn=AimTabBtn, frame=AimFrame, name="AIM"},
	{btn=SettingsTabBtn, frame=SettingsFrame, name="SETTINGS"},
}

function switchTab(activeBtn, activeFrame)
	for _, tab in ipairs(allTabs) do
		tab.frame.Visible = false
		tab.btn.TextColor3 = Color3.fromRGB(140,140,140)
		tab.btn.Text = "[ ] " .. tab.name
	end
	activeFrame.Visible = true
	activeBtn.TextColor3 = accentColor
	activeBtn.Text = "[X] " .. string.match(activeBtn.Text, "%] (.+)$")
end

switchTab(HomeTabBtn, HomeFrame)

HomeTabBtn.MouseButton1Click:Connect(function() switchTab(HomeTabBtn, HomeFrame) end)
PlayerTabBtn.MouseButton1Click:Connect(function() switchTab(PlayerTabBtn, PlayerScroll) end)
MiscTabBtn.MouseButton1Click:Connect(function() switchTab(MiscTabBtn, MiscFrame) end)
SettingsTabBtn.MouseButton1Click:Connect(function() switchTab(SettingsTabBtn, SettingsFrame) end)
EspTabBtn.MouseButton1Click:Connect(function() switchTab(EspTabBtn, EspFrame) end)
AimTabBtn.MouseButton1Click:Connect(function() switchTab(AimTabBtn, AimFrame) end)

-- ===== KEYBIND =====
currentKey = Enum.KeyCode.LeftAlt
listening = false

function setListening(state)
	listening = state
	if state then
		SettingsKeybindBtn.Text = "BIND: ..."
		SettingsKeybindBtn.TextColor3 = Color3.fromRGB(255,255,255)
	end
end

SettingsKeybindBtn.MouseButton1Click:Connect(function()
	setListening(true)
end)

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

-- ===== UNLOAD =====
UnloadBtn.MouseButton1Click:Connect(function()
	stopClassicFly()
	setNoclip(false)
	setInfiniteJump(false)
	setEsp(false)
	setCrosshair(false)
	if antiAfkEnabled then toggleAntiAfk() end
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

-- Respawn
LocalPlayer.CharacterAdded:Connect(function(char)
	stopClassicFly()
	if noclipEnabled then setNoclip(false) end
	wait(0.5)
	local hum = char:FindFirstChild("Humanoid")
	if hum then
		hum.WalkSpeed = walkSpeedValue
		hum.JumpPower = jumpHeightValue
	end
end)

print("BUNBUN HUB geladen - alleen TP, geen Fling.")
