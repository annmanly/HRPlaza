--!Type(UI)

--!Bind
local _closeOverlay:VisualElement = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _contentWindow:VisualElement = nil

--!Bind
local _mainImage:VisualElement = nil

local page = 1

function close()
    self.gameObject:SetActive(false)
end

function OnImagePress()
    if page == 1 then
        _mainImage:RemoveFromClassList("info-image-1")
        _mainImage:AddToClassList("info-image-2")
        page = 2
    else 
        _mainImage:RemoveFromClassList("info-image-2")
        _mainImage:AddToClassList("info-image-1")
        page = 1
        close()

    end
end


function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _closeButton:RegisterPressCallback(close)
    _mainImage:RegisterPressCallback(OnImagePress, nil, true, true)
end
