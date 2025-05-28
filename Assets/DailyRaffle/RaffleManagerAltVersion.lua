--!Type(Module)
--!SerializeField
local raffleUI:RaffleUI = nil

SubmitTicket = Event.new("SubmitTicket")
TicketCountRequest = Event.new("TicketCountRequest")
TicketCountResponse = Event.new("TicketCountResponse")
RewardCheckRequest = Event.new("RewardCheckRequest")
RewardEvent = Event.new("RewardEvent")


-- [[ HELPERS ]]

function GetTodayDateString() 
    local currentDate = os.date("!*t")
    return string.format("%d-%02d-%02d", currentDate.year,currentDate.month, currentDate.day)
end

function GetDateStringWithOffset(offsetDays) 
    local currentTime = os.time(os.date("!*t"))
    local day = currentTime + (offsetDays * (24*60*60))
    local date = os.date("!*t", day)
    return string.format("%d-%02d-%02d", date.year,date.month, date.day)
end

-- [[ CLIENT ]]

function self:ClientStart()

end

-- [[ SERVER ]]

local raffleTicketsPrefix = "RaffleTickets_"
local currentDate = nil
local tickets = {}
local GeneratingTicketsDone = Event.new("GeneratingTicketsDone")

-- [ RAFFLE CONFIGURATION ]
local numberOfWinners = 2

function OnSubmitTicketRequest(player, ticketCount)
    for i=1,ticketCount do 
        AddTicketToLeaderboard(player)
    end
end

function AddTicketToLeaderboard(player)
    todaysTickets = raffleTicketsPrefix .. GetTodayDateString()
    Leaderboard.IncrementScoreForPlayer(todaysTickets, player, 1, function(entry, error)  
        print(`TICKET ADDED FOR: {player.name} TOTAL TICKETS: {entry.score}`)
    end)
end

function OnTicketCountRequest(player)
    todaysTickets = raffleTicketsPrefix .. GetTodayDateString()
    Leaderboard.GetEntryForPlayer(todaysTickets, player, function(entry, err) 
        if entry then
            TicketCountResponse:FireClient(player, entry.score)
        else
            TicketCountResponse:FireClient(player, 0)
        end
    end)
end

function InitiateDraw()
    date = GetDateStringWithOffset(-1)
    winnerKey = "WINNERS" .. date
    Storage.GetValue(winnerKey, function(value, err) 
        if value ~= nil then
            print("WINNERS ALREADY DRAWN")
        else
            tickets = {}

            -- temp set a value while generating tickets to prevent other
            -- servers from doing redundant draws but not sure if necessary
            Storage.SetValue(winnerKey, {"N/A"})
            
            -- INITIATE RAFFLE DRAW
            GenerateTicketsForDraw(1)
        end
    end)

end


function GenerateTicketsForDraw(i)
    local yesterday = GetDateStringWithOffset(-1)
    local ticketsKey = raffleTicketsPrefix .. yesterday
    -- INCREASE WHEN DONE TESTING
    local step = 1 

    Leaderboard.GetEntries(ticketsKey, i, step, function(entries, err) 
        if entries == {} then
            -- no tickets, no winners selected
            print(`[RAFFLE] NO TICKETS ON DAY: {yesterday}`)
            return
        else
            for i,entry in entries do
                for i=1,entry.score do
                    playerTicket = {id = entry.id, name = entry.name}
                    table.insert(tickets, playerTicket)
                end
            end
            if #entries < step then
                GeneratingTicketsDone:Fire()
                return
            else
                GenerateTicketsForDraw(i+step)
            end
        end
    end)
end

function removePlayerFromTickets(tickets, playerId)
    newTickets = {}
    for i,ticketPlayer in ipairs(tickets) do
        if ticketPlayer.id ~= playerId then 
            table.insert(newTickets,ticketPlayer)
        end
    end
    return newTickets
end

function AddWinnersToStorage(winners, date)
    winnerKey = "WINNERS" .. date
    Storage.SetValue(winnerKey, winners, function(err) end)
end

function OnTicketListDone()
    local yesterday = GetDateStringWithOffset(-1)
    winnerCount = numberOfWinners
    print(`{#tickets} TOTAL TICKETS.`)
    if #tickets <= numberOfWinners then winnerCount = #tickets end

    winners = {}
    winnerNames = {}
    for i=1,winnerCount do
        if #tickets == 0 then
            break
        end

        choice = math.random(1, #tickets)
        winnerEntry = {
            id = tickets[choice].id,
            name = tickets[choice].name
        }
        table.insert(winners, winnerEntry)
        table.insert(winnerNames, winnerEntry.name)
        tickets = removePlayerFromTickets(tickets, winnerEntry.id)
        
        Storage.SetValue(winnerEntry.id .. "/RewardReady", true)

    end

    print("WINNERS SELECTED: " .. table.concat(winnerNames, ", "))
    AddWinnersToStorage(winners, yesterday)
end

function CheckIfRewardReady(player)
    Storage.GetPlayerValue(player, "RewardReady", function(value, err) 
        print("CHECKING PLAYER: " .. player.name)
        if value == true then
            GivePrizeCurrency(player)
        end
    end)
end


function CheckWinnersInRoom()
    playersInRoom = server.players
    for i, player in playersInRoom do
        CheckIfRewardReady(player)
    end
end

function GivePrizeCurrency(player)
    if not player.isDestroyed then
        print(`AWARD PRIZE CURRENCY TO {player.name}`)
        Storage.SetPlayerValue(player, "RewardReady", false)
        RewardEvent:FireClient(player)
    end
end


function self:ServerStart()

    SubmitTicket:Connect(OnSubmitTicketRequest)
    TicketCountRequest:Connect(OnTicketCountRequest)
    RewardCheckRequest:Connect(CheckIfRewardReady)
    GeneratingTicketsDone:Connect(OnTicketListDone)

    --- REMOVE AFTER DONE TESTING -- 
    InitiateDraw()
    Timer.After(10, CheckWinnersInRoom)
    --------------------------------

    currentDate = os.date("!*t")
    Timer.Every(1, function() 
        date =  os.date("!*t")
        if date.day ~= currentDate.day then
            -- START RAFFLE DRAW ON UTC DAY RESET
            currentDate = os.date("!*t")
            InitiateDraw()
            Timer.After(10, CheckWinnersInRoom)
        end
    end)
    

end