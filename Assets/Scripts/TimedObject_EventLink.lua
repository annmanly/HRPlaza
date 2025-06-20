--!Type(ClientAndServer)

--!SerializeField
local objects : { GameObject } = nil

local ET_OFFSET = 4 * 3600  -- ET = UTC-4
local CHECK_INTERVAL = 60   -- check every 60 seconds

-- Calculate host timezone offset (local epoch minus UTC epoch)
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

local tzOffset = getTimezoneOffset()

-- Convert local time to ET-adjusted os.time
local function getETTime()
    return os.time() + ET_OFFSET
end

-- Check whether the current ET time is between Thursday 12:00 ET and Tuesday 12:00 ET
local function isWithinActiveWindow()
    local etNow = os.date("!*t", getETTime() - tzOffset) -- ET adjusted UTC time
    local wday = etNow.wday  -- Sunday = 1, Monday = 2, ..., Saturday = 7
    local hour = etNow.hour
    local min = etNow.min
    local sec = etNow.sec

    -- Calculate seconds since start of week (Sunday 00:00)
    local secondsSinceWeekStart = ((wday - 1) * 86400) + (hour * 3600) + (min * 60) + sec

    local thursdayNoon = (5 - 1) * 86400 + 12 * 3600 -- Thursday 12:00:00
    local tuesdayNoon  = (3 - 1) * 86400 + 12 * 3600 -- Tuesday 12:00:00

    if secondsSinceWeekStart >= thursdayNoon then
        return true -- Thursday noon through Saturday
    elseif secondsSinceWeekStart < tuesdayNoon then
        return true -- Sunday through Tuesday 12:00
    else
        return false -- Tuesday 12:00 through Thursday 12:00
    end
end

function self:Start()
    -- Initial check
    local active = isWithinActiveWindow()
    for i = 1, #objects do
        objects[i]:SetActive(active)
    end

    -- Repeat check every CHECK_INTERVAL seconds
    Timer.Every(CHECK_INTERVAL, function()
        local activeNow = isWithinActiveWindow()
        for i = 1, #objects do
            objects[i]:SetActive(activeNow)
        end
    end)
end
