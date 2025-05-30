--!Type(Module)

--!SerializeField
local mainRaffleUIObj:GameObject=nil
--!SerializeField
local infoUIObj:GameObject=nil

local RaffleManager = require("RaffleManager")
local mainUI = nil
local codesUI = nil

function openInfo()
    infoUIObj.gameObject:SetActive(true)
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
    Timer.After(10, function() RaffleManager.RewardCheckRequest:FireServer() end)
    
    RaffleManager.RewardEvent:Connect(function() 
        print("CLIENT RECEIVED REWARD EVENT")
        -- TO DO: add UI notification pop up
    end)
end