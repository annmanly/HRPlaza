--!Type(UI)

--!Bind
local billboardContainer : VisualElement = nil
--!Bind
local primaryText       : UILabel = nil
--!Bind
local countdownText     : UILabel  = nil

local targetTime = nil
local isLive = false
local EventDataManager = require("EventDataManager")


local function formatRemainingTime(seconds)
    local d   = math.floor(seconds / 86400)
    local h   = math.floor((seconds % 86400) / 3600)
    local m   = math.floor((seconds % 3600) / 60)
    local sec = seconds % 60
    if d > 0 then
        return string.format("%02d:%02d:%02d:%02d", d, h, m, sec)
    elseif h > 0 then
        return string.format("%02d:%02d:%02d", h, m, sec)
    else
        return string.format("%02d:%02d", m, sec)
    end
end

function setNewTargetTime(newTime, liveStatus)

    targetTime = newTime
    isLive = liveStatus
    
    if isLive then
        primaryText:SetPrelocalizedText("EVENT ENDING:")
    elseif not isLive and targetTime then 
        primaryText:SetPrelocalizedText("EVENT STARTING")
    else
        primaryText:SetPrelocalizedText(" ")
    end

end

function updateCountdownText()
    if targetTime then
        local now = os.time()
        local remaining = targetTime - now

        if remaining <= 0 then 
            countdownText:SetPrelocalizedText(" ")
            primaryText:SetPrelocalizedText(" ")
            targetTime = nil
        else
            countdownText:SetPrelocalizedText(formatRemainingTime(remaining))
        end
    end

end


function self:Awake()

end

function self:Start()
    primaryText:SetPrelocalizedText("")
    countdownText:SetPrelocalizedText("")
    Timer.Every(1, updateCountdownText)
    if EventDataManager then 
        EventDataManager.UpdateEventTime:Connect(function(targetTime, LiveStatus) setNewTargetTime(targetTime, LiveStatus) end)
        EventDataManager.RequestEventTime:FireServer()
    end
end

