--!Type(Module)

--!SerializeField
local defaultBannerURL : string = "https://cdn.highrisegame.com/trivia_venice.png"

EventBannerURL = StringValue.new("EventBannerURL", defaultBannerURL)
Event02BannerURL = StringValue.new("Event02BannerURL", defaultBannerURL)

function self:ServerAwake()
    Storage.GetValue("EventBannerURL", function(storageValue)
        if storageValue then
            EventBannerURL.value = storageValue
        else
            print("WARNING: No event banner URL found in storage, storing default.")
            Storage.SetValue("EventBannerURL", defaultBannerURL)
        end
    end)

    Storage.GetValue("Event02BannerURL", function(storageValue)
        if storageValue then
            Event02BannerURL.value = storageValue
        else
            print("WARNING: No event banner URL found in storage, storing default.")
            Storage.SetValue("Event02BannerURL", defaultBannerURL)
        end
    end)
end