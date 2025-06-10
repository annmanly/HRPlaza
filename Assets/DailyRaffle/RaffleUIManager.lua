--!Type(Module)

--!SerializeField
local mainRaffleUIObj:GameObject=nil
--!SerializeField
local infoUIObj:GameObject=nil
--!SerializeField
local winnerNotifObj:GameObject=nil
--!SerializeField
local winnerParticleObj:GameObject=nil
--!SerializeField
local sparklesOneshotObj:GameObject=nil
--!SerializeField
local resultsObj:GameObject=nil

ClaimBoxRequest = Event.new("ClaimBoxRequest")
local RaffleManager = require("RaffleManager")
local mainUI = nil
local codesUI = nil
local mainCamera = scene.mainCamera

local particleTransformPos = Vector3.new(-0.00999999978,0.0700000003,0.959999979)

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

function activateParticles()
    if winnerParticleObj then
        winnerParticleObj.transform:SetParent(mainCamera.gameObject.transform)
        winnerParticleObj.transform.localPosition = particleTransformPos
        winnerParticleObj:SetActive(true)
    end
end

function sparklesOneshot()
    if sparklesOneshotObj then
        pos = Vector3.new(0,0.211999997,0.894999981)
        sparklesOneshotObj.transform:SetParent(mainCamera.gameObject.transform)
        sparklesOneshotObj.transform.localPosition = pos
        sparklesOneshotObj:SetActive(true)
        Timer.After(20, function() sparklesOneshotObj:SetActive(false) end)
    end
end

function closeParticles() 
    winnerParticleObj:SetActive(false)
end

function displayWinner()
    activateParticles()

    winnerNotifObj:SetActive(true)
end

function displayDrawingWinners(winners)
    resultsObj:SetActive(true)
    resultsUI = resultsObj.gameObject:GetComponent(Results).showWinners(winners)
end

function self:ClientAwake()
    mainUI = mainRaffleUIObj.gameObject:GetComponent(RaffleUI)
    RaffleManager.TicketCountResponse:Connect(setMainUiTicketCount)
    RaffleManager.UIRaffleWinnerEvent:Connect(displayWinner)
    RaffleManager.UIRaffleDrawingEvent:Connect(displayDrawingWinners)
    RaffleManager.TicketCountRequest:FireServer()

    ClaimBoxRequest:Connect(function() RaffleManager.ClaimBlindBoxRequest:FireServer() end)
    Timer.After(2, function() RaffleManager.RewardCheckRequest:FireServer() end)
    RaffleManager.RewardEvent:Connect(function() 
        print("CLIENT RECEIVED REWARD EVENT")
        -- TO DO: add UI notification pop up
    end)
end