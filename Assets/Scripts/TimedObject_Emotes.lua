--!Type(ClientAndServer)

--!SerializeField
local objectA : GameObject = nil
--!SerializeField
local objectB : GameObject = nil

--!SerializeField
local baseStartTime : string = "2025-06-10 12:00:00"

local baseStartEpoch
local tzOffset
local ET_OFFSET = 4 * 3600 -- ET = UTC-4
local WEEK_SECONDS = 7 * 24 * 3600

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

function self:Awake()
    tzOffset = getTimezoneOffset()

    local function parseETDateTime(str)
        local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
        if not y then return 0 end
        local tbl = {
            year = tonumber(y), month = tonumber(m), day = tonumber(d),
            hour = tonumber(H), min = tonumber(Min), sec = tonumber(S)
        }
        local naiveEpoch = os.time(tbl)
        local utcEpoch   = naiveEpoch + tzOffset
        return utcEpoch + ET_OFFSET
    end

    baseStartEpoch = parseETDateTime(baseStartTime)
end

function self:Start()
    local function updateActiveObject()
        if not objectA or not objectB then
            return
        end        
        local now = os.time()
        local weeksSinceBase = math.floor((now - baseStartEpoch) / WEEK_SECONDS)
        local isEvenWeek = (weeksSinceBase % 2 == 0)

        if isEvenWeek then
            objectA:SetActive(true)
            objectB:SetActive(false)
        else
            objectA:SetActive(false)
            objectB:SetActive(true)
        end
    end

    updateActiveObject()
    Timer.Every(60, updateActiveObject)
end
