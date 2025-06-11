--!Type(UI)

local storageManager = require("StorageManager")

--!Bind
local imageDisplay : UIImage = nil
--!Bind
local image02Display : UIImage = nil
--!Bind
local image03Display : UIImage = nil
--!Bind
local image04Display : UIImage = nil
--!Bind
local image05Display : UIImage = nil

local imageDisplays = {
    imageDisplay,
    image02Display,
    image03Display,
    image04Display,
    image05Display
}

function self:Awake()
    for i, image in ipairs(imageDisplays) do
        local banner = storageManager.bannerURLs[i]
        if banner then
            image:LoadFromCdnUrl(banner.value)

            banner.Changed:Connect(function(newURL)
                if newURL and newURL ~= "" then
                    image:LoadFromCdnUrl(newURL)
                end
            end)
        else
            print("WARNING: No banner found for index " .. i)
        end
    end
end
