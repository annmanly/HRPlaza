--!AddComponentMenu("")

-- UILuaView
type UILuaView =
{
}

-- UILuaViewType
type UILuaViewType =
{
    __tostring: () -> string,
}

if not _G.UILuaView then
    local UILuaViewType_instance : UILuaViewType = {}
    _G.UILuaView = UILuaViewType_instance;
end
