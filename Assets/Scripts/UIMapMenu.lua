--!Type(UI)

--!Bind
local _MapContent : UIScrollView = nil -- Important do not remove
--!Bind
local _itemInfo : VisualElement = nil -- Important do not remove
--!Bind
local _ItemInfoContent : VisualElement = nil -- Important do not remove


--!Bind
local _closeButton : VisualElement = nil -- Close button for the map UI
--!Bind
local _closeInfoButton : VisualElement = nil -- Close button for the item info UI

--!SerializeField
local MapImage  : Texture    = nil   -- map background image

-- Register a callback to close the map UI
_closeButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
end, true, true, true)

-- Function to create an item in the map
function CreateItem(amount: number, image: Texture)
  local item = VisualElement.new()
  item:AddToClassList("map__item")

  local _itemIcon = VisualElement.new()
  _itemIcon:AddToClassList("map__item-icon")

  local _itemImage = UIImage.new(true)
  _itemImage:AddToClassList("map__item__icon__image")
  _itemImage.image = image
  _itemIcon:Add(_itemImage)

  local _itemAmount = VisualElement.new()
  _itemAmount:AddToClassList("map__item-amount")

  local _itemAmountText = UILabel.new()
  _itemAmountText:SetPrelocalizedText(tostring(amount))
  _itemAmount:Add(_itemAmountText)

  item:Add(_itemIcon)
  item:Add(_itemAmount)

  _MapContent:Add(item)

  return item
end

function CreateItemInfoPage(name: string, amount: number, description: string, image: Texture)  
  _itemInfo:RemoveFromClassList("hidden")
  _ItemInfoContent:Clear()

  local _ItemInfoIcon = VisualElement.new()
  _ItemInfoIcon:AddToClassList("map__item__info-icon")

  local _ItemInfoImage = UIImage.new(true)
  _ItemInfoImage:AddToClassList("map__item__info__icon__image")
  _ItemInfoImage.image = image


  local _ItemInfoAmount = VisualElement.new()
  _ItemInfoAmount:AddToClassList("map__item__info-amount")

  local _ItemInfoAmountText = UILabel.new()
  _ItemInfoAmountText:AddToClassList("map__item__info__amount-label")
  _ItemInfoAmountText:SetPrelocalizedText(tostring(amount))
  _ItemInfoAmount:Add(_ItemInfoAmountText)

  _ItemInfoIcon:Add(_ItemInfoImage)
  _ItemInfoIcon:Add(_ItemInfoAmount)


  local _ItemInfoName = VisualElement.new()
  _ItemInfoName:AddToClassList("map__item__info-name")

  local _ItemInfoNameText = UILabel.new()
  _ItemInfoNameText:AddToClassList("map__item__info__name-label")
  _ItemInfoNameText:SetPrelocalizedText(name)
  _ItemInfoName:Add(_ItemInfoNameText)

  local _ItemInfoDescription = VisualElement.new()
  _ItemInfoDescription:AddToClassList("map__item__info-description")

  local _ItemInfoDescriptionText = UILabel.new()
  _ItemInfoDescriptionText:AddToClassList("map__item__info__description-label")
  _ItemInfoDescriptionText:SetPrelocalizedText(description)
  _ItemInfoDescription:Add(_ItemInfoDescriptionText)

  _ItemInfoContent:Add(_ItemInfoIcon)
  _ItemInfoContent:Add(_ItemInfoName)
  _ItemInfoContent:Add(_ItemInfoDescription)
end

-- Register a callback to close the item info UI
_closeInfoButton:RegisterPressCallback(function()
  _itemInfo:AddToClassList("hidden")
end, true, true, true)


-- 
function CreateMapData()
  -- Clear out any existing items
  _MapContent:Clear()

    -- Create an item with the live coin amount.
    local item = CreateItem(0, mapImage)
    
    -- Set up a callback to show more info when the item is pressed.
    item:RegisterPressCallback(function()
      CreateItemInfoPage("Description")
    end, true, true, true)
end


CreateMapData()


