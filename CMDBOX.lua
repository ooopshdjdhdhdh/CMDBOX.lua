-- List of Admins
local Admins = {"Dshop_111"} -- Replace "Dshop_111" with your Roblox username
local prefix = ":" -- Command prefix

-- Check if a player is an admin
local function isAdmin(player)
    return table.find(Admins, player.Name) ~= nil
end

-- Handle player commands
game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        local args = msg:split(" ")
        local cmd = args[1]:sub(#prefix + 1)
        local targetName = args[2]
        local value = args[3]

        if isAdmin(player) then
            if cmd == "team" and targetName and value then
                local target = game.Players:FindFirstChild(targetName)
                if target then
                    target.Team = game.Teams:FindFirstChild(value)
                end
            elseif cmd == "god" then
                player.Character.Humanoid.MaxHealth = math.huge
                player.Character.Humanoid.Health = math.huge
            elseif cmd == "ws" and targetName and value then
                local target = game.Players:FindFirstChild(targetName)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.WalkSpeed = tonumber(value)
                end
            elseif cmd == "ban" and targetName then
                local target = game.Players:FindFirstChild(targetName)
                if target then
                    target:Kick("You have been banned by an admin.")
                end
            elseif cmd == "fly" and targetName then
                local target = game.Players:FindFirstChild(targetName)
                if target and target.Character then
                    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
                        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                        game.Debris:AddItem(bodyVelocity, 5)
                    end
                end
            elseif cmd == "tp" and targetName and value then
                local target = game.Players:FindFirstChild(targetName)
                local destination = game.Players:FindFirstChild(value)
                if target and destination and destination.Character then
                    target.Character:SetPrimaryPartCFrame(destination.Character.PrimaryPart.CFrame)
                end
            elseif cmd == "to" and targetName then
                local target = game.Players:FindFirstChild(targetName)
                if target and target.Character then
                    player.Character:SetPrimaryPartCFrame(target.Character.PrimaryPart.CFrame)
                end
            elseif cmd == "cmd" then
                player:Kick("Admin Commands: :team, :god, :ws, :ban, :fly, :tp, :to, :cmd")
            end
        end
    end)
end)
