--[[
    ULTIMATE AESTHETIC GATEWAY
    Features: Cross-Page Redirect, Modern Footer Alert, RGB Gradient Border
    Style: High-End Glassmorphism
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- ====================================================
-- 1. CONFIGURATION
-- ====================================================
local Config = {
    -- Valid Keys Database
    Keys = {
        "AIZ",
        "TRIAL-KEY-101",
        "ADMIN-ACCESS",
        "PREMIUM-USER"
    },
    
    Title = "AIZ HUB GATEWAY",
    Subtitle = "SECURE ACCESS POINT",
    Accent = Color3.fromRGB(168, 85, 247), -- Ungu Neon
    
    -- ID Gamepass (Ganti 0 dengan ID asli)
    GamepassID = 0, 

    Links = {
        Linkvertise = "https://linkvertise.com/example",
        Lootlabs = "https://lootlabs.gg/example",
        Discord = "https://discord.gg/example"
    },
    PremiumLinks = {
        Discord = "https://discord.gg/ticket"
    }
}

-- ====================================================
-- 2. HELPERS
-- ====================================================
local Icons = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
Icons.SetIconsType("solar") 
local function GetIcon(name) return Icons.GetIcon(name) end

local function Create(c, p) local i=Instance.new(c) for k,v in pairs(p) do i[k]=v end return i end
local function Tween(o, p, t, s, d) TweenService:Create(o, TweenInfo.new(t or 0.3, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out), p):Play() end

pcall(function() for _, v in pairs(CoreGui:GetChildren()) do if v.Name == "AizUltimateGateway" then v:Destroy() end end end)

-- ====================================================
-- 3. UI BASE
-- ====================================================
local ScreenGui = Create("ScreenGui", {Name = "AizUltimateGateway", Parent = CoreGui, IgnoreGuiInset = true})

-- Blur & Dim
local Blur = Create("BlurEffect", {Parent = game:GetService("Lighting"), Size = 0, Name = "LoaderBlur"})
local Dim = Create("Frame", {Parent = ScreenGui, Size = UDim2.fromScale(1,1), BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 1, ZIndex = 0})

-- MAIN FRAME
local MainFrame = Create("Frame", {
    Parent = ScreenGui, Size = UDim2.fromOffset(0, 0), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(10, 10, 12), BorderSizePixel = 0, ClipsDescendants = true
})
Create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 16)})

-- ANIMATED RGB BORDER
local BorderFrame = Create("Frame", {
    Parent = MainFrame, Size = UDim2.new(1, 4, 1, 4), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255), ZIndex = -1
})
Create("UICorner", {Parent = BorderFrame, CornerRadius = UDim.new(0, 18)})
local BGrad = Create("UIGradient", {
    Parent = BorderFrame,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0,255,0)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,255,255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,0,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,255))
    })
})
RunService.RenderStepped:Connect(function() BGrad.Rotation = (BGrad.Rotation + 1) % 360 end)
-- Cover tengah biar jadi border
local InnerCover = Create("Frame", {
    Parent = MainFrame, Size = UDim2.new(1, -2, 1, -2), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(12, 12, 14), ZIndex = 0
})
Create("UICorner", {Parent = InnerCover, CornerRadius = UDim.new(0, 16)})


-- GLOW BACKDROP
local Glow = Create("ImageLabel", {
    Parent = MainFrame, AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.fromScale(0.5,0.5), Size = UDim2.new(1, 150, 1, 150),
    BackgroundTransparency = 1, Image = "rbxassetid://5028857472", ImageColor3 = Config.Accent, ImageTransparency = 1, ZIndex = -2
})

-- HEADER
local Header = Create("Frame", {Parent = InnerCover, Size = UDim2.new(1,0,0,70), BackgroundTransparency = 1, ZIndex = 10})
local TitleLbl = Create("TextLabel", {
    Parent = Header, Size = UDim2.new(1,0,0,30), Position = UDim2.new(0,0,0,15), BackgroundTransparency = 1,
    Text = Config.Title, TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.GothamBlack, TextSize = 24
})
-- Shimmer Title Loop
local TGrad = Create("UIGradient", {Parent = TitleLbl, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(100,100,100)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100,100,100))}), Rotation = 45})
task.spawn(function() while MainFrame.Parent do Tween(TGrad, {Offset = Vector2.new(1, 0)}, 2, Enum.EasingStyle.Linear); wait(2); TGrad.Offset = Vector2.new(-1, 0) end end)

local SubLbl = Create("TextLabel", {
    Parent = Header, Size = UDim2.new(1,0,0,20), Position = UDim2.new(0,0,0,40), BackgroundTransparency = 1,
    Text = Config.Subtitle, TextColor3 = Config.Accent, Font = Enum.Font.GothamBold, TextSize = 10, TextTransparency = 0.5
})

-- CONTENT SLIDER
local Content = Create("Frame", {
    Parent = InnerCover, Size = UDim2.new(1, 0, 1, -100), Position = UDim2.new(0, 0, 0, 70), BackgroundTransparency = 1, ClipsDescendants = true
})

-- ====================================================
-- 4. FOOTER (MODERN DELTA WARNING)
-- ====================================================
local Footer = Create("Frame", {
    Parent = InnerCover, Size = UDim2.new(1, 0, 0, 24), Position = UDim2.new(0, 0, 1, -24),
    BackgroundColor3 = Color3.fromRGB(20, 10, 10), BackgroundTransparency = 0.2, BorderSizePixel = 0, ZIndex = 20
})
-- Rounded Bottom Only Hack
Create("UICorner", {Parent = Footer, CornerRadius = UDim.new(0, 16)})
local HideTopCorners = Create("Frame", {Parent = Footer, Size = UDim2.new(1, 0, 0.5, 0), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(20, 10, 10), BackgroundTransparency = 0.2, BorderSizePixel = 0})

local AlertIcon = Create("ImageLabel", {
    Parent = Footer, Size = UDim2.fromOffset(12,12), Position = UDim2.new(0, 15, 0.5, -6),
    BackgroundTransparency = 1, Image = GetIcon("danger-triangle-bold"), ImageColor3 = Color3.fromRGB(255, 80, 80), ZIndex = 22
})
local AlertTxt = Create("TextLabel", {
    Parent = Footer, Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 34, 0, 0), BackgroundTransparency = 1,
    Text = "DELTA USERS: Disable 'Anti-Scam' in settings to prevent crashes.",
    TextColor3 = Color3.fromRGB(255, 120, 120), Font = Enum.Font.GothamBold, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 22
})
-- Pulse Icon
TweenService:Create(AlertIcon, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.5}):Play()


-- ====================================================
-- 5. PAGES SYSTEM
-- ====================================================
local PageHome = Create("Frame", {Parent = Content, Size = UDim2.fromScale(1,1), BackgroundTransparency = 1})
local PageKey = Create("Frame", {Parent = Content, Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, Visible = false, Position = UDim2.new(1,0,0,0)})
local PagePrem = Create("Frame", {Parent = Content, Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, Visible = false, Position = UDim2.new(1,0,0,0)})

-- === HOME PAGE ===
local InputBg = Create("Frame", {Parent = PageHome, Size = UDim2.new(0.8, 0, 0, 45), Position = UDim2.fromScale(0.5, 0.1), AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(20, 20, 22)})
Create("UICorner", {Parent = InputBg, CornerRadius = UDim.new(0, 10)})
Create("UIStroke", {Parent = InputBg, Color = Color3.fromRGB(50,50,55), Thickness = 1})
Create("ImageLabel", {Parent = InputBg, Size = UDim2.fromOffset(20,20), Position = UDim2.new(0,12,0.5,-10), BackgroundTransparency = 1, Image = GetIcon("key-minimalistic-square-bold"), ImageColor3 = Config.Accent})
local InputBox = Create("TextBox", {
    Parent = InputBg, Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 45, 0, 0), BackgroundTransparency = 1,
    Text = "", PlaceholderText = "PASTE KEY HERE", TextColor3 = Color3.fromRGB(255,255,255), PlaceholderColor3 = Color3.fromRGB(80,80,80),
    Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left
})

local VerifyBtn = Create("TextButton", {
    Parent = PageHome, Size = UDim2.new(0.8, 0, 0, 40), Position = UDim2.fromScale(0.5, 0.45), AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = Config.Accent, AutoButtonColor = false, Text = ""
})
Create("UICorner", {Parent = VerifyBtn, CornerRadius = UDim.new(0, 10)})
local VerifyTxt = Create("TextLabel", {Parent = VerifyBtn, Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, Text = "AUTHENTICATE", TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.GothamBlack, TextSize = 13})

-- Home Nav Buttons
local NavRow = Create("Frame", {Parent = PageHome, Size = UDim2.new(0.8, 0, 0, 60), Position = UDim2.fromScale(0.5, 0.75), AnchorPoint = Vector2.new(0.5,0), BackgroundTransparency = 1})
local function MakeNav(text, icon, color, pos, callback)
    local B = Create("TextButton", {Parent = NavRow, Size = UDim2.new(0.48, 0, 0, 45), Position = UDim2.new(pos,0,0,0), BackgroundColor3 = Color3.fromRGB(20,20,22), AutoButtonColor = false, Text = ""})
    Create("UICorner", {Parent = B, CornerRadius = UDim.new(0, 10)})
    local S = Create("UIStroke", {Parent = B, Color = color, Thickness = 1, Transparency = 0.8})
    Create("ImageLabel", {Parent = B, Size = UDim2.fromOffset(20,20), Position = UDim2.new(0.5, -30, 0.5, -10), BackgroundTransparency=1, Image=GetIcon(icon), ImageColor3=color})
    Create("TextLabel", {Parent = B, Size = UDim2.new(0,50,1,0), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency=1, Text=text, TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamBold, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left})
    B.MouseEnter:Connect(function() Tween(S, {Transparency = 0}, 0.2); Tween(B, {BackgroundColor3 = Color3.fromRGB(28,28,32)}, 0.2) end)
    B.MouseLeave:Connect(function() Tween(S, {Transparency = 0.8}, 0.2); Tween(B, {BackgroundColor3 = Color3.fromRGB(20,20,22)}, 0.2) end)
    B.MouseButton1Click:Connect(callback)
    return B
end
local BtnKey = MakeNav("GET KEY", "link-circle-bold", Color3.fromRGB(200,200,200), 0, function() end)
local BtnPrem = MakeNav("PREMIUM", "crown-star-bold", Color3.fromRGB(255,215,0), 0.52, function() end)

-- === PAGE FUNCTIONALITY ===
local function CreateGrid(parent)
    local Sc = Create("ScrollingFrame", {Parent = parent, Size = UDim2.new(1,0,0.85,0), BackgroundTransparency = 1, ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y})
    local Gl = Create("UIGridLayout", {Parent = Sc, CellSize = UDim2.new(0.45, 0, 0, 90), CellPadding = UDim2.new(0, 10, 0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center})
    Create("UIPadding", {Parent = Sc, PaddingTop = UDim.new(0, 5)})
    local Bk = Create("TextButton", {Parent = parent, Size = UDim2.new(1,0,0,20), Position = UDim2.new(0,0,0.92,0), BackgroundTransparency = 1, Text = "< Back", TextColor3 = Color3.fromRGB(120,120,120), Font = Enum.Font.GothamBold, TextSize = 10})
    return Sc, Bk
end
local KeyGrid, KeyBack = CreateGrid(PageKey)
local PremGrid, PremBack = CreateGrid(PagePrem)

local function CreateCard(parent, title, icon, color, callback)
    local Card = Create("TextButton", {Parent = parent, BackgroundColor3 = Color3.fromRGB(20,20,22), AutoButtonColor = false, Text = ""})
    Create("UICorner", {Parent = Card, CornerRadius = UDim.new(0, 12)})
    local S = Create("UIStroke", {Parent = Card, Color = color, Thickness = 1.2, Transparency = 0.8})
    local I = Create("ImageLabel", {Parent = Card, Size = UDim2.fromOffset(32,32), Position = UDim2.fromScale(0.5, 0.35), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Image = GetIcon(icon), ImageColor3 = color})
    Create("TextLabel", {Parent = Card, Size = UDim2.new(1,0,0,20), Position = UDim2.new(0,0,0.7,0), BackgroundTransparency = 1, Text = title, TextColor3 = Color3.fromRGB(200,200,200), Font = Enum.Font.GothamBold, TextSize = 10})
    Card.MouseEnter:Connect(function() Tween(S, {Transparency = 0}, 0.2); Tween(Card, {BackgroundColor3 = Color3.fromRGB(28,28,32)}, 0.2) end)
    Card.MouseLeave:Connect(function() Tween(S, {Transparency = 0.8}, 0.2); Tween(Card, {BackgroundColor3 = Color3.fromRGB(20,20,22)}, 0.2) end)
    Card.MouseButton1Click:Connect(callback)
end

-- Key Page Items
CreateCard(KeyGrid, "Linkvertise", "link-circle-bold", Color3.fromRGB(255,165,0), function() setclipboard(Config.Links.Linkvertise) end)
CreateCard(KeyGrid, "Lootlabs", "box-bold", Color3.fromRGB(50,205,50), function() setclipboard(Config.Links.Lootlabs) end)
-- [[ REDIRECT TO PREMIUM FEATURE ]] --
CreateCard(KeyGrid, "Skip Tasks?", "crown-minimalistic-bold", Color3.fromRGB(255, 215, 0), function() 
    -- Switch to Premium Page Logic
    PageKey.Visible = false
    PageKey.Position = UDim2.new(1,0,0,0)
    PagePrem.Position = UDim2.new(1,0,0,0)
    PagePrem.Visible = true
    Tween(PagePrem, {Position = UDim2.new(0,0,0,0)}, 0.3)
    SubLbl.Text = "SELECT PAYMENT"
end)

-- Premium Page Items
CreateCard(PremGrid, "Buy Robux", "card-bold", Color3.fromRGB(0, 255, 128), function() if Config.GamepassID > 0 then MarketplaceService:PromptGamePassPurchase(Players.LocalPlayer, Config.GamepassID) end end)
CreateCard(PremGrid, "Buy Ticket", "chat-round-money-bold", Color3.fromRGB(88, 101, 242), function() setclipboard(Config.PremiumLinks.Discord) end)

-- LOGIC
local function Swap(target, title)
    for _, p in pairs(Content:GetChildren()) do if p.Visible then Tween(p, {Position = UDim2.new(-0.5,0,0,0)}, 0.25); task.delay(0.25, function() p.Visible=false end) end end
    target.Position = UDim2.new(0.5,0,0,0); target.Visible = true
    Tween(target, {Position = UDim2.new(0,0,0,0)}, 0.3)
    SubLbl.Text = title
end
BtnKey.MouseButton1Click:Connect(function() Swap(PageKey, "SELECT METHOD") end)
BtnPrem.MouseButton1Click:Connect(function() Swap(PagePrem, "SELECT PAYMENT") end)
KeyBack.MouseButton1Click:Connect(function() Swap(PageHome, Config.Subtitle) end)
PremBack.MouseButton1Click:Connect(function() Swap(PageHome, Config.Subtitle) end)

-- START ANIMATION
Tween(Blur, {Size = 24}, 1)
Tween(Dim, {BackgroundTransparency = 0.2}, 1)
wait(0.2)
Tween(MainFrame, {Size = UDim2.fromOffset(450, 320)}, 0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
Tween(Glow, {ImageTransparency = 0.6}, 1)

-- VERIFY
VerifyBtn.MouseButton1Click:Connect(function()
    local inputKey = InputBox.Text
    local isValid = false

    -- Check key in database
    for _, key in ipairs(Config.Keys) do
        if inputKey == key then
            isValid = true
            break
        end
    end

    if isValid then
        VerifyTxt.Text = "SUCCESS"
        Tween(VerifyBtn, {BackgroundColor3 = Color3.fromRGB(46, 204, 113)}, 0.2)
        wait(0.5)
        Tween(MainFrame, {Size = UDim2.fromOffset(0,0), BackgroundTransparency = 1}, 0.4)
        Tween(Blur, {Size = 0}, 0.4)
        Tween(Dim, {BackgroundTransparency = 1}, 0.4)
        wait(0.5)
        pcall(function() ScreenGui:Destroy() end)
        pcall(function() Blur:Destroy() end)
        LoadMainScript()
    else
        VerifyTxt.Text = "INVALID KEY"
        Tween(VerifyBtn, {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}, 0.2)
        local p = MainFrame.Position; for i=1,5 do MainFrame.Position = p+UDim2.new(0,math.random(-5,5),0,0) RunService.RenderStepped:Wait() end MainFrame.Position = p
        wait(1)
        VerifyTxt.Text = "AUTHENTICATE"
        Tween(VerifyBtn, {BackgroundColor3 = Config.Accent}, 0.2)
    end
end)

-- Draggable
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; dragStart=input.Position; startPos=MainFrame.Position end end)
UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then local delta=input.Position-dragStart; MainFrame.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y) end end)
MainFrame.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)

function LoadMainScript()
    -- Set Authorization Token (Must match the one in aizhub.lua)
    _G.AizHubAuthorized = "https://raw.githubusercontent.com/aiz-fun/Aiz/refs/heads/main/Aiz%20Hub/authorized.lua"
    
    -- URL RAW GITHUB SCRIPT UTAMA (AIZHUB.LUA)
    -- Saya mengasumsikan file aizhub.lua berada di repository yang sama
    local MainScriptUrl = "https://raw.githubusercontent.com/aiz-fun/Aiz/refs/heads/main/Aiz%20Hub/aizhub.lua"
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(MainScriptUrl))()
    end)

    if not success then
        -- Fallback untuk testing local jika link belum ada/gagal
        if isfile and isfile("Aiz Hub/aizhub.lua") then
             loadstring(readfile("Aiz Hub/aizhub.lua"))()
        else
             warn("Gagal load script: " .. tostring(err))
             game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Gagal memuat script utama. Cek console (F9).",
                Duration = 5
            })
        end
    else
        print("AIZ HUB LOADED SUCCESSFULLY FROM WEB")
    end
end
