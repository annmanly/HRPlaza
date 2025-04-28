--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil

--!SerializeField
--!Tooltip("EST date-time for Event01 end, in 'YYYY-MM-DD HH:MM:SS'")
local event01EndTime: string = "2025-06-15 12:00:00"

--!SerializeField
--!Tooltip("EST date-time for Event02 start, in 'YYYY-MM-DD HH:MM:SS'")
local event02StartTime: string = "2025-06-15 18:00:00"

--!SerializeField
--!Tooltip("EST date-time for Event02 end, in 'YYYY-MM-DD HH:MM:SS'")
local event02EndTime: string = "2025-06-15 20:00:00"

-- Parsed epoch times for each event marker
local _event1EndEpoch: number
local _event2StartEpoch: number
local _event2EndEpoch: number

-- Calculate local timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end
local tzOffset = getTimezoneOffset()

-- EST offset relative to UTC (EST = UTC-5)
local ET_OFFSET = 4 * 3600

-- Parse an EST date-time string into a UTC epoch timestamp
local function parseESTDateTime(str)
    print("[CountdownTimer] Parsing EST date string:", str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then print("[CountdownTimer] parseESTDateTime: failed to match pattern") return nil end
    local tbl = { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = tonumber(H), min = tonumber(Min), sec = tonumber(S) }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch + tzOffset
    local finalEpoch = utcEpoch + ET_OFFSET
    print("[CountdownTimer] naiveEpoch:", naiveEpoch, "utcEpoch:", utcEpoch, "finalEpoch:", finalEpoch)
    return finalEpoch
end

function self:Awake()
    print("[CountdownTimer] Awake: computing event epochs")
    _event1EndEpoch   = parseESTDateTime(event01EndTime)   or 0
    _event2StartEpoch = parseESTDateTime(event02StartTime) or 0
    _event2EndEpoch   = parseESTDateTime(event02EndTime)   or 0
    print("[CountdownTimer] event1EndEpoch=", _event1EndEpoch, "event2StartEpoch=", _event2StartEpoch, "event2EndEpoch=", _event2EndEpoch)
end

function self:Start()
    print("[CountdownTimer] Start: clearing label, current time:", os.time())
    countdownLabel:SetPrelocalizedText("")
end

function self:Update()
    local now = os.time()
    -- debug: show everything
    print(string.format(
      "[CountdownTimer] now=%d, E1end=%d, E2start=%d, E2end=%d",
      now, _event1EndEpoch, _event2StartEpoch, _event2EndEpoch
    ))

    -- 1) Before Event01 ends → clear label
    if now < _event1EndEpoch then
        print("[CountdownTimer] Phase: before Event01 end")
        countdownLabel:SetPrelocalizedText("")
        return
    end

    -- 2) Between Event01 end and Event02 start → show countdown
    if now < _event2StartEpoch then
        print("[CountdownTimer] Phase: countdown to Event02 start")
        local remaining = _event2StartEpoch - now
        print("[CountdownTimer] remaining seconds:", remaining)
        local h = math.floor(remaining / 3600)
        local m = math.floor((remaining % 3600) / 60)
        local s = remaining % 60
        local timeStr = (h > 0)
            and string.format("%02d:%02d:%02d", h, m, s)
            or string.format("%02d:%02d", m, s)
        print("[CountdownTimer] formatted time:", timeStr)
        countdownLabel:SetPrelocalizedText(timeStr)
        return
    end

    -- 3) During Event02 → show live text
    if now < _event2EndEpoch then
        print("[CountdownTimer] Phase: Event02 Live")
        countdownLabel:SetPrelocalizedText("Event02 Live!")
        return
    end

    -- 4) After Event02 ends → clear label
    print("[CountdownTimer] Phase: after Event02 end")
    countdownLabel:SetPrelocalizedText("")
end