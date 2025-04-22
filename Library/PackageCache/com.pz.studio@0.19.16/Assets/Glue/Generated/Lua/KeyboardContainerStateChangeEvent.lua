--!AddComponentMenu("")

-- KeyboardContainerStateChangeEvent
type KeyboardContainerStateChangeEvent =
{
    duration: number,
    eventTypeId: number,
    from: number,
    isKeyboardVisible: boolean,
    to: number,
    Init: (isKeyboardVisible: boolean , from: number , to: number , duration: number) -> (),
}

-- KeyboardContainerStateChangeEventType
type KeyboardContainerStateChangeEventType =
{
    GetPooled: (isKeyboardVisible: boolean, from: number, to: number, duration: number) -> KeyboardContainerStateChangeEvent,
    __tostring: () -> string,
}

if not _G.KeyboardContainerStateChangeEvent then
    local KeyboardContainerStateChangeEventType_instance : KeyboardContainerStateChangeEventType = {}
    _G.KeyboardContainerStateChangeEvent = KeyboardContainerStateChangeEventType_instance;
end
