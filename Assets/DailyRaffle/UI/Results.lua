--!Type(UI)

--!Bind
local _smallHeadingText:UILabel = nil
--!Bind
local _headingText:UILabel = nil
--!Bind
local _bannerImage:VisualElement = nil
--!Bind
local _bannerImageContainer:VisualElement = nil


local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween
local RaffleUIManager = require("RaffleUIManager")

_smallHeadingText:SetPrelocalizedText("DAILY RAFFLE")
_headingText:SetPrelocalizedText("WINNERS SELECTED")

function close()
    self.gameObject:SetActive(false)
    -- RaffleUIManager.closeParticles()
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
        bobTween:start()
    end
)

function showWinners(winnerNames)
    local delay = 10
    slideInTween:stop()
    bannerSlideOutTween:stop()
    slideInTween:start()

    Timer.After(delay, function() bobTween:stop() bannerSlideOutTween:start() end)
    
end


function self:Awake()
    
    -- TestNames = {"Test1", "Test2", "Test3", "Test4"}
    -- Timer.After(5, function()  showWinners(TestNames) end)
    _bannerImageContainer:RegisterPressCallback(close)
    -- _closeOverlay:RegisterPressCallback(close)

end