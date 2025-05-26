--!Type(ClientAndServer)
local EnteredAnchor = Event.new("EnteredAnchor")
local TruckDriveEvent = Event.new("TruckDriveEvent")

local animator = nil
function self:ClientAwake()
    animator = self.gameObject:GetComponent(Animator)
    anchor = self.gameObject:GetComponentInChildren(Anchor, false)
    anchor.Entered:Connect(OnAnchorEnter)
    TruckDriveEvent:Connect(function() animator:SetTrigger("StartDriving") end)
end

function OnAnchorEnter(anchor, player)
    if player.name == client.localPlayer.name then
        EnteredAnchor:FireServer()
    end
end

function self:ServerAwake()
    EnteredAnchor:Connect(function() TruckDriveEvent:FireAllClients() end)
end