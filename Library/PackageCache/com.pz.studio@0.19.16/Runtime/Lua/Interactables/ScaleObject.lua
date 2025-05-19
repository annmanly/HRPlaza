--!Type(Client)

---- Serialized Fields ----

--!SerializeField
--!Tooltip("The object to scale. If left empty, the object this script is attached to will be scaled.")
local _objectToScale: Transform = nil
--!SerializeField
local _startScale: Vector3 = Vector3.one
--!SerializeField
local _endScale: Vector3 = Vector3.one
--!SerializeField
--!Tooltip("The duration of the scale in seconds to reach the destination.")
local _durationInSeconds: number = 3
--!SerializeField
--!Tooltip("If true, the scale will loop back to the start after reaching the destination and then repeat forever.")
local _loop: boolean = true
--!SerializeField
--!Tooltip("If true, the scale will be smooth when starting and arriving at the destination.")
local _smoothScale: boolean = true

---- Internal Variables ----

local _internalObjectToScale: Transform = nil
local _internalStartScale: Vector3 = Vector3.zero
local _internalEndScale: Vector3 = Vector3.one
local _internalDuration: number = 3
local _scaleTween: Tween = nil

---- Events ----

ScaleCompletedEvent = Event.new("ScaleCompletedEvent")

---- Functions ----

local function Scale()
	_scaleTween = _internalObjectToScale
		:TweenLocalScale(_internalStartScale, _internalEndScale)
		:Duration(_internalDuration)
		:OnStop(function()
			_internalObjectToScale.localScale = _internalEndScale
			ScaleCompletedEvent:Fire()
		end)

	if _loop then
		_scaleTween = _scaleTween:PingPong():Loop()
	end

	if _smoothScale then
		_scaleTween = _scaleTween:EaseInOutSine()
	end

	_scaleTween:Play()
end

function Pause()
	if _scaleTween then
		_scaleTween:Pause()
	end
end

function Resume()
	if _scaleTween then
		_scaleTween:Play()
	end
end

function Restart()
	if _scaleTween then
		_scaleTween:Stop(false)
	end
	Scale()
end

function SetEndScale(endScale: Vector3)
	_internalEndScale = endScale
end

function SetStartScale(startScale: Vector3)
	_internalStartScale = startScale
end

function SetDuration(duration: number)
	_internalDuration = duration
end

function self.ClientAwake()
	_internalObjectToScale = _objectToScale
	if _internalObjectToScale == nil then
		_internalObjectToScale = self.gameObject.transform
	end

	SetStartScale(_startScale)
	SetEndScale(_endScale)
	SetDuration(_durationInSeconds)

	Scale()
end
