--!Type(Module)
-- DESCRIPTION --
-- Fountain that sprays a gift of bubbles at a set interval to all players within the range

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
--!SerializeField
local wishGoldWonParticles:GameObject = nil

local playersInRange = {}
local bubbleRewardAmount = 10

-- GOLD PRIZE --
local winnerGoldAmount = 69 -- live would be ~69
local inRangeGoldAmount = 1
local maxRangePlayers = 30
local minimumRequiredBalance = 200
local currentRangeCount = 0
local oddsNumber = 100 -- will win 1 in 2, live would be 100
local wishitemID = "wish"

local AddInRangeRequest = Event.new("AddToRange")
local RemoveInRangeRequest = Event.new("RemoveInRange")

OpenWriteWishWindow = Event.new("OpenWriteWishWindow") -- client/client

WishSubmitRequest = Event.new("WishSubmitRequest") -- client->server
GiveSingleCoinEvent = Event.new("SingleCoinAnimationEvent") -- server->client
WishEvent = Event.new("WishEvent") -- server->client



-- [[ CLIENT ]]
local InRange = false

function self:ClientAwake()
    writeWishUI = writeWishWindowObj.gameObject:GetComponent(WriteWishWindow)
    if writeWishUI then OpenWriteWishWindow:Connect(OnWishButtonPress) end
    WishEvent:Connect(OnWishEvent)
    GiveSingleCoinEvent:Connect(onGiveSingleCoinEvent)
end

function OnWishButtonPress()
    writeWishWindowObj:SetActive(true)
    writeWishUI.openWindow()
end

function OnWishEvent(player, wonGold)
    if wonGold then particles = wishGoldWonParticles else particles = wishParticles end

    
    Timer.After(.5, function() 
        coin = GameObject.Instantiate(coinObj, player.character.transform.position + Vector3.new(0,3,0))
        coinController = coin.gameObject:GetComponent(CoinController)
        coinController.throw(coinTarget.gameObject.transform.position) 
        Timer.After(1.2, function() 
            particles.gameObject:SetActive(true) 
            Timer.After(1, function() particles.gameObject:SetActive(false) end)
            if wonGold then giveCoinsAnimation(player, 15) end
        end)
    end)
    Timer.After(.8, function() player.character:PlayEmote("emoji-pray", false) end)
    
end

function onGiveSingleCoinEvent(player)
    Timer.After(1.7, function() giveCoinsAnimation(player, 1) end)
end

function giveCoinsAnimation(player, number)
    for i = 1, number do
        Timer.After(i*.25, function() 
            startOffsetX = math.random(0, .2)
            StartOffsetZ = math.random(0, .2)
            coinStartPos = coinTarget.gameObject.transform.position + Vector3.new(startOffsetX, 0, StartOffsetZ)
            coin = GameObject.Instantiate(coinObj, coinStartPos)
            coinController = coin.gameObject:GetComponent(CoinController)
            coinController.throw(player.character.transform.position + Vector3.new(0,3,0)) 
        end )

    end
end


function self:OnTriggerEnter(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character and InRange == false then
            AddInRangeRequest:FireServer()
            InRange = true
          
        end
    end
end

function self:OnTriggerExit(collider: Collider)
    character = collider.gameObject:GetComponent(Character)
    if character then
        if character == client.localPlayer.character then
            RemoveInRangeRequest:FireServer()
            InRange = false
           
        end
    end
end

-- Function to prompt the purchase
function BuyWish(wishData)

    -- Prompt the purchase
    local itemId = wishitemID
    Payments:PromptPurchase(itemId, function(paid)
        if paid then
            print("[PURCHASE PAID - CLIENT]")
        else
            print("[PURCHASE FAILED - CLIENT]")
        end
    end)
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

function EmitReward(winningPlayer)

    for name, player in playersInRange do

        if player ~= nil then
            if not player.isDestroyed then
                if player == winningPlayer then
                    
                    TransferGold(player, winnerGoldAmount)
                else
                TransferGold(player, 1)

                GiveSingleCoinEvent:FireAllClients(player)
                end
            end
        end
    end
end

function LoadDailyPlayerData()
    -- TO DO: if giving gold/bubbles, track how much is given to each player
end

function TransferGold(player, amount)
    Wallet.TransferGoldToPlayer(player, amount, function(response, err)
      if err ~= WalletError.None then
              error(`Something went wrong while transferring gold to {player.name}: {WalletError[err]}`)
              return
        end
  
      print(string.format("[FOUNTAIN] [GOLD SENT] Sent %d Gold to %s, Gold remaining: %d", amount, player.name, response.gold))
    end)
  end


function CompleteWish(player)
    print(`[FOUNTAIN] {player.name} SUBMITTED A WISH.`)

    Wallet.GetWallet(function(response, err)
        if err ~= WalletError.None then
            error("Something went wrong while retrieving wallet: " .. WalletError[err])
            WishEvent:FireAllClients(player, false)
            return
        end

        -- print("[FOUNTAIN] Current Gold: " .. response.gold .. " EARNED GOLD: " .. response.earnedGold) 
        

        currentGold = response.gold + response.earnedGold
        rollNumber = math.random(1,oddsNumber)
        if rollNumber == 1 and currentGold >= minimumRequiredBalance then

            WishEvent:FireAllClients(player, true)
            EmitReward(player)
        else
            WishEvent:FireAllClients(player, false)
        end

        
    end)

end

function ServerHandleWishPurchase(purchase, player: Player)
    local productId = purchase.product_id
    print("[FOUNTAIN ServerHandleWishPurchase]: Purchase made by player " .. tostring(player) .. " for product " .. tostring(productId))

    local itemToGive = "wish"
    if productId ~= itemToGive then
        Payments.AcknowledgePurchase(purchase, false)
        error("[FOUNTAIN ServerHandleWishPurchase]: Item not found!" .. tostring(productId))
        return
    end


    Payments.AcknowledgePurchase(purchase, true, function(ackErr: PaymentsError)
        if ackErr ~= PaymentsError.None then
            error("[FOUNTAIN ServerHandleWishPurchase]: Acknowledge purchase failed!" .. tostring(ackErr))
            return
        end

        CompleteWish(player)

        Storage.GetPlayerValue(player, "Wishes", function(value)
            if value then
                value = value + 1
            else
                value = 1
            end

            Storage.SetPlayerValue(player, "Wishes", value)
        end)

        print("[FOUNTAIN ServerHandleWishPurchase]: Gold received from " .. player.name)
    end) 
end

function self:ServerAwake()
    Payments.PurchaseHandler = ServerHandleWishPurchase
    AddInRangeRequest:Connect(AddToRange)
    RemoveInRangeRequest:Connect(RemoveFromRange)
    
    
end