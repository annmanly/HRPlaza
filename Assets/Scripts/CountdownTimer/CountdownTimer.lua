--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil
--!Bind
local billboardDisplay: UIImage = nil
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

function self:Start()
    countdownLabel:SetPrelocalizedText("")
end

function self:Update()
    local now = os.time()
    for i = 1, #_eventStartEpochs do
        local s = _eventStartEpochs[i]
        local e = _eventEndEpochs[i]
        if now < s then
            local rem = s - now
            local h = math.floor(rem / 3600)
            local m = math.floor((rem % 3600) / 60)
            local sec = rem % 60
            local fmt = (h > 0) and "%02d:%02d:%02d" or "%02d:%02d"
            local text = (h > 0)
                and string.format(fmt, h, m, sec)
                or string.format(fmt, m, sec)
            countdownLabel:SetPrelocalizedText("Next Event: " .. text)
            billboardDisplay.image = eventImages[i]
            return
        elseif now < e then
            countdownLabel:SetPrelocalizedText("Live Now!")
            billboardDisplay.image = eventImages[i]
            return
        end
    end
    countdownLabel:SetPrelocalizedText("")
    timerContainer:AddToClassList("hidden")
end




