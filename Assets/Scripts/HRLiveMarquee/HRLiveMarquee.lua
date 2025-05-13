--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil
--!Bind
local billboardDisplay: UIImage = nil
--!Bind
local timerContainer: VisualElement = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with a public Texture[] field named 'textures') here")
local marqueeEventsSO : HRLive_ScriptableObject = nil

--!SerializeField
--!Tooltip("TextAsset containing ET start times, one per line ('YYYY-MM-DD HH:MM:SS')")
local startDatesTextAsset: TextAsset = nil

--!SerializeField
--!Tooltip("TextAsset containing ET end times, one per line ('YYYY-MM-DD HH:MM:SS')")
local endDatesTextAsset: TextAsset = nil

-- Internal lists populated in Awake()
local _eventTextures = {}
local _eventStartEpochs = {}
local _eventEndEpochs = {}

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- ET offset relative to UTC (ET = UTC-4)
local ET_OFFSET = 4 * 3600

-- Parse an ET date-time string into a UTC epoch timestamp
local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return nil end
    local tbl = { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = tonumber(H), min = tonumber(Min), sec = tonumber(S) }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch - tzOffset
    return utcEpoch + ET_OFFSET
end

function self:Awake()
    -- Validate SO
    if not marqueeEventsSO then
        print("[Marquee] ERROR: MarqueeEventsSO not assigned or invalid")
        return
    end
    _eventTextures = marqueeEventsSO.GetEventImages()
    print(string.format("[Marquee] Loaded %d textures", #_eventTextures))

    -- Validate TextAssets
    if not startDatesTextAsset then print("[Marquee] ERROR: startDatesTextAsset not assigned") end
    if not endDatesTextAsset then print("[Marquee] ERROR: endDatesTextAsset not assigned") end
    local startText = startDatesTextAsset and startDatesTextAsset.text or ""
    local endText = endDatesTextAsset and endDatesTextAsset.text or ""

    -- Read lines
    local starts, ends = {}, {}
    for line in string.gmatch(startText, "([^\n]+)") do
        if line ~= "" then starts[#starts+1] = line end
    end
    for line in string.gmatch(endText, "([^\n]+)") do
        if line ~= "" then ends[#ends+1] = line end
    end
    print(string.format("[Marquee] Read %d start lines, %d end lines", #starts, #ends))

    -- Prepare events
    local count = math.min(#starts, #ends, #_eventTextures)
    for i=1,count do
        local sEp = parseETDateTime(starts[i])
        local eEp = parseETDateTime(ends[i])
        if sEp and eEp then
            _eventStartEpochs[#_eventStartEpochs+1] = sEp
            _eventEndEpochs[#_eventEndEpochs+1] = eEp
        else
            print(string.format("[Marquee] ERROR parsing event %d", i))
        end
    end

    -- Init UI
    countdownLabel:SetPrelocalizedText("")
    timerContainer:RemoveFromClassList("hidden")
end

function self:Update()
    local now = os.time()
    for i=1,#_eventStartEpochs do
        local s, e = _eventStartEpochs[i], _eventEndEpochs[i]
        if now < s then
            local rem = s - now
            local h = math.floor(rem/3600)
            local m = math.floor((rem%3600)/60)
            local sec = rem%60
            local txt = (h>0) and string.format("%02d:%02d:%02d",h,m,sec) or string.format("%02d:%02d",m,sec)
            countdownLabel:SetPrelocalizedText("Next Event: "..txt)
            billboardDisplay.image = _eventTextures[i]
            return
        elseif now < e then
            countdownLabel:SetPrelocalizedText("LIVE NOW:")
            billboardDisplay.image = _eventTextures[i]
            return
        end
    end
    countdownLabel:SetPrelocalizedText("")
    timerContainer:AddToClassList("hidden")
end
