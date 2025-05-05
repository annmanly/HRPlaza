--!Type(Client)

local questManager = require("CollectQuestManager")

function self:OnTriggerEnter(collider: Collider)
    print(" DROP OFF TRIGGERED")
    character = collider.gameObject:GetComponent(Character)
    if character then
        characterButterfly = character.gameObject.transform:Find("Butterfly")
        if characterButterfly.gameObject.activeInHierarchy then 
            character.gameObject.transform:Find("Butterfly").gameObject:SetActive(false)
            if character == client.localPlayer.character then
                questManager.DropOffRequest:FireServer()
            end
        end
    end
end
