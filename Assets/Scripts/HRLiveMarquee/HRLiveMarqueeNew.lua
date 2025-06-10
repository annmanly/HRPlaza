--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil
--!Bind
local countdownTimer: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil
--!Bind
local marqueeContainer: VisualElement = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with a public Texture[] field named 'textures') here")
local marqueeEventsSO : HRLive_ScriptableObject = nil

--!SerializeField
--!Tooltip("TextAsset containing ET start times, one per line ('YYYY-MM-DD HH:MM:SS')")
local startDatesTextAsset: TextAsset = nil

--!SerializeField
--!Tooltip("TextAsset containing ET end times, one per line ('YYYY-MM-DD HH:MM:SS')")
local endDatesTextAsset: TextAsset = nil

-- Internal lists
local _eventTextures = {}
local _eventStartEpochs = {}
local _eventEndEpochs = {}

-- State
local currentEventIndex = nil
local countdownTimerUpdater = nil
local countdownEndTimer = nil

-- Timezone setup
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()
local ET_OFFSET = 4 * 3600

local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return nil end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H), min = tonumber(Min), sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch - tzOffset
    return utcEpoch + ET_OFFSET
end

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then
        return string.format("%02d:%02d:%02d", h, m, s)
    else
        return string.format("%02d:%02d", m, s)
    end
end

local function startCountdown(targetTime, isLive)
    if countdownTimerUpdater then countdownTimerUpdater:Stop() end
    if countdownEndTimer then countdownEndTimer:Stop() end

    local now = os.time()
    local remaining = targetTime - now

    if not targetTime or remaining <= 0 then
        countdownLabel:SetPrelocalizedText("")
        countdownTimer:SetPrelocalizedText("")
        return
    end

    if isLive then
        countdownLabel:SetPrelocalizedText("LIVE NOW:")
        countdownTimer:SetPrelocalizedText("")
    else
        countdownLabel:SetPrelocalizedText("NEXT EVENT:")
        countdownTimer:SetPrelocalizedText(formatTime(remaining))
        countdownTimerUpdater = Timer.Every(1, function()
            local now = os.time()
            local remaining = targetTime - now
            if remaining <= 0 then
                self:Update()
                return
            end
            countdownTimer:SetPrelocalizedText(formatTime(remaining))
        end)
    end

    countdownEndTimer = Timer.After(remaining, function()
        self:Update()
    end)
end

function self:Awake()
    if not marqueeEventsSO then
        print("[Marquee] ERROR: MarqueeEventsSO not assigned or invalid")
        return
    end
    _eventTextures = marqueeEventsSO.GetEventImages()
    print(string.format("[Marquee] Loaded %d textures", #_eventTextures))

    if not startDatesTextAsset then print("[Marquee] ERROR: startDatesTextAsset not assigned") end
    if not endDatesTextAsset then print("[Marquee] ERROR: endDatesTextAsset not assigned") end
    local startText = startDatesTextAsset and startDatesTextAsset.text or ""
    local endText = endDatesTextAsset and endDatesTextAsset.text or ""

    local starts, ends = {}, {}
    for line in string.gmatch(startText, "([^\n]+)") do
        if line ~= "" then starts[#starts+1] = line end
    end
    for line in string.gmatch(endText, "([^\n]+)") do
        if line ~= "" then ends[#ends+1] = line end
    end
    print(string.format("[Marquee] Read %d start lines, %d end lines", #starts, #ends))

    local count = math.min(#starts, #ends, #_eventTextures)
    for i = 1, count do
        local sEp = parseETDateTime(starts[i])
        local eEp = parseETDateTime(ends[i])
        if sEp and eEp then
            _eventStartEpochs[#_eventStartEpochs+1] = sEp
            _eventEndEpochs[#_eventEndEpochs+1] = eEp
        else
            print(string.format("[Marquee] ERROR parsing event %d", i))
        end
    end

    countdownLabel:SetPrelocalizedText("")
    marqueeContainer:RemoveFromClassList("hidden")
    self:Update()
end

function self:Update()
    local now = os.time()
    local newIndex = nil
    local targetTime = nil
    local isLive = false

    for i = 1, #_eventStartEpochs do
        local s, e = _eventStartEpochs[i], _eventEndEpochs[i]
        if now < s then
            newIndex = i
            targetTime = s
            isLive = false
            break
        elseif now < e then
            newIndex = i
            targetTime = e
            isLive = true
            break
        end
    end

    if newIndex ~= currentEventIndex then
        currentEventIndex = newIndex
        if newIndex then
            imageDisplay.image = _eventTextures[newIndex]
            marqueeContainer:RemoveFromClassList("hidden")
            startCountdown(targetTime, isLive)
        else
            countdownLabel:SetPrelocalizedText("")
            countdownTimer:SetPrelocalizedText("")
            marqueeContainer:AddToClassList("hidden")
        end
    end
end
