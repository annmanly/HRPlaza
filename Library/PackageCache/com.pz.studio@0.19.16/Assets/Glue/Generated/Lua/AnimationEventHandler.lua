--!AddComponentMenu("")

-- AnimationEventHandler
type AnimationEventHandler =
{
    StateEnter: LuaEvent,
    StateExit: LuaEvent,
    StateIK: LuaEvent,
    StateMove: LuaEvent,
    StateUpdate: LuaEvent,
}

-- AnimationEventHandlerType
type AnimationEventHandlerType =
{
}

if not _G.AnimationEventHandler then
    local AnimationEventHandlerType_instance : AnimationEventHandlerType = {}
    _G.AnimationEventHandler = AnimationEventHandlerType_instance;
end
