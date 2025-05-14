--!Type(UI)

--!Bind
local billboardDisplay: UIImage = nil
--!Bind
local infoDate: UILabel = nil
--!Bind
local infoTime: UILabel = nil

--!SerializeField
--!Tooltip("Assign a ScriptableObject of type MarqueeEventsSO (with a public Texture[] field named 'textures') here")
local marqueeEventsSO : HRLive_ScriptableObject = nil

--!SerializeField
--!Tooltip("TextAsset containing one EST date/time per line ('YYYY-MM-DD HH:MM:SS')")
local datesTextAsset: TextAsset = nil

-- Loaded list of event date/time strings
local eventDateTimes: {string} = {}

-- Internal state for cycling
local _currentIndex = 1
local _lastSwitchTime = 0
local _switchInterval = 5 -- seconds between cycles
local eventImages =  marqueeEventsSO.GetEventImages()


-- Helper: calculate weekday using Zeller's congruence
local function calcWeekday(year, month, day)
    if month < 3 then
        year = year - 1
        month = month + 12
    end
    local K = year % 100
    local J = math.floor(year / 100)
    local h = (day + math.floor((13 * (month + 1)) / 5) + K + math.floor(K / 4) + math.floor(J / 4) + 5 * J) % 7
    local names = {"SATURDAY", "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"}
    return names[h + 1]
end

function self:Awake()
    -- Initialize index and load dates from serialized TextAsset
    _currentIndex = 1
    eventDateTimes = {}
    if datesTextAsset then
        print(string.format("[ComingUp] Dates TextAsset assigned (%d chars)", #datesTextAsset.text))
        for line in string.gmatch(datesTextAsset.text, "([^\n]+)") do
            if line ~= "" then table.insert(eventDateTimes, line) end
        end
        print(string.format("[ComingUp] Loaded %d dates, Images count: %d", #eventDateTimes, #eventImages))
    else
        print("[ComingUp] Dates TextAsset not assigned on " .. (self.name or "<unknown>"))
    end
    if #eventDateTimes ~= #eventImages then
        print(string.format("[ComingUp] Dates count (%d) does not match images count (%d)", #eventDateTimes, #eventImages))
    end
end

function self:Start()
    -- Start cycling immediately
    _lastSwitchTime = os.time()
    self:UpdateDisplay()
end

function self:UpdateDisplay()
    -- Update image
    billboardDisplay.image = eventImages[_currentIndex]
    
    -- Parse date/time string
    local dtStr = eventDateTimes[_currentIndex] or ""
    local y, mo, d, h, mi = string.match(dtStr, "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):%d+")
    if not y then
        print("[ComingUp] Failed to parse date/time: '" .. dtStr .. "'")
    end
    if y then
        local year = tonumber(y)
        local month = tonumber(mo)
        local day = tonumber(d)
        local hour = tonumber(h)
        local minute = tonumber(mi)

        -- Format date: WEEKDAY -- MONTH DAY
        local weekday = calcWeekday(year, month, day)
        local monthNames = {"JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"}
        local monthName = monthNames[month]
        infoDate:SetPrelocalizedText(string.format("%s -- %s %d", weekday, monthName, day))

        -- Format time: H:MM AM/PM
        local suffix = "AM"
        local hr12 = hour
        if hr12 == 0 then
            hr12 = 12
        elseif hr12 == 12 then
            suffix = "PM"
        elseif hr12 > 12 then
            hr12 = hr12 - 12
            suffix = "PM"
        end
        local timeStr = string.format("%d:%02d %s", hr12, minute, suffix)
        infoTime:SetPrelocalizedText(timeStr)
    else
        infoDate:SetPrelocalizedText("")
        infoTime:SetPrelocalizedText("")
    end
end

function self:Update()
    -- Cycle every interval
    local now = os.time()
    if now - _lastSwitchTime >= _switchInterval then
        _currentIndex = (_currentIndex % #eventImages) + 1
        _lastSwitchTime = now
        self:UpdateDisplay()
    end
end
