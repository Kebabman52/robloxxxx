local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostDuckyy/UI-Libraries/refs/heads/main/LinoriaLib/source.lua'))()

local Window = Library:CreateWindow({
    Title = 'Sex Hack | Hypercam',
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Misc = Window:AddTab('Misc'),
    Visuals = Window:AddTab('Visuals'),
    SkibidiToilet = Window:AddTab('Skibidi Toilet')
}

local ChamsGroupBox = Tabs.Visuals:AddLeftGroupbox('Chams')
local HitBoxExpGroupBox = Tabs.Misc:AddLeftGroupbox('Hitbox')

local MenuGroup = Tabs.SkibidiToilet:AddLeftGroupbox('Menu')

local Players = game:GetService("Players")
local lPlayer = Players.LocalPlayer
local highlights = {}

local fillColor = Color3.fromRGB(0, 0, 255)
local outlineColor = Color3.fromRGB(80, 0, 255)

function createHighlight(char)
    if not char or not char:IsA("Model") then return end
    if Players:GetPlayerFromCharacter(char) == lPlayer then return end

    local player = Players:GetPlayerFromCharacter(char)
    if player and (player.Team == lPlayer.Team or lPlayer.Team.Name == "Default") then return end

    if highlights[char] then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "Chams"
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = outlineColor
    highlight.FillTransparency = 0.8
    highlight.FillColor = fillColor
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    highlights[char] = highlight
end


function removeHighlight(char)
    if highlights[char] then
        highlights[char]:Destroy()
        highlights[char] = nil
    end
end

function handleCharacter(char)
    if Toggles.EnableChams.Value then
        createHighlight(char)
    else
        removeHighlight(char)
    end
end

local function expandHitbox(player)
    if player == lPlayer then return end
    if not player.Character then return end
    

    local head = player.Character:FindFirstChild("Head")
    if head and head:IsA("Part") then
        head.Size = Vector3.new(5, 5, 5)
        head.Transparency = 0.5
        head.CanCollide = false
    end
end

local function resetHitbox(player)
    if player == lPlayer then return end
    if not player.Character then return end

    local head = player.Character:FindFirstChild("Head")
    if head and head:IsA("Part") then
        head.Size = Vector3.new(2, 1, 1)
        head.Transparency = 0
        head.CanCollide = true
    end
end

ChamsGroupBox:AddToggle('EnableChams', {
    Text = 'Enable Chams',
    Default = true,
    Callback = function(val)
        if val then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lPlayer and plr.Character then
                    createHighlight(plr.Character)
                end
            end
        else
            for char, _ in pairs(highlights) do
                removeHighlight(char)
            end
        end
    end
})

ChamsGroupBox:AddLabel('Fill Color'):AddColorPicker('FillColor', {
    Default = fillColor,
    Title = 'Chams Fill Color',
    Callback = function(color)
        fillColor = color
        for _, h in pairs(highlights) do
            h.FillColor = color
        end
    end
})

ChamsGroupBox:AddLabel('Outline Color'):AddColorPicker('OutlineColor', {
    Default = outlineColor,
    Title = 'Chams Outline Color',
    Callback = function(color)
        outlineColor = color
        for _, h in pairs(highlights) do
            h.OutlineColor = color
        end
    end
})

HitBoxExpGroupBox:AddToggle('HitboxExpander', {
    Text = 'Hitbox Expander',
    Default = false,
    Callback = function(state)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lPlayer and plr.Character then
                if state then
                    expandHitbox(plr)
                else
                    resetHitbox(plr)
                end
            end
        end
    end
})

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= lPlayer then
        if plr.Character then handleCharacter(plr.Character) end
        plr.CharacterAdded:Connect(function(char)
            wait(1)
            handleCharacter(char)
            if Toggles.HitboxExpander.Value then
                expandHitbox(plr)
            end
        end)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= lPlayer then
        plr.CharacterAdded:Connect(function(char)
            wait(1)
            handleCharacter(char)
            if Toggles.HitboxExpander.Value then
                expandHitbox(plr)
            end
        end)
    end
end)

-- // FLEXXING
Library:SetWatermarkVisibility(true)
Library:SetWatermark("Most skidded script ever")

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 
Library.ToggleKeybind = Options.MenuKeybind
