-- Ensure this script runs locally
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.Active = true
Frame.Draggable = true

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, 0, 0.5, 0)
Button.Position = UDim2.new(0, 0, 0.25, 0)
Button.Text = "Fling All"
Button.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
Button.TextScaled = true

-- Teleport inside and Fling Logic
local function teleportInsideAndFling(targetPlayer)
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then return end

    local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHumanoid or not targetRoot then return end

    local localCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end

    -- Teleport inside the target player (centered on the target's HumanoidRootPart)
    localRoot.CFrame = targetRoot.CFrame  -- Teleport to the target's HumanoidRootPart

    -- Fling the target player
    targetRoot.Velocity = Vector3.new(0, 1000, 0)  -- Fling upwards
    task.wait(0.1)
    targetRoot.Velocity = Vector3.new(1000, 0, 0)  -- Fling forward

    task.wait(5)  -- Wait before moving to the next player
end

-- Cycle through all players
local function flingAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            teleportInsideAndFling(player)
        end
    end
end

-- Button Click
Button.MouseButton1Click:Connect(flingAllPlayers)