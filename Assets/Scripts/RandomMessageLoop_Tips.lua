--!Type(Client)
--!SerializeField
local emoteId:string = "emote-hello"
--!SerializeField
local messageInterval:number = 15 -- time between messages in seconds
local npcName = "Highrise Tips:"

local HelpMessages = {
    "Did you know? You can pin your favorite conversations in your inbox!",
    "SAFETY TIP: Don't share your password with anybody!",
    "Want to earn gold? List items for sale on the marketplace! Go go Shop > Market > My Listings",
	"New user tip: chat in rooms to make get help from other users, and make friends along the way!",
	"Looking for help? Join the Highrise Discord. Check out the poster in front of the Town Hall.",
	"Trading basics: Lock -> Accept -> Complete!",
	"How to join a crew: Go to your profile and tap '+ Join A Crew'. Crew group chat is a great way to get support!",
	"Compete with your crew to earn special event rewards. Find the '+ Join A Crew' button in your profile",
	"Earn items by playing events! New events every Thursday through Tuesday",
	"Bored? Try room hopping: A favorite activity in Highrise",
    "Don't miss a message! Check your Message Requests for messages from non-followed accounts.",
	"Find deals on second-hand items in the Marketplace!",
	"Starter grabs are great for new users. Go to Shop > Grabs or check out the Welcome Center right next door",
	"Hang out by the Welcome Center (Hint: it's right next door!) if you are open to giving or recieving advice",
	"Don't be shy! The best way to learn how to play is making friend"
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




