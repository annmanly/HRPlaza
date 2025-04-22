--!AddComponentMenu("")

-- PointerUpEvent
type PointerUpEvent =
{
    actionKey: boolean,
    altKey: boolean,
    altitudeAngle: number,
    azimuthAngle: number,
    button: number,
    clickCount: number,
    commandKey: boolean,
    ctrlKey: boolean,
    currentTarget: IEventHandler,
    deltaPosition: Vector3,
    deltaTime: number,
    eventTypeId: number,
    isPrimary: boolean,
    localPosition: Vector3,
    pointerId: number,
    pointerType: string,
    position: Vector3,
    pressedButtons: number,
    pressure: number,
    radius: Vector2,
    radiusVariance: Vector2,
    shiftKey: boolean,
    tangentialPressure: number,
    tilt: Vector2,
    twist: number,
}

-- PointerUpEventType
type PointerUpEventType =
{
    __tostring: () -> string,
}

if not _G.PointerUpEvent then
    local PointerUpEventType_instance : PointerUpEventType = {}
    _G.PointerUpEvent = PointerUpEventType_instance;
end
