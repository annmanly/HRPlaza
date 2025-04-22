--!AddComponentMenu("")

-- EventBase
type EventBase =
{
    bubbles: boolean,
    currentTarget: IEventHandler,
    dispatch: boolean,
    eventTypeId: number,
    isDefaultPrevented: boolean,
    isImmediatePropagationStopped: boolean,
    isPropagationStopped: boolean,
    originalMousePosition: Vector2,
    timestamp: number,
    tricklesDown: boolean,
    target: IEventHandler,
    PreventDefault: () -> (),
    StopImmediatePropagation: () -> (),
    StopPropagation: () -> (),
}

-- EventBaseType
type EventBaseType =
{
    __tostring: () -> string,
}

if not _G.EventBase then
    local EventBaseType_instance : EventBaseType = {}
    _G.EventBase = EventBaseType_instance;
end
