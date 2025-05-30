--!Type(Module)
--!SerializeField
local raffleUI:RaffleUI = nil

SubmitTicket = Event.new("SubmitTicket")
TicketCountRequest = Event.new("TicketCountRequest")
TicketCountResponse = Event.new("TicketCountResponse")
RewardCheckRequest = Event.new("RewardCheckRequest")
RewardEvent = Event.new("RewardEvent")


-- [[ HELPERS ]]

function GetNowDateStamp()
    local now = os.date("!*t")
    return string.format("%d-%02d-%02d %02d:%02d:%02d", now.year,now.month, now.day, now.hour, now.min, now.sec)
end

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
local winnersPrefix = "WINNERS_"
local currentDate = nil
local tickets = {}
local ticketCount = 0
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
    -- CHANGE TO -1 WHEN DONE TESTING
    local yesterday = GetDateStringWithOffset(0)
    local ticketsKey = raffleTicketsPrefix .. yesterday

    winnerKey = winnersPrefix .. yesterday
    Storage.GetValue(winnerKey, function(value, err) 
        if value ~= nil then
            if value.status == "complete" then
                print("WINNERS ALREADY DRAWN")
                return
            end
        end

        local now = os.date("!*t")
        local serverID = server.info.roomId
        WinnerEntry = {
            status = "drawing",
            drawTime = GetNowDateStamp(),
            finishTime = "00:00:00",
            server = serverID,
            winners = {}
        }
        Storage.SetValue(winnerKey, WinnerEntry)
        
        -- INITIATE RAFFLE DRAW
        tickets = {}
        ticketCount = 0
        GenerateTicketsForDraw(1, ticketsKey)
        
    end)

end


function GenerateTicketsForDraw(i, key)

    -- INCREASE WHEN DONE TESTING
    local step = 1 

    Leaderboard.GetEntries(key, i, step, function(entries, err) 
        if entries == nil or #entries ==  0 then
            GeneratingTicketsDone:Fire()
            return
        else
            for i,entry in pairs(entries) do
                playerTicket = {id = entry.id, name = entry.name, score=entry.score}
                ticketCount += entry.score
                table.insert(tickets, playerTicket)
            end
            if #entries < step then
                
                return
            else
                GenerateTicketsForDraw(i+step, key)
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
    winnerKey = winnersPrefix .. date
    
    Storage.GetValue(winnerKey, function(value, err) 
        if err ~= StorageError.None then
            print(`[ERROR] Storage Error - {StorageError[err]} when reading winners entry {winnerKey}`)
        else
            winnerEntryUpdate = value
            winnerEntryUpdate.winners = winners
            winnerEntryUpdate.finishTime = GetNowDateStamp()
            if winners == {} then 
                print(`[ERROR] No winners selected.`)
                winnerEntryUpdate.status = "error"
            else
                winnerEntryUpdate.status = "complete"
            end

            Storage.SetValue(winnerKey, winnerEntryUpdate, function(err) 
                 if err ~= StorageError.None then
                    print(`[ERROR] Storage Error - {StorageError[err]} when setting winners`)
                 end
            end)
        end
    end)
    
end

function SelectWinners()
    -- CHANGE TO -1 WHEN DONE TESTING
    local yesterday = GetDateStringWithOffset(0)
    winnerCount = numberOfWinners
    print(`{ticketCount} TOTAL TICKETS.`)
    if ticketCount <= numberOfWinners then winnerCount = ticketCount end

    winners = {}
    winnerNames = {}
    for i=1,winnerCount do
        if ticketCount == 0 then
            -- print("NO MORE TICKETS")
            break
        end

        choice = math.random(1, ticketCount)
        for k,ticket in pairs(tickets) do
            initchoice = choice
            choice = choice - ticket.score
            if choice <= 0 then
                ticketCount -= ticket.score
                winnerEntry = {
                    id = ticket.id,
                    name = ticket.name
                }
                table.insert(winners, winnerEntry)
                table.insert(winnerNames, winnerEntry.name)
                tickets[k].score = 0
                print(`TICKET {initchoice} WINNER: {winnerEntry.name}`)
                Storage.SetValue(winnerEntry.id .. "/RewardReady", true)
            
            break
            end
        end
    end

    print("WINNERS SELECTED: " .. table.concat(winnerNames, ", "))
    AddWinnersToStorage(winners, yesterday)
end

function CheckIfRewardReady(player)
    Storage.GetPlayerValue(player, "RewardReady", function(value, err) 
        -- print("CHECKING PLAYER: " .. player.name)
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
    GeneratingTicketsDone:Connect(SelectWinners)

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