--!Type(ClientAndServer)
--!SerializeField
local billboardUI:GrabBillboardUI = nil
--!SerializeField
local deepLinkObj:GameObject = nil
--!SerializeField
local storageKey:string = "GRAB_01"
--!SerializeField
local defaultStartDate:string = "2025-06-17 13:00:00"
--!SerializeField
local defaultImageURL:string = "https://cdn.highrisegame.com/default_EventHUD.png"
--!SerializeField
local defaultLinkURL:string = "https://high.rs/shop?type=gacha"
local defaultData = {
    {
        start = defaultStartDate,
        image = defaultImageURL,
        deeplink = defaultLinkURL
    }
}

local RequestGrabData = Event.new(storageKey .. "RequestGrabData")
local UpdateGrabBillboard = Event.new(storageKey .. "UpdateGrabBillboard")

local GrabData = {}
local updateTimer = nil

local GRABDURATION = 14 * 24 * 60 * 60 -- 14 days

local currentImageURL = ""
local currentDeepLinkURL = ""
local isActive = false

-- [[ CLIENT ]]



function OnGrabDataReceived(grabActive, imageURL, linkURL)
    currentImageURL = imageURL
    currentDeepLinkURL = linkURL
    isActive = grabActive
    ToggleObjects(isActive)

    billboardUI.setImage(imageURL)

    
end


function ToggleObjects(visiblity)
    -- visiblity = true when grab is active

    if deepLinkObj then 
        deepLinkObj.gameObject:SetActive(visiblity)
    end
    if self.gameObject:GetComponent(TapHandler) then 
        self.gameObject:GetComponent(TapHandler).enabled = visiblity
    end

    if self.gameObject:GetComponent(BoxCollider) then
        self.gameObject:GetComponent(BoxCollider).enabled = visiblity
    end

end

function self:ClientAwake()
    UpdateGrabBillboard:Connect(OnGrabDataReceived)
    RequestGrabData:FireServer()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()          
        print(`TAPPED {currentDeepLinkURL}`)
        UI:ExecuteDeepLink(currentDeepLinkURL) 
    end)

    ToggleObjects(false)
end



--- [[ SERVER ]]


-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now    = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

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
    local utcEpoch   = naiveEpoch + getTimezoneOffset()
    return utcEpoch + ET_OFFSET
end

function GetDataFromStorage(callback)

    -- Grab Images & Start Times --
    Storage.GetValue(storageKey, function(data, err) 
        if err ~= StorageError.None then 
            error(`[GRAB STORAGE ERROR] {StorageError[err]}`)
            Timer.After(60*5, function() GetDataFromStorage(CheckActiveGrab) end)
            return 
        end
        if data ~= nil then 
            if data ~= GrabData and callback == nil then callback = CheckActiveGrab end
            GrabData = data
            print(`[GRAB DATA] {storageKey} LOADED {#GrabData} GRABS`)
        else
            print("[GRAB DATA] No data in storage, setting default.")
            Storage.SetValue(storageKey, defaultData)
            GrabData = defaultData
        end

        if callback then 
            callback()
        end

    end)

end

function CheckActiveGrab()
    if #GrabData == 0 then print(`NO GRAB DATA LOADED`) return end

    local now = os.time()
    local maxCount = #GrabData
    local nextWait = nil
    local isActive = false

    for i=1,#GrabData do
        local datestring = GrabData[i].start
        local startEpoch = parseETDateTime(datestring) 

        local endEpoch = startEpoch + GRABDURATION
        if now >= startEpoch and now < endEpoch then
            currentImageURL = GrabData[i].image
            currentDeepLinkURL = GrabData[i].deeplink
            nextWait = endEpoch - now
            isActive = true
            break
        end
    end

    if not isActive then
        currentImageURL = defaultImageURL
        nextWait = nil
    end

    if nextWait then
        if updateTimer then 
            updateTimer:Stop() 
            updateTimer = nil 
        end
        updateTimer = Timer.After(nextWait, function()
            CheckActiveGrab()
        end)
    end

    print(`UPDATING GRAB {storageKey} {tostring(isActive)} IMAGE URL: {currentImageURL} LINK URL {currentDeepLinkURL}`)
    UpdateGrabBillboard:FireAllClients(isActive, currentImageURL, currentDeepLinkURL)
end

function StorageTests()
    
    Timer.After(1, function() 
        testvalue =         {
            {
                start = "2025-06-13 13:00:00",
                image = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/16.png",
                deeplink = defaultLinkURL
            }
        }
        Storage.SetValue(storageKey,testvalue)
        GetDataFromStorage(CheckActiveGrab)
    end)
    Timer.After(15, function() 
        testvalue =         {
            {
                start = "2025-06-19 13:00:00",
                image = defaultImageURL,
                deeplink = "TEST"
            }
        }
        Storage.SetValue(storageKey,testvalue)
    end)

    Timer.After(30, function() 
        testvalue =         {
            {
                start = "2025-06-15 13:00:00",
                image = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_09_2025/16.png",
                deeplink = "https://high.rs/room?id=6476fe22eeafcd5d47b38298"
            }
        }
        Storage.SetValue(storageKey,testvalue)
    end)

end

function self:ServerStart()

    RequestGrabData:Connect(function(client) 
        UpdateGrabBillboard:FireClient(client, isActive, currentImageURL, currentDeepLinkURL)
    end)


    GetDataFromStorage(CheckActiveGrab)

    Timer.Every(60*5, function()  GetDataFromStorage() end)


end
