--!AddComponentMenu("")

-- FlexDirection
type FlexDirection =
{
}

-- FlexDirectionType
type FlexDirectionType =
{
    Column: FlexDirection,
    ColumnReverse: FlexDirection,
    Row: FlexDirection,
    RowReverse: FlexDirection,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.FlexDirection then
    local FlexDirectionType_instance : FlexDirectionType = {}
    _G.FlexDirection = FlexDirectionType_instance;
end
