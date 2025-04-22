--!AddComponentMenu("")

-- AnimationEvent
type AnimationEvent =
{
    animatorStateInfo: AnimatorStateInfo,
    isFiredByAnimator: boolean,
    isFiredByLegacy: boolean,
    floatParameter: number,
    functionName: string,
    intParameter: number,
    objectReferenceParameter: Object,
    stringParameter: string,
    time: number,
}

-- AnimationEventType
type AnimationEventType =
{
    __tostring: () -> string,
}

if not _G.AnimationEvent then
    local AnimationEventType_instance : AnimationEventType = {}
    _G.AnimationEvent = AnimationEventType_instance;
end
