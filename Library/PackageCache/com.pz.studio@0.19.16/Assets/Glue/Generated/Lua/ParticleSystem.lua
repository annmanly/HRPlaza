--!AddComponentMenu("")

-- ParticleSystem
type ParticleSystem =
{
    has3DParticleRotations: boolean,
    hasNonUniformParticleSizes: boolean,
    isEmitting: boolean,
    isPaused: boolean,
    isPlaying: boolean,
    isStopped: boolean,
    particleCount: number,
    proceduralSimulationSupported: boolean,
    totalTime: number,
    randomSeed: number,
    time: number,
    useAutoRandomSeed: boolean,
    Clear: () -> (),
    Clear: (withChildren: boolean) -> (),
    Emit: (count: number) -> (),
    IsAlive: () -> boolean,
    IsAlive: (withChildren: boolean) -> boolean,
    Pause: () -> (),
    Pause: (withChildren: boolean) -> (),
    Play: () -> (),
    Play: (withChildren: boolean) -> (),
    Simulate: (t: number) -> (),
    Simulate: (t: number , withChildren: boolean) -> (),
    Simulate: (t: number , withChildren: boolean , restart: boolean) -> (),
    Simulate: (t: number , withChildren: boolean , restart: boolean , fixedTimeStep: boolean) -> (),
    Stop: (withChildren: boolean?) -> (),
    TriggerSubEmitter: (subEmitterIndex: number) -> (),
}

-- ParticleSystemType
type ParticleSystemType =
{
    __tostring: () -> string,
}

if not _G.ParticleSystem then
    local ParticleSystemType_instance : ParticleSystemType = {}
    _G.ParticleSystem = ParticleSystemType_instance;
end
