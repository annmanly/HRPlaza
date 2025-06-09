--!Type(UI)

--!Bind
local popup_root: VisualElement = nil

local isFirstDisplay = true

local uiModule = require("EventUIModule")

popup_root:RegisterPressCallback(function()
    uiModule.DisableUIs({"tutorialPopup"})
    uiModule.ShowMainUI()
end)

function self:ClientStart()
    uiModule.DisableAllUI()
    uiModule.EnableUIs({"tutorialPopup"})
end
