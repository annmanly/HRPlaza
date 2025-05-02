--!Type(UI)
--!Bind
local _title:UILabel = nil
--!Bind
local _closeButton:VisualElement = nil
--!Bind
local _wishInput:UITextField = nil
--!Bind
local _wishLengthCounter:Label = nil
--!Bind
local _submit:VisualElement = nil
--!Bind
-- local _isAnonAuthor:UISwitchToggle = nil
-- --!Bind
-- local _isSecret:UISwitchToggle = nil
--!Bind
-- local _wishAuthorDisplay:UILabel = nil

local fountainManager = require("Fountain")

function openWindow()
    print("OPEN WINDOW")
end

function closeWindow()

    print("CLOSING WINDOW")
    self.gameObject:SetActive(false)
end

local function ConvertDateFormat(dateStr)
    -- Parse the date string
    local pattern = "(%a+) (%a+) (%d+) (%d+):(%d+):(%d+) (%d+)"
    local dayOfWeek, month, day, hour, min, sec, year = dateStr:match(pattern)
  
    -- Create a table for month conversion
    local months = {Jan = "01", Feb = "02", Mar = "03", Apr = "04", May = "05", Jun = "06",
                    Jul = "07", Aug = "08", Sep = "09", Oct = "10", Nov = "11", Dec = "12"}
  
    -- Format the date to "YYYY-MM-DD"
    local formattedDate = string.format("%02d-%02d %02d:%02d", months[month], day, hour, min)
    return formattedDate
end

function submitWish()
    -- if _isAnonAuthor then
    --     author = "Anonymous"
    -- else
    --     author = client.localPlayer.name
    -- end
    -- timestamp = ConvertDateFormat(os.date("%c"))
    wish = {
        wishAuthor = client.localPlayer.name,
        -- wishDate = timestamp,
        wishMessage = _wishInput.text
    }
    fountainManager.WishSubmitRequest:FireServer(wish)
    print("SUBMIT WISH WITH TEXT" .. _wishInput.text .. " AUTHOR: " .. client.localPlayer.name)

    closeWindow()
end




function self:ClientStart()
    _closeButton:RegisterPressCallback(closeWindow)
    _submit:RegisterPressCallback(submitWish)
    fountainManager.OpenWriteWishWindow:Connect(openWindow)

    
    _title:SetPrelocalizedText("Make a Wish")
    -- _wishAuthorDisplay:SetPrelocalizedText("-" .. client.localPlayer.name)


    _wishInput:RegisterCallback(StringChangeEvent, function(event)
        local text = _wishInput.textElement.text
        _wishLengthCounter.text = string.len(text) .. " / 200"
    end)

    -- _isAnonAuthor:RegisterCallback(BoolChangeEvent, function(event) 
    --     if _isAnonAuthor.value == true then
    --         _wishAuthorDisplay:SetPrelocalizedText("-Anonymous")
    --     else
    --         _wishAuthorDisplay:SetPrelocalizedText("-" .. client.localPlayer.name)
    --     end
    -- end)

    
    
end



