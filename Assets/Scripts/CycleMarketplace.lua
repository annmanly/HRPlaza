--!Type(Client)

--!SerializeField
local Material : Material = nil

--!SerializeField
local Textures : { Texture } = nil 

--!SerializeField
local linkurls : { string } = ""

local _currentLink = ""

-- Waits 5 seconds then picks a random texture, applies it, and recurses
local function CycleTexture()
    Timer.After(5, function()
        if #Textures > 0 then
            -- pick a random index
            local idx = math.random(1, #Textures)
            local tex = Textures[idx]
            if Material and tex then
                Material.mainTexture = tex
                _currentLink = linkurls[idx]
                -- print("link: " .. _currentLink)
            end
        end
        -- continue cycling
        CycleTexture()
    end)
end

function self:ClientStart()
    if not Material or #Textures == 0 then
        return
    end

    -- seed the random number generator
    math.randomseed(os.time())

    -- handle taps
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(OnTap)

    -- immediately set a random initial texture
    local initialIdx = math.random(1, #Textures)
    Material.mainTexture = Textures[initialIdx]
    _currentLink = linkurls[initialIdx]
    -- print("link: " .. _currentLink)

    -- begin the random cycle
    CycleTexture()
end

function OnTap()
    UI:ExecuteDeepLink(_currentLink)
end
