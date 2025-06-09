--!Type(UI)

local PipOff = "pip-off"
local PipOn = "pip-selected"

local GM: GameManager = require("GameManager")
local UIManager = require("EventUIModule")

--!Bind
local welcome_popup: UILuaView = nil
--!Bind
local _closeOverlay: VisualElement = nil
--!Bind
local _nextButtonLabel: UILabel = nil
--!Bind
local _backButton: Button = nil
--!Bind
local _backButtonLabel: UILabel = nil
--!Bind
local _content: VisualElement = nil
--!Bind
local _nextButton: VisualElement = nil
--!Bind
local _image1: VisualElement = nil
--!Bind
local _image2: VisualElement = nil
--!Bind
local _image3: VisualElement = nil
--!Bind
local _image4: VisualElement = nil
--!Bind
local _desc1: UILabel = nil
--!Bind
local _desc2: UILabel = nil
--!Bind
local _desc3: UILabel = nil
--!Bind
local _desc4: UILabel = nil
--!Bind
local _pip1: VisualElement = nil
--!Bind
local _pip2: VisualElement = nil
--!Bind
local _pip3: VisualElement = nil
--!Bind
local _pip4: VisualElement = nil

local _states = 4
local _currentState = 1
local _closeCallback: () -> () = nil

-- Import Tweening module for animations.
local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween -- Tween class for creating animations.
local Easing = TweenModule.Easing -- Easing functions for animations.

-- Tween the Root UI element scaling in.
local InfoCardPopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.35, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		welcome_popup.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
		--Slide up
		local yPos = (1 - value) * 500
		welcome_popup.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(yPos)))
	end,
	function() -- Completion callback (unused here).
		welcome_popup.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

function GetRoot(): VisualElement
	return _content
end

function ShowState(state: number)
	if state == 1 then
		InfoCardPopInTween:start()
	end

	_currentState = state
	_image1:SetDisplay(_currentState == 1)
	_image2:SetDisplay(_currentState == 2)
	_image3:SetDisplay(_currentState == 3)
	_image4:SetDisplay(_currentState == 4)

	_desc1:SetDisplay(_currentState == 1)
	_desc2:SetDisplay(_currentState == 2)
	_desc3:SetDisplay(_currentState == 3)
	_desc4:SetDisplay(_currentState == 4)

	_pip1:AddToClassList(_currentState == 1 and PipOn or PipOff)
	_pip2:AddToClassList(_currentState == 2 and PipOn or PipOff)
	_pip3:AddToClassList(_currentState == 3 and PipOn or PipOff)
	_pip4:AddToClassList(_currentState == 4 and PipOn or PipOff)

	_pip1:RemoveFromClassList(_currentState ~= 1 and PipOn or PipOff)
	_pip2:RemoveFromClassList(_currentState ~= 2 and PipOn or PipOff)
	_pip3:RemoveFromClassList(_currentState ~= 3 and PipOn or PipOff)
	_pip4:RemoveFromClassList(_currentState ~= 4 and PipOn or PipOff)
	
	if state >= 4 then
		_nextButtonLabel:SetPrelocalizedText("Got It!")
	else
		_nextButtonLabel:SetPrelocalizedText("Next")
	end

	_backButton:SetDisplay(_currentState > 1)
end

local function OnCloseButton()
	UIManager.DisableUIs( {"WelcomeUIObj"} )
	UIManager.ShowMainUI()
end

local function OnNext()
	if _currentState == _states then
		OnCloseButton()
	else
		ShowState(_currentState + 1)
	end
end

function Init(closeCallback: () -> ())
	_closeCallback = closeCallback
end

function self.ClientAwake()
	_nextButton:RegisterPressCallback(OnNext)
	_backButton:RegisterPressCallback(function()
		ShowState(_currentState - 1)
	end)

	ShowState(1)

	UIManager.DisableUIs({ "eventHudObj", "energyWidget"})

	_backButtonLabel:SetPrelocalizedText("Back")
	_desc1:SetPrelocalizedText("Tap balloons as they float by to earn tickets! Blue gives 10, red gives 20, and gold gives 50. Every pop helps fill the Clown Meter at the top.")
	_desc2:SetPrelocalizedText("Activate Buffs to power up! Buffs increase Spawnrate, Luck, and Speed — helping you get more balloons and tickets faster. Buffs keep running even when you leave!")
	_desc3:SetPrelocalizedText("When the Clown Meter fills, Bongo the Clown appears! Join forces with other players to tap him down. The more players there are, the tougher he gets — but the rewards are worth it!")
	_desc4:SetPrelocalizedText("Every ticket you earn brings you closer to exciting rewards. Keep collecting to unlock more prizes!")

end