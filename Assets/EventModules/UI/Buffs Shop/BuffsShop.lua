--!Type(UI)

local gameManager = require("GameManager")
local uiManager = require("EventUIModule")
local purchaseManager = require("PurchaseManager")
-- Import Tweening module for animations.
local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween -- Tween class for creating animations.
local Easing = TweenModule.Easing -- Easing functions for animations.
buffIcons = uiManager.buffIcons -- Buff icons for the HUD.

local buffIconmap = {
    spawnRateBuff_short = buffIcons[1],
    spawnRateBuff_long = buffIcons[1],
    luckBuff_short = buffIcons[2],
    luckBuff_long = buffIcons[2],
    speedBuff_short = buffIcons[3],
    speedBuff_long = buffIcons[3],
    rainbow_buff_50 = buffIcons[4],
}

--!Bind
local shop_panel : VisualElement = nil
--!Bind
local header : VisualElement = nil
--!Bind
local _scrollView : UIScrollView = nil
--!Bind
local click_off : VisualElement = nil

-- Tween the Root UI element scaling in.
local InfoCardPopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.35, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		shop_panel.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
		--Slide up
		local yPos = (1 - value) * 500
		shop_panel.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(yPos)))
	end,
	function() -- Completion callback (unused here).
		shop_panel.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

-- Tween the Title UI element scaling in.
local TitlePopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.5, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		header.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
	end,
	function() -- Completion callback (unused here).
		header.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

-- Tween Leaderboard UI element scaling in.
local StorePopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.35, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		_scrollView.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
	end,
	function() -- Completion callback (unused here).
		_scrollView.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)


function CreateItem(itemData, countNotTime)
    local _item = VisualElement.new()
    _item:AddToClassList("item-entry")

    local _icon = Image.new()
    _icon:AddToClassList("item-icon")

    _item:Add(_icon)
    _icon.image = buffIconmap[itemData.id]
    local _timeLabel = Label.new()
    _timeLabel:AddToClassList("item-time-label")
    _timeLabel.text = itemData.time.."m"
    if countNotTime then
        _timeLabel.text = itemData.time
    end
    _icon:Add(_timeLabel)

    local _infoContainer = VisualElement.new()
    _infoContainer:AddToClassList("item-info-container")

    local _title = Label.new()
    _title:AddToClassList("item-title")
    _title.text = itemData.title

    _infoContainer:Add(_title)

    local _description = Label.new()
    _description:AddToClassList("item-description")
    _description.text = itemData.description

    _infoContainer:Add(_description)

    local _purchaseButton = VisualElement.new()
    _purchaseButton:AddToClassList("item-purchase-button")
    local _goldIcon = VisualElement.new()
    _goldIcon:AddToClassList("item-gold-icon")
    _purchaseButton:Add(_goldIcon)
    local _goldLabel = Label.new()
    _goldLabel:AddToClassList("item-gold-label")
    _goldLabel.text = itemData.price
    _purchaseButton:Add(_goldLabel)

    _infoContainer:Add(_purchaseButton)

    _item:Add(_infoContainer)

    local _itemLocked = false

    _item:EnableInClassList("locked", _itemLocked)

    _purchaseButton:RegisterPressCallback(function()
        if _itemLocked then
            return
        end
        print("Purchase button pressed for item:", itemData.id)
        purchaseManager.PromptTokenPurchase(itemData.id)
    end)

    _scrollView:Add(_item)

    return _item
end

function self:Start()
    local playerInfo = gameManager.players[client.localPlayer]
    PopulateShop()
end

click_off:RegisterPressCallback(function()
    uiManager.CloseBuffsShop()
end)

function PopulateShop() 
    _scrollView:Clear()
    CreateItem({id = "spawnRateBuff_short", time = 3, title = "Spawn Rate 3m", description = "Increase the spirit spawn rate for 3 minutes!", price = 200})
end

function InitBuffsShop()

    header.style.scale = StyleScale.new(Scale.new(Vector2.new(0.2, 0.2)))
	_scrollView.style.scale = StyleScale.new(Scale.new(Vector2.new(0.2, 0.2)))

	Timer.After(0.2, function()
		TitlePopInTween:start() -- Start UI pop-in animation.
	end)
	Timer.After(0.2, function()
		StorePopInTween:start() -- Start UI pop-in animation.
	end)
    PopulateShop()

	InfoCardPopInTween:start() -- Start UI pop-in animation.
end