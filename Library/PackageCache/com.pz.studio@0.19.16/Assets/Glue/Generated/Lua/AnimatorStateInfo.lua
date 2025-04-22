--!AddComponentMenu("")

-- AnimatorStateInfo
type AnimatorStateInfo =
{
    fullPathHash: number,
    length: number,
    loop: boolean,
    normalizedTime: number,
    shortNameHash: number,
    speed: number,
    speedMultiplier: number,
    tagHash: number,
    IsName: (name: string) -> boolean,
    IsTag: (tag: string) -> boolean,
}

-- AnimatorStateInfoType
type AnimatorStateInfoType =
{
    __tostring: () -> string,
}

if not _G.AnimatorStateInfo then
    local AnimatorStateInfoType_instance : AnimatorStateInfoType = {}
    _G.AnimatorStateInfo = AnimatorStateInfoType_instance;
end
