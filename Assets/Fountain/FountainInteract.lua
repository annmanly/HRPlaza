--!Type(UI)

--!Bind
local _wishButton:VisualElement = nil
-- --!Bind
-- local _readButton:VisualElement = nil

fountainManager = require("Fountain")

function self:ClientAwake()
    _wishButton:RegisterPressCallback(function() fountainManager.OpenWriteWishWindow:Fire() end)
    
end


-- _readButton:RegisterPressCallback(function() print("READ BUTTON PRESSED") end)