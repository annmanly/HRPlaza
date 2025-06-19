--!Type(ClientAndServer)
--!SerializeField
local npcName:string = "TestNPC"
--!SerializeField
--!Tooltip("Match #outfits. List of ET start times for each outfit in 'YYYY-MM-DD HH:MM:SS'")
local startdates:{string} = {"2025-06-09 13:00:00"}
--!SerializeField
local outfits:{CharacterOutfit} = {}

local RequestOutfitSave = Event.new(npcName .. "SaveOutfit")

export type ClothingData = {
    Id: string,
    Color: number
}


function SerializeOutfitToOutfitSaveData(outfit : CharacterOutfit)  : {ClothingData}
    local clothingList = {}
    for _, clothing in ipairs(outfit.clothing) do
        table.insert(clothingList, {Id = clothing.id, Color = clothing.color})
    end
    return clothingList
end


function DeserializeOutfitSaveDataToOutfit(saveData) : CharacterOutfit
    local outfitIds = {}
    local colors = {}
    for _, clothingData in ipairs(saveData) do
        table.insert(outfitIds, clothingData.Id)
        table.insert(colors, clothingData.Color)
    end
    return DeserializeDataToOutfit(outfitIds, colors)
end



function DeserializeDataToOutfit(outfitIds : {string}, colors) : CharacterOutfit
    outfit = CharacterOutfit.CreateInstance(outfitIds, nil)
    for i = 1 , #outfit.clothing do
        outfit.clothing[i].color = colors[i]
    end
    return outfit
end


function self:ClientAwake()

    if #outfits ~= #startdates then
        print(`OUTFIT & DATE count mismatch, not creating entry`)
        return
    end

    FullSaveData = {}
    for i = 1, #outfits do
        outfit = outfits[i]
        date = startdates[i]
        serializedFit = SerializeOutfitToOutfitSaveData(outfit)
        saveData = {
            start = date,
            outfit = serializedFit
        }
        table.insert(FullSaveData, saveData)
    end
    RequestOutfitSave:FireServer(FullSaveData)
end

function self:ServerAwake()
    RequestOutfitSave:Connect(function(player, data) 
        Storage.SetValue(npcName, data) 
    
    end)
end