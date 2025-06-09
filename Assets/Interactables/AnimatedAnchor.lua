--!Type(Client)

--!SerializeField
local enterTriggerName:string = ""
--!SerializeField
local exitTriggerName:string = ""

--!SerializeField
local randomizeStartIdle:boolean =true

local animator = nil
local anchor = nil

function self:ClientAwake()
    animator = self.gameObject:GetComponent(Animator)
    
    if animator and randomizeStartIdle then animator:Play(0,-1, Random.value) end
    
    anchor = self.gameObject:GetComponentInChildren(Anchor, false)
    
    if anchor then 
        if enterTriggerName ~= "" then 
            anchor.Entered:Connect(function(anchor, player)
                if animator then 
                    animator:SetTrigger(enterTriggerName) 
                end
            end)
        end 
        if enterTriggerName ~= "" then 
            anchor.Exited:Connect(function(anchor, player)
                if animator then 
                        animator:SetTrigger(exitTriggerName)
                end
            end)
        end
    end

end
