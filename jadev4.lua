local uis = game:GetService("UserInputService")
local vm = game:GetService("VirtualInputManager")

local ground = Instance.new("Part")
ground.Position = Vector3.new(-87, 5, -17)
ground.Transparency = 0.5
ground.Size = Vector3.new(5000,10,5000)
ground.Anchored = true

local plr = game.Players.LocalPlayer
local mos = plr:GetMouse()
local char = plr.Character

local keybinds = {
    Fly = "F",
    Speed = "X",
    Aimbot = "T",
    autoclick = "E",
    antivoid = "Z",
    knockback = "J",
    reach = "P"
}

local main = Instance.new("ScreenGui",game.CoreGui)
main.Name = "Main"

local Frame = Instance.new("Frame",main)
Frame.Size = UDim2.fromOffset(400,650)
Frame.Active = true
Frame.Draggable = true

local fly = false
local auto = false
_G.speed = false
_G.aimbot = false
_G.autoclick = false
_G.antivoid = false
_G.noKB = false
_G.reach = false

function antivoidFunc()
    if _G.antivoid then
        _G.antivoid = false
        ground.Parent = game.ReplicatedStorage
    else
        _G.antivoid = true
        ground.Parent = workspace
    end    
end

function gc()
    local cPlr = nil
    local cDist = math.huge
    for i,v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer then
            local c = v.Character

            if not game.Players.LocalPlayer.Character then continue end
            if not game.Players.LocalPlayer.Character.HumanoidRootPart then continue end

            if not v.Character then continue end
            
            if not c:FindFirstChild("HumanoidRootPart") then continue end

            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - c.HumanoidRootPart.Position).magnitude < cDist then
                cPlr = v
                cDist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - c.HumanoidRootPart.Position).magnitude
            end
        end
    end
    return cPlr
end

function reachantislow()
    game.Players.LocalPlayer:SetAttribute('Blocking',false)
    game.Players.LocalPlayer:SetAttribute('Reach',100000)
    game.Players.LocalPlayer:SetAttribute('ReachDefect',-100000)

    game.Players.LocalPlayer:SetAttribute('Eating',false)
    game.Players.LocalPlayer:SetAttribute('Goals',9999)
    game.Players.LocalPlayer:SetAttribute('Kills',9999)
    game.ReplicatedStorage.Constants.Melee.Reach.Value = 100000
end

function cosmeticsFunc()
    if not workspace.Camera:WaitForChild('Viewmodel') then return end
    if not game.Players.LocalPlayer.Character:WaitForChild("Sword") then return end
    if not workspace.Camera:WaitForChild('Viewmodel'):WaitForChild("Sword") then return end
    workspace.Camera:WaitForChild('Viewmodel'):WaitForChild("Sword").MainPart.Mesh.VertexColor = Vector3.new(1,1,5) 
    workspace.Camera:WaitForChild('Viewmodel'):WaitForChild("Sword").MainPart.Mesh.Offset = Vector3.new(1,1,-1)
    workspace.Camera:WaitForChild('Viewmodel'):WaitForChild("Sword").MainPart.Material = Enum.Material.ForceField
    game.Players.LocalPlayer.Character.Sword.Handle.Mesh.TextureId = 0
    game.Players.LocalPlayer.Character.Sword.Handle.BrickColor = BrickColor.new("Teal")
    game.Players.LocalPlayer.Character.Sword.Handle.Material = Enum.Material.ForceField
end

function noKB()
    game:GetService("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild('Knit'):FindFirstChild("Services"):FindFirstChild('CombatService'):FindFirstChild("RE").KnockBackApplied:Destroy()
end

function flyFunc()
    if not fly then
        fly = true
        local v = Instance.new('BodyVelocity')
        v.P = 12500
        v.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        v.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 25
        v.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

        local inc = false
        local dec = false

        uis.InputBegan:Connect(function(k,g)
            if g then return end
            if k.KeyCode == Enum.KeyCode.Space then
                if not inc then
                    inc = true
                    while inc do
                            v.Velocity = v.Velocity + Vector3.new(0,5,0)
                        wait()
                    end
                end
            elseif k.KeyCode == Enum.KeyCode.Q then
                if not dec then
                    dec = true
                    while dec do
                        v.Velocity = v.Velocity - Vector3.new(0,5,0)
                        wait()
                    end
                end
            end
        end)

        uis.InputEnded:Connect(function(k,g)
            if g then return end
            if k.KeyCode == Enum.KeyCode.Space then
                if inc then
                    inc = false
                end
            elseif k.KeyCode == Enum.KeyCode.Q then
                if dec then
                    dec = false
                end
            end
        end)

        while wait() do
            if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude ~= 0 then
                if not inc and not dec then
                    v.Velocity = (game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 27) + Vector3.new(0,y,0)
                end
            else
                if not inc and not dec then
                    v.Velocity = Vector3.new(0,0,0)
                end
            end
        end
    
    else
        fly = false
        game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
    end
end

local UIListLayout = Instance.new("UIListLayout",Frame)
local UIPadding = Instance.new("UIPadding",Frame)
UIPadding.PaddingTop = UDim.new(0,15)
UIPadding.PaddingLeft = UDim.new(0,5)

local Fly = Instance.new("TextButton",Frame)
Fly.Size = UDim2.fromOffset(150,50)
Fly.BackgroundColor3 = Color3.fromRGB(30,30,30)
Fly.TextColor3 = Color3.new(255,255,255)
Fly.Text = "Fly"

local flyKB = Instance.new("TextBox",Fly)
flyKB.Size = UDim2.fromOffset(50,50)
flyKB.Position = UDim2.fromOffset(200,0)
flyKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
flyKB.Text = keybinds.Fly

local cosmetics = Instance.new("TextButton",Frame)
cosmetics.Size = UDim2.fromOffset(150,50)
cosmetics.BackgroundColor3 = Color3.fromRGB(30,30,30)
cosmetics.TextColor3 = Color3.new(255,255,255)
cosmetics.Text = "Cosmetics"

local speed = Instance.new("TextButton",Frame)
speed.Size = UDim2.fromOffset(150,50)
speed.BackgroundColor3 = Color3.fromRGB(30,30,30)
speed.TextColor3 = Color3.new(255,255,255)
speed.Text = "Speed"

local speedKB = Instance.new("TextBox",speed)
speedKB.Size = UDim2.fromOffset(50,50)
speedKB.Position = UDim2.fromOffset(200,0)
speedKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
speedKB.Text = keybinds.Speed

local aimbot = Instance.new("TextButton",Frame)
aimbot.Size = UDim2.fromOffset(150,50)
aimbot.BackgroundColor3 = Color3.fromRGB(30,30,30)
aimbot.TextColor3 = Color3.new(255,255,255)
aimbot.Text = "aimbot"

local aimbotKB = Instance.new("TextBox",aimbot)
aimbotKB.Size = UDim2.fromOffset(50,50)
aimbotKB.Position = UDim2.fromOffset(200,0)
aimbotKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
aimbotKB.Text = keybinds.Aimbot

local autoclick = Instance.new("TextButton",Frame)
autoclick.Size = UDim2.fromOffset(150,50)
autoclick.BackgroundColor3 = Color3.fromRGB(30,30,30)
autoclick.TextColor3 = Color3.new(255,255,255)
autoclick.Text = "autoclick"

local autoclickKB = Instance.new("TextBox",autoclick)
autoclickKB.Size = UDim2.fromOffset(50,50)
autoclickKB.Position = UDim2.fromOffset(200,0)
autoclickKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
autoclickKB.Text = keybinds.autoclick

local antivoid = Instance.new("TextButton",Frame)
antivoid.Size = UDim2.fromOffset(150,50)
antivoid.BackgroundColor3 = Color3.fromRGB(30,30,30)
antivoid.TextColor3 = Color3.new(255,255,255)
antivoid.Text = "antivoid"

local antivoidKB = Instance.new("TextBox",antivoid)
antivoidKB.Size = UDim2.fromOffset(50,50)
antivoidKB.Position = UDim2.fromOffset(200,0)
antivoidKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
antivoidKB.Text = keybinds.antivoid

local knockback = Instance.new("TextButton",Frame)
knockback.Size = UDim2.fromOffset(150,50)
knockback.BackgroundColor3 = Color3.fromRGB(30,30,30)
knockback.TextColor3 = Color3.new(255,255,255)
knockback.Text = "anti-knockback"

local knockbackKB = Instance.new("TextBox",knockback)
knockbackKB.Size = UDim2.fromOffset(50,50)
knockbackKB.Position = UDim2.fromOffset(200,0)
knockbackKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
knockbackKB.Text = keybinds.knockback

local reach = Instance.new("TextButton",Frame)
reach.Size = UDim2.fromOffset(150,50)
reach.BackgroundColor3 = Color3.fromRGB(30,30,30)
reach.TextColor3 = Color3.new(255,255,255)
reach.Text = "reach + antislow"

local reachKB = Instance.new("TextBox",reach)
reachKB.Size = UDim2.fromOffset(50,50)
reachKB.Position = UDim2.fromOffset(200,0)
reachKB.PlaceholderColor3 = Color3.fromRGB(0,0,0)
reachKB.Text = keybinds.reach


flyKB.FocusLost:Connect(function(e)
    if string.sub(flyKB.Text,1,1) ~= "" and string.sub(flyKB.Text,1,1) ~= " " then
        flyKB.PlaceholderText = string.upper(string.sub(flyKB.Text,1,1))
        keybinds.Fly = string.upper(string.sub(flyKB.Text,1,1))
        flyKB.Text = ""
    end
end)

speedKB.FocusLost:Connect(function(e)
    if string.sub(speedKB.Text,1,1) ~= "" and string.sub(speedKB.Text,1,1) ~= " " then
        speedKB.PlaceholderText = string.upper(string.sub(speedKB.Text,1,1))
        keybinds.Speed = string.upper(string.sub(speedKB.Text,1,1))
        speedKB.Text = ""
    end
end)

aimbotKB.FocusLost:Connect(function(e)
    if string.sub(aimbotKB.Text,1,1) ~= "" and string.sub(aimbotKB.Text,1,1) ~= " " then
        aimbotKB.PlaceholderText = string.upper(string.sub(aimbotKB.Text,1,1))
        keybinds.Aimbot = string.upper(string.sub(aimbotKB.Text,1,1))
        aimbotKB.Text = ""
    end
end)

autoclickKB.FocusLost:Connect(function(e)
    if string.sub(autoclickKB.Text,1,1) ~= "" and string.sub(autoclickKB.Text,1,1) ~= " " then
        autoclickKB.PlaceholderText = string.upper(string.sub(autoclickKB.Text,1,1))
        keybinds.autoclick = string.upper(string.sub(autoclickKB.Text,1,1))
        autoclickKB.Text = ""
    end
end)

antivoidKB.FocusLost:Connect(function(e)
    if string.sub(antivoidKB.Text,1,1) ~= "" and string.sub(antivoidKB.Text,1,1) ~= " " then
        antivoidKB.PlaceholderText = string.upper(string.sub(antivoidKB.Text,1,1))
        keybinds.antivoid = string.upper(string.sub(antivoidKB.Text,1,1))
        antivoidKB.Text = ""
    end
end)
knockbackKB.FocusLost:Connect(function(e)
    if string.sub(knockbackKB.Text,1,1) ~= "" and string.sub(knockbackKB.Text,1,1) ~= " " then
        knockbackKB.PlaceholderText = string.upper(string.sub(knockbackKB.Text,1,1))
        keybinds.knockback = string.upper(string.sub(knockbackKB.Text,1,1))
        knockbackKB.Text = ""
    end
end)
reachKB.FocusLost:Connect(function(e)
    if string.sub(reachKB.Text,1,1) ~= "" and string.sub(reachKB.Text,1,1) ~= " " then
        reachKB.PlaceholderText = string.upper(string.sub(reachKB.Text,1,1))
        keybinds.reach = string.upper(string.sub(reachKB.Text,1,1))
        reachKB.Text = ""
    end
end)


Fly.MouseButton1Down:Connect(flyFunc)
cosmetics.MouseButton1Down:Connect(cosmeticsFunc)
speed.MouseButton1Down:Connect(function()
    if not _G.speed then
        _G.speed = true
    else
        _G.speed = false
    end
end)
aimbot.MouseButton1Down:Connect(function()
    if not _G.aimbot then
        _G.aimbot = true
    else
        _G.aimbot = false
    end
end)
autoclick.MouseButton1Down:Connect(function()
    if not _G.autoclick then
        _G.autoclick = true
    else
        _G.autoclick = false
    end
end)
antivoid.MouseButton1Down:Connect(antivoidFunc)
knockback.MouseButton1Down:Connect(noKB)
reach.MouseButton1Down:Connect(function()
    if not _G.reach then
        _G.reach = true
    else
        _G.reach = false
    end
end)

mos.Button1Down:Connect(function()
    if _G.autoclick then
        if not auto then
            auto = true
            while auto do
                print('click')
                vm:SendMouseButtonEvent(0,2,0,true,nil,1)
                wait()
            end
        end
    end
end)
mos.Button1Up:Connect(function()
    if _G.autoclick then
        auto = false
    end
end)

uis.InputBegan:Connect(function(k)
    if k.KeyCode == Enum.KeyCode[keybinds.Fly] then
        flyFunc()
    elseif k.KeyCode == Enum.KeyCode[keybinds.Speed] then
        print(_G.speed)
        if not _G.speed then
            _G.speed = true
        else
            _G.speed = false
        end
    elseif k.KeyCode == Enum.KeyCode[keybinds.Aimbot] then
        if not _G.aimbot then
            _G.aimbot = true
        else
            _G.aimbot = false
        end
    elseif k.KeyCode == Enum.KeyCode[keybinds.autoclick] then
        if not _G.autoclick then
            _G.autoclick = true
        else
            _G.autoclick = false
        end
    elseif k.KeyCode == Enum.KeyCode[keybinds.antivoid] then
        antivoidFunc()
    elseif k.KeyCode == Enum.KeyCode[keybinds.knockback] then
        noKB()
    elseif k.KeyCode == Enum.KeyCode[keybinds.reach] then
        if not _G.reach then
            _G.reach = true
        else
            _G.reach = false
        end
    end
end)

while wait() do
    if _G.aimbot then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,gc().Character.HumanoidRootPart.Position)
        wait()
    end

    if _G.reach then
        reachantislow()
    end

    if _G.speed then
        if not char:FindFirstChild("Humanoid") then continue end
        if not char:FindFirstChild("HumanoidRootPart") then continue end
        if char.Humanoid.MoveDirection.Magnitude ~= 0 then
            print('speeding')
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + char.Humanoid.MoveDirection * 0.5
        end
        wait()
    end
end
