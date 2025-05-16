--!Type(Module)

--!SerializeField
local mainRaffleUI:GameObject=nil
--!SerializeField
local infoUI:GameObject=nil
--!SerializeField
local codesUI:GameObject=nil

function openInfo()
    infoUI.gameObject:SetActive(true)
end

function openCodes()
    codesUI.gameObject:SetActive(true)
    -- TO DO: add actual promo codes
end

function openMainUI()
    mainRaffleUI.gameObject:SetActive(true)
    -- TO DO: add actual promo codes
end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(openMainUI)
end