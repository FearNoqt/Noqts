local UILibrary = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UILibrary"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 100)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = ScreenGui

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextScaled = true
loadingText.Parent = loadingFrame

wait(3)

TweenService:Create(loadingFrame, TweenInfo.new(0.5), {Transparency = 1}):Play()
TweenService:Create(loadingText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
wait(0.5)
loadingFrame:Destroy()

function UILibrary:CreateWindow(name)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0.5, 0, 0.6, 0)
    window.Position = UDim2.new(0.25, 0, 0.2, 0)
    window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    window.BorderSizePixel = 0
    window.Name = name or "Window"
    window.Parent = ScreenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 0
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    title.Text = name or "Window"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22
    title.Parent = window

    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 1, -40)
    tabHolder.Position = UDim2.new(0, 0, 0, 40)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Name = "Tabs"
    tabHolder.Parent = window

    local tabButtons = Instance.new("Frame")
    tabButtons.Size = UDim2.new(1, 0, 0, 30)
    tabButtons.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabButtons.BorderSizePixel = 0
    tabButtons.Name = "TabButtons"
    tabButtons.Parent = tabHolder

    local tabs = Instance.new("Folder")
    tabs.Name = "TabPages"
    tabs.Parent = tabHolder

    -- Draggable
    local dragging, dragInput, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return window
end

function UILibrary:AddTab(window, name)
    local tabButtons = window.Tabs.TabButtons
    local tabPages = window.Tabs.TabPages

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 1, 0)
    button.Position = UDim2.new(#tabButtons:GetChildren(), 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = tabButtons

    local tab = Instance.new("ScrollingFrame")
    tab.Size = UDim2.new(1, 0, 1, -30)
    tab.Position = UDim2.new(0, 0, 0, 30)
    tab.BackgroundTransparency = 1
    tab.ScrollBarThickness = 6
    tab.Visible = false
    tab.Name = name
    tab.Parent = tabPages

    button.MouseButton1Click:Connect(function()
        for _, page in ipairs(tabPages:GetChildren()) do
            page.Visible = false
        end
        tab.Visible = true
    end)

    return tab
end

function UILibrary:AddButton(tab, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, #tab:GetChildren() * 35)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text or "Button"
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.Parent = tab

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
end

function UILibrary:AddLabel(tab, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 30)
    label.Position = UDim2.new(0, 10, 0, #tab:GetChildren() * 35)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = text or "Label"
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.Parent = tab

    return label
end

return UILibrary
