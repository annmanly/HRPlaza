--!Type(UI)

--!Bind
local _closeOverlay:VisualElement = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _contentWindow:VisualElement = nil


function close()
    self.gameObject:SetActive(false)
end

function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _closeButton:RegisterPressCallback(close)

end
