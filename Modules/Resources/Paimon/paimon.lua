if not isfile("Horror/Resources/Paimon.webm") then
    PaimonGif = game:HttpGet("https://github.com/FlR0X/Horror/raw/refs/heads/main/Modules/Resources/Paimon/paimon.webm")
    writefile("Horror/Resources/Paimon.webm", PaimonGif)
end

local ScreenPart = Instance.new("ScreenGui", game:GetService("CoreGui"))
local PaimonFrame = Instance.new("Frame", ScreenPart)
PaimonFrame.Size = UDim2.new(0.09, 0, 0.2, 0)
PaimonFrame.BackgroundTransparency = 1
PaimonFrame.Visible = false -- toggle here premium
local PaimonVideoFrame = Instance.new("VideoFrame", PaimonFrame)
PaimonVideoFrame.Size = UDim2.new(1, 0, 1, 0)
PaimonVideoFrame.BackgroundTransparency = 1
PaimonVideoFrame.Looped = true
PaimonVideoFrame.Video = getcustomasset("Horror/Resources/Paimon.webm")
PaimonFrame.Active = true
PaimonFrame.Selectable = true
PaimonFrame.Draggable = true
repeat task.wait() until PaimonVideoFrame.IsLoaded
PaimonVideoFrame:Play()
