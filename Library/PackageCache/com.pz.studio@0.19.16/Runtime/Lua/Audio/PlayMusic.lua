--!Type(Client)

---- Serialized Fields ----

--!Header("Music URL Settings")
--!SerializeField
local _playMusicFromURL: boolean = false
--!SerializeField
--!Tooltip("URL of the music to play. If set, this will override the Audio Shader.")
local _musicURL: string = ""

--!Header("Music Clip Settings")
--!SerializeField
--!Tooltip("Audio shader music to play. To create an Audio Shader, right click an audio file then go to Create->Highrise->Audio->Audio Shader")
local _musicAudioShader: AudioShader = nil
--!SerializeField
local _loopMusic: boolean = true

--!Header("Common Music Settings")
--!SerializeField
--!Range(0, 1)
local _volume: number = 1
--!SerializeField
local _fadeIn: boolean = true

---- Functions ----

function Play(music: AudioShader)
	if music then
		if #music.clips == 0 then
			print("<color=red>Error: No music clips found in Audio Shader: " .. music.name .. "</color>")
			return
		end
		Audio:PlayMusic(music, _volume, _fadeIn, _loopMusic)
	end
end

function PlayFromURL(url: string)
	if url == nil then
		return
	end
	if url == "" then
		print("<color=red>Error: No music URL set. Please set a URL on object: " .. self.gameObject.name .. "</color>")
		return
	end
	Audio:PlayMusicURL(url, _volume, _fadeIn)
end

function StopMusic(fadeOut: boolean)
	Audio:StopMusic(fadeOut)
end

function self.ClientAwake()
	-- Verify that either an Audio Shader or a URL is set
	if _musicAudioShader == nil and _musicURL == "" then
		print(
			"<color=red>Error: No music to play. Please set either an Audio Shader or a URL on object: "
				.. self.gameObject.name
				.. "</color>"
		)
		return
	end

	-- If a URL is set, load the music from the URL
	if _playMusicFromURL then
		PlayFromURL(_musicURL)
	else
		Play(_musicAudioShader)
	end
end
