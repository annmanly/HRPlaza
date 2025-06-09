--!Type(UI)

local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween

--!Bind
local _number: Label = nil

local popInTween = Tween:new(
    0.01,
    1,
    0.5,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value)
        _number.style.scale = StyleScale.new(Scale.new((Vector2.new(value, value))))
    end,
    function()
        _number.style.scale = StyleScale.new(Scale.new((Vector2.new(1, 1))))
    end
)

local shrinkOutTween = Tween:new(
    1,
    0.01,
    0.5,
    false,
    false,
    TweenModule.Easing.easeInBack,
    function(value)
        _number.style.scale = StyleScale.new(Scale.new((Vector2.new(value, value))))
    end,
    function()
        _number:EnableInClassList("hidden", true)
    end
)

function self:Awake()
    popInTween:start()
    Timer.After(1, function()
        shrinkOutTween:start()
    end)
end

function SetNum(number)
    _number.text = "+"..tostring(number)
end