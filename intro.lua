local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroSystem"
introGui.IgnoreGuiInset = true 
introGui.DisplayOrder = 9999
introGui.Parent = PG

local container = Instance.new("CanvasGroup")
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundTransparency = 0 
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
logo.ImageTransparency = 1
logo.Parent = container

local thunderSound = Instance.new("Sound")
thunderSound.SoundId = "rbxassetid://104093133289862"
thunderSound.Volume = 1
thunderSound.Parent = game:GetService("SoundService")

local function playIntro()
    task.wait(0.5)
    
    thunderSound:Play()
    
    task.spawn(function()
        for i = 1, 3 do
            container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            task.wait(0.05)
            container.BackgroundColor3 = Color3.fromRGB(20, 20, 25) 
            task.wait(0.05)
        end
        container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end)

    logo.ImageTransparency = 0
    local logoPop = game:GetService("TweenService"):Create(logo, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 300)
    })
    logoPop:Play()

    task.spawn(function()
        local originalPos = logo.Position
        for i = 1, 15 do
            local xOffset = math.random(-10, 10)
            local yOffset = math.random(-10, 10)
            logo.Position = originalPos + UDim2.new(0, xOffset, 0, yOffset)
            task.wait(0.02)
        end
        logo.Position = originalPos
    end)

    logoPop.Completed:Connect(function()
        game:GetService("TweenService"):Create(logo, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Size = UDim2.new(0, 260, 0, 260),
            ImageColor3 = Color3.fromRGB(200, 200, 255) 
        }):Play()
    end)

    task.wait(3) 

    local fadeOut = game:GetService("TweenService"):Create(container, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 1 
    })

    fadeOut:Play()
    fadeOut.Completed:Wait()
    
    introGui:Destroy() 
    thunderSound:Destroy()
end

playIntro()
