--!Type(UI)

--!Bind
local _mapBackground : UIImage = nil -- UIImage for displaying the map background, initialized to nil
--!Bind
local _closeButton : VisualElement = nil -- Close button for the map UI
--!Bind
local _marketButton : VisualElement = nil
--!Bind
local _shopButton : VisualElement = nil
--!Bind
local _welcomeButton : VisualElement = nil
--!Bind
local _townhallButton : VisualElement = nil
--!Bind
local _eventsButton : VisualElement = nil
--!Bind
local _parkButton : VisualElement = nil
--!Bind
local _artcenterButton : VisualElement = nil
--!Bind
local _buildercenterButton : VisualElement = nil
--!Bind
local _transitstationButton : VisualElement = nil

--!SerializeField
local MapImage  : Texture    = nil   -- map background image
--!SerializeField
local MarketPostion  : Transform    = nil   -- map background image
--!SerializeField
local ShopPosition  : Transform    = nil   -- map background image
--!SerializeField
local WelcomePosition  : Transform    = nil   -- map background image
--!SerializeField
local TownHallPosition  : Transform    = nil   -- map background image
--!SerializeField
local EventsPosition  : Transform    = nil   -- map background image
--!SerializeField
local ParkPosition  : Transform    = nil   -- map background image
--!SerializeField
local ArtCenterPosition  : Transform    = nil   -- map background image
--!SerializeField
local BuilderCenterPosition  : Transform    = nil   -- map background image
--!SerializeField
local TrasitStationPosition  : Transform    = nil   -- map background image



--!SerializeField
--local PointerImage  : Texture    = nil   -- player position pointer

local teleporterScript = self:GetComponent(TeleporterScript)

-- Function to update the map icon image
function PopulateMapBackground(icon: Texture)
  _mapBackground.image = icon -- Set the image of the map icon to the provided texture
end

PopulateMapBackground(MapImage)

-- Register a callback to close the map UI
_closeButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
end)

_marketButton:RegisterPressCallback(function()
    self.gameObject:SetActive(false)
    teleporterScript.Teleport(MarketPostion.position)
end)

_shopButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ShopPosition.position)
end)

_welcomeButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(WelcomePosition.position)
end)

_townhallButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(TownHallPosition.position)
end)

_eventsButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(EventsPosition.position)
end)

_parkButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ParkPosition.position)
end)

_artcenterButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ArtCenterPosition.position)
end)

_buildercenterButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(BuilderCenterPosition.position)
end)

_transitstationButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(TrasitStationPosition.position)
end)








