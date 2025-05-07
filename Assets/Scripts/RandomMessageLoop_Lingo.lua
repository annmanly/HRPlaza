--!Type(Client)
--!SerializeField
local emoteId:string = "emote-hello"
--!SerializeField
local messageInterval:number = 15 -- time between messages in seconds
local npcName = "Highrise Lingo:"

local HelpMessages = {
    "Floor - Referring to the lowest price of an available item",
    "LF - Looking for", 
    "NFS - Not for sale", 
    "NSB - No Starting Bid.     SB - Starting bid", 
    "Pag - Pageant", 
    "NS - No sale", 
    "G - Gold", 
    "OPT - Overpriced Trade.    G + OPT - Gold plus Overpriced Trade",
    "WL - Wishlist", 
    "TO - Taking offer(s)", 
    "HO - Highest offer", 
    "PC - Price check", 
    "CCC - Content Creator", 
    "Gamejam - Competitions to help practise and enhance Highrise world building.", 
    "Event - Weekly competitive games with rewards for participation and top ranking users and crews. New events every Thursday through Tuesday", 
    "Concepts - Formerly referred to as UDCs (User Design Contests), are art-based contests for creating grab items. Check out the Art Center across the park!",
    "Ideas - A way to fund art ideas to create clothing and accessories for Highrise. Minimum funding at 500k Gold. Check out the Art Center across the park!", 
    "Worlds - 3D customised spaces created by users in Highrise Studio and uploaded to Highrise", 
    "Highrise Studio - The software used and downloaded on a computer to build Highrise Worlds", 
    "Rooms - A 2.5D Isometric space created by users inside the Highrise App", 
    "Creatures - NFTs that are purchased outside of the Highrise app and linked that generate unique benefits such as Highrise +, Daily Creature Tokens, Spontaneous Gifts and Airdrops.", 
    "SF - Formally used as a trading Store Front, now known as Showcase.", 
    "Age-Verified - Referring to adults over the age of 18 who have gone through the process of verifying their age using official ID in Highrise", 
    "Marketplace - A place to sell clothing, pets, emotes, furniture to other users", 
    "Rarity - refers to common, uncommon, rare, epic, legendary and mythical characteristics"
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




