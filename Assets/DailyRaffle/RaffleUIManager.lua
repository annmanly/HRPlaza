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
function closeInfo()
    infoUIObj.gameObject:SetActive(false)
end

function openCodes()
    -- TO DO: sync actual promo codes
    codesUIObj.gameObject:SetActive(true)
    closeInfo()
    closeMainUI()

end
function closeCodes()
    codesUIObj.gameObject:SetActive(false)
end


function openMainUI()
    mainRaffleUIObj.gameObject:SetActive(true)
    RaffleManager.TicketCountRequest:FireServer()
    closeCodes()
    closeInfo()
end

function closeMainUI()
    mainRaffleUIObj.gameObject:SetActive(false)
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
end