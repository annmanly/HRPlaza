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
--!Bind
local _hrliveButton : VisualElement = nil


--!SerializeField
local MapImage  : Texture    = nil   -- map background image
--!SerializeField
local MarketPostion  : Transform    = nil   -- map background image
--!SerializeField
local MarketLookAtPosition  : Transform    = nil   -- map background image

--!SerializeField
local ShopPosition  : Transform    = nil   -- map background image
--!SerializeField
local ShopLookAtPosition  : Transform    = nil   -- map background image

--!SerializeField
local WelcomePosition  : Transform    = nil   -- map background image
--!SerializeField
local WelcomeLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local TownHallPosition  : Transform    = nil   -- map background image
--!SerializeField
local TownHallLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local EventsPosition  : Transform    = nil   -- map background image
--!SerializeField
local EventsLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local ParkPosition  : Transform    = nil   -- map background image
--!SerializeField
local ParkLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local ArtCenterPosition  : Transform    = nil   -- map background image
--!SerializeField
local ArtCenterLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local BuilderCenterPosition  : Transform    = nil   -- map background image
--!SerializeField
local BuilderCenterLookAtPosition  : Transform    = nil   -- map background imag

--!SerializeField
local TrasitStationPosition  : Transform    = nil   -- map background image
--!SerializeField
local TransitLookAtPosition  : Transform    = nil   -- map background image

--!SerializeField
local HRLivePosition  : Transform    = nil   -- map background image



--!SerializeField
--local PointerImage  : Texture    = nil   -- player position pointer

local teleporterScript = nil 

function self:ClientStart()
  teleporterScript = self:GetComponent(RTSTeleportScript)
end

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
    teleporterScript.Teleport(MarketPostion.position, MarketLookAtPosition.position)
end)

_shopButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ShopPosition.position, ShopLookAtPosition.position)
end)

_welcomeButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(WelcomePosition.position, WelcomeLookAtPosition.position)
end)

_townhallButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(TownHallPosition.position, TownHallLookAtPosition.position)
end)

_eventsButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(EventsPosition.position, EventsLookAtPosition.position)
end)

_parkButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ParkPosition.position, ParkLookAtPosition.position)
end)

_artcenterButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(ArtCenterPosition.position, ArtCenterLookAtPosition.position)
end)

_buildercenterButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(BuilderCenterPosition.position, BuilderCenterLookAtPosition.position)
end)

_transitstationButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(TrasitStationPosition.position, TransitLookAtPosition.position)
end)

_hrliveButton:RegisterPressCallback(function()
  self.gameObject:SetActive(false)
  teleporterScript.Teleport(HRLivePosition.position, TransitLookAtPosition.position)
end)






