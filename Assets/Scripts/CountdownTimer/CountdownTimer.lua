--!Type(UI)

--!Bind
local countdownLabel: UILabel = nil

--!SerializeField
--!Tooltip("List of local date-times for event starts in 'YYYY-MM-DD HH:MM:SS'")
local eventStartTimes: {string} = {"2025-06-15 10:00:00", "2025-06-15 18:00:00"}

--!SerializeField
--!Tooltip("List of local date-times for event ends in 'YYYY-MM-DD HH:MM:SS'")
local eventEndTimes: {string} = {"2025-06-15 12:00:00", "2025-06-15 20:00:00"}

-- Parsed epoch times for each event marker
local _eventStartEpochs: table = {}
local _eventEndEpochs: table = {}

-- Parse a local date-time string into an epoch timestamp (DST-aware)
local function parseLocalDateTime(str)
    print("[CountdownTimer] Parsing local date-time:", str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then
        print("[CountdownTimer] parseLocalDateTime: failed to match pattern", str)
        return nil
    end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H),   min = tonumber(Min),      sec = tonumber(S),
        isdst = false  -- auto-detect DST
    }
    local epoch = os.time(tbl)
    print("[CountdownTimer] parseLocalDateTime: epoch =", epoch)
    return epoch
end

function self:Awake()
    print("[CountdownTimer] Awake: parsing multiple events")
    -- Ensure tables are clear
    _eventStartEpochs = {}
    _eventEndEpochs = {}

    -- Parse each paired start/end time
    local count = math.min(#eventStartTimes, #eventEndTimes)
    for i = 1, count do
        local sEpoch = parseLocalDateTime(eventStartTimes[i]) or 0
        local eEpoch = parseLocalDateTime(eventEndTimes[i])   or 0
        table.insert(_eventStartEpochs, sEpoch)
        table.insert(_eventEndEpochs, eEpoch)
        print(string.format("[CountdownTimer] Event %d: start=%d, end=%d", i, sEpoch, eEpoch))
    end
end

function self:Start()
    print("[CountdownTimer] Start: clearing label, now=", os.time())
    countdownLabel:SetPrelocalizedText("")
end

function self:Update()
    local now = os.time()
    -- Debug all events
    for i = 1, #_eventStartEpochs do
        print(string.format(
          "[CountdownTimer] Event %d epochs: start=%d, end=%d", 
          i, _eventStartEpochs[i], _eventEndEpochs[i]
        ))
    end
    print("[CountdownTimer] now =", now)

    -- Iterate through events
    for i = 1, #_eventStartEpochs do
        local s = _eventStartEpochs[i]
        local e = _eventEndEpochs[i]
        -- Before event start: countdown
        if now < s then
            print(string.format("[CountdownTimer] Phase: countdown to Event %d start", i))
            local remaining = s - now
            local h = math.floor(remaining / 3600)
            local m = math.floor((remaining % 3600) / 60)
            local sec = remaining % 60
            local timeStr = (h > 0)
                and string.format("%02d:%02d:%02d", h, m, sec)
                or string.format("%02d:%02d", m, sec)
            print(string.format("[CountdownTimer] remaining to E%d start: %d (%s)", i, remaining, timeStr))
            countdownLabel:SetPrelocalizedText(timeStr)
            return
        end
        -- During event: live
        if now < e then
            print(string.format("[CountdownTimer] Phase: Event %d Live", i))
            countdownLabel:SetPrelocalizedText(string.format("Event%02d Live!", i))
            return
        end
    end

    -- After all events: clear label
    print("[CountdownTimer] Phase: after all events")
    countdownLabel:SetPrelocalizedText("")
end
