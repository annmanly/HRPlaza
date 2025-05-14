--!Type(ScriptableObject)

--!SerializeField
local eventImages: {Texture} = {}

--!SerializeField
local eventStartDates: {string} = {}

--!SerializeField
local eventNames: {string} = {}

--!SerializeField
local grabLinkUrls : {string} = {}

function GetEventImages() : {Texture}
    return eventImages
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