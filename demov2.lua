-- Kiểm tra game đã tải xong chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- CẤU HÌNH KEY & ADMIN & HÌNH NỀN
local CORRECT_KEY = "v2updatebaby"
local ADMIN_NAME = "Monkeynicehihi"
local BACKGROUND_IMAGE_ID = "rbxassetid://137468238820595"

-- MẶC ĐỊNH BAN ĐẦU LÀ TIẾNG ANH (EN)
local CurrentLang = "EN"

----------------------------------------------------
-- DỮ LIỆU NGÔN NGỮ (MẶC ĐỊNH ANH - EN)
----------------------------------------------------
local Translations = {
    VI = {
        KeyTitle = "NICE HUB • 4D SECURITY",
        KeySub = "Vui lòng nhập Key để tiếp tục",
        KeyPlaceholder = "Nhập Key vào đây...",
        BtnGetKey = "LẤY KEY",
        BtnFreeKey = "FREE KEY",
        BtnCheckKey = "XÁC NHẬN KEY",
        KeySuccess = "Key chính xác! Đang mở Hub...",
        KeyFail = "Sai Key! Vui lòng nhập lại.",
        NotAdmin = "Bạn không phải admin / OWNER",
        
        TabHome = "Trang Chủ",
        TabNoKey = "No Key Scripts",
        TabKeyScripts = "Key Scripts",
        TabESP = "Tính Năng ESP",
        TabFixLag = "Giảm Lag",
        TabServer = "Server Hop",
        TabEvents = "Events / Admin",
        TabSettings = "Cài Đặt",
        
        Hello = "Xin chào, ",
        Account = "Tài khoản: ",
        Rank = "Cấp bậc: ",
        
        MaxPlayersLabel = "Số người tối đa trong Server:",
        HopNow = "🌐 Hop Server Ngay",
        
        TrafficLightTitle = "Đèn Tự Động (Đỏ: Đứng im / Xanh: Đi)",
        SkyPanelToggle = "Bật Bảng sky pandel (Đi trên trời)",
        SkyHeightLabel = "Độ cao sky pandel (Mặc định: 30):",
        
        EspPlayer = "Bật ESP Tên Người Chơi",
        EspTrap = "Bật ESP Định Vị Bẫy (TRAP)",
        FixLagTitle = "Tối Ưu Hóa & Xóa Đồ Họa (Fix Lag)",
        FixLagDesc = "Giúp tăng FPS và xóa hiệu ứng nặng",
        
        LangTitle = "Ngôn Ngữ / Language",
        LangDesc = "Chọn ngôn ngữ hiển thị cho Hub",
        InfoTitle = "Thông Tin Phiên Bản",
        InfoContent = "Verox Hub V2 • Phát triển bởi Nice Prime & Veroxhpm Team\nTrạng thái: Hoạt động ổn định"
    },
    EN = {
        KeyTitle = "NICE HUB • 4D SECURITY",
        KeySub = "Please enter Key to continue",
        KeyPlaceholder = "Enter Key here...",
        BtnGetKey = "GET KEY",
        BtnFreeKey = "FREE KEY",
        BtnCheckKey = "CONFIRM KEY",
        KeySuccess = "Correct Key! Opening Hub...",
        KeyFail = "Wrong Key! Please try again.",
        NotAdmin = "You are not an admin / OWNER",
        
        TabHome = "Home",
        TabNoKey = "No Key Scripts",
        TabKeyScripts = "Key Scripts",
        TabESP = "ESP Features",
        TabFixLag = "FPS Boost",
        TabServer = "Server Hop",
        TabEvents = "Events / Admin",
        TabSettings = "Settings",
        
        Hello = "Hello, ",
        Account = "Account: ",
        Rank = "Rank: ",
        
        MaxPlayersLabel = "Max players in Server:",
        HopNow = "🌐 Hop Server Now",
        
        TrafficLightTitle = "Traffic Light Event (Red: Stop / Green: Move)",
        SkyPanelToggle = "Enable sky pandel (Walk in Sky)",
        SkyHeightLabel = "sky pandel Height (Default: 30):",
        
        EspPlayer = "Enable Player Name ESP",
        EspTrap = "Enable Trap ESP (TRAP)",
        FixLagTitle = "Optimization & Fix Lag",
        FixLagDesc = "Boost FPS and remove heavy effects",
        
        LangTitle = "Language",
        LangDesc = "Select display language for the Hub",
        InfoTitle = "Version Information",
        InfoContent = "Verox Hub V2 • Developed by Nice Prime & Veroxhpm Team\nStatus: Stable"
    }
}

----------------------------------------------------
-- DỌN DẸP UI CŨ TRƯỚC KHI KHỞI TẠO
----------------------------------------------------
local function ClearOldUI()
    pcall(function()
        if gethui then
            for _, v in ipairs(gethui():GetChildren()) do
                if v.Name == "NiceHub4DKeySystem" or v.Name == "VeroxSkyPanelGui" or v.Name == "WindUI" then
                    v:Destroy()
                end
            end
        end
        for _, v in ipairs(CoreGui:GetChildren()) do
            if v.Name == "NiceHub4DKeySystem" or v.Name == "VeroxSkyPanelGui" or v.Name == "WindUI" then
                v:Destroy()
            end
        end
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
            for _, v in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
                if v.Name == "NiceHub4DKeySystem" or v.Name == "VeroxSkyPanelGui" or v.Name == "WindUI" then
                    v:Destroy()
                end
            end
        end
    end)
end

ClearOldUI()

----------------------------------------------------
-- 1. GIAO DIỆN KEY SYSTEM 4D
----------------------------------------------------
local KeyScreen = Instance.new("ScreenGui")
KeyScreen.Name = "NiceHub4DKeySystem"
if gethui then
    KeyScreen.Parent = gethui()
else
    KeyScreen.Parent = CoreGui
end
KeyScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyScreen.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "MainFrame"
KeyFrame.Parent = KeyScreen
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BackgroundTransparency = 0.05
KeyFrame.BorderSizePixel = 0
KeyFrame.Position = UDim2.new(0.5, -190, 0.5, -145)
KeyFrame.Size = UDim2.new(0, 380, 0, 310)
KeyFrame.Active = true
KeyFrame.Draggable = true

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 16)
UICornerKey.Parent = KeyFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = KeyFrame
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Transparency = 0.4
UIStroke.Thickness = 2

local ImageLogo = Instance.new("ImageLabel")
ImageLogo.Name = "ImageLogo"
ImageLogo.Parent = KeyFrame
ImageLogo.BackgroundTransparency = 1
ImageLogo.Position = UDim2.new(0.5, -35, 0, 15)
ImageLogo.Size = UDim2.new(0, 70, 0, 70)
ImageLogo.Image = BACKGROUND_IMAGE_ID

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 14)
LogoCorner.Parent = ImageLogo

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 0, 0, 90)
KeyTitle.Size = UDim2.new(1, 0, 0, 25)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = Translations[CurrentLang].KeyTitle
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 17

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = KeyFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 112)
SubTitle.Size = UDim2.new(1, 0, 0, 18)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = Translations[CurrentLang].KeySub
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
SubTitle.TextSize = 11

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0, 138)
KeyInput.Size = UDim2.new(0.8, 0, 0, 36)
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.PlaceholderText = Translations[CurrentLang].KeyPlaceholder
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 13

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 10)
TextBoxCorner.Parent = KeyInput

local TextStroke = Instance.new("UIStroke")
TextStroke.Parent = KeyInput
TextStroke.Color = Color3.fromRGB(50, 50, 70)
TextStroke.Thickness = 1

local BtnGetKey = Instance.new("TextButton")
BtnGetKey.Parent = KeyFrame
BtnGetKey.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
BtnGetKey.Position = UDim2.new(0.1, 0, 0, 184)
BtnGetKey.Size = UDim2.new(0.38, 0, 0, 30)
BtnGetKey.Font = Enum.Font.GothamBold
BtnGetKey.Text = Translations[CurrentLang].BtnGetKey
BtnGetKey.TextColor3 = Color3.fromRGB(255, 170, 0)
BtnGetKey.TextSize = 11

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 8)
GetCorner.Parent = BtnGetKey

local BtnFreeKey = Instance.new("TextButton")
BtnFreeKey.Parent = KeyFrame
BtnFreeKey.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
BtnFreeKey.Position = UDim2.new(0.52, 0, 0, 184)
BtnFreeKey.Size = UDim2.new(0.38, 0, 0, 30)
BtnFreeKey.Font = Enum.Font.GothamBold
BtnFreeKey.Text = Translations[CurrentLang].BtnFreeKey
BtnFreeKey.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnFreeKey.TextSize = 11

local FreeCorner = Instance.new("UICorner")
FreeCorner.CornerRadius = UDim.new(0, 8)
FreeCorner.Parent = BtnFreeKey

local BtnCheckKey = Instance.new("TextButton")
BtnCheckKey.Parent = KeyFrame
BtnCheckKey.BackgroundColor3 = Color3.fromRGB(0, 136, 255)
BtnCheckKey.Position = UDim2.new(0.1, 0, 0, 222)
BtnCheckKey.Size = UDim2.new(0.8, 0, 0, 34)
BtnCheckKey.Font = Enum.Font.GothamBold
BtnCheckKey.Text = Translations[CurrentLang].BtnCheckKey
BtnCheckKey.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnCheckKey.TextSize = 12

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 8)
ConfirmCorner.Parent = BtnCheckKey

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(100, 50, 255))
}
UIGradient.Parent = BtnCheckKey

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Parent = KeyFrame
KeyStatus.BackgroundTransparency = 1
KeyStatus.Position = UDim2.new(0, 0, 0, 266)
KeyStatus.Size = UDim2.new(1, 0, 0, 18)
KeyStatus.Font = Enum.Font.GothamMedium
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
KeyStatus.TextSize = 11

----------------------------------------------------
-- 2. HÀM MỞ MENU CHÍNH WINDUI
----------------------------------------------------
local function OpenMainUI()
    pcall(function() KeyScreen:Destroy() end)

    local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

    local Window = WindUI:CreateWindow({
        Title = "Verox Hub",
        SubTitle = "By Nice Prime & Veroxhpm Team",
        TabWidth = 160,
        Size = UDim2.new(0, 580, 0, 420),
        Acrylic = true,
        Theme = "Dark",
        Logo = BACKGROUND_IMAGE_ID
    })

    local T = Translations[CurrentLang]
    local TabHome = Window:Tab({ Title = T.TabHome, Icon = "home" })
    local TabNoKey = Window:Tab({ Title = T.TabNoKey, Icon = "unlock" })
    local TabKeyScripts = Window:Tab({ Title = T.TabKeyScripts, Icon = "key" })
    local TabESP = Window:Tab({ Title = T.TabESP, Icon = "eye" })
    local TabFixLag = Window:Tab({ Title = T.TabFixLag, Icon = "zap" })
    local TabServer = Window:Tab({ Title = T.TabServer, Icon = "server" })
    local TabEvents = Window:Tab({ Title = T.TabEvents, Icon = "shield" })
    local TabSettings = Window:Tab({ Title = T.TabSettings, Icon = "settings" })

    -- Watermark hiển thị ở dưới menu chính
    pcall(function()
        local parentTarget = gethui and gethui() or CoreGui
        local watermark = Instance.new("TextLabel")
        watermark.Name = "VeroxWatermark"
        watermark.Size = UDim2.new(0, 200, 0, 20)
        watermark.Position = UDim2.new(1, -210, 1, -22)
        watermark.BackgroundTransparency = 1
        watermark.Font = Enum.Font.GothamBold
        watermark.Text = "Verox Hub V2"
        watermark.TextColor3 = Color3.fromRGB(120, 120, 140)
        watermark.TextSize = 11
        watermark.TextXAlignment = Enum.TextXAlignment.Right
        watermark.ZIndex = 999
        watermark.Parent = parentTarget
    end)

    -- TAB HOME
    TabHome:Paragraph({
        Title = T.Hello .. LocalPlayer.DisplayName,
        Content = T.Account .. LocalPlayer.Name .. "\n" .. T.Rank .. (LocalPlayer.Name == ADMIN_NAME and "👑 [OWNER]" or (LocalPlayer.Name == "Khaden1999" and "☠️ HACKER GOD" or "Verox Member"))
    })

    -- TAB NO KEY SCRIPTS
    TabNoKey:Button({
        Title = "⚡ Wzeus Hub",
        Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz"))() end) end
    })

    TabNoKey:Button({
        Title = "🌶️ Chiily Hub V3 / V4",
        Callback = function()
            Window:Dialog({
                Title = "Chọn Chilly Hub!",
                Content = "Vui lòng chọn phiên bản Chilly Hub bạn muốn sử dụng:",
                Buttons = {
                    {
                        Title = "Chilly V3 (Menu cũ)",
                        Callback = function()
                            pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/khauow386-dot/Kha-hup-rayfi/refs/heads/main/Chilihupv3"))() end)
                        end
                    },
                    {
                        Title = "Chilly V4",
                        Callback = function()
                            pcall(function() loadstring(game:HttpGet("https://id.tomroblox.com/raw/kairoblox/chilli-hub-viet-hoa-v4"))() end)
                        end
                    }
                }
            })
        end
    })

    TabNoKey:Button({
        Title = "🌟 Aris Hub",
        Callback = function() pcall(function() loadstring(game:HttpGet("https://vxezestudio.online/api/scripts/script_kfXJrZUcmVdSv/stream/init"))() end) end
    })

    TabNoKey:Button({
        Title = "☁️ Clout Hub",
        Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua"))() end) end
    })

    TabNoKey:Button({
        Title = "🌙 Night Hub",
        Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/nightegg.lua"))() end) end
    })

    -- TAB KEY SCRIPTS
    TabKeyScripts:Button({
        Title = "🍊 Miranda Hub",
        Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/Miranda.lua"))() end) end
    })

    -- TAB ESP
    local PlayerEspEnabled = false
    local TrapEspEnabled = false

    local function ApplyPlayerESP(char)
        local head = char:WaitForChild("Head", 5)
        if not head then return end
        if head:FindFirstChild("PlayerEspTag") then head.PlayerEspTag:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = "PlayerEspTag"
        bb.Adornee = head
        bb.Size = UDim2.new(0, 180, 0, 40)
        bb.StudsOffset = Vector3.new(0, 2.2, 0)
        bb.AlwaysOnTop = true
        bb.Enabled = PlayerEspEnabled
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 12
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Text = "👤 " .. char.Name
        nameLabel.Parent = bb
        bb.Parent = head
    end

    local function ApplyTrapESP(part)
        if part:IsA("BasePart") then
            local nameLower = part.Name:lower()
            if nameLower:find("trap") or nameLower:find("bẫy") then
                if not part:FindFirstChild("TrapEspTag") then
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "TrapEspTag"
                    bb.Adornee = part
                    bb.Size = UDim2.new(0, 120, 0, 35)
                    bb.StudsOffset = Vector3.new(0, 1.5, 0)
                    bb.AlwaysOnTop = true
                    bb.Enabled = TrapEspEnabled
                    
                    local trapLabel = Instance.new("TextLabel")
                    trapLabel.Size = UDim2.new(1, 0, 1, 0)
                    trapLabel.BackgroundTransparency = 1
                    trapLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                    trapLabel.Font = Enum.Font.GothamBold
                    trapLabel.TextSize = 13
                    trapLabel.TextStrokeTransparency = 0
                    trapLabel.Text = "TRAP"
                    trapLabel.Parent = bb
                    bb.Parent = part
                end
            end
        end
    end

    TabESP:Toggle({
        Title = T.EspPlayer,
        Default = false,
        Callback = function(state)
            PlayerEspEnabled = state
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head and head:FindFirstChild("PlayerEspTag") then
                        head.PlayerEspTag.Enabled = PlayerEspEnabled
                    elseif PlayerEspEnabled and plr.Character then
                        ApplyPlayerESP(plr.Character)
                    end
                end
            end
        end
    })

    TabESP:Toggle({
        Title = T.EspTrap,
        Default = false,
        Callback = function(state)
            TrapEspEnabled = state
            for _, obj in ipairs(workspace:GetDescendants()) do
                ApplyTrapESP(obj)
                local tag = obj:FindFirstChild("TrapEspTag")
                if tag then
                    tag.Enabled = TrapEspEnabled
                end
            end
        end
    })

    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            if PlayerEspEnabled then
                ApplyPlayerESP(char)
            end
        end)
    end)

    workspace.DescendantAdded:Connect(function(obj)
        if TrapEspEnabled then
            task.wait(0.1)
            ApplyTrapESP(obj)
        end
    end)

    -- TAB FIX LAG
    TabFixLag:Button({
        Title = T.FixLagTitle,
        Desc = T.FixLagDesc,
        Callback = function()
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                for _, v in ipairs(Lighting:GetChildren()) do
                    if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
                end
                for _, obj in ipairs(game:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.Reflectance = 0
                        obj.CastShadow = false
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj:Destroy()
                    end
                end
            end)
        end
    })

    -- TAB SERVER HOP
    local maxPlayersInput = "1"
    
    TabServer:Input({
        Title = T.MaxPlayersLabel,
        Default = "1",
        Callback = function(value)
            maxPlayersInput = value
        end
    })

    local function HopServerWithMaxPlayers(maxAllowed)
        maxAllowed = tonumber(maxAllowed) or 1
        pcall(function()
            local validServers = {}
            local cursor = ""
            for page = 1, 5 do
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                if cursor ~= "" then url = url .. "&cursor=" + cursor end
                local success, result = pcall(function() return game:HttpGet(url) end)
                if success then
                    local data = HttpService:JSONDecode(result)
                    if data and data.data then
                        for _, s in ipairs(data.data) do
                            if s.playing and s.playing <= maxAllowed and s.playing >= 1 and s.id ~= game.JobId then
                                table.insert(validServers, s.id)
                            end
                        end
                        if data.nextPageCursor then cursor = data.nextPageCursor else break end
                    else break end
                else break end
                task.wait(0.1)
            end

            if #validServers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, validServers[math.random(1, #validServers)], LocalPlayer)
            else
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end
        end)
    end

    TabServer:Button({
        Title = T.HopNow,
        Callback = function()
            HopServerWithMaxPlayers(maxPlayersInput)
        end
    })

    -- TAB EVENTS / ADMIN ABUSE
    local trafficLightActive = false
    TabEvents:Toggle({
        Title = T.TrafficLightTitle,
        Default = false,
        Callback = function(state)
            trafficLightActive = state
            task.spawn(function()
                while trafficLightActive do
                    local greenTime = math.random(4, 7)
                    local elapsed = 0
                    while trafficLightActive and elapsed < greenTime do
                        task.wait(0.1)
                        elapsed = elapsed + 0.1
                    end
                    
                    if not trafficLightActive then break end

                    local redTime = math.random(3, 5)
                    elapsed = 0
                    while trafficLightActive and elapsed < redTime do
                        task.wait(0.1)
                        elapsed = elapsed + 0.1
                        pcall(function()
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local hrp = char.HumanoidRootPart
                                hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                            end
                        end)
                    end
                end
            end)
        end
    })

    -- TÍNH NĂNG SKY PANEL (CÓ THỂ TÙY CHỈNH ĐỘ CAO)
    local skyPanelGui = nil
    local skyPlatform = nil
    local skyConnection = nil
    local skyHeightValue = 30 -- Mặc định độ cao là 30

    TabEvents:Input({
        Title = T.SkyHeightLabel,
        Default = "30",
        Callback = function(value)
            local num = tonumber(value)
            if num then
                skyHeightValue = num
            end
        end
    })

    TabEvents:Toggle({
        Title = T.SkyPanelToggle,
        Default = false,
        Callback = function(state)
            if state then
                if skyPanelGui then skyPanelGui:Destroy() end
                
                skyPanelGui = Instance.new("ScreenGui")
                skyPanelGui.Name = "VeroxSkyPanelGui"
                skyPanelGui.Parent = gethui and gethui() or CoreGui
                skyPanelGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

                local skyBtn = Instance.new("TextButton")
                skyBtn.Name = "SkyButton"
                skyBtn.Parent = skyPanelGui
                skyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
                skyBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
                skyBtn.Size = UDim2.new(0, 130, 0, 45)
                skyBtn.Font = Enum.Font.GothamBold
                skyBtn.Text = "sky pandel"
                skyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                skyBtn.TextSize = 12
                skyBtn.BorderSizePixel = 0
                skyBtn.Active = true
                skyBtn.Draggable = true

                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 8)
                btnCorner.Parent = skyBtn

                local inSky = false

                skyBtn.MouseButton1Click:Connect(function()
                    inSky = not inSky
                    pcall(function()
                        local char = LocalPlayer.Character
                        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                        local hrp = char.HumanoidRootPart

                        if inSky then
                            skyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
                            
                            -- Đưa nhân vật lên trời theo độ cao người dùng nhập
                            hrp.CFrame = hrp.CFrame + Vector3.new(0, skyHeightValue, 0)

                            -- Tạo bệ đỡ tàng hình dưới chân
                            if not skyPlatform then
                                skyPlatform = Instance.new("Part")
                                skyPlatform.Name = "SkyWalkPlatform"
                                skyPlatform.Size = Vector3.new(15, 1, 15)
                                skyPlatform.Anchored = true
                                skyPlatform.Transparency = 1
                                skyPlatform.CanCollide = true
                                skyPlatform.Parent = workspace
                            end

                            if skyConnection then skyConnection:Disconnect() end
                            skyConnection = RunService.RenderStepped:Connect(function()
                                if inSky and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    local root = LocalPlayer.Character.HumanoidRootPart
                                    skyPlatform.Position = root.Position - Vector3.new(0, 3.5, 0)
                                end
                            end)
                        else
                            skyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
                            
                            if skyConnection then
                                skyConnection:Disconnect()
                                skyConnection = nil
                            end
                            if skyPlatform then
                                skyPlatform:Destroy()
                                skyPlatform = nil
                            end
                        end
                    end)
                end)
            else
                if skyConnection then
                    skyConnection:Disconnect()
                    skyConnection = nil
                end
                if skyPlatform then
                    skyPlatform:Destroy()
                    skyPlatform = nil
                end
                if skyPanelGui then
                    skyPanelGui:Destroy()
                    skyPanelGui = nil
                end
            end
        end
    })

    -- TAB SETTINGS
    TabSettings:Dropdown({
        Title = T.LangTitle,
        Desc = T.LangDesc,
        Values = { "English 🇬🇧", "Tiếng Việt 🇻🇳" },
        Default = (CurrentLang == "EN" and "English 🇬🇧" or "Tiếng Việt 🇻🇳"),
        Callback = function(selected)
            if selected:find("Tiếng Việt") then
                CurrentLang = "VI"
            else
                CurrentLang = "EN"
            end
            Window:Destroy()
            OpenMainUI()
        end
    })

    TabSettings:Paragraph({
        Title = T.InfoTitle,
        Content = T.InfoContent
    })

    Window:SelectTab(1)
end

----------------------------------------------------
-- 3. XỬ LÝ NÚT BẤM KEY SYSTEM AN TOÀN
----------------------------------------------------
BtnGetKey.MouseButton1Click:Connect(function()
    KeyInput.Text = CORRECT_KEY
    if setclipboard then
        pcall(function() setclipboard(CORRECT_KEY) end)
        KeyStatus.TextColor3 = Color3.fromRGB(75, 255, 150)
        KeyStatus.Text = "Key copied: " .. CORRECT_KEY
    else
        KeyStatus.TextColor3 = Color3.fromRGB(75, 255, 150)
        KeyStatus.Text = "Key: " .. CORRECT_KEY
    end
end)

BtnFreeKey.MouseButton1Click:Connect(function()
    if LocalPlayer.Name == ADMIN_NAME then
        KeyStatus.TextColor3 = Color3.fromRGB(75, 255, 150)
        KeyStatus.Text = Translations[CurrentLang].KeySuccess
        task.wait(0.5)
        OpenMainUI()
    else
        KeyStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
        KeyStatus.Text = Translations[CurrentLang].NotAdmin
    end
end)

BtnCheckKey.MouseButton1Click:Connect(function()
    local enteredKey = tostring(KeyInput.Text):gsub("%s+", "")
    
    if enteredKey == CORRECT_KEY then
        KeyStatus.TextColor3 = Color3.fromRGB(75, 255, 150)
        KeyStatus.Text = Translations[CurrentLang].KeySuccess
        task.wait(0.5)
        OpenMainUI()
    else
        KeyStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
        KeyStatus.Text = Translations[CurrentLang].KeyFail
    end
end)
