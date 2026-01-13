local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PG = game:GetService("Players").LocalPlayer.PlayerGui
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroSystem"
introGui.IgnoreGuiInset = true 
introGui.DisplayOrder = 9999
introGui.Parent = PG

local container = Instance.new("CanvasGroup")
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundTransparency = 1
container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
container.BorderSizePixel = 0
container.Parent = introGui

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 0, 0, 0) 
logo.Position = UDim2.new(0.5, 0, 0.5, 0)
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.Image = "rbxassetid://139877910432659" 
logo.BackgroundTransparency = 1
logo.Parent = container

local thunderSound = Instance.new("Sound")
thunderSound.SoundId = "rbxassetid://9116278356"
thunderSound.Volume = 1
thunderSound.Parent = SoundService

local function playIntro()
    TweenService:Create(container, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play()
    
    task.wait(0.5) 

    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thunderSound:Play()
    task.wait(0.05)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    local logoShow = TweenService:Create(logo, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 250, 0, 250)
    })
    logoShow:Play()
    
    local breathingEffect = TweenService:Create(logo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(0, 270, 0, 270),
        Rotation = 5 
    })
    
    logoShow.Completed:Connect(function()
        breathingEffect:Play()
    end)

    task.wait(2.5)

    breathingEffect:Cancel() 
    local fadeOut = TweenService:Create(container, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 1 
    })

    fadeOut:Play()
    fadeOut.Completed:Wait()
    
    introGui:Destroy() 
end
playIntro()
