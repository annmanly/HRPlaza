--!Type(Client)


function self:OnTriggerEnter(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        print("CHARACTER ENTERED TRIGGER")
        characterButterfly = character.gameObject.transform:Find("Butterfly")
        if not characterButterfly.gameObject.activeInHierarchy then 
            characterButterfly.gameObject:SetActive(true)
            Timer.After(30, function() characterButterfly.gameObject:SetActive(false) end)
            self.gameObject:SetActive(false)

        end
    end
end
