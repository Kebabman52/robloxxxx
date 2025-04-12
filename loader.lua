local ts = game:GetService("TweenService")
local uip = game:GetService("UserInputService")
local pgui = game:GetService("CoreGui")
local https = game:GetService("HttpService")

-- // Vars
local c = Color3.fromRGB(81, 255, 0)
local d = Color3.fromRGB(45, 45, 45)
local vr = 0
local t = 0
local direction = 1

-- // GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Roblox"
ScreenGui.Parent = pgui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.IgnoreGuiInset = true

local BaseFrame = Instance.new("CanvasGroup")
local BaseStroke = Instance.new("UIStroke")
local BaseStrokeGradient = Instance.new("UIGradient")

BaseFrame.Parent = ScreenGui
BaseFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
BaseFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BaseFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
BaseFrame.Size = UDim2.new(0, 300, 0, 400)

BaseStroke.Parent = BaseFrame
BaseStroke.Thickness = 2
BaseStroke.Transparency = 0
BaseStroke.Color = Color3.fromRGB(255, 255, 255)
BaseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BaseStroke.LineJoinMode = Enum.LineJoinMode.Miter

BaseStrokeGradient.Parent = BaseStroke
BaseStrokeGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 255, 0))
})

local InnerFrame = Instance.new("Frame")
local InnerFrameStroke = Instance.new("UIStroke")
InnerFrame.Name = "InnerFrame"
InnerFrame.Size = UDim2.new(0, 269, 0, 315)
InnerFrame.Parent = BaseFrame
InnerFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
InnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
InnerFrame.Position = UDim2.new(0.5, 0, 0.591, 0)

InnerFrameStroke.Parent = InnerFrame
InnerFrameStroke.Thickness = 1
InnerFrameStroke.Transparency = 0
InnerFrameStroke.Color = Color3.fromRGB(255, 255, 255)
InnerFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InnerFrameStroke.LineJoinMode = Enum.LineJoinMode.Miter

local ScrollFrame = Instance.new("ScrollingFrame")
local ScrollFrameLayout = Instance.new("UIListLayout")
local ScrollFramePadding = Instance.new("UIPadding")

ScrollFrame.Parent = InnerFrame
ScrollFrame.Size = UDim2.new(0, 260, 0, 310)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
ScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(95, 95, 95)

ScrollFrameLayout.Parent = ScrollFrame
ScrollFrameLayout.Padding = UDim.new(0, 6)
ScrollFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

ScrollFramePadding.Parent = ScrollFrame
ScrollFramePadding.PaddingTop = UDim.new(0, 2)

local Title = Instance.new("TextLabel")
local TitleUnderline = Instance.new("Frame")
local TitleUnderlineGradient = Instance.new("UIGradient")

Title.Parent = BaseFrame
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0.12, 0)
Title.Size = UDim2.new(0, 90, 0, 19)
Title.Font = Enum.Font.RobotoMono
Title.Text = "AAA Hex"
Title.TextSize = 21
Title.TextColor3 = Color3.new(1, 1, 1)

TitleUnderline.Parent = BaseFrame
TitleUnderline.AnchorPoint = Vector2.new(0.5, 0.5)
TitleUnderline.BackgroundTransparency = 0
TitleUnderline.BackgroundColor3 = Color3.new(1, 1, 1)
TitleUnderline.Position = UDim2.new(0.5, 0, 0.15, 0)
TitleUnderline.Size = UDim2.new(0, 143, 0, 1)
TitleUnderline.BorderSizePixel = 0

TitleUnderlineGradient.Parent = TitleUnderline
TitleUnderlineGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 12)),ColorSequenceKeypoint.new(0.5, Color3.fromRGB(81, 255, 0)),ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))})

-- // Dragging
local dragging, mstart, fstart
BaseFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mstart = uip:GetMouseLocation()
		fstart = BaseFrame.Position
	end
end)

uip.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = uip:GetMouseLocation() - mstart
		ts:Create(BaseFrame, TweenInfo.new(0.4), {
			Position = UDim2.new(fstart.X.Scale, fstart.X.Offset + delta.X, fstart.Y.Scale, fstart.Y.Offset + delta.Y)
		}):Play()
	end
end)

uip.InputEnded:Connect(function(input)
	if dragging then
		dragging = false
	end
end)

-- // Button Creation
local function creatEButton(name, CallbackFinalBoss)
	local button = Instance.new("TextButton")
	local stroke = Instance.new("UIStroke")
	local corner = Instance.new("UICorner")

	button.Name = name
	button.Size = UDim2.new(0, 200, 0, 30)
	button.Parent = ScrollFrame
	button.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
	button.Font = Enum.Font.RobotoMono
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextSize = 15
	button.Text = name or "Unnamed"

	stroke.Parent = button
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Color3.fromRGB(60, 60, 60)

	corner.Parent = button
	corner.CornerRadius = UDim.new(0, 4)

	local func, err = loadstring(CallbackFinalBoss or "")
	if func then
		button.MouseButton1Click:Connect(func)
		button.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
		end)
    

	else
		warn("on: ", name, "   error: ", err)
	end

	return stroke
end

-- // JSON
local jsonContent
local success, err = pcall(function()
	jsonContent = game:HttpGet("https://raw.githubusercontent.com/Kebabman52/robloxxxx/refs/heads/main/aaaaaa.json")
end)

if success then
	local presets = https:JSONDecode(jsonContent)
	for _, preset in ipairs(presets) do
		local stroke = creatEButton(preset.name, preset.Callback)
		preset._stroke = stroke
		print("Created : " .. preset.name)
	end
else
	warn("some stuff mixxed up on our end")
end

-- // Spinny
while true do
	wait(0.01)

	vr = vr + 10
	BaseStrokeGradient.Rotation = vr

	t = t + direction * 0.025
	if t >= 1 then
		t = 1
		direction = -1
	elseif t <= 0 then
		t = 0
		direction = 1
	end

	local r = c.R + (d.R - c.R) * t
	local g = c.G + (d.G - c.G) * t
	local b = c.B + (d.B - c.B) * t
	InnerFrameStroke.Color = Color3.new(r, g, b)

	for _, child in ipairs(ScrollFrame:GetChildren()) do
		if child:IsA("TextButton") then
			local stroke = child:FindFirstChildWhichIsA("UIStroke")
			if stroke then
				stroke.Color = Color3.new(r, g, b)
			end
		end
	end
end
