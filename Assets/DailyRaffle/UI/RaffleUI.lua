--!Type(UI)

--!Bind
local _closeOverlay:VisualElement = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _contentWindow:VisualElement = nil
--!Bind
local _infoButton:VisualElement = nil
--!Bind
local _redeemButton:VisualElement = nil
--!Bind
local _infoButtonText:UILabel = nil
--!Bind
local _redeemButtonText:UILabel = nil
--!Bind
local _countDown:Label = nil
--!Bind
local _playerTicketCount:Label = nil


local raffleUIManager = require("RaffleUIManager")

_infoButtonText:SetPrelocalizedText("HOW TO PLAY")
_redeemButtonText:SetPrelocalizedText("VIEW PRIZES")

function setTicketCount(number)
    _playerTicketCount.text = `You have {number} tickets.`
end

function timeUntilTomorrow(targetTime)

    -- Get the current time in UTC
    local currentTime = os.time(os.date("!*t"))



    -- Create the target time table in UTC
    local tomorrowExact = os.time(os.date("!*t")) + (24*60*60)
    local tomorrowDate = os.date("!*t",tomorrowExact)
    local targetTime = os.time({
        year = tomorrowDate.year,
        month = tomorrowDate.month,
        day = tomorrowDate.day,
        hour = 0,
        min =  0,
        sec = 0
    })

    -- Calculate the difference in seconds
    local diffInSeconds = os.difftime(targetTime, currentTime)

    -- If the time has already passed, return "0:0:0"
    if diffInSeconds <= 0 then
        print(`diff below zero {diffInSeconds}`)
        return "00:00:00:00"
    end

    -- Convert the difference to days, hours, and minutes
    local days = math.floor(diffInSeconds / (24 * 3600))
    diffInSeconds = diffInSeconds % (24 * 3600)

    local hours = math.floor(diffInSeconds / 3600)
    diffInSeconds = diffInSeconds % 3600

    local minutes = math.floor(diffInSeconds / 60)

    local sec = diffInSeconds % 60

    -- Return the formatted string
    return string.format("%02d:%02d:%02d", hours, minutes, sec)
end

function updateTimer()
    _countDown.text = timeUntilTomorrow()
end

function close()
    self.gameObject:SetActive(false)
end

function OnInfoPress()
    raffleUIManager.openInfo()
    close()
end

function OnRedeemPress()
    close()
    UI:ExecuteDeepLink("http://high.rs/item?id=cn-6848a790f8ff0ff1cf481399&type=Container")
end


function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _closeButton:RegisterPressCallback(close)
    _infoButton:RegisterPressCallback(OnInfoPress)
    _redeemButton:RegisterPressCallback(OnRedeemPress)

    updateTimer()
    Timer.Every(1, function() if self.gameObject.activeInHierarchy then updateTimer() end end)
end
