--!Type(Client)
local raffleManager = require("RaffleManager")
--!SerializeField
local ticketValue:number = 1

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(OnTapped)
end

function OnTapped()
    raffleManager.SubmitTicket:FireServer(ticketValue)
    print("TICKET COLLECTED")
    self.gameObject:SetActive(false)
end
