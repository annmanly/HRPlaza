--!Type(Module)


--!SerializeField
local defaultBannerURL : string = "https://cdn.highrisegame.com/trivia_venice.png"

EventBannerURL = StringValue.new("EventBannerURL", defaultBannerURL)

function self:ServerAwake()
    Storage.GetValue("EventBannerURL", function(storageValue)
        if storageValue then
            EventBannerURL.value = storageValue
        else
            print("WARNING: No event banner URL found in storage, storing default.")
            Storage.SetValue("EventBannerURL", defaultBannerURL)
        end
    end)
end