
-- DELTA BHai SPAWNER
-- For your own Roblox Studio game
-- Place in ServerScriptService

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local event = ReplicatedStorage:FindFirstChild("SpawnRequest")

if not event then
    event = Instance.new("RemoteEvent")
    event.Name = "SpawnRequest"
    event.Parent = ReplicatedStorage
end

local allowed = {
    Rocket = true,
    Spin = true,
    Flame = true,
    Ice = true,
    Light = true,
    Buddha = true,
    Portal = true,
    Dragon = true
}

event.OnServerEvent:Connect(function(player, name)
    if typeof(name) ~= "string" or not allowed[name] then
        return
    end

    local folder = ServerStorage:FindFirstChild("Spawnables")
    if not folder then return end

    local item = folder:FindFirstChild(name)
    if not item then return end

    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local clone = item:Clone()
    clone.Parent = workspace

    if clone:IsA("Model") then
        clone:PivotTo(root.CFrame * CFrame.new(0, 0, -8))
    elseif clone:IsA("BasePart") then
        clone.Position = root.Position + root.CFrame.LookVector * 8
    end
end)
