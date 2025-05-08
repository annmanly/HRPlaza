--!Type(Client)
--!SerializeField
local collectibleObject:GameObject = nil
local collectibleObj = nil
local lifetime:number = 45 -- time before despawn
local minRespawnTimer:number = 5 -- time after collected before spawning again but will add offset
timerOffset = math.random(0, 5)

function spawnObject()
    if collectibleObj then
        collectibleObj.gameObject:SetActive(true)
        Timer.After(lifetime, despawnObject)
    end
end

function despawnObject()
    if collectibleObj then
        collectibleObj.gameObject:SetActive(false)
        timerOffset = math.random(0, 5)
        Timer.After(minRespawnTimer+timerOffset, spawnObject)
    end
end

function self:Start()
    collectibleObj = GameObject.Instantiate(collectibleObject, self.gameObject.transform.position)
    collectibleObj.gameObject.transform.eulerAngles = Vector3.new(0, math.random(10,350), 0)
    Timer.After(timerOffset, spawnObject)
    -- Timer.After(respawnTimer, spawnObject)
end