--!Type(Client)

--!SerializeField
local Material : Material = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type EventsScriptableObject (with public fields GetEventStartDates() and GetEventHuds()) here")
local Events_ScriptableObject : Events_ScriptableObject = nil

local EventHuds     = {}
local eventStartEpochs = {}
local eventEndEpochs   = {}

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now    = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- ET offset relative to UTC (ET = UTC-4)
local ET_OFFSET = 4 * 3600

-- Parse an ET date-time string into a UTC epoch timestamp
local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return 0 end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),    min = tonumber(Min),    sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch   = naiveEpoch + tzOffset
    return utcEpoch + ET_OFFSET
end

local function UpdateEventTexture()
    local now = os.time()
    local maxCount = math.min(
        #eventStartEpochs,
        #eventEndEpochs,
        #EventHuds
    )

    for i = 1, maxCount do
        local startEpoch = eventStartEpochs[i]
        local endEpoch   = eventEndEpochs[i]
        local tex        = EventHuds[i]

        if now >= startEpoch and now < endEpoch then
            if Material and tex then
                Material.mainTexture = tex
            end
            return
        elseif now < startEpoch then
            if Material and tex then
                Material.mainTexture = tex
            end
            return
        end
    end
end

function self:ClientStart()
    EventHuds = Events_ScriptableObject.GetEventHuds()
    eventStartTimes = Events_ScriptableObject.GetEventStartDates()

    if not Material or #EventHuds == 0 then
        return
    end

    -- build start and end epochs
    eventStartEpochs = {}
    eventEndEpochs   = {}
    for i, startStr in ipairs(eventStartTimes) do
        local startEpoch = parseETDateTime(startStr)
        eventStartEpochs[i] = startEpoch
        eventEndEpochs[i]   = startEpoch + (5 * 86400) -- 5 days
    end

    -- Periodic update every second
    Timer.Every(1, UpdateEventTexture)
end
