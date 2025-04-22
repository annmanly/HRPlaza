-- Declare references to the X and O GameObjects to be controlled via the script.
--!SerializeField
local X : GameObject = nil
--!SerializeField
local O : GameObject = nil

-- Create an event called 'tapRequest' which will be used to handle tap actions from the client.
local tapRequest = Event.new("TapRequest")
-- Create an network integer 'tileState' to keep track of the state of each tile: 0 (empty), 1 (X), or 2 (O).
local tileState = IntValue.new("TileState", 0)


-- This function runs once when the client part of the script is initialized.
function self:ClientAwake()
    -- Initially, set both X and O as inactive when the game starts.
    X:SetActive(false)
    O:SetActive(false)

    -- Listen for changes in the 'tileState'.
    -- When 'tileState' changes, this connected function will be called with 'newVal' (new value) and 'oldVal' (old value).
    tileState.Changed:Connect(function(newVal, oldVal)
        if newVal == 0 then
            -- If the tile is empty, deactivate both X and O.
            X:SetActive(false)
            O:SetActive(false)
        elseif newVal == 1 then
            -- If the tile state is 1, show X and hide O.
            X:SetActive(true)
            O:SetActive(false)
        elseif newVal == 2 then
            -- If the tile state is 2, show O and hide X.
            X:SetActive(false)
            O:SetActive(true)
        end
    end)
end

-- This function is called when the client starts, after the initialization.
function self:ClientStart()
    -- Retrieve the TicTacToeManager component from the parent of this GameObject.
    local Manager = self.transform.parent.gameObject:GetComponent("TicTacToeManager")
    
    -- Connect a function to handle 'Tapped' events from the TapHandler component of this GameObject.
    -- When the GameObject is tapped, it will fire the 'tapRequest' event to the server, passing the Manager as an argument.
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
        tapRequest:FireServer(Manager)
    end)
end

-- This function runs once when the server part of the script is initialized.
function self:ServerAwake()
    -- Listen for the 'tapRequest' event.
    -- When it is received, the function will get the 'player' who tapped and the 'manager' of the game.
    tapRequest:Connect(function(player, manager)
        if tileState.value == 0 then
            -- If the tile is empty, set it to the current turn's value.
            tileState.value = manager.Turn.value
            tileState.value = tileState.value + 1
            -- Ensure that the tile state cycles between 1 (X) and 2 (O).
            if tileState.value == 3 then 
                tileState.value = 1 
            end
            -- Update the manager's turn to the new value.
            manager.Turn.value = tileState.value
        else
            -- If the tile is not empty, reset the state to 0 (empty).
            tileState.value = 0
        end
    end)
end
