--!Type(Module)
--!SerializeField
local raffleUI:RaffleUI = nil


PrizeCodeEvent = Event.new("PrizeCodeEvent")
SubmitTicket = Event.new("SubmitTicket")

-- [[ CLIENT ]]


function OnPrizeCodeEvent(code)

end



function self:ClientStart()
    PrizeCodeEvent:Connect(OnPrizeCodeEvent)
end

-- [[ SERVER ]]

local raffleTicketsPrefix = "RaffleTickets"

local yesterdayWinners = ""

local prizeCodesKey = "testcodes"
local prizeCodeIndexKey = "testCodeIndex"
local prizeCodes = {}
local currentIndex = 1


function GetDateString()
    local currentTime = os.date("!*t")

    return string.format("%d-%02d-%02d", currentTime.year,currentTime.month,  currentTime.day)
end

function AddPlayerTicketToStorage(player)
    todaysTickets = raffleTicketsPrefix .. GetDateString()
    Storage.GetValue(todaysTickets, function(value, err) 
        if value == nil then 
            newTickets = {}
        else
            newTickets = value
        end
        table.insert(newTickets, player.name)
        Storage.SetValue(todaysTickets, newTickets)
        print("TICKET ADDED FOR: " .. player.name)
    end)
    Storage.GetPlayerValue(player, todaysTickets, function(value, err) 
        if value == nil then
            value = 0
        end
        Storage.SetPlayerValue(player, todaysTickets, value+1)
    end)
end


function GetCodeListFromStorage()
    Storage.GetValue(prizeCodesKey, function(value, error) 
        prizeCodes = value
        print(prizeCodes[1])
    end)
end

function GetCodeIndexFromStorage()
    Storage.GetValue(prizeCodeIndexKey, function(value, error) 
        currentIndex = value
    end)
end

function SaveCodeIndex()
    Storage.SetValue(prizeCodeIndexKey, currentIndex)
end

function OnSubmitTicketRequest(player, ticketCount)
    for i=1,ticketCount do 
        AddPlayerTicketToStorage(player)
    end
end

function self:ServerStart()
    GetCodeListFromStorage()
    SubmitTicket:Connect(OnSubmitTicketRequest)
    Timer.Every(1, SaveCodeIndex)

end