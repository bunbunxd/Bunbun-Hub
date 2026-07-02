-- [[ BUNBUN HUB - ALLEEN TP ]] --

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
    Instance.new("UICorner", obj).CornerRadius = UDim.new(0, radius or 6)
end
function setStrokeColor(obj, color)
    local s = obj:FindFirstChildOfClass("UIStroke")
    if s then s.Color = color end
end

-- ========== LAAD SCHERM ==========
LoadingGui = Instance.new("ScreenGui", ScreenGui.Parent)
LoadingGui.ResetOnSpawn = false

LoadingFrame = Instance.new("Frame", LoadingGui)
LoadingFrame.BackgroundColor3 = bgDark
LoadingFrame.Position = UDim2.new(0.5, -280, 0.25, -205)
LoadingFrame.Size = UDim2.new(0, 560, 0, 410)
addOutline(LoadingFrame, accentColor, 1)
addCorner(LoadingFrame, 8)

local loadDrag, loadDragStart, loadStartPos, loadDragInput
local function clampFramePosition(frame)
    local pos = frame.Position
    local size = frame.AbsoluteSize
    local screen = workspace.CurrentCamera.ViewportSize
    local minX = -size.X + 50
    local minY = -size.Y + 50
    local maxX = screen.X - 50
    local maxY = screen.Y - 50
    local x = math.clamp(pos.X.Offset + pos.X.Scale * screen.X, minX, maxX)
    local y = math.clamp(pos.Y.Offset + pos.Y.Scale * screen.Y, minY, maxY)
    frame.Position = UDim2.new(0, x, 0, y)
end
local function loadUpdate(input)
    local delta = input.Position - loadDragStart
    LoadingFrame.Position = UDim2.new(loadStartPos.X.Scale, loadStartPos.X.Offset + delta.X, loadStartPos.Y.Scale, loadStartPos.Y.Offset + delta.Y)
    clampFramePosition(LoadingFrame)
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

local ascii = Instance.new("TextLabel", LoadingFrame)
ascii.BackgroundTransparency = 1
ascii.Position = UDim2.new(0, 0, 0, 30)
ascii.Size = UDim2.new(1, 0, 0, 120)
ascii.Font = Enum.Font.RobotoMono
ascii.Text = " _                 _\n| |__  _   _ _ __ | |__  _   _ _ __\n| '_ \\| | | | '_ \\| '_ \\| | | | '_ \\\n| |_) | |_| | | | | |_) | |_| | | | |\n|_.__/ \\__,_|_| |_|_.__/ \\__,_|_| |_|"
ascii.TextColor3 = accentColor
ascii.TextSize = 11
ascii.TextXAlignment = Enum.TextXAlignment.Center
ascii.RichText = false

local author = Instance.new("TextLabel", LoadingFrame)
author.BackgroundTransparency = 1
author.Position = UDim2.new(0, 0, 0, 155)
author.Size = UDim2.new(1, 0, 0, 20)
author.Font = Enum.Font.RobotoMono
author.Text = "made by BununXD"
author.TextColor3 = Color3.fromRGB(160,160,160)
author.TextSize = 11
author.TextXAlignment = Enum.TextXAlignment.Center
author.RichText = false

local loadText = Instance.new("TextLabel", LoadingFrame)
loadText.BackgroundTransparency = 1
loadText.Position = UDim2.new(0, 20, 0, 220)
loadText.Size = UDim2.new(1, -40, 0, 20)
loadText.Font = Enum.Font.RobotoMono
loadText.Text = "loading bunbun hub"
loadText.TextColor3 = Color3.fromRGB(160,160,160)
loadText.TextSize = 12
loadText.TextXAlignment = Enum.TextXAlignment.Center
loadText.RichText = false

local barBg = Instance.new("Frame", LoadingFrame)
barBg.BackgroundColor3 = Color3.fromRGB(30,30,35)
barBg.Position = UDim2.new(0, 40, 0, 260)
barBg.Size = UDim2.new(1, -80, 0, 8)
addCorner(barBg, 4)
addOutline(barBg, Color3.fromRGB(45,45,50), 1)

local bar = Instance.new("Frame", barBg)
bar.BackgroundColor3 = accentColor
bar.Size = UDim2.new(0, 0, 1, 0)
addCorner(bar, 4)

for i = 0, 100 do
    bar.Size = UDim2.new(i/100, 0, 1, 0)
    wait(0.03)
end
wait(0.5)

-- Positie onthouden en laden
local loadFinalPos = LoadingFrame.Position
LoadingGui:Destroy()

-- ========== HOOFD GUI ==========
MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = bgDark
MainFrame.Position = loadFinalPos
MainFrame.Size = UDim2.new(0, 560, 0, 410)
MainFrame.Active = true
addOutline(MainFrame, accentColor, 1)
addCorner(MainFrame, 8)

local dragging, dragInput, dragStart, startPos
local function mainUpdate(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    clampFramePosition(MainFrame)
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
    if input == dragInput and dragging then mainUpdate(input) end
end)

local TooltipLabel = Instance.new("TextLabel", ScreenGui)
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
Instance.new("UIPadding", TooltipLabel).PaddingLeft = UDim.new(0,8)

local LeftPanel = Instance.new("Frame", MainFrame)
LeftPanel.BackgroundColor3 = bgPanel
LeftPanel.Size = UDim2.new(0, 145, 1, 0)
addOutline(LeftPanel, Color3.fromRGB(35,35,40), 1)
addCorner(LeftPanel, 8)

local BunIcon = Instance.new("ImageLabel", LeftPanel)
BunIcon.BackgroundTransparency = 1
BunIcon.Position = UDim2.new(0, 8, 0, 10)
BunIcon.Size = UDim2.new(0, 22, 0, 28)
BunIcon.Image = "rbxassetid://14578474740"
BunIcon.ScaleType = Enum.ScaleType.Fit

local Title = Instance.new("TextLabel", LeftPanel)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 34, 0, 13)
Title.Size = UDim2.new(1, -38, 0, 28)
Title.Font = Enum.Font.RobotoMono
Title.Text = "> BUNBUN"
Title.TextColor3 = accentColor
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.RichText = false

local TabContainer = Instance.new("Frame", LeftPanel)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 58)
TabContainer.Size = UDim2.new(1, -20, 0, 290)

local HomeTabBtn = Instance.new("TextButton")
local PlayerTabBtn = Instance.new("TextButton")
local MiscTabBtn = Instance.new("TextButton")
local SettingsTabBtn = Instance.new("TextButton")
local EspTabBtn = Instance.new("TextButton")
local AimTabBtn = Instance.new("TextButton")

local function styleTabBtn(btn, text, pos)
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

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 157, 0, 14)
ContentContainer.Size = UDim2.new(1, -171, 1, -28)

-- ========== HOME ==========
local HomeFrame = Instance.new("Frame", ContentContainer)
HomeFrame.BackgroundTransparency = 1
HomeFrame.Size = UDim2.new(1,0,1,0)
HomeFrame.Visible = true

local HomeScroll = Instance.new("ScrollingFrame", HomeFrame)
HomeScroll.BackgroundTransparency = 1
HomeScroll.Size = UDim2.new(1,0,1,0)
HomeScroll.CanvasSize = UDim2.new(0,0,0,500)
HomeScroll.ScrollBarThickness = 3
HomeScroll.ScrollBarImageColor3 = accentColor

local homeAscii = Instance.new("TextLabel", HomeScroll)
homeAscii.BackgroundTransparency = 1
homeAscii.Position = UDim2.new(0,0,0,10)
homeAscii.Size = UDim2.new(1,0,0,120)
homeAscii.Font = Enum.Font.RobotoMono
homeAscii.Text = ascii.Text
homeAscii.TextColor3 = accentColor
homeAscii.TextSize = 11
homeAscii.TextXAlignment = Enum.TextXAlignment.Center
homeAscii.RichText = false

local homeAuthor = Instance.new("TextLabel", HomeScroll)
homeAuthor.BackgroundTransparency = 1
homeAuthor.Position = UDim2.new(0,0,0,135)
homeAuthor.Size = UDim2.new(1,0,0,20)
homeAuthor.Font = Enum.Font.RobotoMono
homeAuthor.Text = "made by BununXD"
homeAuthor.TextColor3 = Color3.fromRGB(160,160,160)
homeAuthor.TextSize = 11
homeAuthor.TextXAlignment = Enum.TextXAlignment.Center
homeAuthor.RichText = false

local divider = Instance.new("Frame", HomeScroll)
divider.BackgroundColor3 = Color3.fromRGB(40,40,45)
divider.Position = UDim2.new(0,15,0,165)
divider.Size = UDim2.new(1,-30,0,1)

local infoLabel = Instance.new("TextLabel", HomeScroll)
infoLabel.BackgroundTransparency = 1
infoLabel.Position = UDim2.new(0,0,0,180)
infoLabel.Size = UDim2.new(1,0,0,20)
infoLabel.Font = Enum.Font.RobotoMono
infoLabel.Text = "// PLAYER INFO"
infoLabel.TextColor3 = Color3.fromRGB(120,120,120)
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.RichText = false

local AvatarFrame = Instance.new("Frame", HomeScroll)
AvatarFrame.BackgroundColor3 = bgMid
AvatarFrame.Position = UDim2.new(0,10,0,210)
AvatarFrame.Size = UDim2.new(1,-20,0,120)
addOutline(AvatarFrame, Color3.fromRGB(30,30,35), 1)
addCorner(AvatarFrame, 6)

local AvatarImage = Instance.new("ImageLabel", AvatarFrame)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30,30,35)
AvatarImage.Position = UDim2.new(0,10,0,10)
AvatarImage.Size = UDim2.new(0,100,0,100)
AvatarImage.ScaleType = Enum.ScaleType.Fit
addCorner(AvatarImage, 6)

local function loadAvatar()
    local success, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    AvatarImage.Image = (success and thumb) or "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&width=420&height=420"
end
loadAvatar()

local displayLabel = Instance.new("TextLabel", AvatarFrame)
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

local userLabel = Instance.new("TextLabel", AvatarFrame)
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

local idLabel = Instance.new("TextLabel", AvatarFrame)
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
local PlayerScroll = Instance.new("ScrollingFrame", ContentContainer)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.Size = UDim2.new(1,0,1,0)
PlayerScroll.CanvasSize = UDim2.new(0,0,0,630)
PlayerScroll.ScrollBarThickness = 3
PlayerScroll.ScrollBarImageColor3 = accentColor
PlayerScroll.Visible = false

local function createPage(name)
    local f = Instance.new("Frame", ContentContainer)
    f.Name = name
    f.BackgroundTransparency = 1
    f.Size = UDim2.new(1,0,1,0)
    f.Visible = false
    return f
end
local MiscFrame = createPage("MiscFrame")
local SettingsFrame = createPage("SettingsFrame")
local EspFrame = createPage("EspFrame")
local AimFrame = createPage("AimFrame")

-- FLY BUTTON
local FlyButton = Instance.new("TextButton", PlayerScroll)
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
local SpeedFrame = Instance.new("Frame", PlayerScroll)
SpeedFrame.BackgroundColor3 = bgMid
SpeedFrame.Position = UDim2.new(0,0,0,70)
SpeedFrame.Size = UDim2.new(1,0,0,85)
addOutline(SpeedFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SpeedFrame, 6)

local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0,12,0,8)
SpeedLabel.Size = UDim2.new(1,-24,0,20)
SpeedLabel.Font = Enum.Font.RobotoMono
SpeedLabel.Text = "> SELECT FLY SPEED:"
SpeedLabel.TextColor3 = Color3.fromRGB(160,160,160)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.RichText = false

local Mode1Btn, Mode2Btn, Mode3Btn = Instance.new("TextButton"), Instance.new("TextButton"), Instance.new("TextButton")
local function styleOptionBtn(btn, parent, text, pos, size)
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
local StyleFrame = Instance.new("Frame", PlayerScroll)
StyleFrame.BackgroundColor3 = bgMid
StyleFrame.Position = UDim2.new(0,0,0,170)
StyleFrame.Size = UDim2.new(1,0,0,85)
addOutline(StyleFrame, Color3.fromRGB(30,30,35), 1)
addCorner(StyleFrame, 6)

local StyleLabel = Instance.new("TextLabel", StyleFrame)
StyleLabel.BackgroundTransparency = 1
StyleLabel.Position = UDim2.new(0,12,0,8)
StyleLabel.Size = UDim2.new(1,-24,0,20)
StyleLabel.Font = Enum.Font.RobotoMono
StyleLabel.Text = "> SELECT FLY STYLE:"
StyleLabel.TextColor3 = Color3.fromRGB(160,160,160)
StyleLabel.TextSize = 12
StyleLabel.TextXAlignment = Enum.TextXAlignment.Left
StyleLabel.RichText = false

local NormalStyleBtn = Instance.new("TextButton")
styleOptionBtn(NormalStyleBtn, StyleFrame, "NORMAL", UDim2.new(0.04,0,0,38), UDim2.new(0.44,0,0,35))

local SupermanStyleBtn = Instance.new("TextButton", StyleFrame)
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
SupermanStyleBtn.MouseLeave:Connect(function() TooltipLabel.Visible = false end)

-- Speed slider
local SpeedSliderFrame = Instance.new("Frame", PlayerScroll)
SpeedSliderFrame.BackgroundColor3 = bgMid
SpeedSliderFrame.Position = UDim2.new(0,0,0,270)
SpeedSliderFrame.Size = UDim2.new(1,0,0,75)
addOutline(SpeedSliderFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SpeedSliderFrame, 6)

local SpeedSliderLabel = Instance.new("TextLabel", SpeedSliderFrame)
SpeedSliderLabel.BackgroundTransparency = 1
SpeedSliderLabel.Position = UDim2.new(0,12,0,8)
SpeedSliderLabel.Size = UDim2.new(0.7,0,0,20)
SpeedSliderLabel.Font = Enum.Font.RobotoMono
SpeedSliderLabel.Text = "> PLAYER SPEED:"
SpeedSliderLabel.TextColor3 = Color3.fromRGB(160,160,160)
SpeedSliderLabel.TextSize = 12
SpeedSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedSliderLabel.RichText = false

local SpeedValueLabel = Instance.new("TextLabel", SpeedSliderFrame)
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.Position = UDim2.new(0.75,0,0,8)
SpeedValueLabel.Size = UDim2.new(0.22,0,0,20)
SpeedValueLabel.Font = Enum.Font.RobotoMono
SpeedValueLabel.Text = "16"
SpeedValueLabel.TextColor3 = accentColor
SpeedValueLabel.TextSize = 12
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Right
SpeedValueLabel.RichText = false

local SpeedSliderTrack = Instance.new("Frame", SpeedSliderFrame)
SpeedSliderTrack.BackgroundColor3 = Color3.fromRGB(30,30,35)
SpeedSliderTrack.Position = UDim2.new(0,12,0,44)
SpeedSliderTrack.Size = UDim2.new(1,-24,0,6)
addCorner(SpeedSliderTrack, 3)

local SpeedSliderFill = Instance.new("Frame", SpeedSliderTrack)
SpeedSliderFill.BackgroundColor3 = accentColor
SpeedSliderFill.Size = UDim2.new(0.1,0,1,0)
addCorner(SpeedSliderFill, 3)

local SpeedSliderKnob = Instance.new("TextButton", SpeedSliderTrack)
SpeedSliderKnob.BackgroundColor3 = Color3.fromRGB(220,220,220)
SpeedSliderKnob.Position = UDim2.new(0.1, -6, 0.5, -6)
SpeedSliderKnob.Size = UDim2.new(0,12,0,12)
SpeedSliderKnob.Text = ""
SpeedSliderKnob.RichText = false
addCorner(SpeedSliderKnob, 6)
addOutline(SpeedSliderKnob, accentColor, 1)

-- Jump slider
local JumpSliderFrame = Instance.new("Frame", PlayerScroll)
JumpSliderFrame.BackgroundColor3 = bgMid
JumpSliderFrame.Position = UDim2.new(0,0,0,360)
JumpSliderFrame.Size = UDim2.new(1,0,0,75)
addOutline(JumpSliderFrame, Color3.fromRGB(30,30,35), 1)
addCorner(JumpSliderFrame, 6)

local JumpSliderLabel = Instance.new("TextLabel", JumpSliderFrame)
JumpSliderLabel.BackgroundTransparency = 1
JumpSliderLabel.Position = UDim2.new(0,12,0,8)
JumpSliderLabel.Size = UDim2.new(0.7,0,0,20)
JumpSliderLabel.Font = Enum.Font.RobotoMono
JumpSliderLabel.Text = "> PLAYER JUMPHEIGHT:"
JumpSliderLabel.TextColor3 = Color3.fromRGB(160,160,160)
JumpSliderLabel.TextSize = 12
JumpSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpSliderLabel.RichText = false

local JumpValueLabel = Instance.new("TextLabel", JumpSliderFrame)
JumpValueLabel.BackgroundTransparency = 1
JumpValueLabel.Position = UDim2.new(0.75,0,0,8)
JumpValueLabel.Size = UDim2.new(0.22,0,0,20)
JumpValueLabel.Font = Enum.Font.RobotoMono
JumpValueLabel.Text = "50"
JumpValueLabel.TextColor3 = accentColor
JumpValueLabel.TextSize = 12
JumpValueLabel.TextXAlignment = Enum.TextXAlignment.Right
JumpValueLabel.RichText = false

local JumpSliderTrack = Instance.new("Frame", JumpSliderFrame)
JumpSliderTrack.BackgroundColor3 = Color3.fromRGB(30,30,35)
JumpSliderTrack.Position = UDim2.new(0,12,0,44)
JumpSliderTrack.Size = UDim2.new(1,-24,0,6)
addCorner(JumpSliderTrack, 3)

local JumpSliderFill = Instance.new("Frame", JumpSliderTrack)
JumpSliderFill.BackgroundColor3 = accentColor
JumpSliderFill.Size = UDim2.new(0.5,0,1,0)
addCorner(JumpSliderFill, 3)

local JumpSliderKnob = Instance.new("TextButton", JumpSliderTrack)
JumpSliderKnob.BackgroundColor3 = Color3.fromRGB(220,220,220)
JumpSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6)
JumpSliderKnob.Size = UDim2.new(0,12,0,12)
JumpSliderKnob.Text = ""
JumpSliderKnob.RichText = false
addCorner(JumpSliderKnob, 6)
addOutline(JumpSliderKnob, accentColor, 1)

-- RESET KNOP
local ResetSpeedBtn = Instance.new("TextButton", PlayerScroll)
ResetSpeedBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
ResetSpeedBtn.Position = UDim2.new(0,0,0,450)
ResetSpeedBtn.Size = UDim2.new(1,0,0,34)
ResetSpeedBtn.Font = Enum.Font.RobotoMono
ResetSpeedBtn.Text = "// RESET SPEED & JUMP"
ResetSpeedBtn.TextColor3 = accentColor
ResetSpeedBtn.TextSize = 12
ResetSpeedBtn.RichText = false
addOutline(ResetSpeedBtn, Color3.fromRGB(40,40,45), 1)
addCorner(ResetSpeedBtn, 6)

-- Infinite jump
local InfiniteJumpButton = Instance.new("TextButton", PlayerScroll)
InfiniteJumpButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
InfiniteJumpButton.Position = UDim2.new(0,0,0,500)
InfiniteJumpButton.Size = UDim2.new(1,0,0,45)
InfiniteJumpButton.Font = Enum.Font.RobotoMono
InfiniteJumpButton.Text = "// INFINITE JUMP: OFF"
InfiniteJumpButton.TextColor3 = accentColor
InfiniteJumpButton.TextSize = 14
InfiniteJumpButton.RichText = false
addOutline(InfiniteJumpButton, Color3.fromRGB(40,40,45), 1)
addCorner(InfiniteJumpButton, 6)

-- Noclip
local NoclipButton = Instance.new("TextButton", PlayerScroll)
NoclipButton.BackgroundColor3 = Color3.fromRGB(18,18,22)
NoclipButton.Position = UDim2.new(0,0,0,560)
NoclipButton.Size = UDim2.new(1,0,0,45)
NoclipButton.Font = Enum.Font.RobotoMono
NoclipButton.Text = "// TOGGLE NOCLIP: OFF"
NoclipButton.TextColor3 = accentColor
NoclipButton.TextSize = 14
NoclipButton.RichText = false
addOutline(NoclipButton, Color3.fromRGB(40,40,45), 1)
addCorner(NoclipButton, 6)

-- ========== MISC ==========
local MiscScroll = Instance.new("ScrollingFrame", MiscFrame)
MiscScroll.BackgroundTransparency = 1
MiscScroll.Size = UDim2.new(1,0,1,0)
MiscScroll.CanvasSize = UDim2.new(0,0,0,500)
MiscScroll.ScrollBarThickness = 3
MiscScroll.ScrollBarImageColor3 = accentColor

local MiscLabel = Instance.new("TextLabel", MiscScroll)
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
local TpBtn = Instance.new("TextButton", MiscScroll)
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

local TpListFrame = Instance.new("ScrollingFrame", MiscScroll)
TpListFrame.BackgroundColor3 = bgMid
TpListFrame.Position = UDim2.new(0,0,0,84)
TpListFrame.Size = UDim2.new(1,0,0,0)
TpListFrame.ScrollBarThickness = 4
TpListFrame.ScrollBarImageColor3 = accentColor
TpListFrame.Visible = false
TpListFrame.CanvasSize = UDim2.new(0,0,0,0)
addOutline(TpListFrame, Color3.fromRGB(30,30,35), 1)
addCorner(TpListFrame, 6)

local TpListLayout = Instance.new("UIListLayout", TpListFrame)
TpListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TpListLayout.Padding = UDim.new(0,4)

local TpListPadding = Instance.new("UIPadding", TpListFrame)
TpListPadding.PaddingTop = UDim.new(0,6)
TpListPadding.PaddingLeft = UDim.new(0,6)
TpListPadding.PaddingRight = UDim.new(0,6)

-- CHAT
local SendChatLabel = Instance.new("TextLabel", MiscScroll)
SendChatLabel.BackgroundTransparency = 1
SendChatLabel.Position = UDim2.new(0,0,0,130)
SendChatLabel.Size = UDim2.new(1,0,0,16)
SendChatLabel.Font = Enum.Font.RobotoMono
SendChatLabel.Text = "> SEND CUSTOM CHAT:"
SendChatLabel.TextColor3 = Color3.fromRGB(160,160,160)
SendChatLabel.TextSize = 11
SendChatLabel.TextXAlignment = Enum.TextXAlignment.Left
SendChatLabel.RichText = false

local ChatInputFrame = Instance.new("Frame", MiscScroll)
ChatInputFrame.BackgroundColor3 = bgMid
ChatInputFrame.Position = UDim2.new(0,0,0,152)
ChatInputFrame.Size = UDim2.new(1,0,0,45)
addOutline(ChatInputFrame, Color3.fromRGB(30,30,35), 1)
addCorner(ChatInputFrame, 6)

local ChatTextBox = Instance.new("TextBox", ChatInputFrame)
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

local SendChatBtn = Instance.new("TextButton", MiscScroll)
SendChatBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
SendChatBtn.Position = UDim2.new(0,0,0,205)
SendChatBtn.Size = UDim2.new(1,0,0,38)
SendChatBtn.Font = Enum.Font.RobotoMono
SendChatBtn.Text = "// SEND CHAT"
SendChatBtn.TextColor3 = accentColor
SendChatBtn.TextSize = 13
SendChatBtn.RichText = false
addOutline(SendChatBtn, Color3.fromRGB(40,40,45), 1)
addCorner(SendChatBtn, 6)

local function updateMiscLayout()
    local tpOpen = TpListFrame.Visible
    local tpHeight = tpOpen and 150 or 0
    TpListFrame.Size = UDim2.new(1,0,0,tpHeight)
    TpListFrame.CanvasSize = UDim2.new(0,0,0, tpOpen and math.min(#Players:GetPlayers()*38+16, 150) or 0)
    local chatY = 84 + tpHeight + 14
    SendChatLabel.Position = UDim2.new(0,0,0, chatY)
    ChatInputFrame.Position = UDim2.new(0,0,0, chatY + 22)
    SendChatBtn.Position = UDim2.new(0,0,0, chatY + 22 + 53)
    MiscScroll.CanvasSize = UDim2.new(0,0,0, chatY + 22 + 53 + 30)
end

local function buildTpList()
    for _, c in ipairs(TpListFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
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
    updateMiscLayout()
end

Players.PlayerAdded:Connect(function() if TpListFrame.Visible then buildTpList() end end)
Players.PlayerRemoving:Connect(function() if TpListFrame.Visible then buildTpList() end end)

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
        LocalPlayer:Chat(msg)
    end)
    if not success then
        pcall(function()
            local channel = game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral")
            if channel then channel:SendAsync(msg) end
        end)
    end
end)

updateMiscLayout()

-- ========== ESP ==========
local EspScroll = Instance.new("ScrollingFrame", EspFrame)
EspScroll.BackgroundTransparency = 1
EspScroll.Size = UDim2.new(1,0,1,0)
EspScroll.CanvasSize = UDim2.new(0,0,0,300)
EspScroll.ScrollBarThickness = 3
EspScroll.ScrollBarImageColor3 = accentColor

local EspLabel = Instance.new("TextLabel", EspScroll)
EspLabel.BackgroundTransparency = 1
EspLabel.Position = UDim2.new(0,0,0,10)
EspLabel.Size = UDim2.new(1,0,0,20)
EspLabel.Font = Enum.Font.RobotoMono
EspLabel.Text = "// ESP"
EspLabel.TextColor3 = Color3.fromRGB(120,120,120)
EspLabel.TextSize = 13
EspLabel.TextXAlignment = Enum.TextXAlignment.Left
EspLabel.RichText = false

local EspButton = Instance.new("TextButton", EspScroll)
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

local EspBoxButton = Instance.new("TextButton", EspScroll)
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

local EspNameButton = Instance.new("TextButton", EspScroll)
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

local EspDistButton = Instance.new("TextButton", EspScroll)
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

local EspHealthButton = Instance.new("TextButton", EspScroll)
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

-- ESP functionaliteit
local espEnabled, espBoxEnabled, espNameEnabled, espDistEnabled, espHealthEnabled = false, false, false, false, false
local espObjects = {}
local espConnections = {}
local espUpdateConnection

local function removeEspForPlayer(plrName)
    local data = espObjects[plrName]
    if data then
        if data.highlight then pcall(function() data.highlight:Destroy() end) end
        if data.box then pcall(function() data.box:Destroy() end) end
        if data.bill then pcall(function() data.bill:Destroy() end) end
        espObjects[plrName] = nil
    end
    if espConnections[plrName] then
        pcall(function() espConnections[plrName]:Disconnect() end)
        espConnections[plrName] = nil
    end
end

local function clearAllEsp()
    for plrName, _ in pairs(espObjects) do removeEspForPlayer(plrName) end
    for plrName, _ in pairs(espConnections) do
        pcall(function() espConnections[plrName]:Disconnect() end)
        espConnections[plrName] = nil
    end
    espObjects = {}
    espConnections = {}
end

local function updateEspForPlayer(plr)
    if plr == LocalPlayer then return end
    removeEspForPlayer(plr.Name)
    if not espEnabled then return end

    local char = plr.Character
    if not char then return end

    local data = {}
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChild("Humanoid")

    local h = Instance.new("Highlight", char)
    h.FillTransparency = 1
    h.OutlineColor = accentColor
    h.OutlineTransparency = 0
    data.highlight = h

    if espBoxEnabled then
        local box = Instance.new("SelectionBox", char)
        box.Color3 = accentColor
        box.Transparency = 0
        box.LineThickness = 0.1
        data.box = box
    end

    if espNameEnabled or espDistEnabled or espHealthEnabled then
        local bill = Instance.new("BillboardGui")
        bill.Parent = head or char
        bill.Adornee = head or char
        bill.Size = UDim2.new(0, 180, 0, 70)
        bill.StudsOffset = Vector3.new(0, 2, 0)
        bill.AlwaysOnTop = true

        local mainFrame = Instance.new("Frame", bill)
        mainFrame.Size = UDim2.new(1,0,1,0)
        mainFrame.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", mainFrame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,1)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.VerticalAlignment = Enum.VerticalAlignment.Top

        if espNameEnabled then
            local nameLabel = Instance.new("TextLabel", mainFrame)
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

        if espDistEnabled then
            local distLabel = Instance.new("TextLabel", mainFrame)
            distLabel.Size = UDim2.new(1,0,0,16)
            distLabel.BackgroundTransparency = 1
            distLabel.Font = Enum.Font.RobotoMono
            distLabel.TextColor3 = Color3.fromRGB(200,200,255)
            distLabel.TextSize = 14
            distLabel.TextStrokeTransparency = 0.3
            distLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            distLabel.TextScaled = true
            distLabel.Text = "0m"
            data.distLabel = distLabel
        end

        if espHealthEnabled and hum then
            local healthFrame = Instance.new("Frame", mainFrame)
            healthFrame.Size = UDim2.new(0.4, 0, 0, 4)
            healthFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
            healthFrame.BorderSizePixel = 0
            local healthFill = Instance.new("Frame", healthFrame)
            healthFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
            healthFill.BorderSizePixel = 0
            healthFill.Size = UDim2.new(hum.Health/hum.MaxHealth,0,1,0)
            data.healthFill = healthFill
        end

        data.bill = bill
    end

    espObjects[plr.Name] = data

    local conn = plr.CharacterAdded:Connect(function()
        wait(0.5)
        if espEnabled then updateEspForPlayer(plr) end
    end)
    espConnections[plr.Name] = conn
end

local function updateEspDynamic()
    for plrName, data in pairs(espObjects) do
        if data.distLabel then
            local plr = Players:FindFirstChild(plrName)
            if not plr then continue end
            local char = plr.Character
            if not char then continue end
            local root = char:FindFirstChild("HumanoidRootPart")
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root and myRoot then
                local dist = math.floor((root.Position - myRoot.Position).Magnitude)
                data.distLabel.Text = dist .. "m"
            else
                data.distLabel.Text = "?m"
            end
        end
        if data.healthFill then
            local plr = Players:FindFirstChild(plrName)
            if not plr then continue end
            local char = plr.Character
            if not char then continue end
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                local ratio = math.clamp(hum.Health/hum.MaxHealth, 0, 1)
                data.healthFill.Size = UDim2.new(ratio,0,1,0)
                data.healthFill.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
            end
        end
    end
end

local function refreshAllEsp()
    clearAllEsp()
    if espEnabled then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then updateEspForPlayer(plr) end
        end
        if not espUpdateConnection then
            espUpdateConnection = RunService.RenderStepped:Connect(updateEspDynamic)
        end
    else
        if espUpdateConnection then
            espUpdateConnection:Disconnect()
            espUpdateConnection = nil
        end
    end
end

local function setEsp(enabled)
    espEnabled = enabled
    if enabled then
        EspButton.Text = "// ESP: ON"
        EspButton.TextColor3 = Color3.fromRGB(50,255,50)
        setStrokeColor(EspButton, Color3.fromRGB(50,255,50))
    else
        EspButton.Text = "// ESP: OFF"
        EspButton.TextColor3 = accentColor
        setStrokeColor(EspButton, Color3.fromRGB(40,40,45))
    end
    refreshAllEsp()
end

local function updateEspOptionButton(btn, label, value)
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
EspButton.MouseButton1Click:Connect(function() setEsp(not espEnabled) end)
Players.PlayerRemoving:Connect(function(plr) removeEspForPlayer(plr.Name) end)

-- ========== AIM ==========
local AimScroll = Instance.new("ScrollingFrame", AimFrame)
AimScroll.BackgroundTransparency = 1
AimScroll.Size = UDim2.new(1,0,1,0)
AimScroll.CanvasSize = UDim2.new(0,0,0,500)
AimScroll.ScrollBarThickness = 3
AimScroll.ScrollBarImageColor3 = accentColor

local AimLabel = Instance.new("TextLabel", AimScroll)
AimLabel.BackgroundTransparency = 1
AimLabel.Position = UDim2.new(0,0,0,10)
AimLabel.Size = UDim2.new(1,0,0,20)
AimLabel.Font = Enum.Font.RobotoMono
AimLabel.Text = "// AIM"
AimLabel.TextColor3 = Color3.fromRGB(120,120,120)
AimLabel.TextSize = 13
AimLabel.TextXAlignment = Enum.TextXAlignment.Left
AimLabel.RichText = false

local CrosshairButton = Instance.new("TextButton", AimScroll)
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

local CrosshairConfigFrame = Instance.new("Frame", AimScroll)
CrosshairConfigFrame.BackgroundTransparency = 1
CrosshairConfigFrame.Position = UDim2.new(0,0,0,98)
CrosshairConfigFrame.Size = UDim2.new(1,0,0,350)
CrosshairConfigFrame.Visible = false

-- Style
local StyleLabel2 = Instance.new("TextLabel", CrosshairConfigFrame)
StyleLabel2.BackgroundTransparency = 1
StyleLabel2.Position = UDim2.new(0,0,0,0)
StyleLabel2.Size = UDim2.new(1,0,0,20)
StyleLabel2.Font = Enum.Font.RobotoMono
StyleLabel2.Text = "> STYLE:"
StyleLabel2.TextColor3 = Color3.fromRGB(160,160,160)
StyleLabel2.TextSize = 12
StyleLabel2.TextXAlignment = Enum.TextXAlignment.Left
StyleLabel2.RichText = false

local StyleCrossBtn = Instance.new("TextButton", CrosshairConfigFrame)
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

local StyleDotBtn = Instance.new("TextButton", CrosshairConfigFrame)
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

local StyleCircleBtn = Instance.new("TextButton", CrosshairConfigFrame)
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
local SizeFrame = Instance.new("Frame", CrosshairConfigFrame)
SizeFrame.BackgroundColor3 = bgMid
SizeFrame.Position = UDim2.new(0,0,0,80)
SizeFrame.Size = UDim2.new(1,0,0,40)
addOutline(SizeFrame, Color3.fromRGB(30,30,35), 1)
addCorner(SizeFrame, 6)

local SizeLabel = Instance.new("TextLabel", SizeFrame)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Position = UDim2.new(0,12,0,10)
SizeLabel.Size = UDim2.new(0.4,0,0,20)
SizeLabel.Font = Enum.Font.RobotoMono
SizeLabel.Text = "SIZE:"
SizeLabel.TextColor3 = Color3.fromRGB(160,160,160)
SizeLabel.TextSize = 12
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.RichText = false

local SizeBox = Instance.new("TextBox", SizeFrame)
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
local ThickFrame = Instance.new("Frame", CrosshairConfigFrame)
ThickFrame.BackgroundColor3 = bgMid
ThickFrame.Position = UDim2.new(0,0,0,135)
ThickFrame.Size = UDim2.new(1,0,0,40)
addOutline(ThickFrame, Color3.fromRGB(30,30,35), 1)
addCorner(ThickFrame, 6)

local ThickLabel = Instance.new("TextLabel", ThickFrame)
ThickLabel.BackgroundTransparency = 1
ThickLabel.Position = UDim2.new(0,12,0,10)
ThickLabel.Size = UDim2.new(0.4,0,0,20)
ThickLabel.Font = Enum.Font.RobotoMono
ThickLabel.Text = "THICKNESS:"
ThickLabel.TextColor3 = Color3.fromRGB(160,160,160)
ThickLabel.TextSize = 12
ThickLabel.TextXAlignment = Enum.TextXAlignment.Left
ThickLabel.RichText = false

local ThickBox = Instance.new("TextBox", ThickFrame)
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
local GapFrame = Instance.new("Frame", CrosshairConfigFrame)
GapFrame.BackgroundColor3 = bgMid
GapFrame.Position = UDim2.new(0,0,0,190)
GapFrame.Size = UDim2.new(1,0,0,40)
addOutline(GapFrame, Color3.fromRGB(30,30,35), 1)
addCorner(GapFrame, 6)

local GapLabel = Instance.new("TextLabel", GapFrame)
GapLabel.BackgroundTransparency = 1
GapLabel.Position = UDim2.new(0,12,0,10)
GapLabel.Size = UDim2.new(0.4,0,0,20)
GapLabel.Font = Enum.Font.RobotoMono
GapLabel.Text = "GAP:"
GapLabel.TextColor3 = Color3.fromRGB(160,160,160)
GapLabel.TextSize = 12
GapLabel.TextXAlignment = Enum.TextXAlignment.Left
GapLabel.RichText = false

local GapBox = Instance.new("TextBox", GapFrame)
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
local SettingsScroll = Instance.new("ScrollingFrame", SettingsFrame)
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.Size = UDim2.new(1,0,1,0)
SettingsScroll.CanvasSize = UDim2.new(0,0,0,480)
SettingsScroll.ScrollBarThickness = 3
SettingsScroll.ScrollBarImageColor3 = accentColor

local SettingsLabel = Instance.new("TextLabel", SettingsScroll)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0,0,0,10)
SettingsLabel.Size = UDim2.new(1,0,0,20)
SettingsLabel.Font = Enum.Font.RobotoMono
SettingsLabel.Text = "// SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(120,120,120)
SettingsLabel.TextSize = 13
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsLabel.RichText = false

local SettingsKeybindLabel = Instance.new("TextLabel", SettingsScroll)
SettingsKeybindLabel.BackgroundTransparency = 1
SettingsKeybindLabel.Position = UDim2.new(0,0,0,48)
SettingsKeybindLabel.Size = UDim2.new(1,0,0,16)
SettingsKeybindLabel.Font = Enum.Font.RobotoMono
SettingsKeybindLabel.Text = "> TOGGLE HOTKEY:"
SettingsKeybindLabel.TextColor3 = Color3.fromRGB(160,160,160)
SettingsKeybindLabel.TextSize = 11
SettingsKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsKeybindLabel.RichText = false

local SettingsKeybindBtn = Instance.new("TextButton", SettingsScroll)
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

local ColorLabel = Instance.new("TextLabel", SettingsScroll)
ColorLabel.BackgroundTransparency = 1
ColorLabel.Position = UDim2.new(0,0,0,114)
ColorLabel.Size = UDim2.new(1,0,0,16)
ColorLabel.Font = Enum.Font.RobotoMono
ColorLabel.Text = "> UI ACCENT COLOR:"
ColorLabel.TextColor3 = Color3.fromRGB(160,160,160)
ColorLabel.TextSize = 11
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.RichText = false

local colorOptions = {
    {name = "RED",    color = Color3.fromRGB(255,40,40)},
    {name = "BLUE",   color = Color3.fromRGB(40,120,255)},
    {name = "GREEN",  color = Color3.fromRGB(50,220,80)},
    {name = "PURPLE", color = Color3.fromRGB(160,60,255)},
    {name = "CYAN",   color = Color3.fromRGB(40,220,220)},
    {name = "WHITE",  color = Color3.fromRGB(220,220,220)},
}

local colorBtns = {}
for i, opt in ipairs(colorOptions) do
    local col = math.floor((i-1)%3)
    local row = math.floor((i-1)/3)
    local cb = Instance.new("TextButton", SettingsScroll)
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
local AntiAfkLabel = Instance.new("TextLabel", SettingsScroll)
AntiAfkLabel.BackgroundTransparency = 1
AntiAfkLabel.Position = UDim2.new(0,0,0,225)
AntiAfkLabel.Size = UDim2.new(1,0,0,16)
AntiAfkLabel.Font = Enum.Font.RobotoMono
AntiAfkLabel.Text = "> ANTI-AFK:"
AntiAfkLabel.TextColor3 = Color3.fromRGB(160,160,160)
AntiAfkLabel.TextSize = 11
AntiAfkLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAfkLabel.RichText = false

local AntiAfkBtn = Instance.new("TextButton", SettingsScroll)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
AntiAfkBtn.Position = UDim2.new(0,0,0,245)
AntiAfkBtn.Size = UDim2.new(1,0,0,34)
AntiAfkBtn.Font = Enum.Font.RobotoMono
AntiAfkBtn.Text = "ON"
AntiAfkBtn.TextColor3 = Color3.fromRGB(50,255,50)
AntiAfkBtn.TextSize = 12
AntiAfkBtn.RichText = false
addOutline(AntiAfkBtn, Color3.fromRGB(50,255,50), 1)
addCorner(AntiAfkBtn, 6)

-- Anti-Fling
local AntiFlingLabel = Instance.new("TextLabel", SettingsScroll)
AntiFlingLabel.BackgroundTransparency = 1
AntiFlingLabel.Position = UDim2.new(0,0,0,295)
AntiFlingLabel.Size = UDim2.new(1,0,0,16)
AntiFlingLabel.Font = Enum.Font.RobotoMono
AntiFlingLabel.Text = "> ANTI-FLING:"
AntiFlingLabel.TextColor3 = Color3.fromRGB(160,160,160)
AntiFlingLabel.TextSize = 11
AntiFlingLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiFlingLabel.RichText = false

local AntiFlingBtn = Instance.new("TextButton", SettingsScroll)
AntiFlingBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
AntiFlingBtn.Position = UDim2.new(0,0,0,315)
AntiFlingBtn.Size = UDim2.new(1,0,0,34)
AntiFlingBtn.Font = Enum.Font.RobotoMono
AntiFlingBtn.Text = "ON"
AntiFlingBtn.TextColor3 = Color3.fromRGB(50,255,50)
AntiFlingBtn.TextSize = 12
AntiFlingBtn.RichText = false
addOutline(AntiFlingBtn, Color3.fromRGB(50,255,50), 1)
addCorner(AntiFlingBtn, 6)

-- Server Hop
local ServerHopLabel = Instance.new("TextLabel", SettingsScroll)
ServerHopLabel.BackgroundTransparency = 1
ServerHopLabel.Position = UDim2.new(0,0,0,365)
ServerHopLabel.Size = UDim2.new(1,0,0,16)
ServerHopLabel.Font = Enum.Font.RobotoMono
ServerHopLabel.Text = "> SERVER HOP:"
ServerHopLabel.TextColor3 = Color3.fromRGB(160,160,160)
ServerHopLabel.TextSize = 11
ServerHopLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerHopLabel.RichText = false

local ServerHopBtn = Instance.new("TextButton", SettingsScroll)
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
ServerHopBtn.Position = UDim2.new(0,0,0,385)
ServerHopBtn.Size = UDim2.new(1,0,0,34)
ServerHopBtn.Font = Enum.Font.RobotoMono
ServerHopBtn.Text = "HOP SERVER"
ServerHopBtn.TextColor3 = accentColor
ServerHopBtn.TextSize = 12
ServerHopBtn.RichText = false
addOutline(ServerHopBtn, Color3.fromRGB(40,40,45), 1)
addCorner(ServerHopBtn, 6)

local UnloadBtn = Instance.new("TextButton", SettingsScroll)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
UnloadBtn.Position = UDim2.new(0,0,0,435)
UnloadBtn.Size = UDim2.new(1,0,0,45)
UnloadBtn.Font = Enum.Font.RobotoMono
UnloadBtn.Text = "// UNLOAD SCRIPT"
UnloadBtn.TextColor3 = accentColor
UnloadBtn.TextSize = 14
UnloadBtn.RichText = false
addOutline(UnloadBtn, Color3.fromRGB(40,40,45), 1)
addCorner(UnloadBtn, 6)

-- ===========================================================
-- ========== ALLE FUNCTIONALITEIT ===========================
-- ===========================================================

local walkSpeedValue = 16
local jumpHeightValue = 50
local noclipEnabled = false
local noclipConnections = {}
local infiniteJumpEnabled = false
local jumpConnection

-- Anti-AFK
local antiAfkEnabled = false
local antiAfkConnection
local antiAfkTimer = 0

-- Anti-Fling
local antiFlingEnabled = true
local antiFlingConnection

-- Fly
local flying = false
local flySpeed = 1.8
local flyStyle = "Normal"
local speeds = {Mode1 = 1.2, Mode2 = 2.8, Mode3 = 6.5}
local originalGravity = workspace.Gravity
local connectionFly
local flyAnimTrack
local currentMoveVector = Vector3.new(0,0,0)
local targetMoveVector = Vector3.new(0,0,0)

-- Crosshair
local crosshairEnabled = false
local crosshairStyle = "Cross"
local crosshairSize = 20
local crosshairThickness = 2
local crosshairGap = 6
local crosshairGui
local crosshairElements = {}

-- ===== SLIDERS =====
local function setupSlider(knob, track, fill, label, minVal, maxVal, default, callback)
    local draggingSlider = false
    local function update(xRatio)
        xRatio = math.clamp(xRatio, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * xRatio)
        label.Text = tostring(val)
        fill.Size = UDim2.new(xRatio, 0, 1, 0)
        knob.Position = UDim2.new(xRatio, -6, 0.5, -6)
        callback(val)
    end
    local currentRatio = (default - minVal) / (maxVal - minVal)
    update(currentRatio)
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
    return update
end

local updateSpeedSlider = setupSlider(SpeedSliderKnob, SpeedSliderTrack, SpeedSliderFill, SpeedValueLabel, 8, 150, 16, function(val)
    walkSpeedValue = val
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
end)

local updateJumpSlider = setupSlider(JumpSliderKnob, JumpSliderTrack, JumpSliderFill, JumpValueLabel, 7, 200, 50, function(val)
    jumpHeightValue = val
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.JumpPower = val end
    end
end)

-- Reset speed & jump
ResetSpeedBtn.MouseButton1Click:Connect(function()
    walkSpeedValue = 16
    jumpHeightValue = 50
    updateSpeedSlider((16-8)/(150-8))
    updateJumpSlider((50-7)/(200-7))
end)

-- ===== CROSSHAIR =====
local function createCrosshair()
    local gui = Instance.new("ScreenGui", ScreenGui.Parent)
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
        local function addArm(anchorX, anchorY, posX, posY, sizeX, sizeY)
            local arm = Instance.new("Frame", gui)
            arm.BackgroundColor3 = accentColor
            arm.BorderSizePixel = 0
            arm.Size = UDim2.new(0, sizeX, 0, sizeY)
            arm.AnchorPoint = Vector2.new(anchorX, anchorY)
            arm.Position = UDim2.new(0.5, posX, 0.5, posY)
            table.insert(elements, arm)
        end
        addArm(0.5, 0, 0, -gap/2 - armLen, thick, armLen)
        addArm(0.5, 1, 0,  gap/2 + armLen, thick, armLen)
        addArm(0, 0.5, -gap/2 - armLen, 0, armLen, thick)
        addArm(1, 0.5,  gap/2 + armLen, 0, armLen, thick)
    elseif crosshairStyle == "Dot" then
        local dot = Instance.new("Frame", gui)
        dot.BackgroundColor3 = accentColor
        dot.BorderSizePixel = 0
        dot.Size = UDim2.new(0, crosshairSize, 0, crosshairSize)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Position = UDim2.new(0.5, 0, 0.5, 0)
        addCorner(dot, crosshairSize/2)
        table.insert(elements, dot)
    elseif crosshairStyle == "Circle" then
        local circle = Instance.new("Frame", gui)
        circle.BackgroundTransparency = 1
        circle.Size = UDim2.new(0, crosshairSize, 0, crosshairSize)
        circle.AnchorPoint = Vector2.new(0.5, 0.5)
        circle.Position = UDim2.new(0.5, 0, 0.5, 0)
        local stroke = Instance.new("UIStroke", circle)
        stroke.Color = accentColor
        stroke.Thickness = crosshairThickness
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)
        table.insert(elements, circle)
    end
    return gui, elements
end

local function rebuildCrosshair()
    if crosshairGui then crosshairGui:Destroy(); crosshairGui = nil; crosshairElements = {} end
    if crosshairEnabled then crosshairGui, crosshairElements = createCrosshair() end
end

local function updateCrosshairFromBoxes()
    local s = tonumber(SizeBox.Text)
    local t = tonumber(ThickBox.Text)
    local g = tonumber(GapBox.Text)
    if s and s > 0 then crosshairSize = s end
    if t and t > 0 then crosshairThickness = t end
    if g and g >= 0 then crosshairGap = g end
    if crosshairEnabled then rebuildCrosshair() end
end

SizeBox.FocusLost:Connect(function(enter) if enter then updateCrosshairFromBoxes() end end)
ThickBox.FocusLost:Connect(function(enter) if enter then updateCrosshairFromBoxes() end end)
GapBox.FocusLost:Connect(function(enter) if enter then updateCrosshairFromBoxes() end end)

local function updateStyleVisuals()
    setStrokeColor(StyleCrossBtn, crosshairStyle == "Cross" and accentColor or Color3.fromRGB(45,45,50))
    setStrokeColor(StyleDotBtn, crosshairStyle == "Dot" and accentColor or Color3.fromRGB(45,45,50))
    setStrokeColor(StyleCircleBtn, crosshairStyle == "Circle" and accentColor or Color3.fromRGB(45,45,50))
end

StyleCrossBtn.MouseButton1Click:Connect(function()
    crosshairStyle = "Cross"; updateStyleVisuals()
    if crosshairEnabled then rebuildCrosshair() end
end)
StyleDotBtn.MouseButton1Click:Connect(function()
    crosshairStyle = "Dot"; updateStyleVisuals()
    if crosshairEnabled then rebuildCrosshair() end
end)
StyleCircleBtn.MouseButton1Click:Connect(function()
    crosshairStyle = "Circle"; updateStyleVisuals()
    if crosshairEnabled then rebuildCrosshair() end
end)

local function setCrosshair(enabled)
    crosshairEnabled = enabled
    if enabled then
        CrosshairButton.Text = "// CROSSHAIR: ON"
        CrosshairButton.TextColor3 = Color3.fromRGB(50,255,50)
        setStrokeColor(CrosshairButton, Color3.fromRGB(50,255,50))
        CrosshairConfigFrame.Visible = true
    else
        CrosshairButton.Text = "// CROSSHAIR: OFF"
        CrosshairButton.TextColor3 = accentColor
        setStrokeColor(CrosshairButton, Color3.fromRGB(40,40,45))
        CrosshairConfigFrame.Visible = false
    end
    rebuildCrosshair()
end

CrosshairButton.MouseButton1Click:Connect(function() setCrosshair(not crosshairEnabled) end)
updateStyleVisuals()

-- ===== ANTI-AFK =====
local function setAntiAfk(enabled)
    antiAfkEnabled = enabled
    if enabled then
        AntiAfkBtn.Text = "ON"
        AntiAfkBtn.TextColor3 = Color3.fromRGB(50,255,50)
        setStrokeColor(AntiAfkBtn, Color3.fromRGB(50,255,50))
        antiAfkConnection = RunService.RenderStepped:Connect(function(delta)
            antiAfkTimer += delta
            if antiAfkTimer >= 10 then
                antiAfkTimer = 0
                pcall(function()
                    local cam = workspace.CurrentCamera
                    if cam then cam.CFrame *= CFrame.Angles(0, 0.001, 0) end
                end)
            end
        end)
    else
        AntiAfkBtn.Text = "OFF"
        AntiAfkBtn.TextColor3 = Color3.fromRGB(200,200,200)
        setStrokeColor(AntiAfkBtn, Color3.fromRGB(40,40,45))
        if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
        antiAfkTimer = 0
    end
end

AntiAfkBtn.MouseButton1Click:Connect(function() setAntiAfk(not antiAfkEnabled) end)
setAntiAfk(true)  -- auto aan

-- ===== ANTI-FLING =====
local function setAntiFling(enabled)
    antiFlingEnabled = enabled
    if enabled then
        AntiFlingBtn.Text = "ON"
        AntiFlingBtn.TextColor3 = Color3.fromRGB(50,255,50)
        setStrokeColor(AntiFlingBtn, Color3.fromRGB(50,255,50))
        antiFlingConnection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if root.AssemblyLinearVelocity.Magnitude > 500 then
                root.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
        end)
    else
        AntiFlingBtn.Text = "OFF"
        AntiFlingBtn.TextColor3 = Color3.fromRGB(200,200,200)
        setStrokeColor(AntiFlingBtn, Color3.fromRGB(40,40,45))
        if antiFlingConnection then antiFlingConnection:Disconnect(); antiFlingConnection = nil end
    end
end

AntiFlingBtn.MouseButton1Click:Connect(function() setAntiFling(not antiFlingEnabled) end)
setAntiFling(true)  -- auto aan

-- ===== SERVER HOP =====
ServerHopBtn.MouseButton1Click:Connect(function()
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end)

-- ===== FLY =====
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
        if flyAnimTrack then flyAnimTrack:Stop(); flyAnimTrack:Destroy() end
        playSafeSupermanAnim(hum)
    end
    connectionFly = RunService.RenderStepped:Connect(function()
        if not root or not hum then return end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        local inputVector = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVector += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVector -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVector -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVector += cam.CFrame.RightVector end
        targetMoveVector = (inputVector.Magnitude > 0) and (inputVector.Unit * flySpeed) or Vector3.zero
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
    setStrokeColor(FlyButton, Color3.fromRGB(40,40,45))
    workspace.Gravity = originalGravity
    if connectionFly then connectionFly:Disconnect(); connectionFly = nil end
    if flyAnimTrack then pcall(function() flyAnimTrack:Stop(); flyAnimTrack:Destroy() end); flyAnimTrack = nil end
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

local function updateSpeedVisuals(activeBtn)
    setStrokeColor(Mode1Btn, Color3.fromRGB(45,45,50))
    setStrokeColor(Mode2Btn, Color3.fromRGB(45,45,50))
    setStrokeColor(Mode3Btn, Color3.fromRGB(45,45,50))
    setStrokeColor(activeBtn, accentColor)
end
local function updateStyleVisualsFly(activeBtn)
    setStrokeColor(NormalStyleBtn, Color3.fromRGB(45,45,50))
    setStrokeColor(SupermanStyleBtn, Color3.fromRGB(45,45,50))
    setStrokeColor(activeBtn, accentColor)
end
updateSpeedVisuals(Mode1Btn)
updateStyleVisualsFly(NormalStyleBtn)

Mode1Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode1; updateSpeedVisuals(Mode1Btn) end)
Mode2Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode2; updateSpeedVisuals(Mode2Btn) end)
Mode3Btn.MouseButton1Click:Connect(function() flySpeed = speeds.Mode3; updateSpeedVisuals(Mode3Btn) end)
NormalStyleBtn.MouseButton1Click:Connect(function()
    flyStyle = "Normal"; updateStyleVisualsFly(NormalStyleBtn)
    if flying then stopClassicFly(); flying = true; startClassicFly() end
end)
SupermanStyleBtn.MouseButton1Click:Connect(function()
    flyStyle = "Superman"; updateStyleVisualsFly(SupermanStyleBtn)
    if flying then stopClassicFly(); flying = true; startClassicFly() end
end)

-- ===== NOCLIP =====
local function enableNoclipForCharacter(char)
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    local conn = char.DescendantAdded:Connect(function(d)
        if d:IsA("BasePart") then d.CanCollide = false end
    end)
    table.insert(noclipConnections, conn)
end

local function setNoclip(enabled)
    noclipEnabled = enabled
    if enabled then
        NoclipButton.Text = "// TOGGLE NOCLIP: ON"
        NoclipButton.TextColor3 = Color3.fromRGB(50,255,50)
        setStrokeColor(NoclipButton, Color3.fromRGB(50,255,50))
        local char = LocalPlayer.Character
        if char then enableNoclipForCharacter(char) end
    else
        NoclipButton.Text = "// TOGGLE NOCLIP: OFF"
        NoclipButton.TextColor3 = accentColor
        setStrokeColor(NoclipButton, Color3.fromRGB(40,40,45))
        for _, conn in ipairs(noclipConnections) do pcall(function() conn:Disconnect() end) end
        noclipConnections = {}
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end

NoclipButton.MouseButton1Click:Connect(function() setNoclip(not noclipEnabled) end)

-- ===== INFINITE JUMP =====
local function setInfiniteJump(enabled)
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
        if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
    end
end

InfiniteJumpButton.MouseButton1Click:Connect(function() setInfiniteJump(not infiniteJumpEnabled) end)

-- ===== ACCENT COLOR =====
local function applyAccentColor(newColor)
    accentColor = newColor
    for _, desc in ipairs(ScreenGui:GetDescendants()) do
        if desc:IsA("UIStroke") and desc.Color ~= Color3.fromRGB(40,40,45) and desc.Color ~= Color3.fromRGB(30,30,35) and desc.Color ~= Color3.fromRGB(45,45,50) then
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
    entry.btn.MouseButton1Click:Connect(function() applyAccentColor(entry.color) end)
end

-- ===== TABS =====
local allTabs = {
    {btn=HomeTabBtn, frame=HomeFrame, name="HOME"},
    {btn=PlayerTabBtn, frame=PlayerScroll, name="PLAYER"},
    {btn=MiscTabBtn, frame=MiscFrame, name="MISC"},
    {btn=EspTabBtn, frame=EspFrame, name="ESP"},
    {btn=AimTabBtn, frame=AimFrame, name="AIM"},
    {btn=SettingsTabBtn, frame=SettingsFrame, name="SETTINGS"},
}

local function switchTab(activeBtn, activeFrame)
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
local currentKey = Enum.KeyCode.LeftAlt
local listening = false

SettingsKeybindBtn.MouseButton1Click:Connect(function()
    listening = true
    SettingsKeybindBtn.Text = "BIND: ..."
    SettingsKeybindBtn.TextColor3 = Color3.fromRGB(255,255,255)
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
        if MainFrame.Visible then
            -- Als de GUI uit beeld is geraakt, terug naar midden
            if MainFrame.Position.X.Offset < -500 or MainFrame.Position.Y.Offset < -400 or MainFrame.Position.X.Offset > 2000 or MainFrame.Position.Y.Offset > 1500 then
                MainFrame.Position = UDim2.new(0.5, -280, 0.25, -205)
            end
        end
    end
end)

-- ===== UNLOAD =====
UnloadBtn.MouseButton1Click:Connect(function()
    stopClassicFly()
    setNoclip(false)
    setInfiniteJump(false)
    setEsp(false)
    setCrosshair(false)
    setAntiAfk(false)
    setAntiFling(false)
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
    if noclipEnabled then
        for _, conn in ipairs(noclipConnections) do pcall(function() conn:Disconnect() end) end
        noclipConnections = {}
        enableNoclipForCharacter(char)
    end
    wait(0.5)
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = walkSpeedValue
        hum.JumpPower = jumpHeightValue
    end
end)

print("BUNBUN HUB geladen - zwarte scherm bug verholpen")
