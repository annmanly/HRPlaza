--!Type(ClientAndServer)

--!SerializeField
local objects : { GameObject } = nil

--!SerializeField
--!Tooltip("List of ET start times for each event in 'YYYY-MM-DD HH:MM:SS'")
local eventStartTimes: { string } = {}

-- Parsed epoch lists
local _eventStartEpochs: table = {}
local _eventEndEpochs: table = {}

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()

    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- ET offset relative to UTC (ET = UTC-4)
local ET_OFFSET = 4 * 3600

-- Parse an ET date-time string into a UTC epoch timestamp
local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then
        return 0
    end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),   min = tonumber(Min),      sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    -- convert naive local to UTC, then apply ET offset
    local utcEpoch = naiveEpoch + tzOffset
    -- add 7 days (7 * 24 * 60 * 60 = 604800 seconds)
    return utcEpoch + ET_OFFSET + 5 * 24 * 60 * 60
end

function self:Start()

    for i = 1, #objects do
        local object = objects[i]
        object:SetActive(false)
    end
end

function self:Awake()

    _eventStartEpochs = {}
    _eventEndEpochs = {}
    local count = math.min(#eventStartTimes, #objects)

    for i = 1, count do
        local startEpoch = parseETDateTime(eventStartTimes[i])
        _eventStartEpochs[i] = startEpoch
        _eventEndEpochs[i]   = startEpoch + 14 * 24 * 60 * 60 -- Add 14 days
    end
end

function self:Update()
    local now = os.time()
    for i = 1, #_eventStartEpochs do
        local s = _eventStartEpochs[i]
        local e = _eventEndEpochs[i]
        local object = objects[i]

        if     now < s then

            object:SetActive(false)
        elseif now < e then

            object:SetActive(true)
        else

            object:SetActive(false)
        end
    end
end




