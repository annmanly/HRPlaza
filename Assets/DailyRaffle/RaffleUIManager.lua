--!Type(Module)

--!SerializeField
local mainRaffleUIObj:GameObject=nil
--!SerializeField
local infoUIObj:GameObject=nil
--!SerializeField
local notificationObj:GameObject=nil
--!SerializeField
local winnerNotifObj:GameObject=nil
--!SerializeField
local winnerParticleObj:GameObject=nil

local RaffleManager = require("RaffleManager")
local mainUI = nil
local codesUI = nil
local mainCamera = scene.mainCamera

local particleTransformPos = Vector3.new(-0.00700000022,0.00100000005,0.989000022)

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

function closeParticles() 
    winnerParticleObj:SetActive(false)
end

function displayWinner()
    winnerParticleObj.transform:SetParent(mainCamera.gameObject.transform)
    winnerParticleObj.transform.localPosition = particleTransformPos
    winnerNotifObj:SetActive(true)
    winnerParticleObj:SetActive(true)
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