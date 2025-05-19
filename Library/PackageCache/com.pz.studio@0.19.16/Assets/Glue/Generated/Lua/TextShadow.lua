--!AddComponentMenu("")

-- TextShadow
type TextShadow =
{
    blurRadius: number,
    color: Color,
    offset: Vector2,
    Equals: (other: TextShadow) -> boolean,
}

-- TextShadowType
type TextShadowType =
{
    __eq: (style1: TextShadow, style2: TextShadow) -> boolean,
    __tostring: () -> string,
}

if not _G.TextShadow then
    local TextShadowType_instance : TextShadowType = {}
    _G.TextShadow = TextShadowType_instance;
end
