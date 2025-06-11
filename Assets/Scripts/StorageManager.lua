--!Type(Module)

--!SerializeField
local defaultBannerURL : string = "https://cdn.highrisegame.com/trivia_venice.png"

bannerKeys = {
    "EventBannerURL",
    "Event02BannerURL",
    "Event03BannerURL",
    "Event04BannerURL",
    "Event05BannerURL"
}

bannerURLs = {}

for i, key in ipairs(bannerKeys) do
    bannerURLs[i] = StringValue.new(key, defaultBannerURL)
end

function self:ServerAwake()
    for i, key in ipairs(bannerKeys) do
        local banner = bannerURLs[i]
        Storage.GetValue(key, function(storageValue)
            if storageValue then
                banner.value = storageValue
            else
                print("WARNING: No event banner URL found in storage for " .. key .. ", storing default.")
                Storage.SetValue(key, defaultBannerURL)
            end
        end)
    end
end
