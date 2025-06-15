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
    _descriptionText:SetPrelocalizedText("<b>Tap on birds</b> to enter in the daily raffle and win prizes!\n\nEach ticket counts as one entry, and 100 winners are selected each day!")
    _mainImage:RemoveFromClassList("info-image-2")
    _mainImage:AddToClassList("info-image-1")
    
    _pip1:AddToClassList("pip-selected")
    _pip2:RemoveFromClassList("pip-selected")

end

function SetPage2()
    _smallHeadingText:SetPrelocalizedText("AXL'S RAFFLE")
    _headingText:SetPrelocalizedText("PRIZE")
    _descriptionText:SetPrelocalizedText("Winners will receive a \n<b>Town Square Raffle Blind Box!</b>\n\nIf you are currently in the world at the time of the draw, you'll recieve your box immediately when you win. Otherwise, we'll hold on to it until you return to the world and collect your prize!")
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
