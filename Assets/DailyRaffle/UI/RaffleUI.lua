--!Type(UI)

--!Bind
local _closeOverlay:VisualElement = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _contentWindow:VisualElement = nil


--!Bind
local _codesButton:VisualElement = nil
--!Bind
local _infoButton:VisualElement = nil

--!Bind
local _countDown:Label = nil
--!Bind
local _playerTicketCount:Label = nil


local raffleUIManager = require("RaffleUIManager")

function setTicketCount(number)
    _playerTicketCount.text = number
end

function updateTimer(number)
    -- TO DO: add countdown
end

function close()
    self.gameObject:SetActive(false)
end

function OnInfoPress()
    raffleUIManager.openInfo()
    close()
end


function OnCodesPress()
    raffleUIManager.openCodes()
    close()
end

function self:Awake()
    _closeOverlay:RegisterPressCallback(close)
    _closeButton:RegisterPressCallback(close)
    _infoButton:RegisterPressCallback(OnInfoPress)
    _codesButton:RegisterPressCallback(OnCodesPress)
end
