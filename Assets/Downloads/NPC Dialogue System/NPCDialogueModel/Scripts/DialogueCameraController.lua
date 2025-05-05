--!Type(Client)

--!Tooltip("The default camera to switch to when dialogue ends")
--!SerializeField
local _DefaultCamera : Camera = nil

--!Tooltip("Don't enable the default camera on start if you have other cameras")
--!SerializeField
local _EnableDefaultCameraOnStart : boolean = true

--!Tooltip("The duration of the camera transition in seconds")
--!SerializeField
local _TransitionDuration : number = 1.0 -- Duration of camera transitions in seconds

--!Tooltip("The distance from characters during dialogue (how far the camera is from the characters)")
--!SerializeField
local _DialogueDistance : number = 5 -- Distance from characters during dialogue

--!Tooltip("The height of the camera during dialogue (how much the camera is above the characters)")
--!SerializeField
local _DialogueHeight : number = 2 -- Height of camera during dialogue

--!Tooltip("The offset for the look-at point (how much the camera is above the characters)")
--!SerializeField
local _LookAtOffset : number = 1.5 -- Height offset for look-at point

--!Tooltip("Whether to avoid obstacles")
--!SerializeField
local _EnableCollisionAvoidance : boolean = true

--!Tooltip("The offset for collision avoidance")
--!SerializeField
local _CollisionOffset : number = 0.2

--!Tooltip("The minimum distance to obstacles")
--!SerializeField
local _ObstacleDistanceMin : number = 0.5

--!Tooltip("The maximum distance to obstacles")
--!SerializeField
local _ObstacleDistanceMax : number = 2.0

--!Tooltip("The maximum distance to obstacles")
--!SerializeField
local _RayDistanceMax : number = 10

--!Tooltip("The minimum distance to obstacles")
--!SerializeField
local _RayDistanceMin : number = 0.1

--!Tooltip("The speed at which camera stabilizes after transition")
--!SerializeField
local _StabilizationSpeed : number = 5.0 -- Speed at which camera stabilizes after transition

--!Tooltip("Whether to automatically rotate avatars to face each other during dialogue")
--!SerializeField
local _RotateAvatars : boolean = true

--!Tooltip("How quickly avatars rotate to face each other")
--!SerializeField
local _AvatarRotationSpeed : number = 8.0

local currentTransitionTime : number = 0
local isTransitioning : boolean = false
local transitionStartPosition : Vector3 = Vector3.zero
local transitionStartRotation : Quaternion = Quaternion.identity
local targetPosition : Vector3 = Vector3.zero
local targetRotation : Quaternion = Quaternion.identity
local playerTransform : Transform = nil
local npcTransform : Transform = nil
local isInDialogue : boolean = false
local currentPosition : Vector3 = Vector3.zero
local currentRotation : Quaternion = Quaternion.identity
local isReturningToDefault : boolean = false
local originalPlayerRotation : Quaternion = Quaternion.identity
local originalNPCRotation : Quaternion = Quaternion.identity
local desiredPlayerRotation : Quaternion = Quaternion.identity
local desiredNPCRotation : Quaternion = Quaternion.identity

local _DialogueCamera : Camera = nil

-- Important to stop the player from moving when dialogue is happening
local PlayerController = require("PlayerCharacterController")

function self:Awake()
    _DialogueCamera = self.gameObject:GetComponent(Camera)
end

function self:Start()
    if _EnableDefaultCameraOnStart then
        _DefaultCamera.enabled = true
    end
    _DialogueCamera.enabled = false
end

function self:OnDestroy()
    _DefaultCamera.enabled = true
    _DialogueCamera.enabled = false
end

function CalculateDialogueCameraPosition(playerPos: Vector3, npcPos: Vector3): Vector3
    -- Calculate midpoint between player and NPC
    local midpoint = (playerPos + npcPos) * 0.5
    
    -- Calculate direction from midpoint to camera position
    local direction = (playerPos - npcPos).normalized
    local perpendicular = Vector3.Cross(direction, Vector3.up).normalized
    
    -- Calculate base camera position
    local basePosition = midpoint + (perpendicular * _DialogueDistance) + (Vector3.up * _DialogueHeight)
    
    -- Apply collision avoidance if enabled
    if _EnableCollisionAvoidance then
        local rayOrigin = midpoint + (Vector3.up * _DialogueHeight)
        local rayDirection = (basePosition - rayOrigin).normalized
        local layerMask = LayerMask.GetMask({"Default"})
        
        local hit, hitInfo = Physics.Raycast(rayOrigin, rayDirection, _DialogueDistance + _ObstacleDistanceMax, layerMask)
        if hit then
            local hitDistance = (hitInfo.point - rayOrigin).magnitude
            local t = math.clamp((hitDistance - _RayDistanceMin) / (_RayDistanceMax - _RayDistanceMin), 0, 1)
            local minObstacleDistance = Mathf.Lerp(_ObstacleDistanceMin, _ObstacleDistanceMax, t)
            
            if hitDistance < _DialogueDistance + minObstacleDistance then
                return rayOrigin + rayDirection * (hitDistance - minObstacleDistance - _CollisionOffset)
            end
        end
    end
    
    return basePosition
end

function CalculateDialogueCameraRotation(playerPos: Vector3, npcPos: Vector3): Quaternion
    local midpoint = (playerPos + npcPos) * 0.5
    local lookAtPoint = midpoint + (Vector3.up * _LookAtOffset)
    
    -- Calculate rotation based on current camera position
    local currentPos = isTransitioning and _DialogueCamera.transform.position or targetPosition
    local direction = (lookAtPoint - currentPos).normalized
    return Quaternion.LookRotation(direction)
end

function StartDialogueCamera(player: Player, npc: GameObject)
    if not player or not npc then return end

    PlayerController.options.enabled = false
    
    playerTransform = player.character.transform
    npcTransform = npc.transform
    isInDialogue = true
    isReturningToDefault = false
    
    -- Store original rotations
    if _RotateAvatars then
        originalPlayerRotation = playerTransform.rotation
        originalNPCRotation = npcTransform.rotation
        
        -- Calculate direction between characters
        local directionToNPC = (npcTransform.position - playerTransform.position).normalized
        local directionToPlayer = -directionToNPC
        
        -- Calculate desired rotations to face each other
        desiredPlayerRotation = Quaternion.LookRotation(directionToNPC)
        desiredNPCRotation = Quaternion.LookRotation(directionToPlayer)
    end
    
    -- Calculate ideal dialogue camera position and rotation
    targetPosition = CalculateDialogueCameraPosition(playerTransform.position, npcTransform.position)
    targetRotation = CalculateDialogueCameraRotation(playerTransform.position, npcTransform.position)
    
    -- Start from the default camera's current view
    transitionStartPosition = _DefaultCamera.transform.position
    transitionStartRotation = _DefaultCamera.transform.rotation
    
    -- Initialize dialogue camera while it's still disabled
    _DialogueCamera.transform.position = transitionStartPosition
    _DialogueCamera.transform.rotation = transitionStartRotation
    
    -- Store current position/rotation for smooth transitions
    currentPosition = transitionStartPosition
    currentRotation = transitionStartRotation
    
    -- Start transition
    currentTransitionTime = 0
    isTransitioning = true
    
    -- Ensure the dialogue camera is properly positioned before enabling
    _DialogueCamera.enabled = false
    _DefaultCamera.enabled = false
    
    -- Force an immediate update of the camera transform
    _DialogueCamera.transform.position = transitionStartPosition
    _DialogueCamera.transform.rotation = transitionStartRotation
    
    -- Now enable the dialogue camera
    _DialogueCamera.enabled = true
end

function EndDialogueCamera()
    PlayerController.options.enabled = true
    -- Restore original rotations when dialogue ends
    if _RotateAvatars then
        if playerTransform then
            playerTransform.rotation = originalPlayerRotation
        end
        if npcTransform then
            npcTransform.rotation = originalNPCRotation
        end
    end
    
    isInDialogue = false
    isReturningToDefault = true
    
    -- Store current camera state
    transitionStartPosition = _DialogueCamera.transform.position
    transitionStartRotation = _DialogueCamera.transform.rotation
    
    -- Calculate target camera state (back to default)
    targetPosition = _DefaultCamera.transform.position
    targetRotation = _DefaultCamera.transform.rotation
    
    -- Initialize default camera while it's still disabled
    _DefaultCamera.transform.position = targetPosition
    _DefaultCamera.transform.rotation = targetRotation
    
    -- Start transition
    currentTransitionTime = 0
    isTransitioning = true
end

function UpdateCameraPosition()
    if not isInDialogue or not playerTransform or not npcTransform then return end
    
    -- Calculate desired position and rotation
    local desiredPosition = CalculateDialogueCameraPosition(playerTransform.position, npcTransform.position)
    local desiredRotation = CalculateDialogueCameraRotation(playerTransform.position, npcTransform.position)
    
    -- Smoothly interpolate to desired position
    currentPosition = Vector3.Lerp(currentPosition, desiredPosition, Time.deltaTime * _StabilizationSpeed)
    currentRotation = Quaternion.Slerp(currentRotation, desiredRotation, Time.deltaTime * _StabilizationSpeed)
    
    -- Apply position and rotation
    _DialogueCamera.transform.position = currentPosition
    _DialogueCamera.transform.rotation = currentRotation
end

function UpdateAvatarRotations()
    if not _RotateAvatars or not isInDialogue then return end
    
    -- Smoothly rotate characters to face each other
    if playerTransform then
        playerTransform.rotation = Quaternion.Slerp(
            playerTransform.rotation,
            desiredPlayerRotation,
            Time.deltaTime * _AvatarRotationSpeed
        )
    end
    
    if npcTransform then
        npcTransform.rotation = Quaternion.Slerp(
            npcTransform.rotation,
            desiredNPCRotation,
            Time.deltaTime * _AvatarRotationSpeed
        )
    end
end

function self:Update()
    if isTransitioning then
        -- Update transition progress
        currentTransitionTime = currentTransitionTime + Time.deltaTime
        local t = math.min(currentTransitionTime / _TransitionDuration, 1.0)
        
        -- Use a smoother easing function for more cinematic transitions
        -- Cubic ease-in-out with slower start
        t = t < 0.5 and 4 * t * t * t or 1 - math.pow(-2 * t + 2, 3) / 2
        
        -- Calculate current camera position
        local newPosition = Vector3.Lerp(transitionStartPosition, targetPosition, t)
        
        if isReturningToDefault then
            -- Update the dialogue camera position during transition out
            _DialogueCamera.transform.position = newPosition
            
            -- Smoothly interpolate rotation for exit transition
            _DialogueCamera.transform.rotation = Quaternion.Slerp(transitionStartRotation, targetRotation, t)
            
            -- If transition is nearly complete, smoothly switch cameras
            if t > 0.99 then
                -- Ensure exact position match before switch
                _DialogueCamera.transform.position = targetPosition
                _DialogueCamera.transform.rotation = targetRotation
                _DefaultCamera.transform.position = targetPosition
                _DefaultCamera.transform.rotation = targetRotation
                
                -- Enable default camera only when positions match exactly
                if not _DefaultCamera.enabled then
                    _DefaultCamera.enabled = true
                end
            end
            
            -- Only disable dialogue camera at the very end
            if t >= 1.0 then
                -- One final position check before switch
                _DefaultCamera.transform.position = targetPosition
                _DefaultCamera.transform.rotation = targetRotation
                _DialogueCamera.enabled = false
                isTransitioning = false
            end
        else
            -- Normal dialogue entry transition
            _DialogueCamera.transform.position = newPosition
            
            -- Recalculate rotation based on current position
            local midpoint = (playerTransform.position + npcTransform.position) * 0.5
            local lookAtPoint = midpoint + (Vector3.up * _LookAtOffset)
            local direction = (lookAtPoint - newPosition).normalized
            _DialogueCamera.transform.rotation = Quaternion.LookRotation(direction)
            
            -- Store current position/rotation for stabilization
            currentPosition = _DialogueCamera.transform.position
            currentRotation = _DialogueCamera.transform.rotation
            
            -- If transition is complete
            if t >= 1.0 then
                isTransitioning = false
            end
        end
    elseif isInDialogue then
        -- Update camera position during dialogue
        UpdateCameraPosition()
    end
    
    -- Update avatar rotations every frame
    UpdateAvatarRotations()
end 