--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil
--!Bind
local countdownTimer: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil
--!Bind
local marqueeContainer: VisualElement = nil
local countdownTimerUpdater = nil
local countdownEndTimer = nil

local HRLiveDataManager = require("HRLiveBannerManager")
local isLive = false
local targetTime = nil
local currentBannerURL = ""

-- Timezone setup
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

local tzOffset = getTimezoneOffset()
local ET_OFFSET = 4 * 3600

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

function updateUI(newbannerURL, newtargetTime, newisLive)

    targetTime = parseETDateTime(newtargetTime)
    isLive = newisLive
    if newbannerURL ~= currentBannerURL then 
        -- print(`CLIENT UPDATING IMAGE TO URL:  {newbannerURL}`)
        imageDisplay:LoadFromCdnUrl(newbannerURL)
        currentBannerURL = newbannerURL
    end

end


function self:Awake()
    HRLiveDataManager.UpdateHRLiveUIDataResponse:Connect(updateUI)
    HRLiveDataManager.UpdateHRLiveUIDataRequest:FireServer()
    Timer.Every(1, function()
        if isLive then 
            if countdownLabel.text ~= "LIVE NOW:" then 
                countdownLabel:SetPrelocalizedText("LIVE NOW:")
                countdownTimer:RemoveFromClassList("hidden")
                countdownTimer:SetEmojiPrelocalizedText(" ")
            end
        else
            countdownLabel:SetPrelocalizedText("LIVE IN:")
            countdownTimer:RemoveFromClassList("hidden")
            if targetTime then 
                local now = os.time()
                local remaining = os.difftime(targetTime,now)
                if remaining > 0 then
                   countdownTimer:SetPrelocalizedText(formatTime(remaining))
                else
                    countdownTimer:SetEmojiPrelocalizedText(formatTime(0))
                end
            end
        end
    end)

    
    marqueeContainer:RemoveFromClassList("hidden")

end

function self:Update()

end
