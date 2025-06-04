--!Type(Module)

--!Tooltip(Whether to show a test notification when the script is loaded.)
--!SerializeField
local testNotification : boolean = false

--!Tooltip(The sound that will be played when an alert is shown.)
--!SerializeField
local alertSound : AudioShader = nil

-- You can add more audio shaders here if you want to play different sounds for different alerts.
-- Example: 
--[[

--!SerializeField 
local alertSound2 : AudioShader = nil

]] --

local audioShaders = {
  ["alertSound"] = alertSound,
}

local pNotifyScript = nil

--[[
  Function to show an alert using the pNotify script.
  @param options:table - The options for the alert.
]]
Notify = function(options)
  if pNotifyScript.Notify(options) then
    if options.audio then
      if not options.audioShader then
        print("[WARNING] Alert sound not found. Please provide an audio shader to play the alert sound.")
      else
        local audio = audioShaders[options.audioShader]
        if not audio then
          print("[WARNING] Invalid audio shader provided. Please provide a valid audio shader.")
          return
        end

        Audio:PlayShader(audio)
      end
    end
  else
    print("[WARNING] pNotify script not found on the object.")
  end
end

function self:ClientAwake()
  if pNotifyScript == nil then pNotifyScript = self.gameObject:GetComponent(pnoty) end
  
  if not pNotifyScript then
    print("[WARNING] pnotify script not found on the object.")
  else
    if testNotification then
      Notify({
        type = "info",
        title = "Test Notification",
        message = "This is a test notification.",
        duration = 5,
        audio = true,
        audioShader = "alertSound",
        autoHide = true,
        scope = "local",
        player = client.localPlayer
      })
    end
  end
end