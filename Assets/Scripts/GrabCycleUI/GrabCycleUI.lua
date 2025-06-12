--!Type(UI)

local storageManager = require("StorageManager")

--!Bind
local billboardContainer : VisualElement = nil
--!Bind
local primaryText       : VisualElement = nil
--!Bind
local billboardDisplay  : UIImage = nil

-- Parsed lists
local _eventStartEpochs  = {}
local _eventEndEpochs    = {}
local eventNames         = {}

-- Cycling state for active events
local _activeIndices     = {}
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

    local banner = storageManager.EventBannerURLs[idx]
    if banner and banner.value and banner.value ~= "" then
        billboardDisplay:LoadFromCdnUrl(banner.value)

        banner.Changed:Connect(function(newURL)
            if newURL and newURL ~= "" then
                billboardDisplay:LoadFromCdnUrl(newURL)
            end
        end)
    else
        print("WARNING: No banner found for index " .. idx)
    end

    billboardContainer:RemoveFromClassList("hidden")

    cycleTimer = Timer.After(10, function()
        cycleActiveEvents()
    end)
end

function self:Awake()
    -- Wait for storage to initialize the arrays
    Timer.After(0.1, function()
        _eventStartEpochs = {}
        _eventEndEpochs = {}
        eventNames = {}

        for i = 1, #storageManager.EventStartDates do
            local startStr = storageManager.EventStartDates[i].value or "1970-01-01 00:00:00"
            local name = storageManager.EventNames[i].value or "Unnamed Event"

            local startEpoch = parseETDateTime(startStr)
            _eventStartEpochs[i] = startEpoch
            _eventEndEpochs[i] = startEpoch + (30 * 86400)
            eventNames[i] = name
        end
    end)
end

function self:Start()
    primaryText:SetPrelocalizedText("")
    billboardContainer:RemoveFromClassList("hidden")

    Timer.After(0.2, function()
        local now = os.time()
        local maxCount = math.min(#_eventStartEpochs, #_eventEndEpochs, #eventNames, #storageManager.EventBannerURLs)
        _activeIndices = {}

        for i = 1, maxCount do
            if now >= _eventStartEpochs[i] and now < _eventEndEpochs[i] then
                table.insert(_activeIndices, i)
            end
        end

        if #_activeIndices > 0 then
            _activeIndexPointer = 0
            cycleActiveEvents()
        else
            primaryText:SetPrelocalizedText("")
            billboardContainer:AddToClassList("hidden")
        end
    end)
end
