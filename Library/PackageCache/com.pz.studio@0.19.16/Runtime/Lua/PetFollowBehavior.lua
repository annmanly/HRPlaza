--[[
    
    Copyright (c) 2024 Pocket Worlds

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely.
    
--]] 

--!Type(Client)

-------------------------------------------------------------------------------
-- Properties
-------------------------------------------------------------------------------

--!Header("Follow Settings")
--!SerializeField
local _followStartDistance : number = 4 --the distance from the target to start following
--!SerializeField
local _targetFollowDistance : number = 1 --the distance to stop from the target when following
--!SerializeField
local _useNavmesh : boolean = true --if false, pet will follow the target's direction
--!SerializeField
local _teleportIfNoPath : boolean = true --if true, the pet will teleport to the target if no navmesh path can be found
--!SerializeField
local _teleportIfTooFar : boolean = true --if true, the pet will teleport to the target if the target is too far away
--!SerializeField
local _teleportDistance : number = 20 --The distance where the pet will teleport if _teleportIfTooFar is enabled

--!Header("Idle Wander Settings")
--!SerializeField
local _shouldIdleWander : boolean = true
--!SerializeField
local _percentToWander : number = 0.67 --percent chance to wander instead of playing idle animations
--!SerializeField
local _minTimeBeforeWander : number = 3 --minimum time before the pet will play idle animations/wander
--!SerializeField
local _maxTimeBeforeWander : number = 5 --maximum time before the pet will play idle animations/wander
--!SerializeField
local _idleAnimationsToPlay : {string} = nil --animations to play when the pet is not following the target

local _petController = require("PetCharacterController")
local _character : Character = nil
local _characterTransform : Transform = nil
local _target : Transform = nil
local _following : boolean = false
local _walkScale : number = 1
local _wanderTimer : Timer = nil

function self:ClientStart()
    --get the character from the parent
    _character = self:GetComponentInParent(Character)
    if _character ~= nil then
        _characterTransform = _character.transform
    end

    --if this is a pet, automatically set the player as the target
    local petInfo = _petController.GetPetFromCharacter(_character)
    if petInfo then
        _target = petInfo.player.character.transform
    end

    SetFollowing(false)
end

function SetFollowTarget(target : Transform)
    _target = target
end

function self:ClientOnDestroy()
    if _wanderTimer then
        _wanderTimer:Stop()
    end
end

function self:ClientUpdate()
    if IsPetValid() then
        UpdatePet()
    end
end

function UpdatePet()
    if not _following and IsOutOfRangeOfTarget() then
        --start following the target if the pet is out of range
        SetFollowing(true)
        if _useNavmesh then
            FollowTargetOnNavmesh()
        else
            _character:PlayEmote("walk", _walkScale, true)
        end
    end

    if(_following and _useNavmesh and not _character.isMoving) then
        SetFollowing(false)
    end

    if _following and not _useNavmesh then
        -- if not using the navmesh, directly follow the target's direction
        FollowTargetDirection()
    end
end

function TeleportToTarget()
    _character:Teleport(_target.position)
    SetFollowing(false)
end

function FollowTargetOnNavmesh()

    local sqrDistanceToTarget = (_target.position - _characterTransform.position).sqrMagnitude;
    if _teleportIfTooFar and sqrDistanceToTarget >= TeleportDistanceSqr() then
        TeleportToTarget()
    else
        --the pet was out of range of the target, so move it to the target
        local foundPath = _character:MoveWithinRangeOf(_target.position, _targetFollowDistance, -1, 
            function(character)
                SetFollowing(false)
            end)

        --if the target is separated from the pet and no path can be found, teleport the pet to the target
        if not foundPath and _teleportIfNoPath then
            TeleportToTarget()
        end
    end
end

function SetTimerForIdleWander()
    if not _shouldIdleWander then
        return
    end

    if (_wanderTimer) then
        _wanderTimer:Stop()
    end
    --choose random time for next wander
    local timeBeforeWander = math.random(_minTimeBeforeWander, _maxTimeBeforeWander)
    _wanderTimer = Timer.After(timeBeforeWander, DoIdleWander)
end

function DoIdleWander()
    if not _following then
        --randomly choose to play an idle animation or wander
        local wander = math.random() < _percentToWander
        if not wander and #_idleAnimationsToPlay > 0 then
            PlayRandomIdleAnimation()
        else
            Wander()
        end
    end
end

function PlayRandomIdleAnimation()
    local randomIndex = math.random(1, #_idleAnimationsToPlay)
    local playingEmote = _character:PlayEmote(_idleAnimationsToPlay[randomIndex], 1, false, function()
        SetTimerForIdleWander()
    end)

    if not playingEmote then
        SetTimerForIdleWander()
    end
end

function Wander()
    if not _useNavmesh then
        SetTimerForIdleWander()
        return
    end

    local targetPosition = _target.position
    local randomPosition = Random.insideUnitCircle
    local targetPosition = targetPosition + Vector3.new(randomPosition.x, 0, randomPosition.y).normalized * _targetFollowDistance
    local foundMove = _character:MoveTo(targetPosition, -1, function(character)
        if not _following then
            SetTimerForIdleWander()
        end
    end)
end

--Follow the target's direction when not using the navmesh
function FollowTargetDirection()
    local petPos = _characterTransform.position
    local targetPos = _target.position
    local direction = (targetPos - petPos).normalized
    _characterTransform.forward = direction

    local sqrDistanceToTarget = (targetPos - petPos).sqrMagnitude;
    if _teleportIfTooFar and sqrDistanceToTarget >= TeleportDistanceSqr() then
        TeleportToTarget()
    elseif sqrDistanceToTarget >= TargetFollowDistanceSqr() then
        _characterTransform.position += (direction * _character.speed * Time.deltaTime)
    else
        SetFollowing(false)
    end
end

function SetFollowing(following : boolean)
    _following = following
    if not _following and IsPetValid() then
        _character:SetIdle()
        SetTimerForIdleWander()
    end
end

function IsPetValid() : boolean
    return _character ~= nil and _target ~= nil
end

function IsOutOfRangeOfTarget() : boolean
    local targetPos = _target.position
    local petPos = _characterTransform.position
    --compare the squared distance for optimization
    return (targetPos - petPos).sqrMagnitude > FollowStartDistanceSqr()
end

function FollowStartDistanceSqr() : number
    return _followStartDistance * _followStartDistance
end

function TargetFollowDistanceSqr() : number
    return _targetFollowDistance * _targetFollowDistance
end

function TeleportDistanceSqr() : number
    return _teleportDistance * _teleportDistance
end