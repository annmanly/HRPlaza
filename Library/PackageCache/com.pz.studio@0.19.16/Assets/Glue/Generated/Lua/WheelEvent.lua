--!AddComponentMenu("")

-- WheelEvent
type WheelEvent =
{
    actionKey: boolean,
    altKey: boolean,
    button: number,
    clickCount: number,
    commandKey: boolean,
    ctrlKey: boolean,
    currentTarget: IEventHandler,
    delta: Vector3,
    eventTypeId: number,
    localMousePosition: Vector2,
    mouseDelta: Vector2,
    mousePosition: Vector2,
    pressedButtons: number,
    shiftKey: boolean,
}

-- WheelEventType
type WheelEventType =
{
    __tostring: () -> string,
}

if not _G.WheelEvent then
    local WheelEventType_instance : WheelEventType = {}
    _G.WheelEvent = WheelEventType_instance;
end
