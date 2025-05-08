--!Type(Module)

--!SerializeField
local _DialogueCameraController : DialogueCameraController = nil

local npcBehaviour : NPCBehaviour = nil

local Responses = {
  ["choose_creature_nature"] = function()
    print("Verdant")
  end,
  ["choose_creature_fire"] = function()
    print("Infernal")
  end,
  ["choose_creature_ice"] = function()
    print("Glacial")
  end,
  ["choose_creature_poison"] = function()
    print("Venomous")
  end,
  ["choose_collect_info"] = function()
    print("help selected")
  end,
  ["choose_collect_yes"] = function()
    print("yes selected")
  end,
  ["choose_collect_no"] = function()
    print("no selected")
  end
}

ResponseChosenEvent = Event.new("ResponseChosenEvent")

function StartDialogueCamera(player: Player, npc: GameObject)
  _DialogueCameraController.StartDialogueCamera(player, npc)
  HideLabel()
end

function EndDialogueCamera()
  _DialogueCameraController.EndDialogueCamera()
  ShowLabel()
end

function PlayTalkingAnimation(character: Character, loop: boolean)
  character:PlayEmote("talking", loop)
end

function GetNPCCharacter(): Character?
  return self.gameObject:GetComponent(Character)
end

function StopTalkingAnimation(character: Character)
  character:StopEmote()
end

function SetInteractingWithPlayer(value: boolean)
  npcBehaviour.SetInteractingWithPlayer(value)
end

function HideLabel()
  npcBehaviour.HideLabel()
end

function ShowLabel()
  npcBehaviour.ShowLabel()
end

function self:ClientAwake()
  npcBehaviour = self.gameObject:GetComponent(NPCBehaviour)

  ResponseChosenEvent:Connect(function(player, response)
    print("Response chosen by " .. player.name .. ": " .. response)
    Responses[response]()

    local npcCharacter = GetNPCCharacter()
    if npcCharacter then
      PlayTalkingAnimation(npcCharacter, false)
    end

    PlayTalkingAnimation(player.character, false)
  end)
end

function self:ServerAwake()
  ResponseChosenEvent:Connect(function(player, response)
    print("Response chosen by " .. player.name .. ": " .. response)
  end)
end