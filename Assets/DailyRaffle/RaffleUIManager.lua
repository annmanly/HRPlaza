--!Type(Module)

--!SerializeField
local mainRaffleUIObj:GameObject=nil
--!SerializeField
local infoUIObj:GameObject=nil
--!SerializeField
local codesUIObj:GameObject=nil

local RaffleManager = require("RaffleManager")
local mainUI = nil
local codesUI = nil

function openInfo()
    infoUIObj.gameObject:SetActive(true)
end

function openCodes()
    codesUIObj.gameObject:SetActive(true)
    -- TO DO: add actual promo codes
end

function openMainUI()
    mainRaffleUIObj.gameObject:SetActive(true)
    RaffleManager.TicketCountRequest:FireServer()

end

function setMainUiTicketCount(count)
    if mainUI and mainRaffleUIObj.activeInHierarchy then
        mainUI.setTicketCount(count)
    end
end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(openMainUI)
    mainUI = mainRaffleUIObj.gameObject:GetComponent(RaffleUI)
    RaffleManager.TicketCountResponse:Connect(setMainUiTicketCount)
    RaffleManager.TicketCountRequest:FireServer()
end