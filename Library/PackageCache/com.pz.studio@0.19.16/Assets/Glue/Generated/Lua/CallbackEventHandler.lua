--!AddComponentMenu("")

-- CallbackEventHandler
type CallbackEventHandler =
{
    HasBubbleUpHandlers: () -> boolean,
    HasTrickleDownHandlers: () -> boolean,
    SendEvent: (e: EventBase) -> (),
}

-- CallbackEventHandlerType
type CallbackEventHandlerType =
{
    __tostring: () -> string,
}

if not _G.CallbackEventHandler then
    local CallbackEventHandlerType_instance : CallbackEventHandlerType = {}
    _G.CallbackEventHandler = CallbackEventHandlerType_instance;
end
