--!Type(ClientAndServer)
--!SerializeField
local npcName:string = "TestNPC"
--!SerializeField
local emoteId:string = "emote-wave"
--!SerializeField
local outfitDuration:number = 1209600 -- 14 days

local RequestOutfitData = Event.new(npcName .. "RequestOutfitData")
local OutfitDataResponse = Event.new(npcName .. "OutfitDataResponse")
local GetDefaultOutfit = Event.new(npcName .. "GetDefaultOutfit")
local SetDefaultOutfit = Event.new(npcName .. "SetDefaultOutfit")
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


function equipOutfit(data)
    -- print(`CLIENT RECEIVED OUTFIT {data[2].Id}`)
    character = self.gameObject:GetComponent(Character)
    if character then 
        newOutfit = DeserializeOutfitSaveDataToOutfit(data)
        character:SetOutfit(newOutfit)
        character:PlayEmote(emoteId, true)
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

    character = self.gameObject:GetComponent(Character)
    if not character then
        print("No Character component found on " .. self.gameObject.name)
        return
    end
   character:PlayEmote(emoteId, true)
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
            print(`[OUTFIT DATA] {npcName} LOADED {#OutfitData} OUTFITS`)
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
    activeOutfit = false
    for i=1,#OutfitData do
        local datestring = OutfitData[i].start
        local startEpoch = parseETDateTime(datestring) 

        local endEpoch = startEpoch + outfitDuration
        if now < startEpoch then
            nextWait = startEpoch - now
            activeOutfit = false
            break
        end
        if now >= startEpoch and now < endEpoch then
            currentOutfit = OutfitData[i].outfit
            nextWait = endEpoch - now
            activeOutfit = true
            print(`UPDATING OUTFIT {npcName} {tostring(activeOutfit)} {currentOutfit[2].Id}`)
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

    Timer.Every(60*5, function()  GetDataFromStorage() end)

    RequestOutfitData:Connect(function(player) 
        -- print(`new client. current status: {activeOutfit}`)
        if #OutfitData == 0 then
            GetDefaultOutfit:FireClient(player)
        end
        if activeOutfit then 
            OutfitDataResponse:FireClient(player, currentOutfit)
        end
    end)
    SetDefaultOutfit:Connect(function(player, outfitdata)
        print(`{npcName} setting new default data in storage`)
        Storage.SetValue(npcName, outfitdata)
    end)
end