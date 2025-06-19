--!Type(ClientAndServer)
--!SerializeField
local npcName:string = "TestNPC"
--!SerializeField
local outfitDuration:number = 1209600 -- 14 days

local RequestOutfitData = Event.new(npcName .. "RequestOutfitData")
local OutfitDataResponse = Event.new(npcName .. "OutfitDataResponse")
local GetDefaultOutfit = Event.new(npcName .. "GetDefaultOutfit")
local SetDefaultOutfit = Event.new(npcName .. "SetDefaultOutfit")
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

function equipOutfit(data)
    print(`CLIENT RECEIVED OUTFIT {data.Ids[2]}`)
    character = self.gameObject:GetComponent(Character)
    if character then 
        newOutfit = DeserializeOutfitSaveDataToOutfit(data)
        character:SetOutfit(newOutfit)
    end
end

function SendDefaultFit()
    outfit = self.gameObject:GetComponent(Character).outfits[1]
    serializedFit = SerializeOutfitToOutfitSaveData(outfit)
    saveData = {
        start = "2025-06-09 13:00:00",
        outfit = serializedFit
    }
    
    SetDefaultOutfit:FireServer({saveData})
end

function self:ClientAwake()
    
    RequestOutfitData:FireServer()
    OutfitDataResponse:Connect(equipOutfit)
    GetDefaultOutfit:Connect(SendDefaultFit)
end
-- [[ SERVER ]]
local currentOutfit = {}
local currentStartTime = ""
local activeOutfit = false
local OutfitData = {}
local updateTimer = nil

-- Timezone setup
local function getTimezoneOffset()
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    return os.difftime(now, utcNow)
end

local tzOffset = getTimezoneOffset()
local ET_OFFSET = 4 * 3600

local function parseETDateTime(str)
    local y, m, d, H, Min, S = str:match("(%d+)%-(%d+)%-(%d+)%s+(%d+):(%d+):(%d+)")
    if not y then return nil end
    local tbl = {
        year = tonumber(y), month = tonumber(m), day = tonumber(d),
        hour = tonumber(H), min = tonumber(Min), sec = tonumber(S)
    }
    local naiveEpoch = os.time(tbl)
    local utcEpoch = naiveEpoch - tzOffset
    return utcEpoch + ET_OFFSET
end

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    if h > 0 then
        return string.format("%02d:%02d:%02d", h, m, s)
    else
        return string.format("%02d:%02d", m, s)
    end
end

function GetDataFromStorage(callback)

    -- NPC Outfit --
    Storage.GetValue(npcName, function(data, err) 
        if err ~= StorageError.None then 
            error(`[OUTFIT STORAGE ERROR] {StorageError[err]}`)
            Timer.After(60*5, function() GetDataFromStorage(GetCurrentOutfit) end)
            return 
        end
        if data ~= nil then 
            if data ~= OutfitData and callback == nil then callback = GetCurrentOutfit end
            OutfitData = data
            print(`[OUTFIT DATA] {npcName} LOADED {#OutfitData} GRABS`)
        else
            print("[OUTFIT DATA] No data in storage, setting default.")
        end

        if callback then 
            callback()
        end

    end)

end

function GetCurrentOutfit()
    if #OutfitData == 0 then print(`{npcName} NO OUTFIT DATA LOADED`) return end

    local now = os.time()
    local maxCount = #OutfitData
    local nextWait = nil

    for i=1,#OutfitData do
        local datestring = OutfitData[i].start
        local startEpoch = parseETDateTime(datestring) 

        local endEpoch = startEpoch + outfitDuration
        if now < startEpoch then
            nextWait = startEpoch - now
            isActive = false
            break
        end
        if now >= startEpoch and now < endEpoch then
            currentOutfit = OutfitData[i].outfit
            nextWait = endEpoch - now
            activeOutfit = true
            print(`UPDATING OUTFIT {npcName} {tostring(activeOutfit)} {currentOutfit.Ids[2]}`)
            OutfitDataResponse:FireAllClients(currentOutfit)
            break
        end
    end

    if nextWait then
        if updateTimer then 
            updateTimer:Stop() 
            updateTimer = nil 
        end
        updateTimer = Timer.After(nextWait, function()
            GetCurrentOutfit()
        end)
    end
    
end

function self:ServerAwake()
    GetDataFromStorage(GetCurrentOutfit)
    RequestOutfitData:Connect(function(player) 
        print(`Received outfit data request active: {activeOutfit}`)
        if #OutfitData == 0 then
            print("Requesting default outfit data")
            GetDefaultOutfit:FireClient(player)
        end
        if activeOutfit then 
            print("Sending current outfit")
            OutfitDataResponse:FireClient(player, currentOutfit)
        end
    end)
    SetDefaultOutfit:Connect(function(player, outfitdata)
        print("setting new default data")
        Storage.SetValue(npcName, outfitdata)
    end)
end