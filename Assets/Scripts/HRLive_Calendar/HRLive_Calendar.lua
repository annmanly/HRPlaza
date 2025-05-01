--!Type(UI)

--!Bind
local billboardDisplay01: UIImage = nil
--!Bind
local billboardDisplay02: UIImage = nil
--!Bind
local timerContainer: VisualElement = nil

--!SerializeField
local eventImages: {Texture} = {}

--!SerializeField
--!Tooltip("List of ET start times for each event in 'YYYY-MM-DD HH:MM:SS'")
local eventStartTimes: {string} = {}

--!SerializeField
--!Tooltip("List of ET end times for each event in 'YYYY-MM-DD HH:MM:SS'")
local eventEndTimes: {string} = {}

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
    return utcEpoch + ET_OFFSET
end

function self:Awake()
    _eventStartEpochs = {}
    _eventEndEpochs = {}
    local count = math.min(#eventStartTimes, #eventEndTimes, #eventImages)
    for i = 1, count do
        _eventStartEpochs[i] = parseETDateTime(eventStartTimes[i])
        _eventEndEpochs[i]   = parseETDateTime(eventEndTimes[i])
    end
end

function self:Update()
    local now = os.time()
    for i = 1, #_eventStartEpochs do
        local s = _eventStartEpochs[i]
        local e = _eventEndEpochs[i]

        if now < e then
            -- if this is the _last_ event, show the current one...
            if i + 1 > #_eventStartEpochs then
                billboardDisplay01.image = eventImages[i]
            else
                -- otherwise show the next upcoming event
                billboardDisplay01.image = eventImages[i + 1]
            end  

            -- and if theres a second next event, show it too
            if i + 2 <= #_eventStartEpochs then
                billboardDisplay02.image = eventImages[i + 2]
            end

            return 
        end 
    end

    -- no more events to show
    timerContainer:AddToClassList("hidden")
end



