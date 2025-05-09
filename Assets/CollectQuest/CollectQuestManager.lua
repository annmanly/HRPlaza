--!Type(Module)
--!SerializeField
local questCountUI:CollectStatus = nil
--!SerializeField
local chatbubbles:GameObject = nil


DropOffRequest = Event.new("DropOffRequest")
DropOffConfirmed = Event.new("DropOffConfirmed")
CountRequest = Event.new("CountRequest")
QuestCountUpdateEvent = Event.new("EventCountUpdate")
PrizeCodeEvent = Event.new("PrizeCodeEvent")


-- [[ CLIENT ]]

function UpdateCollectUI(countText)
    questCountUI.updateCount(countText)
end

function OnPrizeCodeEvent(code)
    bubblePosition = chatbubbles.gameObject.transform
    message = "YOU DID IT! Here's a code to your prize: " .. string.format(code)
    Chat:DisplayChatBubble(bubblePosition, message, "Shelly")
    
    Chat:DisplayTextMessage(Chat:GetChannel("General Chat"), client.localPlayer, "PRIZE PROMO CODE: " .. string.format(code), "en")
    Chat:DisplayTextMessage(Chat:GetChannel("General Chat"), client.localPlayer, "Go to highrise.game/account/redeem-promo-code to redeem your code!", "en")
end

function OnDropOff()
    bubblePosition = chatbubbles.gameObject.transform
    Chat:DisplayChatBubble(bubblePosition, "Thank you!", "Shelly")
end

function self:ClientStart()
    QuestCountUpdateEvent:Connect(UpdateCollectUI)
    CountRequest:FireServer()
    DropOffConfirmed:Connect(OnDropOff)
    PrizeCodeEvent:Connect(OnPrizeCodeEvent)
end

-- [[ SERVER ]]
local itemGoal = 2
local currentCount = 0
local participatingPlayers = {}
local prizeCodesKey = "testcodes"
local prizeCodeIndexKey = "testCodeIndex"
local prizeCodes = {}
local currentIndex = 1
local questComplete = false

function AddToParticipatingPlayers(player)
    if not participatingPlayers[player.name] then
        participatingPlayers[player.name] = player
        -- print("ADDED CHARACTER TO RANGE: " .. player.name)
    end

end

function pullCodeListFromStorage()
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

function CollectQuestComplete()
    -- TO DO: have some sort of check / warning when there aren't enough codes to give
    for name, player in participatingPlayers do
        if player then
            if not player.isDestroyed then
                code = prizeCodes[currentIndex]
                print("SELECTED CODE: " .. code)
                currentIndex += 1
                PrizeCodeEvent:FireClient(player, code)
            end
        end
    end
    participatingPlayers = {}
    questComplete = false
    currentCount = 0

end

function UpdateCount(newCount)
    questCount = newCount .. "/" .. itemGoal
    QuestCountUpdateEvent:FireAllClients(questCount)
end

function OnCollectDropOff(player)
    currentCount = currentCount + 1
    UpdateCount(currentCount)
    AddToParticipatingPlayers(player)
    DropOffConfirmed:FireClient(player)

    if currentCount >= itemGoal then 
        if not questComplete then
            CollectQuestComplete()
            Timer.After(2, UpdateCount(0))
        end
        currentCount = itemGoal 
        -- TO DO: ADD REWARD FOR COMPLETING COLLECT QUEST
    end

   
end

function OnCountRequest(player)
    questCount = currentCount .. "/" .. itemGoal
    QuestCountUpdateEvent:FireClient(player, questCount)
end

function self:ServerStart()
    DropOffRequest:Connect(OnCollectDropOff)
    CountRequest:Connect(OnCountRequest)
    pullCodeListFromStorage()
    Timer.Every(1, SaveCodeIndex)
end