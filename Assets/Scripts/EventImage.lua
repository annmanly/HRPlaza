--!Type(UI)

--!Bind
local imageDisplay: UIImage = nil

local EventDataManager = require("EventDataManager")

local currentURL = ""

function updateImage(url)
    if url ~= currentURL  then
        imageDisplay:LoadFromCdnUrl(url)
        currentURL = url
    end
end

function self:Awake()
    if EventDataManager then 
        updateImage(EventDataManager.defaultURL)
        EventDataManager.UpdateEventImageURL:Connect(updateImage)
        EventDataManager.RequestEventImageURL:FireServer()
    end
end