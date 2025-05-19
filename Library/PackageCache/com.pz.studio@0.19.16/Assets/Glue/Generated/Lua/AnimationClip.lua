--!AddComponentMenu("")

-- AnimationClip
type AnimationClip =
{
    empty: boolean,
    hasGenericRootTransform: boolean,
    hasMotionCurves: boolean,
    hasMotionFloatCurves: boolean,
    hasRootCurves: boolean,
    humanMotion: boolean,
    length: number,
    events: {AnimationEvent},
    frameRate: number,
    legacy: boolean,
    localBounds: Bounds,
    AddEvent: (evt: AnimationEvent) -> (),
    ClearCurves: () -> (),
    EnsureQuaternionContinuity: () -> (),
    SampleAnimation: (go: GameObject , time: number) -> (),
    SetCurve: (relativePath: string , type: Type , propertyName: string , curve: AnimationCurve) -> (),
}

-- AnimationClipType
type AnimationClipType =
{
    __tostring: () -> string,
}

if not _G.AnimationClip then
    local AnimationClipType_instance : AnimationClipType = {}
    _G.AnimationClip = AnimationClipType_instance;
end
