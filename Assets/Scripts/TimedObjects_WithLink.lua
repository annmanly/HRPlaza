--!Type(ClientAndServer)

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

    -- parse only as many events as matched across all three files
    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    local count = math.min(#eventStartTimes, #eventEndTimes, #linkurls)
    for i = 1, count do
        _eventStartEpochs[i] = parseETDateTime(eventStartTimes[i])
        _eventEndEpochs[i]   = parseETDateTime(eventEndTimes[i])
    end
end

function self:Start()
    -- initialize and hook tap handlers
    for i, object in ipairs(objects) do
        object:SetActive(false)
        local handler = object and object:GetComponent(TapHandler)
        if handler and linkurls[i] then
            handler.Tapped:Connect(function()
                UI:ExecuteDeepLink(linkurls[i])
                print("link tapped: " .. linkurls[i])
            end)
        end
    end
end

function self:Update()
    local now = os.time()

    -- deactivate all objects
    for _, obj in ipairs(objects) do
        obj:SetActive(false)
    end

    -- activate objects for active events (fallback to first)  
    for i, startEpoch in ipairs(_eventStartEpochs) do
        local endEpoch = _eventEndEpochs[i]
        if now >= startEpoch and now < endEpoch then
            local obj = objects[i] or objects[1]
            if obj then
                obj:SetActive(true)
            end
        end
    end
end
