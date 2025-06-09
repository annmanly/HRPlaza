--!Type(UI)

--!SerializeField
local Icons: {Texture} = nil

--!Bind
local hud_buttons_ui: UILuaView = nil
--!Bind
local root_left: VisualElement = nil
--!Bind
local root_right: VisualElement = nil

local _rankbutton = nil
local _rankLabel = nil

local _xpbutton = nil
local _xpLabel = nil

local utils = require("Utils")
local eventUIModule = require("EventUIModule")
local gameManager = require("GameManager")

function CreateHUDButton(IconId: number, title: string, positionClass: string, cb: () -> (), appendGoldIcon)
    local _ContainerOutline = VisualElement.new()
    _ContainerOutline:AddToClassList("hud-button-outline")
    _ContainerOutline:AddToClassList(positionClass)

    local _Container = VisualElement.new()
    _Container:AddToClassList("hud-button")

    local _Icon = Image.new()
    _Icon:AddToClassList("hud-button-icon")

    _Icon.image = Icons[IconId]

    local _LabelContainer = VisualElement.new()
    _LabelContainer:AddToClassList("hud-button-label-container")

    local _Label = Label.new()
    _Label:AddToClassList("hud-button-label")
    _Label.text = title

    local goldIcon = VisualElement.new()
    goldIcon:AddToClassList("hud-button-gold-icon")


    _Container:Add(_Icon)
    _Container:Add(_LabelContainer)

    if appendGoldIcon then
        _LabelContainer:Add(goldIcon)
    end
    _LabelContainer:Add(_Label)

    _ContainerOutline:Add(_Container)

    if positionClass == "left" then
        root_left:Add(_ContainerOutline)
    else
        root_right:Add(_ContainerOutline)
    end

    _ContainerOutline:RegisterPressCallback(cb)

    _Icon.name = title

    return _ContainerOutline, _Label
end

function self:Start()
    _rankbutton, _rankLabel = CreateHUDButton(1,"Rank","right", eventUIModule.OpenLeaderboard)
    _xpLabel, _xpLabel = CreateHUDButton(2,"Rewards","right", eventUIModule.OpenProgressRewards)
    CreateHUDButton(7,"Buffs","left", eventUIModule.OpenBuffsShop)
    CreateHUDButton(4,"$250","left", gameManager.BuyItem)
    CreateHUDButton(8,"500","left",  gameManager.BuyItem, true)
    CreateHUDButton(6,"Info","right", eventUIModule.ShowTutorialPopup)


    self.gameObject:SetActive(false)

    eventUIModule.updateTicketsEvent:Connect(UpdateTicketsLabel)
end

function UpdateTicketsLabel(amount)
    if _rankLabel then
        _rankLabel.text = utils.formatNumber(amount)
    end
end

function UpdateXPLabel(amount)
    if _xpLabel then
        _xpLabel.text = utils.formatNumber(amount)
    end
end