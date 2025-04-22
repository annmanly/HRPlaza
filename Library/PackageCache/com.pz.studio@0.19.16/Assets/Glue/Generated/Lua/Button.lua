--!AddComponentMenu("")

-- Button
type Button =
{
}

-- ButtonType
type ButtonType =
{
    ussClassName: string,
    new: () -> Button,
    new: (clickEvent: () -> ()) -> Button,
    __tostring: () -> string,
}

if not _G.Button then
    local ButtonType_instance : ButtonType = {}
    _G.Button = ButtonType_instance;
end
