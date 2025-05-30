--!Type(ScriptableObject)

--!SerializeField
local grabBanners: {Texture} = {}

--!SerializeField
local eventHuds: {Texture} = {}

--!SerializeField
local eventStartDates: {string} = {}

--!SerializeField
local eventNames: {string} = {}

--!SerializeField
local grabLinkUrls : {string} = {}

function GetGrabBanners() : {Texture}
    return grabBanners
end

function GetEventHuds() : {Texture}
    return eventHuds
end

function GetEventStartDates() : {String}
    return eventStartDates
end

function GetEventNames() : {String}
    return eventNames
end

function GetGrabLinks() : {String}
    return grabLinkUrls
end