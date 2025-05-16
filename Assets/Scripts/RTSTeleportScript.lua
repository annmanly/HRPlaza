--!Type(ClientAndServer)

local teleportRequest = Event.new("TeleportRequest")
local teleportEvent = Event.new("TeleportEvent")

function self:ClientAwake()

    local player = client.localPlayer

    function Teleport(position, lookAtTransform)
        local angle = Quaternion.LookRotation(lookAtTransform - position).eulerAngles.y
        teleportRequest:FireServer (position, angle)
    end

    teleportEvent:Connect(function(player, pos, angle)
        player.character:Teleport(pos)
        if player == client.localPlayer then
            local camera = client.mainCamera:GetComponent(RTSCamera)
            camera.ResetCamera()
            camera.SetYaw(angle)
        end
    end)

end

------------ Server ------------

function self:ServerAwake()
    teleportRequest:Connect(function(player, pos, angle)
        player.character.transform.position = pos
        teleportEvent:FireAllClients(player, pos, angle)
    end)
end