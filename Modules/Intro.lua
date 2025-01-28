 if not isfile("Horror/Resources/Horror_Intro.png") then
    HorrorIntropng = game:HttpGet("https://raw.githubusercontent.com/FlR0X/Horror/refs/heads/main/Modules/Resources/Images/Horror_500x500.png")
    writefile("Horror/Resources/Horror_Intro.png", HorrorIntropng)
end

local function fadeOutImage()
    local CoreGui = game:GetService("CoreGui")
    local ScreenPart = CoreGui:FindFirstChild("FadeOutImageGui") or Instance.new("ScreenGui", CoreGui)
    ScreenPart.Name = "FadeOutImageGui"
    
    local ImageFrame = ScreenPart:FindFirstChild("ImageFrame") or Instance.new("Frame", ScreenPart)
    ImageFrame.Name = "ImageFrame"
    ImageFrame.Size = UDim2.new(0.2, 0, 0.2, 0)
    ImageFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
    ImageFrame.BackgroundTransparency = 1
    ImageFrame.Visible = true
    
    local ImageLabel = ImageFrame:FindFirstChild("ImageLabel") or Instance.new("ImageLabel", ImageFrame)
    ImageLabel.Name = "ImageLabel"
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = getcustomasset("Horror/Resources/Horror_Intro.png")
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)

    wait(1)  -- Wait 1 second before starting the fade out

    local TweenService = game:GetService("TweenService")
    local TweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local TweenGoal = {BackgroundTransparency = 1, ImageTransparency = 1}
    
    local fadeTween = TweenService:Create(ImageLabel, TweenInfo, TweenGoal)
    fadeTween:Play()

    fadeTween.Completed:Wait()

    ScreenPart:Destroy()
end
fadeOutImage()
