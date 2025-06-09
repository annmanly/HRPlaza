--!Type(Module)

--!SerializeField
local BGMusic : AudioShader = nil
--!SerializeField
local BossLoop : AudioShader = nil
--!SerializeField
local HoldVibrateShader : AudioShader = nil
--!SerializeField
local popSound : AudioShader = nil
--!SerializeField
local shimmer : AudioShader = nil
--!SerializeField
local laughSound : AudioShader = nil
--!SerializeField
local springSound : AudioShader = nil
--!SerializeField
local leavesSound : AudioShader = nil
--!SerializeField
local rewardExplosionSound : AudioShader = nil
--!SerializeField
local spawnSparkleSound : AudioShader = nil
--!SerializeField
local ghostSqueakSound : AudioShader = nil

local vibrateSource = nil

audioMap = {
    popSound = popSound,
    shimmer = shimmer,
    laughSound = laughSound,
    springSound = springSound,
    leavesSound = leavesSound,
    rewardExplosionSound = rewardExplosionSound,
    spawnSparkleSound = spawnSparkleSound,
    ghostSqueakSound = ghostSqueakSound,
}

local taskSoundTimer = nil

local gameManager = require("GameManager")

local shimmerSource = nil

function PlaySound(sound : string, pitch)
    pitch = pitch or 1
    Audio:PlaySound((audioMap[sound]), self.gameObject, 1, pitch, false, false)
end

function Vibrate()
    vibrateSource = Audio:PlaySound(HoldVibrateShader, self.gameObject, 1, 1, false, false)
end

function self:ClientStart()
    if BGMusic then Audio:PlayMusic(BGMusic, 1, false, true) end
end