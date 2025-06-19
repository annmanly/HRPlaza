--!Type(ClientAndServer)
--!SerializeField
local npcName:string = "TestNPC"
--!SerializeField
--!Tooltip("Match #outfits. List of ET start times for each outfit in 'YYYY-MM-DD HH:MM:SS'")
local startdates:{string} = {"2025-06-09 13:00:00"}

local RequestOutfitSave = Event.new(npcName .. "SaveOutfit")

export type ClothingData = {
    id: string,
    color: number
}

function DeserializeClothingDataToOutfit(clothingDataList : {ClothingData}) : CharacterOutfit
    local outfitIds = {}
    for _, clothingData in ipairs(clothingDataList) do
        table.insert(outfitIds, clothingData.id)
    end
    local outfit = DeserializeDataToOutfit(outfitIds)
    for i = 1 , #outfit.clothing do
        outfit.clothing[i].color = clothingDataList[i].color
    end
    return outfit
end

function DeserializeDataToOutfit(outfitIds : {string}) : CharacterOutfit
    return CharacterOutfit.CreateInstance(outfitIds, nil)
end

function SerializeOutfitToData(outfit : CharacterOutfit) : {ClothingData}
    local clothingList = {}
    for _, clothing in ipairs(outfit.clothing) do
        table.insert(clothingList, {id = clothing.id, color = clothing.color})
    end
    return clothingList
end

function SerializeOutfitToOutfitSaveData(outfit : CharacterOutfit)
    local clothingDataList = SerializeOutfitToData(outfit)
    local saveData = {
        Ids = {},
        Colors = {}
    }
    for _, clothingData in ipairs(clothingDataList) do
        saveData.Ids[#saveData.Ids + 1] = clothingData.id
        saveData.Colors[#saveData.Colors + 1] = clothingData.color
    end
    return saveData
end

function DeserializeOutfitSaveDataToOutfit(saveData) : CharacterOutfit
    local clothingDataList = {}
    for i = 1, #saveData.Ids do
        table.insert(clothingDataList, {id = saveData.Ids[i], color = saveData.Colors[i]})
    end
    return DeserializeClothingDataToOutfit(clothingDataList)
end


function self:ClientAwake()

    outfits = self.gameObject:GetComponent(Character).outfits

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