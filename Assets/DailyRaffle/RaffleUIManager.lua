--!Type(Module)

--!SerializeField
local mainRaffleUIObj:GameObject=nil
--!SerializeField
local infoUIObj:GameObject=nil
--!SerializeField
local notificationObj:GameObject=nil
--!SerializeField
local winnerNotifObj:GameObject=nil

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

function displayWinner()
    winnerNotifObj:SetActive(true)
end

function displayDrawingWinners()

end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(openMainUI)
    mainUI = mainRaffleUIObj.gameObject:GetComponent(RaffleUI)
    RaffleManager.TicketCountResponse:Connect(setMainUiTicketCount)
    RaffleManager.UIRaffleWinnerEvent:Connect(displayWinner)
    RaffleManager.UIRaffleDrawingEvent:Connect(displayDrawingWinners)
    RaffleManager.TicketCountRequest:FireServer()
    Timer.After(10, function() RaffleManager.RewardCheckRequest:FireServer() end)
    
    RaffleManager.RewardEvent:Connect(function() 
        print("CLIENT RECEIVED REWARD EVENT")
        -- TO DO: add UI notification pop up
    end)
end