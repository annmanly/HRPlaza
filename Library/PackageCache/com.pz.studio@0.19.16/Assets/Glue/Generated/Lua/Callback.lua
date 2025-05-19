--!AddComponentMenu("")

-- Callback
type Callback =
{
}

-- CallbackType
type CallbackType =
{
}

if not _G.Callback then
    local CallbackType_instance : CallbackType = {}
    _G.Callback = CallbackType_instance;
end
