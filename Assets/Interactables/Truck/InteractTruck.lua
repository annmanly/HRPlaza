--!Type(Client)
local animator = nil
function self:ClientAwake()
    animator = self.gameObject:GetComponent(Animator)
    anchor = self.gameObject:GetComponentInChildren(Anchor, false)
    anchor.Entered:Connect(OnAnchorEnter)
end

function OnAnchorEnter()

    animator:SetTrigger("StartDriving")
    
end