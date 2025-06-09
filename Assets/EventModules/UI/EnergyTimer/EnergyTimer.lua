--!Type(UI)

--!Bind
local timer_label : Label = nil
--!Bind
local energy_amount : Label = nil
--!Bind
local energy_max : Label = nil
--!Bind
local progress_bar_fill : VisualElement = nil

local prankModule = require("PrankModule")
local clientPrankModule = require("ClientPrankModule")
local utils = require("Utils")  -- Utility functions.
local EventUIModule = require("EventUIModule")  -- Module for event UI.

local TweenModule = require("TweenModule")  -- Tween module.
local Tween = TweenModule.Tween  -- Tween class for creating animations.
local Easing = TweenModule.Easing  -- Easing functions for animations.


local timeRemaining = 0
energy = 0
local maxEnergy = 0
local energyTimer = nil

SetStateValues = function(state : prankModule.UserPrankState)
    local eventStatus : prankModule.TicketEventUserStatus = state.eventStatus

    energy = eventStatus.energyAmount
    energy_amount.text = tostring(eventStatus.energyAmount)
    maxEnergy = eventStatus.energyMax
    energy_max.text = "/" .. tostring(eventStatus.energyMax)

    timeRemaining = eventStatus.energyNextIncrementIn
    --print("Time Remaining: " .. tostring(timeRemaining))
    StartEnergyTimer()

    local _energyPercentage = energy / maxEnergy
    local _energybarWidth = 100 * _energyPercentage
    _energybarWidth = math.min(100, _energybarWidth)
    progress_bar_fill.style.width = StyleLength.new(Length.Percent(_energybarWidth))
end

function StopEnergyTimer()
    if energyTimer then
        energyTimer:Stop()
        energyTimer = nil
    end
    clientPrankModule.SyncUItoState()
end
function StartEnergyTimer()
    if energyTimer then
        energyTimer:Stop()
        energyTimer = nil
    end
    energyTimer = Timer.Every(1, function()
        if energy < maxEnergy then
            if timeRemaining > 0 then
                timeRemaining = timeRemaining - 1

                -- convert seconds to minutes and seconds
                minutes = math.floor(timeRemaining / 60)
                seconds = timeRemaining % 60
                timer_label.text = tostring(minutes) .. "m " .. tostring(seconds) .. "s"

            else
                timeRemaining = 0
                --energy = energy + 1
                --energy_amount.text = tostring(energy)
                if energy == maxEnergy then
                    timer_label.text = "Energy Full"
                end
                StopEnergyTimer()
            end
        else
            timer_label.text = "Energy Full"
        end
    end)
end

function CheckEnergy()
    if energy < clientPrankModule.GetActionStack() then
        print("Not enough energy to perform action")
        EventUIModule.OpenEnergyShop()
        return false
    else
        return true
    end
end