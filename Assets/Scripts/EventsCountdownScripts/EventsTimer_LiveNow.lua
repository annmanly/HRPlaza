--!Type(UI)

--!Bind
local headerText: UILabel = nil

local isLive = false
local EventDataManager = require("EventDataManager")

local function updateHeader(newLive)
    if isLive ~= newLive then
        isLive = newLive
        if isLive then
            headerText:SetPrelocalizedText("LIVE\nNOW:")
        else 
            headerText:SetPrelocalizedText("COMING\nSOON:")
        end
    end
end


function self:Start()
    headerText:SetPrelocalizedText("COMING\nSOON:")


    if EventDataManager then 
        EventDataManager.UpdateEventTime:Connect(function(targetTime, LiveStatus) updateHeader(LiveStatus) end)
        EventDataManager.RequestEventTime:FireServer()
    end
end