--!Type(Client)

-- First person camera

--!SerializeField
local cameraHeightFromPlayer : number = 1.5 -- The height of the camera from the player

-- Rotation limits

--!SerializeField
local EnableMaxPitch : boolean = true -- Enable the maximum pitch
--!SerializeField
local EnableMaxYaw : boolean = false -- Enable the maximum yaw

--!SerializeField
local minPitch : number = -45 -- The minimum pitch of the camera (looking down)
--!SerializeField
local maxPitch : number = 45 -- The maximum pitch of the camera (looking up)
--!SerializeField
local minYaw : number = -360 -- For full 360 rotation, set to -360 (left/right movement)
--!SerializeField
local maxYaw : number = 360 -- For full 360 rotation, set to 360 (left/right movement)

--!SerializeField
local touchRotationSensitivity : number = 0.4 -- The sensitivity of the rotation
--!SerializeField
local mouseRotationSensitivity : number = 0.25 -- The sensitivity of the rotation using a mouse

--!SerializeField
local rotationSmoothing : number = 1 -- The smoothing of the rotation

local currentRotationVelocity : Vector2 = Vector2.zero -- The current rotation velocity

local rotationSensitivity = 0
local yaw : number = 0 -- The yaw of the camera
local pitch : number = 0 -- The pitch of the camera

--!SerializeField
local FOV : number = 70 -- The field of view of the camera

local camera = self.gameObject:GetComponent(Camera) -- or Camera.main
if camera == nil then
    error("FirstPersonCamera.lua requires a Camera component on the same GameObject")
end

-- Camera transform reference
local cameraRig : Transform = camera.transform

local rotation : Vector3 = Vector3.zero -- The rotation of the camera
local lastDirection : Vector2 = Vector2.zero -- The last direction of the camera (for rotation)

local target = Vector3.zero -- The target position of the camera
local offset = Vector3.new(0, cameraHeightFromPlayer, 0) -- The offset of the camera from the target

function self:Start()
    self:ResetCamera()
end

function self:ResetCamera()
    -- Adjust sensitivity for mobile devices
    if Input.isMouseInput then
        rotationSensitivity = mouseRotationSensitivity
    else 
        rotationSensitivity = touchRotationSensitivity
    end

    yaw = 0
    pitch = 0

    currentRotationVelocity = Vector2.zero
    camera.fieldOfView = FOV

    lastDirection = Vector2.zero

    if client.localPlayer.character then
        local characterTransform = client.localPlayer.character.gameObject.transform
        yaw = characterTransform.eulerAngles.y
        SetFirstPersonView(characterTransform.position)
    end
end

local localCharacterInstantiatedEvent = nil
local localCharacterInstantiatedEvent = client.localPlayer.CharacterChanged:Connect(function(player, character)
    if character then
        OnLocalCharacter(player, character)
    end
end)

function OnLocalCharacter(player, character)
    localCharacterInstantiatedEvent:Disconnect()
    localCharacterInstantiatedEvent = nil
    -- Get the position of the player
    local playerPosition = character.gameObject.transform.position
    -- Set the camera position to the player position
    SetFirstPersonView(playerPosition)
end

-- Function that creates the first person view based on the player's position
function SetFirstPersonView(target)
    -- Set the camera position to the player position
    camera.transform.position = target + offset
end

-- Function to check if the camera is active
function self:IsActive()
    return camera ~= nil and camera.isActiveAndEnabled and self.isActiveAndEnabled
end


-- When the pinch or drag begins
Input.PinchOrDragBegan:Connect(function(event)
    if not self:IsActive() then
        return
    end

    lastDirection = Vector2.zero
end)

-- When the pinch or drag changes
Input.PinchOrDragChanged:Connect(function(event)
    if not self:IsActive() then
        return
    end

    RotateCamera(event)

end)

Input.PinchOrDragEnded:Connect(function(event)
    if not self:IsActive() then
        return
    end

    lastDirection = Vector2.zero
end)

function Rotate(rotate)
    -- Apply sensitivity
    rotate = rotate * rotationSensitivity

    -- Smooth the rotation
    currentRotationVelocity = Vector2.Lerp(currentRotationVelocity, rotate, rotationSmoothing)
    
    -- Adjust the pitch rotation (up/down movement)
    if EnableMaxPitch then
        pitch = math.clamp(pitch + currentRotationVelocity.y, minPitch, maxPitch)
    else
        pitch = pitch + currentRotationVelocity.y
    end
    
    -- Adjust the yaw rotation (left/right movement)
    if EnableMaxYaw then
        yaw = math.clamp(yaw + currentRotationVelocity.x, minYaw, maxYaw)
    else
        yaw = yaw + currentRotationVelocity.x
    end
end

function UpdatePosition()
    -- Get the player's position
    local playerPosition = client.localPlayer.character.gameObject.transform.position
    -- Set the camera position to the player position
    camera.transform.position = playerPosition + offset

    -- Calculate the rotation to look at the player
    local rotation = Quaternion.Euler(pitch, yaw, 0)
    
    -- Apply the rotation to the camera
    cameraRig.rotation = rotation
end

function RotateCamera(evt)
    local delta = evt.deltaPosition
    local deltaX = delta.x
    local deltaY = delta.y

    local deltaAngleX = -deltaY * rotationSensitivity  -- Invert for natural movement
    local deltaAngleY = deltaX * rotationSensitivity

    Rotate(Vector2.new(deltaAngleY, 0))
    Rotate(Vector2.new(0, deltaAngleX))
end


function self:Update()
    if not self:IsActive() then
        return
    end

    UpdatePosition()
end