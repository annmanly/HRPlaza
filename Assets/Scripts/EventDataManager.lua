--!Type(Module)

local EventData = {}

local updateTimer = nil

local EVENTDURATION = (5 * 86400) -- 5 days

defaultURL = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/01.png"

local currentURL =  defaultURL 
local targetTime = nil
local isLive = false

local defaultData = {
    {
        start = "2025-06-19 12:00:00",
        url = defaultURL
    }
}

local   EventDataKey = "Event_BannerURLS"

UpdateEventImageURL = Event.new("UpdateEventImageURL")
RequestEventImageURL = Event.new("RequestEventImageURL")
UpdateEventTime = Event.new("UpdateEventTime")
RequestEventTime = Event.new("RequestEventTime")

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

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then
        return string.format("%02d:%02d:%02d", h, m, s)
    else
        return string.format("%02d:%02d", m, s)
    end
end

function GetDataFromStorage(callback)


    -- Event Banners & Start Times --
    Storage.GetValue(EventDataKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[HRLIVE STORAGE ERROR] {StorageError[err]}`)
            Timer.After(60*5, function() GetDataFromStorage(UpdateEvent) end)
            return 
        end
        if data ~= nil then 
            if data ~= EventData and callback == nil then callback = UpdateEvent end
            EventData = data
            print(`[EVENT DATA] LOADED {#EventData} EVENT INFO.`)
        else
            print("[EVENT DATA] No data in storage, setting default.")
            Storage.SetValue(EventDataKey, defaultData)
            EventData = defaultData
        end

        if callback then 
            callback()
        end

    end)


end

function UpdateEvent()
    if #EventData == 0 then print(`NO EVENT DATA LOADED`) return end

    local now = os.time()
    local maxCount = #EventData
    local nextWait = nil
    local foundEvent = false

    for i=1,#EventData do
        local datestring = EventData[i].start
        local startEpoch = parseETDateTime(datestring) 

        local endEpoch = startEpoch + EVENTDURATION
        if now < startEpoch then
            currentURL = EventData[i].url
            nextWait = startEpoch - now
            targetTime = startEpoch
            foundEvent = true
            isLive = false
            break
        elseif now >= startEpoch and now < endEpoch then
            currentURL = EventData[i].url
            nextWait = endEpoch - now
            foundEvent = true
            targetTime = endEpoch
            isLive = true
            break
        end
    end

    if not foundEvent then
        currentURL = defaultURL
        nextWait = 60*5
        foundEvent = true
    end

    if nextWait then
        if updateTimer then 
            updateTimer:Stop() 
            updateTimer = nil 
        end
        updateTimer = Timer.After(nextWait, function()
            UpdateEvent()
        end)
    end

    print(`UPDATING CURRENT URL: {currentURL} NEXTWAIT: {formatTime(nextWait)}`)
    UpdateEventImageURL:FireAllClients(currentURL)
    UpdateEventTime:FireAllClients(targetTime, isLive)
end

function self:ServerStart()
    RequestEventImageURL:Connect(function(client) 
        UpdateEventImageURL:FireClient(client, currentURL)
    end)

    RequestEventTime:Connect(function(client)
        UpdateEventTime:FireClient(client, targetTime, isLive)
    end)

    GetDataFromStorage(UpdateEvent)

    Timer.Every(2*5, function()  GetDataFromStorage() end)

    Timer.After(15, function() 
    
        testData = {
        {
        ["start"] = "2025-06-19 12:00:00",		
        ["url"] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/03.png",	
        },	
        {	
        ["start"] = "2025-06-26 12:00:00",		
        ["url"] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/06.png",	
        },		
        }
        
        Storage.SetValue(EventDataKey, testData)
    
    end)

    Timer.After(30, function() 
    
        testData = {
                    {	
        ["start"] = "2025-06-15 12:00:00",		
        ["url"] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/06.png",	
        },
        {
        ["start"] = "2025-06-19 12:00:00",		
        ["url"] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/03.png",	
        },	
		
        }
        
        Storage.SetValue(EventDataKey, testData)
    
    end)
end
