--!Type(Client)

--!SerializeField
local Material : Material = nil

--!SerializeField
local Textures : { Texture } = nil 

--!SerializeField
local linkurls : { string } = ""

local _currentIdx = 1
local _currentLink = ""

-- local recursive function to advance the texture every 5 seconds
local function CycleTexture()
    Timer.After(5, function()
        -- wrap index if past the end
        if _currentIdx > #Textures then
            _currentIdx = 1
        end

        -- apply the texture
        local tex = Textures[_currentIdx]
        if Material and tex then
            Material.mainTexture = tex
            _currentLink = linkurls[_currentIdx]
            print("link: " .. _currentLink)
        end

        -- advance for next call
        _currentIdx = _currentIdx + 1

        -- recurse
        CycleTexture()
    end)
end

function self:ClientStart()
    if not Material or #Textures == 0 then
        return
    end

    self.gameObject:GetComponent(TapHandler).Tapped:Connect(OnTap)

    -- immediately set to the first texture
    Material.mainTexture = Textures[1]
    _currentLink = linkurls[1]
    print("link: " .. _currentLink)
    -- next time, we'll pull Textures[2]
    _currentIdx = 2

    -- start the cycle
    CycleTexture()
end

function OnTap()
    UI:ExecuteDeepLink(_currentLink)
end
