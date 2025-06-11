--!Type(UI)

--!Bind
local _contentWindow:VisualElement = nil
--!Bind 
local _descriptionText: UILabel = nil
--!Bind 
local _smallDescriptionText: UILabel = nil
--!Bind
local _redeemButton:VisualElement = nil
--!Bind 
local _redeemButtonText: UILabel = nil
--!Bind
local _smallHeadingText:UILabel = nil
--!Bind
local _nameText:UILabel = nil
--!Bind
local _bannerImageContainer:VisualElement = nil


local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween
UIRaffleManager = require("RaffleUIManager")

_smallHeadingText:SetPrelocalizedText("DAILY RAFFLE")
_nameText:SetPrelocalizedText("YOU WON!")
_descriptionText:SetPrelocalizedText("1x Townie Trove")
_smallDescriptionText:SetPrelocalizedText("Open the box from <b>My Items > Consumables</b> to receive your prize.")
_redeemButtonText:SetEmojiPrelocalizedText("CLAIM BOX")

function close()
    self.gameObject:SetActive(false)
    UIRaffleManager.closeParticles()
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


function OnRedeemPress()
    close()
    UI:ExecuteDeepLink("http://high.rs/item?id=" .. "cn-6848a790f8ff0ff1cf481399" .. "&type=Container")
    UIRaffleManager.ClaimBoxRequest:Fire()
end


function self:Awake()
    -- _closeOverlay:RegisterPressCallback(close)
    _redeemButton:RegisterPressCallback(OnRedeemPress)
    bobTween:start()
end
