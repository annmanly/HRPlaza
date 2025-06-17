--!Type(UI)

--!Bind
local headerText        : VisualElement = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with public fields GetEventStartDates() and GetEventImages()) here")
local Events_ScriptableObject : Events_ScriptableObject = nil

-- Parsed lists
local _eventStartEpochs  : table = {}
local _eventEndEpochs    : table = {}

-- Timer handle
local updateTimer = nil

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

local function updateHeader()
    local now = os.time()
    local nextUpdateIn = nil
    local maxCount = math.min(#_eventStartEpochs, #_eventEndEpochs)

    for i = 1, maxCount do
        local startEpoch = _eventStartEpochs[i]
        local endEpoch = _eventEndEpochs[i]

        if now >= startEpoch and now < endEpoch then
            headerText:SetPrelocalizedText("LIVE\nNOW:")
            nextUpdateIn = endEpoch - now
            break
        elseif now < startEpoch then
            headerText:SetPrelocalizedText("COMING\nSOON:")
            nextUpdateIn = startEpoch - now
            break
        end
    end

    if not nextUpdateIn then
        headerText:SetPrelocalizedText("")
        headerText:AddToClassList("hidden")
        return
    else
        headerText:RemoveFromClassList("hidden")
    end

    updateTimer = Timer.After(nextUpdateIn, function()
        updateHeader()
    end)
end

function self:Awake()
    local eventStartTimes = Events_ScriptableObject.GetEventStartDates()

    -- build start and end epochs
    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    for i, startStr in ipairs(eventStartTimes) do
        local startEpoch = parseETDateTime(startStr)
        _eventStartEpochs[i] = startEpoch
        _eventEndEpochs[i]   = startEpoch + (5 * 86400) -- 5 days duration
    end
end

function self:Start()
    headerText:SetPrelocalizedText("")
    headerText:RemoveFromClassList("hidden")
    updateHeader()
end