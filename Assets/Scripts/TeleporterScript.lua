--!Type(ClientAndServer)

local teleportRequest = Event.new("TeleportRequest")
local teleportEvent = Event.new("TeleportEvent")

function self:ClientAwake()

    local player = client.localPlayer

    local teleportLocation = nil

    function Teleport(position)
        teleportLocation = position
        teleportRequest:FireServer(teleportLocation)
    end

    teleportEvent:Connect(function(player, pos)
        player.character:Teleport(pos)
    end)
end

------------ Server ------------

function self:ServerAwake()
    teleportRequest:Connect(function(player, pos)
        player.character.transform.position = pos
        teleportEvent:FireAllClients(player, pos)
    end)
end