--!Type(UI)

--!Bind
local meter_fill : VisualElement = nil
--!Bind
local meter_container : VisualElement = nil
--!Bind
local room_timer : Label = nil

local gameManager = require("GameManager")

local uiManager = require("EventUIModule")

local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween

function ConvertSecondsToHMS(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local seconds = seconds % 60
    -- Xmin Xs
    local timeString = ""
    if hours > 0 then
        timeString = string.format("%dh %02dm %02ds", hours, minutes, seconds)
    elseif minutes > 0 then
        timeString = string.format("%02dm %02ds", minutes, seconds)
    else
        timeString = string.format("%02ds", seconds)
    end
    return timeString
end

function UpdateMeter(value, old)
    Tween:new(
        old,
        value,
        .2,
        false,
        false,
        TweenModule.Easing.linear,
        function(v)
            meter_fill.style.width = StyleLength.new(Length.Percent(v))
        end,
        function()
            meter_fill.style.width = StyleLength.new(Length.Percent(value))
        end
    ):start()
end

function SetTimer(seconds)
    room_timer.text = ConvertSecondsToHMS(seconds)
    if seconds <= 0 and room_timer.text ~= "" then
        room_timer.text = ""
    end
end

function self:Start()

    meter_fill.style.width = StyleLength.new(Length.Percent((gameManager.bossMeter.value/gameManager.bossSpawnLimit.value)*100))
    gameManager.bossMeter.Changed:Connect(function(value, old)
        UpdateMeter((value/gameManager.bossSpawnLimit.value)*100, (old/gameManager.bossSpawnLimit.value)*100)
    end)

    gameManager.cooldownTime.Changed:Connect(function(value)
        --print("Cooldown time changed", value)
        SetTimer(value)
    end)
end

meter_container:RegisterPressCallback(function()
    uiManager.OpenProgressRewards()
end)