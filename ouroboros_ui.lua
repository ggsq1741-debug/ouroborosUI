do
    pcall(function() print=function() end end)
    pcall(function() warn=function() end end)
end
if not game:IsLoaded() then game.Loaded:Wait() end

local SCRIPT_NAME = "港猫的通缉Wanted"
local SCRIPT_VERSION = "v4.0"

local Library, Window
local ok, result = pcall(function()
    -- 在你的脚本大概第 7 行
local url = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/ouroboros_ui.lua?cb=" .. tostring(os.time())
    local chunk, e = loadstring(game:HttpGet(url))
    if type(chunk) ~= "function" then error("lib compile: "..tostring(e),0) end
    local lib = chunk()
    if type(lib) ~= "table" then error("lib not table",0) end
    return lib
end)
if not ok then error("UI失败: "..tostring(result),0) end
Library = result
Library:SetDefaultTheme("Midnight")

Window = Library:CreateWindow({
    Name = SCRIPT_NAME,
    LoadingSubtitle = SCRIPT_VERSION,
    ToggleUIKeybind = "F",
    ConfigurationSaving = { Enabled = true, FolderName = "WantedUI", FileName = "default" },
    ToggleButton = { Platform = "Mobile" },
    Home = {
        Title = "欢迎使用 " .. SCRIPT_NAME,
        Tier = SCRIPT_VERSION,
        Discord = "QQ售后1109337389",
        Website = "https://t.me/gangmao0259",
        Stats = { "在线人数", "会话时长", "帧率", "网络延迟" },
    },
})

local MainTab   = Window:CreateTab({ Name = "玩家",       Icon = "users" })
local SpookyTab = Window:CreateTab({ Name = "万圣节",     Icon = "ghost" })
local KeyTab    = Window:CreateTab({ Name = "刷钥匙",     Icon = "key" })
local CrossTab  = Window:CreateTab({ Name = "准心",       Icon = "crosshair" })
local MusicTab  = Window:CreateTab({ Name = "音乐",       Icon = "music" })
local SwingTab  = Window:CreateTab({ Name = "甩飞",       Icon = "wind" })
local CarTab    = Window:CreateTab({ Name = "亚洲车王",   Icon = "car" })
local RageTab   = Window:CreateTab({ Name = "愤怒BOT",    Icon = "bot" })
local FarmTab   = Window:CreateTab({ Name = "自动农场",   Icon = "wheat" })
local RemoteTab = Window:CreateTab({ Name = "远程击杀",   Icon = "target" })
local AuraTab   = Window:CreateTab({ Name = "光环",       Icon = "award" })
local AimTab    = Window:CreateTab({ Name = "辅助瞄准",   Icon = "crosshair" })
local RangeTab  = Window:CreateTab({ Name = "范围",       Icon = "move" })
local SilentTab = Window:CreateTab({ Name = "子弹追踪",   Icon = "target" })
local ESPTab    = Window:CreateTab({ Name = "ESP",        Icon = "eye" })
local ESP2Tab   = Window:CreateTab({ Name = "ESP2",       Icon = "eye" })
local ItemTab   = Window:CreateTab({ Name = "物品ESP",    Icon = "box" })
local DeleteTab = Window:CreateTab({ Name = "删除",       Icon = "trash-2" })
local FunTab    = Window:CreateTab({ Name = "娱乐",       Icon = "zap" })
local ShopTab   = Window:CreateTab({ Name = "购买",       Icon = "shopping-cart" })
local SettingsTab = Window:CreateTab({ Name = "设置",     Icon = "settings" })

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")
local LP=Players.LocalPlayer

local function N(t,c,d) Library:Notify({Title=t or "通知",Content=c or "",Type="Info",Duration=d or 3}) end

-- 防检测 Hook
local HV=false
do
    local m=getrawmetatable(game); local o=m.__index
    setreadonly(m,false)
    m.__index=newcclosure(function(s,k)
        if HV and (k=="AssemblyLinearVelocity" or k=="Velocity") and s:IsA("BasePart") then return Vector3.new(0,0,0) end
        return o(s,k)
    end)
    setreadonly(m,true)
end

-- 目标玩家加入提示
do
    local T={"Suponjibobu00","YK666308","某某某3"}; local S={}
    for _,n in ipairs(T) do S[string.lower(n)]=n end
    local function show(name)
        local g=LP:WaitForChild("PlayerGui"); local old=g:FindFirstChild("TgtNotify"); if old then old:Destroy() end
        local sg=Instance.new("ScreenGui"); sg.Name="TgtNotify"; sg.ResetOnSpawn=false; sg.IgnoreGuiInset=true; sg.Parent=g
        local f=Instance.new("Frame"); f.Size=UDim2.new(0,400,0,80); f.Position=UDim2.new(0.5,-200,0,50)
        f.BackgroundColor3=Color3.fromRGB(30,30,30); f.BackgroundTransparency=0.2; f.BorderSizePixel=0; f.Parent=sg
        Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
        local st=Instance.new("UIStroke",f); st.Color=Color3.fromRGB(255,80,80); st.Thickness=2
        local t1=Instance.new("TextLabel",f); t1.Size=UDim2.new(1,0,0,30); t1.Position=UDim2.new(0,0,0,8)
        t1.BackgroundTransparency=1; t1.Text="目标玩家加入（作者/管理员）"; t1.TextColor3=Color3.fromRGB(255,80,80)
        t1.TextSize=20; t1.Font=Enum.Font.GothamBold
        local t2=Instance.new("TextLabel",f); t2.Size=UDim2.new(1,0,0,28); t2.Position=UDim2.new(0,0,0,40)
        t2.BackgroundTransparency=1; t2.Text=name.." 加入了服务器！"; t2.TextColor3=Color3.new(1,1,1)
        t2.TextSize=16; t2.Font=Enum.Font.Gotham
        task.spawn(function()
            f.BackgroundTransparency=1; t1.TextTransparency=1; t2.TextTransparency=1
            for i=0,20 do local x=i/20; f.BackgroundTransparency=0.8-0.6*x; t1.TextTransparency=1-x; t2.TextTransparency=1-x; task.wait(0.01) end
            task.wait(30)
            for i=0,20 do local x=i/20; f.BackgroundTransparency=0.2+0.8*x; t1.TextTransparency=x; t2.TextTransparency=x; task.wait(0.01) end
            sg:Destroy()
        end)
        local s=Instance.new("Sound",sg); s.SoundId="rbxassetid://4590662766"; s.Volume=0.9; s:Play()
    end
    local function chk(p) if S[string.lower(p.Name)] then show(p.Name) end end
    for _,p in ipairs(Players:GetPlayers()) do chk(p) end
    Players.PlayerAdded:Connect(chk)
end

Library:Notify({Title="问题",Content="有问题bug联系作者",Type="Info",Duration=20})
Library:Notify({Title="纸飞机",Content="@you25801",Type="Info",Duration=60})
Library:Notify({Title="更新",Content="万圣节功能已加",Type="Success",Duration=15})

-- ==========================================
-- 玩家 Tab（左右均分）
-- ==========================================
local PG_Main_L1 = MainTab:AddLeftGroupbox({Name="联系信息",Icon="info"})
PG_Main_L1:CreateButton({Name="查看联系方式",Callback=function() Library:Notify({Title="联系方式",Content="QQ：1109337389\ndc：https://discord.gg/rEAd5RdNe",Type="Info",Duration=15}) end})

local PG_Main_L2 = MainTab:AddLeftGroupbox({Name="移动增强",Icon="zap"})
local curSpeed,speedConn=1,nil
local function updChar()
    local c=LP.Character; local h=c and c:FindFirstChildOfClass("Humanoid")
    if speedConn then speedConn:Disconnect(); speedConn=nil end
    if not h or curSpeed<=1 then return end
    speedConn=RunService.Heartbeat:Connect(function()
        if not LP.Character then speedConn:Disconnect(); speedConn=nil; return end
        local hh=LP.Character.Humanoid
        if hh.MoveDirection.Magnitude>0 then LP.Character:TranslateBy(hh.MoveDirection*curSpeed/10) end
    end)
end
LP.CharacterAdded:Connect(updChar); task.spawn(updChar)
PG_Main_L2:CreateSlider({Name="超级快跑",Range={1,200},Increment=1,CurrentValue=1,Flag="SuperRun",Callback=function(v) curSpeed=v; updChar() end})

local isInfJump=false
UIS.JumpRequest:Connect(function()
    if isInfJump then local c=LP.Character; if c then local h=c:FindFirstChildOfClass("Humanoid"); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end
end)
PG_Main_L2:CreateToggle({Name="无限跳",CurrentValue=false,Flag="InfJump",Callback=function(v) isInfJump=v end})

local clipConn=nil
PG_Main_L2:CreateToggle({Name="穿墙",CurrentValue=false,Flag="NoClip",Callback=function(v)
    if clipConn then clipConn:Disconnect(); clipConn=nil end
    if v then
        clipConn=RunService.Stepped:Connect(function()
            local c=LP.Character; if not c then return end
            for _,p in ipairs(c:GetChildren()) do if p:IsA("BasePart") then p.CanCollide=false end end
        end)
    else
        local c=LP.Character; if c then for _,p in ipairs(c:GetChildren()) do if p:IsA("BasePart") then p.CanCollide=true end end end
    end
end})

local PG_Main_R1 = MainTab:AddRightGroupbox({Name="飞行模式",Icon="wind"})
local Flying,FlySpeed=false,150
local CAO,CLV,CAT,FConn
local mtf=getrawmetatable(game); local ofi=mtf.__index; setreadonly(mtf,false)
mtf.__index=newcclosure(function(s,k) if Flying and (k=="AssemblyLinearVelocity" or k=="Velocity") and s:IsA("BasePart") then return Vector3.new(0,0,0) end return ofi(s,k) end)
setreadonly(mtf,true)
local function getCM() return require(LP:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule")) end
local function startFly()
    if Flying then return end
    local c=LP.Character or LP.CharacterAdded:Wait(); if not c then return end
    local hrp=c:WaitForChild("HumanoidRootPart"); local mp=workspace:FindFirstChildOfClass("Terrain") or workspace
    local at=Instance.new("Attachment",hrp); at.Name="FlyAtt"
    CAO=Instance.new("AlignOrientation"); CAO.Mode=Enum.OrientationAlignmentMode.OneAttachment; CAO.RigidityEnabled=true
    CAO.MaxTorque=Vector3.new(9e9,9e9,9e9); CAO.CFrame=hrp.CFrame; CAO.Attachment0=at; CAO.Parent=mp
    CLV=Instance.new("LinearVelocity"); CLV.VectorVelocity=Vector3.new(0,0,0); CLV.MaxForce=9e9; CLV.Attachment0=at; CLV.Parent=mp
    CAT=at; Flying=true
    pcall(function() hrp:SetNetworkOwner(LP) end)
    local cm=getCM()
    FConn=RunService.Heartbeat:Connect(function()
        if not Flying or not CLV or not CAO then if FConn then FConn:Disconnect(); FConn=nil end; return end
        local mv=cm:GetMoveVector(); local cam=workspace.CurrentCamera
        local F,B,L,R,Q,E=0,0,0,0,0,0
        F=-mv.Z; B=mv.Z; L=-mv.X; R=mv.X
        if UIS:IsKeyDown(Enum.KeyCode.W) then F=1 end
        if UIS:IsKeyDown(Enum.KeyCode.S) then B=1 end
        if UIS:IsKeyDown(Enum.KeyCode.A) then L=1 end
        if UIS:IsKeyDown(Enum.KeyCode.D) then R=1 end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then Q=1 end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then E=1 end
        local fv=cam.CFrame.LookVector*(F-B)+cam.CFrame.RightVector*(R-L)+Vector3.new(0,1,0)*(Q-E)
        if fv.Magnitude>0 then CLV.VectorVelocity=fv.Unit*FlySpeed else CLV.VectorVelocity=Vector3.new(0,0,0) end
        CAO.CFrame=cam.CFrame
        if c and c:FindFirstChild("Humanoid") then c.Humanoid.PlatformStand=true end
    end)
end
local function stopFly()
    if not Flying then return end; Flying=false
    if FConn then FConn:Disconnect(); FConn=nil end
    local c=LP.Character; if c and c:FindFirstChild("Humanoid") then c.Humanoid.PlatformStand=false end
    if CAO then CAO:Destroy(); CAO=nil end
    if CLV then CLV:Destroy(); CLV=nil end
    if CAT then CAT:Destroy(); CAT=nil end
end
PG_Main_R1:CreateToggle({Name="飞行模式",CurrentValue=false,Flag="FlyMode",Callback=function(v) if v then startFly(); N("飞行","已开启") else stopFly(); N("飞行","已关闭") end end})
PG_Main_R1:CreateSlider({Name="飞行速度",Range={50,400},Increment=10,CurrentValue=150,Flag="FlySpeed",Callback=function(v) FlySpeed=v end})

local PG_Main_R2 = MainTab:AddRightGroupbox({Name="特殊功能",Icon="star"})
local SpinOn,SpinSpeed,SpinConn=false,5,nil
local function StartSpin()
    if SpinConn then return end
    SpinConn=RunService.RenderStepped:Connect(function(dt)
        if not SpinOn then return end
        local c=LP.Character; if not c then return end
        local h=c:FindFirstChild("HumanoidRootPart"); if not h then return end
        h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(SpinSpeed)*dt*60,0)
    end)
end
LP.CharacterAdded:Connect(function() if SpinOn then task.wait(0.5); StartSpin() end end)
PG_Main_R2:CreateToggle({Name="人物自转",CurrentValue=false,Flag="Spin",Callback=function(v) SpinOn=v; if v then StartSpin() else if SpinConn then SpinConn:Disconnect(); SpinConn=nil end end end})
PG_Main_R2:CreateSlider({Name="旋转速度",Range={1,200},Increment=5,CurrentValue=5,Flag="SpinSpeed",Callback=function(v) SpinSpeed=v end})

local HS={Enabled=false,Size=1,Conn=nil}
PG_Main_R2:CreateToggle({Name="修改别人头部大小",CurrentValue=false,Flag="HeadScaler",Callback=function(v)
    HS.Enabled=v
    if HS.Conn then HS.Conn:Disconnect(); HS.Conn=nil end
    if not v then for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("Head") then pcall(function() p.Character.Head.Size=Vector3.new(1,1,1) end) end end; return end
    HS.Conn=RunService.Heartbeat:Connect(function()
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("Head") then pcall(function() p.Character.Head.Size=Vector3.new(HS.Size,HS.Size,HS.Size); p.Character.Head.CanCollide=false end) end end
    end)
end})
PG_Main_R2:CreateSlider({Name="头部尺寸",Range={1,5000},Increment=1,CurrentValue=1,Flag="HeadSize",Callback=function(v) HS.Size=v end})

PG_Main_R2:CreateButton({Name="取消坠落状态",Callback=function()
    local m=getrawmetatable(game); local o=m.__index; setreadonly(m,false)
    m.__index=newcclosure(function(s,k) if (k=="AssemblyLinearVelocity" or k=="Velocity") and s:IsA("BasePart") then return Vector3.new(0,0,0) end return o(s,k) end)
    setreadonly(m,true)
end})
PG_Main_R2:CreateButton({Name="踏空行走",Callback=function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))() end})

PG_Main_R2:CreateButton({Name="空中定住",Callback=function()
    local fz,ly,ch,rt=false,nil,nil,nil
    local function LC() ch=LP.Character or LP.CharacterAdded:Wait(); rt=ch:WaitForChild("HumanoidRootPart") end
    LC(); LP.CharacterAdded:Connect(function() task.wait(1); LC() end)
    local g=Instance.new("ScreenGui"); g.Name="AirFreeze"; g.ResetOnSpawn=false; g.Parent=LP:WaitForChild("PlayerGui")
    local m=Instance.new("Frame",g); m.Size=UDim2.new(0,90,0,90); m.Position=UDim2.new(0.5,-45,0.65,0); m.BackgroundColor3=Color3.fromRGB(25,25,30); m.Active=true; m.Draggable=true
    Instance.new("UICorner",m).CornerRadius=UDim.new(0,12)
    local tl=Instance.new("TextLabel",m); tl.Size=UDim2.new(1,0,0,26); tl.BackgroundTransparency=1; tl.Text="定"; tl.TextColor3=Color3.new(1,1,1); tl.TextSize=16
    local b=Instance.new("TextButton",m); b.Size=UDim2.new(0,100,0,32); b.Position=UDim2.new(0.5,-50,0.48,0); b.BackgroundColor3=Color3.fromRGB(0,170,255); b.Text="开启"; b.TextColor3=Color3.new(1,1,1); b.TextSize=14
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        fz=not fz
        if fz then b.Text="关闭"; b.BackgroundColor3=Color3.fromRGB(255,70,70); if rt then ly=rt.Position.Y end
        else b.Text="开启"; b.BackgroundColor3=Color3.fromRGB(0,170,255); ly=nil end
    end)
    RunService.Heartbeat:Connect(function()
        if fz and rt and ly then
            local p=rt.Position; rt.AssemblyLinearVelocity=Vector3.zero; rt.AssemblyAngularVelocity=Vector3.zero
            rt.CFrame=CFrame.new(p.X,ly,p.Z)*rt.CFrame.Rotation
        end
    end)
end})

-- ==========================================
-- 万圣节 Tab（左右）
-- ==========================================
local PG_Mob_L = SpookyTab:AddLeftGroupbox({Name="自动打怪",Icon="sword"})
local PG_Mob_R = SpookyTab:AddRightGroupbox({Name="僵尸范围",Icon="ghost"})
do
    local DF=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv")
    local Aura={Enabled=false,Range=300,Interval=0.01,ShowTracer=true,Color=Color3.fromRGB(255,80,80),Width=0.15,Life=0.2,PlaySound=true,SndId="rbxassetid://6607204501",Vol=0.4}
    local Chams={Enabled=false,Size=10,Color=Color3.fromRGB(0,255,0)}
    if DF then
        local DM=require(DF); local Net=DM.load("Network"); local CT=require(RS.Client.Wanted.Modules.ClientTools)
        local MU=DM.load("MathUtil"); local nid=DM.load("NUID"); local FS=Net.FireServer
        local TF=workspace:FindFirstChild("__MobTr") or Instance.new("Folder",workspace); TF.Name="__MobTr"
        local function tracer(a,b)
            if not Aura.ShowTracer then return end
            pcall(function()
                local a0=Instance.new("Attachment",TF); a0.WorldPosition=a
                local a1=Instance.new("Attachment",TF); a1.WorldPosition=b
                local bm=Instance.new("Beam",TF); bm.Attachment0=a0; bm.Attachment1=a1
                bm.Color=ColorSequence.new(Aura.Color); bm.Width0=Aura.Width; bm.Width1=Aura.Width
                bm.LightEmission=1; bm.LightInfluence=0; bm.FaceCamera=true
                bm.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(1,0.9)})
                game:GetService("Debris"):AddItem(bm,Aura.Life); game:GetService("Debris"):AddItem(a0,Aura.Life); game:GetService("Debris"):AddItem(a1,Aura.Life)
            end)
        end
        local function snd()
            if not Aura.PlaySound then return end
            pcall(function() local s=Instance.new("Sound",game:GetService("SoundService")); s.SoundId=Aura.SndId; s.Volume=Aura.Vol; s:Play(); game:GetService("Debris"):AddItem(s,1) end)
        end
        RunService.RenderStepped:Connect(function()
            local mf=workspace:FindFirstChild("Mobs"); if not mf then return end
            if not Chams.Enabled then
                for _,m in ipairs(mf:GetChildren()) do if m:IsA("Model") then
                    local hl=m:FindFirstChild("__Hl"); if hl then hl:Destroy() end
                    local hd=m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart")
                    if hd then local bb=hd:FindFirstChild("__Bb"); if bb then bb:Destroy() end end
                end end
                return
            end
            for _,m in ipairs(mf:GetChildren()) do if m:IsA("Model") then pcall(function()
                local hd=m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart"); local hm=m:FindFirstChildOfClass("Humanoid")
                if hd and hm then
                    local hl=m:FindFirstChild("__Hl")
                    if not hl then hl=Instance.new("Highlight"); hl.Name="__Hl"; hl.FillTransparency=0.3; hl.OutlineTransparency=0; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=m end
                    hl.FillColor=Chams.Color; hl.OutlineColor=Chams.Color
                    local bb=hd:FindFirstChild("__Bb")
                    if not bb then
                        bb=Instance.new("BillboardGui",hd); bb.Name="__Bb"; bb.Size=UDim2.new(0,100,0,25); bb.StudsOffset=Vector3.new(0,1.5,0); bb.AlwaysOnTop=true
                        local tn=Instance.new("TextLabel",bb); tn.Name="TN"; tn.Size=UDim2.new(1,0,0.5,0); tn.BackgroundTransparency=1; tn.Font=Enum.Font.GothamBold; tn.TextSize=Chams.Size; tn.TextStrokeTransparency=0.2; tn.TextColor3=Chams.Color; tn.Text="港猫小弟"
                        local th=Instance.new("TextLabel",bb); th.Name="TH"; th.Size=UDim2.new(1,0,0.5,0); th.Position=UDim2.new(0,0,0.5,0); th.BackgroundTransparency=1; th.Font=Enum.Font.GothamBold; th.TextSize=Chams.Size; th.TextStrokeTransparency=0.2; th.TextColor3=Color3.new(1,1,1)
                    end
                    local rh=m:GetAttribute("health") or hm.Health; local mh=m:GetAttribute("maxHealth") or hm.MaxHealth
                    local tn=bb:FindFirstChild("TN"); if tn then tn.TextColor3=Chams.Color; tn.TextSize=Chams.Size end
                    local th=bb:FindFirstChild("TH")
                    if th then th.Text=string.format("HP: %d/%d",math.floor(rh),math.floor(mh)); th.TextSize=Chams.Size; th.TextColor3=rh<mh*0.3 and Color3.fromRGB(255,50,50) or Color3.new(1,1,1) end
                end
            end) end end
        end)
        local function near()
            local c=LP.Character; if not c then return nil end
            local mh=c:FindFirstChild("HumanoidRootPart"); if not mh then return nil end
            local best,bd=nil,math.huge
            local mf=workspace:FindFirstChild("Mobs"); if not mf then return nil end
            for _,m in ipairs(mf:GetChildren()) do
                local hm=m:FindFirstChildOfClass("Humanoid"); local h=m:FindFirstChild("HumanoidRootPart")
                if hm and h and hm.Health>0 then local d=(mh.Position-h.Position).Magnitude; if d<=Aura.Range and d<bd then bd=d; best=h end end
            end
            return best
        end
        local function fire(t)
            local c=LP.Character; local hd=c and c:FindFirstChild("Head"); if not hd then return end
            local o,tl=pcall(CT.GetLocalEquippedTool); if not o or not tl or not tl.toolId then return end
            local ts=tl.toolState
            if ts and ts.ammo and ts.ammo<=0 then pcall(FS,"reload",tl.toolId); pcall(FS,"chamber",tl.toolId); return end
            local tp,op=t.Position,hd.Position; local dir=tp-op; local bid=nid(); local scf=MU.CompressCFrame(CFrame.new(op,tp))
            pcall(function() FS("shoot",tl.toolId,scf,{{bid,scf}}) end)
            if ts and ts.ammo then ts.ammo=ts.ammo-1 end
            tracer(op,tp); snd()
            local u=dir.Magnitude>0.001 and dir.Unit or hd.CFrame.LookVector
            pcall(function() FS("registerProjectileHits",bid,tl.toolId,{{massLimit=5,hit=t,position=tp,normal=-u,material=t.Material or Enum.Material.Plastic,distance=dir.Magnitude,collisionPoint=tp,direction=u,speed=1196.285,source={sourceType="Bullet",sourceId=bid,sourceToolId=tl.toolId,sourcePlayerId=LP.UserId},hitName="HumanoidRootPart",hitType="mob",mobType=t.Parent.Name}}) end)
        end
        task.spawn(function()
            while true do if Aura.Enabled then pcall(function() local m=near(); if m then fire(m) end end); task.wait(Aura.Interval) else task.wait(0.5) end end
        end)
        PG_Mob_L:CreateToggle({Name="启用怪物光环",CurrentValue=false,Flag="MobAura",Callback=function(v) Aura.Enabled=v; N("怪物光环",v and "开启" or "关闭") end})
        PG_Mob_L:CreateSlider({Name="最大攻击距离",Range={50,2000},Increment=10,CurrentValue=300,Flag="MobRange",Callback=function(v) Aura.Range=v end})
        PG_Mob_L:CreateSlider({Name="极限射速",Range={0.01,1},Increment=0.01,CurrentValue=0.01,Flag="MobRate",Callback=function(v) Aura.Interval=v end})
        PG_Mob_L:CreateToggle({Name="显示弹道",CurrentValue=true,Flag="MobTracer",Callback=function(v) Aura.ShowTracer=v end})
        PG_Mob_L:CreateToggle({Name="命中音效",CurrentValue=true,Flag="MobSnd",Callback=function(v) Aura.PlaySound=v end})
        PG_Mob_L:CreateDropdown({Name="音效选择",Options={"Neverlose","Gamesense","Fatality","Minecraft","经典"},CurrentOption="Neverlose",AllowNone=false,Flag="MobSndSel",Callback=function(v) local M={["Neverlose"]="rbxassetid://6607204501",["Gamesense"]="rbxassetid://5633695679",["Fatality"]="rbxassetid://6607142036",["Minecraft"]="rbxassetid://7151570575",["经典"]="rbxassetid://4590662766"}; Aura.SndId=M[v] or M["Neverlose"] end})
        PG_Mob_L:CreateToggle({Name="怪物内透",CurrentValue=false,Flag="MobChams",Callback=function(v) Chams.Enabled=v end})
        PG_Mob_L:CreateSlider({Name="字体大小",Range={8,18},Increment=1,CurrentValue=10,Flag="MobFont",Callback=function(v) Chams.Size=v end})
        PG_Mob_L:CreateDropdown({Name="透视颜色",Options={"绿色","红色","蓝色","紫色","黄色","白色"},CurrentOption="绿色",AllowNone=false,Flag="MobColor",Callback=function(v) local M={["绿色"]=Color3.fromRGB(0,255,0),["红色"]=Color3.fromRGB(255,50,50),["蓝色"]=Color3.fromRGB(50,150,255),["紫色"]=Color3.fromRGB(180,50,255),["黄色"]=Color3.fromRGB(255,255,50),["白色"]=Color3.fromRGB(255,255,255)}; Chams.Color=M[v] or M["绿色"] end})
    end
    -- 僵尸范围
    local ZS,ZC,ZConn,ZOrig=2.0,Color3.fromRGB(255,50,50),nil,{}
    local function zClean()
        local mf=workspace:FindFirstChild("Mobs")
        if mf then for _,m in ipairs(mf:GetChildren()) do if m:IsA("Model") then
            local hl=m:FindFirstChild("NPC_Marker"); if hl then hl:Destroy() end
            if ZOrig[m] then pcall(function() m:ScaleTo(ZOrig[m].Scale) end) end
        end end end
        table.clear(ZOrig)
    end
    local function zTick()
        local mf=workspace:FindFirstChild("Mobs"); if not mf then return end
        for _,m in ipairs(mf:GetChildren()) do if m:IsA("Model") then
            local hm=m:FindFirstChildOfClass("Humanoid")
            if hm and hm.Health>0 then
                local hl=m:FindFirstChild("NPC_Marker")
                if not hl then hl=Instance.new("Highlight",m); hl.Name="NPC_Marker"; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.FillTransparency=0.5; hl.OutlineTransparency=0 end
                hl.FillColor=ZC; hl.OutlineColor=ZC
                if not ZOrig[m] then local o=1; pcall(function() o=m:GetScale() end); ZOrig[m]={Scale=o} end
                local tg=ZOrig[m].Scale*ZS; local cu=1; pcall(function() cu=m:GetScale() end)
                if math.abs(cu-tg)>0.01 then pcall(function() m:ScaleTo(tg); for _,p in ipairs(m:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=0; p.CanCollide=true; p.Massless=true end end end) end
            end
        end end
    end
    PG_Mob_R:CreateToggle({Name="启用僵尸范围",CurrentValue=false,Flag="ZombieRange",Callback=function(v)
        if v then if not ZConn then ZConn=RunService.RenderStepped:Connect(zTick) end; N("僵尸范围","开启")
        else if ZConn then ZConn:Disconnect(); ZConn=nil end; zClean(); N("僵尸范围","关闭并恢复") end
    end})
    PG_Mob_R:CreateSlider({Name="放大倍数",Range={1,5},Increment=0.5,CurrentValue=2,Flag="ZombieScale",Callback=function(v) ZS=v end})
    PG_Mob_R:CreateDropdown({Name="高亮颜色",Options={"红","绿","蓝","黄","紫","白","青"},CurrentOption="红",AllowNone=false,Flag="ZombieColor",Callback=function(v) local M={["红"]=Color3.fromRGB(255,50,50),["绿"]=Color3.fromRGB(50,255,50),["蓝"]=Color3.fromRGB(50,150,255),["黄"]=Color3.fromRGB(255,255,50),["紫"]=Color3.fromRGB(180,50,255),["白"]=Color3.fromRGB(255,255,255),["青"]=Color3.fromRGB(50,255,255)}; ZC=M[v] or M["红"] end})
end

-- ==========================================
-- 刷钥匙 Tab（左右）
-- ==========================================
local PG_Key_L = KeyTab:AddLeftGroupbox({Name="自动刷钥匙",Icon="key"})
local PG_Key_R = KeyTab:AddRightGroupbox({Name="节点与参数",Icon="map"})
do
    local TS=game:GetService("TweenService")
    local SPOTS={
        CFrame.new(1141,105,1807), CFrame.new(-6994,53,3112), CFrame.new(-4891,21,3726),
        CFrame.new(-4436,559,2352), CFrame.new(-6339,397,-846), CFrame.new(-3472,345,114),
        CFrame.new(-135,40,-1751), CFrame.new(-1115,181,3286), CFrame.new(702,69,2820),
        CFrame.new(-6718,43,728),
    }
    local C={Enabled=false,Loop=true,Speed=80,Wait=0}
    local running,idx=false,1
    local nodeOn,nodeList=false,{}
    local function nodeESP()
        if nodeOn then
            if #nodeList>0 then return end
            for i,cf in ipairs(SPOTS) do
                local a=Instance.new("Part"); a.Name="NodeA_"..i; a.Size=Vector3.new(1,1,1); a.Position=cf.Position; a.Anchored=true; a.CanCollide=false; a.Transparency=1; a.Parent=workspace
                local b=Instance.new("Part"); b.Name="NodeB_"..i; b.Size=Vector3.new(1,200,1); b.CFrame=cf*CFrame.new(0,100,0); b.Anchored=true; b.CanCollide=false; b.Material=Enum.Material.Neon; b.Color=Color3.fromRGB(0,255,160); b.Transparency=0.6; b.Parent=workspace
                local bb=Instance.new("BillboardGui",a); bb.Size=UDim2.new(0,100,0,50); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true; bb.Adornee=a
                local tl=Instance.new("TextLabel",bb); tl.Size=UDim2.new(1,0,1,0); tl.BackgroundTransparency=1; tl.Text="节点 "..i; tl.TextColor3=Color3.fromRGB(0,255,160); tl.Font=Enum.Font.GothamBold; tl.TextSize=20; tl.TextStrokeTransparency=0
                table.insert(nodeList,a); table.insert(nodeList,b)
            end
        else
            for _,o in ipairs(nodeList) do if o and o.Parent then o:Destroy() end end
            table.clear(nodeList)
        end
    end
    local function getHRP() local c=LP.Character; return c and c:FindFirstChild("HumanoidRootPart") end
    local function tw(hrp,cf)
        if not hrp or not hrp.Parent or not C.Enabled then return false end
        local d=(hrp.Position-cf.Position).Magnitude; local dur=math.max(d/math.max(C.Speed,1),0.1)
        local oc=hrp.CanCollide; hrp.CanCollide=false
        local t=TS:Create(hrp,TweenInfo.new(dur,Enum.EasingStyle.Linear),{CFrame=cf}); t:Play()
        while t.PlaybackState==Enum.PlaybackState.Playing do if not C.Enabled then t:Cancel(); hrp.CanCollide=oc; return false end; task.wait(0.05) end
        hrp.CanCollide=oc; return true
    end
    local function waitS(s) if s<=0 then return true end; local t0=tick(); while tick()-t0<s do if not C.Enabled then return false end; task.wait(0.05) end; return true end
    local function run()
        if running then return end
        if #SPOTS==0 then N("刷钥匙","路径空"); C.Enabled=false; return end
        running=true; idx=1
        task.spawn(function()
            while C.Enabled do
                local h=getHRP(); if not h then task.wait(0.5); continue end
                if not tw(h,SPOTS[idx]) then break end
                if not waitS(C.Wait) then break end
                if not C.Enabled then break end
                idx=idx+1
                if idx>#SPOTS then if C.Loop then idx=1 else C.Enabled=false; N("刷钥匙","已跑完"); break end end
                task.wait(0.05)
            end
            running=false
        end)
    end
    PG_Key_L:CreateButton({Name="开前先启用取消坠落和穿墙",Callback=function() Library:Notify({Title="提示",Content="请到【玩家】开启【取消坠落状态】和【穿墙】",Type="Warning",Duration=8}) end})
    PG_Key_L:CreateToggle({Name="自动刷钥匙",CurrentValue=false,Flag="AutoKey",Callback=function(v) C.Enabled=v; if v then run(); N("刷钥匙","开启") else N("刷钥匙","关闭") end end})
    PG_Key_L:CreateToggle({Name="循环跑图",CurrentValue=true,Flag="AutoKeyLoop",Callback=function(v) C.Loop=v end})
    PG_Key_R:CreateToggle({Name="显示节点标记",CurrentValue=false,Flag="NodeESP",Callback=function(v) nodeOn=v; nodeESP() end})
    PG_Key_R:CreateSlider({Name="移动速度",Range={10,80},Increment=5,CurrentValue=80,Flag="KeySpeed",Callback=function(v) C.Speed=v end})
    PG_Key_R:CreateSlider({Name="节点等待",Range={0,10},Increment=0.1,CurrentValue=0,Flag="KeyWait",Callback=function(v) C.Wait=v end})
end

-- ==========================================
-- 准心 Tab（左右）
-- ==========================================
local PG_Cross_L = CrossTab:AddLeftGroupbox({Name="准星样式",Icon="crosshair"})
local PG_Cross_R = CrossTab:AddRightGroupbox({Name="外观",Icon="sliders"})
do
    local C={Enabled=true,Style="十字",Color=Color3.fromRGB(0,255,160),Size=12,Thickness=2,Gap=4,Alpha=0,DotSize=2,Follow=false,Rotate=false,RSpeed=60,Rot=0,AutoColor=true,CSpeed=0.3,Hue=0}
    local g=Instance.new("ScreenGui"); g.Name="CH"; g.ResetOnSpawn=false; g.IgnoreGuiInset=true; g.DisplayOrder=9999
    local okg=pcall(function() g.Parent=game:GetService("CoreGui") end); if not okg or not g.Parent then g.Parent=LP:WaitForChild("PlayerGui") end
    local ct=Instance.new("Frame",g); ct.AnchorPoint=Vector2.new(0.5,0.5); ct.Position=UDim2.fromScale(0.5,0.5); ct.Size=UDim2.fromOffset(100,100); ct.BackgroundTransparency=1
    local ln=Instance.new("Frame",ct); ln.AnchorPoint=Vector2.new(0.5,0.5); ln.Position=UDim2.fromScale(0.5,0.5); ln.Size=UDim2.fromOffset(0,0); ln.BackgroundTransparency=1
    local els={}
    local function clear() for _,e in ipairs(els) do if e and e.Parent then e:Destroy() end end; table.clear(els) end
    local function line(w,h,ox,oy) local l=Instance.new("Frame",ln); l.AnchorPoint=Vector2.new(0.5,0.5); l.Position=UDim2.new(0.5,ox,0.5,oy); l.Size=UDim2.fromOffset(w,h); l.BackgroundColor3=C.Color; l.BackgroundTransparency=C.Alpha; l.BorderSizePixel=0; table.insert(els,l); return l end
    local function dot(s) local d=Instance.new("Frame",ln); d.AnchorPoint=Vector2.new(0.5,0.5); d.Position=UDim2.fromScale(0.5,0.5); d.Size=UDim2.fromOffset(s,s); d.BackgroundColor3=C.Color; d.BackgroundTransparency=C.Alpha; d.BorderSizePixel=0; Instance.new("UICorner",d).CornerRadius=UDim.new(1,0); table.insert(els,d); return d end
    local function circle(s,t) local c=Instance.new("Frame",ln); c.AnchorPoint=Vector2.new(0.5,0.5); c.Position=UDim2.fromScale(0.5,0.5); c.Size=UDim2.fromOffset(s,s); c.BackgroundTransparency=1; Instance.new("UICorner",c).CornerRadius=UDim.new(1,0); local st=Instance.new("UIStroke",c); st.Color=C.Color; st.Thickness=t; st.Transparency=C.Alpha; table.insert(els,c); return c end
    local function upColors() for _,e in ipairs(els) do if e:IsA("Frame") then local s=e:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.Color; s.Transparency=C.Alpha else e.BackgroundColor3=C.Color; e.BackgroundTransparency=C.Alpha end end end end
    local function draw()
        clear(); if not C.Enabled then return end
        local S,T,G=C.Size,C.Thickness,C.Gap
        if C.Style=="十字" then line(T,S,0,-(G+S/2)); line(T,S,0,(G+S/2)); line(S,T,-(G+S/2),0); line(S,T,(G+S/2),0)
        elseif C.Style=="点" then dot(C.DotSize*2)
        elseif C.Style=="圆" then circle(S*2,T)
        elseif C.Style=="十字+点" then line(T,S,0,-(G+S/2)); line(T,S,0,(G+S/2)); line(S,T,-(G+S/2),0); line(S,T,(G+S/2),0); dot(C.DotSize*2)
        elseif C.Style=="圆+点" then circle(S*2,T); dot(C.DotSize*2)
        elseif C.Style=="X形" then for _,o in ipairs({{G+S/2,0},{-(G+S/2),0},{0,G+S/2},{0,-(G+S/2)}}) do line(T,S,o[1],o[2]).Rotation=45 end end
        upColors()
    end
    RunService.RenderStepped:Connect(function(dt)
        if C.Follow then local m=UIS:GetMouseLocation(); ct.Position=UDim2.fromOffset(m.X,m.Y) else ct.Position=UDim2.fromScale(0.5,0.5) end
        if C.Rotate then C.Rot=(C.Rot+C.RSpeed*dt)%360; ct.Rotation=C.Rot end
        if C.AutoColor then C.Hue=(C.Hue+C.CSpeed*dt)%1; C.Color=Color3.fromHSV(C.Hue,1,1); upColors() end
    end)
    draw()
    PG_Cross_L:CreateToggle({Name="启用准星",CurrentValue=true,Flag="CHOn",Callback=function(v) C.Enabled=v; ct.Visible=v; draw() end})
    PG_Cross_L:CreateDropdown({Name="样式",Options={"十字","点","圆","十字+点","圆+点","X形"},CurrentOption="十字",AllowNone=false,Flag="CHStyle",Callback=function(v) C.Style=v; draw() end})
    PG_Cross_L:CreateToggle({Name="跟随鼠标",CurrentValue=false,Flag="CHFollow",Callback=function(v) C.Follow=v end})
    PG_Cross_R:CreateToggle({Name="启用旋转",CurrentValue=false,Flag="CHRot",Callback=function(v) C.Rotate=v; if not v then C.Rot=0; ct.Rotation=0 end end})
    PG_Cross_R:CreateSlider({Name="旋转速度",Range={5,360},Increment=5,CurrentValue=60,Flag="CHRSpeed",Callback=function(v) C.RSpeed=v end})
    PG_Cross_R:CreateToggle({Name="自动变色",CurrentValue=true,Flag="CHAutoColor",Callback=function(v) C.AutoColor=v end})
    PG_Cross_R:CreateSlider({Name="变色速度",Range={0.05,2},Increment=0.05,CurrentValue=0.3,Flag="CHCSpeed",Callback=function(v) C.CSpeed=v end})
    PG_Cross_R:CreateSlider({Name="准星大小",Range={2,40},Increment=1,CurrentValue=12,Flag="CHSize",Callback=function(v) C.Size=v; draw() end})
    PG_Cross_R:CreateSlider({Name="线条粗细",Range={1,8},Increment=1,CurrentValue=2,Flag="CHT",Callback=function(v) C.Thickness=v; draw() end})
    PG_Cross_R:CreateSlider({Name="中心间隙",Range={0,30},Increment=1,CurrentValue=4,Flag="CHGap",Callback=function(v) C.Gap=v; draw() end})
    PG_Cross_R:CreateSlider({Name="中心点大小",Range={1,10},Increment=1,CurrentValue=2,Flag="CHDot",Callback=function(v) C.DotSize=v; draw() end})
    PG_Cross_R:CreateSlider({Name="透明度",Range={0,1},Increment=0.05,CurrentValue=0,Flag="CHAlpha",Callback=function(v) C.Alpha=v; upColors() end})
end

-- ==========================================
-- 音乐 Tab（左右）
-- ==========================================
local PG_Music_L = MusicTab:AddLeftGroupbox({Name="曲目控制",Icon="music"})
local PG_Music_R = MusicTab:AddRightGroupbox({Name="播放参数",Icon="volume"})
do
local SS=game:GetService("SoundService")
local TR={
    ["PHONK"]={url="https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/PHONK.ogg",f="PHONK.ogg"},
    ["挂哥进行曲"]={url="https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/beibeibei.ogg",f="t2.ogg"},
    ["10年老兵"]={url="https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/nklw.ogg",f="t3.ogg"},
    ["美国人"]={url="https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E7%BE%8E%E5%9B%BD%E4%BA%BA.ogg",f="t4.ogg"},
    ["游京"]={url="https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E6%B8%B8%E4%BA%AC.ogg",f="t5.ogg"},
    ["夜色"]={url="https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E5%A4%9C%E8%89%B2.ogg",f="t6.ogg"}
}
local DEF="游京"; local names={}; for n in pairs(TR) do table.insert(names,n) end; table.sort(names)
    _G.WindUIMusic=_G.WindUIMusic or Instance.new("Sound")
    local snd=_G.WindUIMusic; snd.Name="MPlayer"; snd.Volume=0.5; snd.Looped=true; snd.Parent=SS
    local ready,cur=false,DEF
    local function dl(url)
        local c
        if request then local o,r=pcall(request,{Url=url,Method="GET"}); if o and r and r.Body and #r.Body>10000 then c=r.Body end end
        if not c and syn and syn.request then local o,r=pcall(syn.request,{Url=url,Method="GET"}); if o and r and r.Body and #r.Body>10000 then c=r.Body end end
        if not c then local o,x=pcall(function() return game:HttpGet(url) end); if o and x and #x>10000 then c=x end end
        return c
    end
    local function load(name,auto)
        local t=TR[name]; if not t then return end
        cur=name; ready=false; pcall(function() snd:Stop() end)
        task.spawn(function()
            local c=dl(t.url); if not c then N("音乐","下载失败"); return end
            if string.sub(c,1,4)~="OggS" then N("音乐","非ogg"); return end
            if writefile then writefile(t.f,c) end
            snd.SoundId=(getcustomasset or getsynasset)(t.f)
            local t0=tick(); while (snd.TimeLength or 0)<=0 and tick()-t0<8 do task.wait(0.1) end
            ready=true; N("音乐","已加载: "..name); if auto then pcall(function() snd:Play() end) end
        end)
    end
    load(DEF,true)
    PG_Music_L:CreateDropdown({Name="选择曲目",Options=names,CurrentOption=DEF,AllowNone=false,Flag="MusTrack",Callback=function(v) snd:Stop(); load(v,true) end})
    PG_Music_L:CreateToggle({Name="播放/暂停",CurrentValue=true,Flag="MusPlay",Callback=function(v) if v then if not ready then N("音乐","加载中"); return end; snd:Play() else snd:Pause() end end})
    PG_Music_L:CreateButton({Name="重新播放",Callback=function() snd.TimePosition=0; snd:Play() end})
    PG_Music_L:CreateButton({Name="停止",Callback=function() snd:Stop() end})
    PG_Music_R:CreateSlider({Name="音量",Range={0,10},Increment=1,CurrentValue=5,Flag="MusVol",Callback=function(v) snd.Volume=v/10 end})
    PG_Music_R:CreateToggle({Name="循环播放",CurrentValue=true,Flag="MusLoop",Callback=function(v) snd.Looped=v end})
end

-- ==========================================
-- 甩飞 Tab（左右）
-- ==========================================
local PG_Swing_L = SwingTab:AddLeftGroupbox({Name="甩飞触发",Icon="wind"})
local PG_Swing_R = SwingTab:AddRightGroupbox({Name="甩飞参数",Icon="sliders"})
do
    local C={SwingRange=8,SwingFreq=20,SwingSpeed=0.03,TPPerTick=8,AngForce=200000,VMul=3.0,TgtF=2000,TgtA=500000,TPDur=4,CamOff=Vector3.new(0,3,15)}
    local Cam=workspace.CurrentCamera
    local function GC(p) if not p or not p.Parent then return nil end; local c=p.Character; return c and c.Parent and c end
    local function GHRP(c) return c and c:FindFirstChild("HumanoidRootPart") end
    local function GH(c) return c and c:FindFirstChildOfClass("Humanoid") end
    local camConn,camSub
    local function lockCam(s)
        camSub=s; Cam.CameraType=Enum.CameraType.Scriptable; Cam.CameraSubject=s
        if camConn then camConn:Disconnect() end
        camConn=RunService.RenderStepped:Connect(function()
            if not camSub or not camSub.Parent then return end
            local tp=camSub.Position; Cam.CFrame=CFrame.new(tp+C.CamOff,tp); Cam.Focus=CFrame.new(tp)
        end)
    end
    local function unlockCam()
        if camConn then camConn:Disconnect(); camConn=nil end; camSub=nil
        local c=LP.Character; if c then local h=c:FindFirstChildOfClass("Humanoid"); if h then Cam.CameraSubject=h; Cam.CameraType=Enum.CameraType.Custom end end
    end
    local selfC,selfS
    local function enableSelf()
        if selfC then return end
        selfC=RunService.Heartbeat:Connect(function()
            local c=LP.Character; if not c then return end
            local h,hm=GHRP(c),GH(c); if not h or not hm then return end
            pcall(function()
                hm.PlatformStand=false; hm.Sit=false; hm.AutoRotate=true
                local s=hm:GetState()
                if s==Enum.HumanoidStateType.Physics or s==Enum.HumanoidStateType.FallingDown or s==Enum.HumanoidStateType.Ragdoll then hm:ChangeState(Enum.HumanoidStateType.GettingUp) end
                hm:ChangeState(Enum.HumanoidStateType.Running)
                local v=h.AssemblyLinearVelocity; local sy=math.clamp(v.Y,-40,40)
                h.AssemblyAngularVelocity=Vector3.new(C.AngForce,C.AngForce,C.AngForce)
                h.AssemblyLinearVelocity=Vector3.new(v.X*C.VMul,sy,v.Z*C.VMul)
                RunService.RenderStepped:Wait()
                if h and h.Parent then h.AssemblyAngularVelocity=Vector3.zero end
            end)
        end)
        selfS=RunService.Stepped:Connect(function()
            for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
                for _,pt in pairs(p.Character:GetDescendants()) do if pt:IsA("BasePart") then pcall(function() pt.CanCollide=false end) end end
            end end
        end)
    end
    local function disableSelf()
        if selfC then selfC:Disconnect(); selfC=nil end
        if selfS then selfS:Disconnect(); selfS=nil end
    end
    local function forceT(p)
        if not p then return end
        local c=GC(p); if not c then return end
        local h=GHRP(c); if not h then return end
        pcall(function() h:SetNetworkOwner(LP) end)
        pcall(function() h.AssemblyLinearVelocity=Vector3.new(C.TgtF,C.TgtF,C.TgtF); h.AssemblyAngularVelocity=Vector3.new(C.TgtA,C.TgtA,C.TgtA) end)
        local hm=GH(c); if hm then pcall(function() hm.PlatformStand=true; hm:ChangeState(Enum.HumanoidStateType.Physics) end) end
    end
    local sel,isFly=nil,false
    local LF={Running=false,Target=nil,Orig=nil,Conn=nil,Leave=nil}
    local function tpFly(tg,dur)
        if isFly then return false end
        dur=dur or C.TPDur; if not tg then return false end
        local tc=GC(tg); if not tc then return false end
        local mc=GC(LP); local mh=GHRP(mc); if not mh then return false end
        isFly=true; local orig=mh.Position
        lockCam(mh); enableSelf()
        local t0=tick(); local dir=1; local ls=tick(); local det=false
        while tick()-t0<dur do
            local tc2=GC(tg); if not tc2 then break end
            local th=GHRP(tc2)
            if th then
                if tick()-ls>C.SwingSpeed then dir=dir*-1; ls=tick() end
                local mc2=GC(LP); local mh2=GHRP(mc2)
                if mh2 then
                    for i=1,C.TPPerTick do local off=dir*C.SwingRange*(i/C.TPPerTick); pcall(function() mh2.CFrame=CFrame.new(th.Position+th.CFrame.LookVector*off) end) end
                    forceT(tg)
                end
                if not det and th.AssemblyLinearVelocity.Magnitude>30 then det=true end
            end
            task.wait(0.02)
        end
        local fc=GC(LP); local fh=GHRP(fc)
        if fh then pcall(function() fh.CFrame=CFrame.new(orig); fh.AssemblyAngularVelocity=Vector3.zero; fh.AssemblyLinearVelocity=Vector3.zero end) end
        disableSelf(); unlockCam(); isFly=false
        return det
    end
    function LF.Stop()
        if not LF.Running then return end; LF.Running=false
        if LF.Conn then LF.Conn:Disconnect(); LF.Conn=nil end
        if LF.Leave then LF.Leave:Disconnect(); LF.Leave=nil end
        local mc=GC(LP); local mh=GHRP(mc)
        if mh and LF.Orig then pcall(function() mh.CFrame=CFrame.new(LF.Orig); mh.AssemblyAngularVelocity=Vector3.zero; mh.AssemblyLinearVelocity=Vector3.zero end) end
        disableSelf(); unlockCam(); LF.Target=nil; LF.Orig=nil
    end
    local function loopStart(tg)
        if LF.Running then LF.Stop(); task.wait(0.2) end
        if not tg then return false end
        local tc=GC(tg); if not tc then return false end
        local mc=GC(LP); local mh=GHRP(mc); if not mh then return false end
        LF.Running=true; LF.Target=tg; LF.Orig=mh.Position
        lockCam(mh); enableSelf()
        LF.Conn=RunService.Heartbeat:Connect(function()
            if not LF.Running then return end
            local tc2=GC(LF.Target); if not tc2 then LF.Stop(); return end
            local th=GHRP(tc2); if not th then return end
            local dir=math.sin(tick()*C.SwingFreq); local off=dir*C.SwingRange
            local mc2=GC(LP); local mh2=GHRP(mc2)
            if mh2 then for i=1,C.TPPerTick do local sub=off*(i/C.TPPerTick); pcall(function() mh2.CFrame=CFrame.new(th.Position+th.CFrame.LookVector*sub) end) end; forceT(LF.Target) end
        end)
        LF.Leave=Players.PlayerRemoving:Connect(function(p) if p==LF.Target and LF.Running then LF.Stop() end end)
        return true
    end
    local function getNames()
        local t={}; for _,p in pairs(Players:GetPlayers()) do if p~=LP then table.insert(t,p.Name) end end; return t
    end
    PG_Swing_L:CreateDropdown({Name="选择目标",Options=getNames(),CurrentOption=nil,AllowNone=true,Flag="SwingTgt",Callback=function(v) if v and v~="" then sel=Players:FindFirstChild(v); N("已选",v); if LF.Running then LF.Stop(); task.wait(0.2); loopStart(sel) end end end})
    PG_Swing_L:CreateButton({Name="刷新玩家",Callback=function() N("已刷新","共 "..#getNames().." 人") end})
    PG_Swing_L:CreateButton({Name="传送甩飞（单次）",Callback=function()
        if not sel then N("未选择"); return end
        if isFly then N("执行中"); return end
        task.spawn(function() local ok2=tpFly(sel); N(ok2 and "成功" or "结束",sel.Name) end)
    end})
    PG_Swing_L:CreateToggle({Name="循环甩飞",CurrentValue=false,Flag="SwingLoop",Callback=function(v) if v then if not sel then N("未选择"); return end; loopStart(sel); N("循环甩飞","开") else LF.Stop(); N("循环甩飞","关") end end})
    PG_Swing_R:CreateSlider({Name="摆动幅度",Range={2,20},Increment=1,CurrentValue=8,Flag="SwingR",Callback=function(v) C.SwingRange=v end})
    PG_Swing_R:CreateSlider({Name="摆动频率",Range={5,50},Increment=1,CurrentValue=20,Flag="SwingF",Callback=function(v) C.SwingFreq=v end})
    PG_Swing_R:CreateSlider({Name="每次传送",Range={1,20},Increment=1,CurrentValue=8,Flag="SwingT",Callback=function(v) C.TPPerTick=v end})
    PG_Swing_R:CreateSlider({Name="目标施力",Range={100,10000},Increment=100,CurrentValue=2000,Flag="SwingFrc",Callback=function(v) C.TgtF=v end})
    PG_Swing_R:CreateSlider({Name="传送时长",Range={1,10},Increment=1,CurrentValue=4,Flag="SwingD",Callback=function(v) C.TPDur=v end})
    PG_Swing_R:CreateButton({Name="重置默认",Callback=function()
        C.SwingRange=8; C.SwingFreq=20; C.SwingSpeed=0.03; C.TPPerTick=8; C.AngForce=200000; C.VMul=3.0; C.TgtF=2000; C.TgtA=500000; C.TPDur=4; N("已重置")
    end})
    LP.CharacterAdded:Connect(function() task.wait(0.5); if LF.Running then LF.Stop() end; unlockCam() end)
end

-- ==========================================
-- 亚洲车王 Tab（左右）
-- ==========================================
local PG_Car_L = CarTab:AddLeftGroupbox({Name="视角稳定",Icon="camera"})
local PG_Car_R = CarTab:AddRightGroupbox({Name="防抖参数",Icon="sliders"})
do
    local S={Enabled=false,Mode="稳定跟随",Smooth=0.3,LastCF=nil,Conn=nil,SubConn=nil}
    local function getCam() return workspace.CurrentCamera end
    local function restore()
        local c=getCam(); if not c then return end
        if S.SubConn then S.SubConn:Disconnect(); S.SubConn=nil end
        local ch=LP.Character; if ch then local h=ch:FindFirstChildOfClass("Humanoid"); if h then c.CameraSubject=h end end
        c.CameraType=Enum.CameraType.Custom
    end
    local function start()
        local c=getCam(); if not c then return end
        if S.Conn then S.Conn:Disconnect(); S.Conn=nil end
        if S.SubConn then S.SubConn:Disconnect(); S.SubConn=nil end
        if S.Mode=="稳定跟随" then
            local function setSub() local ch=LP.Character; if ch then local h=ch:FindFirstChild("HumanoidRootPart"); if h then c.CameraSubject=h end end end
            setSub()
            S.SubConn=RunService.Heartbeat:Connect(function()
                if not S.Enabled then return end
                local ch=LP.Character; if ch then local h=ch:FindFirstChild("HumanoidRootPart"); if h and c.CameraSubject~=h then c.CameraSubject=h end end
            end)
        elseif S.Mode=="固定朝向" then
            c.CameraType=Enum.CameraType.Scriptable
            local r=c.CFrame-c.CFrame.Position
            S.Conn=RunService.RenderStepped:Connect(function()
                if not S.Enabled then return end
                local cc=getCam(); if not cc then return end
                local ch=LP.Character; if ch then local h=ch:FindFirstChild("HumanoidRootPart"); if h then cc.CFrame=CFrame.new(h.Position+Vector3.new(0,2,0))*r end end
            end)
        elseif S.Mode=="抗抖动" then
            c.CameraType=Enum.CameraType.Custom; S.LastCF=nil
            S.Conn=RunService.RenderStepped:Connect(function()
                if not S.Enabled then return end
                local cc=getCam(); if not cc then return end
                local cur=cc.CFrame
                if not S.LastCF then S.LastCF=cur else local sm=math.clamp(S.Smooth,0,0.95); local ncf=S.LastCF:Lerp(cur,1-sm); cc.CFrame=CFrame.new(ncf.Position)*(cur-cur.Position); S.LastCF=cc.CFrame end
            end)
        end
    end
    local function stop()
        if S.Conn then S.Conn:Disconnect(); S.Conn=nil end
        if S.SubConn then S.SubConn:Disconnect(); S.SubConn=nil end
        restore(); S.LastCF=nil
    end
    LP.CharacterAdded:Connect(function() if S.Enabled then task.wait(1); stop(); S.Enabled=true; start() end end)
    PG_Car_L:CreateToggle({Name="启用视角稳定",CurrentValue=false,Flag="CamStab",Callback=function(v) S.Enabled=v; if v then start() else stop() end end})
    PG_Car_L:CreateDropdown({Name="防抖模式",Options={"稳定跟随","固定朝向","抗抖动"},CurrentOption="稳定跟随",AllowNone=false,Flag="CamStabMode",Callback=function(v) S.Mode=v; if S.Enabled then stop(); S.Enabled=true; start() end end})
    PG_Car_L:CreateButton({Name="重新应用",Callback=function() if not S.Enabled then return end; stop(); S.Enabled=true; start() end})
    PG_Car_R:CreateSlider({Name="平滑程度",Range={0,0.9},Increment=0.05,CurrentValue=0.3,Flag="CamStabSmooth",Callback=function(v) S.Smooth=v end})
    PG_Car_R:CreateButton({Name="飞车脚本",Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/GUI.lua"))() end})
end

-- ==========================================
-- 愤怒BOT Tab（左右）
-- ==========================================
local PG_Rage_L = RageTab:AddLeftGroupbox({Name="Ragebot",Icon="bot"})
local PG_Rage_R = RageTab:AddRightGroupbox({Name="参数与视觉",Icon="sliders"})
do
    local Debris=game:GetService("Debris"); local SS=game:GetService("SoundService")
    local S={On=false,Wall=true,IgCrawl=true,IgKnock=true,IgGrab=true,LastF=0,Rate=0.05,MaxD=20000,Spread=30,Run=false,Conn=nil,TrOn=true,TrC=Color3.fromRGB(255,80,80),TrW=0.25,TrD=1,SndOn=true,SndId="rbxassetid://4590662766",SndVol=0.5,LastTool=nil,LastAmmo=nil,LastAmmoT=0,ReloadAt=0}
    local Ready=false; local nid,Net,MU,CP,FS,CT
    
    pcall(function()
        local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv"); if not df then return end
        local dm=require(df); if type(dm.load)~="function" then return end
        local ld=dm.load; nid=ld("NUID"); Net=ld("Network"); MU=ld("MathUtil"); CP=ld("ClientPlayers"); FS=Net.FireServer
        CT=require(RS.Client.Wanted.Modules.ClientTools); Ready=true
    end)

    local function myChar() local c=LP.Character; return c,c and c:FindFirstChild("HumanoidRootPart"),c and c:FindFirstChild("Head") end
    local function alive(p) local c=p and p.Character; if not c then return false end; local h=c:FindFirstChildOfClass("Humanoid"); return h and h.Health>0 end
    local function prop(p,k) if not CP then return false end; local cc=CP.GetByPlayerId(p.UserId); if cc and cc.GetPlayerProperty then local o,v=pcall(cc.GetPlayerProperty,cc,k); return o and v==true end; return false end
    local function ignore(p) if S.IgCrawl and prop(p,"crawling") then return true end; if S.IgKnock and prop(p,"knocked") then return true end; if S.IgGrab and prop(p,"grabbed") then return true end; return false end
    local function ragdoll() local c=LP.Character; if not c then return true end; local h=c:FindFirstChildOfClass("Humanoid"); if not h or h.Health<=0 then return true end; local st=h:GetState(); return st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown end
    
    local TF=workspace:FindFirstChild("__MT") or Instance.new("Folder",workspace); TF.Name="__MT"
    local function tracer(a,b,col,w,dur)
        if not S.TrOn then return end
        pcall(function()
            local a0=Instance.new("Attachment",TF); a0.WorldPosition=a
            local a1=Instance.new("Attachment",TF); a1.WorldPosition=b
            local bm=Instance.new("Beam",TF); bm.Attachment0=a0; bm.Attachment1=a1
            bm.Color=ColorSequence.new(col or S.TrC); bm.Width0=w or S.TrW; bm.Width1=w or S.TrW
            bm.LightEmission=1; bm.LightInfluence=0; bm.FaceCamera=true
            bm.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(1,0.8)})
            local lf=dur or S.TrD; Debris:AddItem(bm,lf); Debris:AddItem(a0,lf); Debris:AddItem(a1,lf)
        end)
    end
    local function snd() if not S.SndOn then return end; pcall(function() local s=Instance.new("Sound",SS); s.SoundId=S.SndId; s.Volume=S.SndVol; s:Play(); Debris:AddItem(s,2) end) end
    
    local RP=RaycastParams.new(); RP.FilterType=Enum.RaycastFilterType.Exclude; RP.IgnoreWater=true
    local function resolve(from,to,spread,rad)
        local dir=to-from; local dist=dir.Magnitude
        if dist<0.1 then return from,to,true end
        RP.FilterDescendantsInstances={LP.Character}
        local hit=workspace:Raycast(from,dir,RP)
        if not hit or (hit.Position-to).Magnitude<=rad then return from,to,true end
        local u=dir.Unit
        local up=u:Cross(math.abs(u.Y)<0.9 and Vector3.new(0,1,0) or Vector3.new(1,0,0)).Unit
        local right=u:Cross(up).Unit
        for _,off in ipairs({right,-right,-up,up}) do
            local tp=from+off*spread; local th=workspace:Raycast(tp,to-tp,RP)
            if not th or (th.Position-to).Magnitude<=rad then return tp,to,true end
        end
        return nil,nil,false
    end

    -- ⭐ 找敌人：加入白名单过滤
    local function near() 
        local _,mh=myChar(); if not mh then return nil,nil end; local best,bd,bh=nil,math.huge,nil
        for _,p in ipairs(Players:GetPlayers()) do 
            local isWhiteListed = (_G.WL and _G.WL[p.Name] == true)
            if p~=LP and alive(p) and not ignore(p) and not isWhiteListed then
                local c=p.Character; local h=c and c:FindFirstChild("HumanoidRootPart"); local hd=c and c:FindFirstChild("Head")
                if h and hd then local d=(h.Position-mh.Position).Magnitude; if d<=S.MaxD and d<bd then bd,best,bh=d,p,hd end end
            end 
        end; return best,bh
    end

    local function fire(tg,th)
        if not Ready or ragdoll() then return end
        local now=tick(); if now-S.LastF<S.Rate then return end
        local _,mh,mhd=myChar(); if not mh or not mhd then return end
        local o,tl=pcall(CT.GetLocalEquippedTool); if not o or not tl or not tl.toolState then return end
        local ts=tl.toolState
        if S.LastTool~=tl.toolId then S.LastTool,S.ReloadAt=tl.toolId,0; S.LastAmmo,S.LastAmmoT=nil,now end
        local ca=tonumber(ts.ammo)
        if ca~=S.LastAmmo then S.LastAmmo,S.LastAmmoT=ca,now
        elseif now-S.LastAmmoT>1.5 then S.LastAmmoT=now; if now>=S.ReloadAt then S.ReloadAt=now+0.6; pcall(FS,"reload",tl.toolId); pcall(FS,"chamber",tl.toolId) end; return end
        if ca==nil or ts.totalAmmo==nil then return end
        if ca<=0 then if now>=S.ReloadAt then S.ReloadAt=now+0.6; if (tonumber(ts.totalAmmo) or 0)>0 then pcall(FS,"reload",tl.toolId); pcall(FS,"chamber",tl.toolId) end end; return end
        if ts.reloading==true then return end
        local ro,rt,okR=resolve(mhd.Position,th.Position,S.Spread,th.Size.Magnitude); if not okR then return end
        local bid=nid(); local scf=MU.CompressCFrame(CFrame.new(ro,rt))
        FS("shoot",tl.toolId,scf,{{bid,scf}})
        local dir=rt-ro; local u=dir.Magnitude>0.001 and dir.Unit or mh.CFrame.LookVector
        local mz=tl.projectile and tl.projectile.muzzleVelocity; local sp=type(mz)=="number" and mz>0 and mz/0.28 or 1600
        FS("registerProjectileHits",bid,tl.toolId,{{massLimit=5,hit=th,position=rt,normal=-u,material=th.Material or Enum.Material.Plastic,distance=dir.Magnitude,collisionPoint=rt,direction=u,speed=sp,source={sourceType="Bullet",sourceId=bid,sourceToolId=tl.toolId,sourcePlayerId=LP.UserId}}})
        snd(); tracer(ro,rt,S.TrC,S.TrW,S.TrD); S.LastF=now
    end

    if not S.Run then 
        S.Run=true; 
        S.Conn=RunService.Heartbeat:Connect(function() 
            if S.On and Ready then 
                local t,h=near(); 
                if t and h then pcall(fire,t,h) end 
            end 
        end) 
    end

    -- UI 控件部分
    PG_Rage_L:CreateToggle({Name="开启愤怒机器人",CurrentValue=false,Flag="RageOn",Callback=function(v) S.On=v end})
    PG_Rage_L:CreateToggle({Name="穿墙射击",CurrentValue=true,Flag="RageWall",Callback=function(v) S.Wall=v end})
    PG_Rage_L:CreateToggle({Name="忽略倒地/被抓",CurrentValue=true,Flag="RageIgnore",Callback=function(v) S.IgCrawl,S.IgKnock,S.IgGrab=v,v,v end})
    
    PG_Rage_R:CreateSlider({Name="最大距离",Range={50,10000},Increment=50,CurrentValue=2000,Flag="RageD",Callback=function(v) S.MaxD=v end})
    PG_Rage_R:CreateSlider({Name="射击间隔",Range={0.02,0.5},Increment=0.01,CurrentValue=0.05,Flag="RageR",Callback=function(v) S.Rate=v end})
    PG_Rage_R:CreateSlider({Name="穿墙偏移",Range={5,100},Increment=5,CurrentValue=30,Flag="RageS",Callback=function(v) S.Spread=v end})
    PG_Rage_R:CreateToggle({Name="命中音效",CurrentValue=true,Flag="RageSnd",Callback=function(v) S.SndOn=v end})
    PG_Rage_R:CreateSlider({Name="音效音量",Range={0,1},Increment=0.05,CurrentValue=0.5,Flag="RageVol",Callback=function(v) S.SndVol=v end})
    PG_Rage_R:CreateDropdown({Name="音效选择",Options={"经典","Neverlose","Gamesense","Fatality","Minecraft"},CurrentOption="经典",AllowNone=false,Flag="RageSndSel",Callback=function(v) local M={["经典"]="rbxassetid://4590662766",["Neverlose"]="rbxassetid://6607204501",["Gamesense"]="rbxassetid://5633695679",["Fatality"]="rbxassetid://6607142036",["Minecraft"]="rbxassetid://7151570575"}; S.SndId=M[v] or M["经典"] end})
    PG_Rage_R:CreateToggle({Name="显示弹道",CurrentValue=true,Flag="RageTr",Callback=function(v) S.TrOn=v end})
    PG_Rage_R:CreateSlider({Name="弹道宽度",Range={0.05,1},Increment=0.05,CurrentValue=0.25,Flag="RageTrW",Callback=function(v) S.TrW=v end})
    PG_Rage_R:CreateSlider({Name="弹道时长",Range={0.2,5},Increment=0.1,CurrentValue=1,Flag="RageTrD",Callback=function(v) S.TrD=v end})
    PG_Rage_R:CreateDropdown({Name="弹道颜色",Options={"红","绿","蓝","白","黄","紫","青","橙"},CurrentOption="红",AllowNone=false,Flag="RageTrC",Callback=function(v) local M={["红"]=Color3.fromRGB(255,80,80),["绿"]=Color3.fromRGB(80,255,80),["蓝"]=Color3.fromRGB(80,150,255),["白"]=Color3.fromRGB(255,255,255),["黄"]=Color3.fromRGB(255,255,80),["紫"]=Color3.fromRGB(180,80,255),["青"]=Color3.fromRGB(80,255,255),["橙"]=Color3.fromRGB(255,150,60)}; S.TrC=M[v] or M["红"] end})

    -- ⭐ ==========================================
    -- 白名单模块（已移到左侧下方）
    -- ==========================================
    local WL_Group = RageTab:AddLeftGroupbox({Name="白名单",Icon="shield"})
    _G.WL = _G.WL or {}
    local WL_Toggles = {}

    local function addWL(playerName)
        if WL_Toggles[playerName] then return end
        local isAlreadyWL = (_G.WL[playerName] == true)
        
        local toggleObj = WL_Group:CreateToggle({
            Name = playerName,
            CurrentValue = isAlreadyWL,
            Flag = "RageWL_" .. playerName,
            Callback = function(v)
                _G.WL = _G.WL or {}
                if v then
                    _G.WL[playerName] = true
                else
                    _G.WL[playerName] = nil
                end
            end
        })
        WL_Toggles[playerName] = toggleObj
    end

    local function removeWL(playerName)
        local toggleObj = WL_Toggles[playerName]
        if toggleObj then
            pcall(function() toggleObj:Destroy() end)
            WL_Toggles[playerName] = nil
            if _G.WL then _G.WL[playerName] = nil end
        end
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then addWL(p.Name) end
    end

    Players.PlayerAdded:Connect(function(p)
        if p ~= LP then task.wait(0.5); addWL(p.Name) end
    end)

    Players.PlayerRemoving:Connect(function(p)
        if p ~= LP then removeWL(p.Name) end
    end)
end
-- ==========================================
-- 自动农场 Tab（左右）
-- ==========================================
local PG_Farm_L = FarmTab:AddLeftGroupbox({Name="农场主功能",Icon="wheat"})
local PG_Farm_R = FarmTab:AddRightGroupbox({Name="参数/交互类型",Icon="sliders"})
do
    local TS=game:GetService("TweenService")
    local Net,CP,CT,CG,CPs,FS,IS
    pcall(function()
        local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv"); if not df then error("devv") end
        local dm=require(df); local ld=dm.load; Net=ld("Network"); CP=ld("ClientPlayers")
        CT=require(RS.Client.Wanted.Modules.ClientTools); CG=require(RS.Client.Wanted.Modules.ClientGizmos); CPs=require(RS.Client.Wanted.Modules.ClientProps)
        FS=Net.FireServer; IS=Net.InvokeServer
    end)
    local NAMES={["GasStationSafe"]="加油站",["ATM"]="ATM",["Register"]="收银机",["Lootable"]="可搜",["WorldItem"]="世界物品",["WorldBag"]="世界背包",["MainCashPile"]="主钱堆",["CashPallet"]="钱托",["Cash"]="现金",["MilitaryChest"]="军需箱",["PelicanCase"]="鹈鹕箱",["WorldSafe"]="保险箱",["PC Block"]="PC",["WorldItemSpawn"]="刷新点",["Break Glass"]="打玻璃"}
    local function gHRP() local c=LP.Character; return c and c:FindFirstChild("HumanoidRootPart") end
    local function gHum() local c=LP.Character; return c and c:FindFirstChildOfClass("Humanoid") end
    local function gGizmos(hrp)
        local list={}; if not CG then return list end
        local ok2,src=pcall(debug.getupvalue,CG.Get,1); if not ok2 or type(src)~="table" then return list end
        for k,v in pairs(src) do if k and type(v)=="table" and v.position then v.objectId=v.objectId or k; v.dist=hrp and (hrp.Position-v.position).Magnitude or math.huge; table.insert(list,v) end end
        table.sort(list,function(a,b) return a.dist<b.dist end); return list
    end
    local function isCash(g) if type(g)~="table" then return false end; if g.isCurrency==true then return true end; local t=g.gizmoType; return t=="Cash" or t=="CashPallet" or t=="MainCashPile" end
    local function cashLeft(g) if type(g)~="table" then return nil end; if type(g.cashLeft)=="number" then return g.cashLeft end; if g.gizmoState and type(g.gizmoState.amount)=="number" then return g.gizmoState.amount end; return nil end
    local function canInt(g)
        if type(g)~="table" or not g.gizmoType then return false end
        local gs=g.gizmoState; if gs and (gs.broken or gs.searched or gs.robbed or gs.used or gs.isDestroyed) then return false end
        if g.broken or g.searched or g.robbed or g.isCollected then return false end
        if isCash(g) then local l=cashLeft(g); if l~=nil and l<=0 then return false end; return g.objectId~=nil end
        if g.gizmoType=="ATM" or g.gizmoType=="Register" then return g.position~=nil end
        if g.gizmoType=="WorldSafe" or g.gizmoType=="GasStationSafe" then return g.objectId~=nil end
        if g.gizmoType=="PC Block" then return g.objectId~=nil end
        if type(g.AttemptCollect)=="function" or type(g.Interact)=="function" then return true end
        return false
    end
    local function interact(g)
        if type(g)~="table" then return false end
        local t=g.gizmoType
        if t=="ATM" or t=="Register" then local c=CP and CP.Get(); if c and g.position then pcall(function() c:Melee(g.position) end); return true end; return false end
        if t=="WorldSafe" or t=="GasStationSafe" then if g.objectId then FS("gizmoInteraction",g.objectId,"OpenSafe"); return true end; return false end
        if t=="PC Block" then if g.objectId then FS("gizmoInteraction",g.objectId,"Search"); return true end; return false end
        if isCash(g) then if not g.objectId then return false end; local cnt=(t=="CashPallet" or t=="MainCashPile") and 10 or 1; local ids=table.create(cnt,g.objectId); pcall(IS,"collectCurrency",ids); return true end
        if type(g.AttemptCollect)=="function" then pcall(g.AttemptCollect,g); return true end
        if type(g.Interact)=="function" then pcall(g.Interact,g); return true end
        return false
    end
    local F={Enabled=false,Range=15,Opts={"GasStationSafe","ATM","Register","Lootable","WorldItem","WorldBag","MainCashPile","CashPallet","Cash","MilitaryChest","PelicanCase","WorldSafe","PC Block","WorldItemSpawn","Break Glass"}}
    local A={Enabled=false,Opts={"GasStationSafe","ATM","Register","Lootable","WorldItem","WorldBag","MainCashPile","CashPallet","Cash","MilitaryChest","PelicanCase","WorldSafe","PC Block","WorldItemSpawn"},SellPos=Vector3.new(-2826,37,1738),BagThr=0.8}
    local SPOTS={CFrame.new(-616,42,-2855),CFrame.new(-517,66,-2836),CFrame.new(-572,42,-2865),CFrame.new(-386,617,-1193),CFrame.new(-3139,36,1638),CFrame.new(212,40,-2918),CFrame.new(-1678,181,3336),CFrame.new(-490,128,-1677),CFrame.new(-941,74,-1542),CFrame.new(-484,44,-1957),CFrame.new(1874,172,-538),CFrame.new(-1395,272,3205),CFrame.new(-1390,272,3188),CFrame.new(-3185,37,1716)}
    local function match(g,opts) for _,o in ipairs(opts) do if o==g.gizmoType then return true end; if o=="Break Glass" and g.isJewelry then return true end end; return false end
    local function tw(hrp,dur,cf) if not hrp or not hrp.Parent then return end; if not F.Enabled and not A.Enabled then return end; local t=TS:Create(hrp,TweenInfo.new(dur,Enum.EasingStyle.Linear),{CFrame=cf}); t:Play(); while t.PlaybackState==Enum.PlaybackState.Playing do if not F.Enabled and not A.Enabled then t:Cancel(); return end; task.wait(0.05) end end
    local function hasBuzz() if not CT then return false end; local o,it=pcall(CT.GetItems); if not o or type(it)~="table" then return false end; for _,cat in pairs(it) do if type(cat)=="table" then for _,d in pairs(cat) do if d and (d.name=="Buzzsaw" or d.isBuzzSaw) then return true end end end end; return false end
    local function breakGlass(hrp)
        if not CPs or type(CPs.worldPropsById)~="table" then return false end
        local best,bd=nil,12
        for _,p in pairs(CPs.worldPropsById) do if type(p)=="table" and p.name=="JewelSpawn" and not p.isShattered then local pos=(p.GetPosition and p:GetPosition()) or (p.model and p.model.PrimaryPart and p.model.PrimaryPart.Position); if pos then local d=(hrp.Position-pos).Magnitude; if d<bd then bd=d; best=p end end end end
        if not best then return false end
        local c=CP and CP.Get(); if not c then return false end
        local pos=(best.GetPosition and best:GetPosition()) or (best.model and best.model.PrimaryPart and best.model.PrimaryPart.Position)
        if pos then pcall(function() c:Melee(pos) end); return true end; return false
    end
    local function tickAura()
        local h=gHRP(); if not h then return end
        if hasBuzz() then breakGlass(h) end
        local gz=gGizmos(h); local cash,other={},{}
        for _,g in ipairs(gz) do if g.dist<F.Range and canInt(g) and match(g,F.Opts) then if isCash(g) then table.insert(cash,g) else table.insert(other,g) end end end
        for i=1,#cash do interact(cash[i]) end
        table.sort(other,function(a,b) return a.dist<b.dist end)
        for i=1,math.min(3,#other) do interact(other[i]) end
    end
    task.spawn(function() while true do if F.Enabled then pcall(tickAura) end; task.wait(0.03) end end)
    local function bagPct()
        local o,d=pcall(function() return require(RS.Devv).load("ClientData").Get() end); if not o or type(d)~="table" or type(d.bag)~="table" then return 0 end
        local tot=0; if type(d.bag.contents)=="table" then local O=require(RS.Shared.Wanted.Indicies.Objects); for _,n in pairs(d.bag.contents) do if type(n)=="string" then local w=O.GetDataProperty(n,"weight"); if type(w)=="number" then tot=tot+w end end end end
        local U=require(RS.Shared.Wanted.Modules.UpgradeUtil); local cap=U.GetBagCapacity(); if type(cap)~="number" or cap<=0 then cap=type(d.bag.capacity)=="number" and d.bag.capacity or 1 end; return tot/cap
    end
    local function bagFull() if LP:GetAttribute("isBagFull") then return true end; if not LP:GetAttribute("hasLootBag") then return false end; return bagPct()>=A.BagThr end
    local run=false
    local function startAuto()
        if run then return end; run=true
        task.spawn(function()
            while A.Enabled do
                pcall(function()
                    local h=gHRP(); if not h or not gHum() then return end
                    if bagFull() then local dest=Vector3.new(A.SellPos.X,h.Position.Y,A.SellPos.Z); tw(h,(h.Position-dest).Magnitude/150,CFrame.new(dest)); if not A.Enabled then return end; h=gHRP(); if not h then return end; tw(h,3,CFrame.new(A.SellPos)); if not A.Enabled then return end; pcall(IS,"sellLoot","Ofy"); return end
                    local sp=SPOTS[math.random(1,#SPOTS)]; tw(h,math.max((h.Position-sp.Position).Magnitude/100,0.3),sp); if not A.Enabled then return end
                    local gz=gGizmos(gHRP()); local list={}; for _,g in ipairs(gz) do if canInt(g) and match(g,A.Opts) then table.insert(list,g) end end; table.sort(list,function(a,b) return a.dist<b.dist end)
                    for _,g in ipairs(list) do if not A.Enabled then return end; if bagFull() then return end; h=gHRP(); if not h then return end; local cf=g.cframe and (g.cframe*CFrame.new(0,1,-1)) or CFrame.new(g.position); tw(h,math.max((h.Position-cf.Position).Magnitude/60,0.05),cf); interact(g); task.wait((g.gizmoType=="ATM" or g.gizmoType=="Register") and 2.5 or 0.6) end
                end)
                task.wait(0.1)
            end
            run=false
        end)
    end
    PG_Farm_L:CreateToggle({Name="农场光环",CurrentValue=false,Flag="FarmAura",Callback=function(v) F.Enabled=v end})
    PG_Farm_L:CreateToggle({Name="自动农场",CurrentValue=false,Flag="AutoFarm",Callback=function(v) A.Enabled=v; if v then startAuto() end end})
    PG_Farm_R:CreateSlider({Name="触发距离",Range={5,50},Increment=1,CurrentValue=15,Flag="FarmRange",Callback=function(v) F.Range=v end})
    PG_Farm_R:CreateSlider({Name="背包出售阈值",Range={0.5,1},Increment=0.05,CurrentValue=0.8,Flag="FarmBag",Callback=function(v) A.BagThr=v end})
    local AG={Enabled=false,Interval=1.0}
    PG_Farm_R:CreateToggle({Name="自动打玻璃",CurrentValue=false,Flag="AutoGlass",Callback=function(v) AG.Enabled=v; N("打玻璃",v and "开" or "关") end})
    PG_Farm_R:CreateSlider({Name="打玻璃间隔",Range={0.2,5},Increment=0.1,CurrentValue=1.0,Flag="GlassInt",Callback=function(v) AG.Interval=v end})
    task.spawn(function()
        local last=0
        while true do
            if AG.Enabled and CPs and type(CPs.worldPropsById)=="table" then
                pcall(function()
                    local now=tick()
                    if now-last>=0.5 then
                        local c=LP.Character; local h=c and c:FindFirstChild("HumanoidRootPart")
                        if h then
                            local bg,bd=nil,math.huge
                            for g,p in pairs(CPs.worldPropsById) do if type(p)=="table" and p.name=="JewelSpawn" and not p.isShattered then local pos=(p.GetPosition and p:GetPosition()) or (p.model and p.model.PrimaryPart and p.model.PrimaryPart.Position); if pos then local d=(h.Position-pos).Magnitude; if d<bd then bd=d; bg=g end end end end
                            if bg then last=now; pcall(function() FS("breakJewelCase",bg) end) end
                        end
                    end
                end)
            end
            task.wait(AG.Interval)
        end
    end)
    for opt,label in pairs(NAMES) do
        PG_Farm_R:CreateToggle({Name=label,CurrentValue=true,Flag="Farm_"..opt,Callback=function(v) if v then if not table.find(F.Opts,opt) then table.insert(F.Opts,opt) end else for i=#F.Opts,1,-1 do if F.Opts[i]==opt then table.remove(F.Opts,i) end end end end})
    end
end

-- ==========================================
-- 远程击杀 Tab（左右）
-- ==========================================
local PG_Rem_L = RemoteTab:AddLeftGroupbox({Name="远程击杀",Icon="target"})
local PG_Rem_R = RemoteTab:AddRightGroupbox({Name="说明",Icon="info"})
do
    local sel="无"; local loop=false
    local function gH(p) if p and p.Character then return p.Character:FindFirstChild("HumanoidRootPart") end end
    local function names() local t={"无"}; for _,p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(t,p.Name) end end; return t end
    local function tp()
        if sel=="无" then return end
        local mh=gH(LP); if not mh then return end
        local t=Players:FindFirstChild(sel); local th=gH(t); if not th then return end
        pcall(function() th.CFrame=mh.CFrame*CFrame.new(0,0,-4) end)
    end
    PG_Rem_L:CreateDropdown({Name="选择玩家",Options=names(),CurrentOption="无",AllowNone=false,Flag="RemoteTgt",Callback=function(v) sel=v end})
    PG_Rem_L:CreateToggle({Name="循环传送",CurrentValue=false,Flag="RemoteLoop",Callback=function(v) loop=v end})
    PG_Rem_L:CreateButton({Name="远程传送击杀",Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E8%BF%9C%E7%A8%8B%E5%87%BB%E6%9D%80.lua"))() end})
    PG_Rem_R:CreateButton({Name="使用说明",Callback=function() Library:Notify({Title="说明",Content="先开ESP看名字 → 选目标 → 循环传送 → 击杀",Type="Info",Duration=8}) end})
    RunService.RenderStepped:Connect(function() if loop and sel~="无" then tp() end end)
    Players.PlayerRemoving:Connect(function(p) if p.Name==sel then sel="无" end end)
end

-- ==========================================
-- 光环 Tab（左右）
-- ==========================================
local PG_Aura_L = AuraTab:AddLeftGroupbox({Name="踩踏/逮捕",Icon="award"})
local PG_Aura_R = AuraTab:AddRightGroupbox({Name="抓取/救援",Icon="award"})
do
    local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv")
    if df then
        local dm=require(df); local FS=dm.load("Network").FireServer
        local C={Stomp={Enabled=false,Interval=0.5,Range=50},Arrest={Enabled=false,Interval=0.5,Range=50},Grab={Enabled=false,Interval=0.5,Range=50},Revive={Enabled=false,Interval=0.5,Range=50}}
        local function near(r,skipTeam)
            local c=LP.Character; if not c then return nil end; local mh=c:FindFirstChild("HumanoidRootPart"); if not mh then return nil end
            local best,bd=nil,math.huge
            for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
                local st=p.Team and LP.Team and p.Team==LP.Team
                if not (skipTeam and st) then
                    local h=p.Character:FindFirstChild("HumanoidRootPart"); local hm=p.Character:FindFirstChildOfClass("Humanoid")
                    if h and hm and hm.Health>0 then local dn=p:GetAttribute("isDowned") or p:GetAttribute("knocked") or p:GetAttribute("crawling"); local d=(h.Position-mh.Position).Magnitude; if d<=r and d<bd and dn~=false then bd=d; best=p end end
                end
            end end
            return best
        end
        task.spawn(function() while true do if C.Stomp.Enabled then local t=near(C.Stomp.Range,true); if t then pcall(function() FS("finish",t.UserId) end) end end; task.wait(C.Stomp.Interval) end end)
        task.spawn(function() while true do if C.Arrest.Enabled then local t=near(C.Arrest.Range,false); if t then pcall(function() FS("arrest",t.UserId) end) end end; task.wait(C.Arrest.Interval) end end)
        task.spawn(function() while true do if C.Grab.Enabled then local t=near(C.Grab.Range,true); if t then pcall(function() FS("grab",t.UserId) end) end end; task.wait(C.Grab.Interval) end end)
        task.spawn(function() while true do if C.Revive.Enabled then local t=near(C.Revive.Range,false); if t then pcall(function() FS("revive",t.UserId) end) end end; task.wait(C.Revive.Interval) end end)
        PG_Aura_L:CreateToggle({Name="启用踩踏",CurrentValue=false,Flag="AuraStomp",Callback=function(v) C.Stomp.Enabled=v end})
        PG_Aura_L:CreateSlider({Name="踩踏间隔",Range={0.01,5},Increment=0.01,CurrentValue=0.5,Flag="AuraStompI",Callback=function(v) C.Stomp.Interval=v end})
        PG_Aura_L:CreateToggle({Name="启用逮捕",CurrentValue=false,Flag="AuraArrest",Callback=function(v) C.Arrest.Enabled=v end})
        PG_Aura_L:CreateSlider({Name="逮捕间隔",Range={0.01,5},Increment=0.01,CurrentValue=0.5,Flag="AuraArrestI",Callback=function(v) C.Arrest.Interval=v end})
        PG_Aura_R:CreateToggle({Name="启用抓取",CurrentValue=false,Flag="AuraGrab",Callback=function(v) C.Grab.Enabled=v end})
        PG_Aura_R:CreateSlider({Name="抓取间隔",Range={0.01,5},Increment=0.01,CurrentValue=0.5,Flag="AuraGrabI",Callback=function(v) C.Grab.Interval=v end})
        PG_Aura_R:CreateToggle({Name="启用救援",CurrentValue=false,Flag="AuraRevive",Callback=function(v) C.Revive.Enabled=v end})
        PG_Aura_R:CreateSlider({Name="救援间隔",Range={0.01,5},Increment=0.01,CurrentValue=0.5,Flag="AuraReviveI",Callback=function(v) C.Revive.Interval=v end})
    end
end

-- ==========================================
-- 辅助瞄准 Tab（左右）
-- ==========================================
local PG_Aim_L = AimTab:AddLeftGroupbox({Name="辅助瞄准",Icon="crosshair"})
local PG_Aim_R = AimTab:AddRightGroupbox({Name="FOV/阵营",Icon="circle"})
do
    local CS,SD,AAM
    local okM=pcall(function()
        local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv"); if not df then error("devv") end
        local dm=require(df); local ld=dm.load; CS=ld("ClientSettings"); SD=require(RS.Shared.Wanted.Indicies.SettingsData); AAM=require(RS.Client.Wanted.Objects.ClientTool.Components.Tools.Guns.AimAssist)
    end)
    if okM then
        local A={Enabled=false,Part="Body",SX=2.7,SY=1,PX=2.8,PY=2.6,IgTeam=true,Camp="全部",Wall=true,ShowFOV=false,FOVR=250,FOVFix=true,FOVC=Color3.fromRGB(190,120,255),FOVT=1.5,FOVA=0.3,FOVS=64}
        local orig=AAM.Step
        local cir=Drawing.new("Circle"); cir.Visible=false; cir.Filled=false; cir.Thickness=A.FOVT; cir.Transparency=A.FOVA; cir.Color=A.FOVC; cir.NumSides=A.FOVS; cir.Radius=A.FOVR
        cir.Position=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)
        local function upCir()
            cir.Visible=A.ShowFOV and A.Enabled; cir.Radius=A.FOVR; cir.Thickness=A.FOVT; cir.Transparency=A.FOVA; cir.Color=A.FOVC; cir.NumSides=A.FOVS
            if A.ShowFOV and A.Enabled then
                if A.FOVFix then cir.Position=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)
                else local m=UIS:GetMouseLocation(); cir.Position=Vector2.new(m.X,m.Y) end
            end
        end
        RunService.RenderStepped:Connect(function() pcall(upCir) end)
        local function camp(p) if not p then return nil end; local t=p:GetAttribute("currentTeam"); if type(t)=="string" then return t end; if p.Team then return p.Team.Name end; return nil end
        local function isTeam(p) if p==LP then return true end; local a,b=camp(LP),camp(p); if a==nil or b==nil then return p.Team~=nil and p.Team==LP.Team end; return a==b end
        local function allow(p)
            if A.Camp~="全部" then local c=camp(p); if A.Camp=="仅警察" and c~="police" then return false end; if A.Camp=="仅帮派" and c~="syndicate" then return false end; if A.Camp=="仅平民" and c~="civilian" then return false end; return true end
            if A.IgTeam and isTeam(p) then return false end; return true
        end
        local rp=RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.IgnoreWater=true
        local function wall(p)
            if not p or not p.Parent then return true end
            local c=LP.Character; if not c then return true end
            local o=workspace.CurrentCamera.CFrame.Position; local dir=p.Position-o; if dir.Magnitude<0.1 then return false end
            rp.FilterDescendantsInstances={c,workspace.CurrentCamera}
            local r=workspace:Raycast(o,dir,rp); if not r then return false end
            if r.Instance and r.Instance:IsDescendantOf(p.Parent) then return false end
            if (r.Position-p.Position).Magnitude<=0.6 then return false end; return true
        end
        local function step(self,dt)
            local tool=self and self.tool; local ts=tool and tool.toolState
            if not ts or (ts.ammo or 0)<=0 then return orig(self,dt) end
            local c=LP.Character; local h=c and c:FindFirstChild("HumanoidRootPart"); local cam=workspace.CurrentCamera
            if not c or not h or not cam then return orig(self,dt) end
            local cf=cam.CFrame; local vp=cam.ViewportSize; local sx,sy
            if UIS.TouchEnabled then sx,sy=vp.X*0.5,vp.Y*0.5 else local m=UIS:GetMouseLocation(); sx,sy=m.X,m.Y end
            local bs,by,bp=math.huge,nil,nil
            for _,p in ipairs(Players:GetPlayers()) do if p~=LP and allow(p) then
                local pc=p.Character; local ph=pc and pc:FindFirstChildOfClass("Humanoid"); local pr=pc and pc:FindFirstChild("HumanoidRootPart"); local phd=pc and pc:FindFirstChild("Head")
                if pc and ph and ph.Health>0 and pr then
                    local target; if A.Part=="Head" then target=phd or pr else target=pc:FindFirstChild("UpperTorso") or pc:FindFirstChild("Torso") or pr end
                    if not (A.Wall and wall(target)) then
                        local pred=target.Position+(target.AssemblyLinearVelocity or Vector3.zero)*(A.PX*0.01); local rel=cf:PointToObjectSpace(pred); local mag=rel.Magnitude
                        if mag>0.35 then local inv=1/mag; local fwd=-rel.Z*inv
                            if fwd>0.02 then local sp=cam:WorldToViewportPoint(pred); local dx,dy=sp.X-sx,sp.Y-sy; local pd=math.sqrt(dx*dx+dy*dy)
                                if pd<=A.FOVR then local sc=pd*pd; if sc<bs then bs=sc; by=math.deg(math.atan2(rel.X*inv,fwd)); bp=math.deg(math.atan2(rel.Y*inv,fwd)) end end
                            end
                        end
                    end
                end
            end end
            if by then
                local mod=1
                if tool and tool.GetData then local o,d=pcall(tool.GetData,tool); if o and d and d.aimAssistMod then mod=d.aimAssistMod end end
                local spX=A.SX*mod*dt*10; local spY=A.SY*mod*dt*10
                local cx=LP:GetAttribute("xAngle") or 0; local cy=LP:GetAttribute("yAngle") or 0
                LP:SetAttribute("xAngle",(cx-by*spX)%360); LP:SetAttribute("yAngle",math.clamp(cy+bp*spY,-80,80))
            end
        end
        PG_Aim_L:CreateToggle({Name="启用辅助瞄准",CurrentValue=false,Flag="AimOn",Callback=function(v) A.Enabled=v; if v then AAM.Step=step; N("辅助瞄准","开") else AAM.Step=orig; N("辅助瞄准","关") end; upCir() end})
        PG_Aim_L:CreateDropdown({Name="瞄准部位",Options={"Head","Body"},CurrentOption="Body",AllowNone=false,Flag="AimPart",Callback=function(v) A.Part=v end})
        PG_Aim_L:CreateSlider({Name="水平速度",Range={0.1,5},Increment=0.1,CurrentValue=2.7,Flag="AimSX",Callback=function(v) A.SX=v end})
        PG_Aim_L:CreateSlider({Name="垂直速度",Range={0.1,5},Increment=0.1,CurrentValue=1,Flag="AimSY",Callback=function(v) A.SY=v end})
        PG_Aim_L:CreateSlider({Name="水平预判",Range={0,7},Increment=0.01,CurrentValue=2.8,Flag="AimPX",Callback=function(v) A.PX=v end})
        PG_Aim_L:CreateSlider({Name="垂直预判",Range={0,7},Increment=0.01,CurrentValue=2.6,Flag="AimPY",Callback=function(v) A.PY=v end})
        PG_Aim_R:CreateToggle({Name="显示FOV圈",CurrentValue=false,Flag="AimFOV",Callback=function(v) A.ShowFOV=v; upCir() end})
        PG_Aim_R:CreateToggle({Name="屏幕中心固定",CurrentValue=true,Flag="AimFOVFix",Callback=function(v) A.FOVFix=v; upCir() end})
        PG_Aim_R:CreateSlider({Name="FOV半径",Range={20,1000},Increment=5,CurrentValue=250,Flag="AimFOVR",Callback=function(v) A.FOVR=v; upCir() end})
        PG_Aim_R:CreateSlider({Name="线条粗细",Range={1,8},Increment=1,CurrentValue=2,Flag="AimFOVT",Callback=function(v) A.FOVT=v; upCir() end})
        PG_Aim_R:CreateSlider({Name="透明度",Range={0,1},Increment=0.05,CurrentValue=0.3,Flag="AimFOVA",Callback=function(v) A.FOVA=v; upCir() end})
        PG_Aim_R:CreateDropdown({Name="圈颜色",Options={"紫","红","绿","蓝","白","黄"},CurrentOption="紫",AllowNone=false,Flag="AimFOVC",Callback=function(v) local M={["紫"]=Color3.fromRGB(190,120,255),["红"]=Color3.fromRGB(255,80,80),["绿"]=Color3.fromRGB(80,255,120),["蓝"]=Color3.fromRGB(80,160,255),["白"]=Color3.fromRGB(255,255,255),["黄"]=Color3.fromRGB(255,220,80)}; A.FOVC=M[v] or M["紫"]; upCir() end})
        PG_Aim_R:CreateToggle({Name="忽略队友(仅全部)",CurrentValue=true,Flag="AimIgTeam",Callback=function(v) A.IgTeam=v end})
        PG_Aim_R:CreateDropdown({Name="只吸附阵营",Options={"全部","仅警察","仅帮派","仅平民"},CurrentOption="全部",AllowNone=false,Flag="AimCamp",Callback=function(v) A.Camp=v end})
        PG_Aim_R:CreateToggle({Name="掩体检测",CurrentValue=true,Flag="AimWall",Callback=function(v) A.Wall=v end})
    end
end

-- ==========================================
-- 范围 Tab（左右）
-- ==========================================
local PG_Range_L = RangeTab:AddLeftGroupbox({Name="范围",Icon="move"})
local PG_Range_R = RangeTab:AddRightGroupbox({Name="参数",Icon="sliders"})
do
    local sz = 8
    local conn = nil
    local charConns = {} -- 用于记录重生事件，方便彻底清理

    local function exp(p)
        if p == LP then return end
        local c = p.Character; if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid"); if not h or h.Health <= 0 then return end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local s = math.clamp(sz, 1, 100)
        pcall(function()
            hrp.Size = Vector3.new(s, s, s)
            hrp.Transparency = 0.85
            hrp.Color = Color3.fromRGB(190, 190, 190)
            hrp.Material = Enum.Material.Neon
            hrp.CanCollide = false
        end)
    end

    local function rst(p)
        if p == LP then return end
        local c = p.Character; if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        pcall(function()
            hrp.Size = Vector3.new(2, 2, 1)
            hrp.Transparency = 1 -- ⭐ 核心修复：1代表完全透明隐身，0会变成灰方块
            hrp.Color = Color3.fromRGB(163, 162, 165)
            hrp.Material = Enum.Material.Plastic
            hrp.CanCollide = true
        end)
    end

    local function bindP(p)
        if p == LP then return end
        if charConns[p] then charConns[p]:Disconnect() end
        charConns[p] = p.CharacterAdded:Connect(function()
            task.wait(1)
            if conn then exp(p) end
        end)
    end

    PG_Range_L:CreateToggle({Name="范围",CurrentValue=false,Flag="RangeOn",Callback=function(v)
        if v then
            if conn then conn:Disconnect() end
            for _, c in pairs(charConns) do pcall(function() c:Disconnect() end) end
            table.clear(charConns)

            conn = RunService.Heartbeat:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do exp(p) end
            end)

            for _, p in ipairs(Players:GetPlayers()) do bindP(p) end
        else
            if conn then conn:Disconnect(); conn = nil end
            for _, c in pairs(charConns) do pcall(function() c:Disconnect() end) end
            table.clear(charConns)
            for _, p in ipairs(Players:GetPlayers()) do rst(p) end
        end
    end})
    PG_Range_R:CreateSlider({Name="范围大小",Range={1,100},Increment=1,CurrentValue=8,Flag="RangeSz",Callback=function(v) sz=v end})
end

-- ==========================================
-- 静默瞄准 Tab（左右）
-- ==========================================
local PG_Silent_L = SilentTab:AddLeftGroupbox({Name="静默瞄准",Icon="target"})
local PG_Silent_R = SilentTab:AddRightGroupbox({Name="白名单(勾上=不打)",Icon="shield"})
do
    _G.WL=_G.WL or {}
    local S={On=false,Team=false,Vis=false,Part="HumanoidRootPart",FOVR=130,ShowFOV=false,ShowTgt=false,Hit=100,FixFOV=true,TgtR=20,MaxD=500,Prio="准星最近",Wall=false,ShowTr=false,TrFromB=true,TrT=1,TrA=0.3}
    local curPart=nil
    local tc=Drawing.new("Circle"); tc.Visible=false; tc.Thickness=2; tc.Filled=false; tc.Color=Color3.fromRGB(255,0,0)
    local tr=Drawing.new("Line"); tr.Visible=false; tr.Thickness=1; tr.Transparency=0.3; tr.Color=Color3.fromRGB(255,0,0); tr.ZIndex=999
    local fovG=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui")); fovG.Name="SA_FOV"; fovG.ResetOnSpawn=false; fovG.IgnoreGuiInset=true; fovG.Enabled=false
    local fovF=Instance.new("Frame",fovG); fovF.AnchorPoint=Vector2.new(0.5,0.5); fovF.Position=UDim2.fromScale(0.5,0.5); fovF.BackgroundTransparency=1; fovF.Size=UDim2.fromOffset(260,260)
    local fovS=Instance.new("UIStroke",fovF); fovS.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; fovS.Thickness=1; fovS.Transparency=0.5; fovS.Color=Color3.fromRGB(255,0,0)
    Instance.new("UICorner",fovF).CornerRadius=UDim.new(1,0)
    local function sp(v) local p,on=workspace.CurrentCamera:WorldToViewportPoint(v); return Vector2.new(p.X,p.Y),on end
    local function vis(part,o)
        if not part then return false end
        local c=LP.Character; if not c then return false end
        local oo=o or workspace.CurrentCamera.CFrame.Position; local dir=part.Position-oo
        local rp=RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances={c,part.Parent}
        return not workspace:Raycast(oo,dir.Unit*dir.Magnitude,rp)
    end
    local function near()
        local c=LP.Character; local mr=c and c:FindFirstChild("HumanoidRootPart"); if not mr then return nil end
        local ap=S.FixFOV and (workspace.CurrentCamera.ViewportSize/2) or UIS:GetMouseLocation(); local list={}
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and not (_G.WL and _G.WL[p.Name]) and not (S.Team and p.Team==LP.Team) then
                local cc=p.Character; local h=cc and cc:FindFirstChildOfClass("Humanoid")
                if cc and h and h.Health>0 then
                    local pt=cc:FindFirstChild(S.Part) or cc:FindFirstChild("HumanoidRootPart")
                    if pt and not (S.Vis and not vis(pt,cc.Head.Position)) then
                        local d=(mr.Position-pt.Position).Magnitude
                        if d<=S.MaxD then
                            local s,on=sp(pt.Position)
                            if on then local fd=(ap-s).Magnitude; if fd<=S.FOVR then table.insert(list,{char=cc,fov=fd,dist=d,hp=h.Health}) end end
                        end
                    end
                end
            end
        end
        if #list==0 then return nil end
        table.sort(list,function(a,b) if S.Prio=="最低血量" then return a.hp<b.hp elseif S.Prio=="距离最近" then return a.dist<b.dist else return a.fov<b.fov end end)
        return list[1].char
    end
    PG_Silent_L:CreateToggle({Name="启用静默瞄准",CurrentValue=false,Flag="SAOn",Callback=function(v) S.On=v end})
    PG_Silent_L:CreateToggle({Name="队伍检查",CurrentValue=false,Flag="SATeam",Callback=function(v) S.Team=v end})
    PG_Silent_L:CreateToggle({Name="可见性检查",CurrentValue=false,Flag="SAVis",Callback=function(v) S.Vis=v end})
    PG_Silent_L:CreateSlider({Name="命中率",Range={0,100},Increment=1,CurrentValue=100,Flag="SAHit",Callback=function(v) S.Hit=v end})
    PG_Silent_L:CreateDropdown({Name="目标部位",Options={"Head","HumanoidRootPart"},CurrentOption="HumanoidRootPart",AllowNone=false,Flag="SAPart",Callback=function(v) S.Part=v end})
    PG_Silent_L:CreateDropdown({Name="优先模式",Options={"准星最近","距离最近","最低血量"},CurrentOption="准星最近",AllowNone=false,Flag="SAPrio",Callback=function(v) S.Prio=v end})
    PG_Silent_L:CreateSlider({Name="最大距离",Range={10,2000},Increment=10,CurrentValue=500,Flag="SAMaxD",Callback=function(v) S.MaxD=v end})
    PG_Silent_R:CreateToggle({Name="显示FOV圈",CurrentValue=false,Flag="SAFOV",Callback=function(v) fovG.Enabled=v; S.ShowFOV=v end})
    PG_Silent_R:CreateSlider({Name="FOV半径",Range={10,1000},Increment=10,CurrentValue=130,Flag="SAFOVR",Callback=function(v) fovF.Size=UDim2.fromOffset(v*2,v*2); S.FOVR=v end})
    PG_Silent_R:CreateToggle({Name="屏幕中心固定",CurrentValue=true,Flag="SAFix",Callback=function(v) S.FixFOV=v end})
    PG_Silent_R:CreateToggle({Name="显示目标指示器",CurrentValue=false,Flag="SAShow",Callback=function(v) S.ShowTgt=v end})
    PG_Silent_R:CreateSlider({Name="指示器大小",Range={5,50},Increment=1,CurrentValue=20,Flag="SAShowR",Callback=function(v) S.TgtR=v end})
    PG_Silent_R:CreateToggle({Name="显示瞄准射线",CurrentValue=false,Flag="SATr",Callback=function(v) S.ShowTr=v end})
    PG_Silent_R:CreateSlider({Name="射线粗细",Range={1,10},Increment=1,CurrentValue=1,Flag="SATrT",Callback=function(v) S.TrT=v; tr.Thickness=v end})
    PG_Silent_R:CreateSlider({Name="射线透明度",Range={0,1},Increment=0.05,CurrentValue=0.3,Flag="SATrA",Callback=function(v) S.TrA=v; tr.Transparency=v end})
    local created={}
    local function addWL(name)
        if created[name] then return end
        PG_Silent_R:CreateToggle({Name=name,CurrentValue=false,Flag="WL_"..name,Callback=function(v) _G.WL=_G.WL or {}; if v then _G.WL[name]=true else _G.WL[name]=nil end end})
        created[name]=true
    end
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP then addWL(p.Name) end end
    Players.PlayerAdded:Connect(function(p) if p~=LP then task.wait(0.3); addWL(p.Name) end end)
    RunService.RenderStepped:Connect(function()
        curPart=nil; local tg=nil
        if S.On then tg=near() end
        if tg then local h=tg:FindFirstChildOfClass("Humanoid"); if h and h.Health>0 then curPart=tg:FindFirstChild(S.Part) or tg:FindFirstChild("HumanoidRootPart") end end
        if tc then tc.Visible=false; if curPart and S.ShowTgt then local s,on=sp(curPart.Position); if on then tc.Visible=true; tc.Position=s; tc.Radius=S.TgtR end end end
        tr.Visible=false
        if curPart and S.ShowTr and S.On then local s,on=sp(curPart.Position); if on then local fr; if S.TrFromB then fr=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y) else fr=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2) end; tr.From=fr; tr.To=s; tr.Thickness=S.TrT; tr.Transparency=S.TrA; tr.Visible=true end end
        if fovG.Enabled then if S.FixFOV then fovF.Position=UDim2.fromScale(0.5,0.5) else local m=UIS:GetMouseLocation(); fovF.Position=UDim2.fromOffset(m.X,m.Y) end end
    end)
    local oldNC
    oldNC=hookmetamethod(game,"__namecall",newcclosure(function(...)
        local m=getnamecallmethod(); local a={...}
        if S.On and not checkcaller() and curPart then
            if math.random()<=S.Hit/100 then
                if m=="Raycast" then
                    if #a>=3 and typeof(a[2])=="Vector3" and typeof(a[3])=="Vector3" then
                        if a[3].Magnitude>=100 then a[3]=(curPart.Position-a[2]).Unit*1000; return oldNC(unpack(a)) end
                    end
                end
            end
        end
        return oldNC(...)
    end))
end

-- ==========================================
-- ESP Tab（左右）
-- ==========================================
local PG_ESP_L = ESPTab:AddLeftGroupbox({Name="基础显示",Icon="eye"})
local PG_ESP_R = ESPTab:AddRightGroupbox({Name="射线/属性",Icon="activity"})
do
    local C={On=false,MaxD=2000,Box=false,Name=false,HP=false,BoxT=1,TrOn=false,TrO="bottom",TrT=1,TrA=0.35,ShowRank=false,ShowWanted=false,ShowCash=false,ShowStates=false,Col_Police=Color3.fromRGB(80,180,255),Col_Syn=Color3.fromRGB(255,80,80),Col_Neut=Color3.fromRGB(200,200,200),Col_Want=Color3.fromRGB(255,60,60)}
    local Cam=workspace.CurrentCamera
    local function fmt(n) if type(n)~="number" then return "?" end; if n>=1e6 then return string.format("%.2fM",n/1e6) end; if n>=1e3 then return string.format("%.1fK",n/1e3) end; return tostring(math.floor(n)) end
    local function team(p) if not p then return "civilian",nil end; local t=p:GetAttribute("currentTeam"); if t=="police" then return "police",p:GetAttribute("policeRank") end; if t=="syndicate" then return "syndicate",p:GetAttribute("syndicateRank") end; return "civilian",nil end
    local function col(p) if not p then return C.Col_Neut end; if (p:GetAttribute("wantedLevel") or 0)>0 then return C.Col_Want end; local t=p:GetAttribute("currentTeam"); if t=="police" then return C.Col_Police end; if t=="syndicate" then return C.Col_Syn end; return C.Col_Neut end
    local g=Instance.new("ScreenGui"); g.Name="FullESP_"..math.random(1000,9999); g.ResetOnSpawn=false; g.IgnoreGuiInset=true; g.DisplayOrder=9998
    local okg=pcall(function() g.Parent=game:GetService("CoreGui") end); if not okg or not g.Parent then g.Parent=LP:WaitForChild("PlayerGui") end
    local ESP={}
    local function mk()
        local o={}
        o.tr=Drawing.new("Line"); o.tr.Thickness=1; o.tr.Transparency=0.35; o.tr.Color=Color3.new(1,1,1); o.tr.Visible=false
        o.box=Instance.new("Frame",g); o.box.BackgroundTransparency=1; o.box.BorderSizePixel=0; o.box.Visible=false; o.box.ZIndex=2
        o.st=Instance.new("UIStroke",o.box); o.st.Thickness=1; o.st.Color=Color3.new(1,1,1); o.st.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        o.hpb=Instance.new("Frame",o.box); o.hpb.AnchorPoint=Vector2.new(1,0); o.hpb.Position=UDim2.new(0,-1,0,0); o.hpb.Size=UDim2.new(0,3,1,0); o.hpb.BackgroundColor3=Color3.fromRGB(15,15,15); o.hpb.BorderSizePixel=0
        o.hpf=Instance.new("Frame",o.hpb); o.hpf.AnchorPoint=Vector2.new(0,1); o.hpf.Position=UDim2.new(0,0,1,0); o.hpf.Size=UDim2.new(1,0,1,0); o.hpf.BackgroundColor3=Color3.fromRGB(80,255,80); o.hpf.BorderSizePixel=0
        o.nm=Instance.new("TextLabel",o.box); o.nm.AnchorPoint=Vector2.new(0.5,1); o.nm.Position=UDim2.new(0.5,0,0,-2); o.nm.Size=UDim2.new(1,20,0,14); o.nm.BackgroundTransparency=1; o.nm.Font=Enum.Font.GothamBold; o.nm.TextSize=12; o.nm.TextColor3=Color3.new(1,1,1); o.nm.TextStrokeTransparency=0; o.nm.TextXAlignment=Enum.TextXAlignment.Center
        o.l1=Instance.new("TextLabel",o.box); o.l1.AnchorPoint=Vector2.new(0.5,0); o.l1.Position=UDim2.new(0.5,0,1,2); o.l1.Size=UDim2.new(2,0,0,13); o.l1.BackgroundTransparency=1; o.l1.Font=Enum.Font.GothamBold; o.l1.TextSize=11; o.l1.TextColor3=Color3.fromRGB(255,220,100); o.l1.TextStrokeTransparency=0; o.l1.TextXAlignment=Enum.TextXAlignment.Center
        o.l2=Instance.new("TextLabel",o.box); o.l2.AnchorPoint=Vector2.new(0.5,0); o.l2.Position=UDim2.new(0.5,0,1,16); o.l2.Size=UDim2.new(2,0,0,12); o.l2.BackgroundTransparency=1; o.l2.Font=Enum.Font.GothamMedium; o.l2.TextSize=10; o.l2.TextColor3=Color3.fromRGB(200,200,200); o.l2.TextStrokeTransparency=0; o.l2.TextXAlignment=Enum.TextXAlignment.Center
        o.l3=Instance.new("TextLabel",o.box); o.l3.AnchorPoint=Vector2.new(0.5,0); o.l3.Position=UDim2.new(0.5,0,1,28); o.l3.Size=UDim2.new(2,0,0,12); o.l3.BackgroundTransparency=1; o.l3.Font=Enum.Font.GothamMedium; o.l3.TextSize=10; o.l3.TextColor3=Color3.fromRGB(150,220,255); o.l3.TextStrokeTransparency=0; o.l3.TextXAlignment=Enum.TextXAlignment.Center
        return o
    end
    local function destroy(o) if not o then return end; if o.box and o.box.Parent then pcall(function() o.box:Destroy() end) end; if o.tr then pcall(function() o.tr:Remove() end) end end
    local function hide(o) o.box.Visible=false; if o.tr then o.tr.Visible=false end end
    RunService.RenderStepped:Connect(function()
        local list={}
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then table.insert(list,{c=p.Character,plr=p}) end end
        local seen={}; for _,it in ipairs(list) do seen[it.c]=true end
        for ch,o in pairs(ESP) do if not seen[ch] or not ch.Parent then destroy(o); ESP[ch]=nil end end
        if not C.On then for _,o in pairs(ESP) do hide(o) end; return end
        local mh=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart"); local vp=Cam.ViewportSize
        for _,it in ipairs(list) do
            local ch,plr=it.c,it.plr
            if not ESP[ch] then ESP[ch]=mk() end
            local o=ESP[ch]; local h=ch:FindFirstChildOfClass("Humanoid"); local hrp=ch:FindFirstChild("HumanoidRootPart"); local hd=ch:FindFirstChild("Head")
            if not h or not hrp or not hd or h.Health<=0 then hide(o); continue end
            local d=mh and (mh.Position-hrp.Position).Magnitude or 9999
            if d>C.MaxD then hide(o); continue end
            local tp,ton=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,0.5,0)); local bp,bon=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,2.8,0))
            if not ton or not bon then hide(o); continue end
            local ht=math.abs(bp.Y-tp.Y); if ht<1 then hide(o); continue end
            local wd=ht*0.55; local x,y=tp.X-wd/2,tp.Y; local cc=col(plr)
            if C.TrOn then local fx,fy; if C.TrO=="top" then fx,fy=vp.X/2,0 elseif C.TrO=="bottom" then fx,fy=vp.X/2,vp.Y else fx,fy=vp.X/2,vp.Y/2 end; o.tr.From=Vector2.new(fx,fy); o.tr.To=Vector2.new(tp.X,tp.Y); o.tr.Color=cc; o.tr.Thickness=C.TrT; o.tr.Transparency=C.TrA; o.tr.Visible=true else o.tr.Visible=false end
            o.box.Position=UDim2.fromOffset(x,y); o.box.Size=UDim2.fromOffset(wd,ht); o.box.Visible=C.Box; o.st.Color=cc; o.st.Thickness=C.BoxT; o.st.Transparency=C.Box and 0 or 1
            if C.HP then local r=math.clamp(h.Health/math.max(1,h.MaxHealth),0,1); o.hpb.Visible=true; o.hpf.Size=UDim2.new(1,0,r,0); if r>0.6 then o.hpf.BackgroundColor3=Color3.fromRGB(80,255,80) elseif r>0.3 then o.hpf.BackgroundColor3=Color3.fromRGB(255,200,60) else o.hpf.BackgroundColor3=Color3.fromRGB(255,60,60) end else o.hpb.Visible=false end
            if C.Name then o.nm.Text=plr.DisplayName; o.nm.TextColor3=cc; o.nm.Visible=true else o.nm.Visible=false end
            local r1={}; local tm,rk=team(plr)
            if C.ShowRank then if tm=="police" then table.insert(r1,rk and ("警察·"..rk) or "警察") elseif tm=="syndicate" then table.insert(r1,rk and ("帮派·"..rk) or "帮派") else table.insert(r1,"平民") end end
            if C.ShowWanted then local w=plr:GetAttribute("wantedLevel") or 0; local st=plr:GetAttribute("stars") or 0; if w>0 then local s=math.floor(st); local ss=s>0 and (" "..string.rep("★",math.min(s,5))) or ""; table.insert(r1,"通缉"..math.floor(w)..ss) end end
            o.l1.Text=table.concat(r1,"  ·  "); o.l1.TextColor3=cc; o.l1.Visible=C.ShowRank or C.ShowWanted
            local r2={}; if C.ShowCash then local c=plr:GetAttribute("cash"); if type(c)=="number" then table.insert(r2,"$"..fmt(c)) end end; table.insert(r2,string.format("%dm",math.floor(d))); o.l2.Text=table.concat(r2,"  ·  "); o.l2.Visible=C.ShowCash
            local r3={}; if C.ShowStates then if plr:GetAttribute("isDriving") then table.insert(r3,"驾驶·"..(plr:GetAttribute("vehicleType") or "车")) end; if plr:GetAttribute("aiming") then table.insert(r3,"瞄准") end; if plr:GetAttribute("isTyping") then table.insert(r3,"打字") end; if plr:GetAttribute("hasLootBag") then table.insert(r3,"赃物") end end
            if #r3>0 then o.l3.Text=table.concat(r3,"  ·  "); o.l3.Visible=true else o.l3.Visible=false end
        end
    end)
    PG_ESP_L:CreateToggle({Name="启用ESP",CurrentValue=false,Flag="ESPOn",Callback=function(v) C.On=v end})
    PG_ESP_L:CreateSlider({Name="最大距离",Range={100,5000},Increment=50,CurrentValue=2000,Flag="ESPD",Callback=function(v) C.MaxD=v end})
    PG_ESP_L:CreateToggle({Name="方框",CurrentValue=false,Flag="ESPBox",Callback=function(v) C.Box=v end})
    PG_ESP_L:CreateToggle({Name="名字",CurrentValue=false,Flag="ESPName",Callback=function(v) C.Name=v end})
    PG_ESP_L:CreateToggle({Name="血条",CurrentValue=false,Flag="ESPHP",Callback=function(v) C.HP=v end})
    PG_ESP_L:CreateSlider({Name="方框粗细",Range={1,4},Increment=1,CurrentValue=1,Flag="ESPBoxT",Callback=function(v) C.BoxT=v; for _,o in pairs(ESP) do o.st.Thickness=v end end})
    PG_ESP_R:CreateToggle({Name="显示射线",CurrentValue=false,Flag="ESPTr",Callback=function(v) C.TrOn=v end})
    PG_ESP_R:CreateDropdown({Name="射线起点",Options={"屏幕底部","屏幕中心","屏幕顶部"},CurrentOption="屏幕底部",AllowNone=false,Flag="ESPTrO",Callback=function(v) if v=="屏幕底部" then C.TrO="bottom" elseif v=="屏幕中心" then C.TrO="center" else C.TrO="top" end end})
    PG_ESP_R:CreateSlider({Name="射线粗细",Range={1,5},Increment=1,CurrentValue=1,Flag="ESPTrT",Callback=function(v) C.TrT=v end})
    PG_ESP_R:CreateSlider({Name="射线透明度",Range={0,1},Increment=0.05,CurrentValue=0.35,Flag="ESPTrA",Callback=function(v) C.TrA=v end})
    PG_ESP_R:CreateToggle({Name="显示阵营等级",CurrentValue=false,Flag="ESPRank",Callback=function(v) C.ShowRank=v end})
    PG_ESP_R:CreateToggle({Name="显示通缉星数",CurrentValue=false,Flag="ESPWanted",Callback=function(v) C.ShowWanted=v end})
    PG_ESP_R:CreateToggle({Name="显示金钱",CurrentValue=false,Flag="ESPCash",Callback=function(v) C.ShowCash=v end})
    PG_ESP_R:CreateToggle({Name="显示状态",CurrentValue=false,Flag="ESPStates",Callback=function(v) C.ShowStates=v end})
    Players.PlayerRemoving:Connect(function(p) if p.Character and ESP[p.Character] then destroy(ESP[p.Character]); ESP[p.Character]=nil end end)
end

-- ==========================================
-- ESP2 Tab（左右）
-- ==========================================
local PG_ESP2_L = ESP2Tab:AddLeftGroupbox({Name="ESP2",Icon="eye"})
local PG_ESP2_R = ESP2Tab:AddRightGroupbox({Name="参数",Icon="sliders"})
do
    local FS=16; local MD=1500; local BT=1; local BS=2.2
    local Cam=workspace.CurrentCamera
    local en,box,dist,nm,tr,hp=false,false,false,false,false,false
    local obj={}; local inited=false
    local function toS(w) local s,on=Cam:WorldToViewportPoint(w); if not on then return nil end; return Vector2.new(s.X,s.Y) end
    local function get(p) local c=p.Character; if not c then return nil end; local h=c:FindFirstChildOfClass("Humanoid"); local r=c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso"); local hd=c:FindFirstChild("Head"); if not h or not r or not hd then return nil end; return c,h,r,hd end
    local function mk()
        local o={}
        o.B=Drawing.new("Square"); o.B.Filled=false; o.B.Transparency=1
        o.N=Drawing.new("Text"); o.N.Size=FS; o.N.Center=true; o.N.Outline=true; o.N.Font=Drawing.Fonts.Monospace
        o.D=Drawing.new("Text"); o.D.Size=FS-2; o.D.Center=true; o.D.Outline=true; o.D.Font=Drawing.Fonts.Monospace
        o.H=Drawing.new("Text"); o.H.Size=FS-2; o.H.Center=true; o.H.Outline=true; o.H.Font=Drawing.Fonts.Monospace
        o.T=Drawing.new("Line"); o.T.Thickness=1; o.T.Transparency=0.5
        return o
    end
    local function kill(o) if not o then return end; for _,x in pairs(o) do if x and x.Remove then pcall(function() x:Remove() end) end end end
    local function upd(p,o)
        if p==LP then return end; local c,h,r,hd=get(p)
        if not c or not h or h.Health<=0 then for _,x in pairs(o) do x.Visible=false end; return end
        local d=(Cam.CFrame.Position-r.Position).Magnitude; if d>MD then for _,x in pairs(o) do x.Visible=false end; return end
        local hp=toS(hd.Position+Vector3.new(0,0.5,0)); local rp=toS(r.Position)
        if not hp or not rp then for _,x in pairs(o) do x.Visible=false end; return end
        local ht=math.abs(hp.Y-rp.Y)*BS; local wd=ht*0.65; ht=math.max(ht,15); wd=math.max(wd,10)
        local tl=Vector2.new(hp.X-wd/2,hp.Y-ht*0.2); local br=Vector2.new(hp.X+wd/2,tl.Y+ht)
        if box then o.B.Visible=true; o.B.Size=br-tl; o.B.Position=tl; o.B.Thickness=BT; local pc=h.Health/h.MaxHealth; if pc>0.5 then o.B.Color=Color3.fromRGB(0,255,0) elseif pc>0.25 then o.B.Color=Color3.fromRGB(255,165,0) else o.B.Color=Color3.fromRGB(255,0,0) end else o.B.Visible=false end
        if nm then o.N.Visible=true; o.N.Text=p.Name; o.N.Color=Color3.fromRGB(255,255,255); o.N.Position=Vector2.new(hp.X,tl.Y-FS-2) else o.N.Visible=false end
        if dist then o.D.Visible=true; o.D.Text=string.format("[%d m]",math.floor(d)); o.D.Color=Color3.fromRGB(200,200,200); o.D.Position=Vector2.new(hp.X,br.Y+2) else o.D.Visible=false end
        if hp then o.H.Visible=true; o.H.Text=string.format("HP: %d/%d",math.floor(h.Health),math.floor(h.MaxHealth)); o.H.Color=Color3.fromRGB(0,255,0); o.H.Position=Vector2.new(hp.X,br.Y+FS+2) else o.H.Visible=false end
        if tr then o.T.Visible=true; o.T.From=Vector2.new(Cam.ViewportSize.X/2,0); o.T.To=Vector2.new(hp.X,br.Y); o.T.Color=Color3.fromRGB(255,255,255) else o.T.Visible=false end
    end
    local function initP(p) if p==LP then return end; if obj[p] then kill(obj[p]) end; obj[p]=mk() end
    PG_ESP2_L:CreateButton({Name="初始化ESP2",Callback=function()
        if inited then N("ESP2","已初始化"); return end; inited=true
        for _,p in ipairs(Players:GetPlayers()) do initP(p) end
        Players.PlayerAdded:Connect(initP); Players.PlayerRemoving:Connect(function(p) if obj[p] then kill(obj[p]); obj[p]=nil end end)
        RunService.RenderStepped:Connect(function() if not en then return end; for p,o in pairs(obj) do if p.Parent then pcall(upd,p,o) else kill(o); obj[p]=nil end end end)
        N("ESP2","初始化完成")
    end})
    PG_ESP2_L:CreateToggle({Name="ESP2总开关",CurrentValue=false,Flag="ESP2On",Callback=function(v) en=v; if not v then for _,o in pairs(obj) do for _,x in pairs(o) do x.Visible=false end end end end})
    PG_ESP2_L:CreateToggle({Name="方框",CurrentValue=false,Flag="ESP2Box",Callback=function(v) box=v end})
    PG_ESP2_L:CreateToggle({Name="名字",CurrentValue=false,Flag="ESP2Name",Callback=function(v) nm=v end})
    PG_ESP2_L:CreateToggle({Name="距离",CurrentValue=false,Flag="ESP2Dist",Callback=function(v) dist=v end})
    PG_ESP2_L:CreateToggle({Name="血量",CurrentValue=false,Flag="ESP2HP",Callback=function(v) hp=v end})
    PG_ESP2_L:CreateToggle({Name="射线",CurrentValue=false,Flag="ESP2Tr",Callback=function(v) tr=v end})
    PG_ESP2_R:CreateSlider({Name="最大距离",Range={500,5000},Increment=100,CurrentValue=1500,Flag="ESP2MaxD",Callback=function(v) MD=v end})
    PG_ESP2_R:CreateSlider({Name="方框倍数",Range={1.5,3},Increment=0.1,CurrentValue=2.2,Flag="ESP2BS",Callback=function(v) BS=v end})
    PG_ESP2_R:CreateSlider({Name="方框粗细",Range={1,5},Increment=1,CurrentValue=1,Flag="ESP2BT",Callback=function(v) BT=v end})
end

-- ==========================================
-- 物品ESP Tab（左右，表驱动）
-- ==========================================
local PG_Item_L = ItemTab:AddLeftGroupbox({Name="变卖物",Icon="coins"})
local PG_Item_R = ItemTab:AddRightGroupbox({Name="枪械/其他",Icon="crosshair"})
do
    local function mk(obj,col,label,icon)
        if obj:FindFirstChild("ESP_Highlight") then return end
        local hl=Instance.new("Highlight",obj); hl.Name="ESP_Highlight"; hl.FillColor=col; hl.FillTransparency=0.2; hl.OutlineColor=col; hl.OutlineTransparency=0.05; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        local bb=Instance.new("BillboardGui",obj); bb.Name="ESP_Tag"; bb.Size=UDim2.new(0,180,0,45); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true; bb.MaxDistance=999999
        local tl=Instance.new("TextLabel",bb); tl.Size=UDim2.new(1,0,0.5,0); tl.BackgroundTransparency=1; tl.Text=(icon or "").." "..(label or obj.Name); tl.TextColor3=col; tl.TextScaled=true; tl.Font=Enum.Font.GothamBold; tl.TextStrokeTransparency=0.3
        local dl=Instance.new("TextLabel",bb); dl.Size=UDim2.new(1,0,0.5,0); dl.Position=UDim2.new(0,0,0.5,0); dl.BackgroundTransparency=1; dl.Text=" --m"; dl.TextColor3=Color3.new(1,1,1); dl.TextScaled=true; dl.Font=Enum.Font.GothamBold; dl.TextStrokeTransparency=0.3
        RunService.Heartbeat:Connect(function()
            local c=LP.Character; local r=c and c:FindFirstChild("HumanoidRootPart"); if not r or not obj or not obj.Parent then return end
            local pos; if obj:IsA("BasePart") then pos=obj.Position elseif obj:IsA("Model") and obj.PrimaryPart then pos=obj.PrimaryPart.Position elseif obj:IsA("Model") then for _,p in ipairs(obj:GetDescendants()) do if p:IsA("BasePart") then pos=p.Position; break end end end
            if pos then dl.Text=string.format(" %.1fm",(r.Position-pos).Magnitude) end
        end)
    end
    local function scan(name,col,label,icon)
        local n=0
        for _,obj in ipairs(workspace:GetDescendants()) do if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name==name then mk(obj,col,label,icon); n=n+1 end end
        N("ESP物品","标记 "..n.." 个 "..label)
    end
    local function auto(name,col,label,icon)
        task.spawn(function()
            while true do task.wait(5)
                for _,obj in ipairs(workspace:GetDescendants()) do if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name==name and not obj:FindFirstChild("ESP_Highlight") then mk(obj,col,label,icon) end end
            end
        end)
    end
    local function btn(group,name,col,label,icon)
        group:CreateButton({Name=icon.." "..label,Callback=function() scan(name,col,label,icon); auto(name,col,label,icon) end})
    end
    -- 变卖物
    btn(PG_Item_L,"MoneyPrinter",Color3.fromRGB(0,220,80),"印钞机","")
    btn(PG_Item_L,"Gold Bar",Color3.fromRGB(255,210,0),"金块","")
    btn(PG_Item_L,"Bitcoin",Color3.fromRGB(255,153,0),"比特币","")
    btn(PG_Item_L,"SafeDoor",Color3.fromRGB(255,200,80),"保险箱","")
    btn(PG_Item_L,"Amethyst Ring",Color3.fromRGB(180,50,255),"紫水晶","")
    btn(PG_Item_L,"Ruby",Color3.fromRGB(255,0,0),"红宝石","")
    btn(PG_Item_L,"Ruby Ring",Color3.fromRGB(255,50,50),"红宝石戒指","")
    btn(PG_Item_L,"Sapphire",Color3.fromRGB(100,50,255),"蓝宝石","")
    btn(PG_Item_L,"MilitaryChest",Color3.fromRGB(80,200,50),"军需箱","")
    btn(PG_Item_L,"GPU",Color3.fromRGB(50,220,255),"显卡","")
    btn(PG_Item_L,"Cargo Card",Color3.fromRGB(50,100,255),"货物卡","")
    -- 枪械
    btn(PG_Item_R,"AK-47",Color3.fromRGB(255,80,0),"AK-47","")
    btn(PG_Item_R,"AUG A1",Color3.fromRGB(160,50,255),"AUG A1","")
    btn(PG_Item_R,"AWM",Color3.fromRGB(255,50,50),"AWM","")
    btn(PG_Item_R,"M4A1",Color3.fromRGB(0,128,255),"M4A1","")
    btn(PG_Item_R,"RPG-7",Color3.fromRGB(255,128,0),"RPG-7","")
    btn(PG_Item_R,"ARX-160",Color3.fromRGB(50,128,255),"ARX-160","")
end

-- ==========================================
-- 删除 Tab（左右）
-- ==========================================
local PG_Del_L = DeleteTab:AddLeftGroupbox({Name="删除对象",Icon="trash-2"})
local PG_Del_R = DeleteTab:AddRightGroupbox({Name="说明",Icon="info"})
do
    PG_Del_L:CreateButton({Name="删除炮台",Callback=function()
        local t=workspace:FindFirstChild("Local"); t=t and t:FindFirstChild("Gizmos"); t=t and t:FindFirstChild("Turret")
        if t then t:Destroy(); N("删除","炮台已删") else N("删除","未找到炮台") end
    end})
    PG_Del_L:CreateButton({Name="删除红外线",Callback=function()
        local p=workspace:FindFirstChild("Props")
        if p then local l=p:FindFirstChild("Laser"); if l then l:Destroy() end; local la=p:FindFirstChild("LaserAssembly"); if la then la:Destroy() end; if #p:GetChildren()==0 then p:Destroy() end; N("删除","红外线已删") else N("删除","未找到Props") end
    end})
    PG_Del_L:CreateButton({Name="删除红色屏障",Callback=function()
        local p=workspace:FindFirstChild("Props")
        if p then local f=p:FindFirstChild("LaserForcefield"); if f then f:Destroy() end; if #p:GetChildren()==0 then p:Destroy() end; N("删除","屏障已删") else N("删除","未找到Props") end
    end})
    PG_Del_R:CreateButton({Name="仅本地删除",Callback=function() Library:Notify({Title="说明",Content="本页删除仅本地生效，别人视角仍存在",Type="Info",Duration=6}) end})
end

-- ==========================================
-- 娱乐 Tab（左右）
-- ==========================================
local PG_Fun_L = FunTab:AddLeftGroupbox({Name="娱乐功能",Icon="zap"})
local PG_Fun_R = FunTab:AddRightGroupbox({Name="天气/光照",Icon="cloud"})
do
    local burn,bint=false,0.2
    PG_Fun_L:CreateToggle({Name="烈焰战士",CurrentValue=false,Flag="Burn",Callback=function(v)
        burn=v; if not v then N("烈焰","关"); return end
        task.spawn(function()
            local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv"); if not df then burn=false; N("烈焰","需在游戏内"); return end
            local dm=require(df); local FS=dm.load("Network").FireServer
            N("烈焰","开")
            while burn do pcall(function() FS("replicatePlayerProperty","burning",true) end); task.wait(bint) end
        end)
    end})
    PG_Fun_L:CreateSlider({Name="燃烧间隔",Range={0.05,2},Increment=0.05,CurrentValue=0.2,Flag="BurnInt",Callback=function(v) bint=v end})
    PG_Fun_L:CreateButton({Name="大肥鱼小宠物",Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E5%8A%A8%E7%94%BB%E5%BC%B9%E8%B7%B3.lua"))() end})
    PG_Fun_L:CreateButton({Name="创造与魔法",Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/Saint-Orry/refs/heads/main/3.lua"))() end})
    PG_Fun_R:CreateButton({Name="天气",Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/Saint-Orry/refs/heads/main/%E9%80%9A%E7%BC%89%E5%A4%A9%E6%B0%94.lua"))() end})
    PG_Fun_R:CreateButton({Name="天黑1",Callback=function()
        local L=game:GetService("Lighting")
        task.spawn(function()
            while task.wait(0.3) do
                L.ClockTime=2; L.Brightness=0.45; L.Ambient=Color3.new(0.18,0.18,0.25); L.OutdoorAmbient=Color3.new(0.16,0.16,0.22); L.GlobalShadows=true
                local s=L:FindFirstChild("Realistic Skybox"); if s then s.TimeOfDay=0.15; s.StarsVisible=true; s.MoonBrightness=1; s.SunBrightness=0 end
            end
        end)
        N("天黑1","开")
    end})
    PG_Fun_R:CreateButton({Name="天黑2",Callback=function()
        local L=game:GetService("Lighting")
        L.ClockTime=2; L.Brightness=0.35; L.Ambient=Color3.new(0.12,0.12,0.18); L.OutdoorAmbient=Color3.new(0.10,0.10,0.15); L.GlobalShadows=true
        local s=L:FindFirstChild("Realistic Skybox"); if s then s.TimeOfDay=0.15; s.StarsVisible=true; s.MoonBrightness=1; s.SunBrightness=0 end
    end})
end

-- ==========================================
-- 购买 Tab（左右）
-- ==========================================
local PG_Shop_L = ShopTab:AddLeftGroupbox({Name="自动出售",Icon="dollar-sign"})
local PG_Shop_R = ShopTab:AddRightGroupbox({Name="购买/补弹",Icon="shopping-cart"})
do
    local function getNet() local df=RS:FindFirstChild("Devv") or RS:FindFirstChild("devv"); if not df then return nil end; return require(df).load("Network") end
    local selling=false
    PG_Shop_L:CreateButton({Name="奥菲当铺循环出售",Callback=function()
        if selling then N("出售","已在运行"); return end; selling=true
        task.spawn(function()
            local Net=getNet(); if not Net then selling=false; N("出售","需在游戏内"); return end
            local IS=Net.InvokeServer; local SP=Vector3.new(-2826,37,1738); local R=150; local last=0
            while true do
                pcall(function()
                    local c=LP.Character; local h=c and c:FindFirstChild("HumanoidRootPart")
                    if h and (h.Position-SP).Magnitude<=R then local now=tick(); if now-last>0.1 then IS("sellLoot","Ofy"); last=now end end
                end)
                task.wait(0.01)
            end
        end)
        N("出售","循环已启动")
    end})
    PG_Shop_R:CreateButton({Name="C4 购买（250元）",Callback=function()
        local Net=getNet(); if not Net then N("购买","需在游戏内"); return end
        local o,e=pcall(function() Net.InvokeServer("purchaseAmmo",{itemName="C4",itemType="Ammo",ammoToBuyIndex=1,categoryName="Explosives",shopName="Guns"}) end)
        N("购买",o and "C4请求已发" or ("失败: "..tostring(e)))
    end})
    local refill=false
    PG_Shop_R:CreateButton({Name="循环补充弹药",Callback=function()
        if refill then N("补弹","已在运行"); return end; refill=true
        task.spawn(function()
            local Net=getNet(); if not Net then refill=false; N("补弹","需在游戏内"); return end
            while true do pcall(function() Net.InvokeServer("purchaseAmmo",{refillAll=true}) end); task.wait(0.1) end
        end)
        N("补弹","循环已启动")
    end})
end

-- ==========================================
-- 设置 Tab（中文）
-- ==========================================
SettingsTab:CreateConfigManager({ Name = "配置管理", Side = "Left" })
SettingsTab:CreateThemeManager({ Name = "主题管理", Side = "Right" })

Window:LoadAutoload()
Library:Notify({ Title = SCRIPT_NAME, Content = "加载完成 "..SCRIPT_VERSION, Type = "Success", Duration = 5 })

-- ==========================================
-- Ouroboros UI 终极汉化补丁（补充完善版）
-- 直接粘贴到主脚本最后一行并执行
-- ==========================================
task.spawn(function()
    local TransMap = {
        -- 基础界面/按钮
        ["Search"] = "搜索",
        ["Home"] = "主页",
        ["Players"] = "在线人数",
        ["Session"] = "会话时长",
        ["Rejoin"] = "重新加入",
        ["Hop"] = "切换服务器",
        ["Lowest"] = "最低延迟",
        ["Job ID"] = "服务器ID",
        ["Place"] = "地点ID",
        ["LINKS"] = "相关链接",
        ["Community"] = "社区/交流群",
        ["Website"] = "官方网站",
        ["Feature list"] = "功能列表",
        ["features"] = "个功能",
        ["more"] = "更多",
        ["Set"] = "设置",
        
        -- 配置管理
        ["no configs yet"] = "暂无配置",
        ["Config Name:"] = "配置名称：",
        ["Type config name here..."] = "在此输入配置名称...",
        ["Save"] = "保存",
        ["Load"] = "加载",
        ["Delete"] = "删除",
        ["Refresh"] = "刷新",
        ["Auto Load Config"] = "自动加载配置",
        ["Loads the selected config on launch"] = "启动时加载选中的配置",
        ["Rename"] = "重命名",
        ["Reset"] = "重置",
        ["Autoload mode"] = "自动加载模式",
        ["All accounts"] = "所有账号",
        ["This account"] = "当前账号",
        ["share"] = "分享",
        ["Copy code"] = "复制代码",
        ["paste a config code..."] = "粘贴配置代码...",
        ["Import code"] = "导入代码",
        
        -- 主题与颜色
        ["Preset"] = "预设",
        ["theme name"] = "主题名称",
        ["Create"] = "创建",
        ["Theme"] = "主题",
        ["no themes"] = "暂无主题",
        ["Set Default"] = "设为默认",
        ["Default theme: none"] = "默认主题：无",
        ["Accent"] = "强调色",
        ["Background"] = "背景色",
        ["Surface"] = "表面色",
        ["Text"] = "文本",
        ["Muted text"] = "暗色文本",
        
        -- 主题预设名称
        ["Rose"] = "玫瑰",
        ["Midnight"] = "午夜",
        ["Crimson"] = "绯红",
        ["Sunset"] = "日落",
        ["Amber"] = "琥珀",
        ["Gold"] = "黄金",
        ["Cyber"] = "赛博",
        ["Toxic"] = "剧毒",
        ["Christmas"] = "圣诞",
        ["Valentine"] = "情人节",
        ["Lunar"] = "新春",
        ["Tropical"] = "热带",
        ["Dracula"] = "吸血鬼",
        ["Coffee"] = "咖啡",
        ["Aurora"] = "极光",
        ["Ocean"] = "海洋",
        ["Frost"] = "冰霜",
        ["Abyss"] = "深渊",
        ["Mono"] = "单色",
        ["Halloween"] = "万圣节",
        
        -- 菜单与设置
        ["Menu"] = "菜单",
        ["Dim"] = "暗化",
        ["Transparent"] = "透明",
        ["Adaptive Size"] = "自适应大小",
        ["UI Scale"] = "界面缩放",
        ["Density"] = "密度",
        ["Default"] = "默认",
        ["Corner Radius"] = "圆角半径",
        ["None"] = "无",
        ["image id or url"] = "图片链接或ID",
        ["Background Opacity"] = "背景不透明度",
        ["Minimize UI on Start"] = "启动时最小化界面",
        
        -- 天气系统
        ["Weather"] = "天气",
        ["Weather Mode"] = "天气模式",
        ["Screen"] = "屏幕",
        ["Show"] = "显示",
        ["Rain"] = "雨",
        ["Snow"] = "雪",
        ["Hell Fire"] = "地狱火",
        ["Sakura"] = "樱花",
        ["Fireflies"] = "萤火虫",
        ["Matrix"] = "黑客帝国",
        
        -- 拖拽样式
        ["Drag Style"] = "拖拽样式",
        ["Outline"] = "轮廓",
        ["Brackets"] = "括号",
        ["Ghost"] = "幽灵",
        ["Frame"] = "边框",
        ["Off"] = "关闭",
        
        -- 灵动岛
        ["Dynamic Island"] = "灵动岛",
        ["Show on Hover"] = "悬停显示",
        ["Always Show"] = "始终显示",
        ["Compact"] = "紧凑",
        ["Comfortable"] = "舒适"
    }

    local function TranslateObj(obj)
        if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
        
        local function apply()
            local t = obj.Text
            if not t or t == "" then return end
            
            -- 1. 精确匹配
            if TransMap[t] then
                obj.Text = TransMap[t]
                return
            end
            
            -- 2. 正则模糊匹配：处理 "Search 27 options" 等
            if t:match("^Search %d+ options$") then
                obj.Text = string.gsub(t, "Search", "搜索"):gsub("options", "个选项")
                return
            end
            
            -- 3. 正则模糊匹配：处理配置管理状态 "0 saved · loaded: none · auto: none"
            if t:match("^%d+ saved") then
                obj.Text = string.gsub(t, "saved", "已保存")
                obj.Text = string.gsub(obj.Text, "loaded: none", "已加载: 无")
                obj.Text = string.gsub(obj.Text, "auto: none", "自动: 无")
                obj.Text = string.gsub(obj.Text, "auto: hone", "自动: 无") -- 修复原库拼写错误
                return
            end
            
            -- 4. Delta 提示语
            if t:match("Delta") and t:match("executor is supported") then
                obj.Text = "Delta 执行器已完全兼容。"
                return
            end
        end
        
        apply()
        
        -- 监听文本变化，防止被原UI库刷新回英文
        obj:GetPropertyChangedSignal("Text"):Connect(apply)
    end

    local function HookGui(gui)
        if not gui then return end
        for _, obj in ipairs(gui:GetDescendants()) do
            TranslateObj(obj)
        end
        gui.DescendantAdded:Connect(TranslateObj)
    end

    local CoreGui = game:GetService("CoreGui")
    local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    HookGui(CoreGui)
    HookGui(PlayerGui)
    
    local ok, gethui = pcall(function() return gethui() end)
    if ok and gethui then
        HookGui(gethui())
    end
end)


local UserInputService = game:GetService("UserInputService")
local uiVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- 如果是在输入框里打字，就不触发
    if gameProcessed then return end 
    
    if input.KeyCode == Enum.KeyCode.F then
        uiVisible = not uiVisible
        
        -- 同时隐藏/显示窗口和左侧的开关图标
        pcall(function()
            Window:SetVisible(uiVisible) 
        end)
        
        -- 如果上面的方法不起作用，尝试直接改 ScreenGui
        pcall(function()
            local coreGui = game:GetService("CoreGui")
            local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
            local gui = coreGui:FindFirstChild("Ouroboros") or playerGui:FindFirstChild("Ouroboros")
            if gui then
                gui.Enabled = uiVisible
            end
        end)
    end
end)