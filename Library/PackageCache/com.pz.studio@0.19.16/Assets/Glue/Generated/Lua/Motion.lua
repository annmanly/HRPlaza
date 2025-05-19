--!AddComponentMenu("")

-- Motion
type Motion =
{
    apparentSpeed: number,
    averageAngularSpeed: number,
    averageDuration: number,
    averageSpeed: Vector3,
    isHumanMotion: boolean,
    isLooping: boolean,
    legacy: boolean,
}

-- MotionType
type MotionType =
{
    __tostring: () -> string,
}

if not _G.Motion then
    local MotionType_instance : MotionType = {}
    _G.Motion = MotionType_instance;
end
