--!Type(Module)
--!SerializeField
local raffleUI:RaffleUI = nil

local promoCodeCollection = require("PromoCodes")

SubmitTicket = Event.new("SubmitTicket")

WinnersRequest = Event.new("RequestWinners")
PromoCodeRequest = Event.new("RequestPromoCode")
WinnersResponse = Event.new("WinnersResponse")
PromoCodeResponse = Event.new("PromoCodeResponse")
TicketCountRequest = Event.new("TicketCoutnRequest")
TicketCountResponse = Event.new("TicketCountResponse")


-- [[ CLIENT & SERVER ]]

function GetTodayDateString() 
    local currentDate = os.date("!*t")
    return string.format("%d-%02d-%02d", currentDate.year,currentDate.month, currentDate.day)
end

function GetYesterdayDateString() 
    local currentTime = os.time(os.date("!*t"))
    local yesterday = currentTime - (24*60*60)
    local yesterdayDate = os.date("!*t", yesterday)
    return string.format("%d-%02d-%02d", yesterdayDate.year,yesterdayDate.month, yesterdayDate.day)
end

-- [[ CLIENT ]]


function self:ClientStart()
    -- WinnersResponse:Connect(function(winners) print("WINNER DATA RECEIVED") end)
    -- WinnersRequest:FireServer(GetYesterdayDateString())
end

-- [[ SERVER ]]

local raffleTicketsPrefix = "RaffleTickets"
local prizeCodeIndexKey = "codeIndex"
local prizeCodes = {}
local currentIndex = 1
local raffleTicketCount = 0
local currentDate = nil

-- replace with promo code item id
local promoCodeID = "codeID" 

-- RAFFLE CONFIGURATION
local numberOfWinners = 2

function OnSubmitTicketRequest(player, ticketCount)
    for i=1,ticketCount do 
        AddPlayerTicketToStorage(player)
    end
end

function DrawWinners()
    local yesterday = GetYesterdayDateString()
    local ticketsKey = raffleTicketsPrefix .. yesterday
    local winnerKey = "WINNERS" .. yesterday


    Storage.GetValue(winnerKey, function(value, err) 
        if value then
            print("WINNERS ALREADY DRAWN")
        else
            Storage.GetValue(ticketsKey, function(value, err) 
                if value == nil then 
                    print("NO TICKETS FOUND FOR: " .. ticketsKey)
                    return {}
                else
                    winnerCount = numberOfWinners
                    tickets = value

                    if #tickets <= numberOfWinners then winnerCount = #tickets end
        
                    winners = {}
                    winnerNames = {}
                    for i=1,winnerCount do
                        if #tickets == 0 then
                            break
                        end

                        choice = math.random(1, #tickets)

                        table.insert(winners, tickets[choice])
                        table.insert(winnerNames, tickets[choice][2])

                        GeneratePlayerPromoCode(tickets[choice][1])

                        tickets = removePlayerFromTickets(tickets, tickets[choice])
                        
                    end

                    print("WINNERS SELECTED: " .. table.concat(winnerNames, ", "))
                    AddWinnersToStorage(winners, yesterday)
                end
            end)
        end
    end)


end

function OnPromoCodeRequest(player)
    Storage.GetValue(player .."/promocodes", function(value, error) 
        if error then
            print(`Promo code request -- STORAGE ERROR {StorageError[error]}`)
            return
        end

        if value then
            PromoCodeResponse:FireClient(player, value)
        end
    end)
end



function GeneratePlayerPromoCode(playerid)
    if currentIndex > #prizeCodes then
        print("ERROR: NO MORE PROMO CODES")
        return
    end

    newCode = prizeCodes[currentIndex]
    currentIndex += 1

    Storage.GetValue(playerid .. "/promocodes", function(value, error) 
        if not value then 
            codes = {}
        else
            codes = value
        end 

        codes[promoCodeID] = newCode

        Storage.SetValue(playerid .. "/promocodes", codes)
    end)
    
end


function OnWinnerRequest(client, date)
    print("RECEIVED REQUEST FROM " .. client.user.name)
    local winnerKey = "WINNERS" .. date
    Storage.GetValue(winnerKey, function(value, err) 
        if value then
            WinnersResponse:FireClient(client, value)
        end
    end)
end

function OnTicketCountRequest(player)
    todaysTickets = raffleTicketsPrefix .. GetTodayDateString()

    Storage.GetPlayerValue(player, todaysTickets, function(value, err) 
        if value then
            TicketCountResponse:FireClient(player, value)
        else
            TicketCountResponse:FireClient(player, 0)
        end
    end)
end


function removePlayerFromTickets(tickets, player)
    newTickets = {}
    for i,ticketPlayer in ipairs(tickets) do
        if ticketPlayer[1] ~= player[1] then
            table.insert(newTickets,ticketPlayer)
        end
    end
    return newTickets
end

function AddWinnersToStorage(winners, date)
    winnerKey = "WINNERS" .. date
    Storage.SetValue(winnerKey, winners, function(err) end)
end

function AddPlayerTicketToStorage(player)
    todaysTickets = raffleTicketsPrefix .. GetTodayDateString()
    Storage.GetValue(todaysTickets, function(value, err) 
        if value == nil then 
            newTickets = {}
        else
            newTickets = value
        end
        table.insert(newTickets, {player.user.id, player.user.name})
        Storage.SetValue(todaysTickets, newTickets)
        print("TICKET ADDED FOR: " .. player.name .. "TOTAL TICKETS: " .. #newTickets)
    end)
    Storage.GetPlayerValue(player, todaysTickets, function(value, err) 
        if value == nil then
            value = 0
        end
        Storage.SetPlayerValue(player, todaysTickets, value+1)
    end)
end

function GetCodeList()
    return promoCodeCollection.promoCodes[promoCodeID]
end


function GetCodeListFromStorage()
    Storage.GetValue("PROMOCODES_" .. promoCodeID, function(value, error) 
        prizeCodes = value
        if not value then 
            print("NO CODES FOUND FOR KEY: " .. promoCodeID)
            default = {""}
            Storage.SetValue("PROMOCODES_" .. promoCodeID, default)
        end
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

function self:ServerStart()
    GetCodeListFromStorage()
    SubmitTicket:Connect(OnSubmitTicketRequest)
    WinnersRequest:Connect(OnWinnerRequest)
    TicketCountRequest:Connect(OnTicketCountRequest)
    DrawWinners()

    currentDate = os.date("!*t")
    Timer.Every(1, function() 
        SaveCodeIndex()
        date =  os.date("!*t")
        if date.day ~= currentDate.day then
            currentDate = os.date("!*t")
            DrawWinners()
        end
    end)
end