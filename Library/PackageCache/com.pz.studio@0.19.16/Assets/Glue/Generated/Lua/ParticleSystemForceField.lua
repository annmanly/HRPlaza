--!AddComponentMenu("")

-- ParticleSystemForceField
type ParticleSystemForceField =
{
    endRange: number,
    gravityFocus: number,
    length: number,
    multiplyDragByParticleSize: boolean,
    multiplyDragByParticleVelocity: boolean,
    rotationRandomness: Vector2,
    startRange: number,
    vectorField: Texture3D,
}

-- ParticleSystemForceFieldType
type ParticleSystemForceFieldType =
{
    __tostring: () -> string,
}

if not _G.ParticleSystemForceField then
    local ParticleSystemForceFieldType_instance : ParticleSystemForceFieldType = {}
    _G.ParticleSystemForceField = ParticleSystemForceFieldType_instance;
end
