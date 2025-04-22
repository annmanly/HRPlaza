--!Type(Client)

---- Serialized Fields ----

--!SerializeField
--!Tooltip("If true, the player's own closet inventory will be included in this closet.")
local _includePlayerClosetInventory: boolean = true
--!SerializeField
--!Tooltip("Clothing Collections that will be included in the closet which provide additional clothing. Create one from the menu Assets->Create->Highrise->Clothing Collection")
local _includedClothingCollections: { ClothingCollection } = nil
--!SerializeField
local _useCustomStartingOutfit: boolean = false
--!SerializeField
--!Tooltip("Starting closet outfit to use when opening the closet.")
local _startingClosetOutfit: ClothingCollection = nil
--!SerializeField
--!Tooltip("Should default to the first tab, excluding the All tab, in the closet.")
local _defaultToFirstTab: boolean = false

--!Header("Title Settings")
--!SerializeField
local _closetTitle: string = "Dress Up"
--!SerializeField
local _saveButtonText: string = "Save"

---- Events ----
ClosetOutfitChangedEvent = Event.new("ClosetOutfitChangedEvent")

---- Functions ----

local function ConvertCollectionsToList(): { CharacterClothing }
	local list = {}
	for i, collection in ipairs(_includedClothingCollections) do
		for j, clothing in ipairs(collection.clothing) do
			table.insert(list, clothing)
		end
	end
	return list
end

local function GetDefaultOutfit(): CharacterOutfit
	if not _useCustomStartingOutfit then
		return client.localPlayer.character.outfits[1]
	else
		if not _startingClosetOutfit then
			print("<color=red>Error: No starting outfit collection set for : " .. self.gameObject.name .. "</color>")
			return client.localPlayer.character.outfits[1]
		end

		return CharacterOutfit.CreateInstance(_startingClosetOutfit.clothing)
	end
end

local function OnOutfitSaved(characterOutfit: CharacterOutfit)
	ClosetOutfitChangedEvent:Fire(characterOutfit)
end

function Open()
	UI:OpenCloset(
		client.localPlayer,
		_closetTitle,
		OnOutfitSaved,
		ConvertCollectionsToList(),
		_includePlayerClosetInventory,
		GetDefaultOutfit(),
		_saveButtonText,
		_defaultToFirstTab
	)
end

function self.ClientAwake()
	local tapHandler = self.gameObject:GetComponent(TapHandler)
	if tapHandler then
		tapHandler.Tapped:Connect(Open)
	end
end
