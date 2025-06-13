--!Type(Module)

--!SerializeField
local LiveEventLinkObj:GameObject = nil
--!SerializeField
local defaultStartDate:string = "2025-06-09 13:00:00"
--!SerializeField
local defaultEndDate:string = "2025-06-09 15:00:00"
--!SerializeField
local defaultBannerURL:string = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/01.png"
--!SerializeField
local defaultRoomLink:string = "https://high.rs/room?id=6476fe22eeafcd5d47b38298"


-- Internal lists
local HRLiveBannerURLSKey = "HRLive_BannerURLS"
local HRLiveStartTimesKey = "HRLive_StartTimes"
local HRLiveEndTimesKey = "HRLive_EndTimes"
local HRLiveRoomLinksKey = "HRLive_RoomLinks"

local HRLiveBannerURLS = {}
local HRLiveStartTimes = {}
local HRLiveEndTimes = {}
local HRLiveRoomLinks = {}

-- State
local currentEventIndex = 1
local targetTime = nil
local isLive = false


UpdateHRLiveUIDataRequest = Event.new("UpdateHRLiveUIDataRequest")
UpdateHRLiveUIDataResponse = Event.new("UpdateHRLiveUIDataResponse")
UpdateHRLiveLinkRequest = Event.new("UpdateHRLiveLinkRequest")
UpdateHRLiveLinkEvent = Event.new("UpdateHRLiveLinkEvent")
SetLiveObjects = Event.new("SetLiveObjects")


-- Timezone setup
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

local tzOffset = getTimezoneOffset()
local ET_OFFSET = 4 * 3600

local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return nil end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H), min = tonumber(Min), sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch - tzOffset
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



function GetHRLiveDataFromStorage()
    HRLiveBannerURLSKey = "HRLive_BannerURLS"
    HRLiveStartTimesKey = "HRLive_StartTimes"
    HRLiveEndTimesKey = "HRLive_EndTimes"
    HRLiveRoomLinksKey = "HRLive_RoomLinks"

    -- HRLIVE BANNERS --
    Storage.GetValue(HRLiveBannerURLSKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[HRLIVE STORAGE ERROR] {StorageError[err]}`)
            return 
        end
        if data ~= nil then 
            
            HRLiveBannerURLS = data
            print(`[HRLIVE DATA] LOADED {HRLiveBannerURLS[1]} BANNER URLS.`)
        else
            print("[HRLIVE DATA] No data in storage, setting default.")
            defaultData = {defaultBannerURL}
            Storage.SetValue(HRLiveBannerURLSKey, defaultData)
            HRLiveBannerURLS = defaultData
        end

    end)

    -- HRLIVE START TIMES --
    Storage.GetValue(HRLiveStartTimesKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[HRLIVE STORAGE ERROR] {StorageError[err]}`)
            return 
        end
        if data ~= nil then 
            -- print(`[HRLIVE DATA] LOADED {#data} START TIMES.`)
            HRLiveStartTimes = data
        else
            print("[HRLIVE DATA] No data in storage, setting default.")
            defaultData = {defaultStartDate}
            Storage.SetValue(HRLiveStartTimesKey, defaultData)
            HRLiveStartTimes = defaultData
        end

    end)

    -- HRLIVE EVENT END TIMES --
    Storage.GetValue(HRLiveEndTimesKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[HRLIVE STORAGE ERROR] {StorageError[err]}`)
            return 
        end
        if data ~= nil then 
            -- print(`[HRLIVE DATA] LOADED {#data} END TIMES.`)
            HRLiveEndTimes = data
        else
            print("[HRLIVE DATA] No data in storage, setting default.")
            defaultData = {defaultEndDate}
            Storage.SetValue(HRLiveEndTimesKey, defaultData)
            HRLiveEndTimes = defaultData
        end

    end)

    -- ROOM LINKS --
    Storage.GetValue(HRLiveRoomLinksKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[HRLIVE STORAGE ERROR] {StorageError[err]}`)
            return 
        end
        if data ~= nil then 
            -- print(`[HRLIVE DATA] LOADED {#data} ROOM LINK URLS.`)
            HRLiveRoomLinks = data
        else
            print("[HRLIVE DATA] No data in storage, setting default.")
            defaultData = {defaultRoomLink}
            Storage.SetValue(HRLiveRoomLinksKey, defaultData)
            HRLiveRoomLinks = defaultData
        end

    end)



end

local currentRoomLink = nil
function self:ClientAwake()
    if LiveEventLinkObj then 
        LiveEventLinkObj.gameObject:SetActive(false)
    end

    tapHandler = LiveEventLinkObj:GetComponent(TapHandler)
    if tapHandler then 
        tapHandler.Tapped:Connect(function() 
            print(`TAPPED {currentRoomLink}`)
            UI:ExecuteDeepLink(currentRoomLink) 
        end) 
    end
    SetLiveObjects:Connect(function(setActive, link) 
        
    if LiveEventLinkObj then 
        LiveEventLinkObj.gameObject:SetActive(setActive)
        if setActive then
            currentRoomLink = link
        end
    end
    
    end)
end

function checkActiveEvent()
    local now = os.time()
    local newIndex = 1
    oldLive = isLive
    for i = 1, #HRLiveStartTimes do
        local s, e = parseETDateTime(HRLiveStartTimes[i]), parseETDateTime(HRLiveEndTimes[i])
        if now < s then
            newIndex = i
            targetTime = s
            isLive = false
            break
        elseif now < e then
            newIndex = i
            targetTime = e
            isLive = true
            break
        end
    end

    currentEventIndex = newIndex

    SetLiveObjects:FireAllClients(isLive, HRLiveRoomLinks[currentEventIndex])

    UpdateHRLiveUIDataResponse:FireAllClients(HRLiveBannerURLS[currentEventIndex],HRLiveEndTimes[currentEventIndex], isLive)


end

function OnHRLiveDataRequest(player)
    UpdateHRLiveUIDataResponse:FireClient(player, HRLiveBannerURLS[currentEventIndex],
        HRLiveStartTimes[currentEventIndex], isLive) 
end

function self:ServerAwake()
    GetHRLiveDataFromStorage()
    checkActiveEvent()
    Timer.Every(60*5, function() 
        GetHRLiveDataFromStorage()
    end)

    Timer.Every(1, checkActiveEvent)

    UpdateHRLiveUIDataRequest:Connect(OnHRLiveDataRequest)

end