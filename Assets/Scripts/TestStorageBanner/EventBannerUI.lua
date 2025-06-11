--!Type(UI)

local storageManager = require("StorageManager")
--!Bind
local imageDisplay : UIImage = nil
--!Bind
local image02Display : UIImage = nil


function self:Awake()
    imageURL = storageManager.EventBannerURL.value
    imageDisplay:LoadFromCdnUrl(imageURL)

    storageManager.EventBannerURL.Changed:Connect(function(newURL)
        if newURL and newURL ~= "" then
            imageDisplay:LoadFromCdnUrl(newURL)
        end
    end)

    image02URL = storageManager.Event02BannerURL.value
    image02Display:LoadFromCdnUrl(image02URL)

    storageManager.Event02BannerURL.Changed:Connect(function(newURL)
        if newURL and newURL ~= "" then
            image02Display:LoadFromCdnUrl(newURL)
        end
    end)
end