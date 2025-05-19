--[[
	
	Copyright (c) 2024 Pocket Worlds

	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.

	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:

	1. The origin of this software must not be misrepresented; you must not
	claim that you wrote the original software. If you use this software
	in a product, an acknowledgment in the product documentation would be
	appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be
	misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.
	
--]]

--!Type(Module)

--!SerializeField
local characterPrefab : GameObject = nil

OnCharacterSpawned = Event.new("OnCharacterSpawned")

function self:ServerStart()
    math.randomseed(os.time())

    scene.PlayerJoined:Connect(function(scene, player)
        -- Defer the spawn to the next frame to make sure everyone gets a chance to handle PlayerConnected
        -- and bind to CharacterInstantiated before the character is actually spawned
        local spawnPos : Vector3 = nil;
        local spawnRot : Vector3 = nil;
        
        local spawns = GameObject.FindGameObjectsWithTag("CharacterSpawn")
        local avatarSpawns = GameObject.FindGameObjectsWithTag("AvatarSpawn")
        table.move(avatarSpawns, 1, #avatarSpawns, #spawns + 1, spawns)

        if (#spawns > 0) then
            spawnTransform = spawns[math.random(1, #spawns)].transform
            spawnPos = spawnTransform.position
            spawnRot = spawnTransform.eulerAngles
        else
            spawnPos = Vector3.new(0,0,0)
            spawnRot = spawnPos;
        end
        
        player.character = Object.Instantiate(characterPrefab, spawnPos, spawnRot);  
        OnCharacterSpawned:Fire(player.character)
        OnCharacterSpawned:FireAllClients(player.character)
    end)
end

