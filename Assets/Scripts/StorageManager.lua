--!Type(Module)

--!SerializeField
local defaultBannerURL : string = "https://cdn.highrisegame.com/trivia_venice.png"

-- Default starting point and size
--!SerializeField
local defaultStartDateBase : string = "2025-05-15 12:00:00"

--!SerializeField
local defaultEventName : string = "Default Event"

--!SerializeField
local defaultEventCount : number = 5

EventBannerURLs = {}
EventStartDates = {}
EventNames = {}

-- Key generators
local function getBannerKey(i)
    return string.format("Event%02dBannerURL", i)
end


-- Offset utility, to fill default start dates with consective dates
local function offsetDate(baseDateStr, offsetWeeks)
    local y, m, d, H, Min, S = baseDateStr:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    local baseTime = os.time({
        year = tonumber(y),
        month = tonumber(m),
        day = tonumber(d),
        hour = tonumber(H),
        min = tonumber(Min),
        sec = tonumber(S),
    })
    local offsetTime = baseTime + (offsetWeeks * 7 * 86400)
    return os.date("%Y-%m-%d %H:%M:%S", offsetTime)
end

-- Initialize arrays if empty
if #EventBannerURLs == 0 then
    for i = 1, defaultEventCount do
        EventBannerURLs[i] = StringValue.new(getBannerKey(i), defaultBannerURL)
        EventStartDates[i] = StringValue.new("EventStartDate" .. i, offsetDate(defaultStartDateBase, i - 1))
        EventNames[i] = StringValue.new("EventName" .. i, defaultEventName)
    end
end

function GetEventDataFromStorage()
    -- Main banner URLs
    Storage.GetValue("EventBannerURLs", function(storageValue)
        local storedTable = storageValue or {}
        local updated = false

        for i = 1, #EventBannerURLs do
            local key = getBannerKey(i)
            if not storedTable[key] then
                storedTable[key] = defaultBannerURL
                updated = true
            end
            EventBannerURLs[i].value = storedTable[key]
        end

        if updated then
            Storage.SetValue("EventBannerURLs", storedTable)
        end
    end)

    -- Start dates
    Storage.GetValue("EventStartDates", function(storageValue)
        local storedTable = storageValue or {}
        local updated = false

        for i = 1, #EventStartDates do
            local key = "EventStartDate" .. i
            if not storedTable[key] then
                storedTable[key] = offsetDate(defaultStartDateBase, i - 1)
                updated = true
            end
            EventStartDates[i].value = storedTable[key]
        end

        if updated then
            Storage.SetValue("EventStartDates", storedTable)
        end
    end)

    -- Event names
    Storage.GetValue("EventNames", function(storageValue)
        local storedTable = storageValue or {}
        local updated = false

        for i = 1, #EventNames do
            local key = "EventName" .. i
            if not storedTable[key] then
                storedTable[key] = defaultEventName
                updated = true
            end
            EventNames[i].value = storedTable[key]
        end

        if updated then
            Storage.SetValue("EventNames", storedTable)
        end
    end)
end


function self:ServerAwake()
    GetEventDataFromStorage()

    Timer.Every(60*5, function() 
        GetEventDataFromStorage()
    end)
end

