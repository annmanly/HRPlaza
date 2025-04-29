--!Type(Module)
-- DESCRIPTION --
-- Fountain that sprays a gift of bubbles at a set interval to all players within the range

--!SerializeField
local fountainInteractUI:GameObject = nil
--!SerializeField
local writeWishWindowObj:GameObject = nil
local writeWishUI = nil
--!SerializeField
local wishCollectionObj:GameObject = nil
--!SerializeField
local coinObj:GameObject = nil
--!SerializeField
local coinTarget:GameObject = nil
--!SerializeField
local wishParticles:GameObject = nil

local playersInRange = {}
local bubbleRewardAmount = 10
local bubbleFountainInterval = 15 -- time between emission in seconds

local AddInRangeRequest = Event.new("AddToRange")
local RemoveInRangeRequest = Event.new("RemoveInRange")

OpenWriteWishWindow = Event.new("OpenWriteWishWindow") -- client/client

WishSubmitRequest = Event.new("WishSubmitRequest") -- client->server
WishEvent = Event.new("WishEvent") -- server->client

-- [[ CLIENT ]]
local InRange = false

function self:ClientAwake()
    writeWishUI = writeWishWindowObj.gameObject:GetComponent(WriteWishWindow)
    if writeWishUI then OpenWriteWishWindow:Connect(OnWishButtonPress) end
    WishEvent:Connect(OnWishEvent)
end

function OnWishButtonPress()
    writeWishWindowObj:SetActive(true)
    writeWishUI.openWindow()
end

function OnWishEvent(player)
    coin = GameObject.Instantiate(coinObj, player.character.transform.position)
    coinController = coin.gameObject:GetComponent(CoinController)
    Timer.After(.5, function() coinController.throw(coinTarget.gameObject.transform.position) end)
    Timer.After(.8, function() player.character:PlayEmote("emoji-pray", false) end)
    Timer.After(1.1, function() 
        wishParticles.gameObject:SetActive(true) 
        Timer.After(1, function() wishParticles.gameObject:SetActive(false) end)
    end)
    
end

function self:OnTriggerEnter(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character and InRange == false then
            AddInRangeRequest:FireServer()
            InRange = true
            fountainInteractUI:SetActive(true)
        end
    end
end

function self:OnTriggerExit(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character then
            RemoveInRangeRequest:FireServer()
            InRange = false
            fountainInteractUI:SetActive(false)
        end
    end
end

-- [[ SERVER ]]

function AddToRange(player)
    if not playersInRange[player.name] then
        playersInRange[player.name] = player
        -- print("ADDED CHARACTER TO RANGE: " .. player.name)
    end

end

function RemoveFromRange(player)
    if playersInRange[player.name] then
        playersInRange[player.name] = nil
        -- print("REMOVED CHARACTER FROM RANGE: " .. player.name)
    end

end

function EmitReward()
    print("EMITTING GOLD")
    for i, player in playersInRange do
        TransferGold(player, 1)
    end
end

function LoadDailyPlayerData()
    -- TO DO: if giving gold/bubbles, track how much is given to each player
end

function TransferGold(player, amount)
    Wallet.TransferGoldToPlayer(player, amount, function(response, err)
      if err ~= WalletError.None then
              error("Something went wrong while transferring gold: " .. WalletError[err])
              return
          end
  
      print(string.format("Sent %d Gold to %s, Gold remaining: %d", amount, player.name, response.gold))
    end)
  end


function OnWishSubmitRequest(player, wishData)
    print("RECEIVED WISH DATA: " .. player.name .. " WISH: " .. wishData.wishMessage)
    WishEvent:FireAllClients(player)
end

function self:ServerAwake()

    WishSubmitRequest:Connect(OnWishSubmitRequest)
    AddInRangeRequest:Connect(AddToRange)
    RemoveInRangeRequest:Connect(RemoveFromRange)

    -- Loop to emit gold or bubbles or whatever
    Timer.Every(bubbleFountainInterval, EmitReward)
    
end