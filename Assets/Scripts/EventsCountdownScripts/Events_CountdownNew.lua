--!Type(UI)

--!Bind
local billboardContainer : VisualElement = nil
--!Bind
local headerText        : VisualElement = nil
--!Bind
local primaryText       : VisualElement = nil
--!Bind
local countdownText     : UILabel        = nil
--!Bind
local billboardDisplay  : UIImage        = nil
--!Bind
local eventsSignBackground  : UIImage        = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with public fields GetEventStartDates() and GetEventImages()) here")
local Events_ScriptableObject : Events_ScriptableObject = nil

--!SerializeField
--!Tooltip("Assign Events Sign Background Here")
local SignImage : Texture = nil

-- Parsed lists
local _eventTextures     : table = {}
local _eventStartEpochs  : table = {}
local _eventEndEpochs    : table = {}
local eventNames        : {string}  = {}

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now    = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- ET offset relative to UTC (ET = UTC-4)
local ET_OFFSET = 4 * 3600

-- Parse an ET date-time string into a UTC epoch timestamp
local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return 0 end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),    min = tonumber(Min),    sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch   = naiveEpoch + tzOffset
    return utcEpoch + ET_OFFSET
end

function self:Awake()
    -- grab textures and start-times
    _eventTextures     = Events_ScriptableObject.GetEventImages()
    eventNames     = Events_ScriptableObject.GetEventNames()
    local eventStartTimes = Events_ScriptableObject.GetEventStartDates()


    -- build start and end epochs
    _eventStartEpochs = {}
    _eventEndEpochs   = {}
    for i, startStr in ipairs(eventStartTimes) do
        local startEpoch = parseETDateTime(startStr)
        _eventStartEpochs[i] = startEpoch
        -- add exactly 5 days to compute end time
        _eventEndEpochs[i]   = startEpoch + (5 * 86400)
    end
end

function self:Start()
    -- clear initial texts and show container
    headerText:SetPrelocalizedText("")
    primaryText:SetPrelocalizedText("")
    countdownText:SetPrelocalizedText("")
    billboardContainer:RemoveFromClassList("hidden")
    eventsSignBackground.image = SignImage

end

function self:Update()
    local now = os.time()
    local maxCount = math.min(
        #_eventStartEpochs,
        #_eventEndEpochs,
        #eventNames,
        #_eventTextures
    )

    for i = 1, maxCount do
        local startEpoch = _eventStartEpochs[i]
        local endEpoch   = _eventEndEpochs[i]

        if now >= startEpoch and now < endEpoch then
            -- LIVE NOW state
            local rem = endEpoch - now
            local d   = math.floor(rem / 86400)
            local h   = math.floor((rem % 86400) / 3600)
            local m   = math.floor((rem % 3600) / 60)
            local sec = rem % 60
            local formatted
            if d > 0 then
                formatted = string.format("%02d:%02d:%02d:%02d", d, h, m, sec)
            elseif h > 0 then
                formatted = string.format("%02d:%02d:%02d", h, m, sec)
            else
                formatted = string.format("%02d:%02d", m, sec)
            end
            headerText:SetPrelocalizedText("LIVE\nNOW:")
            primaryText:SetPrelocalizedText("EVENT ENDING:")
            countdownText:SetPrelocalizedText(formatted)
            billboardDisplay.image = _eventTextures[i]

            return

        elseif now < startEpoch then
            -- COMING SOON state
            local rem = startEpoch - now
            local d   = math.floor(rem / 86400)
            local h   = math.floor((rem % 86400) / 3600)
            local m   = math.floor((rem % 3600) / 60)
            local sec = rem % 60
            local formatted
            if d > 0 then
                formatted = string.format("%02d:%02d:%02d:%02d", d, h, m, sec)
            elseif h > 0 then
                formatted = string.format("%02d:%02d:%02d", h, m, sec)
            else
                formatted = string.format("%02d:%02d", m, sec)
            end
            headerText:SetPrelocalizedText("COMING\nSOON:")
            primaryText:SetPrelocalizedText("EVENT STARTING")
            countdownText:SetPrelocalizedText(formatted)
            billboardDisplay.image = _eventTextures[i]

            return
        end
    end

    -- No active or upcoming events
    headerText:SetPrelocalizedText("")
    primaryText:SetPrelocalizedText("")
    countdownText:SetPrelocalizedText("")
    billboardContainer:AddToClassList("hidden")
end
