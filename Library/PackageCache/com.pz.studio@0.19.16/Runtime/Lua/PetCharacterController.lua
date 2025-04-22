--[[
    
    Copyright (c) 2024 Pocket Worlds

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely.
    
--]] 

--!Type(Module)

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type PetInfo = 
{
    player : Player,
    character: Character?,
    outfit: CharacterOutfit?,
    traits: {string},
    characterChangedEvent : EventConnection,
    petOutfitChangedEvent : EventConnection
}

-------------------------------------------------------------------------------
-- Properties
-------------------------------------------------------------------------------

--!SerializeField
local _characterPrefab : GameObject = nil --Prefab to use for the pet character
--!SerializeField
local _defaultPetTraitBehavior : GameObject = nil --Default pet behavior that is always created
--!SerializeField
local _petTraitBehaviors : {GameObject} = nil --List of pet trait behaviors that are spawned if pets contain matching traits. GameObject name must match trait name

PetCreatedEvent = Event.new("PetCreatedEvent")
PetOutfitChangedEvent = Event.new("PetOutfitChangedEvent")

-------------------------------------------------------------------------------
-- Private
-------------------------------------------------------------------------------

local _pets : {[Player] : PetInfo} = {}
local _traits : {[string] : GameObject} = {}

-- Return the pet info for the given player.  Creates a new pet entry if not 
-- already found.
local function GetPet(player : Player)
    local pet = _pets[player]
    if not pet then
        pet = {
            player = player,
            character = nil,
            outfit = nil
        }
        _pets[player] = pet
    end
    return pet;
end

local function RemovePet(player : Player)
    local pet = _pets[player]
    if pet then
        if pet.character then
            Object.Destroy(pet.character.gameObject)
        end
        _pets[player] = nil
    end
end

-- Create the trait behaviors as child GameObjects under the pet prefab GameObject
local function CreateTraitBehaviors(petObject : GameObject)
    --Create the default trait behavior
    if _defaultPetTraitBehavior then
        local defaultTraitObject = Object.Instantiate(_defaultPetTraitBehavior)
        defaultTraitObject.transform.parent = petObject.transform
    end

    --Create the trait behaviors from the pet's traits
    for trait, prefab in pairs(_traits) do
        if prefab ~= nil then
            local traitObject = Object.Instantiate(prefab)
            traitObject.transform.parent = petObject.transform
        end
    end
end

local function MatchTraitToPrefabBehaviors(pet : PetInfo)
    --match the prefab name to the trait name
    for i, traitName in pairs(pet.traits) do
        local trait = pet.traits[i]
        for i, prefab in pairs(_traitBehaviors) do
            if prefab.name == trait then
                _traits[trait] = prefab
            end
        end
    end
end

local function CreatePet(pet : PetInfo, outfitChanged : boolean)
    -- Create the pet
    local petPosition = pet.player.character.transform.position -- offset from player?
    local petRotation = pet.player.character.transform.rotation 
    local petObject = Object.Instantiate(_characterPrefab, petPosition, petRotation)
    petObject.name = pet.player.name .. "Pet"
    pet.character = petObject:GetComponent(Character) 
    if pet.player.pet ~= nil then
        pet.player.pet.character = pet.character
    end
    pet.character:SetOutfit(pet.outfit)
    --Future support: get traits from pet
    pet.traits = {}
    MatchTraitToPrefabBehaviors(pet)
    
    PetCreatedEvent:Fire(pet)
    
    if outfitChanged then
        PetOutfitChangedEvent:Fire(pet)
    end

    CreateTraitBehaviors(petObject)
end

local function DestroyPetObject(pet : PetInfo)
    Object.Destroy(pet.character.gameObject)
    pet.character = nil
end

local function UpdatePetCharacter(pet : PetInfo)
    local petIsValid = pet.player.character and pet.outfit
    if pet.character and petIsValid then
        --destroy and re-create the pet in case the skeleton changed
        DestroyPetObject(pet)
        CreatePet(pet, true)
    elseif pet.character then
        DestroyPetObject(pet)
        return
    elseif not petIsValid then
        return;
    else
        CreatePet(pet, false)
    end
end

local function HandlePlayerCharacterChanged(player : Player, character : Character)
    UpdatePetCharacter(GetPet(player))
end

local function HandlePetOutfitChanged(player : Player, outfit: CharacterOutfit?)
    local pet = GetPet(player)
    pet.outfit = outfit
    UpdatePetCharacter(pet)
end


local function HandlePlayerJoinedScene(scene : Scene, player : Player)
    local pet = GetPet(player)
    pet.characterChangedEvent = player.CharacterChanged:Connect(HandlePlayerCharacterChanged)
    pet.petOutfitChangedEvent = player.PetOutfitChanged:Connect(HandlePetOutfitChanged)
end

local function HandlePlayerLeftScene(scene : Scene, player : Player)
    local pet = GetPet(player)
    if pet.characterChangedEvent ~= nil then
        pet.characterChangedEvent:Disconnect()
    end
    if pet.petOutfitChangedEvent ~= nil then
        pet.petOutfitChangedEvent:Disconnect()
    end
    
    RemovePet(player)
end

function self:ClientAwake()
    scene.PlayerJoined:Connect(HandlePlayerJoinedScene)
    scene.PlayerLeft:Connect(HandlePlayerLeftScene)
end

-------------------------------------------------------------------------------
-- Public
-------------------------------------------------------------------------------

function GetPetFromCharacter(character : Character) : PetInfo
    if not character then
        return nil
    end
    
    for player, pet in pairs(_pets) do
        if pet.character == character then
            return pet
        end
    end
    return nil
end

function GetPetForPlayer(player : Player) : PetInfo
    return GetPet(player)
end