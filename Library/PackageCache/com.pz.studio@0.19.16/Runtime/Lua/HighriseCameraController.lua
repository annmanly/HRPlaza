--!Type(Client)

--!Header("Movement Restrictions")
--!SerializeField
local canPan : boolean = true
--!SerializeField
local canRotate : boolean = true
--!SerializeField
local canZoom : boolean = true
--!SerializeField
local touchRotationDampener : number = 0.4

---!Tooltip("The camera decides on its initail position and rotation based on the target it finds by raycasting out from the camera's position. This is the layer mask used for that raycast in case you need to avoid some collision layers.")
---!SerializeField
---local pivotRaycastLayer : number = -1
--!Tooltip("The pivot point that the target will be rotating around and the input plane will spawn at.")
--!SerializeField
local pivot : Vector3 = Vector3.zero

--!Header("Zoom Settings")
--!SerializeField
local zoomMin : number = 10
--!SerializeField
local zoomMax : number = 50

--!Header("Rotation Settings")
--!SerializeField
local yawOffsetMax : number = 10
--!SerializeField
local yawOffsetMin : number = -10

local camera = self.gameObject:GetComponent(Camera)
if camera == nil then
    print("HighriseCameraController requires a Camera component on the GameObject its attached to.")
    return
end

local target : Vector3 = Vector3.zero             -- think of this as the "center" of the camera's focus that is being moved around the input Plane
local newTarget : Vector3 = Vector3.zero          -- the target that the camera will move to this frame
local zoom : number = 0                           -- the current zoom level of the camera using frustum height as the measurement
local initialZoom : number = 0                    -- the current zoom level of the camera using frustum height as the measurement

local initialYaw = camera.transform.eulerAngles.y -- the initial yaw of the camera to calculate the min/max yaw when the user rotates the camera
local initialPitch = camera.transform.eulerAngles.x -- the initial pitch of the camera to calculate the min/max pitch when the user rotates the camera
local cameraRig : Transform = camera.transform    -- quick reference to the camera's transform

local inertiaVelocity : Vector3 = Vector3.zero    -- the current velocity of the camera fom inertia
local inertiaMagnitude : number = 0               -- the magnitude of the current InertiaVelocity (this is an optimization to avoid calculating it every frame)
local inertiaMultiplier : number = 2              -- A multiplier to the inertia force to make it feel more or less initially intense.
local closeMaxInitialInertia : number = 35        -- The maximum amount of force when applying inertia to the panning of the camera at closest zoom
local farMaxInitialIntertia : number = 150        -- The maximum amount of force when applying inertia to the panning of the camera at farthest zoom
local inertiaDampeningFactor : number = 0.93      -- The multiplier used to scale the inertia force back over time.

local initialZoomOfPinch : number = 0             -- the zoom level at the start of the pinch gesture
local lastZoomScale : number = 1                  -- the scale that the pinch applied to InitialZoomOfPinch on the last frame, 1 being no change
local wasPinching : boolean = false               -- whether the last frame was pinching (two fingers) or not

local rotation : Vector3 = Vector3.new(0,initialYaw,0) -- the rotation of the camera (.y can be thought of it as the "swivel" of the camera around the Target)
local lastDirection : Vector2 = Vector2.zero      -- the direction of the last frame of the pinch gesture (for rotating the camera with touch controls)

local worldPlaneNormal : Vector3 = Vector3.zero   -- the normal of the plane that tracks panning the camera in a way that feels natural in the world
local worldPlane : Plane = nil                    -- the cached plane to avoid re-generating more often than needed
local rotatedLastFrame : boolean = false          -- whether the camera was rotated last frame or not and we need to recalculate the world plane



function SetupFromPivot()
    local ray = Ray.new(cameraRig.position, cameraRig.forward)
    local success, distance = worldPlane:Raycast(ray)
    zoom = distance * 2 * math.tan(camera.fieldOfView * 0.5 * Mathf.Deg2Rad)
    initialZoom = zoom
    initialZoomOfPinch = zoom
    
    target = ray:GetPoint(distance)
    newTarget = target
    pivot = target
end
    
function CalculateWorldPlane()
    worldPlaneNormal = Vector3.ProjectOnPlane(-camera.transform.forward, Vector3.up).normalized
    worldPlane = Plane.new(worldPlaneNormal, pivot)
end


CalculateWorldPlane()
SetupFromPivot()


-- Handle the reset event which is used to reset the camera to the local player's character. In this case we are bound to a plane, so that is our initial pivot and zoome
client.Reset:Connect(function()
    if (client.localPlayer.character) then
        ReCenter(pivot, initialZoom, Vector3.new(initialPitch, initialYaw, 0))
    end        
end)

Input.MouseWheel:Connect(function(evt)    
    if not IsActive() or not canZoom then
        return
    end
    if evt.delta.y < 0.0 then
        ZoomIn()
    else
        ZoomOut()
    end
end)

function IsActive()
    return camera ~= nil and camera.isActiveAndEnabled
end

Input.PinchOrDragBegan:Connect(function(evt)
    if not IsActive() then
        return
    end

    lastDirection = Vector2.zero
    ResetZoomScale()
    ResetInertia()
end)

Input.PinchOrDragChanged:Connect(function(evt)
    if not IsActive() then
        return
    end
    if rotatedLastFrame then
        CalculateWorldPlane()
        rotatedLastFrame = false
    end
    
    if not canRotate or not RotateCamera(evt) then
        if canPan then
            PanCamera(evt)
        end
    end

    if canZoom and evt.isPinching then
        ZoomCamera(evt)
    end

    wasPinching = evt.isPinching
end)

Input.PinchOrDragEnded:Connect(function(evt)
    if not IsActive() then
        return
    end
    if not Input.isMouseInput then
        ApplyInertia(CalculateWorldVelocity(evt))
    end
end)

function ScreenPositionToWorldPoint(camera, screenPosition)
    local ray = camera:ScreenPointToRay(screenPosition)

    local success, distance = worldPlane:Raycast(ray)
    if not success then
        print("HighriseCameraController Failed to cast a ray into the world.")
        return Vector3.zero
    end

    return ray:GetPoint(distance)
end
 
function PanCamera(evt)
    if wasPinching or Input.isAltPressed then
        return
    end
    local lastPosition = evt.position - evt.deltaPosition
    local startPoint = ScreenPositionToWorldPoint(camera, lastPosition)
    local endPoint = ScreenPositionToWorldPoint(camera, evt.position)
    local dragAdjustment = -(endPoint - startPoint)

    newTarget = newTarget + dragAdjustment
end

function RotateCamera(evt)
    if Input.isMouseInput then
        if not Input.isAltPressed then
            return false
        end

        -- Full screen width drag is 360 degrees and full screen height is the pitch range
        local screenDelta = evt.position - (evt.position - evt.deltaPosition)
        local xAngle = screenDelta.x / Screen.width * 360.0
        if Mathf.Abs(xAngle) >= Mathf.Epsilon then
            rotatedLastFrame = true
            Rotate(Vector2.new(xAngle, 0))
        end
    else
        if not evt.isPinching then
            return false
        end

        -- First frame of pinch
        if lastDirection == Vector2.zero then
            lastDirection = evt.direction
        -- Subsequent frames of pinch. Use the delta direction between two fingers to rotate the camera
        elseif evt.direction ~= Vector2.zero then
            local deltaAngle = Vector2.SignedAngle(lastDirection, evt.direction) * touchRotationDampener
            if Mathf.Abs(deltaAngle) >= Mathf.Epsilon then
                rotatedLastFrame = true
                Rotate(Vector2.new(deltaAngle, 0))
                
                lastDirection = evt.direction
                rotatedLastFrame = true
            end
        end
    end

    return true
end
    
-- Pan the camera on the X/Y plane by the given amount
function Rotate(rotate)
    local clampDifference = 0
    rotation = rotation + Vector3.new(rotate.y, rotate.x, 0)
    if (Mathf.Abs(yawOffsetMin) + Mathf.Abs(yawOffsetMax) < 360) then
        -- lock
        clampedYawMax = initialYaw + yawOffsetMax
        clampedYawMin = initialYaw + yawOffsetMin
        if (rotation.y > clampedYawMax) then
            clampDifference = rotation.y - clampedYawMax
            rotation.y = clampedYawMax
        elseif (rotation.y < clampedYawMin) then
            clampDifference = rotation.y - clampedYawMin
            rotation.y = clampedYawMin
        end
    else
        -- spin
        rotation.y = rotation.y + 3600  -- Ensure positive value
        rotation.y = rotation.y % 360   -- Ensure value is between 0 and 360
    end
    
    if Mathf.Abs(rotate.x) >= Mathf.Epsilon then
        rotate.x = rotate.x - clampDifference
        local rotationChangeQ = Quaternion.Euler(rotate.y, rotate.x, 0)
        local targetOffset = newTarget - pivot
        newTarget = pivot + rotationChangeQ * targetOffset
    end
end

-- to make the zoom behave correctly focusPoint needs to stay in the same spot on the screen
-- to do that the screen distance between focusPoint and the target needs to stay the same
-- therefore the world distance between these points needs to be scaled by deltaScalefunction ZoomCamera(evt)
function ZoomCamera(evt)
    -- New zoom attempt
    if not wasPinching then
        ResetZoomScale()
    end

    ZoomScaled(initialZoomOfPinch, evt.scale)

    local scale = zoom / initialZoomOfPinch
    local deltaScale = scale / lastZoomScale
    local focusPoint = ScreenPositionToWorldPoint(camera, evt.position)
    local zoomAdjustment = (target - focusPoint) * (1 / deltaScale - 1)

    newTarget = newTarget - zoomAdjustment
    lastZoomScale = scale
end

function ResetZoomScale(self)
    initialZoomOfPinch = zoom
    lastZoomScale = 1
end

function ZoomIn()
    zoom = Mathf.Clamp(zoom - 1, zoomMin, zoomMax)
end

function ZoomOut()
    zoom = Mathf.Clamp(zoom + 1, zoomMin, zoomMax)
end

function ZoomScaled(baseZoom, scaleFactor)
    local newZoom = baseZoom + (baseZoom / scaleFactor - baseZoom)
    zoom = Mathf.Clamp(newZoom, zoomMin, zoomMax)
end
    
function ResetInertia()
    inertiaVelocity = Vector3.zero
    inertiaMagnitude = 0
end

local MaxSwipeVelocity = 400 -- the maximum velocity of a swipe to apply inertia with
function CalculateWorldVelocity(evt)
    local velocity = evt.velocity
    velocity.x = Mathf.Clamp(velocity.x, -MaxSwipeVelocity, MaxSwipeVelocity)
    velocity.y = Mathf.Clamp(velocity.y, -MaxSwipeVelocity, MaxSwipeVelocity)

    local screenStart = evt.position
    local screenEnd = evt.position + velocity
    
    local worldStart = ScreenPositionToWorldPoint(camera, screenStart)
    local worldEnd = ScreenPositionToWorldPoint(camera, screenEnd)

    local result = -(worldEnd - worldStart) -- swiping right means moving the camera left
    return result * 2
end

function ApplyInertia(worldVelocity)
    local t = Easing.Quadratic((zoom - zoomMin) / (zoomMax - zoomMin)) -- closer camera means slower inertia
    local currentMaxVelocity = Mathf.Lerp(closeMaxInitialInertia, farMaxInitialIntertia, t)
    
    inertiaVelocity = Vector3.ClampMagnitude(worldVelocity * inertiaMultiplier, currentMaxVelocity)
    inertiaMagnitude = inertiaVelocity.magnitude
end

function ReCenter(setTarget, setZoom, setRotation)
    zoom = setZoom or zoom

    newTarget = setTarget
    zoom = Mathf.Clamp(zoom, zoomMin, zoomMax)
    rotation = setRotation
end

local InertiaMinVelocity = 0.5 -- prevents the infinite slow drag at the end of inertia
local InertiaStepDuration = 1 / 60 -- each "inertia step" is normalized to 60fps
function UpdateInertia()
    if not Input.isMouseInput and inertiaMagnitude > InertiaMinVelocity then
        local stepReduction = (1.0 - inertiaDampeningFactor) / (InertiaStepDuration / Time.deltaTime)
        local velocityDampener = 1.0 - math.min(math.max(stepReduction, 0), 1)
        inertiaVelocity = inertiaVelocity * velocityDampener
        inertiaMagnitude = inertiaMagnitude * velocityDampener
        newTarget = newTarget + (inertiaVelocity * Time.deltaTime)
    end
end

--local worldBounds = client.worldBounds
--worldBounds:Expand(outOfBoundsAllowance)
function UpdatePosition()
    --if worldBounds:Contains(newTarget) then
    target = newTarget
    --end

    local updatedRotation = Quaternion.Euler(
        initialPitch,
        rotation.y,
        0
    )

    local frustumHeight = zoom
    local fov = camera.fieldOfView
    local distance = (frustumHeight * 0.5) / math.tan(fov * 0.5 * Mathf.Deg2Rad)

    local cameraPos = Vector3.back * distance
    cameraPos = updatedRotation * cameraPos
    cameraPos = cameraPos + target

    cameraRig.position = cameraPos
    cameraRig:LookAt(target)

    newTarget = target
end

function self:Update()
    if not IsActive() then
        return
    end

    UpdateInertia()
    UpdatePosition()
end