--!Type(UI)

--!SerializeField
local MapImage : Texture = nil -- Texture for the map icon, initialized to nil

--!SerializeField
local MapMenuUI : GameObject = nil -- Texture for the map icon, initialized to nil

--!Bind
local _MapIcon : UIImage = nil -- UIImage for displaying the map icon, initialized to nil

--!Bind
local _openButton : VisualElement = nil 

--!Bind
local _raffleButton:VisualElement = nil

local raffleUIManager = require("RaffleUIManager")

_raffleButton:RegisterPressCallback(function() 
    raffleUIManager.openMainUI()
end)

-- Function to update the map icon image
function PopulateIcon(icon: Texture)
  _MapIcon.image = icon -- Set the image of the map icon to the provided texture
end

PopulateIcon(MapImage) -- Initialize the map icon with the provided MapImage texture

_openButton:RegisterPressCallback(function()
  if not MapMenuUI.activeSelf then
    MapMenuUI:SetActive(true)
  else
    MapMenuUI:SetActive(false)
  end
end)