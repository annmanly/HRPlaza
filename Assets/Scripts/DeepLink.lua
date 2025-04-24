--!Type(Client)
--!SerializeField
local linkurl:string = ""

function self:ClientAwake()
    if linkurl ~= "" then
        self.gameObject:GetComponent(TapHandler).Tapped:Connect(OnTap)
    else
        print("NO LINK SPECIFIED")
    end
end

function OnTap()
    UI:ExecuteDeepLink(linkurl)
end