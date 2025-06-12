--!Type(ClientAndServer)

--!SerializeField
local objects : { GameObject } = nil

--!SerializeField
local eventStartTimes: { string } = {}
--!SerializeField
local eventEndTimes:   { string } = {}

local _eventStartEpochs = {}
local _eventEndEpochs   = {}
local tzOffset
local ET_OFFSET = 4 * 3600  -- ET = UTC-4

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return 0 end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),   min = tonumber(Min),      sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch   = naiveEpoch + tzOffset
    return utcEpoch + ET_OFFSET
end

function self:Awake()
    tzOffset = getTimezoneOffset()
    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    local count = math.min(#eventStartTimes, #eventEndTimes, #objects)
    for i = 1, count do
        _eventStartEpochs[i] = parseETDateTime(eventStartTimes[i])
        _eventEndEpochs[i]   = parseETDateTime(eventEndTimes[i])
    end
end

-- Schedules activation/deactivation callbacks for a single object index
local function scheduleForIndex(i)
    local object     = objects[i]
    local now        = os.time()
    local startEpoch = _eventStartEpochs[i]
    local endEpoch   = _eventEndEpochs[i]

    -- Cancel any existing timers for this object if your Timer API supports it

    -- If it's before the start time, schedule activation
    if now < startEpoch then
        object:SetActive(false)
        Timer.After(startEpoch - now, function()
            object:SetActive(true)
        end)
    elseif now < endEpoch then
        -- We're in the active window
        object:SetActive(true)
    else
        -- Past end time
        object:SetActive(false)
    end

    -- Schedule deactivation if we haven't passed it yet
    if now < endEpoch then
        Timer.After(endEpoch - now, function()
            object:SetActive(false)
        end)
    end
end

function self:Start()
    -- Initial scheduling for every object
    for i = 1, #objects do
        scheduleForIndex(i)
    end

    -- Fallback “sanity check” every minutes:
    -- re-evaluate current state and re-schedule any missed callbacks.
    Timer.Every(60, function()
        for i = 1, #objects do
            -- re-sync active state
            local now  = os.time()
            local obj  = objects[i]
            local sEp  = _eventStartEpochs[i]
            local eEp  = _eventEndEpochs[i]
            if     now < sEp then obj:SetActive(false)
            elseif now < eEp then obj:SetActive(true)
            else                 obj:SetActive(false)
            end

            -- re-schedule upcoming callbacks in case they were lost
            scheduleForIndex(i)
        end
    end)
end

-- No Update() needed any more!
