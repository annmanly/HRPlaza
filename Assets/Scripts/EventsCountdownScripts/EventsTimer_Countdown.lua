--!Type(UI)

--!Bind
local billboardContainer : VisualElement = nil
--!Bind
local primaryText       : UILabel = nil
--!Bind
local countdownText     : UILabel  = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with public fields GetEventStartDates() and GetEventImages()) here")
local Events_ScriptableObject : Events_ScriptableObject = nil

-- Parsed lists
local _eventStartEpochs  : table = {}
local _eventEndEpochs    : table = {}

local countdownTimer = nil
local reevaluateTimer = nil

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

local function formatRemainingTime(seconds)
    local d   = math.floor(seconds / 86400)
    local h   = math.floor((seconds % 86400) / 3600)
    local m   = math.floor((seconds % 3600) / 60)
    local sec = seconds % 60
    if d > 0 then
        return string.format("%02d:%02d:%02d:%02d", d, h, m, sec)
    elseif h > 0 then
        return string.format("%02d:%02d:%02d", h, m, sec)
    else
        return string.format("%02d:%02d", m, sec)
    end
end

local function startCountdown(targetTime, isLive)
    if countdownTimer then countdownTimer:Stop() end
    if reevaluateTimer then reevaluateTimer:Stop() end

    local now = os.time()
    local remaining = targetTime - now

    if remaining <= 0 then
        primaryText:SetPrelocalizedText("")
        countdownText:SetPrelocalizedText("")
        billboardContainer:AddToClassList("hidden")
        return
    end

    billboardContainer:RemoveFromClassList("hidden")

    if isLive then
        primaryText:SetPrelocalizedText("EVENT ENDING:")
    else
        primaryText:SetPrelocalizedText("EVENT STARTING")
    end

    countdownText:SetPrelocalizedText(formatRemainingTime(remaining))

    countdownTimer = Timer.Every(1, function()
        local now = os.time()
        local remaining = targetTime - now
        if remaining <= 0 then
            primaryText:SetPrelocalizedText("")
            countdownText:SetPrelocalizedText("")
            billboardContainer:AddToClassList("hidden")
            if countdownTimer then countdownTimer:Stop() end
            if reevaluateTimer then reevaluateTimer:Stop() end
            return
        end
        countdownText:SetPrelocalizedText(formatRemainingTime(remaining))
    end)

    reevaluateTimer = Timer.After(remaining, function()
        evaluateCountdownState()
    end)
end

function evaluateCountdownState()
    local now = os.time()
    local maxCount = math.min(#_eventStartEpochs, #_eventEndEpochs)

    for i = 1, maxCount do
        local startEpoch = _eventStartEpochs[i]
        local endEpoch   = _eventEndEpochs[i]

        if now >= startEpoch and now < endEpoch then
            startCountdown(endEpoch, true)
            return
        elseif now < startEpoch then
            startCountdown(startEpoch, false)
            return
        end
    end

    -- No active or upcoming events
    primaryText:SetPrelocalizedText("")
    countdownText:SetPrelocalizedText("")
    billboardContainer:AddToClassList("hidden")
end

function self:Awake()
    local eventStartTimes = Events_ScriptableObject.GetEventStartDates()

    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    for i, startStr in ipairs(eventStartTimes) do
        local startEpoch = parseETDateTime(startStr)
        _eventStartEpochs[i] = startEpoch
        _eventEndEpochs[i]   = startEpoch + (5 * 86400) -- 5 days duration
    end
end

function self:Start()
    primaryText:SetPrelocalizedText("")
    countdownText:SetPrelocalizedText("")
    billboardContainer:RemoveFromClassList("hidden")
    evaluateCountdownState()
end
