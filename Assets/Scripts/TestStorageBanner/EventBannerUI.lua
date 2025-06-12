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
--!Bind
local image06Display : UIImage = nil
--!Bind
local image07Display : UIImage = nil
--!Bind
local image08Display : UIImage = nil
--!Bind
local image09Display : UIImage = nil
--!Bind
local image10Display : UIImage = nil
--!Bind
local image11Display : UIImage = nil
--!Bind
local image12Display : UIImage = nil
--!Bind
local image13Display : UIImage = nil
--!Bind
local image14Display : UIImage = nil
--!Bind
local image15Display : UIImage = nil
--!Bind
local image16Display : UIImage = nil
--!Bind
local image17Display : UIImage = nil
--!Bind
local image18Display : UIImage = nil
--!Bind
local image19Display : UIImage = nil
--!Bind
local image20Display : UIImage = nil
--!Bind
local image21Display : UIImage = nil
--!Bind
local image22Display : UIImage = nil
--!Bind
local image23Display : UIImage = nil
--!Bind
local image24Display : UIImage = nil
--!Bind
local image25Display : UIImage = nil

local imageDisplays = {
    imageDisplay,
    image02Display,
    image03Display,
    image04Display,
    image05Display,
    image06Display,
    image07Display,
    image08Display,
    image09Display,
    image10Display,
    image11Display,
    image12Display,
    image13Display,
    image14Display,
    image15Display,
    image16Display,
    image17Display,
    image18Display,
    image19Display,
    image20Display,
    image21Display,
    image22Display,
    image23Display,
    image24Display,
    image25Display
}

function self:Awake()
    for i, image in ipairs(imageDisplays) do
        local banner = storageManager.HRLiveEventBannerURLs[i]
        print("Loaded banners:", #storageManager.HRLiveEventBannerURLs)
        if banner then
            image:LoadFromCdnUrl(banner.value)

            banner.Changed:Connect(function(newURL)
                if newURL and newURL ~= "" then
                    image:LoadFromCdnUrl(newURL)
                end
            end)
        else
            print("WARNING: No HRLive banner found for index " .. i)
        end
    end
end
