--!Type(UI)

--!Bind
local _raffleButton:VisualElement = nil

local raffleUIManager = require("RaffleUIManager")

_raffleButton:RegisterPressCallback(function() 
    raffleUIManager.openMainUI()
end)