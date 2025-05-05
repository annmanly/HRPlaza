--!Type(Client)


function self:OnTriggerEnter(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        characterButterfly = character.gameObject.transform:Find("Butterfly")
        if not characterButterfly.gameObject.activeInHierarchy then 
            character.gameObject.transform:Find("Butterfly").gameObject:SetActive(true)
            self.gameObject:SetActive(false)
        end
    end
end
