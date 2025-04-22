--!AddComponentMenu("")

-- AnimationCurve
type AnimationCurve =
{
    length: number,
    AddKey: (time: number , value: number) -> number,
    ClearKeys: () -> (),
    CopyFrom: (other: AnimationCurve) -> (),
    Equals: (other: AnimationCurve) -> boolean,
    Evaluate: (time: number) -> number,
    RemoveKey: (index: number) -> (),
    SmoothTangents: (index: number , weight: number) -> (),
}

-- AnimationCurveType
type AnimationCurveType =
{
    Constant: (timeStart: number, timeEnd: number, value: number) -> AnimationCurve,
    EaseInOut: (timeStart: number, valueStart: number, timeEnd: number, valueEnd: number) -> AnimationCurve,
    Linear: (timeStart: number, valueStart: number, timeEnd: number, valueEnd: number) -> AnimationCurve,
    __tostring: () -> string,
}

if not _G.AnimationCurve then
    local AnimationCurveType_instance : AnimationCurveType = {}
    _G.AnimationCurve = AnimationCurveType_instance;
end
