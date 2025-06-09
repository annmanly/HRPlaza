--!Type(Module)

local gameManager = require("GameManager")

productIDMAP = {
  spawnRateBuff_short = "spawnrate_short",
}

---------- CLIENT SIDE ----------

-- Function to Prompt the player to purchase a token (Client Side)
function PromptTokenPurchase(id: string)

  local id = productIDMAP[id]
  print("PromptTokenPurchase called for product ID:", id)

  Payments:PromptPurchase(id, function(paid)
    if paid then
      print("Purchase successful", client.localPlayer.name)
    else
      print("Purchase failed", client.localPlayer.name)
    end
  end)
end

---------- SERVER SIDE ----------

-- Function to handle the purchase (Server Side)
function ServerHandlePurchase(purchase, player: Player)
    local productId = purchase.product_id
    print("ServerHandlePurchase called for player:", player.name, "with product ID:", productId)

    -- 1) Try to apply the appropriate buff and capture its return value in `success`.
    local success = false
    if productId == "spawnrate_short" then
        success = gameManager.StartbuffForPlayer(player, "spawnRateBuff_short")
    else
        success = false
    end

    print("Buff application success:", success, "for product ID:", productId, "for player:", player.name)

    -- 2) Acknowledge the purchase once, passing in the `success` flag.
    Payments.AcknowledgePurchase(purchase, success, function(ackErr: PaymentsError)
        if ackErr ~= PaymentsError.None then
            print(player.name, " Error acknowledging purchase: " .. tostring(ackErr))
            return
        end

        if success then
            print("Purchase acknowledged and buff applied for product:", productId, "for player:", player.name)
        else
            print("purchase rejected:", productId, "for player:", player.name)
        end
    end)
end

-- Initialize the module
function self:ServerAwake()
  Payments.PurchaseHandler = ServerHandlePurchase
end