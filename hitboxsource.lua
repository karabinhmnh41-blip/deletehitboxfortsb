local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HitboxManager"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Tạo Frame chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 150, 0, 50)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo UI di chuyển
MainFrame.Parent = ScreenGui

-- Bo góc cho UI
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Tạo Nút Bấm
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 130, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -65, 0.5, -15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Đỏ: Đang tắt
ToggleBtn.Text = "Hitbox: ON"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = ToggleBtn

-- Biến trạng thái
local hitboxDisabled = false

-- Hàm xử lý Hitbox
local function updateHitbox(char, state)
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanTouch = not state
            part.CanQuery = not state
        end
    end
end

-- Sự kiện Click
ToggleBtn.MouseButton1Click:Connect(function()
    hitboxDisabled = not hitboxDisabled
    
    if hitboxDisabled then
        ToggleBtn.Text = "Hitbox: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Xanh: Đã xóa hitbox
        updateHitbox(Player.Character, true)
    else
        ToggleBtn.Text = "Hitbox: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Đỏ: Hitbox bình thường
        updateHitbox(Player.Character, false)
    end
end)

-- Đảm bảo trạng thái áp dụng lại khi nhân vật respawn
Player.CharacterAdded:Connect(function(newChar)
    if hitboxDisabled then
        task.wait(0.5) -- Đợi nhân vật load xong
        updateHitbox(newChar, true)
    end
end)

print("UI Manager đã sẵn sàng!")
