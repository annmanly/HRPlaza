--!Type(Module)
--!SerializeField
local raffleUI:RaffleUI = nil


SubmitTicket = Event.new("SubmitTicket")
TicketCountRequest = Event.new("TicketCountRequest")
TicketCountResponse = Event.new("TicketCountResponse")
RewardCheckRequest = Event.new("RewardCheckRequest")
RewardEvent = Event.new("RewardEvent")
UIRaffleWinnerEvent = Event.new("RaffleWinnerEvent")
UIRaffleDrawingEvent = Event.new("UIDrawingEvent")
SpawnRaffleTicketEvent = Event.new("SpawnRaffleTicketEvent")
ClaimBlindBoxRequest = Event.new("ClaimBlindBoxRequest")

local ServerPrankModule = require("ServerPrankModule")



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


-- [[ SERVER ]]

local raffleTicketsPrefix = "RaffleTickets_"
local winnersPrefix = "WINNERS_"
local currentDate = nil
local tickets = {}
local ticketCount = 0
local uniquePlayerCount = 0
local GeneratingTicketsDone = Event.new("GeneratingTicketsDone")
local playerCooldowns = {}

-- [ RAFFLE CONFIGURATION ]
local numberOfWinners = 100
local spawnInterval = 120 
local forcedDraw = false 

function OnSubmitTicketRequest(player, ticketCount)
    if playerCooldowns[player] then 
        if playerCooldowns[player] <= 0 then 
            for i=1,ticketCount do 
                playerCooldowns[player] = spawnInterval
                AddTicketToLeaderboard(player)
            end
        else
            -- print(`[RAFFLE] PLAYER COLLECTED TICKET BEFORE COOLDOWN: {player.name}`)
        end
    else
        playerCooldowns[player] = spawnInterval
        for i=1,ticketCount do 
            AddTicketToLeaderboard(player)
        end
    end

end

function AddTicketToLeaderboard(player)
    todaysTickets = raffleTicketsPrefix .. GetTodayDateString()
    Leaderboard.IncrementScoreForPlayer(todaysTickets, player, 1, function(entry, error)  
        -- print(`[RAFFLE] TICKET ADDED FOR: {player.name} TOTAL TICKETS: {entry.score}`)
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

    local yesterday = GetDateStringWithOffset(-1)
    local ticketsKey = raffleTicketsPrefix .. yesterday
    winnerKey = winnersPrefix .. yesterday
    Storage.GetValue(winnerKey, function(value, err) 
        if value == nil or forcedDraw == true then
            local now = os.date("!*t")
            local serverID = server.info.roomId
            WinnerEntry = {
                status = "drawing",
                drawTime = GetNowDateStamp(),
                finishTime = "00:00:00",
                server = serverID,
                uniqueplayercount = 0,
                winners = {}
            }
            Storage.SetValue(winnerKey, WinnerEntry)
            print(`[RAFFLE] SERVER INIATING RAFFLE DRAW.`)
            -- INITIATE RAFFLE DRAW
            tickets = {}
            ticketCount = 0
            GenerateTicketsForDraw(1, ticketsKey)
        else
            if value.status == "complete" then
                
                winners = value.winners
                winnerNames = {}
                for i, winner in winners do
                    table.insert(winnerNames, winner.name)
                end
                print("[RAFFLE] WINNERS ALREADY DRAWN: " .. table.concat(winnerNames, ", "))
                -- DisplayWinners(winnerNames)
                CheckWinnersInRoom()
                return
            
            elseif value.status =="drawing" or value.status == "error" then
                Timer.After(10, InitiateDraw)
                return
            elseif value.status =="error-no-entries" then
                print("[RAFFLE] [ERROR] NO WINNERS / NO ENTRIES " .. yesterday)
                return
            end

        end


        
    end)

end


function GenerateTicketsForDraw(i, key)

    local step = 10
    local maxTicketsPerPlayer = math.ceil((24*60*60) / spawnInterval)
    
    Leaderboard.GetEntries(key, i, step, function(entries, err) 
        if err ~= LeaderboardError.None then
            error(`RAFFLE LEADERBOARD ERROR {LeaderboardError[err]}`)
        end
        if entries == nil or #entries ==  0 then
            GeneratingTicketsDone:Fire()
            return
        else
            for i,entry in pairs(entries) do
                -- print(`[RAFFLE] REGISTERING TICKET(S): {entry.name} {entry.score}`)
                if entry.score <= maxTicketsPerPlayer then
                    playerTicket = {id = entry.id, name = entry.name, score=entry.score}
                    uniquePlayerCount += 1
                    ticketCount += entry.score
                    table.insert(tickets, playerTicket)
                end
            end
            if #entries < step then
                GeneratingTicketsDone:Fire()
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

function AddWinnersToStorage(winners, date, uniqueCount)
    winnerKey = winnersPrefix .. date
    
    Storage.GetValue(winnerKey, function(value, err) 
        if err ~= StorageError.None then
            error(`Storage Error - {StorageError[err]} when reading winners entry {winnerKey}`)
        else
            winnerEntryUpdate = value
            winnerEntryUpdate.winners = winners
            winnerEntryUpdate.uniqueplayercount = uniqueCount
            winnerEntryUpdate.finishTime = GetNowDateStamp()
            if winners == {} or winners == nil or #winners == 0 then 
                print(`[ERROR] No winners selected.`)
                winnerEntryUpdate.status = "error-no-entries"
            else
                winnerEntryUpdate.status = "complete"
            end

            Storage.SetValue(winnerKey, winnerEntryUpdate, function(err) 
                 if err ~= StorageError.None then
                    error(`Storage Error - {StorageError[err]} when setting winners`)
                 end
            end)
        end
    end)
    
end

function SelectWinners()

    local yesterday = GetDateStringWithOffset(-1)
    winnerCount = numberOfWinners
    if uniquePlayerCount <= numberOfWinners then winnerCount = uniquePlayerCount end
    print(`[RAFFLE] SELECTING WINNNERS. {ticketCount} TOTAL TICKETS |  {uniquePlayerCount} UNIQUE PLAYERS | {winnerCount} WINNERS`)
    winners = {}
    winnerNames = {}
    for i=1,winnerCount do
        if ticketCount == 0 then
            break
        end

        choice = math.random(1, ticketCount)
        for k,ticket in ipairs(tickets) do
            
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
                -- print(`[RAFFLE] TICKET {initchoice} WINNER: {winnerEntry.name}`)
                Storage.SetValue(winnerEntry.id .. "/RewardReady", true)
                Leaderboard.IncrementScore("RaffleWinners", winnerEntry.id, winnerEntry.name, 1, function() end)
                break
            end
        end
    end

    print("[RAFFLE] WINNERS SELECTED: " .. table.concat(winnerNames, ", "))
    AddWinnersToStorage(winners, yesterday, uniquePlayerCount)
    CheckWinnersInRoom()
end

function CheckIfRewardReady(player)
    Storage.GetPlayerValue(player, "RewardReady", function(value, err) 
        if value == true then
            DisplayWinnerPopUp(player)
        end
    end)
end


function CheckWinnersInRoom()
    playersInRoom = server.players
    for i, player in playersInRoom do
        Storage.GetPlayerValue(player, "RewardReady", function(value, err) 
            if value == true then
                DisplayWinnerPopUp(player)
            end
        end)

    end
end

function OnClaimBoxRequest(player)
    Storage.GetPlayerValue(player, "RewardReady", function(value, err) 
        if value == true then
            print(`AWARDING BOX`)
            GivePrizeCurrency(player)
        end
    end)
end

function DisplayWinnerPopUp(player)
    -- if not player.isDisconnected then 
        UIRaffleWinnerEvent:FireClient(player) -- display notif
    -- end

end

function GivePrizeCurrency(player)
    -- if not player.isDisconnected then 
    Storage.SetPlayerValue(player, "RewardReady", false)
    RewardEvent:FireClient(player)
    print(`[RAFFLE] PLACEHOLDER AWARD PRIZE CURRENCY TO {player.name}`)
    ServerPrankModule.GiveItemsToPlayer(player)
    -- end
end


function self:ServerStart()

    SubmitTicket:Connect(OnSubmitTicketRequest)
    TicketCountRequest:Connect(OnTicketCountRequest)
    RewardCheckRequest:Connect(CheckIfRewardReady)
    GeneratingTicketsDone:Connect(SelectWinners)
    ClaimBlindBoxRequest:Connect(OnClaimBoxRequest)

    --- REMOVE AFTER DONE TESTING -- 
    -- Timer.After(10, function() InitiateDraw() end)
    ------------------------------
    -- Storage.SetValue("589802ad0b911bb89a71a1fe".. "/RewardReady", true)
    -- Storage.SetValue("62fb30c5132e425314f6758f".. "/RewardReady", true)

    currentDate = os.date("!*t")
    Timer.Every(1, function() 
        date =  os.date("!*t")
        if date.day ~= currentDate.day then
            -- START RAFFLE DRAW ON UTC DAY RESET
            currentDate = os.date("!*t")
            UIRaffleDrawingEvent:FireAllClients()
            InitiateDraw()
        end

        for player in playerCooldowns do
            playerCooldowns[player] -= 1
        end
    end)

    Timer.Every(spawnInterval, function() 
        SpawnRaffleTicketEvent:FireAllClients() 
        
        for player, cooldown in playerCooldowns do
            playerCooldowns[player] = 0
        end
    end)
    
    SpawnRaffleTicketEvent:FireAllClients()

    server.PlayerDisconnected:Connect(function(player) 
        playerCooldowns[player] = nil
    end)

end