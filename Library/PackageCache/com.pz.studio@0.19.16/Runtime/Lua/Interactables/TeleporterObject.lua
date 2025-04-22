--!Type(ClientAndServer)

local petController = require("PetCharacterController")

---- Serialized Fields ----

--!SerializeField
local destination: Transform = nil

--!SerializeField
local teleportCharactersOnly: boolean = true

--!SerializeField
--!Tooltip("Whether to play a sound when using the teleporter, local player only")
local playSound: boolean = false

--!SerializeField
--!Tooltip("The audio shader to play when teleporting.")
local soundToPlay: AudioShader = nil

--!SerializeField
--!Tooltip("Whether to play a particle effect when using the teleporter.")
local playParticleEffect: boolean = true

--!SerializeField
--!Tooltip("The prefab containing the particle effect to play at the destination after teleporting")
local teleportParticles: GameObject = nil

--!SerializeField
--!Tooltip("Whether to move the camera to your character after teleporting.")
local resetCameraAfterTeleport: boolean = true

local teleportEvent = Event.new("TeleportEvent")

---- Internal Variables ----

local pets = {}

---- Client Functions ----

function self:ClientAwake()
	petController.PetCreatedEvent:Connect(function(pet)
		pets[pet.player] = pet.character
	end)

	scene.PlayerLeft:Connect(function(scene, player)
		pets[player] = nil
	end)
end

function self:ClientStart()
	local particleComponent = nil
	if playParticleEffect and teleportParticles ~= nil and destination ~= nil then
		local particleObject = Object.Instantiate(teleportParticles, destination.position)
		particleComponent = particleObject:GetComponent(ParticleSystem)
	end

	function RequestTeleport()
		if destination == nil then
			return
		end

		teleportEvent:FireServer(destination.position)
	end

	function PlayTeleportFX()
		if particleComponent ~= nil then
			particleComponent:Play()
		end
	end

	function PlayTeleportSound()
		if playSound and soundToPlay ~= nil then
			Audio:PlayShader(soundToPlay)
		end
	end

	function TeleportCharacterToDestination(character: Character)
		-- Exit if no Character component
		if character == nil then
			return
		end
		local player = character.player
		if client.localPlayer == player then
			RequestTeleport()
		end
	end

	function TeleportObjectToDestination(object: GameObject)
		if not object then
			return
		end
		object.transform.position = destination.position
		PlayTeleportFX()
		PlayTeleportSound()
	end

	function Teleport(character: Character, destination: Vector3)
		character:Teleport(destination)
		PlayTeleportFX()

		if pets[character.player] ~= nil then
			pets[character.player]:Teleport(destination)
		end

		if character.player == client.localPlayer then
			if resetCameraAfterTeleport then
				client.Reset:Fire()
			end
			PlayTeleportSound()
		end
	end

	teleportEvent:Connect(function(character, destination)
		Teleport(character, destination)
	end)
end

function self:OnTriggerEnter(other: Collider)
	if not destination then
		print(
			"<color=red>Error: Teleporter destination not set on "
				.. self.gameObject.name
				.. " Object. Drag an object from the Scene into the Destination field in the Inspector.</color>"
		)
		return
	end

	if teleportCharactersOnly then
		local playerCharacter = other.gameObject:GetComponent(Character)
		TeleportCharacterToDestination(playerCharacter)
	else
		TeleportObjectToDestination(other.gameObject)
	end
end

---- Server Functions ----

function self:ServerStart()
	teleportEvent:Connect(function(player, destination)
		player.character.transform.position = destination
		teleportEvent:FireAllClients(player.character, destination)
	end)
end
