--!Type(Client)
--!SerializeField
local collectibleObject:GameObject = nil

--!SerializeField
local startSpawnPositions:{Transform} = {}
--!SerializeField
local endSpawnPositions:{Transform} = {}

local lifetime:number = 60*3 -- time before despawn
local minRespawnTimer:number = lifetime -- time after collected before spawning again but will add offset
timerOffsetMax = 5
local raffleManager = require("RaffleManager")

local spawnSound = nil

function spawnObject()
    Timer.After(math.random(0, timerOffsetMax), 
        function() 
            randomChoice = math.random(1, #startSpawnPositions)
            spawnPos = startSpawnPositions[randomChoice]
            newObj = GameObject.Instantiate(collectibleObject, spawnPos.position)
            newObj.gameObject.transform:LookAt(endSpawnPositions[randomChoice])
            Timer.After(lifetime, function() despawnObject(newObj) end)
            if spawnSound then spawnSound:Play() end
    end)

end

function despawnObject(obj)
    if obj then
        GameObject.Destroy(obj)
    end
end

function self:Start()
    raffleManager.SpawnRaffleTicketEvent:Connect(spawnObject)
    spawnSound = self.gameObject:GetComponent(AudioSource)
end