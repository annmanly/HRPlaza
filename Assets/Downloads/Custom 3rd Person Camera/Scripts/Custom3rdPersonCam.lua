--!Type(Client)

-- Serialized Fields with renamed identifiers
--!Tooltip("The height of the point over the player the camera will pivot around")
--!SerializeField
local _cameraHeight : number = 2.5
--!Tooltip("Initial distance from pivot")
--!SerializeField
local _startZoom : number = 7.5

--!Tooltip("Minimum allowable zoom")
--!SerializeField
local _minimumZoom : number = 3
--!Tooltip("Maximum allowable zoom")
--!SerializeField
local _maximumZoom : number = 25

--!SerializeField
local _offset : Vector3 = Vector3.new(0, 0, 0) -- Center the camera without lateral shift

-- Rotation limits
--!Tooltip("Whether the camera can rotate around the X axis (Up and Down)")
--!SerializeField
local _pitchEnabled : boolean = true -- Enable pitch limits
--!Tooltip("The initial X rotation of the camera")
--!SerializeField
local _pitchStart : number = 5 -- Initial pitch angle

--!Tooltip("The minimum X rotation the camera can have (Upwards)")
--!SerializeField
local _pitchMin : number = -2 -- Minimum pitch angle

--!Tooltip("The maximum X rotation the camera can have (Downwards)")
--!SerializeField
local _pitchMax : number = 30 -- Maximum pitch angle

--!Tooltip("Whether the camera can rotate around the Y axis (Left and Right)")
--!SerializeField
local _yawEnabled : boolean = false -- Enable yaw limits
--!Tooltip("The minimum Y rotation the camera can have (Left)")
--!SerializeField
local _yawMin : number = -360 -- Minimum yaw angle for full rotation
--!Tooltip("The maximum Y rotation the camera can have (Right)")
--!SerializeField
local _yawMax : number = 360 -- Maximum yaw angle for full rotation

--!Tooltip("Camera rotation sensitivity (1 = slow, 10 = fast)")
--!Range(1, 10)
--!SerializeField
local _rotationSensitivity : number = 2 -- Default to medium sensitivity

--!Tooltip("Whether the camera should avoid clipping through obstacles")
--!SerializeField
local _enableCollisionAvoidance : boolean = true

--!Tooltip("Offset applied to avoid clipping through obstacles")
--!SerializeField
local _collisionOffset : number = 0.2
--!Tooltip("Maximum distance from obstacles")
--!SerializeField
local _obstacleDistanceMinFar : number = 3
--!SerializeField
local _obstacleDistanceMinNear : number = 0
--!Tooltip("Maximum distance for raycasting")
--!SerializeField
local _rayDistanceMaxFar : number = 10
--!Tooltip("Minimum distance for raycasting")
--!SerializeField
local _rayDistanceMinNear : number = 0.1

--!Tooltip("Enable first-person view when zoomed in enough")
--!SerializeField
local _enableFirstPerson : boolean = true

--!Tooltip("Field of View in third-person mode (degrees)")
--!Range(30, 90)
--!SerializeField
local _thirdPersonFOV : number = 60

--!Tooltip("Field of View in first-person mode (degrees)")
--!Range(60, 120)
--!SerializeField
local _firstPersonFOV : number = 60

--!Tooltip("Enable transition between first and third person")
--!SerializeField
local _enableSmoothTransition : boolean = true

--!Tooltip("How quickly the FOV transitions between first and third person (higher = faster)")
--!Range(1, 10)
--!SerializeField
local _FOVTransitionSpeed : number = 3

local camera = self.gameObject:GetComponent(Camera)
assert(camera, "ThirdPersonCamera.lua requires a Camera component on the same GameObject")

local zoom = _startZoom
local yaw = 0
local pitch = 0
local currentRotationVelocity = Vector2.zero
local lastDirection = Vector2.zero
local isPinching = false
local previousPinchDistance = 1

-- Internal constants for smooth camera behavior
local ROTATION_SMOOTHNESS = 1.0  -- Fixed smoothing factor for consistent feel
local ZOOM_SENSITIVITY = 10     -- Fixed zoom sensitivity
local SENSITIVITY_SCALE = 0.1    -- Scale factor to convert 1-10 range to actual sensitivity

-- Internal variables
local currentFOV = _thirdPersonFOV

function IsActive()
  return camera ~= nil and camera.isActiveAndEnabled and self.isActiveAndEnabled
end

local function UpdatePosition()
  local playerPosition = client.localPlayer.character.gameObject.transform.position
  local pivot = playerPosition + _cameraHeight * Vector3.up
  local rotation = Quaternion.Euler(pitch, yaw, 0)
  
  -- Calculate base camera position
  local basePosition = pivot + (rotation * (Vector3.back * zoom))
  
  -- Apply offset components individually to respect zero values
  local finalOffset = Vector3.new(
    _offset.x ~= 0 and (rotation * Vector3.right).x * _offset.x or 0,
    _offset.y ~= 0 and (rotation * Vector3.up).y * _offset.y or 0,
    _offset.z ~= 0 and (rotation * Vector3.forward).z * _offset.z or 0
  )
  
  local desiredPosition = basePosition + finalOffset

  -- Only perform collision checks if enabled
  if _enableCollisionAvoidance then
    local rayOrigin = pivot
    local rayDirection = (desiredPosition - pivot).normalized
    local layerMask = LayerMask.GetMask({"Default"})

    local hit, hitInfo = Physics.Raycast(rayOrigin, rayDirection, zoom + _obstacleDistanceMinFar, layerMask)
    local minObstacleDistance = _obstacleDistanceMinNear
    if hit then
        local hitDistance = (hitInfo.point - rayOrigin).magnitude
        local t = math.clamp((hitDistance - _rayDistanceMinNear) / (_rayDistanceMaxFar - _rayDistanceMinNear), 0, 1)
        minObstacleDistance = Mathf.Lerp(_obstacleDistanceMinNear, _obstacleDistanceMinFar, t)
        if hitDistance < zoom + minObstacleDistance then
            camera.transform.position = rayOrigin + rayDirection * (hitDistance - minObstacleDistance - _collisionOffset)
            return
        end
    end
  end
  
  camera.transform.position = desiredPosition

  -- Update camera FOV based on first/third person mode
  local targetFOV = zoom <= _minimumZoom and _firstPersonFOV or _thirdPersonFOV
  if _enableSmoothTransition then
    if zoom <= _minimumZoom then
      -- Smooth transition into first person
      currentFOV = Mathf.Lerp(currentFOV, targetFOV, Time.deltaTime * _FOVTransitionSpeed)
    else
      -- Instant transition back to third person
      currentFOV = targetFOV
    end
  else
    -- No transition, instant FOV change
    currentFOV = targetFOV
  end
  
  camera.fieldOfView = currentFOV

  if zoom <= _minimumZoom then
      if _enableFirstPerson then
          local headPosition = playerPosition + Vector3.up * _cameraHeight
          camera.transform.position = headPosition
          camera.transform.rotation = Quaternion.Euler(pitch, yaw, 0)
      else
          camera.transform.rotation = rotation
      end
  else
      camera.transform.rotation = rotation
  end
end

function self:Start()
  ResetCamera()
end

function ResetCamera()
    zoom = _startZoom
    yaw = 0
    pitch = _pitchStart
    currentRotationVelocity = Vector2.zero
    isPinching = false
    previousPinchDistance = 1
    lastDirection = Vector2.zero
    currentFOV = _thirdPersonFOV  -- Reset FOV to third-person value
    if client.localPlayer.character then
        local characterTransform = client.localPlayer.character.gameObject.transform
        yaw = camera.transform.eulerAngles.y
        UpdatePosition()
    end
end

local function Rotate(rotate)
    -- Convert the 1-10 range to appropriate decimal values
    rotate = rotate * (_rotationSensitivity * SENSITIVITY_SCALE)
    currentRotationVelocity = Vector2.Lerp(currentRotationVelocity, rotate, ROTATION_SMOOTHNESS)
    pitch = _pitchEnabled and math.clamp(pitch + currentRotationVelocity.y, _pitchMin, _pitchMax) or pitch + currentRotationVelocity.y
    yaw = _yawEnabled and math.clamp(yaw + currentRotationVelocity.x, _yawMin, _yawMax) or yaw + currentRotationVelocity.x
end

function SetYaw(newYaw : number)
	yaw = newYaw
	UpdatePosition()
end

Input.MouseWheel:Connect(function(evt)
    if not IsActive() then return end
    local zoomChange = (evt.delta.y < 0 and -1 or 1) * ZOOM_SENSITIVITY
    zoom = Mathf.Clamp(zoom + zoomChange, _minimumZoom, _maximumZoom)
end)

Input.PinchOrDragBegan:Connect(function(event)
    if not IsActive() then return end
    isPinching = event.isPinching
    previousPinchDistance = event.distance
    lastDirection = Vector2.zero
end)

Input.PinchOrDragChanged:Connect(function(event)
    if not IsActive() then return end
    if isPinching then
        local zoomDelta = (1 - event.distance / previousPinchDistance) * ZOOM_SENSITIVITY
        zoom = Mathf.Clamp(zoom + zoomDelta, _minimumZoom, _maximumZoom)
        previousPinchDistance = event.distance
    else
        local delta = event.deltaPosition
        Rotate(Vector2.new(delta.x, -delta.y))
    end
end)

Input.PinchOrDragEnded:Connect(function(event)
    if not IsActive() then return end
    isPinching = false
    previousPinchDistance = 1
    lastDirection = Vector2.zero
end)

function self:Update()
    if not IsActive() then return end
    UpdatePosition()
end
