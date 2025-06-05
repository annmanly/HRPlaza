--!Type(UI)

--!Bind
local _smallHeadingText:UILabel = nil
--!Bind
local _nameText:UILabel = nil
--!Bind
local _bannerImage:VisualElement = nil
--!Bind
local _bannerImageContainer:VisualElement = nil

local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween
local RaffleUIManager = require("RaffleUIManager")

_smallHeadingText:SetPrelocalizedText("DAILY RAFFLE WINNER")
_nameText:SetPrelocalizedText(" ")

function close()
    self.gameObject:SetActive(false)
    RaffleUIManager.closeParticles()
end

local bobTween = Tween:new(    
    0,
    -10,
    1,
    true,
    true,
    TweenModule.Easing.easeInOutQuad,
    function(value, t)
        _bannerImageContainer.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(value)))
    end,
    function()
    end
)

local nameSlideOutTween = Tween:new(
    0,
    60,
    0.5,
    false,
    false,
    TweenModule.Easing.easeInBack,
    function(value, t)
        _nameText.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(value)))
        _nameText.style.opacity = StyleFloat.new(1-t)
    end,
    function()
        _nameText.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(0)))
        _nameText.style.opacity = StyleFloat.new(0)
    end
)

local nameSlideInTween = Tween:new(
    -120,
    0,
    0.5,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        _nameText.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(value)))
        _nameText.style.opacity = StyleFloat.new(t)
    end,
    function()
        _nameText.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(0)))
        _nameText.style.opacity = StyleFloat.new(1)

    end
)

local bannerSlideOutTween = Tween:new(
    0,
    -120,
    0.5,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        _bannerImage.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(value)))
        _bannerImage.style.opacity = StyleFloat.new(t)
    end,
    function()
        _bannerImage.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(0)))
        _bannerImage.style.opacity = StyleFloat.new(1)
        close()
    end
)

local slideInTween = Tween:new(
    -120,
    0,
    0.5,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        _bannerImage.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(value)))
        _bannerImage.style.opacity = StyleFloat.new(t)
    end,
    function()
        _bannerImage.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(0)))
        _bannerImage.style.opacity = StyleFloat.new(1)
        nameSlideInTween:start()
    end
)

function showWinners(winnerNames)
    local delay = 4
    slideInTween:start()

    for i, name in winnerNames do
        if i == 1 then
             _nameText:SetPrelocalizedText(name)
            nameSlideInTween:start()
        else
            Timer.After(delay*(i-1), function() 
            nameSlideOutTween:start()
            _nameText:SetPrelocalizedText(name)
            nameSlideInTween:start()
        end)
        end
    end

    Timer.After(#winnerNames*delay, function() bannerSlideOutTween:start() end)
    
end


function self:Awake()
    bobTween:start()
    -- TestNames = {"Test1", "Test2", "Test3", "Test4"}
    -- Timer.After(5, function()  showWinners(TestNames) end)
    _bannerImageContainer:RegisterPressCallback(close)
end