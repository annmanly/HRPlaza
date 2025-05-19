--!Type(Client)

---- Serialized Fields ----

--!SerializeField
--!Tooltip("The object to move. If left empty, the object this script is attached to will be moved.")
local _objectToRotate: Transform = nil
--!SerializeField
local _xAxisRotationSpeed: number = 0
--!SerializeField
local _yAxisRotationSpeed: number = 60
--!SerializeField
local _zAxisRotationSpeed: number = 0
--!SerializeField
--!Tooltip("If negative, the object will rotate forever")
local _rotateDuration: number = -1

---- Internal Variables ----

local _internalObjectToRotate: Transform = nil
local _internalSpeedVector: Vector3 = Vector3.zero
local _initialRotation: Quaternion = Quaternion.identity
local _timer: number = 0
local _internalRotateDuration: number = 3
local _rotating: boolean = false

---- Events ----

RotateCompletedEvent = Event.new("RotateCompletedEvent")

---- Functions ----

local function Rotate()
	local rotation = _internalSpeedVector * Time.deltaTime
	_internalObjectToRotate:Rotate(rotation)
end

function Pause()
	_rotating = false
end

function Resume()
	_rotating = true
end

function Restart()
	_internalObjectToRotate.rotation = _initialRotation
	_timer = 0
	_rotating = true
end

function self.ClientUpdate()
	if not _rotating then
		return
	end
	_timer += Time.deltaTime
	if _timer >= _internalRotateDuration and _rotateDuration > 0 then
		_rotating = false
		RotateCompletedEvent:Fire()
	else
		Rotate()
	end
end

function SetDuration(duration: number)
	_internalRotateDuration = duration
end

function SetRotataionSpeed(speedVector: Vector3)
	_internalSpeedVector = speedVector
end

function self.ClientAwake()
	_internalObjectToRotate = _objectToRotate
	if _internalObjectToRotate == nil then
		_internalObjectToRotate = self.gameObject.transform
	end

	_initialRotation = _internalObjectToRotate.rotation

	SetDuration(_rotateDuration)
	SetRotataionSpeed(Vector3.new(_xAxisRotationSpeed, _yAxisRotationSpeed, _zAxisRotationSpeed))
	_rotating = true
end
