--!Type(Client)
--!SerializeField
local collectibleObject:GameObject = nil

--!SerializeField
local startSpawnPositions:{Transform} = {}
--!SerializeField
local endSpawnPositions:{Transform} = {}

local lifetime:number = 25 -- time before despawn
local minRespawnTimer:number = lifetime -- time after collected before spawning again but will add offset
timerOffset = math.random(0, 5)


function spawnObject()
    Timer.After(math.random(0, 1), 
        function() 
            randomChoice = math.random(1, #startSpawnPositions)
            spawnPos = startSpawnPositions[randomChoice]
            newObj = GameObject.Instantiate(collectibleObject, spawnPos.position)
            newObj.gameObject.transform:LookAt(endSpawnPositions[randomChoice])
            Timer.After(lifetime, function() despawnObject(newObj) end)
    end)

end

function despawnObject(obj)
    if obj then
        GameObject.Destroy(obj)
    end
end

function self:Start()
    spawnObject()
    Timer.Every(minRespawnTimer, spawnObject)
end