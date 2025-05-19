--!AddComponentMenu("")

-- Random
type Random =
{
}

-- RandomType
type RandomType =
{
    insideUnitCircle: Vector2,
    insideUnitSphere: Vector3,
    onUnitSphere: Vector3,
    rotation: Quaternion,
    rotationUniform: Quaternion,
    value: number,
    ColorHSV: () -> Color,
    ColorHSV: (hueMin: number, hueMax: number) -> Color,
    ColorHSV: (hueMin: number, hueMax: number, saturationMin: number, saturationMax: number) -> Color,
    ColorHSV: (hueMin: number, hueMax: number, saturationMin: number, saturationMax: number, valueMin: number, valueMax: number) -> Color,
    ColorHSV: (hueMin: number, hueMax: number, saturationMin: number, saturationMax: number, valueMin: number, valueMax: number, alphaMin: number, alphaMax: number) -> Color,
    InitState: (seed: number) -> (),
    Range: (minInclusive: number, maxInclusive: number) -> number,
    RangeInt: (minInclusive: number, maxExclusive: number) -> number,
}

if not _G.Random then
    local RandomType_instance : RandomType = {}
    _G.Random = RandomType_instance;
end
