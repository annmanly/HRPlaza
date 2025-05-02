--!Type(Client)
--!SerializeField
local fountainInteractUI:GameObject = nil

function self:OnTriggerEnter(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character then
            fountainInteractUI:SetActive(true)
        end
    end
end

function self:OnTriggerExit(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character then
            fountainInteractUI:SetActive(false)
        end
    end
end