--!Type(ClientAndServer)

local teleportRequest = Event.new("TeleportRequest")
local teleportEvent = Event.new("TeleportEvent")

function self:ClientAwake()

    local player = client.localPlayer

    local teleportLoaction = nil

    function Teleport(position)
        teleportLoaction = position
        teleportRequest:FireServer (teleportLoaction)
    end

    teleportEvent:Connect(function(player, pos)
        player.character:Teleport(teleportLoaction)
    end)
end

------------ Server ------------

function self:ServerAwake()
    teleportRequest:Connect(function(player, pos)
        player.character.transform.position = pos
        teleportEvent:FireAllClients(player)
    end)
end