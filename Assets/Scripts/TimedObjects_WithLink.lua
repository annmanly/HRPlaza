-- optional debug flag
local ENABLE_LOGGING = false

-- serialized fields
--!SerializeField
local objects           : { GameObject }         = nil
--!SerializeField
local startTimesFile    : TextAsset = nil
--!SerializeField
local endTimesFile      : TextAsset = nil
--!SerializeField
local linkUrlsFile      : TextAsset = nil

-- runtime lists
local linkurls          = {}
local eventStartTimes   = {}
local eventEndTimes     = {}
local _eventStartEpochs = {}
local _eventEndEpochs   = {}
local currentEventIndex = nil

-- compute host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now    = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- ET offset relative to UTC (ET = UTC-4)
local ET_OFFSET = 4 * 3600

-- parse an ET date-time string into a UTC epoch timestamp
local function parseETDateTime(str)
    local y,m,d,H,Min,S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return 0 end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),    min = tonumber(Min),    sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch   = naiveEpoch + tzOffset
    return utcEpoch + ET_OFFSET
end

-- safely read non-empty lines from a TextAsset, handling CR/LF
local function readLines(textAsset)
    if not textAsset then return {} end
    local text = textAsset.text or ""
    local lines = {}
    for line in string.gmatch(text, "([^\r\n]+)") do
        if line ~= "" then
            lines[#lines + 1] = line
        end
    end
    return lines
end

function self:Awake()
    -- load event times and URLs from text files
    eventStartTimes = readLines(startTimesFile)
    eventEndTimes   = readLines(endTimesFile)
    linkurls        = readLines(linkUrlsFile)

    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    local count = math.min(#eventStartTimes, #eventEndTimes, #linkurls)
    for i = 1, count do
        _eventStartEpochs[i] = parseETDateTime(eventStartTimes[i])
        _eventEndEpochs[i]   = parseETDateTime(eventEndTimes[i])
    end

    if ENABLE_LOGGING then print("Loaded " .. count .. " events.") end

    updateActiveObject()
end

function updateActiveObject()
    local now = os.time()
    local activeIndex = nil

    for i, startEpoch in ipairs(_eventStartEpochs) do
        local endEpoch = _eventEndEpochs[i]
        if now >= startEpoch and now < endEpoch then
            activeIndex = i
            break
        end
    end

    -- reset all objects
    for _, obj in ipairs(objects) do
        obj:SetActive(false)
    end

    if activeIndex then
        local obj = objects[activeIndex] or objects[1]
        if obj then
            obj:SetActive(true)
            if currentEventIndex ~= activeIndex then
                currentEventIndex = activeIndex
                local handler = obj:GetComponent(TapHandler)
                handler.Tapped:Connect(function()
                    UI:ExecuteDeepLink(linkurls[activeIndex])
                    print("link tapped: " .. linkurls[activeIndex])
                end)
            end
            if ENABLE_LOGGING then
                print("Event " .. activeIndex .. " is now active.")
            end
        end
    else
        currentEventIndex = nil
        if ENABLE_LOGGING then
            print("No active event at this time.")
        end
    end

    scheduleNextEventCheck()
end

function scheduleNextEventCheck()
    local now = os.time()
    local nextChangeTime = nil

    for i, startEpoch in ipairs(_eventStartEpochs) do
        local endEpoch = _eventEndEpochs[i]
        if now < startEpoch then
            nextChangeTime = math.min(nextChangeTime or startEpoch, startEpoch)
        elseif now < endEpoch then
            nextChangeTime = math.min(nextChangeTime or endEpoch, endEpoch)
        end
    end

    if nextChangeTime then
        local delay = math.max(1, nextChangeTime - now)
        if ENABLE_LOGGING then
            print("Next check scheduled in " .. delay .. " seconds.")
        end
        Timer.After(delay, function()
            updateActiveObject()
        end)
    else
        if ENABLE_LOGGING then
            print("No future events scheduled. Timer stopped.")
        end
    end
end