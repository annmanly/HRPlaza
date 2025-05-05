--!Type(Client)

--!SerializeField
local dialogueUIObject: GameObject = nil
--!SerializeField
local npcColor: Color = Color.new(157, 56, 187)
--!SerializeField
local npcName: string = "NPC"
--!SerializeField
local startChunk: DialogueChunk = nil

local tapHandler: TapHandler = nil
local dialogueUI: DialogueUI = nil
local indicator = nil

local ResponseManager = require("DialogueResponseManager")


function OnTapped()
    print("Tapped")
    if not dialogueUI then print("There is no Dialogue UI") return end
    dialogueUIObject:SetActive(true)

    local messageTexts = {}
    messageTexts = startChunk.GetPages()

    dialogueUI.InitializeDialogue(npcColor, npcName, messageTexts)
    ResponseManager.StartDialogueCamera(client.localPlayer, self.gameObject)

    ResponseManager.SetInteractingWithPlayer(true)
end

function self:Start()
    dialogueUI = dialogueUIObject:GetComponent(DialogueUI)

    tapHandler = self.gameObject:GetComponent(TapHandler)
    tapHandler.Tapped:Connect(OnTapped)
end