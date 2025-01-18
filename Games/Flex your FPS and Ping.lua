-- Get stuff --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FlR0X/Horror/refs/heads/main/UI%20Library/UI%20Library.lua"))()
Library.theme.accentcolor = Color3.new(1, 0, 0)
local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/FlR0X/Horror/refs/heads/main/UI%20Library/Notify%20Library/Akali%20Notify.lua"))()
local Notify = NotifyLibrary.Notify
local user = game.Players.LocalPlayer.DisplayName or game.Players.LocalPlayer.Name
local Window = Library:CreateWindow("Horror | " .. user .. " | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, Vector2.new(500, 600), Enum.KeyCode.RightControl)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

_G.pingspam = false
_G.fpsSpoof = false
getgenv().pingvalue = 1
getgenv().fpsvalue = 60
getgenv().fpsvaluemax = 120
getgenv().fpsvaluemin = 60

local MainTab = Window:CreateTab("Spoofing") 
local SecondTab = Window:CreateTab("Badges") 

local FpsSection = MainTab:CreateSector("Fps", "left")
local PingSection = MainTab:CreateSector("Ping", "right")
local BadgesSection = SecondTab:CreateSector("Badges", "left")

local OBBY_LIST = {"Easy", "Medium", "Hard", "Extreme", "Terrifying"}

local obbyRemote = ReplicatedStorage:WaitForChild("Obby")
local homeRemote = ReplicatedStorage:WaitForChild("Home")

FpsSection:AddToggle("FPS Spoofer", false, function(state)
    _G.fpsSpoof = state
    if _G.fpsSpoof and hookfunction then
        for _, func in pairs(getgc()) do
            if type(func) == "function" and debug.getinfo(func).numparams == 3 then
                local scriptEnv = getfenv(func)
                if scriptEnv and scriptEnv.script == game.Players.LocalPlayer.PlayerScripts:FindFirstChild("System").Handler then
                    hookfunction(func, function(...)
                        local fpsValue = getgenv().fpsvalue
                        if fpsValue then
                            return fpsValue
                        end
                        return task.wait(9e9)
                    end)
                    break
                end
            end
        end
    end
end)

FpsSection:AddSlider("FPS", 1, 1, 9999, 1, function(value)
    getgenv().fpsvalue = value
end)

FpsSection:AddToggle("Randomize FPS", false, function(state)
    _G.randomizeFPS = state
    if _G.randomizeFPS then
        task.spawn(function()
            while _G.randomizeFPS do
                getgenv().fpsvalue = math.random(getgenv().fpsvaluemin, getgenv().fpsvaluemax)
                task.wait(1)
            end
        end)
    end
end)

FpsSection:AddSlider("Minimum FPS", 1, 150, 1500, 1, function(value)
    getgenv().fpsvaluemin = value
end)

FpsSection:AddSlider("Maximum FPS", 1, 350, 1500, 1, function(value)
    getgenv().fpsvaluemax = value
end)

PingSection:AddToggle("Ping Spoofer", false, function(state)
    _G.pingspam = state
end)

PingSection:AddSlider("Ping", 1, 10, 9999, 1, function(value)
    getgenv().pingvalue = value
end)

PingSection:AddToggle("Randomize Ping", false, function(state)
    _G.randomizePing = state
    if _G.randomizePing then
        task.spawn(function()
            while _G.randomizePing do
                getgenv().pingvalue = math.random(getgenv().pingvaluemin, getgenv().pingvaluemax)
                task.wait(1)
            end
        end)
    end
end)

PingSection:AddSlider("Minimum Ping", 1, 10, 1500, 1, function(value)
    getgenv().pingvaluemin = value
end)

PingSection:AddSlider("Maximum Ping", 1, 50, 1500, 1, function(value)
    getgenv().pingvaluemax = value
end)

RunService.Heartbeat:Connect(function()
    if _G.pingspam then
        local pingRem = ReplicatedStorage:FindFirstChild("PingRem")
        if pingRem then
            pingRem:FireServer(getgenv().pingvalue)
        end
    end
end)

local function unlockObbyBadges()
    for _, obby in ipairs(OBBY_LIST) do 
        obbyRemote:FireServer(obby)
        firetouchinterest(workspace.Obbies[obby]:WaitForChild("badge"), game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
    end
    homeRemote:FireServer() 
end

BadgesSection:AddButton("Unlock All Obby Badges", function()
    unlockObbyBadges()
end)

