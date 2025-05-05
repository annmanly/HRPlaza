--!Type(UI)

--!Bind
local nameLabel : UILabel = nil
local NPC : GameObject = nil

function Initialize(npc: GameObject)
  NPC = npc
  nameLabel:SetPrelocalizedText(NPC.name, true)
end