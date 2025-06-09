--!Type(UI)

local uiManager = require("EventUIModule")
buffIcons = uiManager.buffIcons -- Buff icons for the HUD.

local buffIconmap = {
    spawnRateBuff_short = buffIcons[1],
    spawnRateBuff_long = buffIcons[1],
    luckBuff_short = buffIcons[2],
    luckBuff_long = buffIcons[2],
    speedBuff_short = buffIcons[3],
    speedBuff_long = buffIcons[3],
    rainbowBaloonBuff = buffIcons[4],
}

--!Bind
local buffhud_container : VisualElement = nil

-- Import Tweening module for animations.
local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween -- Tween class for creating animations.
local Easing = TweenModule.Easing -- Easing functions for animations.

local gameManager = require("GameManager")

buffHuds = {}
local countDowns = {}

function ConvertSecondsToMinutes(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    return string.format("%02d:%02d", minutes, remainingSeconds)
end

function CreateBuffDisplay(buffInfo)

    local timeRemaining = buffInfo.timeRemaining
    local buffType = buffInfo.buffType
    local buffIcon = buffIconmap[buffType]

    local newItem = VisualElement.new()
    newItem:AddToClassList("buffhud_item")

    local newIcon = Image.new()
    newIcon:AddToClassList("buffhud_icon")
    newIcon.image = buffIcon

    -- Timer Bar
    local timerLabel = Label.new()
    timerLabel:AddToClassList("buffhud_timerlabel")
    timerLabel.text = ConvertSecondsToMinutes(timeRemaining)

    newItem:Add(newIcon)
    newItem:Add(timerLabel)

    buffhud_container:Add(newItem)

    --print(timeRemaining)

    local _tempTimeLeft = timeRemaining
    local countDownTimer = Timer.Every(1, function()
        _tempTimeLeft = _tempTimeLeft - 1
        timerLabel.text = ConvertSecondsToMinutes(_tempTimeLeft)
    end)
    table.insert(countDowns, countDownTimer)

    Timer.After(timeRemaining, function()
        -- Remove the buff display after the duration ends
        if newItem then
            newItem:RemoveFromHierarchy()
        end
        -- Remove the countdown timer after the buff duration ends
        if countDownTimer then
            countDownTimer:Stop()
            countDownTimer = nil
        end
        -- Remove the buff from the HUDs table
        buffHuds[buffType] = nil
    end)

    return newItem
end

function self:Start()

    local playerinfo = gameManager.players[client.localPlayer]

    gameManager.createBufHudEvent:Connect(function(buffInfo)
        -- Check if the buff is still active (e.g., 3 minutes)
        local stillActive, timeRemaining = gameManager.GetBuffStatus(playerinfo[buffInfo.buffType], buffInfo.buffType)
        if stillActive then

            if buffHuds[buffInfo.buffType] then
                buffHuds[buffInfo.buffType]:RemoveFromHierarchy()
                buffHuds[buffInfo.buffType] = nil
            end
            
            -- Create the buff display
            local newBuff = CreateBuffDisplay(buffInfo)
            buffHuds[buffInfo.buffType] = newBuff
            
        else
            -- Remove the buff effect here (e.g., reset spawn rate, speed, etc.)
            print("Buff is no longer active for player: ", client.localPlayer.name, "Buff: ", buffInfo.buffType)
            -- Remove the buff display if it exists
            if buffHuds[buffInfo.buffType] then
                buffHuds[buffInfo.buffType]:RemoveFromHierarchy()
                buffHuds[buffInfo.buffType] = nil
            end
        end
    end)

end