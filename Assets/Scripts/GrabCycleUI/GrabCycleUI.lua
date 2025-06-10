--!Type(UI)

--!Bind
local billboardContainer : VisualElement = nil
--!Bind
local primaryText       : VisualElement = nil
--!Bind
local billboardDisplay  : UIImage = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with public fields GetEventStartDates() and GetEventImages()) here")
local Events_ScriptableObject : Events_ScriptableObject = nil

-- Parsed lists
local _eventTextures     : table = {}
local _eventStartEpochs  : table = {}
local _eventEndEpochs    : table = {}
local eventNames         : {string} = {}

-- Cycling state for active events
local _activeIndices     : table = {}
local _activeIndexPointer = 1
local cycleTimer = nil

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
    if not y then return 0 end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H), min = tonumber(Min), sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch + tzOffset
    return utcEpoch + ET_OFFSET
end

local function cycleActiveEvents()
    if #_activeIndices == 0 then
        primaryText:SetPrelocalizedText("")
        billboardContainer:AddToClassList("hidden")
        return
    end

    _activeIndexPointer = (_activeIndexPointer % #_activeIndices) + 1
    local idx = _activeIndices[_activeIndexPointer]

    primaryText:SetPrelocalizedText(eventNames[idx] .. " Grab")
    billboardDisplay.image = _eventTextures[idx]
    billboardContainer:RemoveFromClassList("hidden")

    cycleTimer = Timer.After(10, function()
        cycleActiveEvents()
    end)
end

function self:Awake()
    _eventTextures = Events_ScriptableObject.GetGrabBanners()
    local eventStartTimes = Events_ScriptableObject.GetEventStartDates()
    eventNames = Events_ScriptableObject.GetEventNames()

    _eventStartEpochs = {}
    _eventEndEpochs = {}
    for i, startStr in ipairs(eventStartTimes) do
        local startEpoch = parseETDateTime(startStr)
        _eventStartEpochs[i] = startEpoch
        _eventEndEpochs[i] = startEpoch + (28 * 86400)
    end
end

function self:Start()
    primaryText:SetPrelocalizedText("")
    billboardContainer:RemoveFromClassList("hidden")

    local now = os.time()
    local maxCount = math.min(#_eventStartEpochs, #_eventEndEpochs, #eventNames, #_eventTextures)
    _activeIndices = {}
    for i = 1, maxCount do
        if now >= _eventStartEpochs[i] and now < _eventEndEpochs[i] then
            table.insert(_activeIndices, i)
        end
    end

    if #_activeIndices > 0 then
        _activeIndexPointer = 0 -- So first increment points to 1
        cycleActiveEvents()
    else
        primaryText:SetPrelocalizedText("")
        billboardContainer:AddToClassList("hidden")
    end
end
