--!AddComponentMenu("")

-- FingerCountEnd
type FingerCountEnd =
{
    count: number,
    eventTypeId: number,
}

-- FingerCountEndType
type FingerCountEndType =
{
    __tostring: () -> string,
}

if not _G.FingerCountEnd then
    local FingerCountEndType_instance : FingerCountEndType = {}
    _G.FingerCountEnd = FingerCountEndType_instance;
end
