--!Type(UI)

--!Bind
local ticket_container : VisualElement = nil
--!Bind
local ticket_label : Label = nil

function self:Awake()
    ticket_container:EnableInClassList("fade", true)
end

function ShowMessage(message)
    if message == 'Miss!' then
        ticket_label:EnableInClassList("miss", true)
    else
        ticket_label:EnableInClassList("miss", false)
    end
    if message == 'Perfect!' then
        ticket_label:EnableInClassList("perfect", true)
    else
        ticket_label:EnableInClassList("perfect", false)
    end
    ticket_label.text = tostring(message)
    ticket_container:EnableInClassList("fade", false)
    Timer.After(1, function() ticket_container:EnableInClassList("fade", true) end)
end

