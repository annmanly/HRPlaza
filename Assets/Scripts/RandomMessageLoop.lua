--!Type(Client)
--!SerializeField
local emoteId:string = "emote-hello"
--!SerializeField
local messageInterval:number = 15 -- time between messages in seconds
local npcName = "Axl"

local HelpMessages = {
    "Did you know? You can list items for sale on the marketplace!",
    "Did you know? You can pin your favorite converstions in your inbox!",
    "SAFETY TIP: Don't share your password with anybody!"
}

lastIndex = 0

function chooseRandomIndex()
    -- choose random index without repeating last message
    choice = math.random(1, #HelpMessages)
    if choice ~= lastIndex then 
        lastIndex = choice
        return choice
    else
        return chooseRandomIndex()
    end
end

function self:Awake()

    character = self.gameObject:GetComponent(Character)

    character:PlayEmote(emoteId, true)

    bubblePosition = self.gameObject.transform:Find("ChatBubbles").transform

    chosenMessage = HelpMessages[chooseRandomIndex()]
    Chat:DisplayChatBubble(bubblePosition, chosenMessage, npcName)

    Timer.Every(messageInterval, function()  
        chosenMessage = HelpMessages[chooseRandomIndex()]
        Chat:DisplayChatBubble(bubblePosition, chosenMessage, npcName)
    end)
end




