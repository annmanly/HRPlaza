--!Type(Module)

--!SerializeField
local _messagePrefab : GameObject = nil

local interval = nil

function ShowMessage(messageText, messageDuration, looping, loopTime)
    
    local Send = function()
        local message = GameObject.Instantiate(_messagePrefab)
        messageComponent = message:GetComponent(WorldMessage)
        messageComponent.SetMessage(messageText, messageDuration)
        print("SENDING MESSAGE: "  .. messageText)
    end

    StopMessages()
    Send()

    if looping and loopTime > 0 then 
        interval = Timer.Every(messageDuration + loopTime, function()
            Send()
        end)
    end
end

function StopMessages()
    if interval then
        interval:Stop()
        interval = nil
        oldMessage = GameObject.FindObjectOfType(WorldMessage)
        if oldMessage then oldMessage.gameObject:SetActive(false) end
    end
end