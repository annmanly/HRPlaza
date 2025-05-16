--!Type(Client)
local raffleManager = require("RaffleManager")
--!SerializeField
local ticketValue:number = 1
--!SerializeField
local popUPObj:GameObject = nil
--!SerializeField
local mainObj:GameObject = nil
--!SerializeField
local ticketObj:GameObject = nil
local speed = 2
local timer = 0

local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween

local plusTicketPopOut = Tween:new(
    .25,
    0,
    .3,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        popUPObj.gameObject.transform.localScale = Vector3.new(value,value,value)
    end,
    function()
        self.gameObject:SetActive(false)
    end
)

local plusTicketPopIn = Tween:new(
    0,
    .25,
    .25,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        popUPObj.gameObject.transform.localScale = Vector3.new(value,value,value)
    end,
    function()
        Timer.After(1.25, function() plusTicketPopOut:start() end)
    end
)


function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(OnTapped)
end

function OnTapped()
    if ticketObj.activeInHierarchy then
        raffleManager.SubmitTicket:FireServer(ticketValue)
        print("TICKET COLLECTED")
        ticketObj.gameObject:SetActive(false)
        mainObj.gameObject:SetActive(false)
        popUPObj.gameObject:SetActive(true)
        plusTicketPopIn:start()
    end
    
end


function self:Update()
    if mainObj.activeInHierarchy then
        self.gameObject.transform.position += self.gameObject.transform.forward * speed * Time.deltaTime
    end
end