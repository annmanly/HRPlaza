--!Type(Client)

--!Tooltip("The camera to use for the NPC's view")
--!SerializeField
local _Camera : Camera = nil

--!Tooltip("Whether the NPC is moving or not")
--!SerializeField
local _IsStatic : boolean = false

--!Tooltip("The radius of the NPC's view")
--!SerializeField
local _ViewRadius : number = 4

--!Tooltip("The time the NPC will wait to move")
--!SerializeField
local _WaitToMoveTime : number = 10

--!Tooltip("The waypoints the NPC will move to")
--!SerializeField
local _WayPoints : { Transform } = nil

--!Tooltip("Whether the NPC should idle and wander")
--!SerializeField
local _ShouldIdleWander : boolean = true

--!Tooltip("The minimum time the NPC will wait before wandering")
--!SerializeField
local _MinTimeBeforeWander : number = 1

--!Tooltip("The maximum time the NPC will wait before wandering")
--!SerializeField
local _MaxTimeBeforeWander : number = 5

--!Tooltip("The percentage of the time the NPC will wander")
--!SerializeField
local _PercentToWander : number = 0.67

--!Tooltip("The animations the NPC will play when idle")
--!SerializeField
local _IdleAnimationsToPlay : { string } = nil

--!Tooltip("The radius of the NPC's wander")
--!SerializeField
local _WanderRadius : number = 3 -- How far from waypoint the NPC can wander

--!Tooltip("The chance the NPC will stop and do idle animation at waypoint")
--!SerializeField
local _ChanceToStop : number = 0.3 -- Chance to stop and do idle animation at waypoint

--!Tooltip("Whether to show the NPC's nameplate")
--!SerializeField
local _ShowNamePlate : boolean = true

--!Tooltip("The prefab for the NPC's nameplate")
--!SerializeField
local _NPCNameLabelPrefab : GameObject = nil

--!Tooltip("The offset of the NPC's nameplate")
--!SerializeField
local _NamePlateOffset : number = 3.5

--!Tooltip("The distance to show the NPC's nameplate")
--!SerializeField
local _DistanceToShowNamePlate : number = 10

local isNamePlateActive : boolean = false
local npcNameLabel : GameObject = nil
local playerInDistance : boolean = false

local moveTime : number = _WaitToMoveTime
local lastMoveTime : number = 0

local currentWayPointIndex : number = 1

local agent : NavMeshAgent = nil
local playerPosition : Vector3 = nil
local initialNPCPosition : Vector3 = nil

local playerInRange : boolean = false
local playerNear : boolean = false
local isPatrol : boolean = true
local isInteractingWithPlayer : boolean = false

local character : Character = nil
local isMoving : boolean = false
local lastStopTime : number = 0
local stopCooldown : number = 1 -- Cooldown in seconds between stops
local wanderTimer : Timer = nil

function SetInteractingWithPlayer(value: boolean)
  isInteractingWithPlayer = value
end

function InstantiateLabel(NPC: GameObject)
  npcNameLabel = GameObject.Instantiate(_NPCNameLabelPrefab)
  npcNameLabel.name = NPC.name
  npcNameLabel.transform.parent = NPC.transform

  npcNameLabel:GetComponent(npcnameplate).Initialize(NPC)
  isNamePlateActive = true

  npcNameLabel.transform.position = NPC.transform.position + Vector3.up * _NamePlateOffset
  npcNameLabel.transform.rotation = NPC.transform.rotation
end

function HideLabel()
  if isNamePlateActive then
    npcNameLabel:SetActive(false)
    isNamePlateActive = false
  end
end

function ShowLabel()
  if not isNamePlateActive then
    npcNameLabel:SetActive(true)
    isNamePlateActive = true
  end
end

function self:Awake()
  agent = self.gameObject:GetComponent(NavMeshAgent)
  character = self.gameObject:GetComponent(Character)

  if not agent.isActiveAndEnabled then
    agent.enabled = true
  end

  initialNPCPosition = self.gameObject.transform.position
end

function self:Start()
  if not _IsStatic and #_WayPoints < 0 then
    print("No waypoints found for NPC - Switching to static mode")
    _IsStatic = true
  end
  
  playerPosition = client.localPlayer.character.transform.position
  -- Start moving to first waypoint
  Move()

  if _ShowNamePlate then
    InstantiateLabel(self.gameObject)
  end
end

function Move()
  print("Moving to waypoint: " .. tostring(currentWayPointIndex))
  if character and not isMoving and not isInteractingWithPlayer then
    if not _WayPoints or not _WayPoints[currentWayPointIndex] then
      print("Invalid waypoint at index: " .. tostring(currentWayPointIndex)) 
      return
    end
    
    isMoving = true
    local moveTimedOut = false 

    Timer.After(5, function()
      if isMoving then
        print("MoveTo timeout. Forcing move completion")
        isMoving = false
        moveTimedOut = true
        moveTime = _WaitToMoveTime
        SetTimerForNextWaypoint()
      end
    end)

    -- Decide whether to move to waypoint or wander around it
    if math.random() < _ChanceToStop then
      -- Stop and do idle behavior
      character:MoveTo(_WayPoints[currentWayPointIndex].position, -1, function(character)
        isMoving = false
        moveTime = _WaitToMoveTime
        if not playerInRange then
          Stop()
        end
      end)
    else
      -- Wander around the waypoint
      local waypointPos = _WayPoints[currentWayPointIndex].position
      local randomOffset = Random.insideUnitCircle * _WanderRadius
      local targetPos = waypointPos + Vector3.new(randomOffset.x, 0, randomOffset.y)
      
      character:MoveTo(targetPos, -1, function(character)
        isMoving = false
        moveTime = _WaitToMoveTime
        if not playerInRange then
          SetTimerForNextWaypoint()
        else
          Stop()
        end
      end)
    end
  end
end

function Stop()
  -- Only stop if enough time has passed since last stop
  if Time.time - lastStopTime < stopCooldown then
    return
  end
  
  if character then
    character:SetIdle()
    isMoving = false
    lastStopTime = Time.time
    
    -- Start idle behavior when stopped
    if _ShouldIdleWander then
      SetTimerForIdleWander()
    end
  end
end

function SetTimerForIdleWander()
  if not _ShouldIdleWander then return end
  
  if wanderTimer then
    wanderTimer:Stop()
  end
  
  local timeBeforeWander = math.random(_MinTimeBeforeWander, _MaxTimeBeforeWander)
  wanderTimer = Timer.After(timeBeforeWander, DoIdleWander)
end

function DoIdleWander()
  if not isMoving and not playerInRange and not isInteractingWithPlayer then
    local wander = math.random() < _PercentToWander
    if not wander and _IdleAnimationsToPlay and #_IdleAnimationsToPlay > 0 then
      PlayRandomIdleAnimation()
    else
      Wander()
    end
  end
end

function PlayRandomIdleAnimation()
  if not _IdleAnimationsToPlay or #_IdleAnimationsToPlay == 0 then return end
  
  local randomIndex = math.random(1, #_IdleAnimationsToPlay)
  local playingEmote = character:PlayEmote(_IdleAnimationsToPlay[randomIndex], 1, false, function()
    SetTimerForIdleWander()
  end)
  
  if not playingEmote then
    SetTimerForIdleWander()
  end
end

function Wander()
  local waypointPos = _WayPoints[currentWayPointIndex].position
  local randomOffset = Random.insideUnitCircle * _WanderRadius
  local targetPos = waypointPos + Vector3.new(randomOffset.x, 0, randomOffset.y)
  
  local foundMove = character:MoveTo(targetPos, -1, function(character)
    if not isInteractingWithPlayer then
      SetTimerForIdleWander()
    end
  end)
end

function SetTimerForNextWaypoint()
  Timer.After(_WaitToMoveTime, function()
    if not isInteractingWithPlayer and not playerInRange then
      NextPoint()
    end
  end)
end

function NextPoint()
  currentWayPointIndex = currentWayPointIndex + 1
  if currentWayPointIndex > #_WayPoints then
    currentWayPointIndex = 1
  end
  Move()
end

-- Function to move the NPC randomly in range in a circle in waypoints
function MoveInPosition()
  if character and not isMoving and not playerInRange and not isInteractingWithPlayer then
    local position = _WayPoints[currentWayPointIndex].position
    local randomPosition = Random.insideUnitCircle
    local targetPosition = position + Vector3.new(randomPosition.x, 0, randomPosition.y).normalized * _ViewRadius
    character:MoveTo(targetPosition, -1, function(character)
      isMoving = false
      moveTime = _WaitToMoveTime
    end)
  end
end

function Behaviour()
  if isInteractingWithPlayer then return end

  if playerInRange then
    Stop()
    return
  end

  if moveTime <= 0 and not isMoving then
    NextPoint()
  end
end

function CheckPlayerInRange()
  local player = client.localPlayer.character
  if not player then return end
  
  local sqrDistance = (self.transform.position - player.transform.position).sqrMagnitude
  playerInRange = sqrDistance <= (_ViewRadius * _ViewRadius)

  playerInDistance = sqrDistance <= (_DistanceToShowNamePlate * _DistanceToShowNamePlate)
  if playerInDistance and not isInteractingWithPlayer then
    if not isNamePlateActive then
      ShowLabel()
    end
  else
    HideLabel()
  end
end

function self:Update()
  if _IsStatic then return end

  CheckPlayerInRange()
  
  if moveTime > 0 then
    moveTime = moveTime - Time.deltaTime
  end

  -- Only try to move if we're not already moving and player is not in range
  if not isMoving and not playerInRange and moveTime <= 0 then
    NextPoint()
  end
end