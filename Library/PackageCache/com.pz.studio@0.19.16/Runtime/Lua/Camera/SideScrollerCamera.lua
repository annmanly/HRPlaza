--!Type(Client)

--!Header("Zoom Settings")
--!SerializeField
local canZoom : boolean = true  -- Whether the camera can zoom
--!SerializeField
local zoom : number = 10.0
--!SerializeField
local zoomMin : number = 5.0
--!SerializeField
local zoomMax : number = 15.0

--!SerializeField
local camerFollowPlayer : boolean = true  -- Whether the camera should follow the player
--!SerializeField
local cameraFollowSpeed : number = 3.0  -- The speed at which the camera follows the player

--!SerializeField
local xOffset : number = 0.0  -- The offset in the x-axis
--!SerializeField
local yOffset : number = 5.0  -- The offset in the y-axis

--!SerializeField
local canPan : boolean = true  -- Whether the camera can be panned
--!SerializeField
local mobileZoomSensitivity : number = 1 -- The sensitivity of the zoom on mobile devices

-- boundaries
--!SerializeField
local boundary : boolean = false  -- Whether the camera should have boundaries
--!SerializeField
local minBoundaryX : number = -10.0 -- Minimum x boundary
--!SerializeField
local maxBoundaryX : number = 10.0 -- Maximum x boundary
--!SerializeField
local minBoundaryY : number = -10.0 -- Minimum y boundary
--!SerializeField
local maxBoundaryY : number = 10.0 -- Maximum y boundary

--!SerializeField
local deadzone : boolean = true  -- Whether the camera should have a deadzone
--!SerializeField
local deadzoneWidth : number = 3.0  -- Width of the deadzone
--!SerializeField
local deadzoneHeight : number = 3.0  -- Height of the deadzone

local camera = self.gameObject:GetComponent(Camera)
if camera == nil then
    print("SideScrollerCamera requires a Camera component on the GameObject its attached to.")
    return
end

local target = Vector3.zero                      -- the point the camera is looking at
local targetPosition = nil

local isPinching : boolean = false             -- whether the player is pinching the screen
local isPanning : boolean = false -- whether the player is panning the screen
local lastPanWorldPosition : Vector3 = Vector3.zero   -- the last world position of the pan gesture
local previousPinchDistance = 1 -- the previous distance value between two touches during a pinch gesture

local myChar = nil
local cameraOverridden = false                   -- whether the camera has been overridden by a pan

client.localPlayer.CharacterChanged:Connect(function(player, character)
    if character then
        myChar = character
    end
end)

function self:Start()
    -- Ensure the camera is orthographic
    camera.orthographic = true

    local startPos = self.transform.position
    target = startPos
    CenterOn(startPos)
end


function self:Update()
    if not self:IsActive() then
        return
    end

    if camerFollowPlayer then    
        UpdatePosition()
    end

    UpdateZoom()
end

function self:IsActive()
    return camera ~= nil and camera.isActiveAndEnabled and self.isActiveAndEnabled
end

function self:ResetCamera()
    previousPinchDistance = 1
    isPinching = false
    isPanning = false

    if myChar then
        -- Set the target position for the camera to smoothly move towards
        targetPosition = myChar.transform.position + Vector3.new(xOffset, yOffset, 0)
        -- Ensure the camera starts moving towards the target position
        cameraOverridden = false
    else
        print("SideScrollerCamera: No character found to follow.")
    end
end

client.Reset:Connect(function(evt)
    if not self:IsActive() then
        return
    end

    self:ResetCamera()
end)

Input.MouseWheel:Connect(function(evt)
    if not self:IsActive() or not canZoom then
        return
    end

    if evt.delta.y < 0.0 then
        ZoomIn()
        PostZoomMoveTowardsScreenPoint(evt.position)
    else
        ZoomOut()
        PostZoomMoveTowardsScreenPoint(evt.position)
    end

    cameraOverridden = true
end)

Input.PinchOrDragBegan:Connect(function(evt)
    if not self:IsActive() then
        return
    end

    isPinching = evt.isPinching
    previousPinchDistance = evt.distance
    isPanning = not evt.isPinching

    local screenPositionVector3 = Vector3.new(evt.position.x, evt.position.y, 0)
    lastPanWorldPosition = camera:ScreenToWorldPoint(screenPositionVector3)
end)

Input.PinchOrDragChanged:Connect(function(evt)
    if not self:IsActive() then
        return
    end

    if isPinching then
        if not canZoom then 
            return 
        end

        local scaleChange = (1 - evt.distance / previousPinchDistance) * mobileZoomSensitivity

        local newZoom = zoom + (zoom * scaleChange)
        zoom = Mathf.Clamp(newZoom, zoomMin, zoomMax)

        previousPinchDistance = evt.distance

        PostZoomMoveTowardsScreenPoint(evt.position)
    else
        PanCamera(evt)
    end

    cameraOverridden = true
end)

Input.PinchOrDragEnded:Connect(function(evt)
    if not self:IsActive() then
        return
    end

    isPinching = false
    isPanning = false
end)

function ClampPosition(position)
  if not boundary then return position end

  -- Get the player's position
  local playerPosition = myChar.transform.position

  -- Calculate boundaries relative to player
  local minX = playerPosition.x + minBoundaryX
  local maxX = playerPosition.x + maxBoundaryX
  local minY = playerPosition.y + minBoundaryY
  local maxY = playerPosition.y + maxBoundaryY

  position.x = Mathf.Clamp(position.x, minX, maxX)
  position.y = Mathf.Clamp(position.y, minY, maxY)
  return position
end

function UpdateZoom()
    camera.orthographicSize = zoom
end

function ZoomIn()
    zoom = Mathf.Clamp(zoom - 1, zoomMin, zoomMax)
end

function ZoomOut()
    zoom = Mathf.Clamp(zoom + 1, zoomMin, zoomMax)
end

function PostZoomMoveTowardsScreenPoint(screenPosition)
    local screenPositionVector3 = Vector3.new(screenPosition.x, screenPosition.y, 0)
    local worldPosition = camera:ScreenToWorldPoint(screenPositionVector3)

    UpdateZoom()

    PanWorldPositionToScreenPosition(worldPosition, screenPositionVector3)
end

function PanWorldPositionToScreenPosition(worldPosition, screenPosition)
    local adjustment = -(camera:ScreenToWorldPoint(screenPosition) - worldPosition)
    adjustment.z = 0

    local newTarget = ClampPosition(target + adjustment)

    CenterOn(newTarget)
end

function CenterOn(newTarget)
    target = newTarget
    camera.transform.position = Vector3.new(target.x, target.y, camera.transform.position.z)
end

function PanCamera(evt)
    if not canPan then 
        return 
    end

    local screenPositionVector3 = Vector3.new(evt.position.x, evt.position.y, 0)

    PanWorldPositionToScreenPosition(lastPanWorldPosition, screenPositionVector3)
    
    lastPanWorldPosition = camera:ScreenToWorldPoint(screenPositionVector3)
end

function IsOutsideDeadzone(playerPosition, cameraPosition)
    if not deadzone then 
        return true -- Deadzone is disabled
    end 

    local deadzoneHalfWidth = deadzoneWidth / 2
    local deadzoneHalfHeight = deadzoneHeight / 2

    local deltaX = math.abs(playerPosition.x - cameraPosition.x)
    local deltaY = math.abs(playerPosition.y - cameraPosition.y)

    return deltaX > deadzoneHalfWidth or deltaY > deadzoneHalfHeight
end

function UpdatePosition()
    if myChar then
        -- Initialize targetPosition at the start to ensure it's never nil
        local playerPosition = myChar.transform.position + Vector3.new(xOffset, yOffset, 0)
        targetPosition = targetPosition or playerPosition -- Initialize targetPosition if not already set

        if myChar.isMoving and not isPanning then 
            cameraOverridden = false
        else
            if cameraOverridden then
                return
            end
        end

        local originalCameraZ = camera.transform.position.z -- Store the original z value of the camera
    
        if IsOutsideDeadzone(playerPosition, camera.transform.position) then
            -- Update the target position to be the player position when outside deadzone
            targetPosition = playerPosition
            cameraOverridden = false
        end

        -- Calculate dynamic lerp factor based on distance to target
        local distance = (camera.transform.position - targetPosition).magnitude
        local dynamicLerpFactor = Mathf.Clamp(Time.deltaTime * cameraFollowSpeed * (distance / 10), 0.01, 1)
        local newPosition = Vector3.Lerp(camera.transform.position, targetPosition, dynamicLerpFactor)
        
        newPosition.z = originalCameraZ -- Set the z value of the newPosition to the original z value of the camera
        camera.transform.position = newPosition
        target = newPosition
    else
        print("SideScrollerCamera: No character found to follow.")
    end
end
