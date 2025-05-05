--!Type(Module)
--!SerializeField
local questCountUI:CollectStatus = nil

DropOffRequest = Event.new("DropOffRequest")
CountRequest = Event.new("CountRequest")
QuestCountUpdateEvent = Event.new("EventCountUpdate")

-- [[ CLIENT ]]

function UpdateCollectUI(countText)
    questCountUI.updateCount(countText)
end

function self:ClientStart()
    QuestCountUpdateEvent:Connect(UpdateCollectUI)
    CountRequest:FireServer()
end

-- [[ SERVER ]]
local itemGoal = 15
local currentCount = 0

function UpdateCount(newCount)
    questCount = newCount .. "/" .. itemGoal
    QuestCountUpdateEvent:FireAllClients(questCount)
end

function OnCollectDropOff()
    currentCount = currentCount + 1
    if currentCount > itemGoal then 
        currentCount = itemGoal 
        -- TO DO: ADD REWARD FOR COMPLETING COLLECT QUEST
    end
    UpdateCount(currentCount)
end

function OnCountRequest(player)
    questCount = currentCount .. "/" .. itemGoal
    QuestCountUpdateEvent:FireClient(player, questCount)
end

function self:ServerStart()
    DropOffRequest:Connect(OnCollectDropOff)
    CountRequest:Connect(OnCountRequest)
end