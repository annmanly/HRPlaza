--!AddComponentMenu("")

-- FingerCountBegin
type FingerCountBegin =
{
    count: number,
    eventTypeId: number,
}

-- FingerCountBeginType
type FingerCountBeginType =
{
    __tostring: () -> string,
}

if not _G.FingerCountBegin then
    local FingerCountBeginType_instance : FingerCountBeginType = {}
    _G.FingerCountBegin = FingerCountBeginType_instance;
end
