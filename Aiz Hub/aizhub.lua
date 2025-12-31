--[[
    Aiz Hub Universal
    Author: @aiz.fun
    Version: 1.7.0
    Library: WindUI
]]

-- [ SECURITY CHECK ] --
local AuthorizedHost = "https://raw.githubusercontent.com/aiz-fun/Aiz/refs/heads/main/Aiz%20Hub/authorized.lua"

if _G.AizHubAuthorized ~= AuthorizedHost then
    local Player = game:GetService("Players").LocalPlayer
    if Player then
        Player:Kick("Unauthorized access! Please use the official Key System.")
    end
    return
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

-- ====================================================
-- 1. DAFTARKAN TEMA (Manual Biar Work)
-- ====================================================

-- Tema 1: Default (Ungu)
WindUI:AddTheme({
    Name = "Gradient-Purple",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#A855F7"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, { Rotation = 0 }),
})

-- Tema 2: Merah
WindUI:AddTheme({
    Name = "Gradient-Red",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#DC2626"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, { Rotation = 0 }),
})

-- Tema 3: Biru
WindUI:AddTheme({
    Name = "Gradient-Blue",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#2563EB"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, { Rotation = 0 }),
})

-- Tema 4: Hijau
WindUI:AddTheme({
    Name = "Gradient-Green",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#10B981"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, { Rotation = 0 }),
})

-- Tema 5: Emas (Premium)
WindUI:AddTheme({
    Name = "Gradient-Gold",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#FFD700"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, { Rotation = 0 }),
})

-- ====================================================
-- 2. PREMIUM CHECK
-- ====================================================
local PremiumList = {
    8080406235,         
    LocalPlayer.UserId, 
}

local IsPremium = false
local UserStatus = "Free User"
local CurrentTheme = "Gradient-Purple" -- Default Theme

if table.find(PremiumList, LocalPlayer.UserId) then
    IsPremium = true
    UserStatus = "PREMIUM 👑"
    CurrentTheme = "Gradient-Gold" -- Auto Gold jika premium
end

-- ====================================================
-- 3. WINDOW SETUP
-- ====================================================

local Window = WindUI:CreateWindow({
    Title = "Aiz Hub | Universal",
    Icon = IsPremium and "solar:crown-bold" or "solar:planet-2-bold-duotone", 
    Author = IsPremium and "Verified User" or "Free User",
    Folder = "AizHub", -- Folder disesuaikan agar aman
    Size = UDim2.fromOffset(800, 550),
    Transparent = true,
    Theme = CurrentTheme, 
    Resizable = true,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() setclipboard(LocalPlayer.DisplayName) end,
    },
})

-- Notif Load
WindUI:Notify({
    Title = "Loaded",
    Content = "Current Theme: " .. CurrentTheme,
    Duration = 3,
    Icon = "solar:pallete-2-bold"
})

-- ====================================================
-- 4. LOGIKA DATA PROFIL
-- ====================================================
local onlineFriends = 0
task.spawn(function()
    pcall(function()
        for _, friend in pairs(LocalPlayer:GetFriendsOnline()) do 
            onlineFriends = onlineFriends + 1 
        end
    end)
end)

local joinDate = os.date("%d %B %Y", os.time() - (LocalPlayer.AccountAge * 86400))
local avatarImage = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"

-- ====================================================
-- 5. UI CONTENT
-- ====================================================

local UserTab = Window:Tab({ Title = "User Profile", Icon = "solar:user-circle-bold", Locked = false })

-- [[ KIRI: DATA ]]
local IdentitySection = UserTab:Section({ Title = "My Identity", Side = "Left", Box = true, Icon = "solar:card-recieved-bold" })
IdentitySection:Paragraph({
    Title = LocalPlayer.DisplayName,
    Desc = "Status: " .. UserStatus .. "\nFriends Online: " .. onlineFriends,
    Image = avatarImage,
    ImageSize = 65,
    Buttons = {{ Title = "Copy Name", Icon = "solar:copy-bold", Callback = function() setclipboard(LocalPlayer.Name) end }}
})

local StatsSection = UserTab:Section({ Title = "My Stats", Side = "Left", Box = true, Icon = "solar:chart-square-bold" })
StatsSection:Paragraph({ Title = "Username", Desc = "@" .. LocalPlayer.Name, Icon = "solar:user-id-bold" })
StatsSection:Paragraph({ Title = "Join Date", Desc = joinDate, Icon = "solar:calendar-date-bold" })
StatsSection:Paragraph({ Title = "Account Age", Desc = LocalPlayer.AccountAge .. " Days", Icon = "solar:history-bold" })

-- [[ KANAN: PLAYER LIST ]]
local PlayerListSection = UserTab:Section({ Title = "Server Players", Side = "Right", Box = true, Icon = "solar:global-bold" })

local function AddPlayer(p)
    local thumb = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=150&h=150"
    PlayerListSection:Paragraph({
        Title = p.DisplayName,
        Desc = "@" .. p.Name,
        Image = thumb,
        ImageSize = 40,
        Buttons = {{ Title = "Goto", Icon = "solar:map-point-bold", Callback = function() 
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame 
            end 
        end }}
    })
end
for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then AddPlayer(p) end end
Players.PlayerAdded:Connect(function(p) task.wait(1) AddPlayer(p) end)

-- [[ KANAN: SETTINGS ]]
local SettingsSection = UserTab:Section({
    Title = "Settings",
    Side = "Right",
    Box = true,
    Icon = "solar:settings-bold-duotone"
})

-- 1. DROPDOWN TEMA
-- 1. DROPDOWN TEMA
local ThemeList = {"Gradient-Purple", "Gradient-Red", "Gradient-Blue", "Gradient-Green", "Gradient-Gold"}
-- Validate Default
if not table.find(ThemeList, CurrentTheme) then
    CurrentTheme = ThemeList[1]
end

SettingsSection:Dropdown({
    Title = "Interface Theme",
    Desc = "Select UI Color",
    Multi = false,
    Required = true,
    Items = ThemeList,
    Default = CurrentTheme,
    Callback = function(val)
        if val then
            WindUI:SetTheme(val)
            WindUI:Notify({
                Title = "Theme Changed", 
                Content = "Switched to " .. val, 
                Duration = 2,
                Icon = "solar:palette-2-bold"
            })
        end
    end
})

-- 2. INPUT WALKSPEED
SettingsSection:Input({
    Title = "WalkSpeed",
    Desc = "Input speed number",
    Placeholder = "e.g. 100",
    InputIcon = "solar:running-bold",
    Callback = function(text)
        local num = tonumber(text)
        if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = num
            WindUI:Notify({Title="Success", Content="Speed: "..num, Duration=1})
        end
    end
})

-- 3. INPUT JUMPPOWER
SettingsSection:Input({
    Title = "JumpPower",
    Desc = "Input jump height",
    Placeholder = "e.g. 50",
    InputIcon = "solar:arrow-up-bold",
    Callback = function(text)
        local num = tonumber(text)
        if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = num
            WindUI:Notify({Title="Success", Content="Jump: "..num, Duration=1})
        end
    end
})

-- 4. UTILITY BUTTONS
SettingsSection:Paragraph({
    Title = "Actions",
    Desc = "Server Control",
    Buttons = {
        {
            Title = "Rejoin",
            Icon = "solar:restart-circle-bold",
            Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end
        },
        {
            Title = "Anti AFK",
            Icon = "solar:shield-check-bold",
            Callback = function()
                local vu = game:GetService("VirtualUser")
                LocalPlayer.Idled:Connect(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end)
                WindUI:Notify({Title="Activated", Content="Anti-AFK is running", Duration=2})
            end
        }
    }
})

-- [ TAB: UNIVERSAL ] --
local UniversalTab = Window:Tab({
    Title = "Universal",
    Icon = "solar:planet-2-broken",
})

local HttpService = game:GetService("HttpService")

-- Load Images Database (LUA)
local ImageDB = {}
pcall(function()
    ImageDB = loadstring(game:HttpGet("https://raw.githubusercontent.com/aiz-fun/Aiz/refs/heads/main/Aiz%20Hub/image.lua"))()
end)

-- Fallback if load fails
if not ImageDB or not ImageDB.baseplate then
    ImageDB = { baseplate = "https://tr.rbxcdn.com/180DAY-1ef078e0daa7568fa3a0088e9ee6b6b2/768/432/Image/Webp/noFilter" }
end

UniversalTab:Section({ Title = "Scripts" })
UniversalTab:Paragraph({
    Title = "Infinite Yield",
    Desc = "FE Admin Commands",
    Icon = "solar:shield-warning-bold",
    Thumbnail = "ImageDB.baseplate",
    ThumbnailSize = 80,
    Buttons = {{
        Title = "Main",
        Icon = "solar:play-bold",
        Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end
    }}
})
