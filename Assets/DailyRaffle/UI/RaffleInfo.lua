--!Type(UI)

--!Bind
local _closeOverlay:VisualElement = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _contentWindow:VisualElement = nil

--!Bind
local _smallHeadingText:UILabel = nil
--!Bind
local _headingText:UILabel = nil
--!Bind
local _descriptionText:UILabel = nil
--!Bind
local _mainImage:VisualElement = nil

--!Bind
local _pipsContainer:VisualElement = nil
--!Bind
local _pip1:VisualElement = nil
--!Bind
local _pip2:VisualElement = nil


local page = 1



function close()
    self.gameObject:SetActive(false)
end

function OnImagePress()
    if page == 1 then
        SetPage2()
        page = 2
    else 
        SetPage1()
        page = 1
        close()
    end
end


function SetPage1()
    _smallHeadingText:SetPrelocalizedText("AXL'S RAFFLE")
    _headingText:SetPrelocalizedText("HOW TO ENTER")
    _descriptionText:SetPrelocalizedText("<b>Tap on birds</b> to enter in the daily raffle and win prizes!\n\nEach ticket counts as one entry, and multiple winners are selected each day!")
    _mainImage:RemoveFromClassList("info-image-2")
    _mainImage:AddToClassList("info-image-1")
    
    _pip1:AddToClassList("pip-selected")
    _pip2:RemoveFromClassList("pip-selected")

end

function SetPage2()
    _smallHeadingText:SetPrelocalizedText("AXL'S RAFFLE")
    _headingText:SetPrelocalizedText("Redeeming Prizes")
    _descriptionText:SetPrelocalizedText("Winners will receive {currency} which they can exchange for their favorite prizes from the collection!\n\n<b>Players must be in the world to receive {currency}, so check back in to see if you won!</b>")
    _mainImage:RemoveFromClassList("info-image-1")
    _mainImage:AddToClassList("info-image-2")

    _pip1:RemoveFromClassList("pip-selected")
    _pip2:AddToClassList("pip-selected")
end


function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _closeButton:RegisterPressCallback(close)
    _contentWindow:RegisterPressCallback(OnImagePress)
    SetPage1()
end
