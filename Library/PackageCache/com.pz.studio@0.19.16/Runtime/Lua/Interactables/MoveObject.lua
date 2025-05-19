--!Type(Client)

---- Serialized Fields ----

--!SerializeField
--!Tooltip("The object to move. If left empty, the object this script is attached to will be moved.")
local _objectToMove: Transform = nil
--!SerializeField
--!Tooltip("The starting point of the move. If left empty, the object will start at its current position.")
local _travelPoints: { Transform } = nil
--!SerializeField
--!Tooltip("The duration of the move in seconds between each point.")
local _durationInSeconds: number = 3
--!SerializeField
local _faceMoveDirection: boolean = true
--!SerializeField
--!Tooltip("If true, the move will move back to the first point after reaching the last point.")
local _wrapBackToStart: boolean = true
--!SerializeField
--!Tooltip("If true, the move will start over at the first point once it reaches the end.")
local _loop: boolean = true
--!SerializeField
--!Tooltip("If true, the move will move backwards through the points after reaching the end point")
local _reverseAfterReachEnd: boolean = true
--!SerializeField
--!Tooltip("If true, the move will slow down when starting and arriving at each point.")
local _smoothMove: boolean = true

---- Internal Variables ----

local _internalObjectToMove: Transform = nil
local _internalTravelPoints: { Vector3 } = {}
local _internalDuration: number = 3
local _moveTween: Tween = nil
local _moveIndex: number = 1
local _reversing: boolean = false

---- Events ----

MoveCompletedEvent = Event.new("MoveCompletedEvent")

---- Functions ----

local function Move()
	local startIndex = _moveIndex
	if _reversing and _moveIndex == #_internalTravelPoints + 1 then
		startIndex = 1
	end
	local startPos = _internalTravelPoints[startIndex]
	local endIndex = _reversing and _moveIndex - 1 or (_moveIndex % #_internalTravelPoints) + 1
	local endPos = _internalTravelPoints[endIndex]
	--start a tween from start position to end position
	_moveTween = _internalObjectToMove:TweenPosition(startPos, endPos):Duration(_internalDuration):OnStop(function()
		_internalObjectToMove.position = endPos
		OnMoveCompleted()
	end)

	if _faceMoveDirection then
		-- Face the end position
		local direction = (endPos - startPos)
		direction.y = 0
		_internalObjectToMove.forward = direction.normalized
	end

	if _smoothMove then
		_moveTween = _moveTween:EaseInOutSine()
	end

	_moveTween:Play()
end

--Find the ending move point index for the move completion based on the current settings
local function GetEndIndexForMoveCompletion(): number
	if _reversing then
		return 1
	end
	return _wrapBackToStart and #_internalTravelPoints + 1 or #_internalTravelPoints
end

function OnMoveCompleted()
	if _moveTween then
		_moveTween:Stop(false)
	end

	_moveIndex = _reversing and _moveIndex - 1 or _moveIndex + 1
	local endIndex = GetEndIndexForMoveCompletion()
	local completedMove = false
	if _moveIndex == endIndex then
		MoveCompletedEvent:Fire()
		if _reverseAfterReachEnd then
			_reversing = not _reversing

			--if reversing, we need to check if we are at the start or end of the move points
			if _reversing then
				--if we are at the end of the move points, we need to start at the last point
				if _wrapBackToStart then
					_moveIndex = #_internalTravelPoints + 1
				else
					_moveIndex = #_internalTravelPoints
				end
			else
				_moveIndex = 1
			end
		elseif _wrapBackToStart then
			_moveIndex = 1
		end

		--if it is not set to loop and not reversing, we have completed the move
		completedMove = not _loop and not _reversing
	end
	if not completedMove then
		Move()
	end
end

function Pause()
	if _moveTween then
		_moveTween:Pause()
	end
end

function Resume()
	if _moveTween then
		_moveTween:Play()
	end
end

function Restart()
	if _moveTween then
		_moveTween:Stop(false)
	end
	_moveIndex = 1
	_reversing = false
	Move()
end

function ClearTravelPoints()
	table.clear(_internalTravelPoints)
end

function AddTravelPoint(travelPointPosition: Vector3)
	table.insert(_internalTravelPoints, travelPointPosition)
end

function SetDuration(duration: number)
	_internalDuration = duration
end

function self.ClientAwake()
	_internalObjectToMove = _objectToMove
	if _internalObjectToMove == nil then
		_internalObjectToMove = self.gameObject.transform
	end

	if _travelPoints ~= nil then
		for i = 1, #_travelPoints do
			AddTravelPoint(_travelPoints[i].position)
		end
	end

	SetDuration(_durationInSeconds)

	Move()
end
