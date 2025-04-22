--!Type(Client)

---- Serialized Fields ----

--!SerializeField
--!Tooltip("Audio shader to play. To create an Audio Shader, right click an audio file then go to Create->Highrise->Audio->Audio Shader")
local _audioShader: AudioShader = nil
--!SerializeField
--!Tooltip("Delay in seconds before playing the sound.")
local _secondsDelay: number = 0

---- Internal Variables ----

local _audioTimer: Timer = nil

---- Functions ----

function Play()
	if _audioShader then
		if #_audioShader.clips == 0 then
			print("<color=red>Error: No sound clips found in Audio Shader: " .. _audioShader.name .. "</color>")
			return
		end
		Audio:PlayShader(_audioShader)
	end
end

function self.ClientAwake()
	if not _audioShader then
		print(
			"<color=red>Error: No sound to play. Please set an Audio Shader on object: "
				.. self.gameObject.name
				.. "</color>"
		)
		return
	end

	if _secondsDelay > 0 then
		_audioTimer = Timer.After(_secondsDelay, function()
			Play()
			_audioTimer = nil
		end)
	else
		Play()
	end
end

function self:OnDestroy()
	if _audioTimer then
		_audioTimer:Stop()
		_audioTimer = nil
	end
end
