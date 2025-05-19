--!AddComponentMenu("")

-- Input
type Input =
{
    LongPressBegan: LuaEvent,
    LongPressContinue: LuaEvent,
    LongPressEnded: LuaEvent,
    MouseWheel: LuaEvent,
    PinchOrDragBegan: LuaEvent,
    PinchOrDragChanged: LuaEvent,
    PinchOrDragEnded: LuaEvent,
    Tapped: LuaEvent,
    client: GameClient,
    isAltPressed: boolean,
    isMouseInput: boolean,
    inputPanel: IPanel,
}

-- InputType
type InputType =
{
    __tostring: () -> string,
}

if not _G.Input then
    local InputType_instance : InputType = {}
    _G.Input = InputType_instance;
end
