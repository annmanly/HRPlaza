--!Type(Client)

--!SerializeField
local frames:{Sprite} = {}

--!SerializeField
local timePerFrame:number = 0.3

local frameIndex:number = 1
local renderer = nil

-- Loops through frames with delay
local function CycleFrame()
    frameIndex = frameIndex + 1
    if frameIndex > #frames then
        frameIndex = 1
    end

    if renderer and frames[frameIndex] then
        renderer.sprite = frames[frameIndex]
    end

    Timer.After(timePerFrame, CycleFrame)
end

function self:ClientStart()
    renderer = self.gameObject:GetComponent(SpriteRenderer)  

    if not renderer then
        print("Renderer NOT found!")
        return
    end

    if #frames == 0 then
        print("No frames assigned.")
        return
    end

    -- Set the first frame
    renderer.sprite = frames[frameIndex]

    -- Start frame cycle loop
    Timer.After(timePerFrame, CycleFrame)
end
