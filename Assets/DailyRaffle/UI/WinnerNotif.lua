--!Type(UI)
--!Bind
local _closeOverlay:VisualElement = nil

--!Bind
local _contentWindow:VisualElement = nil
--!Bind 
local _descriptionText: UILabel = nil
--!Bind
local _redeemButton:VisualElement = nil
--!Bind 
local _redeemButtonText: UILabel = nil

_descriptionText:SetPrelocalizedText("YOU RECEIVED:\n 1x Townie Token")
_redeemButtonText:SetEmojiPrelocalizedText("REDEEM PRIZE")
manager = require("RaffleUIManager")

function close()
    self.gameObject:SetActive(false)
    manager.closeParticles()
end

function OnRedeemPress()
    close()
    UI:ExecuteDeepLink("https://high.rs/shop?type=ic&id=65b2c1ce054206f608be9658")
end


function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _redeemButton:RegisterPressCallback(OnRedeemPress)
end
