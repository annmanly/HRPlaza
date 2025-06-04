--!Type(ClientAndServer)

local teleportRequest = Event.new("TeleportRequest")
local teleportEvent = Event.new("TeleportEvent")

function self:ClientAwake()

    local player = client.localPlayer

    function Teleport(position)
        teleportRequest:FireServer (position)
    end

    teleportEvent:Connect(function(player, pos)
        player.character:Teleport(pos)
        if player == client.localPlayer then
            local camera = client.mainCamera:GetComponent(RTSCamera)
            camera.ResetCamera()
        end
    end)

end

------------ Server ------------

function self:ServerAwake()
    teleportRequest:Connect(function(player, pos)
        player.character.transform.position = pos
        teleportEvent:FireAllClients(player, pos)
    end)
end